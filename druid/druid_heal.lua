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
    druid_heal()
    TargetByName(group_list[group].heal)
    druid_heal()
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        druid_heal()
	end
end

function druid_heal()
    heal_under_percent(0.6, "Healing Touch")
    heal_under_percent(0.8, "Rejuvenation")
end
