function priest_big_buff_group1()
    priest_big_buff_by_group(1)
end

function priest_big_buff_group2()
    priest_big_buff_by_group(2)
end

function priest_big_buff_group3()
    priest_big_buff_by_group(3)
end

function priest_big_buff_group4()
    priest_big_buff_by_group(4)
end

function priest_big_buff_by_group(group)
    exact_target_by_name(group_list[group].tank)
    big_stamina()
    big_spirit()
    fear_ward()
    inner_fire()
end

function big_stamina()
    cast_buff("Spell_Holy_PrayerOfFortitude", "Prayer of Fortitude")
end

function big_spirit()
    cast_buff("Spell_Holy_PrayerofSpirit", "Prayer of Spirit")
end

function fear_ward()
    cast_buff("Spell_Holy_Excorcism", "Fear Ward")
end

function priest_small_buff_group1()
    priest_small_buff_by_group(1)
end

function priest_small_buff_group2()
    priest_small_buff_by_group(2)
end

function priest_small_buff_group3()
    priest_small_buff_by_group(3)
end

function priest_small_buff_group4()
    priest_small_buff_by_group(4)
end

function priest_small_buff_group5()
    priest_small_buff_by_group(5)
end

function priest_small_buff_by_group(group)
    exact_target_by_name(group_list[group].tank)
    priest_small_buff()
    exact_target_by_name(group_list[group].heal)
    priest_small_buff()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        priest_small_buff()
	end
    inner_fire()
end

function priest_small_buff()
    small_stamina()
    -- small_spirit()
end

function small_stamina()
    cast_buff("Spell_Holy_WordFortitude", "Power Word: Fortitude")
end

function small_spirit()
    cast_buff("Spell_Holy_DivineSpirit", "Divine Spirit")
end

function inner_fire()
    cast_buff_player("Spell_Holy_InnerFire", "Inner Fire")
end
