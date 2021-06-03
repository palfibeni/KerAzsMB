if UnitClass("player") == "Mage" then
  azs.debug("I am mage")
  azs.class.element = "Frost" -- Could be "Frost", "Fire" or "Arcane"
  azs.class.dps = function() mageAttack() end
  azs.class.dispel = function() mageDispel() end
  azs.class.cc = function(icon) polymorphByIcon(icon) end
  azs.class.buff = function()
    mageBuff()
    mageWater()
    offerMageWater()
  end
  azs.class.aoe = function() mageAoe() end
  -- azs.class.handleNefaCall = function() end
  azs.class.stopDps = function()
    SpellStopCasting()
  end
  azs.class.initActionBar = function()
    placeSpellByName("Evocation", evocationActionSlot)
		placeSpellByName("Shoot", autoAttackActionSlot)
  end
  azs.class.help = function()
    azs.debug("Mage ranged dps rotation can be choosen by element,which can be set via the 'azs.class.element' set to either of \"Frost\", \"Fire\" or \"Arcane\".")
  end
end
