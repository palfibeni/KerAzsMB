function mage_big_buff_group1()
    exact_target_by_name(group_list[1].tank)
    mage_big_int()
    mage_armor()
end

function mage_big_buff_group2()
    exact_target_by_name(group_list[2].tank)
    mage_big_int()
    mage_armor()
end

function mage_big_buff_group3()
    exact_target_by_name(group_list[3].tank)
    mage_big_int()
    mage_armor()
end

function mage_big_int()
    cast_buff("Spell_Holy_ArcaneIntellect", "Arcane Brilliance")
end
