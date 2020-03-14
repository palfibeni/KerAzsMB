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
	PetAttack("target")
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
	cast("Aimed Shot")
	if not casting_or_channeling() then
   		cast("Arcane Shot")
	end
	use_ranged_attack()
end
