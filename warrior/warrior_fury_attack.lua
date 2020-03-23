function warrior_fury_skull()
	if is_target_skull() then
		warrior_fury_attack()
	else
        stop_autoattack()
		target_skull()
	end
end

function warrior_fury_cross()
	if is_target_cross() then
		warrior_fury_attack()
	else
        stop_autoattack()
		target_cross()
	end
end

function warrior_fury_attack()
	cast_buff_player("Ability_Racial_Avatar", "Berserker Stance")
	cast_buff_player("Ability_Warrior_AncestralGuardian", "Berserker Rage")
	if UnitHealth("target") / UnitHealthMax("target") <= .30 then
		UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"))
		cast_buff_player("Ability_Racial_DeathPact", "Death Wish")
		cast_buff_player("Ability_Racial_CriticalStrike", "Recklessness")
		execute()
	else
		bloodthrist()
		whirlwind()
		fury_heroic_strike()
	end
	use_autoattack()
end

function bloodthrist()
	if get_rage() > 30 then
		cast("Ability_Racial_BloodLust", "Bloodthirst")
	else
		cast("Ability_Racial_BloodRage", "Bloodrage")
	end
end

function whirlwind()
	if get_rage() > 40 then
		cast("Whirlwind")
	else
		cast("Bloodrage")
	end
end

function fury_heroic_strike()
	if get_rage() > 55 then
		cast("Heroic Strike")
	else
		cast("Bloodrage")
	end
end


function execute()
	if get_rage() > 20 then
		cast("Execute")
	else
		cast("Bloodrage")
	end
end
