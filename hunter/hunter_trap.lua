function hunterFreezingTrap()
  if GetSpellCooldownByName("Freezing Trap") ~= 0 then return end
  hunterFeignDeath()
  removeBuff("Ability_Rogue_FeignDeath")
  CastSpellByName("Freezing Trap")
end

function hunterExplosiveTrap()
  if GetSpellCooldownByName("Explosive Trap") ~= 0 then return end
  hunterFeignDeath()
  removeBuff("Ability_Rogue_FeignDeath")
  CastSpellByName("Explosive Trap")
end
