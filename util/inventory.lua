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
aqMounts = {"Yellow Qiraji Resonating Crystal", "Blue Qiraji Resonating Crystal", "Green Qiraji Resonating Crystal", "Red Qiraji Resonating Crystal"}
wizardOils = {"Brilliant Wizard Oil", "Wizard Oil", "Lesser Wizard Oil"}
manaOils = {"Brilliant Mana Oil", "Mana Oil", "Lesser Mana Oil"}
poisons = {"Instant Poison", "Deadly Poison"}
sharpeningStones = {"Sharpening Stone"}
weightStones = {"Elemental Sharpening Stone", "Weightstone"}
manaPotions = {"Major Mana Potion", "Superior Mana Potion", "Greater Mana Potion", "Mana Potion", "Lesser Mana Potion", "Minor Mana Potion"}
healthPotions = {"Major Healing Potion", "Superior Healing Potion", "Greater Healing Potion", "Healing Potion", "Lesser Healing Potion", "Minor Healing Potion"}
manaRunes = {"Demonic Rune", "Dark Rune"}
-- Flask of Titans = Interface\Icons\INV_Potion_62
-- Flask of Distilled Wisdom = Interface\Icons\INV_Potion_97
-- Flask of Supreme Power = Interface\Icons\INV_Potion_41
--
-- Elixir of the Mongoose = Interface\Icons\INV_Potion_32
-- Elixir of Fortitude = Interface\Icons\INV_Potion_44
--
-- Juju Power = Interface\Icons\INV_Misc_MonsterScales_11
-- Juju Might = Interface\Icons\INV_Misc_MonsterScales_07
-- Juju Ember = Interface\Icons\INV_Misc_MonsterScales_15
-- Juju Flurry = Interface\Icons\INV_Misc_MonsterScales_17
--
-- Blessed Sunfruit = Interface\Icons\Spell_Holy_Devotion
-- Blessed Sunfruit Juice = Interface\Icons\Spell_Holy_LayOnHands
--
-- Greater Arcane Elixir = Interface\Icons\INV_Potion_25
-- Mageblood Potion = Interface\Icons\INV_Potion_45
-- Elixir of Greater Firepower = Interface\Icons\INV_Potion_60
-- Elixir of Shadow Power = Interface\Icons\INV_Potion_46

function mountUp()
	if isInAQ40() then
		useItemFromList(aqMounts)
		return
	end
	local bag,slot
	if not IsShiftKeyDown() and UnitLevel("player") == 60 then
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
	elseif not IsShiftKeyDown() and UnitClass("player") == "Paladin" then
		if getSpellId("Summon Charger") ~= -1 then
			CastSpellByName("Summon Charger")
		else
			CastSpellByName("Summon Warhorse")
		end
	elseif not IsShiftKeyDown() and UnitClass("player") == "Warlock" then
		if getSpellId("Summon Dreadsteed") ~= -1 then
			CastSpellByName("Summon Dreadsteed")
		else
			CastSpellByName("Summon Felsteed")
		end
	else
		if UnitFactionGroup("player") == "Alliance" then
			useItemFromList(slowMounts)
		else
			useItemFromList(hslowMounts)
		end
	end
end

function useHealthPotion()
	useItemFromList(healthPotions)
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

function applyWeaponEnchantBasedOnClass()
	if not isInProgressRaid() then return end
	local class = UnitClass("player")
	if class == "Warrior" then
		applySharpeningStone()
	elseif class == "Mage" or class == "Warlock" or (class == "Druid" and azs.class.talent == DRUID_BALANCE) then
		applyWizardOil()
	elseif class == "Rogue" then
		applyPoisons()
	elseif class == "Paladin" or class == "Priest" or (class == "Druid" and azs.class.talent == DRUID_RESTO) then
		applyManaOil()
	end
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

function applySharpeningStone()
	if isWeaponBlunt("MainHandSlot") then
		applyEnchantsToWeapon(weightStones, 16)
	else applyEnchantsToWeapon(sharpeningStones, 16) end
	if isWeaponBlunt("SecondaryHandSlot") then
		applyEnchantsToWeapon(weightStones, 17)
	else applyEnchantsToWeapon(sharpeningStones, 17) end
end

function applyEnchantToWeapon(name, weaponSlot)
	local weaponSlot = weaponSlot or 16 -- can be 17 for offhand
	if not hasWeaponEnchant(weaponSlot) and not TradeFrame:IsShown() then
		useItem(name)
		PickupInventoryItem(weaponSlot)
		ClearCursor()
	end
end

function applyEnchantsToWeapon(names, weaponSlot)
	local weaponSlot = weaponSlot or 16 -- can be 17 for offhand
	if not hasWeaponEnchant(weaponSlot) and not TradeFrame:IsShown() then
		useItemFromList(names)
		PickupInventoryItem(weaponSlot)
		ClearCursor()
	end
end

function hasWeaponEnchant(weaponSlot)
	local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
	return (weaponSlot == 16 and hasMainHandEnchant) or (weaponSlot == 17 and hasOffHandEnchant)
end

function isWeaponBlunt(slot)
	local _, _, _, _, _, subType = getWeaponAttributes(slot)
	if string.find(subType, "Mace") or string.find(subType, "Staff") then
		return true
	end
	return false
end

-- Returns name, link, rarity, level, type, subType
-- slot example: "MainHandSlot" "SecondaryHandSlot"
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
	local count = 0;
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

function equipItemByItemname(itemName,invSlotId)
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local item=GetContainerItemLink(bag,slot)
				if string.find(item, itemName) then
					PickupContainerItem(bag,slot)
					EquipCursorItem(invSlotId)
				end
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
