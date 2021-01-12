function is_tank_by_name(name)
	for i,tank in pairs(tank_list) do
		if tank == name then return true end
	end
	return nil
end

-- 1 = Inspect, 9.9 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
function is_in_melee_range()
	return CheckInteractDistance("target",3)
end

-- 1 = Inspect, 9.9 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
function is_in_buff_range()
	return CheckInteractDistance("target",4)
end

function exact_target_by_name(name)
	TargetByName(name, true)
end

function is_target_skull()
	return (GetRaidTargetIndex("target") == 8)
end

function is_target_cross()
	return (GetRaidTargetIndex("target") == 7)
end

function target_skull()
	target_by_icon(8)
end

function target_cross()
	target_by_icon(7)
end

function target_by_icon(icon)
	for k,tank in pairs(tank_list) do
		exact_target_by_name(tank)
		TargetUnit("targettarget")
		if (GetRaidTargetIndex("target") == icon) then
			return
		end
	end
	tab_target_by_icon(icon)
end

function tab_target_by_icon(icon)
	for i=1,10 do
		TargetNearestEnemy()
		if (GetRaidTargetIndex("target") == icon) then
			return
		end
	end
	TargetUnit("player")
end