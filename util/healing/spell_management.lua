-- Spell management
-- TODO: Action slot mapping and pet abilities

-- spellName -> {spellID,bookType,castTime,actionSlot}
spellData={}

spellCastTime={
	-- Priest
	["Lesser Heal(Rank 1)"]=1.5,
	["Lesser Heal(Rank 2)"]=2,
	["Lesser Heal(Rank 3)"]=2.5,
	["Heal"]=2.5,
	["Greater Heal"]=2.5,
	["Flash Heal"]=1.5,
	-- Paladin
	["Holy Light"]=2.5,
	["Flash of Light"]=1.5
}

function BuildSpellData()
	local i=1
	local maxSpell,maxRank=nil,nil
	while true do
		local spellName,spellRank=GetSpellName(i,BOOKTYPE_SPELL);
		if maxSpell and spellName~=maxSpell then
			spellData[maxSpell]=spellData[maxSpell.."("..maxRank..")"]
			maxSpell,maxRank=nil,nil
		end
		if not spellName then
			break
		end
		local spellDataKey
		if strfind(spellRank,"Rank",1,1) then
			maxSpell,maxRank=spellName,spellRank
			spellDataKey=spellName.."("..spellRank..")"
			spellData[spellDataKey]={spellId=i,bookType="BOOKTYPE_SPELL"}
		elseif spellRank~="Passive" and spellRank~="Racial Passive" then
			maxSpell,maxRank=nil,nil
			spellDataKey=spellName
			spellData[spellDataKey]={spellId=i,bookType="BOOKTYPE_SPELL"}
			if strfind(spellDataKey,")",-1) then
				spellData[spellDataKey.."()"]=spellData[spellDataKey]
			end
		end
		if spellCastTime[spellName] then
			spellData[spellDataKey].castTime=spellCastTime[spellName]
		elseif spellCastTime[spellName.."("..spellRank..")"] then
			spellData[spellDataKey].castTime=spellCastTime[spellName.."("..spellRank..")"]
		end
		-- TODO: Cast time decreasing talents
		i=i+1
	end
end

function GetSpellIdEntries(pSpellId)
	for name,info in pairs(spellData) do
		if not pSpellId or info.spellId==pSpellId then
			local s=info.spellId..": "..name
			if info.castTime then
				s=s.." | Cast: "..info.castTime.."s"
			end
			Debug(s)
		end
	end
end

function GetSpellCooldownByName(spellName)
	return GetSpellCooldown(spellData[spellName].spellId,spellData[spellName].bookType)
end

function GetSpellCastTimeByName(spellName)
	return spellData[spellName].castTime
end
