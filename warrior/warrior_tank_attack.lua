heroicStrikeActionSlot = 13
revengeActionSlot = 14
sunderArmorActionSlot = 15
bloodrageActionSlot = 16
shieldSlamActionSlot = 17
lastStandActionSlot = 18
shieldWallActionSlot = 19
mockingBlowActionSlot = 20

lastSunder = 0
lastDoDefCooldown = 0

function warrior_tank_attack_skull()
	if azs.targetSkull() then
		warriorTankAttack()
	end
end

function warrior_tank_attack_cross()
	if azs.targetCross() then
		warriorTankAttack()
	end
end

function warriorTankAttack()
	local isMainTank = isMainTankByName(UnitName("player"))
	bloodrage()
	if warriorAutoTaunt() then return end
	warriorDefenseStance()
	if not IsCurrentAction(heroicStrikeActionSlot) and UnitMana("player") >= 50 then
		CastSpellByName("Heroic Strike")
	end
	highThreatAttack()
	if IsActionReady(revengeActionSlot) then
		CastSpellByName("Revenge")
  end
	sunderArmor(isMainTank)
	if not isMainTank then
		warriorDemoShout()
	end
	if UnitMana("player") >= 40 then
		CastSpellByName("Shield Block")
	end
	doDefCooldown()
	use_autoattack()
end

function warriorDefenseStance()
	local icon, name, active, castable = GetShapeshiftFormInfo(2);
	if not active then
		CastSpellByName("Defensive Stance")
	end
end

function highThreatAttack()
	if azs.class.talent == WARRIOR_FURY_PROT then
		if IsActionReady(bloodThirstActionSlot) and  UnitMana("player") >= 30 then
			CastSpellByName("Bloodthirst")
		end
	else
		if IsActionReady(shieldSlamActionSlot) and UnitMana("player") >= 20 then
			CastSpellByName("Shield Slam")
	  end
	end
end

function warriorAutoTaunt()
	if not azs.warriorTauntEnabled then return false end
	if UnitName("targettarget") == nil then return false end
	if isTankByName(UnitName("targettarget")) then return false end
	if UnitIsEnemy("target","player") then
		return warriorTaunt()
	end
	return false
end

function warriorTaunt()
	if UnitName("targettarget") == UnitName("player") then return false end
	if GetSpellCooldownByName("Taunt") < 1 then
		warriorDefenseStance()
		CastSpellByName("Taunt")
		return true
	elseif GetSpellCooldownByName("Mocking Blow") < 1 then
		warriorBattleStance()
		CastSpellByName("Mocking Blow")
		return true
	end
	return false
end

function bloodrage()
  if IsActionReady(bloodrageActionSlot) then
		CastSpellByName("Bloodrage")
  end
end

function sunderArmor(isMainTank)
	if isMainTank and UnitMana("player") >= 62 then
		CastSpellByName("Sunder Armor")
		return
	end
	if IsActionReady(sunderArmorActionSlot) and UnitMana("player") >= 12 then
		if get_debuff_count("target", "Ability_Warrior_Sunder") < 5 or lastSunder + 20 < GetTime() then
			CastSpellByName("Sunder Armor")
			lastSunder = GetTime()
		end
	end
end

function doDefCooldown()
	if lastDoDefCooldown + 10 > GetTime() then return end
	if isPlayerHpUnder(0.2) and IsActionReady(lastStandActionSlot) then
		lastStand()
	elseif isPlayerHpUnder(0.15) and IsActionReady(shieldWallActionSlot) then
		shieldWall()
	elseif isPlayerHpUnder(0.15) then
		useItem("Major Healing Potion")
		lastDoDefCooldown = GetTime()
	end
end

function lastStand()
	CastSpellByName("Last Stand")
	SendChatMessage(UnitName("player") .. " is below 20% health, using Last Stand!", "YELL")
	lastDoDefCooldown = GetTime()
end

function shieldWall()
	CastSpellByName("Shield Wall")
	SendChatMessage(UnitName("player") .. " is below 15% health, using Shield Wall!", "YELL")
	lastDoDefCooldown = GetTime()
end
