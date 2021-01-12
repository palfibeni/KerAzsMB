-- pick up an item to use by name
function pick_up_item(name)
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
function pick_up_item_from_list(name_list)
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
function use_item(name)
	if CursorHasItem() then return end
	for bag=0,4 do
		for slot = 1,GetContainerNumSlots(bag) do
			local texture = GetContainerItemInfo(bag,slot)
			if texture then
				local link = GetContainerItemLink(bag,slot)
				if string.find(link, name) then UseInventoryItem(bag,slot) return end
			end
		end
	end
	ResetCursor()
end