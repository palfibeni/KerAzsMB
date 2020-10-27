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
	warrior_whirlwind()
    warrior_fury_cleave()
	use_autoattack()
end

function warrior_whirlwind()
	if get_rage() > 40 then
		CastSpellByName("Whirlwind")
	else
		CastSpellByName("Bloodrage")
	end
end

function warrior_fury_cleave()
	if get_rage() > 60 then
		CastSpellByName("Cleave")
	else
		CastSpellByName("Bloodrage")
	end
end
