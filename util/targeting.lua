function isTankByName(name)
	return isRoleByName(name, "tank")
end

function isMainTankByName(name)
	return isRoleByName(name, "mainTank")
end

function isRoleByName(name, role)
	if azs.nameList[role] == nil then return false end
	for i,toon in pairs(azs.nameList[role]) do
		if toon == name then return true end
	end
	return false
end

-- multiheal is not considered an other role
function getPlayerRoleByName(name)
	local playerName = UnitName("player")
	if isRoleByName(playerName, "multitank") then return "multitank" end
	if isRoleByName(playerName, "multimelee") then return "multimelee" end
	return "multicaster"
end

-- /script azs.debug(getMainByRole("multicaster"))
function getMainByRole(role)
	for id,toon in pairs(azs.nameList[role]) do
		azs.debug("is toon in targetList?: " .. toon)
		if azs.targetList[toon] ~= nil then
			for target,info in pairs(azs.targetList[toon]) do
				if isValidMain(target) then
					return toon
				end
			end
		end
	end
	return nil
end

function isValidMain(target)
	if not UnitIsConnected(target) then return false end
	if UnitIsGhost(target) and UnitIsGhost("player") then return true end
	return not UnitIsDeadOrGhost(target)
end

-- maintank -
-- offtank - maintank
-- mainmelee - maintank
-- offmelee - mainmelee
-- maincaster - maintank / offtank / mainmelee
-- offcaster - maincaster
-- /script azs.debug(getFollowTarget())
function getFollowTarget()
	local playerName = UnitName("player")
	local roleMain = getMainByRole(getPlayerRoleByName(playerName))
	if playerName ~= roleMain and roleMain ~= nil then return roleMain end
	local mainTank = getMainByRole("multitank")
	if mainTank then return mainTank end
	local mainMelee = getMainByRole("multimelee")
	if mainMelee then return mainMelee end
	local mainCaster = getMainByRole("multicaster")
	if mainCaster then return mainCaster end
end

-- 1 = Inspect, 9.9 yards
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

function exactTargetByName(name)
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
