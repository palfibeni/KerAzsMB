mageDispelRange="Remove Curse"

mageDecurse={Curse=true}

function MageDispel(lTargetList,dispelByHp)
	lTargetList = lTargetList or azs.targetList.all
	dispelByHp=dispelByHp or false
	if SpellCastReady(mageDispelRange) then
		local target,debuffType=GetDispelTarget(lTargetList,mageDispelRange,mageDecurse,false)
		MageDispelTarget(target,debuffType)
	end
end

function MageDispelTarget(target,debuffType)
	if target then
		lTargetList[target].blacklist=nil
		currentHealTarget=target
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
