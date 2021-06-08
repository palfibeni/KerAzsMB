function shackle_star()
    shackle_by_icon(1)
end

function shackle_orange()
    shackle_by_icon(2)
end

function shackle_purple()
    shackle_by_icon(3)
end

function shackle_green()
    shackle_by_icon(4)
end

function shackle_moon()
    shackle_by_icon(5)
end

function shackle_blue()
    shackle_by_icon(6)
end

function shackle_by_icon(icon)
    azs.targetByIcon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Shackle Undead")
    end
end
