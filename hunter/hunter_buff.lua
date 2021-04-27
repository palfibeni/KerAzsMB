consumables = {"Tender Wolf Meat", "Red Wolf Meat", "Mystery Meat", "Raptor Flesh", "Tiger Meat",
    "Lean Wolf Flank", "Boar Ribs", "Goretusk Liver", "Chunk of Boar Meat",
    "Stringy Wolf Meat"}

function buff_pet()
  if UnitExists("pet") and not UnitIsDead("pet") then
		feed_pet()
	else
		CastSpellByName("Call Pet")
		CastSpellByName("Revive Pet")
  end
  cast_buff_player("Ability_TrueShot", "Trueshot Aura")
end

function feed_pet()
	if GetPetHappiness()~=nil and GetPetHappiness()~=3 then
		if not has_buff("pet", "Ability_Hunter_BeastTraining") then
			CastSpellByName("Feed Pet")
			pick_up_item_from_list(consumables)
		end
	end
	ResetCursor()
end
