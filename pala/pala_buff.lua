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
    exact_target_by_name(group_list[group].tank)
    small_bless_tank()
    exact_target_by_name(group_list[group].heal)
    pala_small_bless()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        pala_small_bless()
	end
end

function small_bless_tank()
    pala_small_kings()
end

function pala_small_bless()
    local class = UnitClass("target")
	if class=="Warrior" or class=="Rogue" then
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

function pala_small_salva()
    cast_buff("Spell_Holy_SealOfSalvation", "Blessing of Salvation")
end

function pala_small_sanc()
	cast_buff("Spell_Nature_LightningShield", "Blessing of Sanctuary")
end
