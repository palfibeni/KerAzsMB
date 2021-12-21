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

function resurrectAll(spell, targetList)
  targetList = targetList or azs.targetList.all
  if UnitAffectingCombat("player") then return end
  for target,info in pairs(targetList) do
    if UnitIsDead(target) then
      SendChatMessage("Ressing " .. info.name .. "!", "YELL")
      CastSpellByName(spell)
  		SpellTargetUnit(target)
    end
  end
end
