consumables = {"Roasted Quail", "Homemade Cherry Pie", "Tender Wolf Meat", "Red Wolf Meat", "Mystery Meat",
  "Raptor Flesh", "Tiger Meat", "Lean Wolf Flank", "Boar Ribs", "Goretusk Liver",
  "Chunk of Boar Meat", "Stringy Wolf Meat", "Mutton Chop"}

function hunterBuff(shouldHunterBuffPet)
  local shouldHunterBuffPet = shouldHunterBuffPet or azs.class.shouldHunterBuffPet
  if UnitExists("pet") or shouldHunterBuffPet then
    hunterBuffPet()
  end
  cast_buff_player("Ability_TrueShot", "Trueshot Aura")
end

function hunterBuffPet()
  if UnitExists("pet") and not UnitIsDead("pet") then
		feedPet()
	else
		CastSpellByName("Call Pet")
		CastSpellByName("Revive Pet")
  end
end

function feedPet()
	if GetPetHappiness()~=nil and GetPetHappiness()~=3 then
		if not hasBuff("pet", "Ability_Hunter_BeastTraining") then
			CastSpellByName("Feed Pet")
			pickUpItemFromList(consumables)
		end
	end
	ResetCursor()
end
