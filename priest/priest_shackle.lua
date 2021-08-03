function shackle_star()
    shackleByIcon(1)
end

function shackle_orange()
    shackleByIcon(2)
end

function shackle_purple()
    shackleByIcon(3)
end

function shackle_green()
    shackleByIcon(4)
end

function shackle_moon()
    shackleByIcon(5)
end

function shackle_blue()
    shackleByIcon(6)
end

function shackleByIcon(icon)
    azs.targetByIcon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Shackle Undead")
    end
end
