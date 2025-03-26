azs.progressRaidBossTree = {
  [ZG] = function () return azs.progressRaidBossTree[AQ20]() or isTargetBossInZG() end,
  [AQ20] = function () return azs.progressRaidBossTree[MC]() or isTargetBossInAQ20() end,
  [MC] = function () return azs.progressRaidBossTree[BWL]() or isTargetBossInMC() end,
  [BWL] = function () return azs.progressRaidBossTree[AQ40]() or isTargetBossInBWL() end,
  [AQ40] = function () return azs.progressRaidBossTree[NAXX]() or isTargetBossInAQ40() end,
  [NAXX] = function () return isTargetBossInNaxx() end,
}

function isTargetProgressRaidBoss()
  if UnitLevel("player") < 60 then return false end
  progressRaid = azs.progressRaid or NAXX
  return azs.progressRaidBossTree[progressRaid]()
end

function isTargetBossInMC()
  return isTargetInMobList(BOSSES_IN_MC)
end

function isTargetBossInBWL()
  return isTargetInMobList(BOSSES_IN_BWL)
end

function isTargetBossInZG()
  return isTargetInMobList(BOSSES_IN_ZG)
end

function isTargetBossInAQ20()
  return isTargetInMobList(BOSSES_IN_AQ20)
end

function isTargetBossInAQ40()
  return isTargetInMobList(BOSSES_IN_AQ40)
end

function isTargetBossInNaxx()
  return isTargetInMobList(BOSSES_IN_NAXX)
end

function hasMandokirGaze()
	return isInZG() and has_debuff("player", "Spell_Shadow_Charm")
end
