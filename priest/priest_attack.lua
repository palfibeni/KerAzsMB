-- /script priest_skull()
function priest_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        priest_attack()
    else
        target_skull()
    end
end

-- /script priest_cross()
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
        shadow_word_pain()
        CastSpellByName("Mind Blast")
        CastSpellByName("Smite")
    else
		use_wand()
    end
end

function shadow_word_pain()
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
end
