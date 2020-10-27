function druid_aoe()
	druid_demo_shout()
	druid_cleave()
end

function druid_demo_shout()
	if has_debuff("target", "Ability_Druid_DemoralizingRoar") then return end
	if get_rage() > 10 then
		CastSpellByName("Demoralizing Roar")
	else
		CastSpellByName("Enrage")
	end
end

function druid_cleave()
	if get_rage() > 20 then
		CastSpellByName("Swipe")
	else
		CastSpellByName("Enrage")
	end
end
