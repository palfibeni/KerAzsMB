-- /script druid_balance_skull()
function druid_balance_skull(element)
	element = element or "Arcane"
	if is_target_skull() then
        druid_balance_attack()
	else
		target_skull()
	end
end

-- /script druid_balance_skull("Nature")
-- /script druid_balance_cross()
function druid_balance_cross(element)
	element = element or "Arcane"
	if is_target_cross() then
        druid_balance_attack(element)
	else
		target_cross()
	end
end

-- /script druid_balance_attack("Nature")
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
			cast_debuff("Spell_Nature_StarFall", "Moonfire")
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
