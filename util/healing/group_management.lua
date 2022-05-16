-- Initialize bias list structure
biasList={group={}}

-- Set default global bias values
biasList.tank=-0.1
biasList.mainTank=-0.12
biasList.heal=0
biasList.multiheal=-0.08
biasList.multimelee=-0.06
biasList.multicaster=-0.06

local function InitTargetList()
	azs.targetList = {all = {}, group = {}, party = {}, master = {},self = {}}
	for role,names in pairs(azs.nameList) do
		azs.targetList[role]={}
	end
	azs.targetList.dps = {}
	for i=1,8 do
		azs.targetList.group[i] = {}
	end
end
InitTargetList()
local targetListReady = false

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
	if azs.targetList then
		if list=="group" then
			for target,info in pairs(azs.targetList.group[groupNum]) do
				RemoveBias(info,oldBias)
				AddBias(info,bias)
			end
		else
			for target,info in pairs(azs.targetList[list]) do
				RemoveBias(info,oldBias)
				AddBias(info,bias)
			end
		end
	end
	--azs.debug("New bias value set.")
end

function GetGroupId(uid)
	name=UnitName(uid)
	for target,info in pairs(azs.targetList.all) do
		if info.name==name then
			return target
		end
	end
	return nil
end

function HandleGroupManagementEvent()
	if not targetListReady then
		BuildTargetList()
	else
		UpdateTargetList()
	end
end

function BuildTargetList()
	targetListReady = false
	-- Initialize/reset target list
	InitTargetList()

	-- Register players
	if UnitInRaid("player") then
		partyToRaidCheck=true
		for i=1,40 do
			if UnitName("raid"..i)=="Unknown" then
				--azs.debug("Couldn't build target list. raid"..i.."'s name is unknown.")
				azs.targetList=nil
				return
			end
			RegisterUnit(true,i)
		end
	else
		partyToRaidCheck=false
		RegisterUnit(false,"player")
		if UnitName("player")=="Unknown" then
			--azs.debug("Couldn't build target list. player's name is unknown.")
			azs.targetList=nil
			return
		end
		for i=1,GetNumPartyMembers() do
			RegisterUnit(false,"party"..i)
			if UnitName("party"..i)=="Unknown" then
				--azs.debug("Couldn't build target list. party"..i.."'s name is unknown.")
				azs.targetList=nil
				return
			end
		end
	end
	targetListReady = true
	initHealProfiles()
	BuildSpellData()
	--azs.debug("Target list built")
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
		local unitName,unitGroup,unitClass
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
		azs.targetList.all[uid]=targetInfo

		-- Role
		azs.targetList[unitRole][uid]=targetInfo
		AddBias(targetInfo,biasList[unitRole])

		-- Group
		if isRaid then
			azs.targetList.group[unitGroup][uid]=targetInfo
			AddBias(targetInfo,biasList.group[unitGroup])
			if isPlayer then
				azs.targetList.party=azs.targetList.group[unitGroup]
				for target,partyInfo in pairs(azs.targetList.party) do
					AddBias(partyInfo,biasList.party)
				end
			elseif azs.targetList.party[uid] then
				AddBias(targetInfo,biasList.party)
			end
		else
			azs.targetList.party[uid]=targetInfo
		end

		-- Player
		azs.targetList[unitName]={}
		azs.targetList[unitName][uid]=targetInfo
		AddBias(targetInfo,biasList[unitName])
		if isPlayer then
			azs.targetList.self=azs.targetList[unitName]
			AddBias(targetInfo,biasList.self)
		end
	end
end

