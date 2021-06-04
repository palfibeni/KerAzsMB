function warrior_aoe_skull()
	if azs.targetSkull() then
        warrior_aoe()
	else
		stop_autoattack()
	end
end

function warrior_aoe_cross()
	if azs.targetCross() then
        warrior_aoe()
	else
		stop_autoattack()
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
