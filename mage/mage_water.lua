blacklistedMages = {}

-- /script mageWater()
function mageWater()
  if casting_or_channeling() then return end
  if count_item("Conjured Crystal Water") < 39 then
    if UnitMana("player") >= 780 then
      CastSpellByName("Conjure Water")
    elseif IsActionReady(evocationActionSlot) then
      CastSpellByName("Evocation")
    else
      use_item("Conjured Crystal Water")
    end
  end
end

function offerMageWater()
  if not TradeFrame:IsShown() then return end
  use_item("Conjured Crystal Water")
  AcceptTrade()
end

function askMageWater()
  if count_item("Conjured Crystal Water") > 3 then return end

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
    end
  end
end

function askMageWaterGroup()
  for i=1,GetNumPartyMembers() do
    local name = UnitClass("party"..i)
    if name == "Unknown" then return end
    local class = UnitClass("party"..i)
    if UnitIsConnected("party"..i) and class == "Mage" and not isBlacklistedMage(name) then
      tradeForWaterByName(name)
    end
  end
end

function tradeForWaterByName(name)
  TargetByName(name)
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
