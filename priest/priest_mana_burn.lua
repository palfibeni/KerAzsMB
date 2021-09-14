function priestManaDrain()
  if castingOrChanneling() then return end
  CastSpellByName("Mana Burn")
end
