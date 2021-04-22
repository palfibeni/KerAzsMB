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

function player_has_buff(icon)
	return has_buff("player", icon)
end

-- Return whether given target has the given buff
function has_buff(target, icon)
	local i=1
	while UnitBuff(target,i)~=nil do
		if "Interface\\Icons\\" .. icon==UnitBuff(target,i) then
			return true
		end
		i=i+1
	end
	return false
end

-- Buffs azs.targetList with spell
function buffTargetList(icon, spell_name, ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
		castBuff(icon, spell_name, target)
	end
end

function castBuff(icon, spell, target)
	if has_buff(target, icon) then return end
	ClearFriendlyTarget()
	CastSpellByName(spell)
	if IsValidSpellTarget(target) then
		SpellTargetUnit(target)
		return
	end
	SpellStopTargeting()
end
