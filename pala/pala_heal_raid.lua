function pala_heal_raid()
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and not isdead and UnitIsConnected("raid"..i) then
			TargetByName(name)
            pala_heal_dps_downgrade()
		end
	end
end

function pala_heal_raid_reverse()
    for i=GetNumRaidMembers(),1,-1 do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and not isdead and UnitIsConnected("raid"..i) then
			TargetByName(name)
            pala_heal_dps_downgrade()
		end
	end
end

function pala_heal_raid_from_group5()
	pala_heal_raid(21, 40)
	pala_heal_raid(1, 20)
end

function pala_heal_raid(start, last)
	for i=start,last do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and not isdead and UnitIsConnected("raid"..i) then
			TargetByName(name)
            pala_heal_dps_downgrade()
		end
	end
end

function pala_heal_dps_downgrade()
    if casting_or_channeling() then return end
    if UnitIsDead("target") then return end
    pala_cleanse()
    heal_under_percent(0.4, "Holy Light(Rank 4)")
    heal_under_percent(0.7, "Flash of Light(Rank 5)")
end

function pala_dispel_raid()
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and UnitIsConnected("raid"..i) and not UnitIsDead("target") then
			if has_debuff_pala("target") then
				CastSpellByName("Cleanse")
			end
		end
	end
end

function has_debuff_pala(target)
	for x=1,16 do
	    local name,count,debuffType=UnitDebuff(target,x,1)
	    if debuffType == "Magic" or debuffType == "Poison" or debuffType == "Disease" then
            return true
        end
    end
	return false
end
