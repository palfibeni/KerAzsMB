function warrior_arms_skull()
	if azs.targetSkull() then
		warriorArmsAttack()
	else
    stop_autoattack()
	end
end

function warrior_arms_cross()
	if azs.targetCross() then
		warriorArmsAttack()
	else
    stop_autoattack()
	end
end

function warriorArmsAttack()
	use_autoattack()
	warriorBattleStance()
	if charge() then return end
	bloodrage()
	battleShout()
	if is_target_hp_under(0.3) then
		CastSpellByName("Execute")
	else
		CastSpellByName("Overpower")
		cast_debuff("Ability_Gouge", "Rend")
		CastSpellByName("Heroic Strike")
	end
end
