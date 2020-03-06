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

-- hunters should have autoshot in slot 64, and slot 65 should be empty
function stop_ranged_attack()
	PickupAction(65)
	PlaceAction(64)
end

-- hunters should have autoshot in slot 64, and slot 65 should be empty
function use_ranged_attack()
	if not IsCurrentAction(64) and not IsCurrentAction(65) then
		UseAction(64)
		PickupAction(64)
		PlaceAction(65)
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
