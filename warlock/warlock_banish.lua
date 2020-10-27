function banish_star()
    banish_by_icon(1)
end

function banish_orange()
    banish_by_icon(2)
end

function banish_purple()
    banish_by_icon(3)
end

function banish_green()
    banish_by_icon(4)
end

function banish_moon()
    banish_by_icon(5)
end

function banish_blue()
    banish_by_icon(6)
end

function banish_by_icon(icon)
    target_by_icon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Banish")
    end
end
