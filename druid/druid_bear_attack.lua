druidTauntEnabled = true

function druid_bear_skull()
	if is_target_skull() then
        druid_bear_attack()
	else
		stop_autoattack()
		target_skull()
	end
end

function druid_bear_cross()
	if is_target_cross() then
        druid_bear_attack()
	else
		stop_autoattack()
		target_cross()
	end
end

function druid_bear_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	cast_buff_player("Ability_Racial_BearForm", "Dire Bear Form")
	cast_buff_player("Ability_Racial_BearForm", "Bear Form")
	druid_bear_taunt()
	cast_debuff("Spell_Nature_FaerieFire", "Faerie Fire (Feral)()");
	if (UnitMana("player")>=15) then
		CastSpellByName("Maul")
	else
		CastSpellByName("Enrage")
	end
	if (UnitMana("player")>=50) then
		CastSpellByName("Swipe")
	end
	use_autoattack()
end

function druid_bear_taunt()
	if not druidTauntEnabled then return end
	if UnitName("targettarget") == nil then return end
	if UnitName("targettarget") == UnitName("player") then return end
	if is_tank_by_name(UnitName("targettarget")) then return end
	if UnitIsEnemy("target","player") then
		CastSpellByName("Growl")
	end
end
