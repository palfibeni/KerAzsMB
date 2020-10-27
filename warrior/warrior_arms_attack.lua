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
	if UnitHealth("target") / UnitHealthMax("target") <= .25 then
		execute()
	else
		CastSpellByName("Overpower")
		rend()
		heroic_strike()
	end
end

function rend()
	if has_debuff("target", "Ability_Gouge") then return end
	if get_rage() > 10 then
		CastSpellByName("Rend")
	else
		CastSpellByName("Bloodrage")
	end
end

function heroic_strike()
	if get_rage() > 15 then
		CastSpellByName("Heroic Strike")
	else
		CastSpellByName("Bloodrage")
	end
end


function execute()
	if get_rage() > 20 then
		CastSpellByName("Execute")
	else
		CastSpellByName("Bloodrage")
	end
end
