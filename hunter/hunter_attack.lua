hunter_auto_attack = false;

function hunter_attack_skull()
	if is_target_skull() then
        hunter_attack()
	else
		stop_hunter_auto_shot()
		stop_autoattack()
		target_skull()
	end
end

function hunter_attack_multi_skull()
	if is_target_skull() then
        hunter_attack()
	else
		stop_hunter_auto_shot()
		stop_autoattack()
		target_skull()
	end
end

function hunter_attack_cross()
	if is_target_cross() then
        hunter_attack()
	else
		stop_hunter_auto_shot()
		stop_autoattack()
		target_cross()
	end
end

function hunter_attack_multi_cross()
	if is_target_cross() then
        hunter_attack()
	else
		stop_hunter_auto_shot()
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

function hunter_attack_multi()
    if is_in_melee_range() then
		hunter_melee()
	else
		hunter_ranged()
		if not casting_or_channeling() then
			CastSpellByName("Multi-Shot")
		end
    end
	PetAttack("target")
end

function hunter_melee()
	stop_hunter_auto_shot()
	if not has_debuff("player", "Spell_Nature_ProtectionformNature") then
		cast_buff_player("Ability_Hunter_AspectOfTheMonkey", "Aspect of the Monkey")
	end
	CastSpellByName("Mongoose Bite")
	CastSpellByName("Raptor Strike")
	use_autoattack()
end

function hunter_ranged()
	stop_autoattack()
	if not has_debuff("player", "Spell_Nature_ProtectionformNature") then
		cast_buff_player("Spell_Nature_RavenForm", "Aspect of the Hawk")
	end
	cast_debuff("Ability_Hunter_SniperShot", "Hunter's Mark")
	if is_target_hp_under(0.3) then
		cast_buff_player("Ability_Hunter_RunningShot", "Rapid Fire")
	end
	local aimed, dur_aimed, en_aimed = GetActionCooldown(61)
	if aimed == 0 then
		CastSpellByName("Aimed Shot")
		CastSpellByName("Arcane Shot") -- Used for leveling only
	else
		use_hunter_auto_shot()
	end
end

function use_hunter_auto_shot()
	if hunter_auto_attack then return end
	hunter_auto_attack = true
	use_ranged_attack()
	CastSpellByName("Auto Shot")
end

function stop_hunter_auto_shot()
    stop_ranged_attack()
	hunter_auto_attack = false
end
