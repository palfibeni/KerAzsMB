function stop_wand()
	PickupAction(63)
	PlaceAction(62)
end

function use_wand()
	if not IsCurrentAction(62) and not IsCurrentAction(63) then
		UseAction(62)
		PickupAction(62)
		PlaceAction(63)
	end
end

function casting()
    return CastingBarFrame.casting
end

function channeling()
    return CastingBarFrame.channeling
end

function casting_or_channeling()
    return casting() or channeling()
end

function heal_under_percent(percent, spell)
	if is_target_hp_under(percent) then
		cast(spell)
	end
end
