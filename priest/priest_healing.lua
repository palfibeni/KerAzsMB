-- TODO Fix AOE, add Fade

buffAbolishDisease="Spell_Nature_NullifyDisease"
buffRenew="Spell_Holy_Renew"
buffInnerFocus="Spell_Frost_WindWalkOn"

priestHealRange="Lesser Heal"
priestDispelRange="Cure Disease"
aoeHealMinPlayers=3

desperatePrayerActionSlot = 61

-- /script priest_heal_mandokir()
function priest_heal_mandokir()
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
 PriestHeal(targetList.all, false)
end

function fear_ward()
    if casting_or_channeling() then return end
    cast_buff("Spell_Holy_Excorcism", "Fear Ward")
end

-- /script  PriestHealOrDispel(targetList.all, false)
function PriestHealOrDispel(targetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	healProfile=healProfile or getDefaultHealingProfile()
	dispelTypes=dispelTypes or priestDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	if SpellCastReady(priestHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hpOrDebuffType,hotTarget,hotHp,action=GetHealOrDispelTarget(targetList,priestHealRange,buffRenew,priestDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			PriestHealTarget(healProfile,target,hpOrDebuffType,hotTarget,hotHp)
		else
			PriestDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function PriestHeal(targetList,healProfile)
	if IsActionReady(desperatePrayerActionSlot) and is_player_hp_under(0.4) then
			CastSpellByName("Desperate Prayer")
	end
	UseHealTrinket()
	healProfile=healProfile or getDefaultHealingProfile()
	if SpellCastReady(priestHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp,hotTarget,hotHp=GetHealTarget(targetList,priestHealRange,buffRenew)
		local aoeInfo=PriestAoeInfo()
		PriestHealTarget(healProfile,target,hp,hotTarget,hotHp,aoeInfo)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function PriestAoeInfo()
	ClearFriendlyTarget()
	CastSpellByName("Cure Disease")
	local playerCount,playerHps=0,{}
	for target,info in pairs(targetList.party) do
		local hp=UnitHealth(target)/UnitHealthMax(target)
		if IsValidSpellTarget(target) then
			playerCount=playerCount+1
			playerHps[playerCount]={uid=target,hpRatio=hp}
		end
	end
	SpellStopTargeting()
	table.sort(playerHps,function(a,b) return a.hpRatio<b.hpRatio end)
	return playerHps
end

function PriestHealTarget(healProfile,target,hp,hotTarget,hotHp,aoeInfo)
	if priestHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(priestHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,targetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or has_buff("player",buffInnerFocus)) and GetSpellCooldownByName(spellName)==0 then
				if (not healMode or healMode==1) and target and hp<hpThreshold and (not targetList or targetList[target]) then
					--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					currentHealTarget=target
					CastSpellByName(spellName)
					SpellTargetUnit(target)
					break
				elseif healMode==2 then
					if is_target_skull() or is_target_skull() or target_skull() or target_cross() then
						if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
							--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
							currentHealTarget="targettarget"
							currentHealFinish=GetTime()+(GetSpellCastTimeByName(spellName) or 1.5)
							precastHpThreshold=hpThreshold
							CastSpellByName(spellName)
							SpellTargetUnit("targettarget")
						end
					end
					break
				elseif healMode==3 and hotTarget and hotHp<hpThreshold and (not targetList or targetList[hotTarget]) then
					--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					currentHealTarget=nil
					CastSpellByName(spellName)
					SpellTargetUnit(hotTarget)
					break
				--elseif healMode==4 and aoeInfo[aoeHealMinPlayers] and aoeInfo[aoeHealMinPlayers].hpRatio<hpThreshold then
					--Debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					--currentHealTarget=nil
					--CastSpellByName(spellName)
					--break
				end
			end
		end
	end
end

function PriestDispel(targetList,dispelTypes,dispelByHp)
	dispelTypes=dispelTypes or priestDispelAll
	dispelByHp=dispelByHp or false
	if SpellCastReady(priestDispelRange) then
		local target,debuffType=GetDispelTarget(targetList,priestDispelRange,priestDispelAll,false)
		PriestDispelTarget(target,debuffType)
	end
end

priestDispelAll={Magic=true,Disease=true}
priestDispelMagic={Magic=true}
priestDispelDisease={Disease=true}

function PriestDispelTarget(target,debuffType)
	if target then
		if debuffType=="Magic" then
			ClearTarget()
			CastSpellByName("Dispel Magic")
		elseif not has_buff(target,buffAbolishDisease) then
			CastSpellByName("Abolish Disease")
		else
			CastSpellByName("Cure Disease")
		end
		SpellTargetUnit(target)
	end
end

function initPriestHealProfiles()
	priestHealProfiles={
		regular={
			{0.4 , 380, "Flash Heal",1,targetList.tank},
			--{0.5 , 0  , "Inner Focus",4},
			--{0.5 , 0  , "Prayer of Healing",4,targetList.party,true},
			--{0.8 , 410, "Prayer of Healing(Rank 1)",4},
			{0.3 , 380, "Flash Heal"},
			{0.5 , 215, "Flash Heal(Rank 4)"},
			{0.6 , 259, "Heal(Rank 4)"},
			{0.7 , 216, "Heal(Rank 3)"},
			{0.8 , 174, "Heal(Rank 2)"},
			{0.9 , 94 , "Renew(Rank 3)",3},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
		renewSpam={
			{0.4 , 380, "Flash Heal",1,targetList.tank},
			--{0.5 , 0  , "Inner Focus",4},
			--{0.5 , 0  , "Prayer of Healing",4,false,true},
			--{0.8 , 410, "Prayer of Healing(Rank 1)",4},
			{0.4 , 259, "Heal(Rank 4)"},
			{0.6 , 184, "Renew(Rank 6)",3},
			{0.9 , 94 , "Renew(Rank 3)",3},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
		pureRenewSpam={
			{0.6 , 184, "Renew(Rank 6)",3},
			{0.9 , 94 , "Renew(Rank 3)",3},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
		UNLIMITEDPOWER={
			--{0.9 , 0  , "Prayer of Healing",4},
			{0.99, 0  , "Flash Heal"},
			{0.9 , 131, "Heal(Rank 1)",2}
		},
    midLevel={
			{0.4 , 265, "Flash Heal",1,targetList.tank},
      {0.3 , 265, "Flash Heal"},
      {0.5 , 155, "Flash Heal(Rank 2)"},
      {0.6 , 259, "Heal"},
      {0.7 , 174, "Heal(Rank 2)"},
      {0.8 , 131, "Heal(Rank 1)"},
      {0.9 , 96 , "Renew(Rank 3)",3}
    },
    lesser={
			{0.5 , 63, "Lesser Heal",1,targetList.tank},
      {0.3 , 63, "Lesser Heal"},
      {0.7 , 38, "Lesser Heal(Rank 2)"},
      {0.8 , 94 , "Renew(Rank 1)",3}
    }
	}
end
