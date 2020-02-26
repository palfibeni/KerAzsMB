function pala_big_buff_group1()
    pala_big_buff_by_group(1)
end

function pala_big_buff_group2()
    pala_big_buff_by_group(2)
end

function pala_big_buff_group3()
    pala_big_buff_by_group(3)
end

function pala_big_buff_by_group(group)
    TargetByName(group_list[group].tank)
    pala_big_kings()
    TargetByName(group_list[group].heal)
    pala_big_bless()
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        pala_big_bless()
	end
end

function pala_big_bless()
    local class = UnitClass("target")
	if class=="Warrior" or class=="Rogue" or class=="Hunter" then
		pala_big_might()
	else
		pala_big_wisdom()
	end
end

function pala_big_might()
    cast_buff("	Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

function pala_big_wisdom()
    cast_buff("Spell_Holy_GreaterBlessingOfWisdom", "Greater Blessing of Wisdom")
end

function pala_big_kings()
    cast_buff("Spell_Magic_GreaterBlessingOfKings", "Greater Blessing of Kings")
end

function pala_big_light()
    cast_buff("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

function pala_buff_group1()
    pala_small_buff_by_group(1)
end

function pala_buff_group2()
    pala_small_buff_by_group(2)
end

function pala_buff_group3()
    pala_small_buff_by_group(3)
end

function pala_small_buff_by_group(group)
    TargetByName(group_list[group].tank)
    pala_small_kings()
    TargetByName(group_list[group].heal)
    pala_small_bless()
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        pala_small_bless()
	end
end

function pala_small_bless()
    local class = UnitClass("target")
	if class=="Warrior" or class=="Rogue" or class=="Hunter" then
		pala_small_might()
	else
		pala_small_wisdom()
	end
end

function pala_small_might()
    cast_buff("Spell_Holy_FistOfJustice", "Blessing of Might")
end

function pala_small_wisdom()
    cast_buff("Spell_Holy_SealOfWisdom", "Blessing of Wisdom")
end

function pala_small_kings()
    cast_buff("Spell_Magic_MageArmor", "Blessing of Kings")
end

function pala_small_light()
    cast_buff("Spell_Holy_PrayerOfHealing02", "Blessing of Light")
end
