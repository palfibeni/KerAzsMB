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
    if (UnitMana("player")>=221) then
        stop_wand()
		-- Useable trinkets
        -- UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
        -- UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
        cast("Frostbolt")
    elseif (evoc == 0) then
        cast("Evocation")
    else
        use_wand()
    end
end
