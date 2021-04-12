warriorTauntEnabled = false

heroicStrikeActionSlot = 13
revengeActionSlot = 14
sunderArmorActionSlot = 15
bloodrageActionSlot = 16
shieldSlamActionSlot = 17

lastSunder = 0

function warrior_tank_attack_skull()
	if is_target_skull() then
		warrior_tank_attack()
	else
		target_skull()
	end
end

function warrior_tank_attack_cross()
	if is_target_cross() then
		warrior_tank_attack()
	else
		target_cross()
	end
end

function warrior_tank_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		stop_autoattack()
		return
	end
	warrior_defense_stance()
	bloodrage()
	warrior_taunt()
	if IsActionReady(shieldSlamActionSlot) and UnitMana("player") >= 20 then
		CastSpellByName("Shield Slam")
  end
	warrior_demo_shout()
	if IsActionReady(sunderArmorActionSlot) and UnitMana("player") >= 12 then
			if get_debuff_count("target", "Ability_Warrior_Sunder") < 5 or lastSunder + 20 < GetTime() then
					CastSpellByName("Sunder Armor")
					lastSunder = GetTime()
			end
	end
	if IsActionReady(revengeActionSlot) then
		CastSpellByName("Revenge")
  end
	if not IsCurrentAction(heroicStrikeActionSlot) and UnitMana("player") >= 30 then
		CastSpellByName("Heroic Strike")
	end
	use_autoattack()
end

function warrior_defense_stance()
	local icon, name, active, castable = GetShapeshiftFormInfo(2);
	if not active then
		CastSpellByName("Defensive Stance")
	end
end

function warrior_taunt()
	if not warriorTauntEnabled then return end
	if UnitName("targettarget") == nil then return end
	if UnitName("targettarget") == UnitName("player") then return end
	if is_tank_by_name(UnitName("targettarget")) then return end
	if UnitIsEnemy("target","player") then
		CastSpellByName("Taunt")
	end
end

function bloodrage()
  if IsActionReady(bloodrageActionSlot) then
		CastSpellByName("Bloodrage")
  end
end
