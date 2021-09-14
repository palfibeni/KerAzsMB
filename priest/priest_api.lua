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

  azs.class.heal = function() priestHeal() end
  azs.class.dispel = function() priestHealOrDispel() end
  azs.class.special = function() priestManaDrain() end
  azs.class.buff = function(aura)
    if UnitLevel("player") == 60 then priestRaidBuff() else priestSmallBuff() end
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
  azs.class.initActionBar = {
		{"Shoot", autoAttackActionSlot},
    {"Prayer of Healing", 67},
  }

  local mainHealMacro = getFearWardLogicIfDwarf(playerName) .. "/script azs.dispel()"
  local healOnlyMacro = getFearWardLogicIfDwarf(playerName) .. "/script azs.heal()"

  azs.class.initMacros = {
    {"HealOrDispel", "Spell_ChargePositive", mainHealMacro, {64,65}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"HealOnly", "Spell_Holy_HolyBolt", healOnlyMacro, {1,2,3,4,5,6}, "SetBias(-0.15,\"group\",".. azs.class.prioGroup ..")"},
    {"Mana Drain", "Spell_Shadow_SiphonMana", "/script azs.special()", {66}},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Priest is mainly heal,")
  end
end

function initShadowPriestData()
  azs.debug("I am Shadow Priest")
  azs.class.vampiricEnabled = false
  azs.class.shPainEnabled = false
  azs.class.dps = function()
    if UnitLevel("player") > 20 then
      shPriestAttack()
    else
      priestAttack()
    end
  end
  azs.class.cc = function(icon) shackleByIcon(icon) end
  azs.class.special = function() priestManaDrain() end
  azs.class.buff = function()
    if UnitLevel("player") == 60 then priestRaidBuff() else priestSmallBuff() end
    askMageWater()
    if isInBWL() then applyWizardOil() end
  end
  azs.class.stopDps = function()
    SpellStopCasting()
    lastShadowWord = 0
    lastVampiric = 0
  end
  azs.class.initActionBar = {
		{"Shoot", autoAttackActionSlot},
    {"Prayer of Healing", 67},
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Holy_HolySmite", "/script azs.dps()", {1,5}},
    {"Attack cross", "Spell_Shadow_PsychicScream", "/script azs.dps(\"cross\")", {2}},
    {"Shackle Star", "Spell_Shadow_Cripple", "/script azs.cc(1)", {3}},
    {"Drain mana", "Spell_Shadow_SiphonMana", "/script azs.special()", {4}, ""},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Shadow priest is using Mind Blast, and Mind Flay, on level it will also use Smite.")
    azs.debug("additional options in supermacro extensions:")
    azs.debug("'vampiricEnabled = true' to enable Vampiric Emrace in the rotation")
    azs.debug("'shPainEnabled = true' to enable Shadow Word: Pain in the rotation")
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
