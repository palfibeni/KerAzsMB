if UnitClass("player") == "Hunter" then
  azs.debug("I am hunter")
  azs.class.dps = function() hunterDps() end
  azs.class.cc = function(icon)
    hunterFeignDeath()
    removeBuff("Ability_Rogue_FeignDeath")
    CastSpellByName("Freezing Trap")
  end
  azs.class.special = function() hunterManaDrain() end
  azs.class.buff = function()
    hunterBuff()
    askMageWater()
  end
  azs.class.handleNefaCall = function() handleNefaCallHunter() end
  azs.class.stopDps = function()
    stop_ranged_attack()
    stop_autoattack()
  end
  azs.class.initActionBar = function()
  	placeSpellByName("Attack", autoAttackActionSlot)
  	placeSpellByName("Auto Shot", autoShotActionSlot)
  	placeSpellByName("Feign Death", feignDeathActionSlot)
  	placeSpellByName("Aimed Shot", aimedShotActionSlot)
  	placeSpellByName("Multi-Shot", multiShotActionSlot)
  	placeSpellByName("Raptor Strike", raptorStrikeActionSlot)
  	placeSpellByName("Mongoose Bite", mongooseBiteActionSlot)
  end
  azs.class.help = function()
    azs.debug("Hunter ranged dps rotation is Aspect, Hunter's Mark, Auto Shot, Aimed Shot, Multi Shot.")
    azs.debug("Multishot will be only used if 'multiShotEnabled' is set to true.")
    azs.debug("Hunter buff contains pet logic also, but needs to be enabled by setting 'shouldHunterBuffPet' to true.")
  end
end
