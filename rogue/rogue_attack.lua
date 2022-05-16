function rogueAttack(params)
  local weaponType = params.weapon or azs.class.weapon
  local mainRole = params.mainRole or azs.class.mainRole
  if player_hasBuff("Ability_Stealth") then
    CastSpellByName("Cheap shot")
  else
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
end

function spendComboPoints(mainRole)
  local mainRole = mainRole or "Damage"
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
    if useTrinkets() then return end
    CastSpellByName("Blade Flurry")
    CastSpellByName("Adrenaline Rush")
	  useRacials()
  end
end
