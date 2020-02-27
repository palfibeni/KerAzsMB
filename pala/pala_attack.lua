function pala_attack_cross()
    if is_target_cross() then
        pala_attack()
    else
        stop_autoattack()
        target_cross()
    end
end

function pala_attack_skull()
    if is_target_skull() then
        pala_attack()
    else
        stop_autoattack()
        target_skull()
    end
end

function pala_attack()
    cast("Hammer of Justice")
    cast_buff_player("Spell_Holy_HolySmite", "Seal of the crusader")
    if UnitCreatureType("target") == "Undead" or UnitCreatureType("target") == "Demon" then
		cast("Exorcism")
		cast("Holy Wrath")
	end
    use_autoattack()
end
