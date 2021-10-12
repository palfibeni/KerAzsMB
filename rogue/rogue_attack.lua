function rogueAttack(params)
  weaponType = params.weapon or azs.class.weapon
  mainRole = params.mainRole or azs.class.mainRole
  burstDmg()
  if (GetComboPoints("target") > 1 ) then
    spendComboPoints(mainRole)
  else
    if weaponType == "Sword" then
      CastSpellByName("Sinister Strike")
    else
      CastSpellByName("Backstab")
    end
  end
  use_autoattack()
end

function spendComboPoints(mainRole)
  mainRole = mainRole or "Damage"
  if mainRole == "Damage" then
    cast_buff_player("Ability_Rogue_SliceDice", "Slice and Dice")
    if (GetComboPoints("target") == 5) then
      CastSpellByName("Eviscerate")
    end
  else
    CastSpellByName("Kidney Shot")
  end
end

function burstDmg()
  if GetComboPoints("target") >= 1 and isTargetHpUnder(0.7) then
    CastSpellByName("Blade Flurry")
    CastSpellByName("Adrenaline Rush")
    UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
    UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
  end
end

function rouge_attack_skull()
    if azs.targetSkull() then
        rogueAttack("Sword")
    else
        stop_autoattack()
    end
end

function rouge_attack_cross()
    if azs.targetCross() then
        rogueAttack("Sword")
    else
        stop_autoattack()
    end
end

function rouge_attack_dagger_skull()
    if azs.targetSkull() then
        rogueAttack("Dagger")
    else
        stop_autoattack()
    end
end

function rouge_attack_dagger_cross()
    if azs.targetSkull() then
        rogueAttack("Dagger")
    else
        stop_autoattack()
    end
end
