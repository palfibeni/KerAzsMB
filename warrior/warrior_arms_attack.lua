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
	cast("Overpower")
	rend()
	heroic_strike()
end

function rend()
	if has_debuff("target", "Ability_Gouge") then return end
	if get_rage()>10 then
		cast("Rend")
	else
		cast("Bloodrage")
	end
end


function heroic_strike()
	if get_rage()>15 then
		cast("Heroic Strike")
	else
		cast("Bloodrage")
	end
end
