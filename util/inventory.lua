slowMounts = {"Pinto Bridle", "Brown Horse Bridle", "Chestnut Mare Bridle",
	"Brown Ram", "Gray Ram", "White Ram",
	"Reins of the Spotted Frostsaber","Reins of the Striped Frostsaber","Reins of the Striped Nightsaber",
	"Blue Mechanostrider", "Green Mechanostrider", "Red Mechanostrider", "Unpainted Mechanostrider"}

paladinMount = "Summon Warhorse"

function mountUp()
	useItemFromList(slowMounts)
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

-- use an item from the inventory to use by name
function useItem(name)
	if CursorHasItem() then return end
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				if string.find(link, name) then UseContainerItem(bag,slot) return end
			end
		end
	end
	ResetCursor()
end

-- pick up any item to use from a list of names
function useItemFromList(name_list)
	if CursorHasItem() then return end
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				for k,name in pairs(name_list) do
					if string.find(link, name) then UseContainerItem(bag,slot) return end
				end
			end
		end
	end
	ResetCursor()
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
