buffAbolishDisease="Spell_Nature_NullifyDisease"
buffRenew="Spell_Holy_Renew"

priestDispelAll={Magic=true,Disease=true}
priestDispelMagic={Magic=true}
priestDispelDisease={Disease=true}

function PriestHealOrDispel(targetList,hpThreshold,dispelTypes,dispelByHp,dispelHpThreshold)
	hpThreshold=hpThreshold or 0.9
	dispelTypes=dispelTypes or priestDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	local target,hpOrDebuffType,action=GetHealOrDispelTarget(targetList,"Heal",hpThreshold,"Dispel Magic",dispelTypes,dispelByHp,dispelHpThreshold)
	if action=="heal" then
		PriestHealTarget(target,hpOrDebuffType)
	else
		PriestDispelTarget(target,hpOrDebuffType)
	end
end

function PriestHeal(targetList,hpThreshold)
	hpThreshold=hpThreshold or 0.9
	local target,hp=GetHealTarget(targetList,"Heal",0.9)
	PriestHealTarget(target,hp)
	-- TODO: Aoe heal support
end

function PriestHealTarget(target,hp)
	if target then
		local mana=UnitMana("player")
		if hp<0.3 and mana>=380 then
			CastSpellByName("Flash Heal")
		elseif hp<0.5 and mana>=215 then
			CastSpellByName("Flash Heal(Rank 4)")
		elseif hp<0.6 and mana>=259 then
			CastSpellByName("Heal(Rank 4)")
		elseif hp<0.7 and mana>=216 then
			CastSpellByName("Heal(Rank 3)")
		elseif hp<0.8 and mana>=174 then
			CastSpellByName("Heal(Rank 2)")
		elseif not has_buff(target,buffRenew) and mana>=94 then
			CastSpellByName("Renew(Rank 3)")
		elseif mana>=131 then
			CastSpellByName("Heal(Rank 1)")
		else
			return
		end
		SpellTargetUnit(target)
	end
end

function PriestDispel(targetList,dispelTypes,dispelByHp)
	dispelTypes=dispelTypes or priestDispelAll
	dispelByHp=dispelByHp or false
	local target,debuffType=GetDispelTarget(targetList,"Dispel Magic",priestDispelAll,false)
	PriestDispelTarget(target,debuffType)
end

function PriestDispelTarget(target,debuffType)
	if target then
		if debuffType=="Magic" then
			CastSpellByName("Dispel Magic")
			SpellTargetUnit(target)
		elseif not has_buff(target,buffAbolishDisease) then
			CastSpellByName("Abolish Disease")
			SpellTargetUnit(target)
		end
	end
end
