vampiricEnabled = false
shPainEnabled = false

lastShadowWord = 0
lastVampiric = 0

function sh_priest_skull()
  if casting_or_channeling() then return end
  if azs.targetSkull() then
    shPriestAttack()
  else
    azs.targetSkull()
    lastShadowWord = 0
    lastVampiric = 0
  end
end

function sh_priest_cross()
  if casting_or_channeling() then return end
  if azs.targetCross() then
    shPriestAttack()
  else
    azs.targetCross()
    lastShadowWord = 0
    lastVampiric = 0
  end
end

function shPriestAttack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	if casting_or_channeling() then return end
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
  if shPainEnabled and lastShadowWord + 24 < GetTime() then
    cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
    lastShadowWord = GetTime()
  end
end

function shadowVampiricEmbrace()
  if vampiricEnabled and lastVampiric + 60 < GetTime() then
    cast_debuff("Spell_Shadow_UnsummonBuilding", "Vampiric Embrace")
    lastVampiric = GetTime()
  end
end
