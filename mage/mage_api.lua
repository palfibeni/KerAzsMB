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
  azs.class.initActionBar = {
    {"Evocation", evocationActionSlot},
    {"Shoot", autoAttackActionSlot}
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Frost_FrostArmor", "/script azs.dps(\"skull\")", {1,4}},
    {"Attack cross", "Spell_Frost_FrostBolt02", "/script azs.dps(\"cross\")", {2}},
    {"Poly Star", "Ability_Seal", "/script azs.cc(1)", {3}},
    {"AoE", "Spell_Frost_FrostNova", "/script azs.aoe()", {5}},
    {"Buff", "Spell_Holy_MagicalSentry", "/script azs.buff()", {8}},
    {"Dispel", "Spell_Holy_DispelMagic", "/script azs.dispel()", nil},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Mage ranged dps rotation can be choosen by element,which can be set via the 'azs.class.element' set to either of \"Frost\", \"Fire\" or \"Arcane\".")
  end
end
