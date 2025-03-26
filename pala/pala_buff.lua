-- /script blessingOfFreedom("Cooperbeard")
function blessingOfFreedom(playerName)
  if GetSpellCooldownByName("Blessing of Freedom") ~= 0 then return end
	local playerName = playerName or UnitName("target")
	if not azs.targetList[playerName] then return end
	for target,info in pairs(azs.targetList[playerName]) do
		if isRooted(target) then
			castBuff("Spell_Holy_SealOfValor", "Blessing of Freedom", target)
		end
	end
end

function paladinBuff(buff, aura)
  local buff = buff or determinePaladinBuff()
  setDefaultAura(aura)
  if buff == "Sanc/Salva" then
    return palaRaidSancSalva()
  elseif buff == "Salva" then
    return palaRaidSalva()
  elseif buff == "Kings" then
    return palaRaidKings()
  elseif buff == "Might/Wisdom" then
    return palaRaidMightWisdom()
  elseif buff == "Light" then
    return palaRaidLight()
  elseif buff == "SmallMight/Wisdom" then
    return palaSmallMightWisdom()
  elseif buff == "Small" then
    if getSpellId("Blessing of Kings") ~= -1 then
      return palaSmallKings()
    end
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
  buffTargetListWithBless("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

-- /script palaRaidWisdom()
function palaRaidWisdom()
  buffTargetListWithBless("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom")
end

-- /script palaRaidKings()
function palaRaidKings()
  buffTargetListWithBless("Spell_Magic_GreaterBlessingofKings", "Greater Blessing of Kings")
end

-- /script palaRaidLight()
function palaRaidLight()
  buffTargetListWithBless("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

-- /script palaRaidSalva()
function palaRaidSalva()
  buffTargetListWithBless("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation")
end

-- /script palaRaidSanc()
function palaRaidSanc()
  buffTargetListWithBless("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary")
end

-- /script palaRaidSancSalva()
function palaRaidSancSalva(ltargetList)
	local ltargetList = ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" or info.class == "DRUID" then
			buffTargetWithBless("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary", target)
    else
			buffTargetWithBless("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation", target)
    end
	end
end

-- /script palaRaidMightSalva()
function palaRaidMightSalva(ltargetList)
	local ltargetList = ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" then
			buffTargetWithBless("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might", target)
    elseif info.class == "DRUID" or info.class == "PRIEST" or info.class == "PALADIN" or info.class == "SHAMAN" then
      buffTargetWithBless("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom", target)
    else
      buffTargetWithBless("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation", target)
    end
	end
end

-- /script palaRaidMightWisdom()
function palaRaidMightWisdom(ltargetList)
	local ltargetList = ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" or info.class == "ROGUE" then
			buffTargetWithBless("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might", target)
    else
			buffTargetWithBless("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom", target)
    end
	end
end

-- /script palaSmallKings()
function palaSmallKings(ltargetList)
    buffTargetListWithBless("Spell_Magic_MageArmor", "Blessing of Kings", ltargetList)
end

-- /script palaSmallMightWisdom()
function palaSmallMightWisdom(ltargetList)
	local ltargetList = ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "WARRIOR" or info.class == "ROGUE" or info.class == "DRUID" or isSelfRetriPala(info) then
			buffTargetWithBless("Spell_Holy_FistOfJustice", "Blessing of Might", target)
    else
			buffTargetWithBless("Spell_Holy_SealOfWisdom", "Blessing of Wisdom", target)
    end
	end
end

function setDefaultAura(defaultAura)
  local defaultAura = defaultAura or "Devotion Aura"
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

function overrideResistAura()
  if isTargetInMobList(HIGH_FIRE_DAMAGE_MOBS) then return "Fire Resist Aura" end
  if isTargetInMobList(HIGH_FROST_DAMAGE_MOBS) then return "Frost Resist Aura"end
  return "Devotion Aura"
end

-- Buffs azs.targetList with spell
function buffTargetListWithBless(icon, spellName, ltargetList)
	local ltargetList = ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
		buffTargetWithBless(icon, spellName, target)
	end
end

function buffPlayerWithBless(icon, spell, playerName)
	local playerName = playerName or UnitName("target")
	if not azs.targetList[playerName] then return end
	for target,info in pairs(azs.targetList[playerName]) do
		buffTargetWithBless(icon, spell, target)
	end
end

function buffTargetWithBless(icon, spell, target)
	if not hasBuff(target, "Spell_Holy_SealOfProtection") then
		castBuff(icon, spell, target)
	end
end

function isSelfRetriPala(info)
  return info.name == UnitName("player") and azs.class.talent == PALADIN_RETRI
end

function buffRaid()
  local ltargetList = ltargetList or azs.targetList.all
	for target,info in pairs(ltargetList) do
    if info.class == "HUNTER" then
      buffTargetWithBless("Spell_Holy_SealOfSalvation", "Blessing of Salvation", target)
    elseif info.class == "DRUID"  then
			buffTargetWithBless("Spell_Holy_FistOfJustice", "Blessing of Might", target)
    else
			buffTargetWithBless("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light", target)
    end
	end
end
