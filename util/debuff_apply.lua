-- If target has no debuff, cast it.
function cast_debuff(icon, spell_name)
	if has_debuff("target", icon) then return end
	CastSpellByName(spell_name)
end

-- Return whether given target has the given debuff
function has_debuff(target, icon)
	for x=1,16 do
		local name = UnitDebuff(target,x)
		if (name == nil) then
			return false
		end
		if (name == ("Interface\\Icons\\" .. icon)) then
			return true
		end
	end
	return false
end

-- Return whether given target has the given debuff
function get_debuff_count(target, icon)
	for x=1,16 do
		local name, count = UnitDebuff(target,x)
		if (name == nil) then
			return 0
		end
		if (name == ("Interface\\Icons\\" .. icon)) and count then
			return tonumber(count)
		end
	end
	return 0
end
