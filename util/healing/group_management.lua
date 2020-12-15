-- Group Management
nameList={
	tank={"Harklen","Gaelber","Llanewrynn","Stardancer","Cooperbeard","Naderius","Dobzse","Obier","Nyavalyás", "Moonflower"},
	heal={},
	multiheal={"Lightbeard", "Baleog", "Lionel", "Nobleforged", "Bronzecoat"},
	multidps={"Azsgrof", "Daemona", "Jaliana", "Carla", "Liberton", "Pinkypie",
	"Fabregas", "Windou", "Oakheart", "Cromwell", "Leilena", "Featherfire",
	"Miraclemike", "Pompedous", "Morbent", "Maleficus", "Nightleaf", "Ravencloud"}
}
roles={"tank","heal","multiheal","multidps","dps"}

-- targetLists: {all,tank,heal,dps(default),multiheal,multidps,party,group<1-8>,<charname>,master,self}   TODO: assist?,class,custom<any>?
-- playerInfo: uid -> {name,role,class,group,bias}

-- Initialize bias list structure
biasList={group={}}

-- Set default global bias values
biasList.tank,biasList.heal,biasList.multiheal,biasList.multidps=-0.1,0,-0.08,-0.05

-- This function should be used in SuperMacro's extended LUA code fields, to easily manage healing biases per healer.
-- I could set biasList as a saved variable, might do it later, but since the addon doesn't have ui elements, the method above is more comfortable to use.
function SetBias(bias,list,groupNum)
	local oldBias
	if list=="group" then
		oldBias=biasList.group[groupNum]
		biasList.group[groupNum]=bias
	else
		oldBias=biasList[list]
		biasList[list]=bias
	end
	if oldBias==bias then
		return
	end
	if targetList then
		if list=="group" then
			for target,info in pairs(targetList.group[groupNum]) do
				RemoveBias(info,oldBias)
				AddBias(info,bias)
			end
		else
			for target,info in pairs(targetList[list]) do
				RemoveBias(info,oldBias)
				AddBias(info,bias)
			end
		end
	end
	--Debug("New bias value set.")
end

function Debug(message)
	if message==nil then
		DEFAULT_CHAT_FRAME:AddMessage("nil")
	else
		DEFAULT_CHAT_FRAME:AddMessage(message)
	end
end

function GroupManagementHandler()
	if not UnitClass("player") == "Priest" and not UnitClass("player") == "Paladin" and not UnitClass("player") == "Druid" then return end
	if not targetList then
		BuildTargetList()
	elseif event=="PLAYER_ENTERING_WORLD" or event=="RAID_ROSTER_UPDATE" and UnitInRaid("player") or event=="PARTY_MEMBERS_CHANGED" and not UnitInRaid("player") then
		UpdateTargetList()
	end
end

function BuildTargetList()
	-- Initialize/reset target list
	targetList={all={},group={},party={},master={},self={}}
	for i,role in ipairs(roles) do
		targetList[role]={}
	end
	for i=1,8 do
		targetList.group[i]={}
	end

	-- Register players
	if UnitInRaid("player") then
		partyToRaidChack=true
		for i=1,40 do
			if UnitName("raid"..i)=="Unknown" then
				--Debug("Couldn't build target list. raid"..i.."'s name is unknown.")
				targetList=nil
				return
			end
			RegisterUnit(true,i)
		end
	else
		partyToRaidChack=false
		RegisterUnit(false,"player")
		if UnitName("player")=="Unknown" then
			--Debug("Couldn't build target list. player's name is unknown.")
			targetList=nil
			return
		end
		for i=1,GetNumPartyMembers() do
			RegisterUnit(false,"party"..i)
			if UnitName("party"..i)=="Unknown" then
				--Debug("Couldn't build target list. party"..i.."'s name is unknown.")
				targetList=nil
				return
			end
		end
	end
	--Debug("Target list built")
end

function RegisterUnit(isRaid,raidOrUnitId)
	local uid
	if isRaid then
		uid="raid"..raidOrUnitId
	else
		uid=raidOrUnitId
	end
	if UnitIsConnected(uid) then
		-- Set player info, initialize bias
		local unitName,unitGroup,unitClass,unitRole
		if isRaid then
			unitName,_,unitGroup,_,_,unitClass=GetRaidRosterInfo(raidOrUnitId)
		else
			unitName=UnitName(uid)
			_,unitClass=UnitClass(uid)
		end
		local unitRole=GetRole(unitName)
		local targetInfo={}
		local isPlayer=unitName==UnitName("player")
		targetInfo.name=unitName
		targetInfo.class=unitClass
		targetInfo.group=unitGroup or 0
		targetInfo.role=unitRole
		targetInfo.bias=0

		-- Add player to target lists, set bias values
		-- All
		targetList.all[uid]=targetInfo

		-- Role
		targetList[unitRole][uid]=targetInfo
		AddBias(targetInfo,biasList[unitRole])

		-- Group
		if isRaid then
			targetList.group[unitGroup][uid]=targetInfo
			AddBias(targetInfo,biasList.group[unitGroup])
			if isPlayer then
				targetList.party=targetList.group[unitGroup]
				for target,partyInfo in pairs(targetList.party) do
					AddBias(partyInfo,biasList.party)
				end
			elseif targetList.party[uid] then
				AddBias(targetInfo,biasList.party)
			end
		else
			targetList.party[uid]=targetInfo
		end

		-- Player
		targetList[unitName]={}
		targetList[unitName][uid]=targetInfo
		AddBias(targetInfo,biasList[unitName])
		if isPlayer then
			targetList.self=targetList[unitName]
			AddBias(targetInfo,biasList.self)
		end
	end
