function HandleEvents()
  if event=="PLAYER_ENTERING_WORLD" or event=="RAID_ROSTER_UPDATE" and UnitInRaid("player") or event=="PARTY_MEMBERS_CHANGED" and not UnitInRaid("player") then
    HandleGroupManagementEvent()
  else
		if not UnitClass("player") == "Priest" and not UnitClass("player") == "Paladin" and not UnitClass("player") == "Druid" and not UnitClass("player") == "Mage" then return end
    HandleHealingEvent()
  end
end
