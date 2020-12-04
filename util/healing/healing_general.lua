-- 7 PARAMETERS!!! YEP!!!!!!
function GetHealOrDispelTarget(targetList,healSpell,hpThreshold,dispelSpell,dispelTypes,dispelByHp,dispelHpThreshold)
	local dispelTarget,debuffType,action
	local healTarget,minHp=GetHealTarget(targetList,healSpell,hpThreshold)
	if not healTarget or minHp>dispelHpThreshold then
		dispelTarget,debuffType=GetDispelTarget(targetList,dispelSpell,dispelTypes,dispelByHp)
		if dispelTarget then
			action="dispel"
		else
			action="heal"
		end
	else
		action="heal"
	end
	if action=="heal" then
		return healTarget,minHp,action
	end
	return dispelTarget,debuffType,action
end

function GetHealTarget(targetList,healSpell,hpThreshold)
	ClearFriendlyTarget()
	CastSpellByName(healSpell)
	local currentTarget,minHp,minBiasedHp
	for target,info in pairs(targetList) do
		local hp=UnitHealth(target)/UnitHealthMax(target)
		if hp<hpThreshold and IsValidSpellTarget(target) then
			local biasedHp=hp+info.bias
			if not minHp or biasedHp<minBiasedHp then
				minHp=hp
				minBiasedHp=biasedHp
				currentTarget=target
			end
		end
	end
	SpellStopTargeting()
	return currentTarget,minHp
end

function ClearFriendlyTarget()
	if UnitExists("target") and UnitIsFriend("player","target") then
		ClearTarget()
	end
end

function IsValidSpellTarget(target)
	return not UnitIsDeadOrGhost(target) and SpellCanTargetUnit(target)
end


function GetDispelTarget(targetList,dispelSpell,dispelTypes,dispelByHp)
	ClearFriendlyTarget()
	CastSpellByName(dispelSpell)
	local currentTarget,topPriority,debuffType
	for target,info in pairs(targetList) do
		if IsValidSpellTarget(target) then
			for i=1,16 do
				_,_,debuffType=UnitDebuff(target,i,1)
				if not debuffType or dispelTypes[debuffType] then
					break
				end
			end
			if debuffType then
				local priority=info.bias
				if dispelByHp then
					priority=priority+UnitHealth(target)/UnitHealthMax(target)
				end
				if not topPriority or priority<topPriority then
					topPriority=priority
					currentTarget=target
				end
			end
		end
	end
	SpellStopTargeting()
	return currentTarget,debuffType
	-- TODO: Check the amount of debuffs on a player and maybe priorities by debuff type. Will be important for Chromaggus.
end
