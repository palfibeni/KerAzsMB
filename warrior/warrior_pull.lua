function warrior_pull_skull()
	if is_target_skull() then
		CastSpellByName("Shoot Crossbow")
	else
        stop_autoattack()
		target_skull()
	end
end

function warrior_pull_cross()
	if is_target_cross() then
		CastSpellByName("Shoot Crossbow")
	else
        stop_autoattack()
		target_cross()
	end
end
