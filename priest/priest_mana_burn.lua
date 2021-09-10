function priestManaDrain()
  if casting_or_channeling() then return end
  CastSpellByName("Mana Burn")
end
