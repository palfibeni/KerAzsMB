function initMageData()
  azs.debug("I am mage")
  azs.class.element =  getMageElement() -- Could be "Frost", "Fire" or "Arcane"
  azs.class.dps = function(element) mageAttack(element) end
  azs.class.dispel = function() mageDispel() end
  azs.class.cc = function(icon) polymorphByIcon(icon) end

  azs.class.buff = function()
    mageBuff()
    mageWater()
    offerMageWater()
    if isInBWL() then applyWizardOil() end
  end
  azs.class.aoe = function() mageAoe() end
  -- azs.class.handleNefaCall = function() end
  azs.class.stopDps = function()
    SpellStopCasting()
  end

  if azs.mages[playerName] and azs.mages[playerName].ccTarget then
    azs.class.ccTarget = azs.mages[playerName].ccTarget
  else
    azs.class.ccTarget = 1
  end

  azs.class.initActionBar = {
    {"Evocation", evocationActionSlot},
    {"Shoot", autoAttackActionSlot}
  }
  azs.class.initMacros = {
    {"Attack skull", "Spell_Frost_FrostArmor", "/script azs.dps(nil, \"Frost\")", {1,4}, ""},
    {"Attack cross", "Spell_Frost_FrostBolt02", "/script azs.dps(\"cross\", \"Frost\")", {2}, ""},
    {"Attack Fire skull", "Spell_Fire_Fireball02", "/script azs.dps(nil, \"Fire\")", {64}, ""},
    {"Poly " .. azs.class.ccTarget, "Ability_Seal", "/script azs.cc(" .. azs.class.ccTarget .. ")", {3}, ""},
    {"AoE", "Spell_Frost_FrostNova", "/script azs.aoe()", {5}, ""},
    {"Buff", "Spell_Holy_MagicalSentry", "/script azs.buff()", {8}, ""},
    {"Dispel", "Spell_Holy_DispelMagic", "/script azs.dispel()", {65}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""}
  }
  azs.class.help = function()
    azs.debug("Mage ranged dps rotation can be choosen by element, which can be set via the 'azs.class.element' set to either of \"Frost\", \"Fire\" or \"Arcane\".")
  end
end

function getMageElement()
  local _, _, pointsSpentInSubtelity = GetTalentTabInfo(3)
  if pointsSpentInSubtelity > 5 then
    return "Frost"
  else
    return "Fire"
  end
end
