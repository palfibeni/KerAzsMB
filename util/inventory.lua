slowMounts = {"Pinto Bridle", "Brown Horse Bridle", "Chestnut Mare Bridle",
	"Brown Ram", "Gray Ram", "White Ram",
	"Reins of the Spotted Frostsaber","Reins of the Striped Frostsaber","Reins of the Striped Nightsaber",
	"Blue Mechanostrider", "Green Mechanostrider", "Red Mechanostrider", "Unpainted Mechanostrider"}
fastMounts = {"Black War Ram", "Black Battlestrider", "Reins of the Black War Tiger", "Black War Steed Bridle",
	"Swift Razzashi Raptor", "Swift Brown Steed", "Swift Palomino", "Swift White Steed",
	"Swift Brown Ram", "Swift Gray Ram", "Swift White Ram",
	"Reins of the Swift Frostsaber", "Reins of the Swift Mistsaber", "Reins of the Swift Stormsaber",
	"Swift Green Mechanostrider", "Swift White Mechanostrider", "Swift Yellow Mechanostrider"
}
hslowMounts = {"Horn of the Brown Wolf", "Horn of the Dire Wolf", "Horn of the Timber Wolf",
	"Blue Skeletal Horse", "Brown Skeletal Horse", "Red Skeletal Horse",
	"Brown Kodo", "Gray Kodo",
	"Whistle of the Emerald Raptor", "Whistle of the Turquoise Raptor", "Whistle of the Violet Raptor"}
hfastMounts = {"Horn of the Black War Wolf", "Red Skeletal Warhorse", "Black War Kodo", "Whistle of the Black War Raptor",
	"Swift Razzashi Raptor", "Horn of the Swift Brown Wolf", "Horn of the Swift Gray Wolf", "Horn of the Swift Timber Wolf",
	"Green Skeletal Warhorse", "Purple Skeletal Warhorse",
	"Great Brown Kodo", "Great Gray Kodo", "Great White Kodo",
	"Swift Blue Raptor", "Swift Olive Raptor", "Swift Orange Raptor"
}
wizardOils = {"Brilliant Wizard Oil", "Wizard Oil", "Lesser Wizard Oil"}
manaOils = {"Brilliant Mana Oil", "Mana Oil", "Lesser Mana Oil"}
poisons = {"Instant Poison", "Deadly Poison"}
manaPotions = {"Superior Mana Potion", "Major Mana Potion"}
manaRunes = {"Demonic Rune", "Dark Rune"}

function mountUp()
	local bag,slot
	if UnitLevel("player") == 60 then
		if UnitFactionGroup("player") == "Alliance" then
			bag,slot = findItemFromListInInventory(fastMounts)
		else
			bag,slot = findItemFromListInInventory(hfastMounts)
		end
	end
	if bag ~= nil and slot ~= nil then
		if CursorHasItem() then return end
		UseContainerItem(bag,slot)
		ResetCursor()
	elseif UnitClass("player") == "Paladin" then
		CastSpellByName("Summon Warhorse")
	elseif UnitClass("player") == "Warlock" then
		CastSpellByName("Summon Felsteed")
	else
		if UnitFactionGroup("player") == "Alliance" then
			useItemFromList(slowMounts)
		else
			useItemFromList(hslowMounts)
		end
	end
end

function useTrinkets()
	local trinket0CD, _, trinket0Usable = GetInventoryItemCooldown("player", 13)
	if trinket0Usable == 1 and trinket0CD == 0 then
		UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
		return true;
	end
	local trinket1CD, _, trinket1Usable = GetInventoryItemCooldown("player", 14)
  if trinket1Usable == 1 and trinket1CD == 0 then
		UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		return true;
	end
	return false;
end

function applyWizardOil()
	applyEnchantsToWeapon(wizardOils)
end

function applyManaOil()
	applyEnchantsToWeapon(manaOils)
end

function applyPoisons()
	applyEnchantsToWeapon(poisons, 16)
	applyEnchantsToWeapon(poisons, 17)
end

function applyEnchantToWeapon(name, weaponSlot)
	weaponSlot = weaponSlot or 16 -- can be 17 for offhand
	if not hasWeaponEnchant(weaponSlot) and not TradeFrame:IsShown() then
		useItem(name)
		PickupInventoryItem(weaponSlot)
		ClearCursor()
	end
end

function applyEnchantsToWeapon(names, weaponSlot)
	weaponSlot = weaponSlot or 16 -- can be 17 for offhand
	if not hasWeaponEnchant(weaponSlot) and not TradeFrame:IsShown() then
		useItemFromList(names)
		PickupInventoryItem(weaponSlot)
		ClearCursor()
	end
end


function hasWeaponEnchant(weaponSlot)
	hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
	return (weaponSlot == 16 and hasMainHandEnchant) or (weaponSlot == 17 and hasOffHandEnchant)
end

-- Returns name, link, rarity, level, type, subType
-- slot example: "MainHandSlot"
function getWeaponAttributes(slot)
	local mainHandLink = GetInventoryItemLink("player", GetInventorySlotInfo(slot))
	local _, _, id  = strfind(mainHandLink, "item:(%d+):")
	local name, link, rarity, level, type, subType = GetItemInfo(id)
	return name, link, rarity, level, type, subType;
end

-- pick up an item to use by name
function pickUpItem(name)
	if CursorHasItem() then return end
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				if string.find(link, name) then PickupContainerItem(bag,slot) return end
			end
		end
	end
	ResetCursor()
end

-- pick up any item to use from a list of names
function pickUpItemFromList(name_list)
	if CursorHasItem() then return end
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				for k,name in pairs(name_list) do
					if string.find(link, name) then PickupContainerItem(bag,slot) return end
				end
			end
		end
	end
	ResetCursor()
end

-- use an item from the inventory by name
function useItem(name)
	if CursorHasItem() then return end
	local bag,slot = findItemInInventory(name)
	if bag ~= nil and slot ~= nil and GetContainerItemCooldown(bag,slot) == 0 then
		UseContainerItem(bag,slot)
	end
	ResetCursor()
end

-- find an item in the inventory by name
function findItemInInventory(name)
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				if string.find(link, name) then
					return bag,slot
				end
			end
		end
	end
	return nil
end

-- pick up any item to use from a list of names
function useItemFromList(name_list)
	if CursorHasItem() then return end
	local bag,slot = findItemFromListInInventory(name_list)
	if bag ~= nil and slot ~= nil then
		UseContainerItem(bag,slot)
	end
	ResetCursor()
end

-- find an item in the inventory from a list of names
function findItemFromListInInventory(name_list)
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				for k,name in pairs(name_list) do
					if string.find(link, name) then
						return bag,slot
					end
				end
			end
		end
	end
	return nil
end

-- use an item from the inventory to use by name
-- /script azs.debug(countItem("Conjured Crystal Water"))
function countItem(name)
	count = 0;
	if CursorHasItem() then return end
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local icon, itemCount = GetContainerItemInfo(bag,slot)
			if icon then
				local link = GetContainerItemLink(bag,slot)
				if string.find(link, name) then count = count + itemCount end
			end
		end
	end
	return count;
end

function equipItemByItemLink(itemLink,invSlotId)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local item=GetContainerItemLink(bag,slot)
			if item==itemLink then
				PickupContainerItem(bag,slot)
				EquipCursorItem(invSlotId)
			end
		end
	end
end

function unequipItemBySlotId(invSlotId)
	local itemLink=GetInventoryItemLink("player",invSlotId)
	if itemLink then
		PickupInventoryItem(invSlotId)
		PutItemInBackpack()
		return itemLink
	end
end
