heroicStrikeActionSlot = 13
berserkerRageActionSlot = 14
whirlwindActionSlot = 15
bloodThirstActionSlot = 17

function warriorFuryAttack()
	if charge() then return end
	warriorBerserkerStance()
	berserkerRage()
	bloodrage()
	battleShout()
	if isTargetHpUnder(0.25) then
		if useTrinkets() then return end
		useRacials()
		cast_buff_player("Ability_Racial_DeathPact", "Death Wish")
		cast_buff_player("Ability_Racial_CriticalStrike", "Recklessness")
		CastSpellByName("Execute")
	else
		if IsActionReady(bloodThirstActionSlot) and UnitMana("player") >= 30 then
			CastSpellByName("Bloodthirst")
		end
		whirlwind()
		if not IsCurrentAction(heroicStrikeActionSlot) and UnitMana("player") >= 55 then -- 45 with ony, 75 if no ony
			CastSpellByName("Heroic Strike")
		end
	end
	use_autoattack()
end

function charge()
	if azs.class.chargeEnabled and UnitExists("target") and not isInMeleeRange() then
		if UnitAffectingCombat("player") == nil then
			warriorBattleStance()
			CastSpellByName("Charge")
			return true
		elseif UnitMana("player") >= 10 then
			warriorBerserkerStance()
			CastSpellByName("Intercept")
			return true
		end
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
	if IsActionReady(whirlwindActionSlot) and UnitMana("player") >= 35 then -- 35 with ony, 55 without
		CastSpellByName("Whirlwind")
	end
end

function battleShout()
	if not player_hasBuff("Ability_Warrior_BattleShout") then
		CastSpellByName("Battle Shout")
	end
end
