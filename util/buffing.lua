-- Casts given buff on target
function cast_buff(icon, spell_name)
	if not is_in_buff_range() then return end
  if UnitIsDead("target") then return end
	if has_buff("target", icon) then return end
	CastSpellByName(spell_name)
end

-- Casts given buff on player
function cast_buff_player(icon, spell_name)
	if player_has_buff(icon) then return end
	CastSpellByName(spell_name)
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

function player_has_buff(icon)
	return has_buff("player", icon)
end

-- Return whether given target has the given buff
function has_buff(target, icon)
	if UnitIsDead(target) then return false end
	for x=1,20 do
		local name = UnitBuff(target,x)
		if name == nil then
			return false
		end
		if (name == ("Interface\\Icons\\" .. icon)) then
			return true
		end
	end
	return false
end
