function druidBearAoe()
	cast_debuff("Ability_Warrior_WarCry", "Demoralizing Shout");
	CastSpellByName("Enrage")
	if UnitMana("player") > 12 then
		CastSpellByName("Swipe")
	end
	if UnitMana("player") > 35 then
		CastSpellByName("Maul")
	end
end
