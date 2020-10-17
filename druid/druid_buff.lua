function druid_big_buff_group1()
    exact_target_by_name(group_list[1].tank)
    druid_big_buff()
end

function druid_big_buff_group2()
    exact_target_by_name(group_list[2].tank)
    druid_big_buff()
end

function druid_big_buff_group3()
    exact_target_by_name(group_list[3].tank)
    druid_big_buff()
end

function druid_big_buff()
    cast_buff("Spell_Nature_Thorns", "Thorns")
    cast_buff("Spell_Nature_Regeneration", "Gift of the Wild")
end

-- /script druid_buff_group1()
function druid_buff_group1()
    druid_small_buff_by_group(1)
end

-- /script druid_buff_group2()
function druid_buff_group2()
    druid_small_buff_by_group(2)
end

-- /script druid_buff_group3()
function druid_buff_group3()
    druid_small_buff_by_group(3)
end

-- /script druid_buff_group4()
function druid_buff_group4()
    druid_small_buff_by_group(4)
end

-- /script druid_buff_group5()
function druid_buff_group5()
    druid_small_buff_by_group(5)
end

function druid_small_buff_by_group(group)
    exact_target_by_name(group_list[group].tank)
    druid_small_buff()
    cast_buff("Spell_Nature_Thorns", "Thorns")
    exact_target_by_name(group_list[group].heal)
    druid_small_buff()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        druid_small_buff()
	end
end

function druid_small_buff()
	cast_buff("Spell_Nature_Regeneration", "Mark of the Wild")
end
