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
	cast_buff_player("Ability_Warrior_DefensiveStance", "Defensive Stance")
	warrior_demo_shout()
	warrior_cleave()
	use_autoattack()
end

function warrior_demo_shout()
	if has_debuff("target", "Ability_Warrior_WarCry") then return end
	if get_rage() > 10 then
		CastSpellByName("Demoralizing Shout")
	else
		CastSpellByName("Bloodrage")
	end
end

function warrior_cleave()
	if get_rage() > 20 then
		CastSpellByName("Cleave")
	else
		CastSpellByName("Bloodrage")
	end
end
