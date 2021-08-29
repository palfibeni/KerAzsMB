function warrior_aoe_skull()
	if azs.targetSkull() then
		warriorTankAoe()
	else
		stop_autoattack()
	end
end

function warrior_aoe_cross()
	if azs.targetCross() then
		warriorTankAoe()
	else
		stop_autoattack()
	end
end

function warriorTankAoe()
	warriorDefenseStance()
	bloodrage()
	warriorTaunt()
	warriorDemoShout()
	battleShout()
	if UnitMana("player") >= 20 then
		CastSpellByName("Cleave")
	end
	if UnitMana("player") >= 35 then
		sunderArmor()
	end
	use_autoattack()
end

function warriorDemoShout()
	cast_debuff("Ability_Warrior_WarCry", "Demoralizing Shout")
end
