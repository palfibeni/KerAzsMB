-- mellee should have autoattack in slot 62, and slot 63 should be empty
function stop_autoattack()
	PickupAction(63)
	PlaceAction(62)
end

-- mellee should have autoattack in slot 62, and slot 63 should be empty
function use_autoattack()
	if not IsCurrentAction(62) and not IsCurrentAction(63) then
		UseAction(62)
		PickupAction(62)
		PlaceAction(63)
	end
end

-- hunters should have autoshot in slot 64
function stop_ranged_attack()
	if IsAutoRepeatAction(64) then
		CastSpellByName("Auto Shot")
	end
end

-- hunters should have autoshot in slot 64
function use_ranged_attack()
	if not IsAutoRepeatAction(64) then
		CastSpellByName("Auto Shot")
	end
end

-- casters should have wand in slot 62, and slot 63 should be empty
function stop_wand()
	PickupAction(63)
	PlaceAction(62)
end

-- casters should have wand in slot 62, and slot 63 should be empty
function use_wand()
	if not IsCurrentAction(62) and not IsCurrentAction(63) then
		UseAction(62)
		PickupAction(62)
		PlaceAction(63)
	end
end
