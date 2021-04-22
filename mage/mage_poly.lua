lastFriendlyPoly = 0
lastFriendlyPolyTarget = nil

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
        CastSpellByName("Polymorph")
    end
end

function polymorphFriendTargets(icon, spell_name, ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if not UnitIsFriend("player",target) and not has_debuff(target, "Spell_Nature_Polymorph") and (lastFriendlyPoly + 10 < GetTime() or lastFriendlyPolyTarget == target) then
        ClearTarget()
        CastSpellByName("Polymorph")
        if IsValidSpellTarget(target) then
          lastFriendlyPoly = GetTime()
          lastFriendlyPolyTarget = target
          SpellTargetUnit(target)
          return
        end
        SpellStopTargeting()
    end
	end
end
