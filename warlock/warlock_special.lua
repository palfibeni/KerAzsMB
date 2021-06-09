function warlockSpecial()
  if azs.class.drain == "Soul" then
    warlockDrainSoul()
  else
    warlockDrainMana()
  end
end

function warlock_drain_mana_skull()
  if azs.targetSkull() then
    warlockDrainMana()
  end
end

function warlock_drain_mana_cross()
  if azs.targetCross() then
    warlockDrainMana()
  end
end

function warlockDrainMana()
  if casting_or_channeling() then return end
  if (UnitMana("player") >= (UnitLevel("player") * 5)) then
    CastSpellByName("Drain Mana")
  else
    CastSpellByName("Life Tap")
  end
end

-- /script warlock_drain_soul_skull()
function warlock_drain_soul_skull()
  if azs.targetSkull() then
      warlockDrainSoul()
  end
end

function warlock_drain_soul_cross()
  if azs.targetCross() then
    warlockDrainSoul()
  end
end

function warlockDrainSoul()
  if casting_or_channeling() then return end
  if (UnitMana("player")>=290) then
    CastSpellByName("Drain Soul")
  else
    CastSpellByName("Life Tap")
  end
end