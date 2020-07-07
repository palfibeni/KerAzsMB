-- If target has no debuff, cast it.
function cast_debuff(icon, spell_name)
	if has_debuff("target", icon) then return end
	cast(spell_name)
end

-- Return whether given target has the given debuff
function has_debuff(target, icon)
	for x=1,16 do
		if (UnitDebuff(target,x) == ("Interface\\Icons\\" .. icon)) then
			return true
		end
	end
	return false
end

-- Removes given type of debuff from target with given spell
function remove_debuff_type_target(type, spell_name)
	if has_debuff_type("target", type) then
		cast(spell_name)
	end
end

function remove_debuff_types_target(types, spell_name)
	if has_debuff_types("target", types) then
		cast(spell_name)
	end
end

-- Removes given type of debuff from player with given spell
function remove_debuff_type_player(type, spell_name)
	if has_debuff_type("player", type, spell_name) then
		cast(spell_name)
	end
end

-- Return whether given target has the given type debuff
function has_debuff_type(target, type)
	for x=1,16 do
	    local name,count,debuffType=UnitDebuff(target,x,1)
	    if debuffType == type then
            return true
        end
    end
	return false
end

function has_debuff_types(target, types)
	for x=1,16 do
	    local name,count,debuffType=UnitDebuff(target,x,1)
		for i,type in pairs(types) do
			if debuffType == type then
	            return true
	        end
		end
    end
	return false
end

-- Casts given buff on target
function cast_buff(icon, spell_name)
	if has_buff("target", icon) then return end
	cast(spell_name)
end

-- Casts given buff on player
function cast_buff_player(icon, spell_name)
	if player_has_buff(icon) then return end
	cast(spell_name)
end

function player_has_buff(icon)
	return has_buff("player", icon)
end

-- Return whether given target has the given buff
function has_buff(target, icon)
	if UnitIsDead(target) then return false end
	for x=1,16 do
		if (UnitBuff(target,x) == ("Interface\\Icons\\" .. icon)) then
			return true
		end
	end
	return false
end

-- Buffs whole raid with spell
function buff_raid(icon, spell_name)
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and UnitIsConnected("raid"..i) then
			TargetByName(name)
			cast_buff(icon, spell_name)
		end
	end
end

-- Remove Debuffs from whole raid with spell
function remove_debuff_type_raid(type, spell_name)
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and UnitIsConnected("raid"..i) then
			TargetByName(name)
			remove_debuff_type_target(type, spell_name)
		end
	end
end

-- Remove Debuffs from whole raid with spell
function remove_debuff_types_raid(types, spell_name)
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and UnitIsConnected("raid"..i) then
			TargetByName(name)
			remove_debuff_types_target(types, spell_name)
		end
	end
end

-- Buffs all tanks with spell
function buff_tanks(icon, spell_name)

end
