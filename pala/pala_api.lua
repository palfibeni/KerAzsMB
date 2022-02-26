function initPaladinData()
  azs.debug("I am Paladin")
  local playerName = UnitName("player")

  azs.class.heal = function(healingProfile)
    handleLowMana()
    palaHeal(azs.targetList.all, healingProfile)
  end
  azs.class.dispel = function(healingProfile)
    handleLowMana()
    palaDispel(azs.targetList.all, healingProfile)
  end
  azs.class.healOrDispel = function(healingProfile)
    handleLowMana()
    palaHealOrDispel(azs.targetList.all, healingProfile)
  end
  azs.class.buff = function(buff, aura)
    paladinBuff(buff, aura)
    askMageWater()
    if isInProgressRaid() then applyManaOil() end
  end

  if azs.healers[playerName] and azs.healers[playerName].group then
    azs.class.prioGroup = azs.healers[playerName].group
  else
    azs.class.prioGroup = 1
  end

  azs.class.stop = function()
    SpellStopCasting()
  end

  local healOrDispelMacro = getFreedomLogic() .. "/script palaRess()" .. string.char(10) .. "/script azs.healOrDispel(\"hlTankOnly\")"
  local dispelOnlyMacro = getFreedomLogic() .. "/script palaRess()" .. string.char(10) .. "/script azs.dispel(\"hlTankOnly\")"
  local healOnlyMacro = getFreedomLogic() .. "/script palaRess()" .. string.char(10) .. "/script azs.heal(\"hlTankOnly\")"
  local buffType = getDefaultPaladinValue("buff", determinePaladinBuff())
  azs.class.initMacros = {
    {"HealOrDispel", "Spell_ChargePositive", healOrDispelMacro, {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Holy_HolyBolt", healOnlyMacro, {64,65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"DispelOnly", "Spell_Holy_Renew", dispelOnlyMacro, {66,67}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Buff", "Spell_Holy_GreaterBlessingofWisdom", "/script azs.buff(\""..buffType.."\")", {8}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""}
  }
  azs.class.help = function()
    azs.debug("Paladin is mainly heal, what buff he will use is determined by its ")
    azs.debug("1. If has santuary, will use it on tanks the rest will get salvation. - \"Sanc/Salva\"")
    azs.debug("2. If has Kings, will use it on everyone. \"Kings\"")
    azs.debug("3. If has Might talented, will use it on mellee, and Wisdom on the rest. \"Might/Wisdom\"")
    azs.debug("4. If none, then will use Light. \"Light\"")
    azs.debug("5. If low level, will cast small might/wisdom. \"Small\"")
    azs.debug("The behaviour can be overwritten by passing the wanted param to the buff function.")
  end
end

function getFreedomLogic()
  return "/script blessingOfFreedom(\"" .. getDefaultPaladinValue("freedom", azs.assistMe) .. "\")" .. string.char(10)
end

function getDefaultPaladinValue(field, defaultValue)
  local playerName = UnitName("player")
  if azs.healers[playerName] and azs.healers[playerName][field] then
    return azs.healers[playerName][field]
  else
    return defaultValue
  end
end
