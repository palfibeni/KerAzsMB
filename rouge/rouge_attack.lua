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
    burst_dmg()
    sinister_eviscerate()
end

function burst_dmg()
    if (GetComboPoints("target") >= 1) then
        cast("Blade Flurry")
        cast("Adrenaline Rush")
        UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
    end
end

function sinister_eviscerate()
    if (GetComboPoints("target") == 5) then
        cast("Eviscerate")
    else
        cast("Sinister Strike")
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
    burst_dmg()
    backstab_eviscerate()
end

function backstab_eviscerate()
    if (GetComboPoints("target") == 5) then
        cast("Eviscerate")
    else
        cast("Backstab")
    end
end
