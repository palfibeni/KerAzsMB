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

-- /script pala_heal_mandokir()
function pala_heal_mandokir()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	PalaHealOrDispel(azs.targetList.all, false)
end

-- /script PalaHeal(azs.targetList.all, false)
-- /script PalaHealOrDispel(azs.targetList.all, false)
function PalaHealOrDispel(lTargetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	lTargetList = lTargetList or azs.targetList.all
	healProfile=healProfile or getDefaultHealingProfile()
	dispelTypes=dispelTypes or palaDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	if SpellCastReady(palaHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hpOrDebuffType,_,_,action=GetHealOrDispelTarget(lTargetList,palaHealRange,nil,palaDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			PalaHealTarget(healProfile,target,hpOrDebuffType)
		else
			PalaDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function PalaHeal(lTargetList,healProfile)
	lTargetList = lTargetList or azs.targetList.all
	if IsActionReady(divineShieldActionSlot) and is_player_hp_under(0.5) then
			CastSpellByName("Divine Shield")
	end
	UseHealTrinket()
	healProfile=healProfile or getDefaultHealingProfile()
	if SpellCastReady(palaHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp=GetHealTarget(lTargetList,palaHealRange)
		PalaHealTarget(healProfile,target,hp)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function PalaHealTarget(healProfile,target,hp)
	if palaHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(palaHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,lTargetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or has_buff("player",buffDivineFavor)) and GetSpellCooldownByName(spellName)==0 then
				if (not healMode or healMode==1) and target and hp<hpThreshold and (not lTargetList or lTargetList[target]) then
					--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					azs.targetList.all[target].blacklist = nil
					currentHealTarget = target
					CastSpellByName(spellName)
					SpellTargetUnit(target)
					break
				elseif healMode==2 then
					if is_target_skull() or is_target_skull() or target_skull() or target_cross() then
						if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
							--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
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

palaDispelAll={Magic=true,Disease=true,Poison=true}
palaDispelMagic={Magic=true}
palaDispelDisease={Disease=true}
palaDispelPoison={Poison=true}
palaDispelNoMagic={Disease=true,Poison=true}
palaDispelNoDisease={Magic=true,Poison=true}
palaDispelNoPoison={Magic=true,Disease=true}

function PalaDispel(lTargetList,dispelTypes,dispelByHp)
	lTargetList = lTargetList or azs.targetList.all
	dispelTypes=dispelTypes or palaDispelAll
	dispelByHp=dispelByHp or false
	if SpellCastReady(palaDispelRange) then
		local target=GetDispelTarget(lTargetList,palaDispelRange,dispelTypes,dispelByHp)
		PalaDispelTarget(target)
	end
end


function PalaDispelTarget(target)
	if target then
		azs.targetList.all[target].blacklist = nil
		currentHealTarget = target
		currentHealFinish = nil
		CastSpellByName("Cleanse")
		SpellTargetUnit(target)
	end
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
		midLevel={
			{0.4 , 150 , "Holy Light(Rank 3)"},
			{0.5 , 150, "Holy Light(Rank 3)",1,azs.targetList.tank,true},
			{0.8 , 35 , "Flash of Light"}
		},
		lesser={
			{0.3 , 35 , "Holy Light"},
			{0.4 , 35, "Holy Light",1,azs.targetList.tank,true},
			{0.6 , 35 , "Holy Light(Rank 1)"}
		},
	}
end
