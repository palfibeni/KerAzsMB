-- /script druid_decurse_raid()
function druid_decurse_raid()
    remove_debuff_type_raid("Curse", "Remove Curse")
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
