function mageAoe()
  if castingOrChanneling() then return end
  if isPlayerRelativeManaAbove(5) then
    --CastSpellByName("Frost Nova(Rank 1)")
    CastSpellByName("Cone of Cold")
    CastSpellByName("Arcane Explosion")
  elseif hasManaGem() then
    useManaGem()
  else
    CastSpellByName("Evocation")
  end
end
