druidTauntEnabled = true
maulActionSlot = 13
enrageActionSlot = 14

lastFeralFaerieFire = 0;

function druid_bear_skull()
	if azs.targetSkull() then
		druidBearAttack()
	else
		stop_autoattack()
	end
end

function druid_bear_cross()
	if azs.targetCross() then
		druidBearAttack()
	else
		stop_autoattack()
	end
end

function druidBearAttack()
	druid_bear_form()
	druid_bear_taunt()
	cast_debuff("Spell_Nature_FaerieFire", "Faerie Fire (Feral)()");
	if not has_debuff("target", "Ability_Warrior_WarCry") then
		cast_debuff("Ability_Druid_DemoralizingRoar", "Demoralizing Roar");
	end
	enrage()
	if not IsCurrentAction(maulActionSlot) and UnitMana("player") >= 7 then
		CastSpellByName("Maul")
	end
	if (UnitMana("player")>=50) then
		CastSpellByName("Swipe")
	end
	use_autoattack()
end

function druid_bear_form()
	local icon, name, active, castable = GetShapeshiftFormInfo(1);
	if not active then
		CastSpellByName("Dire Bear Form")
		CastSpellByName("Bear Form")
	end
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

function feralFaerieFire()
  if lastFeralFaerieFire + 6 < GetTime() then
		cast_debuff("Spell_Nature_FaerieFire", "Faerie Fire (Feral)()");
    lastFeralFaerieFire = GetTime()
  end
end

function enrage()
  if IsActionReady(enrageActionSlot) then
		CastSpellByName("Enrage")
  end
end
