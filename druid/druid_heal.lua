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
    exact_target_by_name(group_list[group].tank)
    druid_heal()
    exact_target_by_name(group_list[group].heal)
    druid_heal()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        druid_heal()
	end
end

function druid_heal()
    heal_under_percent(0.4, "Healing Touch")
    if is_target_hp_under(0.6) then
        cast_buff("Spell_Nature_ResistNature", "Regrowth")
    end
    if is_target_hp_under(0.8) then
        cast_buff("Spell_Nature_Rejuvenation", "Rejuvenation")
    end
end
