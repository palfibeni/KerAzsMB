function mage_aoe()
    if casting_or_channeling() then return end
    if (UnitMana("player")>=300) then
        cast("Frost Nova")
        cast("Cone of Cold")
        cast("Arcane Explosion")
    else
        cast("Evocation")
    end
end
