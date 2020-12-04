palaDispelAll={Magic=true,Disease=true,Poison=true}
palaDispelMagic={Magic=true}
palaDispelDisease={Disease=true}
palaDispelPoison={Poison=true}
palaDispelNoMagic={Disease=true,Poison=true}
palaDispelNoDisease={Magic=true,Poison=true}
palaDispelNoPoison={Magic=true,Disease=true}

function PalaHealOrDispel(targetList,hpThreshold,dispelTypes,dispelByHp,dispelHpThreshold)
	hpThreshold=hpThreshold or 0.9
	dispelTypes=dispelTypes or palaDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	local target,hpOrDebuffType,action=GetHealOrDispelTarget(targetList,"Flash of Light",hpThreshold,"Cleanse",dispelTypes,dispelByHp,dispelHpThreshold)
	if action=="heal" then
		PalaHealTarget(target,hpOrDebuffType)
	else
		PalaDispelTarget(target,hpOrDebuffType)
	end
end

function PalaHeal(targetList,hpThreshold)
	hpThreshold=hpThreshold or 0.9
	local target,hp=GetHealTarget(targetList,"Flash of Light",hpThreshold)
	PalaHealTarget(target,hp)
end

function PalaHealTarget(target,hp)
	if target then
		local mana=UnitMana("player")
		if hp<0.4 and mana>=140 and targetList.all[target].role=="tank" then
			CastSpellByName("Divine Favor")
			CastSpellByName("Flash of Light")
		elseif hp<0.6 and mana>=115 then
			CastSpellByName("Flash of Light(Rank 5)")
		elseif hp<0.8 and mana>=70 then
			CastSpellByName("Flash of Light(Rank 3)")
		elseif mana>=35 then
			CastSpellByName("Flash of Light(Rank 1)")
		else
			return
		end
		SpellTargetUnit(target)
	end
end

function PalaDispel(targetList,dispelTypes,dispelByHp)
	dispelTypes=dispelTypes or palaDispelAll
	dispelByHp=dispelByHp or false
	local target=GetDispelTarget(targetList,"Cleanse",dispelTypes,dispelByHp)
	PalaDispelTarget(target)
end

function PalaDispelTarget(target)
	if target then
		CastSpellByName("Cleanse")
		SpellTargetUnit(target)
	end
end
