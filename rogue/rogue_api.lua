-- ActionBar page 1 Stealth: slots 73 to 84

function initRogueData()
  azs.class.weapon = azs.class.weapon or getRogueWeapon() -- Could be "Sword" or "Dagger"
  azs.class.mainRole = azs.class.mainRole or "Damage" -- either "Damage" or "Stun"
  azs.debug("I am " .. azs.class.weapon .. " Rogue")
  azs.class.dps = function(params) rogueAttack(params) end
  azs.class.buff = function()
    if isInAQ40() then applyPoisons() end
  end
  azs.class.stop = function()
    stop_autoattack()
  end
  local params = "{weapon = \"" .. azs.class.weapon .. "\", mainRole = \"" .. azs.class.mainRole .. "\"}"
  local mainAttackMacro = "/script azs.dps(nil, ".. params..")"
  local secondaryAttackMacro = "/script azs.dps(\"cross\", ".. params..")"

  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
    {"Kick", 3}
  }
  azs.class.initMacros = {
    {"Attack skull", "Ability_DualWield", mainAttackMacro, {1,4,5}},
    {"Attack cross", "Ability_SteelMelee", secondaryAttackMacro, {2}},
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
