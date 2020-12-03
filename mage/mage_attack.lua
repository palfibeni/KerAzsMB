evocationActionSlot = 61

-- /script mage_attack_skull()
function mage_attack_skull()
	if is_target_skull() then
        mage_attack("Frost")
	else
		target_skull()
	end
end

-- /script mage_attack_cross()
function mage_attack_cross()
	if is_target_cross() then
        mage_attack("Frost")
	else
		target_cross()
	end
end

-- /script mage_attac_fire_skull()
function mage_attac_fire_skull()
	if is_target_skull() then
        mage_attack("Fire")
	else
		target_skull()
	end
end

-- /script mage_attack_fire_cross()
function mage_attack_fire_cross()
	if is_target_cross() then
        mage_attack("Fire")
	else
		target_cross()
	end
end

-- /script mage_attac_arcane_skull()
function mage_attac_arcane_skull()
	if is_target_skull() then
        mage_attack("Arcane")
	else
		target_skull()
	end
end

-- /script mage_attack_arcane_cross()
function mage_attack_arcane_cross()
	if is_target_cross() then
        mage_attack("Arcane")
	else
		target_cross()
	end
end

function mage_attack(element)
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    if casting_or_channeling() then return end
    local evoc, dur_evoc, en_evoc = GetActionCooldown(evocationActionSlot)
    if (UnitMana("player")>= (UnitLevel("player") * 6)) then
        stop_wand()
		if is_target_hp_under(0.7) then
			cast_buff_player("Spell_Nature_Lightning", "Arcane Power")
			-- Useable trinkets
	        UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
			UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		end
		if element == "Fire" then
	        CastSpellByName("Fireball")
		elseif element == "Arcane" then
	        CastSpellByName("Arcane Missles")
		else
			CastSpellByName("Frostbolt")
		end
    elseif (evoc == 0) then
        CastSpellByName("Evocation")
    else
        use_wand()
    end
end
