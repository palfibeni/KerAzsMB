function warlockBuff(summon)
  warlockArmor()
  warlockSummon(summon)
end

function warlockArmor()
  if UnitLevel("player") >= 20 then
    if (isPlayerRelativeManaAbove(26)) then
      cast_buff_player("Spell_Shadow_RagingScream", "Demon Armor")
    else
      CastSpellByName("Life Tap")
    end
  else
    cast_buff_player("Spell_Shadow_RagingScream", "Demon Skin")
  end
end

function warlockSummon(summon)
  local summon = summon or azs.class.summon
  if summon == "DS" then
    demonicSacrifice()
  else
    summonImp()
  end
end

function demonicSacrifice()
  if player_hasBuff("Spell_Shadow_PsychicScream") then
    return
  end
  if UnitExists("pet") then
    CastSpellByName("Demonic Sacrifice")
  elseif (isPlayerRelativeManaAbove(22)) then
    CastSpellByName("Fel Domination")
    CastSpellByName("Summon Succubus")
  else
    CastSpellByName("Life Tap")
    end
end

function summonImp()
  if player_hasBuff("Spell_Shadow_BloodBoil") then
    return
  end
  if isPlayerRelativeManaAbove(16) then
    CastSpellByName("Fel Domination")
    CastSpellByName("Summon Imp")
  else
    CastSpellByName("Life Tap")
  end
end

function unendingBreath()
  buffTargetList("Spell_Shadow_DemonBreath", "Unending Breath")
end

function detectInvisibility()
  buffTargetList("Spell_Shadow_DetectInvisibility", "Detect Invisibility")
end
