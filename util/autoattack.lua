autoAttackActionSlot = 62
autoAttackOnActionSlot = 63
autoShotActionSlot = 64

-- mellee should have autoattack in slot 62, and slot 63 should be empty
function stop_autoattack()
	PickupAction(autoAttackOnActionSlot)
	PlaceAction(autoAttackActionSlot)
end

-- mellee should have autoattack in slot 62, and slot 63 should be empty
function use_autoattack()
	if not UnitExists("target") or UnitIsFriend("player", "target") then
		stop_autoattack()
		return
	end
	if not IsCurrentAction(autoAttackActionSlot) and not IsCurrentAction(autoAttackOnActionSlot) then
		UseAction(autoAttackActionSlot)
		PickupAction(autoAttackActionSlot)
		PlaceAction(autoAttackOnActionSlot)
	end
end

-- hunters should have autoshot in slot 64
function stop_ranged_attack()
	if IsAutoRepeatAction(autoShotActionSlot) then
		CastSpellByName("Auto Shot")
	end
end

-- hunters should have autoshot in slot 64
function use_ranged_attack()
	if not IsAutoRepeatAction(autoShotActionSlot) then
		CastSpellByName("Auto Shot")
	end
end

-- casters should have wand in slot 62, and slot 63 should be empty
function stop_wand()
	PickupAction(autoAttackOnActionSlot)
	PlaceAction(autoAttackActionSlot)
end

-- casters should have wand in slot 62, and slot 63 should be empty
function use_wand()
	if UnitExists("target") and not IsCurrentAction(autoAttackActionSlot) and not IsCurrentAction(autoAttackOnActionSlot) then
		UseAction(autoAttackActionSlot)
		PickupAction(autoAttackActionSlot)
		PlaceAction(autoAttackOnActionSlot)
	end
end
