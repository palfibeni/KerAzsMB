function druid_decurse_group1()
    druid_decurse_by_group(1)
end

function druid_decurse_group2()
    druid_decurse_by_group(2)
end

function druid_decurse_group3()
    druid_decurse_by_group(3)
end

function druid_decurse_by_group(group)
    exact_target_by_name(group_list[group].tank)
    druid_decurse()
    exact_target_by_name(group_list[group].heal)
    druid_decurse()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        druid_decurse()
	end
end

function druid_decurse()
    remove_debuff_type_target("Curse", "Remove Curse")
end
