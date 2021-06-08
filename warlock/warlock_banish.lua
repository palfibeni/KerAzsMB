function banish_star()
    banishByIcon(1)
end

function banish_orange()
    banishByIcon(2)
end

function banish_purple()
    banishByIcon(3)
end

function banish_green()
    banishByIcon(4)
end

function banish_moon()
    banishByIcon(5)
end

function banish_blue()
    banishByIcon(6)
end

function banishByIcon(icon)
    azs.targetByIcon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Banish")
    end
end
