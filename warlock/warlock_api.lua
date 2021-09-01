function initWarlockData()
  azs.debug("I am warlock")
  local playerName = UnitName("player")

  -- Setting default element:
  -- Could be "Shadow" or "Fire"
  azs.class.element = "Shadow"

  -- Setting curse:
  -- Could be "CoE", "CoT", "CoR", "CoW" or "Cos"
  azs.class.curse = getDefaultWarlockValue("curse", "CoE")

  -- Setting summon companion:
  -- Could be "Imp" or "DS"
  azs.class.summon = getDefaultWarlockValue("summon", "Imp")

  -- Setting drain option for special attack:
  -- Could be "Soul" or "Mana"
  azs.class.drain = "Mana"

  azs.class.dps = function(curse) warlockAttack(curse) end
  azs.class.cc = function(icon) banishByIcon(icon) end
  azs.class.special = function(drain) warlockSpecial(drain) end
  azs.class.buff = function(summon)
    warlockBuff(summon)
    askMageWater()
    if isInBWL() then applyWizardOil() end
  end
  azs.class.aoe = function() warlockAoe() end
  -- azs.class.handleNefaCall = function() end
  azs.class.stopDps = function()
    SpellStopCasting()
  end
  azs.class.ccTarget = getDefaultWarlockValue("ccTarget", 1)
  azs.class.initActionBar = {
		{"Shoot", autoAttackActionSlot},
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Shadow_DeathCoil", "/script azs.dps(\"skull\", \"" .. azs.class.curse .. "\")", {1}, "azs.class.element = \"" .. azs.class.element .. "\""},
    {"Attack cross", "Spell_Shadow_ShadowBolt", "/script azs.dps(\"cross\", \"" .. azs.class.curse .. "\")", {2}, "azs.class.element = \"" .. azs.class.element .. "\""},
    {"Banish " .. azs.class.ccTarget, "Spell_Shadow_Cripple", "/script azs.cc(" .. azs.class.ccTarget .. ")", {3}},
    {"Drain mana", "Spell_Shadow_SiphonMana", "/script azs.special(\"skull\", \"Mana\")", {4}, ""},
    {"Drain soul", "Spell_Shadow_Haunting", "/script azs.special(\"skull\", \"Soul\")", {64}, ""},
    {"AoE", "Spell_Shadow_RainOfFire", "/script azs.aoe()", {5}},
    {"Buff", "Spell_Shadow_SummonImp", "/script azs.buff(\"" .. azs.class.summon .. "\")", {8}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""}
  }
  azs.class.help = function()
    azs.debug("Warlock ranged dps rotation can be choosen by element,which can be set via the 'azs.class.element' set to either of \"Shadow\" or \"Fire\".")
    azs.debug("'azs.class.curse': Curse Choices \"CoE\", \"CoR\", \"CoW\" \"CoS\" or \"CoW\".")
    azs.debug("'azs.class.summon': Summon choices can be set to \"Imp\" or to Sacrifice Succubus \"DS\".")
    azs.debug("'azs.class.drain': Drain choices can be set to \"Mana\" or to \"Soul\".")
  end
end

function getDefaultWarlockValue(field, defaultValue)
  local playerName = UnitName("player")
  if azs.warlocks[playerName] and azs.warlocks[playerName][field] then
    return azs.warlocks[playerName][field]
  else
    return defaultValue
  end
end
