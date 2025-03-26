function banishByIcon(icon)
    azs.targetByIcon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Banish")
    end
end
