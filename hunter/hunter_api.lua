if UnitClass("player") == "Hunter" then
  azs.debug("I am hunter")
  azs.class.multiShotEnabled = false
  azs.class.shouldHunterBuffPet = false
  azs.class.dps = function() hunterDps() end
  azs.class.cc = function(icon)
    hunterFeignDeath()
    removeBuff("Ability_Rogue_FeignDeath")
    CastSpellByName("Freezing Trap")
  end
  azs.class.special = function()
    hunterManaDrain()
    hunterDps()
  end
  azs.class.buff = function()
    hunterBuff()
    askMageWater()
  end
  azs.class.handleNefaCall = function() handleNefaCallHunter() end
  azs.class.stopDps = function()
    stop_ranged_attack()
    stop_autoattack()
  end
  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
  	{"Auto Shot", autoShotActionSlot},
  	{"Feign Death", feignDeathActionSlot},
  	{"Aimed Shot", aimedShotActionSlot},
  	{"Multi-Shot", multiShotActionSlot},
  	{"Raptor Strike", raptorStrikeActionSlot},
  	{"Mongoose Bite", mongooseBiteActionSlot}
  }
  azs.class.initMacros = {
    {"Attack skull", "Ability_Hunter_CriticalShot", "/script azs.dps(\"skull\")", {1,5}, "azs.class.multiShotEnabled = true"},
    {"Attack cross", "Ability_Marksmanship", "/script azs.dps(\"cross\")", {2}, "azs.class.multiShotEnabled = true"},
    {"Trap", "Spell_Frost_ChainsOfIce", "/script azs.cc()", {3}},
    {"Drain mana", "Spell_Holy_ElunesGrace", "/script azs.special()", {4}, "azs.class.multiShotEnabled = true"},
    {"Buff", "Ability_TrueShot", "/script azs.buff()", {8}, "azs.class.shouldHunterBuffPet = " .. azs.class.shouldHunterBuffPet},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}}
  }
  azs.class.help = function()
    azs.debug("Hunter ranged dps rotation is Aspect, Hunter's Mark, Auto Shot, Aimed Shot, Multi Shot.")
    azs.debug("Multishot will be only used if 'multiShotEnabled' is set to true.")
    azs.debug("Hunter buff contains pet logic also, but needs to be enabled by setting 'shouldHunterBuffPet' to true.")
  end
end
