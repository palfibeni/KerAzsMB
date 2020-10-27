function warrior_fury_aoe_skull()
	if is_target_skull() then
        warrior_fury_aoe()
	else
		stop_autoattack()
		target_skull()
	end
end

function warrior_fury_aoe_cross()
	if is_target_cross() then
        warrior_fury_aoe()
	else
		stop_autoattack()
		target_cross()
	end
end

function warrior_fury_aoe()
	cast_buff_player("Ability_Racial_Avatar", "Berserker Stance")
	CastSpellByName("Berserker Rage")
	CastSpellByName("Bloodrage")
	CastSpellByName("Whirlwind")
    CastSpellByName("Cleave")
	use_autoattack()
end
