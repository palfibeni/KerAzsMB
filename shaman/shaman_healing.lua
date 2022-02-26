shamanHealRange="Healing Wave"
shamanDispelRange="Cure Poison"
shamanNatureSwiftness="Spell_Nature_RavenForm"
--
shamanDispelAll={Disease=true,Poison=true}
shamanDispelDisease={Disease=true}
shamanDispelPoison={Poison=true}

function shamanRess()
	resurrectAll("Ancestral Spirit")
end

-- /script shamanHeal(azs.targetList.all, false)
-- /script shamanHealOrDispel(azs.targetList.all, false)
function shamanHealOrDispel(lTargetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	lTargetList = lTargetList or azs.targetList.all
	healProfile=healProfile or getDefaultHealingProfile()
	dispelTypes=dispelTypes or shamanDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	useHealingTrinket()
	if SpellCastReady(shamanHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hpOrDebuffType,_,_,action=GetHealOrDispelTarget(lTargetList,shamanHealRange,nil,shamanDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			shamanHealTarget(healProfile,target,hpOrDebuffType)
		else
			shamanDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function shamanHeal(lTargetList,healProfile)
	lTargetList = lTargetList or azs.targetList.all
	if IsActionReady(divineShieldActionSlot) and isPlayerHpUnder(0.5) then
			CastSpellByName("Divine Shield")
	end
	useHealingTrinket()
	healProfile=healProfile or getDefaultHealingProfile()
	if SpellCastReady(shamanHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp=GetHealTarget(lTargetList,shamanHealRange)
		shamanHealTarget(healProfile,target,hp)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function shamanHealTarget(healProfile,target,hp)
	if shamanHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(shamanHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,lTargetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or hasBuff("player",shamanNatureSwiftness)) and GetSpellCooldownByName(spellName)==0 then
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

function shamanDispel(lTargetList,dispelTypes,dispelByHp)
	lTargetList = lTargetList or azs.targetList.all
	dispelTypes=dispelTypes or shamanDispelAll
	dispelByHp=dispelByHp or false
	useHealingTrinket()
	if SpellCastReady(shamanDispelRange) then
		local target=GetDispelTarget(lTargetList,shamanDispelRange,dispelTypes,dispelByHp)
		shamanDispelTarget(target)
	end
end

function shamanDispelTarget(target,debuffType)
	if target then
		azs.targetList.all[target].blacklist=nil
		currentHealTarget=target
		currentHealFinish=nil
		if debuffType=="Poison" then
			ClearTarget()
			CastSpellByName("Cure Poison")
		else
			CastSpellByName("Cure Disease")
		end
		SpellTargetUnit(target)
	end
end

function initshamanHealProfiles()
	shamanHealProfiles={
		regular={
			{0.2 , 540 , "Nature's Swiftness",1,azs.targetList.tank},
			{0.2 , 589 , "Healing Wave",1,azs.targetList.tank, true},
			{0.4 , 190, "Healing Wave(Rank 5)"},
			{0.6 , 223, "Lesser Healing Wave(Rank 4)",1,azs.targetList.tank},
			{0.8 , 299, "Chain Heal(Rank 2)"},
			{0.8 , 247, "Chain Heal(Rank 1)"},
			{0.9 , 50 , "Lesser Healing Wave(Rank 2)"},
			{0.9 , 35 , "Healing Wave(Rank 1)", 2}
		},
		midLevel={
			{0.4 , 150, "Healing Wave(Rank 3)"},
			{0.5 , 150, "Healing Wave(Rank 3)",1,azs.targetList.tank},
			{0.8 , 35 , "Lesser Healing Wave"}
		},
		lesser={
			{0.3 , 35, "Healing Wave"},
			{0.4 , 35, "Healing Wave",1,azs.targetList.tank},
			{0.6 , 35 , "Healing Wave(Rank 1)"}
		},
	}
end
