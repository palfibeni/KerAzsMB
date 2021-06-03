function warlock_aoe()
  warlockAoe()
end

function warlockAoe()
  if casting_or_channeling() then return end
  if UnitMana("player") >= UnitLevel("player") * 20 then
    CastSpellByName("Hellfire")
  elseif is_player_hp_over(0.3) then
    CastSpellByName("Life Tap")
  end
end