end

function UpdateTargetList()
	if UnitInRaid("player") then
		if not partyToRaidChack then
			BuildTargetList()
		else
			for i=1,40 do
				local uid="raid"..i
				if UnitIsConnected(uid) then
					currentTargetInfo=targetList.all[uid]
					if UnitName(uid)=="Unknown" then
						--Debug("Couldn't update target list. raid"..i.."'s name is unknown.")
						return
					end
					if not currentTargetInfo then
						RegisterUnit(1,i)
						--Debug("Added new uid")
					else
						local unitName,_,unitGroup,_,_,unitClass=GetRaidRosterInfo(i)
						if unitName~=currentTargetInfo.name then
							UpdatePlayer(uid,currentTargetInfo,unitName,unitClass)
							--Debug("Updated player info")
						end
						if unitGroup~=currentTargetInfo.group then
							UpdateGroup(uid,currentTargetInfo,unitGroup)
							--Debug("Updated player group")
						end
					end
				else
					if targetList.all[uid] then
						RemoveUid(uid)
						--Debug("Removed unused uid")
					end
				end
			end
			--Debug("Target list updated")
		end
	else
		if partyToRaidChack then
			BuildTargetList()
		else
			for i=1,GetNumPartyMembers() do
				local uid="party"..i
				if UnitIsConnected(uid) then
					if UnitName(uid)=="Unknown" then
						--Debug("Couldn't update target list. party"..i.."'s name is unknown.")
						return
					end
					currentTargetInfo=targetList.all[uid]
					if not currentTargetInfo then
						RegisterUnit(false,uid)
						--Debug("Added new uid")
					else
						local unitName=UnitName(uid)
						local _,unitClass=UnitClass(uid)
						if unitName~=currentTargetInfo.name then
							UpdatePlayer(uid,currentTargetInfo,unitName,unitClass)
							--Debug("Updated player info")
						end
					end
				else
					if targetList.all[uid] then
						RemoveUid(uid)
						--Debug("Removed unused uid")
					end
				end
			end
			--Debug("Target list updated")
		end
	end
end

function UpdatePlayer(uid,info,name,class)
	local role=GetRole(name)
	local oldRole=info.role
	local oldName=info.name
	local ownName=UnitName("player")

	-- Role
	if role~=oldRole then
		info.role=role
		targetList[role][uid]=info
		targetList[oldRole][uid]=nil
		AddBias(info,biasList[role])
		RemoveBias(info,biasList[oldRole])
	end

	-- Class
	info.class=class

	-- Player
	if name~=oldName then -- Just to be safe.
		info.name=name

		if not targetList[name] then
			targetList[name]={}
		end
		targetList[name][uid]=info
		targetList[oldName][uid]=nil

		AddBias(info,biasList[name])
		RemoveBias(info,biasList[oldName])

		if name==ownName then
			targetList.self[uid]=info
			AddBias(info,biasList.self)
		elseif oldName==ownName then
			targetList.self[uid]=nil
			RemoveBias(info,biasList.self)
		end
	end
end

function UpdateGroup(uid,info,groupNum)
	local oldGroupNum=info.group
	local ownName=UnitName("player")

	if groupNum~=0 and oldGroupNum~=0 then -- Just to be safe
		if ownName==info.name then
			for target,partyInfo in pairs(targetList.party) do
				RemoveBias(partyInfo,biasList.party)
			end
		elseif targetList.party[uid] then
			RemoveBias(info,biasList.party)
		end

		info.group=groupNum
		targetList.group[groupNum][uid]=info
		targetList.group[oldGroupNum][uid]=nil
		AddBias(info,biasList.group[groupNum])
		RemoveBias(info,biasList.group[oldGroupNum])

		if ownName==info.name then
			targetList.party=targetList.group[groupNum]
			for target,partyInfo in pairs(targetList.party) do
				AddBias(partyInfo,biasList.party)
			end
		elseif targetList.party[uid] then
			AddBias(info,biasList.party)
		end
	end
end

function RemoveUid(uid)
	local info=targetList.all[uid]
	local name=info.name
	local group=info.group
	local role=info.role

	targetList.all[uid]=nil
	targetList[name][uid]=nil

	if group==0 then
		targetList.party[uid]=nil
	else
		targetList.group[group][uid]=nil
	end
	targetList[role][uid]=nil
	if name==UnitName("player") then
		targetList.self[uid]=nil
	end
end
function AddBias(targetInfo,value)
	if value then
		targetInfo.bias=targetInfo.bias+value
	end
end

function RemoveBias(targetInfo,value)
	if value then
		targetInfo.bias=targetInfo.bias-value
	end
end

function GetRole(name)
	for i,role in ipairs(roles) do
		if role=="dps" then
			break
		end
		for j,currentName in ipairs(nameList[role]) do
			if currentName==name then
				return role
			end
		end
	end
	return "dps"
end
