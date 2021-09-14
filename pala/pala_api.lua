function initPaladinData()
  azs.debug("I am Paladin")
  local playerName = UnitName("player")

  azs.class.heal = function() palaHeal() end
  azs.class.dispel = function() palaHealOrDispel() end
  azs.class.buff = function(buff, aura)
    paladinBuff(buff, aura)
    askMageWater()
    if isInBWL() then applyManaOil() end
  end

  if azs.healers[playerName] and azs.healers[playerName].group then
    azs.class.prioGroup = azs.healers[playerName].group
  else
    azs.class.prioGroup = 1
  end

  azs.class.stopDps = function()
    SpellStopCasting()
  end
  azs.class.initMacros = {
    {"HealOrDispel", "Spell_ChargePositive", "/script azs.dispel()", {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Holy_HolyBolt", "/script azs.heal()", {64,65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Buff", "Spell_Holy_GreaterBlessingofWisdom", "/script azs.buff()", {8}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""}
  }
  azs.class.help = function()
    azs.debug("Paladin is mainly heal, what buff he will use is determined by its talents.")
    azs.debug("1. If has santuary, will use it on tanks the rest will get salvation. - \"Sanc/Salva\"")
    azs.debug("2. If has Kings, will use it on everyone. \"Kings\"")
    azs.debug("3. If has Might talented, will use it on mellee, and Wisdom on the rest. \"Might/Wisdom\"")
    azs.debug("4. If none, then will use Light. \"Light\"")
    azs.debug("5. If low level, will cast small might/wisdom. \"Small\"")
    azs.debug("The behaviour can be overwritten by passing the wanted param to the buff function.")
  end
end
