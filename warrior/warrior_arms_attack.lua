function warriorArmsAttack()
	use_autoattack()
	warriorBattleStance()
	if charge() then return end
	bloodrage()
	battleShout()
	if isTargetHpUnder(0.3) then
		CastSpellByName("Execute")
	else
		CastSpellByName("Overpower")
		cast_debuff("Ability_Gouge", "Rend")
		CastSpellByName("Heroic Strike")
	end
end
