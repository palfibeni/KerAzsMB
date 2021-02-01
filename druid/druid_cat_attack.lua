function cat_attack_skull()
    if is_target_skull() then
        cat_attack()
    else
        stop_autoattack()
        target_skull()
    end
end

function cat_attack_cross()
    if is_target_cross() then
        cat_attack()
    else
        stop_autoattack()
        target_cross()
    end
end

function cat_attack()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
    stop_autoattack()
		return
	end
  if (GetComboPoints("target") == 5) then
      CastSpellByName("Ferocious Bite")
  else
      CastSpellByName("Shred")
  end
  -- in case of not behind the enemy
  if (GetComboPoints("target") == 0) then
      CastSpellByName("Claw")
  end
end
