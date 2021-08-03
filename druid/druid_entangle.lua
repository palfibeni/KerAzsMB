function entangle_star()
    entangleByIcon(1)
end

function entangle_orange()
    entangleByIcon(2)
end

function entangle_purple()
    entangleByIcon(3)
end

function entangle_green()
    entangleByIcon(4)
end

function entangle_moon()
    entangleByIcon(5)
end

function entangle_blue()
    entangleByIcon(6)
end

function entangleByIcon(icon)
    azs.targetByIcon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Entangling Roots")
    end
end
