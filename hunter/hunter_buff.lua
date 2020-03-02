consumables = {"Chunk of Boar Meat", "Strigy Wolf Meat"}

function buff_pet()
    if UnitExists("pet") and not UnitIsDead("pet") then
		FeedPet()
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
