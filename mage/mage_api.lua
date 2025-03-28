function initMageData()
  azs.class.talent = determineMageTalent()
  azs.debug("Talent: " .. azs.class.talent)
  azs.class.element =  getMageElement() -- Could be "Frost", "Fire" or "Arcane"
  local playerName = UnitName("player")
  azs.class.dps = function(element)
    handleLowMana()
    mageAttack(element)
  end
  azs.class.dispel = function() mageDispel() end
  azs.class.cc = function(icon) polymorphByIcon(icon) end

  azs.class.buff = function()
    mageWater()
    mageBuff()
    drinkMageWater()
    offerMageWater()
    applyWeaponEnchantBasedOnClass()
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
    {"Polymorph", polymorphActionSlot},
    {"Scorch", scorchActionSlot},
    {"Fire Blast", fireblastActionSlot},
    {"Fireball", fireballActionSlot}
  }

  azs.class.initMacros = {
    {"Poly " .. azs.class.ccTarget, "Ability_Seal", "/script azs.cc(" .. azs.class.ccTarget .. ")", {3}, ""},
    {"AoE", "Spell_Frost_FrostNova", "/script azs.aoe()", {5}, ""},
    {"Buff", "Spell_Holy_MagicalSentry", "/script azs.buff()", {8}, ""},
    {"Attack Arcane skull", "Spell_Nature_StarFall", "/script azs.dps(nil, \"Arcane\")", {65}, ""},
    {"Dispel", "Spell_Holy_DispelMagic", "/script azs.dispel()", {66}, ""},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}, ""},
    {"Follow", "Ability_Hunter_MendPet", "/script azs.follow()", {10}, ""}
  }

  local friendlyPolyLogic = "/script -- polymorphFriendTargets()" .. string.char(10)
  local decurseMacro = "/script -- azs.dispel()" .. string.char(10)
  local dpsBaseMacro = friendlyPolyLogic .. decurseMacro

  local mainDpsMacro = dpsBaseMacro .. "/script azs.dps()"
  local secondaryDpsMacro = dpsBaseMacro .. "/script azs.dps(\"cross\")"
  local offElementDpsMacro = dpsBaseMacro
  if azs.class.talent == MAGE_FIRE then
    offElementDpsMacro = offElementDpsMacro .. "/script azs.dps(nil, \"Frost\")"
    table.insert(azs.class.initMacros, {"Attack skull", "Spell_Fire_Fireball02", mainDpsMacro, {1,4}, ""})
    table.insert(azs.class.initMacros, {"Attack cross", "Spell_Fire_Fire", secondaryDpsMacro, {2}, ""})
    table.insert(azs.class.initMacros, {"Attack Fire skull", "Spell_Frost_FrostArmor", offElementDpsMacro, {64}, ""})
  else
    offElementDpsMacro = offElementDpsMacro .. "/script azs.dps(nil, \"Fire\")"
    table.insert(azs.class.initMacros, {"Attack skull", "Spell_Frost_FrostArmor", mainDpsMacro, {1,4}, ""})
    table.insert(azs.class.initMacros, {"Attack cross", "Spell_Frost_FrostBolt02", secondaryDpsMacro, {2}, ""})
    table.insert(azs.class.initMacros, {"Attack Fire skull", "Spell_Fire_Fireball02", offElementDpsMacro, {64}, ""})
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
