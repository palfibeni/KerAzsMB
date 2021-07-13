if UnitClass("player") == "Warlock" then
  azs.debug("I am warlock")
  azs.class.element = "Shadow" -- Could be "Shadow" or "Fire"
  azs.class.curse = "CoE" -- Could be "CoE", "CoT", "CoR", "CoW" or "Cos"
  azs.class.summon = "Imp" -- Could be "Imp" or "DS"
  azs.class.drain = "Mana" -- Could be "Soul" or "Mana"
  azs.class.dps = function(curse) warlockAttack(curse) end
  azs.class.cc = function(icon) banishByIcon(icon) end
  azs.class.special = function(drain) warlockSpecial(drain) end
  azs.class.buff = function()
    warlockBuff()
    askMageWater()
    if isInBWL() then applyWizardOil() end
  end
  azs.class.aoe = function() warlockAoe() end
  -- azs.class.handleNefaCall = function() end
  azs.class.stopDps = function()
    SpellStopCasting()
  end
  azs.class.initActionBar = {
		{"Shoot", autoAttackActionSlot},
  	{"Summon Felsteed", 9}
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Shadow_DeathCoil", "/script azs.dps(\"skull\")", {1}, "azs.class.element = \"" .. azs.class.element .. "\"" .. string.char(10) .. "azs.class.curse = \"" .. azs.class.curse .. "\""},
    {"Attack cross", "Spell_Shadow_ShadowBolt", "/script azs.dps(\"cross\")", {2}, "azs.class.element = \"" .. azs.class.element .. "\"" .. string.char(10) .. "azs.class.curse = \"" .. azs.class.curse .. "\""},
    {"Banish Star", "Spell_Shadow_Cripple", "/script azs.cc(1)", {3}},
    {"Drain mana", "Spell_Shadow_SiphonMana", "/script azs.special(\"skull\", \"Mana\")", {4}, ""},
    {"Drain soul", "Spell_Shadow_Haunting", "/script azs.special(\"skull\", \"Soul\")", {64}, ""},
    {"AoE", "Spell_Shadow_RainOfFire", "/script azs.aoe()", {5}},
    {"Buff", "Spell_Shadow_SummonImp", "/script azs.buff()", {8}, "azs.class.summon = " .. azs.class.summon}
  }
  azs.class.help = function()
    azs.debug("Warlock ranged dps rotation can be choosen by element,which can be set via the 'azs.class.element' set to either of \"Shadow\" or \"Fire\".")
    azs.debug("'azs.class.curse': Curse Choices \"CoE\", \"CoR\", \"CoW\" \"CoS\" or \"CoW\".")
    azs.debug("'azs.class.summon': Summon choices can be set to \"Imp\" or to Sacrifice Succubus \"DS\".")
    azs.debug("'azs.class.drain': Drain choices can be set to \"Mana\" or to \"Soul\".")
  end
end
