function warrior_aoe()
	warrior_demo_shout()
	warrior_cleave()
end

function warrior_demo_shout()
	if target_has_debuff("Ability_Warrior_WarCry") then return end
	if get_rage()>10 then
		cast("Demoralizing Shout")
	else
		cast("Bloodrage")
	end
end

function warrior_cleave()
	if get_rage()>20 then
		cast("Cleave")
	else
		cast("Bloodrage")
	end
end
