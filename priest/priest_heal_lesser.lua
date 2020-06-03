-- /script priest_heal_group1()
function priest_heal_group1()
    priest_heal_lesser_by_group(1)
end

-- /script priest_heal_group2()
function priest_heal_group2()
    priest_heal_lesser_by_group(2)
end

-- /script priest_heal_group3()
function priest_heal_group3()
    priest_heal_lesser_by_group(3)
end

-- /script priest_heal_group4()
function priest_heal_group4()
    priest_heal_lesser_by_group(4)
end


function priest_heal_lesser_by_group(group)
    exact_target_by_name(group_list[group].tank)
    priest_lesser_heal_tank()
    priest_heal_self()
    exact_target_by_name(group_list[group].heal)
    priest_lesser_heal_dps()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        priest_lesser_heal_dps()
	end
    exact_target_by_name(group_list[group].tank)
    priest_shield_over_70()
end

function priest_lesser_heal_tank()
    if UnitIsDead("target") then return end
    heal_under_percent(0.7, "Lesser Heal")
    priest_dispel()
end

function priest_lesser_heal_dps()
    if casting_or_channeling() then return end
    if UnitIsDead("target") then return end
    priest_dispel()
    heal_under_percent(0.5, "Lesser Heal")
end
