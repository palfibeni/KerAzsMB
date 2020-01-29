function warrior_pull_skull()
    warrior_pull_by_icon(8)
end

function warrior_pull_cross()
    warrior_pull_by_icon(7)
end

function warrior_pull_by_icon(icon)
    for i=1,10 do
        TargetNearestEnemy()
        if (GetRaidTargetIndex("target")==icon)
        then
            cast("Shoot Crossbow")
        end
    end
end
