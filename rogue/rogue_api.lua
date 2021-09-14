function initRogueData()
  azs.class.weapon = getRogueWeapon() -- Could be "Sword" or "Dagger"
  azs.debug("I am " .. azs.class.weapon .. " Rogue")
  azs.class.dps = function() rogueAttack() end
  azs.class.buff = function()
    if isInBWL() then applyPoisons() end
  end
  azs.class.stopDps = function()
    stop_autoattack()
  end
  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
    {"Kick", 3}
  }
  azs.class.initMacros = {
    {"Attack skull", "Ability_DualWield", "/script azs.dps(nil, \"".. azs.class.weapon .. "\")", {1,4,5}},
    {"Attack cross", "Ability_SteelMelee", "/script azs.dps(\"cross\", \"".. azs.class.weapon .. "\")", {2}},
    {"Poison up", "Ability_Creature_Poison_03", "/script azs.buff()", {8}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Rogue dps rotation can be adjusted by setting the used weapon, which can be set via the 'azs.class.weapon' set to either of \"Sword\" or \"Dagger\".")
  end
end

function getRogueWeapon()
  local _, _, pointsSpentInSubtelity = GetTalentTabInfo(3)
  if pointsSpentInSubtelity > 0 then
    return "Dagger"
  else
    return "Sword"
  end
end