function UpdateTargetList()
	if UnitInRaid("player") then
		if not partyToRaidCheck then
			BuildTargetList()
		else
			for i=1,40 do
				local uid="raid"..i
				if UnitIsConnected(uid) then
					currentTargetInfo=azs.targetList.all[uid]
					if UnitName(uid)=="Unknown" then
						--azs.debug("Couldn't update target list. raid"..i.."'s name is unknown.")
						return
					end
					if not currentTargetInfo then
						RegisterUnit(1,i)
					else
						local unitName,_,unitGroup,_,_,unitClass=GetRaidRosterInfo(i)
						if unitName~=currentTargetInfo.name then
							UpdatePlayer(uid,currentTargetInfo,unitName,unitClass)
							--azs.debug("Updated player info")
						end
						if unitGroup~=currentTargetInfo.group then
							UpdateGroup(uid,currentTargetInfo,unitGroup)
							--azs.debug("Updated player group")
						end
					end
				else
					if azs.targetList.all[uid] then
						RemoveUid(uid)
						--azs.debug("Removed unused uid")
					end
				end
			end
			--azs.debug("Target list updated")
		end
	else
		if partyToRaidCheck then
			BuildTargetList()
		else
			for i=1,5 do
				local uid="party"..i
				if UnitIsConnected(uid) then
					if UnitName(uid)=="Unknown" then
						--azs.debug("Couldn't update target list. party"..i.."'s name is unknown.")
						return
					end
					currentTargetInfo=azs.targetList.all[uid]
					if not currentTargetInfo then
						RegisterUnit(false,uid)
						--azs.debug("Added new uid")
					else
						local unitName=UnitName(uid)
						local _,unitClass=UnitClass(uid)
						if unitName~=currentTargetInfo.name then
							UpdatePlayer(uid,currentTargetInfo,unitName,unitClass)
							--azs.debug("Updated player info")
						end
					end
				else
					if azs.targetList.all[uid] then
						RemoveUid(uid)
						--azs.debug("Removed unused uid")
					end
				end
			end
			--azs.debug("Target list updated")
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
		azs.targetList[role][uid]=info
		azs.targetList[oldRole][uid]=nil
		AddBias(info,biasList[role])
		RemoveBias(info,biasList[oldRole])
	end

	-- Class
	info.class=class

	-- Player
	if name~=oldName then -- Just to be safe.
		info.name=name

		if not azs.targetList[name] then
			azs.targetList[name]={}
		end
		azs.targetList[name][uid]=info
		azs.targetList[oldName]=nil

		AddBias(info,biasList[name])
		RemoveBias(info,biasList[oldName])

		if name==ownName then
			azs.targetList.self[uid]=info
			AddBias(info,biasList.self)
		elseif oldName==ownName then
			azs.targetList.self[uid]=nil
			RemoveBias(info,biasList.self)
		end
	end
end

function UpdateGroup(uid,info,groupNum)
	local oldGroupNum=info.group
	local ownName=UnitName("player")

	if groupNum~=0 and oldGroupNum~=0 then -- Just to be safe
		if ownName==info.name then
			for target,partyInfo in pairs(azs.targetList.party) do
				RemoveBias(partyInfo,biasList.party)
			end
		elseif azs.targetList.party[uid] then
			RemoveBias(info,biasList.party)
		end

		info.group=groupNum
		azs.targetList.group[groupNum][uid]=info
		azs.targetList.group[oldGroupNum][uid]=nil
		AddBias(info,biasList.group[groupNum])
		RemoveBias(info,biasList.group[oldGroupNum])

		if ownName==info.name then
			azs.targetList.party=azs.targetList.group[groupNum]
			for target,partyInfo in pairs(azs.targetList.party) do
				AddBias(partyInfo,biasList.party)
			end
		elseif azs.targetList.party[uid] then
			AddBias(info,biasList.party)
		end
	end
end

function RemoveUid(uid)
	local info=azs.targetList.all[uid]
	local name=info.name
	local group=info.group
	local role=info.role

	azs.targetList.all[uid]=nil
	azs.targetList[name]=nil

	if group==0 then
		azs.targetList.party[uid]=nil
	else
		azs.targetList.group[group][uid]=nil
	end
	azs.targetList[role][uid]=nil
	if name==UnitName("player") then
		azs.targetList.self[uid]=nil
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
	for role,names in pairs(azs.nameList) do
		for i,currentName in ipairs(names) do
			if currentName==name then
				return role
			end
		end
	end
	return "dps"
end

function isTargetInList(target, list)
  for _,name in list do
    if UnitName(target) == name then
      return true
    end
  end
end

function PrintTargetLists()
	for uid,info in pairs(azs.targetList.all) do
		DEFAULT_CHAT_FRAME:AddMessage(uid.." | "..info.name.." | "..info.role.." | "..info.azs.class.." | group"..info.group.." | "..info.bias)
	end
end
