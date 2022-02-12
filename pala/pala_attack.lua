holyStrikeActionSlot = 13
lastPalaDefCooldown = 0
antiInvuDebuff = "Spell_Holy_RemoveCurse"

function pala_attack()
  if player_hasBuff("Spell_Holy_Restoration") or player_hasBuff("Spell_Holy_SealOfProtection") or player_hasBuff("Spell_Holy_DivineIntervention") then
    palaHeal()
    return
  end
  doPalaDefCooldown()
  --paladinBuff()
  --castBuff("Spell_Nature_LightningShield", "Blessing of Sanctuary", "player")
  --castBuff("Spell_Magic_MageArmor", "Blessing of Kings", "player")
  castBuff("Spell_Holy_SealOfWisdom", "Blessing of Wisdom", "player")
  buffPlayer("Spell_Holy_SealOfWisdom", "Blessing of Wisdom", "Neiva")
  buffPlayer("Spell_Holy_SealOfWisdom", "Blessing of Wisdom", "Medikit")
  --buffTargetListExceptList("Spell_Holy_SealOfSalvation", "Blessing of Salvation", {"Thinarms", "Neiva", "Medikit"})
   --buffTargetList("Spell_Magic_MageArmor", "Blessing of Kings")
--  castBuff("Spell_Holy_FistOfJustice", "Blessing of Might", "player")
  if castingOrChanneling() then return end
  if GetSpellCooldownByName("Hammer of Justice") == 0 then
    CastSpellByName("Hammer of Justice")
  end
  if not has_debuff("target", "Spell_Holy_HealingAura") and not has_debuff("target", "Spell_Holy_RighteousnessAura")
  and not has_debuff("target", "Spell_Holy_HolySmite") and not player_hasBuff("Ability_ThunderBolt") then
    cast_buff_player("Spell_Holy_HolySmite", "Seal of the Crusader")
  else
    -- cast_buff_player("Ability_Warrior_InnerRage", "Seal of Command")
    cast_buff_player("Ability_ThunderBolt", "Seal of Righteousness")
  end
  if GetSpellCooldownByName("Holy Strike") == 0 and not IsCurrentAction(heroicStrikeActionSlot) then
      CastSpellByName("Holy Strike(Rank 1)")
  end
  if UnitCreatureType("target") == "Undead" or UnitCreatureType("target") == "Demon" and GetSpellCooldownByName("Exorcism") == 0 then
      CastSpellByName("Exorcism")
  end
  if GetSpellCooldownByName("Judgement") == 0 then
      CastSpellByName("Judgement")
  end
  use_autoattack()
end

function doPalaDefCooldown()
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
		useItemFromList({"Minor Healing Potion", "Lesser Healing Potion", "Healing Potion", "Greater Healing Potion", "Superior Healing Potion", "Major Healing Potion"})
		lastPalaDefCooldown = GetTime()
	end
end

function getDefaultPaladinInvu()
  if UnitLevel("player") >= 34 then
    return "Divine Shield"
  end
  return "Divine Protection"
end

function buffPlayerWithBless(icon, spell, playerName)
	playerName = playerName or UnitName("target")
	if not azs.targetList[playerName] then return end
	for target,info in pairs(azs.targetList[playerName]) do
		if not hasBuff(target, "Spell_Holy_SealOfProtection") then
			castBuff(icon, spell, target)
		end
	end
end
