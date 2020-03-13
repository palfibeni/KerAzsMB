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

function mage_armor()
    cast_buff_player("Spell_MageArmor", "Mage Armor")
end

function mage_buff_group1()
    mage_small_buff_by_group(1)
end

function mage_buff_group2()
    mage_small_buff_by_group(2)
end

function mage_buff_group3()
    mage_small_buff_by_group(3)
end

function mage_small_buff_by_group(group)
    exact_target_by_name(group_list[group].heal)
    mage_small_int()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        mage_small_int()
	end
    mage_armor()
end

function mage_small_int()
    local class = UnitClass("target")
	if class=="Warrior" or class=="Rogue" then return end
	cast_buff("Spell_Holy_MagicalSentry", "Arcane Intellect")
end

function mage_amplify()
    cast_buff("Spell_Holy_FlashHeal", "Amplify Magic")
end
