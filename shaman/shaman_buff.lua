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

lastEarthTotem = 0
earthTotems = {
  strength = {icon = "Spell_Nature_EarthBindTotem", spell = "Strength of Earth Totem"},
  stoneskin = {icon = "Spell_Nature_StoneSkinTotem", spell = "Stoneskin Totem"},
  stoneclaw = {icon = nil, spell = "Stoneclaw Totem"},
  tremor = {icon = nil, spell = "Tremor Totem"},
  none = {}
}

function earthTotemLogic(earthTotem)
  earthTotem = overrideEarthTotem() or earthTotem or decideEarthTotem()
  if castTotem(earthTotem, lastEarthTotem) then
    lastEarthTotem = GetTime()
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

lastFireTotem = 0
fireTotems = {
  searing = {icon = nil, spell = "Searing Totem"},
  nova = {icon = nil, spell = "Fire Nova Totem"},
  magma = {icon = nil, spell = "Magma Totem"},
  frostRes = {icon = "Spell_FrostResistanceTotem_01", spell = "Frost Resistance Totem"},
  none = {}
}

function fireTotemLogic(fireTotem)
  fireTotem = fireTotem or decideFireTotem()
  if castTotem(fireTotem, lastFireTotem) then
    lastFireTotem = GetTime()
  end
end

function decideFireTotem()
  if UnitLevel("player") < 10 then return nil end
  if UnitLevel("player") > 26 then
    return fireTotems.magma
  end
  return fireTotems.searing
end

lastWaterTotem = 0
waterTotems = {
  disease = {icon = nil, spell = "Disease Cleansing Totem"},
  poison = {icon = nil, spell = "Poison Cleansing Totem"},
  healing = {icon = "INV_Spear_04", spell = "Healing Stream Totem"},
  manaSpring = {icon = "Spell_Nature_ManaRegenTotem", spell = "Mana Spring Totem"},
  manaTide = {icon = "Spell_Frost_SummonWaterElemental", spell = "Mana Tide Totem"},
  fireRes = {icon = "Spell_FireResistanceTotem_01", spell = "Fire Resistance Totem"},
  none = {}
}

function waterTotemLogic(waterTotem)
  waterTotem = overrideWaterTotem() or waterTotem or decideWaterTotem()
  if castTotem(waterTotem, lastWaterTotem) then
    lastWaterTotem = GetTime()
  end
end

function overrideWaterTotem()
  if isInAQ20() or isInSubZone(ZG_MARLI) then return waterTotems.poison end
  return nil
end

function decideWaterTotem()
  if UnitLevel("player") < 20 then return nil end
  if UnitLevel("player") > 26 then
    return waterTotems.manaSpring
  end
  return waterTotems.healing
end

lastAirTotem = 0
airTotems = {
  windfury = {icon = nil, spell = "Windfury Totem"},
  natureRes = {icon = "Spell_Nature_NatureResistanceTotem", spell = "Nature Resistance Totem"},
  windfall = {icon = "Spell_Nature_EarthBind", spell = "Windfall Totem"},
  none = {}
}

function airTotemLogic(airTotem)
  airTotem = overrideAirTotem() or airTotem or decideAirTotem()
  if castTotem(airTotem, lastAirTotem) then
    lastAirTotem = GetTime()
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
