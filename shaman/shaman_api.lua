function initShamanData()
  initTotems()
  if isHealShaman() then
    initHealShamanData()
  else
    initElemShamanData()
  end
end

function initTotems()
  -- Setting Earth Totem:
  -- Could be strength, stoneskin, stoneclaw, tremor, none
  azs.class.earth = getDefaultShamanValue("earth", "strength")
  -- Setting Fire Totem:
  -- Could be searing, nova, magma, frostRes, none
  azs.class.fire = getDefaultShamanValue("fire", "none")
  -- Setting Water Totem:
  -- Could be disease, poison, healing, manaSpring, manaTide, fireRes, none
  azs.class.water = getDefaultShamanValue("water", "manaSpring")
  -- Setting summon companion:
  -- Could be windfury, natureRes, windfall, none
  azs.class.air = getDefaultShamanValue("air", "windfury")
end

function getDefaultShamanValue(field, defaultValue)
  local playerName = UnitName("player")
  if azs.shamans[playerName] and azs.shamans[playerName][field] then
    return azs.shamans[playerName][field]
  else
    return defaultValue
  end
end

function isHealShaman()
  local _, _, pointsSpentInResto = GetTalentTabInfo(3)
  return pointsSpentInResto > 0
end

function initHealShamanData()
  azs.debug("I am heal Shaman")
  local playerName = UnitName("player")
  azs.class.dps = function(param)
    castShamanTotems(param)
    shamanAttack()
  end
  azs.class.heal = function(healingProfile, param)
    castShamanTotems(param)
    shamanHeal(azs.targetList.all, healingProfile)
  end
  azs.class.healOrdispel = function(healingProfile, param)
    castShamanTotems(param)
    shamanHealOrDispel(azs.targetList.all, healingProfile)
  end
  azs.class.buff = function(param)
    shamanBuff(param)
    askMageWater()
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

  local params = "{earth = \"" .. azs.class.earth .. "\", fire = \"" .. azs.class.fire
  params = params .. "\", water = \"" .. azs.class.water .. "\", air = \"" .. azs.class.air .. "\"}"

  local mainAttackMacro = "/script azs.dps(nil, ".. params..")"
  local healOrDispelMacro = "/script shamanRess()" .. string.char(10) .. "/script azs.heal(nil, ".. params..")"
  local healOnlyMacro = "/script shamanRess()" .. string.char(10) .. "/script azs.healOrdispel(nil, ".. params..")"
  local buffMacro = "/script azs.buff(".. params..")"

  azs.class.initMacros = {
    {"HealOrDispel", "Spell_ChargePositive", healOrDispelMacro, {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Nature_MagicImmunity", healOnlyMacro, {64,65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Attack skull", "Spell_Lightning_LightningBolt01", mainAttackMacro, {66}},
    {"Buff", "Spell_Nature_LightningShield", buffMacro, {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Shaman's main function is either dps or heal.")
  end
end

function initElemShamanData()
  azs.debug("I am elem Shaman")
  local playerName = UnitName("player")
  azs.class.dps = function(param)
    castShamanTotems(param)
    shamanAttack()
  end
  azs.class.heal = function(healingProfile, param)
    castShamanTotems(param)
    shamanHeal(azs.targetList.all, healingProfile)
  end
  azs.class.healOrdispel = function(healingProfile, param)
    castShamanTotems(param)
    shamanHealOrDispel(azs.targetList.all, healingProfile)
  end
  azs.class.buff = function(param)
    shamanBuff(param)
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

  local params = "{earth = \"" .. azs.class.earth .. "\", fire = \"" .. azs.class.fire
  params = params .. "\", water = \"" .. azs.class.water .. "\", air = \"" .. azs.class.air .. "\"}"

  local mainAttackMacro = "/script azs.dps(nil, ".. params..")"
  local secondaryAttackMacro = "/script azs.dps(\"cross\", ".. params..")"
  local healOrDispelMacro = "/script azs.heal(nil, ".. params..")"
  local healOnlyMacro = "/script azs.healOrdispel(nil, ".. params..")"
  local buffMacro = "/script azs.buff(".. params..")"

  azs.class.initMacros = {
    {"Attack skull", "Spell_Lightning_LightningBolt01", mainAttackMacro, {1,5}},
    {"Attack cross", "Spell_Fire_FlameShock", secondaryAttackMacro, {2}},
    {"HealOrDispel", "Spell_ChargePositive", healOrDispelMacro, {65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Nature_MagicImmunity", healOnlyMacro, {66}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Buff", "Spell_Nature_LightningShield", buffMacro, {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Shaman's main function is either dps or heal.")
  end
end
