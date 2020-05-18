function priest_heal_raid()
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and not isdead and UnitIsConnected("raid"..i) then
			TargetByName(name)
            priest_heal_dps_downgrade()
		end
	end
end

function priest_heal_raid_reverse()
    for i=GetNumRaidMembers(),1,-1 do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and not isdead and UnitIsConnected("raid"..i) then
			TargetByName(name)
            priest_heal_dps_downgrade()
		end
	end
end

function priest_heal_dps_downgrade()
    if casting_or_channeling() then return end
    if UnitIsDead("target") then return end
    priest_dispel()
    heal_under_percent(0.5, "Flash Heal(Rank 4)")
end
