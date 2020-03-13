function mage_decurse_group1()
    mage_decurse_by_group(1)
end

function mage_decurse_group2()
    mage_decurse_by_group(2)
end

function mage_decurse_group3()
    mage_decurse_by_group(3)
end

function mage_decurse_by_group(group)
    exact_target_by_name(group_list[group].tank)
    mage_decurse()
    exact_target_by_name(group_list[group].heal)
    mage_decurse()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        mage_decurse()
	end
end

function mage_decurse()
    for x=1,16 do
	  local name,count,debuffType=UnitDebuff("target",x,1)
	  if debuffType=="Curse" then
          cast("Remove Lesser Curse")
      end
    end
end
