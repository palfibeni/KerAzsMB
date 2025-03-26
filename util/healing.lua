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

function useRacials()
  trollBerserking()
  orcBerserking()
end

function trollBerserking()
  if UnitRace("player") == "Troll" then
    cast_buff_player("Racial_Troll_Berserk", "Berserking")
  end
end

function orcBerserking()
  if UnitRace("player") == "Orc" then
    cast_buff_player("Racial_Orc_BerserkerStrength", "Blood Fury")
  end
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
	return not UnitIsDead("target") and UnitMana("target") / UnitManaMax("target") > percent
end

function isTargetManaUnder(percent)
	return not UnitIsDead("target") and UnitMana("target") / UnitManaMax("target") < percent
end

function isPlayerRelativeManaAbove(amount)
  return UnitMana("player") >= (UnitLevel("player") * amount)
end

function isPlayerRelativeManaBelow(amount)
  return UnitMana("player") <= (UnitLevel("player") * amount)
end

function isPlayerManaOver(percent)
	return UnitMana("player") / UnitManaMax("player") > percent
end

-- /script azs.debug(isPlayerManaUnder(50))
-- /script azs.debug(UnitMana("player"))
-- /script azs.debug(UnitManaMax("player"))
function isPlayerManaUnder(percent)
	return UnitMana("player") / UnitManaMax("player") < percent
end

function resurrectAll(spell, targetList)
  local targetList = targetList or azs.targetList.all
  if UnitAffectingCombat("player") or castingOrChanneling() then return end
  if resurrectTargetList(spell, azs.targetList.party) then return end
  local playerName = UnitName("player")
  if UnitInRaid("player") and azs.healers[playerName] then
    if resurrectTargetList(spell, azs.targetList.group[ azs.healers[playerName].group]) then return end
  end
  resurrectTargetList(spell, targetList)
end

function resurrectTargetList(spell, targetList)
  local targetList = targetList or azs.targetList.all
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
