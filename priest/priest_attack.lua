function priestAttack()
  if (UnitMana("player")>=221) then
    stop_wand()
    shadowWordPain()
    CastSpellByName("Mind Blast")
    CastSpellByName("Smite")
  else
    use_wand()
  end
end

function shadowWordPain()
  cast_debuff("Spell_Shadow_ShadowWordPain", "Shadow Word: Pain")
end
