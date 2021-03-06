function rouge_attack_skull()
    if is_target_skull() then
        rouge_attack()
    else
        stop_autoattack()
        target_skull()
    end
end

function rouge_attack_cross()
    if is_target_cross() then
        rouge_attack()
    else
        stop_autoattack()
        target_cross()
    end
end

function rouge_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    burst_dmg()
    if (GetComboPoints("target") > 1 ) then
      cast_buff_player("Ability_Rogue_SliceDice", "Slice and Dice")
    end
    if (GetComboPoints("target") == 5) then
        CastSpellByName("Eviscerate")
    else
        CastSpellByName("Sinister Strike")
    end
    use_autoattack()
end

function burst_dmg()
    if (GetComboPoints("target") >= 1) then
        CastSpellByName("Blade Flurry")
        CastSpellByName("Adrenaline Rush")
        UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
    end
end

function rouge_attack_dagger_skull()
    if is_target_skull() then
        rouge_dagger_attack()
    else
        stop_autoattack()
        target_skull()
    end
end

function rouge_attack_dagger_cross()
    if is_target_cross() then
        rouge_dagger_attack()
    else
        stop_autoattack()
        target_cross()
    end
end

function rouge_dagger_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    burst_dmg()
    if (GetComboPoints("target") > 1 ) then
      cast_buff_player("Ability_Rogue_SliceDice", "Slice and Dice")
    end
    if (GetComboPoints("target") == 5) then
        CastSpellByName("Eviscerate")
    else
        CastSpellByName("Backstab")
    end
    use_autoattack()
end
