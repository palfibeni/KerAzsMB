evocationActionSlot = 61
scorchActionSlot = 13
fireblastActionSlot = 14
fireballActionSlot = 15

lastScorch = 0

mageWeapon = nil
mageOffhand = nil

evoStart = 0

-- element can be Fire, Frost, Arcane
function mageAttack(mageElement)
	local mageElement = mageElement or azs.class.element
  if castingOrChanneling() then return end
	castEvocation()
  if isPlayerRelativeManaAbove(6) then
    stop_wand()
		mageCooldown()
		castMageWards()
		mageMainDamageSource(mageElement)
	elseif hasManaGem() then
		useManaGem()
  else
    use_wand()
  end
end

function mageCooldown()
	if isTargetHpUnder(0.7) then
		if useTrinkets() then return end
		cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
		cast_buff_player("Spell_Nature_EnchantArmor", "Presence of Mind")
		cast_buff_player("Spell_Fire_SealOfFire", "Combustion")
		useRacials()
	end
end

function mageMainDamageSource(mageElement)
	if mageElement == "Fire" and not isTargetInMobList(FIRE_IMMUNE_MOBS) then
		fireRotation()
	elseif mageElement == "Arcane" then
		CastSpellByName("Arcane Missiles")
	else
		CastSpellByName("Frostbolt")
	end
end

function fireRotation()
	if azs.class.talent == MAGE_FIRE then
		stackScorch()
	end
	-- fireblast()
	fireball()
end

function stackScorch()
	if IsActionReady(scorchActionSlot) then
			if get_debuff_count("target", "Spell_Fire_SoulBurn") < 5 or lastScorch + 25 < GetTime() then
					CastSpellByName("Scorch")
					lastScorch = GetTime()
			end
		end
end

function fireblast()
	if IsActionReady(fireblastActionSlot) then
		CastSpellByName("Fire Blast")
	end
end

function fireball()
	if IsActionReady(fireballActionSlot) then
		CastSpellByName("Fireball")
	end
end

function castEvocation()
	if evoStart + 8 < GetTime() and mageWeapon ~= nil then
		equipItemByItemLink(mageWeapon,16)
		equipItemByItemLink(mageOffhand,17)
		mageWeapon = nil
		mageOffhand = nil
	end
  if IsActionReady(evocationActionSlot) and isPlayerRelativeManaBelow(8) then
		mageWeapon = GetInventoryItemLink("player",16)
		mageOffhand = GetInventoryItemLink("player",17)
		useItem("Will of Arlokk")
		evoStart = GetTime()
		CastSpellByName("Evocation")
	end
end

function castMageWards()
	if isTargetInMobList(HIGH_FIRE_DAMAGE_MOBS) then
		castFireWard()
	end
	if isTargetInMobList(HIGH_FROST_DAMAGE_MOBS) then
		castFrostWard()
	end
end

function castFireWard()
	if GetSpellCooldownByName("Fire Ward")  then
			CastSpellByName("Fire Ward")
	end
end

function castFrostWard()
	if GetSpellCooldownByName("Frost Ward")  then
			CastSpellByName("Frost Ward")
	end
end

-- function mageAttackNew(mageElement)
-- 	local mageElement = mageElement or azs.class.element
--   if castingOrChanneling() then return end
-- 	castEvocation()
--   if isPlayerRelativeManaAbove(6) then
--     stop_wand()
-- 		local spell = getNextSpellToCast(mageElement)
-- 		if spell then CastSpellByName(spell)
-- 	elseif hasManaGem() then
-- 		useManaGem()
--   else
--     use_wand()
--   end
-- end
--
-- function getNextSpellToCast(mageElement)
-- 	if castingOrChanneling() then return nil end
-- 	if isTargetHpUnder(0.7) then
-- 		if GetSpellCooldownByName("Arcane Power") == 0 then return "Arcane Power" end
-- 		if GetSpellCooldownByName("Presence of Mind") == 0 then return "Presence of Mind" end
-- 		if GetSpellCooldownByName("Combustion") == 0 then return "Combustion" end
-- 	end
-- 	if isTargetInMobList(HIGH_FIRE_DAMAGE_MOBS) GetSpellCooldownByName("Fire Ward") == 0 then return "Fire Ward" end
-- 	if isTargetInMobList(HIGH_FROST_DAMAGE_MOBS) GetSpellCooldownByName("Frost Ward") == 0 then return "Frost Ward" end
-- 	if mageElement == "Fire" and not isTargetInMobList(FIRE_IMMUNE_MOBS) then
-- 		if azs.class.talent == MAGE_FIRE and IsActionReady(scorchActionSlot) and get_debuff_count("target", "Spell_Fire_SoulBurn") < 5 or lastScorch + 25 < GetTime() then
-- 			return "Scorch"
-- 		end
-- 		return "Fireball"
-- 	elseif mageElement == "Arcane" then
-- 		return "Arcane Missiles"
-- 	else
-- 		return "Frostbolt"
-- 	end
-- end
