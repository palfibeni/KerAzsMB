function initMageData()
  azs.class.talent = determineMageTalent()
  azs.debug("Talent: " .. azs.class.talent)
  azs.class.element =  getMageElement() -- Could be "Frost", "Fire" or "Arcane"
  local playerName = UnitName("player")
  azs.class.dps = function(element) mageAttack(element) end
  azs.class.dispel = function() mageDispel() end
  azs.class.cc = function(icon) polymorphByIcon(icon) end

  azs.class.buff = function()
    mageBuff()
    mageWater()
    offerMageWater()
    if isInAQ40() or isInNaxx() then applyWizardOil() end
  end
  azs.class.aoe = function() mageAoe() end
  -- azs.class.handleNefaCall = function() end
  azs.class.stop = function()
    SpellStopCasting()
  end

  if azs.mages[playerName] and azs.mages[playerName].ccTarget then
    azs.class.ccTarget = azs.mages[playerName].ccTarget
  else
    azs.class.ccTarget = 1
  end

  azs.class.initActionBar = {
    {"Evocation", evocationActionSlot},
    {"Shoot", autoAttackActionSlot},
    {"Polymorph", polymorphActionSlot}
  }
  azs.class.initMacros = {
    {"Poly " .. azs.class.ccTarget, "Ability_Seal", "/script azs.cc(" .. azs.class.ccTarget .. ")", {3}, ""},
    {"AoE", "Spell_Frost_FrostNova", "/script azs.aoe()", {5}, ""},
    {"Buff", "Spell_Holy_MagicalSentry", "/script azs.buff()", {8}, ""},
    {"Attack Arcane skull", "Spell_Nature_StarFall", "/script azs.dps(nil, \"Arcane\")", {65}, ""},
    {"Dispel", "Spell_Holy_DispelMagic", "/script azs.dispel()", {66}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""}
  }

  table.insert(azs.class.initActionBar, {"Scorch", scorchActionSlot})
  table.insert(azs.class.initActionBar, {"Fire Blast", fireblastActionSlot})
  table.insert(azs.class.initActionBar, {"Fireball", fireballActionSlot})
  if azs.class.talent == MAGE_FIRE then
    table.insert(azs.class.initMacros, {"Attack skull", "Spell_Fire_Fireball02", "/script azs.dps()", {1,4}, ""})
    table.insert(azs.class.initMacros, {"Attack cross", "Spell_Fire_Fire", "/script azs.dps(\"cross\")", {2}, ""})
    table.insert(azs.class.initMacros, {"Attack Fire skull", "Spell_Frost_FrostArmor", "/script azs.dps(nil, \"Frost\")", {64}, ""})
  else
    table.insert(azs.class.initMacros, {"Attack skull", "Spell_Frost_FrostArmor", "/script azs.dps()", {1,4}, ""})
    table.insert(azs.class.initMacros, {"Attack cross", "Spell_Frost_FrostBolt02", "/script azs.dps(\"cross\")", {2}, ""})
    table.insert(azs.class.initMacros, {"Attack Fire skull", "Spell_Fire_Fireball02", "/script azs.dps(nil, \"Fire\")", {64}, ""})
  end

  azs.class.help = function()
    azs.debug("Mage ranged dps rotation can be choosen by element, which can be set via the 'azs.class.element' set to either of \"Frost\", \"Fire\" or \"Arcane\".")
  end
end

function getMageElement()
  if azs.class.talent == MAGE_DEEP_FROST or azs.class.talent == MAGE_ARCANE_FROST then
    return "Frost"
  else
    return "Fire"
  end
end

function determineMageTalent()
  local _, _, pointsSpentInFire = GetTalentTabInfo(2)
  local _, _, pointsSpentInFrost = GetTalentTabInfo(3)
  if pointsSpentInFire > 0 then
    return MAGE_FIRE
  elseif pointsSpentInFrost > 30 then
    return MAGE_DEEP_FROST
  else
    return MAGE_ARCANE_FROST
  end
end
