function initHunterData()
  azs.debug("I am Hunter")
  azs.class.multiShotEnabled = azs.class.multiShotEnabled or not isInZG()
  azs.class.shouldHunterBuffPet = azs.class.shouldHunterBuffPet or false
  azs.class.dps = function(params) hunterDps(params) end
  azs.class.cc = function(icon)
    hunterFeignDeath()
    removeBuff("Ability_Rogue_FeignDeath")
    CastSpellByName("Freezing Trap")
  end
  azs.class.special = function()
    hunterManaDrain()
    hunterDps()
  end
  azs.class.buff = function(shouldHunterBuffPet)
    hunterBuff(shouldHunterBuffPet)
    askMageWater()
    drinkMageWater()
  end
  azs.class.handleNefaCall = function() handleNefaCallHunter() end
  azs.class.stop = function()
    stop_ranged_attack()
    stop_autoattack()
  end

  local dpsParams = "{multiShotEnabled = \"" .. tostring(azs.class.multiShotEnabled) .. "\"}"
  local mainAttackMacro = "/script azs.dps(nil, ".. dpsParams ..")"
  local secondaryAttackMacro = "/script azs.dps(\"cross\", ".. dpsParams ..")"

  azs.class.initActionBar = {
    {"Attack", autoAttackActionSlot},
  	{"Auto Shot", autoShotActionSlot},
  	{"Feign Death", feignDeathActionSlot},
  	{"Raptor Strike", raptorStrikeActionSlot},
  	{"Mongoose Bite", mongooseBiteActionSlot},
  	{"Aimed Shot", aimedShotActionSlot},
  	{"Multi-Shot", multiShotActionSlot},
    {"Tranquilizing Shot", tranqShotActionSlot}
  }

  azs.class.initMacros = {
    {"Attack skull", "Ability_Hunter_CriticalShot", mainAttackMacro, {1,5}, ""},
    {"Attack cross", "Ability_Marksmanship", secondaryAttackMacro, {2}, ""},
    {"Trap", "Spell_Frost_ChainsOfIce", "/script azs.cc()", {3}},
    {"Drain mana", "Spell_Holy_ElunesGrace", "/script azs.special()", {4}, ""},
    {"Buff", "Ability_TrueShot", "/script azs.buff()", {8}, "azs.class.shouldHunterBuffPet = false"},
    {"MountUp", "Spell_Nature_Swiftness", "/script mountUp()", {9}},
    {"Follow", "Ability_Hunter_MendPet", "/script azs.follow()", {10}, ""}
  }
  azs.class.help = function()
    azs.debug("Hunter ranged dps rotation is Aspect, Hunter's Mark, Auto Shot, Aimed Shot, Multi Shot.")
    azs.debug("Multishot will be only used if 'multiShotEnabled' is set to true.")
    azs.debug("Hunter buff contains pet logic also, but needs to be enabled by setting 'shouldHunterBuffPet' to true.")
  end
end
