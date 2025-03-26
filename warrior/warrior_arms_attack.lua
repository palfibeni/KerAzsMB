function warriorArmsAttack()
	use_autoattack()
	warriorBattleStance()
	if charge() then return end
	bloodrage()
	battleShout()
	CastSpellByName("Overpower")
	cast_debuff("Ability_Gouge", "Rend")
	warriorDemoShout()
	if not IsCurrentAction(heroicStrikeActionSlot) and UnitMana("player") >= 20 then
		CastSpellByName("Heroic Strike")
	end
end

function warriorNeccesarySpells()
	use_autoattack()
	if charge() then return end
	bloodrage()
	battleShout()
end
