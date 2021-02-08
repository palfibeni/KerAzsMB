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
	warrior_defense_stance()
	bloodrage()
	warrior_demo_shout()
	battleShout()
	if UnitMana("player") >= 20 then
		CastSpellByName("Cleave")
	end
	use_autoattack()
end

function warrior_demo_shout()
	cast_debuff("Ability_Warrior_WarCry", "Demoralizing Shout")
end
