-- TODO barskin

buffAbolishPoison="Spell_Nature_NullifyPoison_02"
buffRegrowth="Spell_Nature_ResistNature"
buffRejuvenation="Spell_Nature_Rejuvenation"
druidNatureSwiftness="Spell_Nature_RavenForm"

druidDispelAll={Posion=true,Curse=true}
druidDispelCurse={Curse=true}
druidDispelPosion={Posion=true}

druidHealRange="Healing Touch"
druidDispelRange="Remove Curse"

lastInner = 0;
innervateActionSlot = 61;

-- /script  druidHealOrDispel(azs.targetList.all, false)
function druidHealOrDispel(lTargetList,healProfile,dispelTypes,dispelByHp,dispelHpThreshold)
	leaveShapeShiftForm()
	lTargetList = lTargetList or azs.targetList.all
	healProfile=healProfile or getDefaultHealingProfile()
	dispelTypes=dispelTypes or druidDispelAll
	dispelByHp=dispelByHp or false
	dispelHpThreshold=dispelHpThreshold or 0.4
	useHealingTrinket()
	if (UnitMana("player") < 500) then
		innervate()
	end
	if SpellCastReady(druidHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hpOrDebuffType,hotTarget,hotHp,action=GetHealOrDispelTarget(lTargetList,druidHealRange,buffRegrowth,druidDispelRange,dispelTypes,dispelByHp,dispelHpThreshold)
		if action=="heal" then
			druidHealTarget(healProfile,target,hpOrDebuffType,hotTarget,hotHp)
		else
			druidDispelTarget(target,hpOrDebuffType)
		end
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

-- /script druidHeal(azs.targetList.all, false)
function druidHeal(lTargetList,healProfile)
	leaveShapeShiftForm()
	lTargetList = lTargetList or azs.targetList.all
	useHealingTrinket()
	if (UnitMana("player") < 500) then
		innervate()
	end
	healProfile=healProfile or getDefaultHealingProfile()
	if SpellCastReady(druidHealRange,stopCastingDelayExpire) then
		stopCastingDelayExpire=nil
		local target,hp,hotTarget,hotHp=GetHealTarget(lTargetList,druidHealRange,buffRegrowth)
		druidHealTarget(healProfile,target,hp,hotTarget,hotHp)
	else
		HealInterrupt(currentHealTarget,currentHealFinish,precastHpThreshold)
	end
end

function druidHealTarget(healProfile,target,hp,hotTarget,hotHp)
	if druidHealProfiles[healProfile] then
		for i,healProfileEntry in ipairs(druidHealProfiles[healProfile]) do
			local hpThreshold,manaCost,spellName,healMode,lTargetList,withCdOnly=unpack(healProfileEntry)
			local mana=UnitMana("player")
			if mana>=manaCost and (not withCdOnly or hasBuff("player",druidNatureSwiftness)) and GetSpellCooldownByName(spellName)==0 then
				if (not healMode or healMode==1) and target and hp<hpThreshold and (not lTargetList or lTargetList[target]) then
					--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					azs.targetList.all[target].blacklist = nil
					currentHealTarget = target
					CastSpellByName(spellName)
					SpellTargetUnit(target)
					break
				elseif healMode==2 then
					if azs.targetSkull() or azs.targetCross() then
						if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
							--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
							currentHealTarget = "targettarget"
							currentHealFinish = GetTime() + (GetSpellCastTimeByName(spellName) or 1.5)
							precastHpThreshold = hpThreshold
							CastSpellByName(spellName)
							SpellTargetUnit("targettarget")
						end
					end
					break
				elseif healMode==3 and hotTarget and hotHp<hpThreshold and (not lTargetList or lTargetList[hotTarget]) then
					--azs.debug("Executing heal profile \""..healProfile.."\", entry: "..i)
					azs.targetList.all[target].blacklist = nil
					currentHealTarget = hotTarget
					CastSpellByName(spellName)
					SpellTargetUnit(hotTarget)
					break
				end
			end
		end
	end
end

-- /script druidDispel()
function druidDispel(lTargetList,dispelTypes,dispelByHp)
	leaveShapeShiftForm()
	lTargetList = lTargetList or azs.targetList.all
	dispelTypes=dispelTypes or druidDispelAll
	dispelByHp=dispelByHp or false
	useHealingTrinket()
	if (UnitMana("player") < 500) then
		innervate()
	end
	if SpellCastReady(druidDispelRange) then
		local target,debuffType=GetDispelTarget(lTargetList,druidDispelRange,druidDispelAll,false)
		druidDispelTarget(target,debuffType)
	end
end

function druidDispelTarget(target,debuffType)
	if target then
		azs.targetList.all[target].blacklist = nil
		currentHealTarget = target
		currentHealFinish = nil
		if debuffType=="Curse" then
			CastSpellByName("Remove Curse")
			SpellTargetUnit(target)
		elseif not hasBuff(target,buffAbolishPoison) then
			CastSpellByName("Abolish Poison")
			SpellTargetUnit(target)
		end
	end
end

function innervate()
  if (lastInner + 300 <= GetTime()) then
    local icon, name, active, castable = GetShapeshiftFormInfo(5);
    if active then
  		CastSpellByName("Moonkin Form")
      return
    elseif IsActionReady(innervateActionSlot) and (UnitMana("player") >= 70) then
      ClearFriendlyTarget()
      CastSpellByName("Innervate")
      SpellTargetUnit("player")
      lastInner = GetTime()
    end
  end
end

function leaveShapeShiftForm()
	for i=1, GetNumShapeshiftForms() do
		local _, name, active = GetShapeshiftFormInfo(i)
		if( active ~= nil ) then
			CastShapeshiftForm(i)
			break
		end
	end
end

function initDruidHealProfiles()
	druidHealProfiles={
		regular={
			{0.2 , 540 , "Nature's Swiftness",1,azs.targetList.tank},
			{0.2 , 540 , "Healing Touch(Rank 9)",1,azs.targetList.tank, true},
			{0.4 , 350 , "Regrowth(Rank 4)",3},
			{0.4 , 248, "Swiftmend",1,azs.targetList.tank},
			{0.5 , 166, "Healing Touch(Rank 4)"},
			{0.65 , 99, "Healing Touch(Rank 3)"},
			{0.75 , 49, "Healing Touch(Rank 2)"},
			{0.9 , 280 , "Regrowth(Rank 3)",3},
			{0.9 , 49, "Healing Touch(Rank 2)",2}
		},
		midLevel={
			{0.4 , 150 , "Healing Touch(Rank 3)"},
			{0.5 , 150, "Healing Touch(Rank 3)",1,azs.targetList.tank},
			{0.7 , 120 , "Regrowth(Rank 2)",3},
			{0.8 , 35 , "Healing Touch(Rank 1)", 2}
		},
		lesser={
			{0.3 , 35 , "Healing Touch"},
			{0.4 , 35, "Healing Touch",1,azs.targetList.tank},
			{0.6 , 35 , "Healing Touch(Rank 1)"},
			{0.7 , 120 , "Regrowth",3}
		},
	}
end
