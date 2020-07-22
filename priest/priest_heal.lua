function priest_heal_group1()
    priest_heal_by_group(1)
end

function priest_heal_group2()
    priest_heal_by_group(2)
end

function priest_heal_group3()
    priest_heal_by_group(3)
end

function priest_heal_group4()
    priest_heal_by_group(4)
end

function priest_heal_by_group(group)
    exact_target_by_name(group_list[group].tank)
    priest_heal_tank()
    priest_heal_self()
    exact_target_by_name(group_list[group].heal)
    priest_heal_dps()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        priest_heal_dps()
	end
    exact_target_by_name(group_list[group].tank)
    priest_shield_over_70()
    fear_ward()
end

function priest_heal_tank()
    if UnitIsDead("target") then return end
    heal_under_percent(0.5, "Flash Heal")
    heal_under_percent(0.8, "Heal")
    priest_dispel()
end

function priest_heal_self()
    if casting_or_channeling() then return end
    local desp, dur_desp, en_desp = GetActionCooldown(61)
    if desp == 0 and is_player_hp_under(0.25) then
        cast("Desperate Prayer")
        cast("Fade")
    end
end

function priest_dispel()
    if casting_or_channeling() then return end
    remove_debuff_type_target("Magic", "Dispel Magic")
end

function priest_heal_dps()
    if casting_or_channeling() then return end
    if UnitIsDead("target") then return end
    priest_dispel()
    heal_under_percent(0.5, "Flash Heal")
end

function priest_shield_over_70()
    if not is_tank_by_name(UnitName("targettarget")) then return end
    if casting_or_channeling() then return end
    if is_target_hp_over(0,7) then
        if (UnitMana("player") >= (UnitLevel("player") * 40)) then
            cast("Power Word: Shield")
        end
    end
end

function fear_ward()
    if not is_tank_by_name(UnitName("targettarget")) then return end
    if casting_or_channeling() then return end
    cast_buff("Spell_Holy_Excorcism", "Fear Ward")
end

function priest_heal_horde_group1()
    priest_heal_horde_by_group(1)
end

function priest_heal_horde_by_group(group)
    exact_target_by_name(horde_group_list[group].tank)
    priest_heal_tank()
    priest_heal_self()
    exact_target_by_name(horde_group_list[group].heal)
    priest_heal_dps()
    for i,dps in pairs(horde_group_list[group].dps_list) do
		exact_target_by_name(dps)
        priest_heal_dps()
	end
    exact_target_by_name(horde_group_list[group].tank)
    priest_shield_over_70()
end
