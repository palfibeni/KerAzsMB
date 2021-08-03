-- ActionBar page 1 Battle Stance: slots 73 to 84
-- ActionBar page 1 Defensive Stance: slots 85 to 96
-- ActionBar page 1 Berserker Stance: slots 97 to 108

function initWarriorData()
  if isTankWarrior() then
    initTankWarrior()
  else
    initFuryWarrior()
  end
end

function isTankWarrior()
  local _, _, pointsInDefensive = GetTalentTabInfo(3)
  return pointsInDefensive > 0
end

function initTankWarrior()
  azs.debug("I am Tank warrior")
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
    {"Heroic Strike", heroicStrikeActionSlot},
    {"Bloodrage", bloodrageActionSlot},
    {"Revenge", revengeActionSlot},
    {"Sunder Armor", sunderArmorActionSlot},
    {"Shield Slam", shieldSlamActionSlot}
  }
  azs.class.initMacros = {
    {"Tank attack", "Ability_Warrior_DefensiveStance", "/script azs.dps(\"solo\")", {73,74,76,85,86,88}, "warriorTauntEnabled = true"},
    {"AoE tank attack", "Ability_Warrior_Cleave", "/script azs.aoe(\"solo\")", {77,89}, "warriorTauntEnabled = true"},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {81,93}}
  }
  azs.class.help = function()
    azs.debug("Wheter a Warrior is tank or not, is determined by talent point put into defensive tree.")
    azs.debug("To setup auto-taunt, you need to add warriorTauntEnabled = true/false in supermacro extension to the attack macro")
  end
end

function initFuryWarrior()
  azs.debug("I am fury warrior")
  if UnitLevel("player") > 31 then
    azs.class.dps = function() warriorArmsAttack() end
  else
    azs.class.dps = function() warriorFuryAttack() end
  end
  azs.class.stopDps = function()
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
    {"Attack skull", "Ability_DualWield", "/script azs.dps(\"skull\")", {73,77,97,100,101}},
    {"Attack cross", "Ability_SteelMelee", "/script azs.dps(\"cross\")", {74,98}},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {81,93,105}}
  }
  azs.class.help = function()
    azs.debug("Wheter a Warrior is tank or not, is determined by azs.tank_list.")
    azs.debug("Fury Warriors use bloodthrist, whirlwind, and under 30% hp, they will start piling up rage for execute.")
  end
end
