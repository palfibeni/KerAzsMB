function warrior_arms_skull()
	if (is_target_skull()) then
		warrior_arms_attack()
	else
		target_skull()
	end
end

function warrior_arms_cross()
	if (GetRaidTargetIndex("target")==7) then
		warrior_arms_attack()
	else
		target_cross()
	end
end

local function warrior_arms_attack()
	rend()
	heroic_strike()
end

local function rend()
	if target_has_debuff("Ability_Gouge") then return end
	if get_rage()>10 then
		cast("Rend")
	else
		cast("Bloodrage")
	end
end


local function heroic_strike()
	if get_rage()>15 then
		cast("Heroic Strike")
	else
		cast("Bloodrage")
	end
end
