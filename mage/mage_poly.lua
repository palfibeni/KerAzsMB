-- /script poly_star()
function poly_star()
    poly_by_icon(1)
end

-- /script poly_orange()
function poly_orange()
    poly_by_icon(2)
end

-- /script poly_purple()
function poly_purple()
    poly_by_icon(3)
end

-- /script poly_green()
function poly_green()
    poly_by_icon(4)
end

-- /script poly_moon()
function poly_moon()
    poly_by_icon(5)
end

-- /script poly_blue()
function poly_blue()
    poly_by_icon(6)
end

function poly_by_icon(icon)
    target_by_icon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        cast("Polymorph")
    end
end
