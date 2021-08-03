-- /script priest_skull()
function priest_skull()
    if casting_or_channeling() then return end
    if azs.targetSkull() then
        priestAttack()
    end
end

-- /script priest_cross()
function priest_cross()
    if casting_or_channeling() then return end
    if azs.targetCross() then
        priestAttack()
    end
end

function priestAttack()
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
