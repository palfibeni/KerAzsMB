-- ActionBar page 1 Cat Form: slots 73 to 84
-- ActionBar page 1 Prowl: slots 85 to 96
-- ActionBar page 1 Bear Form: slots 97 to 108
-- ActionBar page 1 Moonkin Form: slots 109 to 120

function initDruidData()
  if isTankDruid() then
    initTankDruidData()
  elseif isBalanceDruid() then
    initBalanceDruidData()
  else
    initRestoDruidData()
  end
end

function isTankDruid()
  local _, _, pointsInFeral = GetTalentTabInfo(2)
  return pointsInFeral > 0
end

function isBalanceDruid()
  local _, _, pointsInBalance = GetTalentTabInfo(1)
  return pointsInBalance > 30
end

function initTankDruidData()
  azs.debug("I am Tank Druid")
  azs.class.dps = function(form)
    if form == "Bear" then
      druidBearAttack()
    else
      catAttack()
    end
  end
  azs.class.aoe = function() druidBearAoe() end
  azs.class.buff = function() druidBuff() end
  azs.class.stopDps = function()
    stop_autoattack()
  end

  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
    {"Growl", 64},
    {"Bash", 99},
    {"Maul", maulActionSlot},
    {"Enrage", enrageActionSlot}
  }
  azs.class.initMacros = {
    {"Bear attack", "Ability_Druid_Maul", "/script azs.dps(\"solo\", \"Bear\")", {1,97,98,100}, "druidTauntEnabled = true"},
    {"AoE tank attack", "Ability_Warrior_Cleave", "/script azs.aoe(\"solo\")", {101}, "druidTauntEnabled = true"},
    {"Cat attack", "Ability_Druid_Rake", "/script azs.dps(\"solo\", \"Cat\")", {73,74,75,76,77,78,79}},
    {"Druid buff", "Spell_Nature_Regeneration", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Wheter a Druid is tank or not, is determined by talentPoints put into feral tree.")
    azs.debug("To setup auto-taunt, you need to add druidTauntEnabled = true/false in supermacro extension to the attack macro.")
  end
end

function initBalanceDruidData()
  azs.debug("I am balance druid")
  azs.class.element = "Arcane" -- Could be "Arcane" or "Nature"
  azs.class.dps = function(element) druidBalanceAttack(element) end
  azs.class.dispel = function() DruidDispel() end
  azs.class.cc = function(icon) entangleByIcon(icon) end
  azs.class.buff = function()
    druidBuff()
    askMageWater()
    if isInBWL() then applyWizardOil() end
  end
  azs.class.stopDps = function()
    SpellStopCasting()
    stop_autoattack()
  end
  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot}
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Nature_Lightning", "/script azs.dps(\"skull\", \"Arcane\")", {1,4,5,109,112,113}, ""},
    {"Attack cross", "Spell_Nature_StarFall", "/script azs.dps(\"cross\", \"Arcane\")", {2,110}, ""},
    {"Attack Nature skull", "Ability_Creature_Poison_03", "/script azs.dps(\"skull\", \"Nature\")", {64}, ""},
    {"Entangle Star", "Ability_Seal", "/script azs.cc(1)", {3,111}, ""},
    {"Buff", "Spell_Holy_MagicalSentry", "/script azs.buff()", {8,116}, ""},
    {"Dispel", "Spell_Holy_DispelMagic", "/script azs.dispel()", {65}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""}
  }
  azs.class.help = function()
    azs.debug("Druid ranged dps rotation can be choosen by element, which can be set via the 'azs.class.element' set to either of \"Arcane\" or \"Nature\".")
  end
end

function initRestoDruidData()
  azs.debug("I am resto druid")
  azs.class.heal = function() DruidHeal() end
  azs.class.dispel = function() dudu_heal_mandokir() end
  azs.class.buff = function()
    druidBuff()
    askMageWater()
    if isInBWL() then applyManaOil() end
  end
  azs.class.stopDps = function()
    SpellStopCasting()
  end
  azs.class.initMacros = {
    {"HealOrDispel", "Spell_ChargePositive", "/script azs.dispel()", {1,2,3,4,5,6} },
    {"HealOnly", "Spell_Holy_HolyBolt", "/script azs.heal()", {64,65}},
    {"Buff", "Spell_Holy_WordFortitude", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Druid is mainly heal.")
  end
end
