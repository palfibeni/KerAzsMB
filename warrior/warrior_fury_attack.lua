function warrior_arms_skull()
	if is_target_skull() then
		warrior_arms_attack()
	else
        stop_autoattack()
		target_skull()
	end
end

function warrior_arms_cross()
	if is_target_cross() then
		warrior_arms_attack()
	else
        stop_autoattack()
		target_cross()
	end
end

function warrior_arms_attack()
	use_autoattack()
	cast("Berserker Rage")
	if UnitHealth("target") / UnitHealthMax("target") <= .25 then
		execute()
	else
		bloodthrist()
		whirlwind()
		fury_heroic_strike()
	end
end

function bloodthrist()
	if get_rage() > 30 then
		cast("Bloodthirst")
	else
		cast("Bloodrage")
	end
end

function whirlwind()
	if get_rage() > 40 then
		cast("Whirlwind")
	else
		cast("Bloodrage")
	end
end

function fury_heroic_strike()
	if get_rage() > 45 then
		cast("Heroic Strike")
	else
		cast("Bloodrage")
	end
end


function execute()
	if get_rage() > 20 then
		cast("Execute")
	else
		cast("Bloodrage")
	end
end
