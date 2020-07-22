-- /script druid_balance_skull()
function druid_balance_skull()
	if is_target_skull() then
        druid_balance_attack()
	else
		stop_autoattack()
		target_skull()
	end
end

-- /script druid_balance_cross()
function druid_balance_cross()
	if is_target_cross() then
        druid_balance_attack()
	else
		stop_autoattack()
		target_cross()
	end
end

-- /script druid_balance_attack()
function druid_balance_attack()
	if casting() then return end
	moonkin_form()
    if casting_or_channeling() then return end
    if (UnitMana("player")>=50) then
		cast_debuff("Spell_Nature_StarFall", "Moonfire")
        cast("Starfire")
        cast("Wrath")
		stop_autoattack()
	else
		use_autoattack()
    end
end

function moonkin_form()
	cast_buff_player("Spell_Nature_MoonGlow", "Moonkin Form")
end
