function druid_attack_skull()
	if is_target_skull() then
        druid_attack()
	else
		stop_autoattack()
		target_skull()
	end
end

function druid_attack_cross()
	if is_target_cross() then
        druid_attack()
	else
		stop_autoattack()
		target_cross()
	end
end

function druid_attack()
    if casting_or_channeling() then return end
    if (UnitMana("player")>=50) then
		-- Useable trinkets
        -- UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
        -- UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
        cast("Wrath")
		stop_autoattack()
	else
		use_autoattack()
    end
end
