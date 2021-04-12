-- /script druid_depoison_raid()
function druid_depoison_raid()
    remove_debuff_type_raid("Poison", "Abolish Poison")
end

function druid_depoison_by_group(group)
    exact_target_by_name(group_list[group].tank)
    druid_depoison()
    exact_target_by_name(group_list[group].heal)
    druid_depoison()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        druid_depoison()
	end
end

function druid_depoison()
    remove_debuff_type_target("Poison", "Abolish Poison")
end
