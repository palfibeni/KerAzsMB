lastShadowWord = 0
lastVampiric = 0

function sh_priest_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        sh_priest_attack()
    else
        target_skull()
        lastShadowWord = 0
        lastVampiric = 0
    end
end

function sh_priest_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        sh_priest_attack()
    else
        target_cross()
        lastShadowWord = 0
        lastVampiric = 0
    end
end

function sh_priest_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	if casting_or_channeling() then return end
  if (UnitMana("player")>=221) then
      stop_wand()
      cast_buff_player("Spell_Shadow_Shadowform", "Shadowform")
      shadow_word_pain()
      shadow_vampiric_embrace()
      CastSpellByName("Mind Blast")
      CastSpellByName("Mind Flay")
  else
	    use_wand()
  end
end

function shadow_word_pain()
  if lastShadowWord + 24 < GetTime() then
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
    lastShadowWord = GetTime()
  end
end

function shadow_vampiric_embrace()
  if lastVampiric + 60 < GetTime() then
    cast_debuff("Spell_Shadow_UnsummonBuilding", "Vampiric Embrace")
    lastVampiric = GetTime()
  end
end
