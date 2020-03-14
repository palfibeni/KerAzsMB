function warrior_fury_aoe_skull()
	if is_target_skull() then
        warrior_fury_aoe()
	else
		stop_autoattack()
		target_skull()
	end
end

function warrior_fury_aoe_cross()
	if is_target_cross() then
        warrior_fury_aoe()
	else
		stop_autoattack()
		target_cross()
	end
end

function warrior_fury_aoe()
	use_autoattack()
	cast("Berserker Rage")
	warrior_whirlwind()
    warrior_fury_cleave()
end

function warrior_whirlwind()
	if get_rage() > 40 then
		cast("Whirlwind")
	else
		cast("Bloodrage")
	end
end

function warrior_fury_cleave()
	if get_rage() > 60 then
		cast("Cleave")
	else
		cast("Bloodrage")
	end
end
