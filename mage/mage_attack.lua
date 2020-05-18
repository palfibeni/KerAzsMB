function mage_attack_skull()
	if is_target_skull() then
        mage_attack()
	else
		target_skull()
	end
end

function mage_attack_cross()
	if is_target_cross() then
        mage_attack()
	else
		target_cross()
	end
end

function mage_attack()
    if casting_or_channeling() then return end
    local evoc, dur_evoc, en_evoc = GetActionCooldown(61)
    if (UnitMana("player")>= (UnitLevel("player") * 6)) then
        stop_wand()
		if UnitHealth("target") / UnitHealthMax("target") <= .30 then
			cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
			-- Useable trinkets
	        UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
			-- UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		end
        cast("Frostbolt")
    elseif (evoc == 0) then
        cast("Evocation")
    else
        use_wand()
    end
end
