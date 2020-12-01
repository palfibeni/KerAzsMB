-- Removes given type of debuff from target with given spell
function remove_debuff_type_target(type, spell_name)
    if UnitIsDead("target") then return end
	if has_debuff_type("target", type) then
		CastSpellByName(spell_name)
	end
end

-- Removes given types of debuffs from target with given spell
function remove_debuff_types_target(types, spell_name)
    if UnitIsDead("target") then return end
	if has_debuff_types("target", types) then
		CastSpellByName(spell_name)
	end
end

-- Removes given type of debuff from player with given spell
function remove_debuff_type_player(type, spell_name)
    if UnitIsDead("target") then return end
	if has_debuff_type("player", type, spell_name) then
		CastSpellByName(spell_name)
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

-- Return whether given target has the given type debuff
function has_debuff_type(target, type)
	for x=1,16 do
	    local name,count,debuffType=UnitDebuff(target,x,1)
		if name == nil then
			return false
		end
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
			if name == nil then
				return false
			end
			if debuffType == type then
	            return true
			end
		end
    end
	return false
end
