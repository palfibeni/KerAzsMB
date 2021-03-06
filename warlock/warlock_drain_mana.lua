function warlock_drain_mana_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        warlock_drain_mana()
    else
        target_skull()
    end
end

function warlock_drain_mana_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        warlock_drain_mana()
    else
        target_cross()
    end
end

function warlock_drain_mana()
    if (UnitMana("player") >= (UnitLevel("player") * 5)) then
        CastSpellByName("Drain Mana")
    else
        CastSpellByName("Life Tap")
    end
end
