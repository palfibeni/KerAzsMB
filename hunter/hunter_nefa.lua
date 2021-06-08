engagePrefix="Well done"
nextClassCall = nil
hunterWeaponLink = nil

unequipTime = 2.5
reequipTime = 1
timeoutTime = 5

classCallPrefixes={
	druid="Druids",hunter="Hunters",mage="Mages",priest="Priests",paladin="Paladins",
	rogue="Rogues",shaman="Shamans",warrior="Warriors",warlock="Warlocks"
}

local f = CreateFrame("FRAME", "HunterNefaFrame")
f:RegisterEvent("CHAT_MSG_MONSTER_YELL")

function NefaEventHandlerHunter()
  if not UnitClass("player") == "Hunter" then return end
  if event == "CHAT_MSG_MONSTER_YELL" then
    if string.find(arg1, engagePrefix, 1, 1) then
      hunterWeaponLink = GetInventoryItemLink("player",18)
      nextClassCall = GetTime() + 35
    else
      local called = false
      for _,callPrefix in classCallPrefixes do
        called = string.find(arg1, callPrefix, 1, 1)
        if called then
          nextClassCall=GetTime() + 25
          break
        end
      end
    end
  end
end

f:SetScript("OnEvent", NefaEventHandlerHunter)

function handleNefaCallHunter()
  if not nextClassCall then return end
	local t = GetTime()
	hunterWeaponLink = GetInventoryItemLink("player",18) or hunterWeaponLink
	if nextClassCall + 10 + timeoutTime <= t then
		equipItemByItemLink(hunterWeaponLink,18)
		nextClassCall = nil
	elseif nextClassCall- unequipTime <= t then
		unequipItemBySlotId(18)
	elseif nextClassCall - 25 + reequipTime <= t then
		equipItemByItemLink(hunterWeaponLink, 18)
	end
end
