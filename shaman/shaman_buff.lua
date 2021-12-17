function shamanBuff(earthTotem)
  cast_buff_player("Spell_Nature_LightningShield", "Lightning Shield")
  cast_buff_player("Spell_Nature_Rockbiter", "Rockbiter Weapon")
  if earthTotem == "STR" then
    cast_buff_player("Spell_Nature_EarthBindTotem", "Strength of Earth Totem")
  end
end

function castShamanTotems()
  if not (has_player_buff("Spell_Nature_Manaregentotem")) then
		CastSpellByName("Mana Spring Totem")
	end
	if not (has_player_buff("Spell_Nature_Stoneskintotem")) then
		CastSpellByName("Stoneskin Totem")
	end
	if not (has_player_buff("Spell_Nautre_Invisibilitytotem")) then
		CastSpellByName("Grace of Air Totem")
	end
end
