buffAbolishPoison="Spell_Nature_NullifyPoison_02"
buffRegrowth="Spell_Nature_ResistNature"
buffRejuvenation="Spell_Nature_Rejuvenation"

druidDispelAll={Posion=true,Curse=true}
priestDispelCurse={Curse=true}
priestDispelPosion={Posion=true}

function DruidHealOrDispel(targetList,hpThreshold,dispelTypes,dispelByHp,dispelHpThreshold)
	hpThreshold=hpThreshold or 0.9
	dispelTypes=dispelTypes or druidDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	local target,hpOrDebuffType,action=GetHealOrDispelTarget(targetList,"Healing Touch",hpThreshold,"Remove Curse",dispelTypes,dispelByHp,dispelHpThreshold)
	if action=="heal" then
		DruidHealTarget(target,hpOrDebuffType)
	else
		DruidDispelTarget(target,hpOrDebuffType)
	end
end

function DruidHeal(targetList,hpThreshold)
	hpThreshold=hpThreshold or 0.9
	local target,hp=GetHealTarget(targetList,"Heal",0.9)
	DruidHealTarget(target,hp)
end

function DruidHealTarget(target,hp)
	if target then
		local mana=UnitMana("player")
		if hp<0.3 and has_buff(target,buffRegrowth) and targetList.all[target].role=="tank" then
			CastSpellByName("Swiftmend")
		elseif hp<0.3 and mana>=350 and not has_buff(target,buffRegrowth) then
			CastSpellByName("Regrowth(Rank 4)")
		elseif hp<0.5 and mana>=243 then
			CastSpellByName("Healing Touch(Rank 4)")
		elseif hp<0.7 and mana>=280 and not has_buff(target,buffRegrowth) then
			CastSpellByName("Regrowth(Rank 3)")
		elseif hp<0.8 and mana>=105 and not has_buff(target,buffRejuvenation) then
			CastSpellByName("Rejuvenation(Rank 4)")
		else
			return
		end
		SpellTargetUnit(target)
	end
end

function DruidDispel(targetList,dispelTypes,dispelByHp)
	dispelTypes=dispelTypes or priestDispelAll
	dispelByHp=dispelByHp or false
	local target,debuffType=GetDispelTarget(targetList,"Dispel Magic",priestDispelAll,false)
	PriestDispelTarget(target,debuffType)
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
remove_debuff_type_raid("Poison", "Abolish Poison")
