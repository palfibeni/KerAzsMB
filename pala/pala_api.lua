function initPaladinData()
  azs.class.talent = determinePaladinTalent()
  if azs.class.talent == PALADIN_HOLY then
    initHolyPaladinData()
  else
    initRetriPaladinData()
  end
end

function determinePaladinTalent()
  local _, _, pointsSpentInHoly = GetTalentTabInfo(1)
  local _, _, pointsSpentInRetri = GetTalentTabInfo(3)
  if pointsSpentInRetri > pointsSpentInHoly then
    return PALADIN_RETRI
  else
    return PALADIN_HOLY
  end
end

function initHolyPaladinData()
  azs.debug("I am " .. azs.class.talent)
  local playerName = UnitName("player")

  azs.class.heal = function(healingProfile)
    handleLowMana()
    palaHeal(azs.targetList.all, healingProfile)
  end
  azs.class.dispel = function(healingProfile)
    handleLowMana()
    palaDispel(azs.targetList.all)
  end
  azs.class.healOrDispel = function(healingProfile)
    handleLowMana()
    palaHealOrDispel(azs.targetList.all, healingProfile)
  end
  azs.class.buff = function(buff, aura)
    paladinBuff(buff, aura)
    askMageWater()
    drinkMageWater()
    applyWeaponEnchantBasedOnClass()
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

  local freedomLogic = getFreedomLogic()
  local ressMacro = "/script palaRess()" .. string.char(10)
  local judgementLogic = getJudgementLogic()
  local stunLogic = "/script -- paladinStun()" .. string.char(10)
  local healingBaseMacro = freedomLogic .. ressMacro .. judgementLogic .. stunLogic

  local healProfile = getPaladinDefaultHealingProfile()
  local healOrDispelMacro = healingBaseMacro .. "/script azs.healOrDispel(\""..healProfile.."\")"
  local dispelOnlyMacro = healingBaseMacro .. "/script azs.dispel(\""..healProfile.."\")"
  local healOnlyMacro = healingBaseMacro .. "/script azs.heal(\""..healProfile.."\")"
  local buffMacro = "/script azs.buff(\""..getDefaultPaladinValue("buff", determinePaladinBuff()).."\")"
  azs.class.initMacros = {
    {"HealOrDispel", "Spell_ChargePositive", healOrDispelMacro, {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Holy_HolyBolt", healOnlyMacro, {64,65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"DispelOnly", "Spell_Holy_Renew", dispelOnlyMacro, {66,67}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Buff", "Spell_Holy_GreaterBlessingofWisdom", buffMacro, {8}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""},
    {"Follow", "Ability_Hunter_MendPet", "/script azs.follow()", {10}, ""},
    {"PalaHealOnRazu", "Ability_Warrior_BattleShout", "/script /script healOnRazoviousPala()", {}, ""}
  }
  azs.class.help = function()
    azs.debug("Paladin is mainly heal, what buff he will use is determined by its ")
    azs.debug("1. If has santuary, will use it on tanks the rest will get salvation. - \"Sanc/Salva\"")
    azs.debug("2. If has Kings, will use it on everyone. \"Kings\"")
    azs.debug("3. If has Might talented, will use it on melee, and Wisdom on the rest. \"Might/Wisdom\"")
    azs.debug("4. If none, then will use Light. \"Light\"")
    azs.debug("5. If low level, will cast small might/wisdom. \"Small\"")
    azs.debug("The behaviour can be overwritten by passing the wanted param to the buff function.")
  end
end

function getFreedomLogic()
  return "/script blessingOfFreedom(\"" .. getDefaultPaladinValue("freedom", azs.assistMe) .. "\")" .. string.char(10)
end

function getJudgementLogic()
  return "/script -- judgement(\"".. getDefaultPaladinValue("seal", "wisdom") .."\")" .. string.char(10)
end

function getDefaultPaladinValue(field, defaultValue)
  local playerName = UnitName("player")
  if azs.healers[playerName] and azs.healers[playerName][field] then
    return azs.healers[playerName][field]
  else
    return defaultValue
  end
end

function initRetriPaladinData()
  azs.debug("I am " .. azs.class.talent)
  local playerName = UnitName("player")
  azs.class.dps = function(param)
    handleLowMana()
    palaHealOrDispel()
    paladinBuff(buff, aura)
    palaAttack()
  end
  azs.class.heal = function(healingProfile)
    handleLowMana()
    palaHeal(azs.targetList.all, healingProfile)
  end
  azs.class.dispel = function(healingProfile)
    handleLowMana()
    palaDispel(azs.targetList.all)
  end
  azs.class.healOrDispel = function(healingProfile)
    handleLowMana()
    palaHealOrDispel(azs.targetList.all, healingProfile)
  end
  azs.class.buff = function(buff, aura)
    paladinBuff(buff, aura)
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

  local freedomLogic = getFreedomLogic()
  local ressMacro = "/script palaRess()" .. string.char(10)
  local healingBaseMacro = freedomLogic .. ressMacro

  local healProfile = getPaladinDefaultHealingProfile()
  local healOrDispelMacro = healingBaseMacro .. "/script azs.healOrDispel(\""..healProfile.."\")"
  local dispelOnlyMacro = healingBaseMacro .. "/script azs.dispel(\""..healProfile.."\")"
  local healOnlyMacro = healingBaseMacro .. "/script azs.heal(\""..healProfile.."\")"
  local buffMacro = "/script azs.buff(\""..getDefaultPaladinValue("buff", determinePaladinBuff()).."\")"

  azs.class.initActionBar = {
    {"Holy Strike(Rank 1)", holyStrikeActionSlot},
    {"Attack", autoAttackActionSlot},
  }

  azs.class.initMacros = {
    {"Attack skull", "Ability_DualWield", "/script azs.dps()", {1,5}},
    {"Attack cross", "Ability_SteelMelee", "/script azs.dps(\"cross\")", {2}},
    {"HealOrDispel", "Spell_ChargePositive", healOrDispelMacro, {65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Nature_MagicImmunity", healOnlyMacro, {66}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"DispelOnly", "Spell_Holy_Renew", dispelOnlyMacro, {67}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Buff", "Spell_Holy_GreaterBlessingofWisdom", buffMacro, {8}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Paladin is mainly heal, what buff he will use is determined by its ")
    azs.debug("1. If has santuary, will use it on tanks the rest will get salvation. - \"Sanc/Salva\"")
    azs.debug("2. If has Kings, will use it on everyone. \"Kings\"")
    azs.debug("3. If has Might talented, will use it on melee, and Wisdom on the rest. \"Might/Wisdom\"")
    azs.debug("4. If none, then will use Light. \"Light\"")
    azs.debug("5. If low level, will cast small might/wisdom. \"Small\"")
    azs.debug("The behaviour can be overwritten by passing the wanted param to the buff function.")
  end
end
