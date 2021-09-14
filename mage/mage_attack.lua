evocationActionSlot = 61

-- element can be Fire, Frost, Arcane
function mageAttack(mageElement)
	mageElement = mageElement or azs.class.element
  if castingOrChanneling() then return end
  if (UnitMana("player") >= (UnitLevel("player") * 6)) then
    stop_wand()
		if isTargetHpUnder(0.7) then
			cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
			cast_buff_player("Spell_Nature_EnchantArmor", "Presence of Mind")
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
