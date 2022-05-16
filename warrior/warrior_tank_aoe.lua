function warriorTankAoe()
	bloodrage()
	if warriorAutoTaunt() then return end
	warriorDefenseStance()
	warriorDemoShout()
	battleShout()
	if UnitMana("player") >= 20 then
		CastSpellByName("Cleave")
	end
	if UnitMana("player") >= 35 then
		sunderArmor()
	end
	doDefCooldown()
	use_autoattack()
end

function warriorDemoShout()
	cast_debuff("Ability_Warrior_WarCry", "Demoralizing Shout")
end
