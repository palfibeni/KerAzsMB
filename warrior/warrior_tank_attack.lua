function warrior_tank_attack_cross()
	if GetRaidTargetIndex("target") == 7 then
		warrior_tank_attack()
	else
		targetCross()
	end
end

function warrior_tank_attack()
	warrior_taunt()
	shieldSlam()
	revenge()
	heroicStrike()
end

function warrior_taunt()
	if UnitIsEnemy("target","player") and not is_tank_by_name(UnitName("targettarget")) then
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
