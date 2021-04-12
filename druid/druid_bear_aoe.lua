function druid_bear_aoe()
	cast_debuff("Ability_Warrior_WarCry", "Demoralizing Shout");
	CastSpellByName("Enrage")
	if UnitMana("player") > 20 then
		CastSpellByName("Swipe")
	end
	if UnitMana("player") > 55 then
		CastSpellByName("Maul")
	end
end
