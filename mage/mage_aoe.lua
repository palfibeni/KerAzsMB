-- /script mage_aoe()
function mage_aoe()
    if casting_or_channeling() then return end
    if (UnitMana("player")>=300) then
        CastSpellByName("Frost Nova")
        CastSpellByName("Cone of Cold")
        CastSpellByName("Arcane Explosion")
    else
        CastSpellByName("Evocation")
    end
end
