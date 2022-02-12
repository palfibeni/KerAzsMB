function priestRaidBuff()
  holyFire()
  buffTargetList("Spell_Holy_PrayerofSpirit", "Prayer of Spirit")
  buffTargetList("Spell_Holy_PrayerOfFortitude", "Prayer of Fortitude")
end

function priestSmallBuff()
  holyFire()
	buffTargetList("Spell_Holy_WordFortitude", "Power Word: Fortitude")
end

function holyFire()
  cast_buff_player("Spell_Holy_InnerFire", "Inner Fire")
end

function fearWard(playerName)
  buffPlayer("Spell_Holy_Excorcism", "Fear Ward", playerName)
end

function powerInfusion()
	if GetSpellCooldownByName("Power Infusion") ~= 0 then return end
	if not IsActionReady(powerInfusionActionSlot) then return end
	if UnitExists("targettarget") and UnitIsFriend("player","targettarget") then
	  if isTargetHpOver(0.7) then return end
		if castPowerInfusionOnMageInList(azs.targetList.dps) then return true end
		if castPowerInfusionOnMageInList(azs.targetList.multidps) then return true end
	end
	return false
end

function castPowerInfusionOnMageInList(targetList)
	for target,info in pairs(targetList) do
		if info.class == "MAGE" then
			if castPowerInfusion(info.name) then
				return true
			end
		end
	end
  return false
end

function castPowerInfusion(playerName)
	playerName = playerName or UnitName("target")
	if not azs.targetList[playerName] then return end
	for target,info in pairs(azs.targetList[playerName]) do
    CastSpellByName("Power Infusion")
		if IsValidSpellTarget(target) and not hasBuff(target, "Spell_Holy_PowerInfusion") then
      SpellStopTargeting()
      SendChatMessage("Power infusion on " .. playerName .. "!", "YELL")
      castBuff("Spell_Holy_PowerInfusion", "Power Infusion", target)
			return true
		end
	end
  SpellStopTargeting()
	return false
end
