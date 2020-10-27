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
	cast_buff_player("Ability_Warrior_DefensiveStance", "Defensive Stance")
	CastSpellByName("Bloodrage")
	warrior_demo_shout()
	cast_buff_player("Ability_Warrior_BattleShout", "Battle Shout")
	CastSpellByName("Cleave")
	use_autoattack()
end

function warrior_demo_shout()
	cast_debuff("Ability_Warrior_WarCry", "Demoralizing Shout")
end
