-- ActionBar page 1 Shadowform: slots 73 to 84

function initPriestData()
  if isShadowPriest() then
    initShadowPriestData()
  else
    initHolyPriestData()
  end
end

function isShadowPriest()
  local _, _, pointsSpentInShadow = GetTalentTabInfo(3)
  return pointsSpentInShadow > 0
end

function initHolyPriestData()
  azs.debug("I am Holy Priest")
  local playerName = UnitName("player")

  azs.class.heal = function(healingProfile)
    handleLowMana()
    priestHeal(azs.targetList.all, healingProfile)
  end
  azs.class.dispel = function(healingProfile)
    handleLowMana()
    priestDispel(azs.targetList.all)
  end
  azs.class.healOrDispel = function(healingProfile)
    handleLowMana()
    priestHealOrDispel(azs.targetList.all, healingProfile)
  end
  azs.class.special = function() priestManaDrain() end
  azs.class.buff = function(aura)
    if UnitLevel("player") == 60 then priestRaidBuff() else priestSmallBuff() end
    askMageWater()
    drinkMageWater()
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
  azs.class.initActionBar = {
		{"Shoot", autoAttackActionSlot},
    {"Fade", fadeActionSlot},
    {"Power Infusion", powerInfusionActionSlot},
    {"Prayer of Healing", 67},
  }

  local healOrDispelMacro = getFearWardLogicIfDwarf(playerName) .. "/script priestRess()" .. string.char(10) .. "/script azs.healOrDispel()"
  local healOnlyMacro = getFearWardLogicIfDwarf(playerName) .. "/script priestRess()" .. string.char(10) .. "/script azs.heal()"
  local dispelOnlyMacro = getFearWardLogicIfDwarf(playerName) .. "/script priestRess()" .. string.char(10) .. "/script azs.dispel()"

  azs.class.initMacros = {
    {"HealOnly", "Spell_Holy_HolyBolt", healOnlyMacro, {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOrDispel", "Spell_ChargePositive", healOrDispelMacro, {65,66}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"DispelOnly", "Spell_Holy_DispelMagic", dispelOnlyMacro, {67,68}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Mana Drain", "Spell_Shadow_SiphonMana", "/script azs.special()", {64}},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}},
    {"Follow", "Ability_Hunter_MendPet", "/script azs.follow()", {10}, ""},
    {"PriestHealOnRazu", "Ability_Warrior_BattleShout", "/script /script healOnRazoviousPriest()", {}, ""}
  }
  azs.class.help = function()
    azs.debug("Priest is mainly heal,")
  end
end

function initShadowPriestData()
  azs.debug("I am Shadow Priest")
  azs.class.vampiricEnabled = azs.class.vampiricEnabled or false
  azs.class.shPainEnabled = azs.class.vampiricEnabled or false
  azs.class.dps = function()
    if UnitLevel("player") > 20 then
      shPriestAttack()
    else
      priestAttack()
    end
  end
  azs.class.cc = function(icon) shackleByIcon(icon) end
  azs.class.special = function() priestManaDrain() end
  azs.class.heal = function(healingProfile) priestHeal(azs.targetList.all, healingProfile) end
  azs.class.dispel = function(healingProfile) priestHealOrDispel(azs.targetList.all, healingProfile) end
  azs.class.buff = function()
    if UnitLevel("player") == 60 then priestRaidBuff() else priestSmallBuff() end
    askMageWater()
    applyWeaponEnchantBasedOnClass()
  end
  azs.class.stop = function()
    SpellStopCasting()
    lastShadowWord = 0
    lastVampiric = 0
  end
  azs.class.initActionBar = {
		{"Shoot", autoAttackActionSlot},
    {"Prayer of Healing", 67},
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Holy_HolySmite", "/script azs.dps()", {1,5, 73, 77}},
    {"Attack cross", "Spell_Shadow_PsychicScream", "/script azs.dps(\"cross\")", {2, 74}},
    {"Shackle Star", "Spell_Shadow_Cripple", "/script azs.cc(1)", {3, 75}},
    {"Drain mana", "Spell_Shadow_SiphonMana", "/script azs.special()", {4, 76}, ""},
    {"HealOnly", "Spell_Holy_HolyBolt", "/script azs.heal()", {64}, ""},
    {"HealOrDispel", "Spell_ChargePositive", "/script azs.dispel()", {65}, ""},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8, 79}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9, 80}},
    {"Follow", "Ability_Hunter_MendPet", "/script azs.follow()", {10}, ""}
  }
  azs.class.help = function()
    azs.debug("Shadow priest is using Mind Blast, and Mind Flay, on low level it will also use Smite.")
    azs.debug("additional options in supermacro extensions:")
    azs.debug("'azs.class.vampiricEnabled = true' to enable Vampiric Emrace in the rotation")
    azs.debug("'azs.class.shPainEnabled = true' to enable Shadow Word: Pain in the rotation")
  end
end

function getFearWardLogicIfDwarf(playerName)
  if UnitRace("player") == "Dwarf" then
    return "/script fearWard(\"" .. getFearWardTarget(playerName) .. "\")" .. string.char(10)
  end
  return ""
end

function getFearWardTarget(playerName)
  if azs.healers[playerName] and azs.healers[playerName].fearWard then
    return azs.healers[playerName].fearWard
  end
  return azs.assistMe
end
