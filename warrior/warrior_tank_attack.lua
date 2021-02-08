lastSunder = 0
lastBloodrage = 0
lastShieldSlam = 0
warriorTauntEnabled = false

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
		return
	end
	warrior_defense_stance()
	-- cast_buff_player("Ability_Warrior_DefensiveStance", "Defensive Stance")
	bloodrage()
	warrior_taunt()
	shieldSlam()
	warrior_demo_shout()
  sunderArmor()
	  CastSpellByName("Revenge")
	if UnitMana("player") >= 20 then
		CastSpellByName("Heroic Strike")
	end
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

function sunderArmor()
	if UnitMana("player") >= 12 then
		if get_debuff_count("target", "Ability_Warrior_Sunder") < 5 or lastSunder + 20 < GetTime() then
            CastSpellByName("Sunder Armor")
            lastSunder = GetTime()
        end
    end
end

function bloodrage()
  if lastBloodrage + 60 < GetTime() then
		CastSpellByName("Bloodrage")
    lastBloodrage = GetTime()
  end
end

function shieldSlam()
  if UnitMana("player") >= 20 and lastShieldSlam + 6 < GetTime() then
		CastSpellByName("Shield Slam")
    lastBloodrage = GetTime()
  end
end
