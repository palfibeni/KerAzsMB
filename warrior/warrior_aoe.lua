function warrior_aoe_skull()
	if is_target_skull() then
        warrior_aoe()
	else
		stop_autoattack()
		target_skull()
	end
end

function warrior_aoe_cross()
	if is_target_cross() then
        warrior_aoe()
	else
		stop_autoattack()
		target_cross()
	end
end

function warrior_aoe()
	use_autoattack()
	warrior_demo_shout()
	warrior_cleave()
end

function warrior_demo_shout()
	if has_debuff("Ability_Warrior_WarCry") then return end
	if get_rage() > 10 then
		cast("Demoralizing Shout")
	else
		cast("Bloodrage")
	end
end

function warrior_cleave()
	if get_rage() > 20 then
		cast("Cleave")
	else
		cast("Bloodrage")
	end
end
