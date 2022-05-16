buffAbolishDisease = "Spell_Nature_NullifyDisease"
buffRenew = "Spell_Holy_Renew"
buffInnerFocus = "Spell_Frost_WindWalkOn"

priestHealRange = "Lesser Heal"
priestDispelRange = "Cure Disease"
aoeHealMinPlayers = 3

desperatePrayerActionSlot = 61
fadeActionSlot = 15
powerInfusionActionSlot = 16

priestDispelAll={Magic=true,Disease=true}
priestDispelMagic={Magic=true}
priestDispelDisease={Disease=true}

function priestRess()
	resurrectAll("Resurrection")
end

-- /script healOnRazoviousPriest()
function healOnRazoviousPriest()
	if UnitName("target") == "Deathknight Understudy" and UnitIsFriend("player","target") and isTargetHpUnder("target",0.98) then
	  CastSpellByName("Greater Heal(Rank 1")
	  return
	end
	exactTargetByName("Instructor Razuvious")
	TargetUnit("targettarget")
end

-- /script  priestHealOrDispel(azs.targetList.all, false)
function priestHealOrDispel(lTargetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	priestCooldown()
	local lTargetList = lTargetList or azs.targetList.all
	local healProfile = healProfile or getPriestDefaultHealingProfile()
	local dispelTypes = dispelTypes or priestDispelAll
	local dispelByHp = dispelByHp or false
	local dispelHpThreshold = dispelHpThreshold or 0.4
	if SpellCastReady(priestHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hpOrDebuffType,hotTarget,hotHp,action=GetHealOrDispelTarget(lTargetList,priestHealRange,buffRenew,priestDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			local aoeInfo = PriestAoeInfo()
			priestHealTarget(healProfile,target,hpOrDebuffType,hotTarget,hotHp,aoeInfo)
		else
			priestDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

-- /script priestHeal(azs.targetList.all, "instantOnly")
function priestHeal(lTargetList,healProfile)
	priestCooldown()
	local lTargetList = lTargetList or azs.targetList.all
	local healProfile = healProfile or getPriestDefaultHealingProfile()
	if SpellCastReady(priestHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp,hotTarget,hotHp=GetHealTarget(lTargetList,priestHealRange,buffRenew)
		local aoeInfo = PriestAoeInfo()
		priestHealTarget(healProfile,target,hp,hotTarget,hotHp,aoeInfo)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function PriestAoeInfo()
	ClearFriendlyTarget()
	CastSpellByName(priestDispelRange)
	local playerCount,playerHps=0,{}
	for target,info in pairs(azs.targetList.party) do
		local hp = UnitHealth(target)/UnitHealthMax(target)
		if IsValidSpellTarget(target) then
			playerCount = playerCount + 1
			playerHps[playerCount] = {uid = target, hpRatio = hp}
		end
	end
	SpellStopTargeting()
	table.sort(playerHps,function(a,b) return a.hpRatio<b.hpRatio end)
	return playerHps
end

function priestHealTarget(healProfile,target,hp,hotTarget,hotHp,aoeInfo)
	if priestHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(priestHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,lTargetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or hasBuff("player",buffInnerFocus)) and GetSpellCooldownByName(spellName)==0 then
				if (not healMode or healMode==1) and target and hp<hpThreshold and (not lTargetList or lTargetList[target]) then
					--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					azs.targetList.all[target].blacklist=nil
					currentHealTarget=target
					CastSpellByName(spellName)
					SpellTargetUnit(target)
					break
				elseif healMode==2 then
					if azs.targetSkull() or azs.targetCross() then
						if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
							--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
							currentHealTarget="targettarget"
							currentHealFinish=GetTime()+(GetSpellCastTimeByName(spellName) or 1.5)
							precastHpThreshold=hpThreshold
							CastSpellByName(spellName)
							SpellTargetUnit("targettarget")
						end
					end
					break
				elseif healMode==3 and hotTarget and hotHp<hpThreshold and (not lTargetList or lTargetList[hotTarget]) then
					--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					azs.targetList.all[target].blacklist=nil
					currentHealTarget=hotTarget
					CastSpellByName(spellName)
					SpellTargetUnit(hotTarget)
					break
				elseif healMode==4 and aoeInfo[aoeHealMinPlayers] and aoeInfo[aoeHealMinPlayers].hpRatio<hpThreshold then
					-- azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					currentHealTarget=nil
					CastSpellByName(spellName)
					break
				end
			end
		end
	end
end

-- /script priestDispel()
function priestDispel(lTargetList,dispelTypes,dispelByHp)
	local lTargetList = lTargetList or azs.targetList.all
	local dispelTypes=dispelTypes or priestDispelAll
	local dispelByHp=dispelByHp or false
	priestCooldown()
	if SpellCastReady(priestDispelRange) then
		local target,debuffType=GetDispelTarget(lTargetList,priestDispelRange,priestDispelAll,false)
		priestDispelTarget(target,debuffType)
	end
end

function priestDispelTarget(target,debuffType)
	if target then
		azs.targetList.all[target].blacklist=nil
		currentHealTarget=target
		currentHealFinish=nil
		if debuffType=="Magic" then
			ClearTarget()
			CastSpellByName("Dispel Magic")
		elseif not hasBuff(target,buffAbolishDisease) then
			CastSpellByName("Abolish Disease")
		else
			CastSpellByName("Cure Disease")
		end
		SpellTargetUnit(target)
	end
end

function priestCooldown()
	if not UnitAffectingCombat("player") then return end
	if IsActionReady(fadeActionSlot) and isPlayerHpUnder(0.5) then
			CastSpellByName("Fade")
	end
	if IsActionReady(desperatePrayerActionSlot) and isPlayerHpUnder(0.4) then
			CastSpellByName("Desperate Prayer")
	end
	if powerInfusion() then return end
	useRacials()
	useHealingTrinket()
end

function initPriestHealProfiles()
	priestHealProfiles={
		regular={
			{0.4 , 380, "Flash Heal",1,azs.targetList.tank},
			{0.5 , 0  , "Inner Focus",4},
			{0.5 , 0  , "Prayer of Healing",4,azs.targetList.party,true},
			{0.8 , 410, "Prayer of Healing(Rank 1)",4},
			{0.3 , 380, "Flash Heal"},
			{0.5 , 215, "Flash Heal(Rank 4)"},
			{0.6 , 259, "Heal(Rank 4)"},
			{0.7 , 216, "Heal(Rank 3)"},
			{0.8 , 174, "Heal(Rank 2)"},
			{0.9 , 94 , "Renew(Rank 3)",3},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
		renewSpam={
			{0.4 , 380, "Flash Heal",1,azs.targetList.tank},
			{0.5 , 0  , "Inner Focus",4},
			{0.5 , 0  , "Prayer of Healing",4,false,true},
			{0.8 , 410, "Prayer of Healing(Rank 1)",4},
			{0.4 , 259, "Heal(Rank 4)"},
			{0.6 , 184, "Renew(Rank 6)",3},
			{0.9 , 94 , "Renew(Rank 3)",3},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
		pureRenewSpam={
			{0.6 , 184, "Renew(Rank 6)",3},
			{0.9 , 94 , "Renew(Rank 3)",3},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
		instantOnly={
			{0.6 , 184, "Power Word: Shield",1,azs.targetList.tank},
			{0.3 , 184, "Power Word: Shield"},
			{0.6 , 184, "Renew(Rank 6)",3},
			{0.9 , 94 , "Renew(Rank 3)",3}
		},
		UNLIMITEDPOWER={
			{0.9 , 0  , "Prayer of Healing",4},
			{0.99, 0  , "Flash Heal"},
			{0.9 , 131, "Heal",2}
		},
    midLevel={
			{0.4 , 265, "Flash Heal",1,azs.targetList.tank},
      {0.3 , 265, "Flash Heal"},
      {0.5 , 155, "Flash Heal(Rank 2)"},
      {0.6 , 259, "Heal"},
      {0.7 , 174, "Heal(Rank 2)"},
      {0.8 , 131, "Heal(Rank 1)"},
      {0.9 , 96 , "Renew(Rank 3)",3}
    },
    lesser={
			{0.5 , 63, "Lesser Heal",1,azs.targetList.tank},
      {0.3 , 63, "Lesser Heal"},
      {0.7 , 38, "Lesser Heal(Rank 2)"},
      {0.8 , 94 , "Renew",3}
    }
	}
end

function getPriestDefaultHealingProfile()
	if UnitName("target") == "Shazzrah" or isPriestNefarianCall() then
		 return "instantOnly"
	  else
			return getDefaultHealingProfile()
		end
end

-- Nefarian related logic
function isPriestNefarianCall()
	return priestClassCallExpire and priestClassCallExpire >= GetTime()
end
