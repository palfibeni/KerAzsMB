blacklistedMages = {}

-- /script mageWater()
function mageWater(minimumAmount, waterType)
  if casting_or_channeling() then return end
  minimumAmount = minimumAmount or 20
  waterType = waterType or deduceWaterType()
  if count_item(waterType) < minimumAmount then
    if UnitMana("player") >= (UnitLevel("player") * 13) then
      CastSpellByName("Conjure Water")
    elseif IsActionReady(evocationActionSlot) then
      CastSpellByName("Evocation")
    else
      use_item(deduceWaterType())
    end
  end
end


function offerMageWater(waterType)
  if not TradeFrame:IsShown() then return end
  waterType = waterType or deduceWaterType()
  use_item(waterType)
  AcceptTrade()
end

function askMageWater(minimumAmount, waterType)
  minimumAmount = minimumAmount or 10
  waterType = waterType or deduceWaterType()
  if count_item(waterType) >= minimumAmount then return end
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
  exact_target_by_name(name)
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
