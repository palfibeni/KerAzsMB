holyStrikeActionSlot = 13
lastPalaDefCooldown = 0
antiInvuDebuff = "Spell_Holy_RemoveCurse"

function palaAttack()
  if player_hasBuff("Spell_Holy_Restoration") or player_hasBuff("Spell_Holy_SealOfProtection") or player_hasBuff("Spell_Holy_DivineIntervention") then
    palaHeal(azs.targetList.all, "regular")
    return
  end
  palaHeal(azs.targetList.all, "retriDangerZone")
  doPalaDefCooldown()
  paladinBuff()
  if castingOrChanneling() then return end
  if shouldPaladinStun() then
    CastSpellByName("Hammer of Justice")
  end
  if IsActionReady(holyStrikeActionSlot) and not IsCurrentAction(holyStrikeActionSlot) then
    CastSpellByName("Holy Strike(Rank 1)")
  end
  castSelectedSeal("dps")
  if UnitCreatureType("target") == "Humanoid" and not has_debuff("target", "Spell_Holy_SealOfMight") and GetSpellCooldownByName("Repentance") == 0 and GetSpellCooldownByName("Judgement") == 0 and player_hasBuff("Ability_Warrior_InnerRage") then
      CastSpellByName("Repentance")
  end
  if GetSpellCooldownByName("Judgement") == 0 and not has_debuff("target", "Spell_Holy_RighteousnessAura") then
      CastSpellByName("Judgement")
  end
  if UnitCreatureType("target") == "Undead" or UnitCreatureType("target") == "Demon" and GetSpellCooldownByName("Exorcism") == 0 then
      CastSpellByName("Exorcism")
  end
  use_autoattack()
end

function doPalaDefCooldown()
  if not UnitAffectingCombat("player") then return end
	if lastPalaDefCooldown + 6 > GetTime() then return end
  local invuSpell = getDefaultPaladinInvu()
  if isPlayerHpUnder(0.35) and GetSpellCooldownByName(invuSpell) == 0 and not has_debuff("player", antiInvuDebuff) then
    CastSpellByName(invuSpell)
    lastPalaDefCooldown = GetTime()
	elseif isPlayerHpUnder(0.35) and GetSpellCooldownByName("Blessing of Protection") == 0 and not has_debuff("player", antiInvuDebuff) then
    CastSpellByName("Blessing of Protection")
    SpellTargetUnit("player")
    lastPalaDefCooldown = GetTime()
  elseif isPlayerHpUnder(0.15) and GetSpellCooldownByName("Lay on Hands") == 0 then
    CastSpellByName("Lay on Hands")
    SpellTargetUnit("player")
		lastPalaDefCooldown = GetTime()
	elseif isPlayerHpUnder(0.15) then
		useHealthPotion()
		lastPalaDefCooldown = GetTime()
	end
end

function getDefaultPaladinInvu()
  if UnitLevel("player") >= 34 then
    return "Divine Shield"
  end
  return "Divine Protection"
end

function shouldPaladinStun()
  if getSpellId("Seal of Command") ~= -1 then
    return GetSpellCooldownByName("Judgement") == 0 and player_hasBuff("Ability_Warrior_InnerRage") and GetSpellCooldownByName("Hammer of Justice") == 0
  end
  return GetSpellCooldownByName("Hammer of Justice") == 0
end

function paladinStun()
  if not GetSpellCooldownByName("Hammer of Justice") == 0 then return end
  if not UnitAffectingCombat("player") then return end
  if not isInMeleeRange() then return end
  if isStunned("target") then return end
  CastSpellByName("Hammer of Justice")
end

-- /script judgement("light") -- "light", "wisdom", "dps"
function judgement(seal)
  if not GetSpellCooldownByName("Judgement") == 0 then return end
  if not UnitAffectingCombat("player") then return end
  if not isInMeleeRange() then return end
  if not hasJudgementApplied() and not hasSealApplied() then
    castSelectedSeal(seal)
  elseif not hasJudgementApplied() then
    CastSpellByName("Judgement")
  end
end

function hasJudgementApplied()
  return has_debuff("target", "Spell_Holy_HealingAura")
    or has_debuff("target", "Spell_Holy_RighteousnessAura")
    or has_debuff("target", "Spell_Holy_HolySmite")
end

function hasSealApplied()
  return player_hasBuff("Spell_Holy_HealingAura")
    or player_hasBuff("Spell_Holy_RighteousnessAura")
    or player_hasBuff("Ability_ThunderBolt")
    or player_hasBuff("Ability_Warrior_InnerRage")
end

function castSelectedSeal(seal)
  if seal == "light" then
    cast_buff_player("Spell_Holy_HealingAura", "Seal of Light")
  elseif seal == "wisdom" then
    cast_buff_player("Spell_Holy_RighteousnessAura", "Seal of Wisdom")
  elseif seal == "dps" then
    castDpsSeal()
  end
end

function castDpsSeal()
  if not hasJudgementApplied() and not hasSealApplied() then
    if UnitLevel("player") > 38 and isPlayerRelativeManaBelow(5) then
      cast_buff_player("Spell_Holy_RighteousnessAura", "Seal of Wisdom")
    elseif not player_hasBuff("Spell_Holy_RighteousnessAura") then
      cast_buff_player("Spell_Holy_HolySmite", "Seal of the Crusader")
    end
  elseif getSpellId("Seal of Command") ~= -1 and not has_debuff("target", "Spell_Holy_RighteousnessAura") then
    cast_buff_player("Ability_Warrior_InnerRage", "Seal of Command")
  else
    cast_buff_player("Ability_ThunderBolt", "Seal of Righteousness")
  end
end

function castConsecration()
  if GetSpellCooldownByName("Consecration") == 0 then
    CastSpellByName("Consecration")
  end
end
