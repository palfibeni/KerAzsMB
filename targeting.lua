function is_target_skull()
	return (GetRaidTargetIndex("target") == 8)
end

function is_target_cross()
	return (GetRaidTargetIndex("target") == 7)
end

function target_skull()
	target_by_icon(8)
end

function target_cross()
	target_by_icon(7)
end

function target_by_icon(icon)
	for k,tank in pairs(tank_list) do
		TargetByName(tank)
		TargetUnit("targettarget")
		if (GetRaidTargetIndex("target") == icon) then
			return
		end
	end
	tab_target_by_icon(icon)
end

function tab_target_by_icon(icon)
	for i=1,10 do
		TargetNearestEnemy()
		if (GetRaidTargetIndex("target") == icon) then
			return
		end
	end
	TargetUnit("player")
end
