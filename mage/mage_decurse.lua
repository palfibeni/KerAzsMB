mageDispelRange="Remove Lesser Curse"

mageDecurse={Curse=true}

function MageDispel(lTargetList)
	mageDispel(lTargetList)
end

-- /script MageDispel(azs.targetList.all)
function mageDispel(lTargetList)
	lTargetList=lTargetList or azs.targetList.all
	if SpellCastReady(mageDispelRange,false) then
		local target,debufftype=GetDispelTarget(lTargetList,mageDispelRange,mageDecurse,false)
		if target then
			lTargetList[target].blacklist=nil
			currentHealTarget=target
			CastSpellByName("Remove Lesser Curse")
			SpellTargetUnit(target)
		end
	end
end

-- DEPRECATED
-- /script mage_decurse_raid()
function mage_decurse_raid()
    MageDispel()
end
