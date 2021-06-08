function getRogueTalent()
  local _, _, pointsSpentInSubtelity = GetTalentTabInfo(3)
  if pointsSpentInSubtelity > 0 then
    return "Dagger"
  else
    return "Sword"
  end
end

if UnitClass("player") == "Rogue" then
  azs.debug("I am rogue")
  azs.class.weapon = getRogueTalent() -- Could be "Sword" or "Dagger"
  azs.class.dps = function() rogueAttack() end
  azs.class.stopDps = function()
    stop_autoattack()
  end
  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
    {"Kick", 3}
  }
  azs.class.initMacros = {
    {"Attack skull", "Ability_DualWield", "/script azs.dps(\"skull\")", {1,4,5}},
    {"Attack cross", "Ability_SteelMelee", "/script azs.dps(\"cross\")", {2}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Rogue dps rotation can be adjusted by setting the used weapon, which can be set via the 'azs.class.weapon' set to either of \"Sword\" or \"Dagger\".")
  end
end
