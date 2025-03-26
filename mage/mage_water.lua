blacklistedMages = {}

mageWaters = {"Conjured Crystal Water", "Conjured Sparkling Water", "Conjured Mineral Water",
  "Conjured Spring Water", "Conjured Purified Water", "Conjured Fresh Water", "Conjured Water" }
mageWaterIcons = {"INV_Drink_18", "INV_Drink_11", "INV_Drink_09", "INV_Drink_10",
  "INV_Drink_Milk_02", "INV_Drink_07", "INV_Drink_06"}

-- /script mageWater(20, "Conjured Sparkling Water")
function mageWater(minimumAmount, waterType)
  if castingOrChanneling() then return end
  local minimumAmount = minimumAmount or 20
  local waterType = waterType or deduceWaterType()
  if countItem(waterType) < minimumAmount then
    if isPlayerRelativeManaAbove(13) then
      CastSpellByName("Conjure Water")
    else
      drinkMageWater()
    end
  end
end

-- /script azs.debug(player_hasBuff("INV_Drink_06"))
-- /script azs.debug(hasBuffFromList("player", mageWaterIcons))

function drinkMageWater(percent)
  if UnitAffectingCombat("player") then return end
  local percent = percent or 0.5
  if isPlayerManaUnder(percent) and not hasBuffFromList("player", mageWaterIcons) then
    useItemFromList(mageWaters)
  end
end

-- /script offerMageWater("Conjured Sparkling Water")
function offerMageWater(waterType)
  if not TradeFrame:IsShown() then return end
  local waterType = waterType or deduceWaterType()
  useItem(waterType)
  AcceptTrade()
end

-- /script askMageWater(10, "Conjured Sparkling Water")
function askMageWater(minimumAmount, waterType)
  local minimumAmount = minimumAmount or 10
  local waterType = waterType or deduceWaterType()
  if countItem(waterType) >= minimumAmount then return end
  if TradeFrame:IsShown() then
    AcceptTrade()
  end
  if UnitInRaid("player") then
  	askMageWaterRaid()
  else
    askMageWaterGroup()
  end
end

function askMageWaterRaid()
  for i=1,GetNumRaidMembers() do
    local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
    if name == "Unknown" then return end
    if UnitIsConnected("raid"..i) and class == "Mage" and not isBlacklistedMage(name) then
      tradeForWaterByName(name)
      return
    end
  end
end

function askMageWaterGroup()
  for i=1,GetNumPartyMembers() do
    local name = UnitName("party"..i)
    if name == "Unknown" then return end
    local class = UnitClass("party"..i)
    if UnitIsConnected("party"..i) and class == "Mage" and not isBlacklistedMage(name) then
      tradeForWaterByName(name)
      return
    end
  end
end

function tradeForWaterByName(name)
  exactTargetByName(name)
  InitiateTrade("target")
  if TradeFrame:IsShown() then
    return
  else
    blacklistedMages[name] = GetTime()
  end
end

function isBlacklistedMage(name)
  if blacklistedMages[name] == nil then return false end
  if blacklistedMages[name] + 5 < GetTime() then
    blacklistedMages[name] = nil
    return false
  else
    return true
  end
end

function deduceWaterType()
  if UnitLevel("player") == 60 then return "Conjured Crystal Water" end
  if UnitLevel("player") < 10 then return "Conjured Water" end
  if UnitLevel("player") < 20 then return "Conjured Fresh Water" end
  if UnitLevel("player") < 30 then return "Conjured Purified Water" end
  if UnitLevel("player") < 40 then return "Conjured Spring Water" end
  if UnitLevel("player") < 50 then return "Conjured Mineral Water" end
  if UnitLevel("player") < 60 then return "Conjured Sparkling Water" end
end
