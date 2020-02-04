function priest_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        priest_attack()
    else
        target_skull()
    end
end

function priest_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        priest_attack()
    else
        target_cross()
    end
end

function priest_attack()
    if (UnitMana("player")>=221) then
		stop_wand()
        shadowWordPain_skull()
        cast("Mind Blast")
        cast("Smite")
    else
		use_wand()
    end
end

function sh_priest_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        sh_priest_attack()
    else
        target_skull()
    end
end

function sh_priest_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        sh_priest_attack()
    else
        target_cross()
    end
end

function sh_priest_attack()
    if (UnitMana("player")>=221) then
		stop_wand()
        shadowWordPain_skull()
        cast_debuff("Spell_Shadow_UnsummonBuilding", "Vampiric Embrace")
        cast("Mind Blast")
        cast("Mind Flay")
    else
		use_wand()
    end
end

function shadowWordPain_skull()
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
end
