function rogueAttack(weaponType)
  weaponType = weaponType or azs.class.weapon
  burstDmg()
  if (GetComboPoints("target") > 1 ) then
    cast_buff_player("Ability_Rogue_SliceDice", "Slice and Dice")
  end
  if (GetComboPoints("target") == 5) then
    CastSpellByName("Eviscerate")
  else
    if azs.class.weapon == "Sword" then
      CastSpellByName("Sinister Strike")
    else
      CastSpellByName("Backstab")
    end
  end
  use_autoattack()
end

function burstDmg()
  if (GetComboPoints("target") >= 1) then
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
        rouge_attack("Sword")
    else
        stop_autoattack()
    end
end

function rouge_attack_dagger_skull()
    if azs.targetSkull() then
        rouge_dagger_attack("Dagger")
    else
        stop_autoattack()
    end
end

function rouge_attack_dagger_cross()
    if azs.targetSkull() then
        rouge_dagger_attack("Dagger")
    else
        stop_autoattack()
    end
end
