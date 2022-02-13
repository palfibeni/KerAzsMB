moonfireEnabled = false

-- /script druid_balance_skull()
function druid_balance_skull(element)
	if azs.targetSkull() then
		druidBalanceAttack()
	end
end

-- /script druid_balance_cross()
function druid_balance_cross(element)
	if azs.targetCross() then
		druidBalanceAttack(element)
	end
end

function druidBalanceAttack(element)
	element = element or azs.class.element
	if castingOrChanneling() then return end
	if (UnitMana("player") >= 340) then
		druid_moonkin_form()
		if (element == "Nature") then
			CastSpellByName("Wrath")
		else
			if moonfireEnabled then
				cast_debuff("Spell_Nature_StarFall", "Moonfire")
			end
			cast_debuff("Spell_Nature_FaerieFire", "Faerie Fire")
			CastSpellByName("Starfire")
		end
		stop_autoattack()
	else
		innervate()
  end
end

function faireFire()
	if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
		cast_debuff("Spell_Nature_FaerieFire", "Faerie Fire")
	end
end

function druid_moonkin_form()
	local icon, name, active, castable = GetShapeshiftFormInfo(5);
	if not active then
		CastSpellByName("Moonkin Form")
	end
end
