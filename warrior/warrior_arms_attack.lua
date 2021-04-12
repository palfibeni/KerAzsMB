function warrior_arms_skull()
	if is_target_skull() then
		warrior_arms_attack()
	else
    stop_autoattack()
		target_skull()
	end
end

function warrior_arms_cross()
	if is_target_cross() then
		warrior_arms_attack()
	else
    stop_autoattack()
		target_cross()
	end
end

function warrior_arms_attack()
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
