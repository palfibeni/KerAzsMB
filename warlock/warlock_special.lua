function warlockSpecial(drain)
  local drain = drain or azs.class.drain
  if drain == "Soul" then
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
  if castingOrChanneling() then return end
  if isPlayerRelativeManaAbove(5) then
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
  if castingOrChanneling() then return end
  if (UnitMana("player")>=290) then
    CastSpellByName("Drain Soul")
  else
    CastSpellByName("Life Tap")
  end
end
