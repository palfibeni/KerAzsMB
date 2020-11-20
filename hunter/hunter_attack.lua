last_aimed = 0;
last_multi = 0;

function hunter_attack_skull()
	if is_target_skull() then
        hunter_attack()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_skull()
	end
end

function hunter_attack_multi_skull()
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

function hunter_attack_multi_cross()
	if is_target_cross() then
        hunter_attack()
	else
		stop_ranged_attack()
		stop_autoattack()
		target_cross()
	end
end

function hunter_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    if is_in_melee_range() then
		hunter_melee()
	else
		hunter_ranged()
    end
	PetAttack("target")
end

function hunter_attack_multi()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    if is_in_melee_range() then
		hunter_melee()
	else
		hunter_ranged()
		if not casting_or_channeling() and last_multi + 10 < GetTime() then
			CastSpellByName("Multi-Shot")
		end
    end
	PetAttack("target")
end

function hunter_melee()
	stop_ranged_attack()
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
	if last_aimed + 6 < GetTime() then
		CastSpellByName("Aimed Shot")
		CastSpellByName("Arcane Shot") -- Used for leveling only
	else
		use_ranged_attack()
	end
end
