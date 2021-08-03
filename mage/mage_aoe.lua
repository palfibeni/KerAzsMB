-- /script mage_aoe()
function mage_aoe()
  mageAoe()
end

function mageAoe()
  if casting_or_channeling() then return end
  if (UnitMana("player") >= UnitLevel("player") * 5) then
      CastSpellByName("Frost Nova(Rank 1)")
      CastSpellByName("Cone of Cold")
      CastSpellByName("Arcane Explosion")
  else
      CastSpellByName("Evocation")
  end
end
