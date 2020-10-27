function warlock_aoe()
    if casting_or_channeling() then return end
    CastSpellByName("Hellfire")
end
