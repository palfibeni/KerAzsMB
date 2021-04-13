-- /script pala_raid_might()
function pala_raid_might()
  setDefaultAura()
  buffTargetList("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

-- /script pala_raid_wisdom()
function pala_raid_wisdom()
  setDefaultAura()
  buffTargetList("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom")
end

-- /script pala_raid_kings()
function pala_raid_kings()
  setDefaultAura()
  buffTargetList("Spell_Magic_GreaterBlessingofKings", "Greater Blessing of Kings")
end

-- /script pala_raid_light()
function pala_raid_light()
  setDefaultAura()
  buffTargetList("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

-- /script pala_raid_salva()
function pala_raid_salva()
  setDefaultAura()
  buffTargetList("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation")
end

-- /script pala_raid_sanc()
function pala_raid_sanc()
  setDefaultAura()
  buffTargetList("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary")
end

-- /script buff_raid_pala_sanc_salva()
function buff_raid_pala_sanc_salva(lTargetList)
  setDefaultAura()
	lTargetList=lTargetList or targetList.all
	for target,info in pairs(lTargetList) do
    if info.class == "WARRIOR" or info.class == "DRUID" then
			castBuff("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary", target)
    else
			castBuff("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation", target)
    end
	end
end

-- /script buff_raid_pala_might_wisdom()
function buff_raid_pala_might_wisdom(lTargetList)
  setDefaultAura()
	lTargetList=lTargetList or targetList.all
	for target,info in pairs(lTargetList) do
    if info.class == "WARRIOR" or info.class == "ROGUE" then
			castBuff("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might", target)
    else
			castBuff("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom", target)
    end
	end
end

-- /script buff_raid_pala_might_wisdom()
function buff_pala_small_might_wisdom(lTargetList)
  setDefaultAura()
	lTargetList=lTargetList or targetList.all
	for target,info in pairs(lTargetList) do
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
