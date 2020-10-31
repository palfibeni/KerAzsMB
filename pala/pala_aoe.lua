function pala_aoe_group1()
    pala_aoe_by_group(1)
end

function pala_aoe_group2()
    pala_aoe_by_group(2)
end

function pala_aoe_group3()
    pala_aoe_by_group(3)
end

function pala_aoe_group4()
    pala_aoe_by_group(4)
end

function pala_aoe_group5()
    pala_aoe_by_group(5)
end

function pala_aoe_by_group(group)
    CastSpellByName("Consecration")
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        pala_heal_dps()
	end
end
