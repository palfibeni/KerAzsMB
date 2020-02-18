function warlock_drain_soul_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        warlock_drain_mana()
    else
        target_skull()
    end
end

function warlock_drain_soul_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        warlock_drain_mana()
    else
        target_cross()
    end
end

function warlock_drain_soul()
    if (UnitMana("player")>=290) then
        cast("Drain Soul")
    else
        cast("Life Tap")
    end
end