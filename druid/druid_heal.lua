function druid_heal_group1()
    druid_heal_by_group(1)
end

function druid_heal_group2()
    druid_heal_by_group(2)
end

function druid_heal_group3()
    druid_heal_by_group(3)
end

function druid_heal_by_group(group)
    TargetByName(group_list[group].tank)
    heal_under_percent(0.6, "Healing Touch")
    heal_under_percent(0.8, "Rejuvenation")
    TargetByName(group_list[group].heal)
    heal_under_percent(0.8, "Healing Touch")
    heal_under_percent(0.8, "Rejuvenation")
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        heal_under_percent(0.8, "Healing Touch")
        heal_under_percent(0.8, "Rejuvenation")
	end
end
