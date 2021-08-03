warriorTauntEnabled = false

heroicStrikeActionSlot = 13
revengeActionSlot = 14
sunderArmorActionSlot = 15
bloodrageActionSlot = 16
shieldSlamActionSlot = 17

lastSunder = 0

function warrior_tank_attack_skull()
	if azs.targetSkull() then
		warriorTankAttack()
	end
end

function warrior_tank_attack_cross()
	if azs.targetCross() then
		warriorTankAttack()
	end
end

function warriorTankAttack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		stop_autoattack()
		return
	end
	warriorDefenseStance()
	bloodrage()
	warriorTaunt()
	if IsActionReady(shieldSlamActionSlot) and UnitMana("player") >= 20 then
		CastSpellByName("Shield Slam")
  end
	warriorDemoShout()
	sunderArmor()
	if IsActionReady(revengeActionSlot) then
		CastSpellByName("Revenge")
  end
	if not IsCurrentAction(heroicStrikeActionSlot) and UnitMana("player") >= 30 then
		CastSpellByName("Heroic Strike")
	end
	use_autoattack()
end

function warriorDefenseStance()
	local icon, name, active, castable = GetShapeshiftFormInfo(2);
	if not active then
		CastSpellByName("Defensive Stance")
	end
end

function warriorTaunt()
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

function sunderArmor()
	if IsActionReady(sunderArmorActionSlot) and UnitMana("player") >= 12 then
			if get_debuff_count("target", "Ability_Warrior_Sunder") < 5 or lastSunder + 20 < GetTime() then
					CastSpellByName("Sunder Armor")
					lastSunder = GetTime()
			end
	end
end
