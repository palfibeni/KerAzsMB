evocationActionSlot = 61

-- /script mage_attack_skull()
-- element can be Fire, Frost, Arcane
function mage_attack_skull(element)
	element=element or "Frost"
	if is_target_skull() then
        mage_attack(element)
	else
		target_skull()
	end
end

-- /script mage_attack_cross()
-- element can be Fire, Frost, Arcane
function mage_attack_cross(element)
	element=element or "Frost"
	if is_target_cross() then
        mage_attack(element)
	else
		target_cross()
	end
end

function mage_attack(element)
	element=element or "Frost"
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    if casting_or_channeling() then return end
    if (UnitMana("player") >= (UnitLevel("player") * 6)) then
      stop_wand()
			if is_target_hp_under(0.7) then
				cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
				-- Useable trinkets
			  UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
				UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
			end
			if element == "Fire" then
				CastSpellByName("Fire Blast")
				CastSpellByName("Fireball")
			elseif element == "Arcane" then
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
