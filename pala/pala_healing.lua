buffDivineFavor="Spell_Holy_Heal"
palaHealRange="Holy Light"
palaDispelRange="Purify"

palaDispelAll={Magic=true,Disease=true,Poison=true}
palaDispelMagic={Magic=true}
palaDispelDisease={Disease=true}
palaDispelPoison={Poison=true}
palaDispelNoMagic={Disease=true,Poison=true}
palaDispelNoDisease={Magic=true,Poison=true}
palaDispelNoPoison={Magic=true,Disease=true}

divineShieldActionSlot = 61

function palaRess()
	resurrectAll("Redemption")
end

-- /script healOnRazoviousPala()
function healOnRazoviousPala()
	if UnitName("target") == "Deathknight Understudy" and UnitIsFriend("player","target") and isTargetHpUnder(0.98) then
	  CastSpellByName("Flash of Light")
	  return
	end
	exactTargetByName("Instructor Razuvious")
	TargetUnit("targettarget")
end

-- /script palaHeal(azs.targetList.all, false)
-- /script palaHealOrDispel(azs.targetList.all, false)
function palaHealOrDispel(lTargetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	local lTargetList = lTargetList or azs.targetList.all
	local healProfile = healProfile or getPaladinDefaultHealingProfile()
	local dispelTypes = dispelTypes or palaDispelAll
	local dispelByHp = dispelByHp or false
	local dispelHpThreshold = dispelHpThreshold or 0.4
	palaCooldown()
	if SpellCastReady(palaHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire = nil
		local target,hpOrDebuffType,_,_,action=GetHealOrDispelTarget(lTargetList,palaHealRange,nil,palaDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			palaHealTarget(healProfile,target,hpOrDebuffType)
		else
			palaDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function palaHeal(lTargetList,healProfile)
	local lTargetList = lTargetList or azs.targetList.all
	local healProfile = healProfile or getPaladinDefaultHealingProfile()
	palaCooldown()
	if SpellCastReady(palaHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp=GetHealTarget(lTargetList,palaHealRange)
		palaHealTarget(healProfile,target,hp)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function palaHealTarget(healProfile,target,hp)
	if palaHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(palaHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,lTargetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or hasBuff("player",buffDivineFavor)) and GetSpellCooldownByName(spellName)==0 then
				if (not healMode or healMode==1) and target and hp<hpThreshold and (not lTargetList or lTargetList[target]) then
					--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					azs.targetList.all[target].blacklist = nil
					currentHealTarget = target
					CastSpellByName(spellName)
					SpellTargetUnit(target)
					break
				elseif healMode==2 then
					if azs.targetSkull() or azs.targetCross() then
						if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
							--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
							currentHealTarget = "targettarget"
							currentHealFinish = GetTime()+(GetSpellCastTimeByName(spellName) or 1.5)
							precastHpThreshold = hpThreshold
							CastSpellByName(spellName)
							SpellTargetUnit("targettarget")
						end
					end
					break
				end
			end
		end
	end
end

function palaDispel(lTargetList,dispelTypes,dispelByHp)
	local lTargetList = lTargetList or azs.targetList.all
	local dispelTypes = dispelTypes or palaDispelAll
	local dispelByHp = dispelByHp or false
	palaCooldown()
	if SpellCastReady(palaDispelRange) then
		local target=GetDispelTarget(lTargetList,palaDispelRange,dispelTypes,dispelByHp)
		palaDispelTarget(target)
	end
end


function palaDispelTarget(target)
	if target then
		azs.targetList.all[target].blacklist = nil
		currentHealTarget = target
		currentHealFinish = nil
		CastSpellByName("Cleanse")
		SpellTargetUnit(target)
	end
end

function palaCooldown()
	if not UnitAffectingCombat("player") then return end
	if IsActionReady(divineShieldActionSlot) and isPlayerHpUnder(0.5) then
 		 CastSpellByName("Divine Shield")
  end
	useHealingTrinket()
end

function initPalaHealProfiles()
	palaHealProfiles={
		regular={
			{0.4 , 720, "Divine Favor"},
			{0.4 , 660, "Holy Light"},
			{0.6 , 140, "Flash of Light"},
			{0.8 , 90 , "Flash of Light(Rank 4)"},
			{0.9 , 50 , "Flash of Light(Rank 2)"},
			{0.9 , 35 , "Holy Light(Rank 1)", 2}
		},
		hlTankOnly={
			{0.4 , 720, "Divine Favor",1,azs.targetList.tank},
			{0.4 , 660, "Holy Light",1,azs.targetList.tank},
			{0.6 , 140, "Flash of Light"},
			{0.8 , 70 , "Flash of Light(Rank 3)"},
			{0.9 , 35 , "Flash of Light(Rank 1)"},
			{0.9 , 35 , "Holy Light(Rank 1)", 2}
		},
		low={
			{0.4 , 720, "Divine Favor",1,azs.targetList.tank},
			{0.4 , 660, "Holy Light",1,azs.targetList.tank,true},
			{0.6 , 70 , "Flash of Light(Rank 5)"},
			{0.8 , 50 , "Flash of Light(Rank 3)"},
			{0.9 , 35 , "Flash of Light(Rank 1)"},
			{0.9 , 35 , "Holy Light(Rank 1)", 2}
		},
		UNLIMITEDPOWER={
			{0.5 , 0  , "Holy Light",1,azs.targetList.tank},
			{0.3 , 0  , "Holy Light"},
			{0.99, 0  , "Flash of Light"},
			{0.9 , 35 , "Holy Light(Rank 1)", 2}
		},
		flashOfLightSpam={
			{0.5, 140  , "Flash of Light"},
			{0.99, 140  , "Flash of Light",1,azs.targetList.tank}
		},
		midLevel={
			{0.4 , 150 , "Holy Light(Rank 3)"},
			{0.5 , 150, "Holy Light(Rank 3)",1,azs.targetList.tank},
			{0.8 , 35 , "Flash of Light"}
		},
		lesser={
			{0.4 , 35 , "Holy Light"},
			{0.6 , 35, "Holy Light",1,azs.targetList.tank},
			{0.8 , 35 , "Holy Light(Rank 1)"}
		},
		retriDangerZone={
			{0.1 , 0 , "Lay on Hands"},
			{0.2 , 35, "Holy Light"},
			{0.3 , 35 , "Blessing of Protection",1,azs.targetList.multimelee},
			{0.3 , 35 , "Blessing of Protection",1,azs.targetList.multicaster},
			{0.3 , 35 , "Blessing of Protection",1,azs.targetList.multiheal},
			{0.3 , 35 , "Blessing of Protection",1,azs.targetList.dps},
			{0.3 , 35 , "Blessing of Protection",1,azs.targetList.heal}
		},
	}
end

function getPaladinDefaultHealingProfile()
	if azs.class.talent == PALADIN_RETRI then
		 return "retriDangerZone"
  end
	return getDefaultHealingProfile()
end
