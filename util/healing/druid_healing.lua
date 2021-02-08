buffAbolishPoison="Spell_Nature_NullifyPoison_02"
buffRegrowth="Spell_Nature_ResistNature"
buffRejuvenation="Spell_Nature_Rejuvenation"
druidNatureSwiftness="Spell_Nature_RavenForm"

druidDispelAll={Posion=true,Curse=true}
druidDispelCurse={Curse=true}
druidDispelPosion={Posion=true}

druidHealRange="Healing Touch"
druidDispelRange="Remove Curse"


-- /script dudu_heal_mandokir()
function dudu_heal_mandokir()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	DruidHealOrDispel(targetList.all, false)
end

-- /script  DruidHealOrDispel(targetList.all, false)
function DruidHealOrDispel(targetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	healProfile=healProfile or "regular"
	dispelTypes=dispelTypes or druidDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	if SpellCastReady(druidHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hpOrDebuffType,hotTarget,hotHp,action=GetHealOrDispelTarget(targetList,druidHealRange,buffRegrowth,druidDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			DruidHealTarget(healProfile,target,hpOrDebuffType,hotTarget,hotHp)
		else
			DruidDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function DruidHeal(targetList,healProfile)
	UseHealTrinket()
	if (UnitMana("player") < 500) then
		innervate()
	end
	healProfile=healProfile or "regular"
	if SpellCastReady(druidHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp,hotTarget,hotHp=GetHealTarget(targetList,druidHealRange,buffRegrowth)
		DruidHealTarget(healProfile,target,hp,hotTarget,hotHp)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function DruidHealTarget(healProfile,target,hp,hotTarget,hotHp)
	if druidHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(druidHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,targetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or has_buff("player",druidNatureSwiftness)) and GetSpellCooldownByName(spellName)==0 then
				if (not healMode or healMode==1) and target and hp<hpThreshold and (not targetList or targetList[target]) then
					--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					currentHealTarget=target
					CastSpellByName(spellName)
					SpellTargetUnit(target)
					break
				elseif healMode==2 then
					if is_target_skull() or is_target_skull() or target_skull() or target_cross() then
						if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
							--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
							currentHealTarget="targettarget"
							currentHealFinish=GetTime()+(GetSpellCastTimeByName(spellName) or 1.5)
							precastHpThreshold=hpThreshold
							CastSpellByName(spellName)
							SpellTargetUnit("targettarget")
						end
					end
					break
				elseif healMode==3 and hotTarget and hotHp<hpThreshold and (not targetList or targetList[hotTarget]) then
					--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					currentHealTarget=nil
					CastSpellByName(spellName)
					SpellTargetUnit(hotTarget)
					break
				end
			end
		end
	end
end

function DruidDispel(targetList,dispelTypes,dispelByHp)
	dispelTypes=dispelTypes or druidDispelAll
	dispelByHp=dispelByHp or false
	if SpellCastReady(druidDispelRange) then
		local target,debuffType=GetDispelTarget(targetList,druidDispelRange,druidDispelAll,false)
		DruidDispelTarget(target,debuffType)
	end
end

function DruidDispelTarget(target,debuffType)
	if target then
		if debuffType=="Curse" then
			CastSpellByName("Remove Curse")
			SpellTargetUnit(target)
		elseif not has_buff(target,buffAbolishPoison) then
			CastSpellByName("Abolish Poison")
			SpellTargetUnit(target)
		end
	end
end

function initDruidHealProfiles()
	druidHealProfiles={
		regular={
			{0.4 , 350 , "Regrowth(Rank 4)",3},
			{0.4 , 248, "Swiftmend",1,targetList.tank},
			{0.5 , 166, "Healing Touch(Rank 4)"},
			{0.65 , 99, "Healing Touch(Rank 3)"},
			{0.75 , 49, "Healing Touch(Rank 2)"},
			{0.9 , 280 , "Regrowth(Rank 3)",3},
			{0.9 , 49, "Healing Touch(Rank 2)",2}
		},
	}
end
