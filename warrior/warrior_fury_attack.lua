function warrior_fury_skull()
	if is_target_skull() then
		warrior_fury_attack()
	else
        stop_autoattack()
		target_skull()
	end
end

function warrior_fury_cross()
	if is_target_cross() then
		warrior_fury_attack()
	else
        stop_autoattack()
		target_cross()
	end
end

function warrior_fury_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	if not is_in_melee_range() and UnitAffectingCombat("player") == nil then
		cast_buff_player("Ability_Warrior_OffensiveStance", "Battle Stance")
		CastSpellByName("Charge")
		return
	end
	cast_buff_player("Ability_Racial_Avatar", "Berserker Stance")
	CastSpellByName("Berserker Rage")
	CastSpellByName("Bloodrage")
	if is_target_hp_under(0.3) then
		UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"))
		cast_buff_player("Ability_Racial_DeathPact", "Death Wish")
		cast_buff_player("Ability_Racial_CriticalStrike", "Recklessness")
		CastSpellByName("Execute")
	else
		CastSpellByName("Bloodthirst")
		CastSpellByName("Whirlwind")
		fury_heroic_strike()
	end
	use_autoattack()
end

function fury_heroic_strike()
	if UnitMana("player") > 55 then
		CastSpellByName("Heroic Strike")
	else
		CastSpellByName("Bloodrage")
	end
end
