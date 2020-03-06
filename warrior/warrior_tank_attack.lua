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
	warrior_taunt()
	shieldSlam()
	revenge()
	heroicStrike()
end

function warrior_taunt()
	if UnitName("targettarget") == nil then return end
	if is_tank_by_name(UnitName("targettarget")) then return end
	if UnitIsEnemy("target","player") then
		cast("Taunt")
	end
end

function shieldSlam()
	if get_rage() > 20 then
		cast("Shield Slam")
	else
		cast("Bloodrage")
	end
end

function revenge()
	if get_rage() > 5 then
		cast("Revenge")
	end
end

function heroicStrike()
	if get_rage() > 15 then
		cast("Heroic Strike")
	end
end
