lastBerserkerRage = 0
lastBattleShout = 0
lastWhirlwind = 0
lastBloodThirst = 0

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
	if charge() then return end
	warrior_berserker_stance()
	berserkerRage()
	bloodrage()
	battleShout()
	if is_target_hp_under(0.3) then
		UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"))
		UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"))
		cast_buff_player("Ability_Racial_DeathPact", "Death Wish")
		cast_buff_player("Ability_Racial_CriticalStrike", "Recklessness")
		CastSpellByName("Execute")
	else
		bloodthirst()
		whirlwind()
		fury_heroic_strike()
	end
	use_autoattack()
end

function charge()
	if not is_in_melee_range() and UnitAffectingCombat("player") == nil then
		warrior_battle_stance()
		CastSpellByName("Charge")
		return true
	end
	return false
end

function warrior_battle_stance()
	local icon, name, active, castable = GetShapeshiftFormInfo(1);
	if not active then
		CastSpellByName("Battle Stance")
	end
end

function warrior_berserker_stance()
	local icon, name, active, castable = GetShapeshiftFormInfo(3);
	if not active then
		CastSpellByName("Berserker Stance")
	end
end

function berserkerRage()
  if lastBerserkerRage + 30 < GetTime() then
		CastSpellByName("Berserker Rage")
    lastBerserkerRage = GetTime()
  end
end

function fury_heroic_strike()
	if UnitMana("player") >= 55 and lastBloodThirst + 6 > GetTime() and lastWhirlwind + 10 > GetTime() then
		CastSpellByName("Heroic Strike")
	end
end

function bloodthirst()
	if UnitMana("player") >= 30 and lastBloodThirst + 6 < GetTime() then
		CastSpellByName("Bloodthirst")
		lastBloodThirst = GetTime()
	end
end

function whirlwind()
	if UnitMana("player") >= 25 and lastWhirlwind + 10 < GetTime() then
		CastSpellByName("Whirlwind")
		lastWhirlwind = GetTime()
	end
end

function battleShout()
	if UnitMana("player") >= 10 and lastBattleShout + 120 < GetTime() and not player_has_buff("Ability_Warrior_BattleShout") then
		CastSpellByName("Battle Shout")
    lastBerserkerRage = GetTime()
	end
end
