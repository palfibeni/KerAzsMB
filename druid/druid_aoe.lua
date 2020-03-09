function druid_aoe()
	druid_demo_shout()
	druid_cleave()
end

function druid_demo_shout()
	if has_debuff("Ability_Druid_DemoralizingRoar") then return end
	if get_rage() > 10 then
		cast("Demoralizing Roar")
	else
		cast("Enrage")
	end
end

function druid_cleave()
	if get_rage() > 20 then
		cast("Swipe")
	else
		cast("Enrage")
	end
end
