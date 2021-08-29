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
