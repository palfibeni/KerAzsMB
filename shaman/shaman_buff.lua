azs.class.lastEarthTotem = 0
azs.class.lastFireTotem = 0
azs.class.lastWaterTotem = 0
azs.class.lastAirTotem = 0

function shamanBuff(param)
  cast_buff_player("Spell_Nature_LightningShield", "Lightning Shield")
  castShamanTotems(param)
end

function castShamanTotems(param)
  earthTotemLogic(earthTotems[param.earth])
  fireTotemLogic(fireTotems[param.fire])
  waterTotemLogic(waterTotems[param.water])
  airTotemLogic(airTotems[param.air])
end

function castTotem(totem, lastTotem)
  if totem == nil or totem.spell == nil then return end
  if totem.icon == nil then
    if lastTotem + 20 < GetTime() then
  		CastSpellByName(totem.spell)
      return true
  	end
    return false
  end
  if lastTotem + 2.5 < GetTime() then
    cast_buff_player(totem.icon, totem.spell)
    return true
  end
  return false
end

function earthTotemLogic(earthTotem)
  local earthTotem = overrideEarthTotem() or earthTotem or decideEarthTotem()
  if castTotem(earthTotem, azs.class.lastEarthTotem) then
    azs.class.lastEarthTotem = GetTime()
  end
end

function overrideEarthTotem()
  if isTargetInMobList(FEARING_MOBS) then
    return earthTotems.tremor
  end
  return nil
end

function decideEarthTotem()
  if UnitLevel("player") < 4 then return nil end
  if UnitLevel("player") > 10 then
    return earthTotems.strength
  end
  return earthTotems.stoneskin
end


function fireTotemLogic(fireTotem)
  local fireTotem = overrideFireTotem() or fireTotem or decideFireTotem()
  if castTotem(fireTotem, azs.class.lastFireTotem) then
    azs.class.lastFireTotem = GetTime()
  end
end

function overrideFireTotem()
  if isTargetInMobList(HIGH_FROST_DAMAGE_MOBS) then
    return fireTotems.frostRes
  end
  return nil
end

function decideFireTotem()
  if UnitLevel("player") < 10 then return nil end
  if UnitLevel("player") > 26 then
    return fireTotems.magma
  end
  return fireTotems.searing
end

function waterTotemLogic(waterTotem)
  local waterTotem = overrideWaterTotem() or waterTotem or decideWaterTotem()
  if castTotem(waterTotem, azs.class.lastWaterTotem) then
    azs.class.lastWaterTotem = GetTime()
  end
end

function overrideWaterTotem()
  if isInAQ20() or isInSubZone(ZG_MARLI) then return waterTotems.poison end
  if isTargetInMobList(HIGH_FIRE_DAMAGE_MOBS) then return waterTotems.fireRes end
  return nil
end

function decideWaterTotem()
  if UnitLevel("player") < 20 then return nil end
  if UnitLevel("player") > 26 then
    return waterTotems.manaSpring
  end
  return waterTotems.healing
end

function airTotemLogic(airTotem)
  local airTotem = overrideAirTotem() or airTotem or decideAirTotem()
  if castTotem(airTotem, azs.class.lastAirTotem) then
    azs.class.lastAirTotem = GetTime()
  end
end

function overrideAirTotem()
  if isInAQ20() or isInSubZone(ZG_MARLI) then return airTotems.natureRes end
  return nil
end

function decideAirTotem()
  if UnitLevel("player") < 30 then return nil end
  return airTotems.windfury
end
