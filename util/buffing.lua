-- Casts given buff on target
function cast_buff(icon, spellName)
	if GetSpellCooldownByName(spellName) ~= 0 then return end
	if not is_in_buff_range() then return end
  if UnitIsDead("target") then return end
	if hasBuff("target", icon) then return end
	CastSpellByName(spellName)
end

-- Casts given buff on player
function cast_buff_player(icon, spellName)
	if GetSpellCooldownByName(spellName) ~= 0 then return end
	if player_hasBuff(icon) then return end
	CastSpellByName(spellName)
end

function player_hasBuff(icon)
	return hasBuff("player", icon)
end

-- Return whether given target has the given buff
function hasBuff(target, icon)
	return getIndexOfBuff(target, icon) ~= -1
end

-- Returns the index of given buff, if the target has it, otherwise -1
function getIndexOfBuff(target, icon)
	local i=1
	local buff = UnitBuff("player", i);
	while buff do
		if "Interface\\Icons\\" .. icon == buff then
			return i
		end
		i=i+1
	  buff = UnitBuff("player", i);
	end
	return -1
end

-- Buffs azs.targetList with spell
function buffTargetList(icon, spellName, ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
		castBuff(icon, spellName, target)
	end
end

function castBuff(icon, spell, target)
	if hasBuff(target, icon) then return end
	ClearFriendlyTarget()
	CastSpellByName(spell)
	if IsValidSpellTarget(target) then
		SpellTargetUnit(target)
		return
	end
	SpellStopTargeting()
end

function removeBuff(icon)
	index = getIndexOfBuff("player", icon)
	if index ~= -1 then
		CancelPlayerBuff(index)
	end
end

function buffPlayer(icon, spell, playerName)
  if GetSpellCooldownByName(spell) ~= 0 then return end
	playerName = playerName or UnitName("target")
	if not azs.targetList[playerName] then return end
	for target,info in pairs(azs.targetList[playerName]) do
		castBuff(icon, spell, target)
	end
end

-- Buffs azs.targetList with spell
function buffTargetListExceptList(icon, spellName, expectList, ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if not isTargetInList(target, expectList) then
      castBuff(icon, spellName, target)
    end
	end
end
