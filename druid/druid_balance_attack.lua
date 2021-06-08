moonfireEnabled = false
moonkinFaerieFireEnabled = false

-- /script druid_balance_skull()
function druid_balance_skull(element)
	if azs.targetSkull() then
		druid_balance_attack()
	end
end

-- /script druid_balance_cross()
function druid_balance_cross(element)
	if azs.targetCross() then
		druid_balance_attack(element)
	end
end

function druid_balance_attack(element)
	element = element or "Arcane"
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	if casting_or_channeling() then return end
	if (UnitMana("player") >= 340) then
		druid_moonkin_form()
		if (element == "Nature") then
			CastSpellByName("Wrath")
		else
			if moonfireEnabled then
				cast_debuff("Spell_Nature_StarFall", "Moonfire")
			end
			if moonkinFaerieFireEnabled then
				cast_debuff("Spell_Nature_FaerieFire", "Faerie Fire")
			end
			CastSpellByName("Starfire")
		end
		stop_autoattack()
	else
		innervate()
  end
end

function druid_moonkin_form()
	local icon, name, active, castable = GetShapeshiftFormInfo(5);
	if not active then
		CastSpellByName("Moonkin Form")
	end
end
