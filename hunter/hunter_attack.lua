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
		hunter_melee()
	else
		hunter_ranged()
    end
	hunter_pet_attack()
end

function hunter_pet_attack()
	if not PetHasActionBar() == nil then
		PetAttack()
	end
end

function hunter_melee()
	stop_ranged_attack()
	cast("Mongoose Bite")
	cast("Raptor Strike")
	use_autoattack()
end

function hunter_ranged()
	stop_autoattack()
	cast_buff_player("Spell_Nature_RavenForm", "Aspect of the Hawk")
	cast_debuff("Ability_Hunter_SniperShot", "Hunter's Mark")
	cast("Arcane Shot")
	use_ranged_attack()
end
