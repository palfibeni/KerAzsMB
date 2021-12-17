precastInterruptWindow=1
healHpThreshold=0.9
healInterruptThreshold=0.95
stopCastingDelay=0.5

-- Delay a new spellcast after a spell is interrupted.
blacklistTime=10
retryBlacklist=true
-- true: Try to heal/dispel blacklisted players, when no non-blacklisted player needs healing/dispelling.
-- false: Blacklisted players won't get heals/dispels until blacklist time expires.

stopCastingDelayExpire=nil
currentHealTarget=nil
currentHealFinish=nil
precastHpThreshold=nil

function HandleHealingEvent()
	if event == "UI_ERROR_MESSAGE" and arg1 == "Target not in line of sight" then
		BlacklistTarget(currentHealTarget)
		currentHealTarget = nil
		precastHpThreshold = nil
	elseif event == "SPELLCAST_START" then
		currentHealFinish=GetTime() + arg2 / 1000
	elseif event == "SPELLCAST_DELAYED" then
		currentHealFinish= currentHealFinish + arg1 / 1000
	elseif event=="SPELLCAST_STOP" then
		currentHealTarget = nil
		currentHealFinish = nil
		precastHpThreshold = nil
	end
end

-- 7 PARAMETERS!!! YEP!!!!!!
function GetHealOrDispelTarget(lTargetList,healSpell,healIcon,dispelSpell,dispelTypes,dispelByHp,dispelHpThreshold)
	local dispelTarget,debuffType,action
	local healTarget,minHp,healHotTarget,minHotHp=GetHealTarget(lTargetList,healSpell,healIcon)
	if not healTarget or minHp>dispelHpThreshold then
		dispelTarget,debuffType=GetDispelTarget(lTargetList,dispelSpell,dispelTypes,dispelByHp)
		if dispelTarget then
			action="dispel"
		else
			action="heal"
		end
	else
		action="heal"
	end
	if action=="heal" then
		return healTarget,minHp,healHotTarget,minHotHp,action
	end
	return dispelTarget,debuffType,nil,nil,action
end

function GetHealTarget(lTargetList,healSpell,healIcon)
	ClearFriendlyTarget()
	CastSpellByName(healSpell)
	local currentTarget, minHp, minBiasedHp
	local currentHotTarget, minHotHp, minBiasedHotHp
	local blacklistFlag, minBlacklistTime = retryBlacklist,nil
	for target,info in pairs(lTargetList) do
		local hp=UnitHealth(target)/UnitHealthMax(target)
		if hp<healHpThreshold and IsValidSpellTarget(target) then
			if not info.blacklist or info.blacklist<=GetTime() then
				if blacklistFlag then
					blacklistFlag,currentTarget,currentHotTarget,minHp,minHotHp=false,nil,nil,nil,nil
				end
				local biasedHp=hp+info.bias
				if not minHp or biasedHp<minBiasedHp then
					minHp,minBiasedHp,currentTarget=hp,biasedHp,target
				end
				if healIcon and (not minHotHp or biasedHp<minBiasedHotHp) and not hasBuff(target,healIcon) then
					minHotHp,minBiasedHotHp,currentHotTarget=hp,biasedHp,target
				end
			elseif blacklistFlag then
				if not minBlacklistTime or minBlacklistTime > info.blacklist then
					minBlacklistTime = info.blacklist
					currentTarget = target
					minHp = hp
					if healIcon and not hasBuff(target,healIcon) then
						currentHotTarget=target
						minHotHp=hp
					end
				end
			end
		end
	end
	SpellStopTargeting()
	return currentTarget,minHp,currentHotTarget,minHotHp
end

function HpLower(target,hpThreshold)
	local hpCurrent=UnitHealth(target)/UnitHealthMax(target)
	return hpCurrent<hpThreshold
end

function GetSpellSlot(texture)
	for i=1,120 do
		if GetActionTexture(i)==texture then
			return i
		end
	end
	return nil
end

function IsCastingOrChanneling()
	return CastingBarFrame.casting or CastingBarFrame.channeling
end

function IsValidSpellTarget(target)
	return not UnitIsDeadOrGhost(target) and SpellCanTargetUnit(target)
end

function ClearFriendlyTarget()
	if UnitExists("target") and UnitIsFriend("player","target") then
		ClearTarget()
	end
end

function GetDispelTarget(targetList,dispelSpell,dispelTypes,dispelByHp)
	ClearFriendlyTarget()
	CastSpellByName(dispelSpell)
	local currentTarget,topPriority,debuffType,currentDebuffType
	for target,info in pairs(targetList) do
		if IsValidSpellTarget(target) then
			for i=1,16 do
				_,_,debuffType=UnitDebuff(target,i,1)
				if not debuffType or dispelTypes[debuffType] then
					break
				end
			end
			if debuffType then
				local priority=info.bias
				if dispelByHp then
					priority=priority+UnitHealth(target)/UnitHealthMax(target)
				end
				if not topPriority or priority<topPriority then
					topPriority=priority
					currentTarget=target
					currentDebuffType=debuffType
				end
			end
		end
	end
	SpellStopTargeting()
	return currentTarget,currentDebuffType
	-- TODO: Check the amount of debuffs on a player and maybe priorities by debuff type. Will be important for Chromaggus.
	-- TODO: Implement check for abolish effects (priest Abolish Disease, Druid abolish poison, Restorative Poison, etc...)
end

function HealInterrupt(target,finish,hpThreshold)
	if not stopCastingDelayExpire then
		if target=="targettarget" then -- Precast
			if not (azs.targetSkull() or azs.targetCross()) or
			not UnitExists(target) or not UnitIsFriend("player",target) or
			finish-precastInterruptWindow<GetTime() and not HpLower(target,hpThreshold) then
				SpellStopCasting()
				--azs.debug("Precast interrupt!")
				stopCastingDelayExpire=GetTime()+stopCastingDelay
			end
		elseif target then -- Overheal prevention
			if UnitExists(target) and not HpLower(target,healInterruptThreshold) then
				SpellStopCasting()
				--azs.debug("Overheal interrupt!")
				stopCastingDelayExpire=GetTime()+stopCastingDelay
			end
		end
	end
end

function BlacklistTarget(target)
	if target then
		local targetInfo=azs.targetList.all[target]
		if targetInfo then
			targetInfo.blacklist=GetTime()+blacklistTime
		end
	end
end

function IsCastingOrChanelling()
	return CastingBarFrame.casting or CastingBarFrame.channeling
end

function SpellCastReady(spell,delay)
	return not IsCastingOrChanelling() and GetSpellCooldownByName(spell)==0 and (not delay or delay<GetTime())
end

function UseHealTrinket()
	if UnitMana("player") / UnitManaMax("player") < 0.8 then
		useTrinkets()
	end
end

function initHealProfiles()
	initPalaHealProfiles()
	initPriestHealProfiles()
	initDruidHealProfiles()
	initshamanHealProfiles()
end

function getDefaultHealingProfile()
	if UnitLevel("player") < 21 then
		return "lesser"
	end
	if UnitLevel("player") < 40 then
		return "midLevel"
	end
		return "regular"
end
