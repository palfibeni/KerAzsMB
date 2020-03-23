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
    exact_target_by_name(group_list[group].tank)
    pala_big_kings()
    exact_target_by_name(group_list[group].heal)
    pala_big_bless()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
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
    cast_buff("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

function pala_big_wisdom()
    cast_buff("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom")
end

function pala_big_kings()
    cast_buff("Spell_Magic_GreaterBlessingofKings", "Greater Blessing of Kings")
end

function pala_big_light()
    cast_buff("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

function pala_big_salva()
    cast_buff("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation")
end

function pala_big_sanc()
    cast_buff("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary")
end
