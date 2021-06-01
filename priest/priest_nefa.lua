priestClassCallExpire = nil

classCallPrefixes={
	druid="Druids",hunter="Hunters",mage="Mages",priest="Priests",paladin="Paladins",
	rogue="Rogues",shaman="Shamans",warrior="Warriors",warlock="Warlocks"
}

local f = CreateFrame("FRAME", "PriestNefaFrame")
f:RegisterEvent("CHAT_MSG_MONSTER_YELL")

function PriestNefaEventHandler()
  if not UnitClass("player") == "Priest" then return end
  if event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, classCallPrefixes.priest, 1, 1) then
    priestClassCallExpire = GetTime() + 30
  end
end

f:SetScript("OnEvent", PriestNefaEventHandler)
