function hunter_attack_skull()
	if is_target_skull() then
        hunter_aoe()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_skull()
	end
end

function hunter_attack_cross()
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
		stop_ranged_attack()
		cast("Raptor Strike")
		use_autoattack()
	else
		stop_autoattack()
		cast_buff_player("Spell_Nature_RavenForm", "Aspect of the Hawk")
		cast("Volley")
		cast("Multi-Shot")
		use_ranged_attack()
    end
end
