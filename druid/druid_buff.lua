function druidRaidBuff()
  buffTargetList("Spell_Nature_Thorns", "Thorns", azs.targetList.tank)
  buffTargetList("Spell_Nature_Regeneration", "Gift of the Wild")
end

function druidSmallBuff()
  buffTargetList("Spell_Nature_Thorns", "Thorns", azs.targetList.tank)
	buffTargetList("Spell_Nature_Regeneration", "Mark of the Wild")
end

function druidBuff()
  if UnitLevel("player") == 60 then
    druidRaidBuff()
  else
    druidSmallBuff()
  end
end
