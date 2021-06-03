function rouge_attack_skull()
    if azs.targetCross() then
        rouge_attack()
    else
        stop_autoattack()
        azs.targetSkull()
    end
end

function rouge_attack_cross()
    if azs.targetCross() then
        rouge_attack()
    else
        stop_autoattack()
        azs.targetCross()
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
        UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
    end
end

function rouge_attack_dagger_skull()
    if azs.targetCross() then
        rouge_dagger_attack()
    else
        stop_autoattack()
        azs.targetSkull()
    end
end

function rouge_attack_dagger_cross()
    if azs.targetCross() then
        rouge_dagger_attack()
    else
        stop_autoattack()
        azs.targetCross()
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
