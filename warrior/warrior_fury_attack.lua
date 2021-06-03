chargeEnabled = false

heroicStrikeActionSlot = 13
berserkerRageActionSlot = 14
whirlwindActionSlot = 15
bloodThirstActionSlot = 17

function warrior_fury_skull()
	if azs.targetCross() then
		warrior_fury_attack()
	else
    stop_autoattack()
	end
end

function warrior_fury_cross()
	if azs.targetCross() then
		warrior_fury_attack()
	else
    stop_autoattack()
	end
end

function warrior_fury_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		stop_autoattack()
		return
	end
	if charge() then return end
	warriorBerserkerStance()
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
		if IsActionReady(bloodThirstActionSlot) and  UnitMana("player") >= 30 then
			CastSpellByName("Bloodthirst")
		end
		whirlwind()
		if not IsCurrentAction(heroicStrikeActionSlot) and UnitMana("player") >= 55 then
			CastSpellByName("Heroic Strike")
		end
	end
	use_autoattack()
end

function charge()
	if chargeEnabled and not is_in_melee_range() and UnitAffectingCombat("player") == nil then
		warriorBattleStance()
		CastSpellByName("Charge")
		return true
	end
	return false
end

function warriorBattleStance()
	local icon, name, active, castable = GetShapeshiftFormInfo(1);
	if not active then
		CastSpellByName("Battle Stance")
	end
end

function warriorBerserkerStance()
	local icon, name, active, castable = GetShapeshiftFormInfo(3);
	if not active then
		CastSpellByName("Berserker Stance")
	end
end

function berserkerRage()
  if IsActionReady(berserkerRageActionSlot) then
		CastSpellByName("Berserker Rage")
  end
end

function whirlwind()
	if IsActionReady(whirlwindActionSlot) and  UnitMana("player") >= 25 then
		CastSpellByName("Whirlwind")
	end
end

function battleShout()
	if not player_has_buff("Ability_Warrior_BattleShout") then
		CastSpellByName("Battle Shout")
	end
end
