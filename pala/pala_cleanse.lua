function pala_cleanse_group1()
    pala_cleanse_by_group(1)
end

function pala_cleanse_group2()
    pala_cleanse_by_group(2)
end

function pala_cleanse_group3()
    pala_cleanse_by_group(3)
end

-- /script pala_cleanse_raid()
function pala_cleanse_raid()
    remove_debuff_type_raid("Poison", "Cleanse")
    remove_debuff_type_raid("Disease", "Cleanse")
end

function pala_cleanse_by_group(group)
    exact_target_by_name(group_list[group].tank)
    pala_cleanse()
    exact_target_by_name(group_list[group].heal)
    pala_cleanse()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        pala_cleanse()
	end
end

function pala_cleanse()
    remove_debuff_type_target("Poison", "Cleanse")
    remove_debuff_type_target("Disease", "Cleanse")
end
