function catAttack()
  druid_cat_form()
	feralFaerieFire()
  if (UnitMana("player") >= 35 and GetComboPoints("target") == 5) then
      CastSpellByName("Ferocious Bite")
  elseif (UnitMana("player") >= 48) then
      CastSpellByName("Shred")
  end
  -- in case of not behind the enemy
  if (GetComboPoints("target") == 0 and UnitMana("player") >= 80) then
      CastSpellByName("Claw")
  end
end

function druid_cat_form()
	local icon, name, active, castable = GetShapeshiftFormInfo(3);
	if not active then
    CastSpellByName("Cat Form")
	end
end
