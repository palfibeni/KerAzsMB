if UnitClass("player") == "Warlock" then
  azs.debug("I am mage")
  azs.class.element = "Shadow" -- Could be "Shadow" or "Fire"
  azs.class.curse = "CoE" -- Could be "CoE", "CoT", "CoR", "CoW" or "Cos"
  azs.class.summon = "Imp" -- Could be "Imp" or "DS"
  azs.class.drain = "Soul" -- Could be "Soul" or "Mana"
  azs.class.dps = function() warlockAttack() end
  azs.class.cc = function(icon) banishByIcon(icon) end
  azs.class.special = function() warlockSpecial() end
  azs.class.buff = function()
    warlockBuff()
    askMageWater()
  end
  azs.class.aoe = function() warlockAoe() end
  -- azs.class.handleNefaCall = function() end
  azs.class.stopDps = function()
    SpellStopCasting()
  end
  azs.class.initActionBar = function()
		placeSpellByName("Shoot", autoAttackActionSlot)
  end
  azs.class.help = function()
    azs.debug("Warlock ranged dps rotation can be choosen by element,which can be set via the 'azs.class.element' set to either of \"Shadow\" or \"Fire\".")
    azs.debug("'azs.class.curse': Curse Choices \"CoE\", \"CoR\", \"CoW\" \"CoS\" or \"CoW\".")
    azs.debug("'azs.class.summon': Summon choices can be set to \"Imp\" or to Sacrifice Succubus \"DS\".")
    azs.debug("'azs.class.drain': Drain choices can be set to \"Mana\" or to \"Soul\".")
  end
end
