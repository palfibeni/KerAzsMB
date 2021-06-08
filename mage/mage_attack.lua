evocationActionSlot = 61

-- DEPRECTED
-- /script mage_attack_skull()
function mage_attack_skull()
	if azs.targetSkull() then
      mageAttack()
	end
end

-- DEPRECTED
-- /script mage_attack_cross()
function mage_attack_cross()
	if azs.targetCross() then
      mageAttack()
	end
end

-- element can be Fire, Frost, Arcane
function mageAttack(mageElement)
	mageElement = mageElement or azs.class.element
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
  if casting_or_channeling() then return end
  if (UnitMana("player") >= (UnitLevel("player") * 6)) then
    stop_wand()
		if is_target_hp_under(0.7) then
			cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
			SpellStopCasting()
			cast_buff_player("Spell_Nature_EnchantArmor", "Presence of Mind")
			SpellStopCasting()
			-- Useable trinkets
		  UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
			UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		end
		if mageElement == "Fire" then
			CastSpellByName("Fire Blast")
			CastSpellByName("Fireball")
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
