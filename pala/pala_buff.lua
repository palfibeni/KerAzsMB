function paladinBuff(buff, aura)
  buff = buff or determinePaladinBuff()
  setDefaultAura(aura)
  if buff == "Sanc/Salva" then
    return palaRaidSancSalva()
  elseif buff == "Kings" then
    return palaRaidKings()
  elseif buff == "Might/Wisdom" then
    return palaRaidMightWisdom()
  elseif buff == "Light" then
    return palaRaidLight()
  elseif buff == "Small" then
    return palaSmallMightWisdom()
  end
end

function determinePaladinBuff()
  if UnitLevel("player") < 60 then return "Small" end
  local _, _, pointsSpentInProtection = GetTalentTabInfo(2)
  local _, _, pointsSpentInRetribution = GetTalentTabInfo(3)
  if pointsSpentInProtection > 20 then
    return "Sanc/Salva"
  elseif pointsSpentInProtection > 10 then
    return "Kings"
  elseif pointsSpentInRetribution == 5 then
    return "Might/Wisdom"
  else
    return "Light"
  end
end

-- /script palaRaidMight()
function palaRaidMight()
  buffTargetList("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

-- /script palaRaidWisdom()
function palaRaidWisdom()
  buffTargetList("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom")
end

-- /script palaRaidKings()
function palaRaidKings()
  buffTargetList("Spell_Magic_GreaterBlessingofKings", "Greater Blessing of Kings")
end

-- /script palaRaidLight()
function palaRaidLight()
  buffTargetList("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

-- /script palaRaidSalva()
function palaRaidSalva()
  buffTargetList("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation")
end

-- /script palaRaidSanc()
function palaRaidSanc()
  buffTargetList("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary")
end

-- /script palaRaidSancSalva()
function palaRaidSancSalva(ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" or info.class == "DRUID" then
			castBuff("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary", target)
    else
			castBuff("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation", target)
    end
	end
end

-- /script palaRaidMightWisdom()
function palaRaidMightWisdom(ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" or info.class == "ROGUE" then
			castBuff("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might", target)
    else
			castBuff("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom", target)
    end
	end
end

-- /script palaSmallMightWisdom()
function palaSmallMightWisdom(ltargetList)
	ltargetList=ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" or info.class == "ROGUE" then
			castBuff("Spell_Holy_FistOfJustice", "Blessing of Might", target)
    else
			castBuff("Spell_Holy_SealOfWisdom", "Blessing of Wisdom", target)
    end
	end
end

function setDefaultAura(defaultAura)
  defaultAura=defaultAura or "Devotion Aura"
	local active=0
	for i=1,GetNumShapeshiftForms() do
    _,_,active=GetShapeshiftFormInfo(i)
		if active then
			break
		end
	end
	if not active then
		CastSpellByName(defaultAura)
	end
end
