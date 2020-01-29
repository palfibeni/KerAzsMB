function priest_big_buff_group1()
    priest_big_buff_by_group(1)
end

function priest_big_buff_group2()
    priest_big_buff_by_group(2)
end

function priest_big_buff_by_group(group)
    TargetByName(group_list[group].tank)
    big_stamina()
    big_spirit()
    inner_fire()
end

function priest_small_buff_group1()
    priest_small_buff_by_group(1)
end

function priest_small_buff_group2()
    priest_small_buff_by_group(2)
end

function priest_small_buff_by_group(group)
    TargetByName(group_list[group].tank)
    small_stamina()
    TargetByName(group_list[group].heal)
    small_stamina()
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        small_stamina()
	end
    inner_fire()
end

function small_stamina()
    cast_buff("Spell_Holy_WordFortitude", "Power Word: Fortitude")
end

function big_stamina()
    cast_buff("Spell_Holy_PrayerOfFortitude", "Prayer of Fortitude")
end

function big_spirit()
    cast_buff("Spell_Holy_PrayerofSpirit", "Prayer of Spirit")
end

function inner_fire()
    cast_buff("Spell_Holy_InnerFire", "Inner Fire")
end
