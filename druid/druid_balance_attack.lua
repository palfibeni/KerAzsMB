-- /script druid_balance_skull()
function druid_balance_skull(element)
	element = element or "Arcane"
	if is_target_skull() then
        druid_balance_attack()
	else
		stop_autoattack()
		target_skull()
	end
end

-- /script druid_balance_cross()
function druid_balance_cross(element)
	element = element or "Arcane"
	if is_target_cross() then
        druid_balance_attack()
	else
		stop_autoattack()
		target_cross()
	end
end

-- /script druid_balance_attack()
function druid_balance_attack(element)
	element = element or "Arcane"
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	if casting() then return end
	moonkin_form()
	if casting_or_channeling() then return end
	if (UnitMana("player")>=50) then
		if (element == "Nature") then 
			CastSpellByName("Wrath")
		else
			cast_debuff("Spell_Nature_StarFall", "Moonfire")
			CastSpellByName("Starfire")
		end
		stop_autoattack()
	else
		use_autoattack()
    end
end

function moonkin_form()
	cast_buff_player("Spell_Nature_MoonGlow", "Moonkin Form")
end
