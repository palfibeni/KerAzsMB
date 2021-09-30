function is_tank_by_name(name)
	for i,tank in pairs(azs.nameList.tank) do
		if tank == name then return true end
	end
	return nil
end

-- 1 = Inspect, 9.9 yards
-- 2 = Trade, 11.11 yards
-- 3 = Duel, 9.9 yards
-- 4 = Follow, 28 yards
function is_in_trade_range()
	return CheckInteractDistance("target",2)
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

-- /script azs.markSkull()
azs.markSkull = function()
	return azs.markIcon(8)
end

azs.markIcon = function(icon)
	if not IsPartyLeader() and not IsRaidLeader() and not IsRaidOfficer() then return end
	if azs.checkRaidTargetIcon("target", icon) then return end
	SetRaidTarget("target", icon)
end

azs.targetSkull = function()
	return azs.targetByIcon(8)
end

azs.targetCross = function()
	return azs.targetByIcon(7)
end

azs.targetByIcon = function(icon)
	if azs.checkRaidTargetIcon("target", icon) then return true end
	for k,tank in pairs(azs.nameList.tank) do
		AssistByName(tank)
		if azs.checkRaidTargetIcon("target", icon) then
			return true
		end
	end
	return azs.tabTargetByIcon(icon)
end

azs.tabTargetByIcon = function(icon)
	for i=1,10 do
		TargetNearestEnemy()
		if azs.checkRaidTargetIcon("target", icon) then
			return true
		end
	end
	return false
end

azs.checkRaidTargetIcon = function(target,icon)
	return UnitExists(target) and not UnitIsDead(target) and GetRaidTargetIndex(target) == icon
end
