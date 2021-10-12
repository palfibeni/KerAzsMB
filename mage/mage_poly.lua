lastFriendlyPoly = 0
lastFriendlyPolyTarget = nil
polymorphActionSlot = 16

-- /script poly_star()
function poly_star()
    polymorphByIcon(1)
end

-- /script poly_orange()
function poly_orange()
    polymorphByIcon(2)
end

-- /script poly_purple()
function poly_purple()
    polymorphByIcon(3)
end

-- /script poly_green()
function poly_green()
    polymorphByIcon(4)
end

-- /script poly_moon()
function poly_moon()
    polymorphByIcon(5)
end

-- /script poly_blue()
function poly_blue()
    polymorphByIcon(6)
end

function polymorphByIcon(icon)
    azs.targetByIcon(icon)
    if (GetRaidTargetIndex("target") == icon) then
        CastSpellByName("Polymorph")
    end
end

function polymorphFriendTargets()
  if not recastPolymorphFriendTargets() then
	   findNewTargetPolymorphFriendTargets()
  end
end

function recastPolymorphFriendTargets()
  local target = azs.currentPolyTarget
	if target then
		if not UnitCanAttack("player",target) then
			azs.currentPolyTarget = nil
		elseif not has_debuff(target,"Spell_Nature_Polymorph") then
			TargetUnit(target)
			if IsActionInRange(polymorphActionSlot) == 1 then
				CastSpellByName("Polymorph")
				azs.Debug("Poly: "..info.name)
			end
			return true
		end
	end
  return false
end

function findNewTargetPolymorphFriendTargets()
	for target,info in azs.targetList.all do
		if UnitCanAttack("player",target) and (not info.blacklist or info.blacklist<=GetTime()) and (not has_debuff(target,"Spell_Nature_Polymorph") or lastFriendlyPoly + 10 < GetTime()) then
			TargetUnit(target)
			if IsActionInRange(polymorphActionSlot) == 1 then
        lastFriendlyPoly = GetTime()
				currentHealTarget = target
				azs.currentPolyTarget = target -- Fixate on a target, until the mind control expires.
				CastSpellByName("Polymorph")
				azs.Debug("Poly: "..info.name)
			end
		end
	end
end
