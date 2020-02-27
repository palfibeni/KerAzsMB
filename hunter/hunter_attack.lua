function hunter_attack_skull()
	if is_target_skull() then
        hunter_attack()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_skull()
	end
end

function hunter_attack_cross()
	if is_target_cross() then
        hunter_attack()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_cross()
	end
end

function hunter_attack()
    if is_in_melee_range() then
		stop_ranged_attack()
		cast("Raptor Strike")
		use_autoattack()
	else
		stop_autoattack()
		cast_buff_player("Spell_Nature_RavenForm", "Aspect of the Hawk")
		cast_debuff("Ability_Hunter_SniperShot", "Hunter's Mark")
		cast("Arcane Shot")
		use_ranged_attack()
    end
end

function stop_ranged_attack()
	PickupAction(65)
	PlaceAction(64)
end

function use_ranged_attack()
	if not IsCurrentAction(64) and not IsCurrentAction(65) then
		UseAction(64)
		PickupAction(64)
		PlaceAction(65)
	end
end
