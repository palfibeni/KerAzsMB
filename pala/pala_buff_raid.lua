function pala_raid_might()
    buff_raid("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

function pala_raid_wisdom()
    buff_raid("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom")
end

function pala_raid_kings()
    buff_raid("Spell_Magic_GreaterBlessingofKings", "Greater Blessing of Kings")
end

function pala_raid_light()
    buff_raid("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

function pala_raid_salva()
    buff_raid("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation")
end

function pala_raid_sanc()
    buff_raid("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary")
end

-- /script buff_raid_pala_might_wisdom()
function buff_raid_pala_might_wisdom()
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and UnitIsConnected("raid"..i) and not UnitIsDead("target") then
			TargetByName(name)
            if class=="Warrior" or class=="Rogue" then
			    pala_big_might()
        	else
			    pala_big_wisdom()
        	end
		end
	end
end
