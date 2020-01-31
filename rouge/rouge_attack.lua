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
    end
end

function sinister_eviscerate()
    if (GetComboPoints("target") == 5) then
        cast("Eviscerate")
    else
        cast("Sinister Strike")
    end
end
