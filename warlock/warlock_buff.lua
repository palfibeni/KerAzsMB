-- SUCCUBUS
function warlock_buffs_succubus()
  warlockArmor()
  demonicSacrifice()
end

-- IMP
function warlock_buffs_imp()
  warlockArmor()
  summonImp()
end

function warlockBuff()
  warlockArmor()
  warlockSummon()
end

function warlockArmor()
  if UnitLevel("player") >= 20 then
    if (UnitMana("player") >= (UnitLevel("player") * 26)) then
      cast_buff_player("Spell_Shadow_RagingScream", "Demon Armor")
    else
      CastSpellByName("Life Tap")
    end
  else
    cast_buff_player("Spell_Shadow_RagingScream", "Demon Skin")
  end
end

function warlockSummon(summon)
  summon = summon or azs.class.summon
  if summon == "DS" then
    demonicSacrifice()
  else
    summonImp()
  end
end

function demonicSacrifice()
  if player_has_buff("Spell_Shadow_PsychicScream") then
    return
  end
  CastSpellByName("Demonic Sacrifice")
  if (UnitMana("player") >= (UnitLevel("player") * 22)) then
    CastSpellByName("Fel Domination")
    CastSpellByName("Summon Succubus")
  else
    CastSpellByName("Life Tap")
    end
end

function summonImp()
  if player_has_buff("Spell_Shadow_BloodBoil") then
    return
  end
  if (UnitMana("player") >= (UnitLevel("player") * 16)) then
    CastSpellByName("Fel Domination")
    CastSpellByName("Summon Imp")
  else
    CastSpellByName("Life Tap")
  end
end
