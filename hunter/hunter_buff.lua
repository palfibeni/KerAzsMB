consumables = {"Mystery Meat", "Tiger Meat" "Lean Wolf Flank", "Boar Ribs",
    "Goretusk Liver", "Chunk of Boar Meat", "Stringy Wolf Meat"}

function buff_pet()
    if UnitExists("pet") and not UnitIsDead("pet") then
		feed_pet()
	else
		cast("Call Pet")
		cast("Revive Pet")
    end
end

function feed_pet()
	if GetPetHappiness()~=nil and GetPetHappiness()~=3 then
		if not has_buff("pet", "Ability_Hunter_BeastTraining") then
			cast("Feed Pet")
			pick_up_item_from_list(consumables)
		end
	end
	ResetCursor()
end
