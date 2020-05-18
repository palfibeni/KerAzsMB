function hunter_aoe_skull()
	if is_target_skull() then
        hunter_aoe()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_skull()
	end
end

function hunter_aoe_cross()
	if is_target_cross() then
        hunter_aoe()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_cross()
	end
end

function hunter_aoe()
    if is_in_melee_range() then
		hunter_melee()
	else
		stop_autoattack()
		cast_buff_player("Spell_Nature_RavenForm", "Aspect of the Hawk")
		cast("Multi-Shot")
		use_ranged_attack()
    end
end
