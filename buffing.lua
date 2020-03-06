-- If target has no debuff, cast it.
function cast_debuff(icon, spell_name)
	if has_debuff("target", icon) then return end
	cast(spell_name)
end

-- Return whether given target has the given debuff
function has_debuff(target, icon)
	local i,x=1,0
	while (UnitDebuff(target,i)) do
		if (UnitDebuff(target,i) == ("Interface\\Icons\\" .. icon)) then
			x=1
		end
		i=i+1
	end
	return x == 1
end

-- Removes given type of debuff from target with given spell
function remove_debuff_type_target(icon, type, spell_name)
	if has_debuff_type("target", icon, type, spell_name)
		cast(spell_name)
	end
end

-- Removes given type of debuff from player with given spell
function remove_debuff_type_player(type, spell_name)
	if has_debuff_type("player", type, spell_name)
		cast(spell_name)
	end
end

-- Return whether given target has the given type debuff
function has_debuff_type(target, type)
	for x=1,16 do
	    local name,count,debuffType=UnitDebuff(target,x,1)
	    if type == "Magic" then
            return true
        end
    end
end

-- Casts given buff on target
function cast_buff(icon, spell_name)
	if has_buff("target", icon) then return end
	cast(spell_name)
end

-- Casts given buff on player
function cast_buff_player(icon, spell_name)
	if has_buff("player", icon) then return end
	cast(spell_name)
end

-- Return whether given target has the given buff
function has_buff(target, icon)
	local i,x=1,0
	while (UnitBuff(target,i)) do
		if (UnitBuff(target,i) == ("Interface\\Icons\\" .. icon)) then
			x=1
		end
		i=i+1
	end
	return x == 1
end
