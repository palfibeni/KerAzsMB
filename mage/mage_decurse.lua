mageDispelRange="Remove Curse"

mageDecurse={Curse=true}

function MageDispel(targetList,dispelByHp)
	dispelByHp=dispelByHp or false
	if SpellCastReady(mageDispelRange) then
		local target,debuffType=GetDispelTarget(targetList,mageDispelRange,mageDecurse,false)
		MageDispelTarget(target,debuffType)
	end
end

function MageDispelTarget(target,debuffType)
	if target then
		if debuffType=="Curse" then
			ClearTarget()
			CastSpellByName("Remove Curse")
		end
		SpellTargetUnit(target)
	end
end

-- DEPRECATED
-- /script mage_decurse_raid()
function mage_decurse_raid()
    remove_debuff_type_raid("Curse", "Remove Lesser Curse")
end
