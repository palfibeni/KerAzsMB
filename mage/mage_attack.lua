evocationActionSlot = 61
scorchActionSlot = 13
fireblastActionSlot = 14
fireballActionSlot = 15

lastScorch = 0

-- element can be Fire, Frost, Arcane
function mageAttack(mageElement)
	mageElement = mageElement or azs.class.element
  if castingOrChanneling() then return end
  if (UnitMana("player") >= (UnitLevel("player") * 6)) then
    stop_wand()
		if isTargetHpUnder(0.7) then
			if useTrinkets() then return end
			cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
			cast_buff_player("Spell_Nature_EnchantArmor", "Presence of Mind")
			cast_buff_player("Spell_Fire_SealOfFire", "Combustion")
		end
		if mageElement == "Fire" and not isTargetInMobList(FIRE_IMMUNE_MOBS) then
			fireRotation()
		elseif mageElement == "Arcane" then
			CastSpellByName("Arcane Missiles")
		else
			CastSpellByName("Frostbolt")
		end
  elseif IsActionReady(evocationActionSlot) then
      CastSpellByName("Evocation")
  else
      use_wand()
  end
end

function fireRotation()
	if azs.class.talent == MAGE_FIRE then
		stackScorch()
	end
	fireblast()
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
