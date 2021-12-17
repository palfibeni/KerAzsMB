function initShamanData()
  if isHealShaman() then
    initHealShamanData()
  else
    initElemShamanData()
  end
end

function isHealShaman()
  local _, _, pointsSpentInResto = GetTalentTabInfo(3)
  return pointsSpentInResto > 0
end

function initHealShamanData()
  azs.debug("I am heal Shaman")
  local playerName = UnitName("player")
  azs.class.dps = function() shamanAttack() end
  azs.class.heal = function() shamanHeal() end
  azs.class.buff = function()
    shamanBuff()
  end

  if azs.healers[playerName] and azs.healers[playerName].group then
    azs.class.prioGroup = azs.healers[playerName].group
  else
    azs.class.prioGroup = 1
  end

  azs.class.stop = function()
    SpellStopCasting()
    stop_autoattack()
  end

  azs.class.initMacros = {
    {"HealOnly", "Spell_Nature_MagicImmunity", "/script azs.heal()", {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Mana Drain", "Spell_Shadow_SiphonMana", "/script azs.special()", {66}},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Shaman's main function is either dps or heal.")
  end
end

function initElemShamanData()
  azs.debug("I am elem Shaman")
  local playerName = UnitName("player")
  azs.class.dps = function()
      shamanAttack()
  end
  azs.class.heal = function() shamanHeal() end
  azs.class.buff = function()
    shamanBuff()
  end

  if azs.healers[playerName] and azs.healers[playerName].group then
    azs.class.prioGroup = azs.healers[playerName].group
  else
    azs.class.prioGroup = 1
  end

  azs.class.stop = function()
    SpellStopCasting()
    stop_autoattack()
  end

  azs.class.initMacros = {
    {"Attack skull", "Spell_Lightning_LightningBolt01", "/script azs.dps()", {1,5}},
    {"Attack cross", "Spell_Fire_FlameShock", "/script azs.dps(\"cross\")", {2}},
    {"HealOnly", "Spell_Nature_MagicImmunity", "/script azs.heal()", {66}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Shaman's main function is either dps or heal.")
  end
end
