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
	cast_buff_player("Ability_Warrior_DefensiveStance", "Defensive Stance")
	CastSpellByName("Bloodrage")
	warrior_taunt()
	CastSpellByName("Shield Slam")
	warrior_demo_shout()
    sunderArmor()
    CastSpellByName("Revenge")
	CastSpellByName("Heroic Strike")
end

function warrior_taunt()
	if UnitName("targettarget") == nil then return end
	if UnitName("targettarget") == UnitName("player") then return end
	if is_tank_by_name(UnitName("targettarget")) then return end
	if UnitIsEnemy("target","player") then
		CastSpellByName("Taunt")
	end
end

function sunderArmor()
	if get_debuff_count("target", "Ability_Warrior_Sunder") < 5 or lastSunder + 20 < GetTime() then
        if get_rage() >= 12 then
            CastSpellByName("Sunder Armor")
            lastSunder = GetTime()
        end
    end
end
