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
        shadow_form()
        shadow_word_pain()
        cast_debuff("Spell_Shadow_UnsummonBuilding", "Vampiric Embrace")
        CastSpellByName("Mind Blast")
        CastSpellByName("Mind Flay")
    else
		use_wand()
    end
end

function shadow_word_pain()
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
end

function shadow_form()
    cast_buff_player("Spell_Shadow_Shadowform", "Shadowform")
end
