function warlock_aoe()
  warlockAoe()
end

function warlockAoe()
  if castingOrChanneling() then return end
  if isPlayerRelativeManaAbove(20) then
    CastSpellByName("Hellfire")
  elseif isPlayerHpOver(0.3) then
    CastSpellByName("Life Tap")
  end
end
