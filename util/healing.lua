function casting()
    return CastingBarFrame.casting
end

function channeling()
    return CastingBarFrame.channeling
end

-- Returns whether the player is casting or channeling a spell
function casting_or_channeling()
    return casting() or channeling()
end

function is_target_hp_over(percent)
	return not UnitIsDead("target") and UnitHealth("target") / UnitHealthMax("target") > percent
end

function is_target_hp_under(percent)
	return not UnitIsDead("target") and UnitHealth("target") / UnitHealthMax("target") < percent
end

function is_player_hp_over(percent)
	return UnitHealth("player") / UnitHealthMax("player") > percent
end

function is_player_hp_under(percent)
	return UnitHealth("player") / UnitHealthMax("player") < percent
end

function heal_under_percent(percent, spell)
	if UnitIsDead("target") then return end
	if is_target_hp_under(percent) then
		CastSpellByName(spell)
	end
end