lastShadowWord = 0
lastVampiric = 0

function shPriestAttack()
	if castingOrChanneling() then return end
  if (UnitMana("player")>=221) then
    stop_wand()
    cast_buff_player("Spell_Shadow_Shadowform", "Shadowform")
    shadowWordPain()
    shadowVampiricEmbrace()
    CastSpellByName("Mind Blast")
    CastSpellByName("Mind Flay")
  else
    use_wand()
  end
end

function shadowWordPain()
  if azs.class.shPainEnabled and lastShadowWord + 24 < GetTime() then
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
    lastShadowWord = GetTime()
  end
end

function shadowVampiricEmbrace()
  if azs.class.vampiricEnabled and lastVampiric + 60 < GetTime() then
    cast_debuff("Spell_Shadow_UnsummonBuilding", "Vampiric Embrace")
    lastVampiric = GetTime()
  end
end
