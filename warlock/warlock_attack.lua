-- SKULL
-- /script warlock_skull_cos()
function warlock_skull_cos()
	warlock_skull("CoS", "Shadow")
end

-- /script warlock_skull_coe()
function warlock_skull_coe()
	warlock_skull("CoE", "Shadow")
end

-- /script warlock_skull_coa()
function warlock_skull_coa()
	warlock_skull("CoA", "Shadow")
end

-- /script warlock_skull_cow()
function warlock_skull_cow()
	warlock_skull("CoW", "Shadow")
end
-- /script warlock_skull_cos()
function warlock_skull_cos_fire()
	warlock_skull("CoS", "Fire")
end

-- /script warlock_skull_coe()
function warlock_skull_coe_fire()
	warlock_skull("CoE", "Fire")
end

function warlock_skull(curse, element)
	if is_target_skull() then
		warlock_attack(curse, element)
	else
		target_skull()
	end
end

-- CROSS
-- /script warlock_cross_cos()
function warlock_cross_cos()
	warlock_cross("CoS", "Shadow")
end

-- /script warlock_cross_coe()
function warlock_cross_coe()
	warlock_cross("CoE", "Shadow")
end

-- /script warlock_cross_coa()
function warlock_cross_coa()
	warlock_cross("CoA", "Shadow")
end

-- /script warlock_cross_cow()
function warlock_cross_cow()
	warlock_cross("CoW", "Shadow")
end

function warlock_cross(curse, element)
	if is_target_cross() then
		warlock_attack(curse, element)
	else
		target_cross()
	end
end

-- ATTACK
function warlock_attack(curse, element)
	if casting() then return end
	if (UnitMana("player") >= (UnitLevel("player") * 6)) then
		stop_wand()
		-- Useable trinkets
        UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
        UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		if element == "Fire" then
	        CastSpellByName("Immolation")
		else
			warlock_curse(curse)
			CastSpellByName("Shadow Bolt")
		end
	elseif (is_player_hp_over(0.3)) then
		CastSpellByName("Life Tap")
	else
		use_wand()
	end
end

function warlock_curse(curse)
	if curse == "CoS" then
		cast_debuff("Spell_Shadow_CurseOfAchimonde", "Curse of Shadow")
	elseif curse == "CoE" then
		cast_debuff("Spell_Shadow_ChillTouch", "Curse of the Elements")
	elseif curse == "CoA" then
		cast_debuff("Spell_Shadow_CurseOfSargeras", "Curse of Agony")
	elseif curse == "CoW" then
		corruption()
		CastSpellByName("Amplify Curse")
		cast_debuff("Spell_Shadow_CurseOfMannoroth", "Curse of Weakness")
	end
end

function corruption()
	cast_debuff("Spell_Shadow_AbominationExplosion", "Corruption")
end
