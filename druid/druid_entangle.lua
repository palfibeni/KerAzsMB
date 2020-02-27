function entangle_star()
    entangle_by_icon(1)
end

function entangle_orange()
    entangle_by_icon(2)
end

function entangle_purple()
    entangle_by_icon(3)
end

function entangle_green()
    entangle_by_icon(4)
end

function entangle_moon()
    entangle_by_icon(5)
end

function entangle_blue()
    entangle_by_icon(6)
end

function entangle_by_icon(icon)
    target_by_icon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        cast("Entangling Roots")
    end
end
