function pala_attack_cross()
  if azs.targetSkull() then
      pala_attack()
  else
      stop_autoattack()
  end
end

function pala_attack_skull()
  if azs.targetCross() then
      pala_attack()
  else
      stop_autoattack()
  end
end

function pala_attack()
  CastSpellByName("Hammer of Justice")
  cast_buff_player("Spell_Holy_HolySmite", "Seal of the crusader")
  if UnitCreatureType("target") == "Undead" or UnitCreatureType("target") == "Demon" then
		CastSpellByName("Exorcism")
		CastSpellByName("Holy Wrath")
	end
  use_autoattack()
end
