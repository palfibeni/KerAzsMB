-- /script pala_raid_might()
function pala_raid_might()
  setDefaultAura()
  buff_raid("Spell_Holy_GreaterBlessingofKings", "Greater Blessing of Might")
end

-- /script pala_raid_wisdom()
function pala_raid_wisdom()
  setDefaultAura()
  buff_raid("Spell_Holy_GreaterBlessingofWisdom", "Greater Blessing of Wisdom")
end

-- /script pala_raid_kings()
function pala_raid_kings()
  setDefaultAura()
  buff_raid("Spell_Magic_GreaterBlessingofKings", "Greater Blessing of Kings")
end

-- /script pala_raid_light()
function pala_raid_light()
  setDefaultAura()
  buff_raid("Spell_Holy_GreaterBlessingofLight", "Greater Blessing of Light")
end

-- /script pala_raid_salva()
function pala_raid_salva()
  setDefaultAura()
  buff_raid("Spell_Holy_GreaterBlessingofSalvation", "Greater Blessing of Salvation")
end

-- /script pala_raid_sanc()
function pala_raid_sanc()
  setDefaultAura()
  buff_raid("Spell_Holy_GreaterBlessingofSanctuary", "Greater Blessing of Sanctuary")
end

-- /script buff_raid_pala_sanc_salva()
function buff_raid_pala_sanc_salva()
  setDefaultAura()
	for i=1,GetNumRaidMembers() do
		local name,rank,subgroup,level,class,fileName,zone,online,isdead=GetRaidRosterInfo(i)
		if name and class and UnitIsConnected("raid"..i) and not UnitIsDead("target") then
			TargetByName(name)
      if class=="Warrior" or class=="Druid" then
        pala_big_sanc()
      else
        pala_big_salva()
      end
		end
	end
end

-- /script buff_raid_pala_might_wisdom()
function buff_raid_pala_might_wisdom()
  setDefaultAura()
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
