blacklistedDeadPlayers = {}

function casting()
    return CastingBarFrame.casting
end

function channeling()
    return CastingBarFrame.channeling
end

-- Returns whether the player is casting or channeling a spell
function castingOrChanneling()
    return casting() or channeling()
end

function isTargetHpOver(percent)
	return not UnitIsDead("target") and UnitHealth("target") / UnitHealthMax("target") > percent
end

function isTargetHpUnder(percent)
	return not UnitIsDead("target") and UnitHealth("target") / UnitHealthMax("target") < percent
end

function isPlayerHpOver(percent)
	return UnitHealth("player") / UnitHealthMax("player") > percent
end

function isPlayerHpUnder(percent)
	return UnitHealth("player") / UnitHealthMax("player") < percent
end

function isTargetManaOver(percent)
	return not UnitIsDead("target") and UnitMana("target") / UnitHealthMana("target") > percent
end

function isTargetManaUnder(percent)
	return not UnitIsDead("target") and UnitMana("target") / UnitHealthMana("target") < percent
end

function isPlayerManaOver(percent)
	return UnitMana("player") / UnitHealthMana("player") > percent
end

function isPlayerManaUnder(percent)
	return UnitMana("player") / UnitHealthMana("player") < percent
end

function resurrectAll(spell, targetList)
  targetList = targetList or azs.targetList.all
  if UnitAffectingCombat("player") or castingOrChanneling() then return end
  if resurrectTargetList(spell, azs.targetList.party) then return end
  playerName = UnitName("player")
  azs.debug(azs.healers[playerName])
  if UnitInRaid("player") and azs.healers[playerName] then
    if resurrectTargetList(spell, azs.targetList.group[ azs.healers[playerName].group ]) then return end
  end
  resurrectTargetList(spell, targetList)
end

function resurrectTargetList(spell, targetList)
  targetList = targetList or azs.targetList.all
  for target,info in pairs(targetList) do
    if UnitIsDead(target) and not isBlacklistedDead(info.name) then
      SendChatMessage("Ressing " .. info.name .. "!", "YELL")
      blacklistedDeadPlayers[info.name] = GetTime()
      currentHealTarget = target
      CastSpellByName(spell)
  		SpellTargetUnit(target)
      return true
    end
  end
	SpellStopTargeting()
  return false
end

function isBlacklistedDead(name)
  if blacklistedDeadPlayers[name] == nil then return false end
  if blacklistedDeadPlayers[name] + 15 < GetTime() then
    blacklistedDeadPlayers[name] = nil
    return false
  else
    return true
  end
end
