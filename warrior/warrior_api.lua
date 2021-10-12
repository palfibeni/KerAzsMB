-- ActionBar page 1 Battle Stance: slots 73 to 84
-- ActionBar page 1 Defensive Stance: slots 85 to 96
-- ActionBar page 1 Berserker Stance: slots 97 to 108

function initWarriorData()
  azs.class.talent = determineWarriorTalent()
  azs.debug("Talent: " .. azs.class.talent)
  if azs.class.talent == WARRIOR_DEEP_PROT or azs.class.talent == WARRIOR_FURY_PROT then
    initTankWarrior()
  else
    initFuryWarrior()
  end
end

function determineWarriorTalent()
  local _, _, pointsInDefensive = GetTalentTabInfo(3)
  local _, _, pointsInFury = GetTalentTabInfo(2)
  if pointsInDefensive == 0 then
    return WARRIOR_FURY
  elseif pointsInFury > 5 then
    return WARRIOR_FURY_PROT
  else
    return WARRIOR_DEEP_PROT
  end
end

function initTankWarrior()
  if UnitLevel("player") < 11 then
    azs.class.dps = function() warriorArmsAttack() end
  else
    azs.class.dps = function() warriorTankAttack() end
  end

  if UnitLevel("player") < 11 then
    azs.class.aoe = function() warriorArmsAttack() end
  else
    azs.class.aoe = function() warriorTankAoe() end
  end
  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
    {"Taunt", 87},
    {"Concussion Blow", 64},
    {"Disarm", 90},
    {"Shield Bash", 91},
    {"Shield Block", 92},
    {"Heroic Strike", heroicStrikeActionSlot},
    {"Bloodrage", bloodrageActionSlot},
    {"Revenge", revengeActionSlot},
    {"Sunder Armor", sunderArmorActionSlot},
    {"Last Stand", lastStandActionSlot},
    {"Shield Wall", shieldWallActionSlot}
  }
  if azs.class.talent == WARRIOR_FURY_PROT then
    table.insert(azs.class.initActionBar, {"Bloodthirst", bloodThirstActionSlot})
  else
    table.insert(azs.class.initActionBar, {"Shield Slam", shieldSlamActionSlot})
  end
  azs.class.initMacros = {
    {"Tank attack", "Ability_Warrior_DefensiveStance", "/script azs.dps(\"solo\")", {73,74,76,85,86,88}, "warriorTauntEnabled = true"},
    {"AoE tank attack", "Ability_Warrior_Cleave", "/script azs.aoe(\"solo\")", {77,89}, "warriorTauntEnabled = true"},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {81,93,105}}
  }
  azs.class.help = function()
    azs.debug("Wheter a Warrior is tank or not, is determined by talent point put into defensive tree.")
    azs.debug("To setup auto-taunt, you need to add warriorTauntEnabled = true/false in supermacro extension to the attack macro")
  end
end

function initFuryWarrior()
  azs.class.chargeEnabled = false
  if UnitLevel("player") < 31 then
    azs.class.dps = function() warriorArmsAttack() end
  else
    azs.class.dps = function() warriorFuryAttack() end
  end
  azs.class.stop = function()
    stop_autoattack()
  end
  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
    {"Pummel", 99},
    {"Heroic Strike", heroicStrikeActionSlot},
    {"Bloodrage", bloodrageActionSlot},
    {"Berserker Rage", berserkerRageActionSlot},
    {"Whirlwind", whirlwindActionSlot},
    {"Bloodthirst", bloodThirstActionSlot}
  }
  azs.class.initMacros = {
    {"Attack skull", "Ability_DualWield", "/script azs.dps()", {73,77,97,100,101}},
    {"Attack cross", "Ability_SteelMelee", "/script azs.dps(\"cross\")", {74,98}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {81,93,105}}
  }
  azs.class.help = function()
    azs.debug("Whether a Warrior is tank or not, is determined by talent point put into defensive tree.")
    azs.debug("Fury Warriors use bloodthrist, whirlwind, and under 30% hp, they will start piling up rage for execute.")
  end
end
