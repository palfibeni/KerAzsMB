function drain_soul()
    if (GetRaidTargetIndex("target")==8 or GetRaidTargetIndex("target")==7) then
        if (UnitMana("player")>=290) then
            cast("Drain Soul")
        else
            cast("Life Tap")
        end
    end
end
