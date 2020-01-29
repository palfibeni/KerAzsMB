function pala_buff_group1()
    pala_small_buff_by_group(1)
end

function pala_buff_group2()
    pala_small_buff_by_group(2)
end

function pala_small_buff_by_group(group)
    TargetByName(group_list[group].tank)
    pala_small_bless()
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
