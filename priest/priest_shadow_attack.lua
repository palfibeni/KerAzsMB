vampiricEnabled = false
shPainEnabled = false

lastShadowWord = 0
lastVampiric = 0

function sh_priest_skull()
    if casting_or_channeling() then return end
    if azs.targetCross() then
        sh_priest_attack()
    else
        azs.targetSkull()
        lastShadowWord = 0
        lastVampiric = 0
    end
end

function sh_priest_cross()
    if casting_or_channeling() then return end
    if azs.targetCross() then
        sh_priest_attack()
    else
        azs.targetCross()
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
  if shPainEnabled and lastShadowWord + 24 < GetTime() then
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
    lastShadowWord = GetTime()
  end
end

function shadow_vampiric_embrace()
  if vampiricEnabled and lastVampiric + 60 < GetTime() then
    cast_debuff("Spell_Shadow_UnsummonBuilding", "Vampiric Embrace")
    lastVampiric = GetTime()
  end
end
