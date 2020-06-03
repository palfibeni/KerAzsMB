-- SKULL
-- /script warlock_skull_cos()
function warlock_skull_cos()
	warlock_skull("CoS")
end

-- /script warlock_skull_coe()
function warlock_skull_coe()
	warlock_skull("CoE")
end

-- /script warlock_skull_coa()
function warlock_skull_coa()
	warlock_skull("CoA")
end

function warlock_skull(curse)
	if is_target_skull() then
		warlock_attack(curse)
	else
		target_skull()
	end
end

-- CROSS
function warlock_cross_cos()
	warlock_cross("CoS")
end

function warlock_cross_coe()
	warlock_cross("CoE")
end

function warlock_cross_coa()
	warlock_cross("CoA")
end

function warlock_cross(curse)
	if is_target_cross() then
		warlock_attack(curse)
	else
		target_cross()
	end
end

-- ATTACK
function warlock_attack(curse)
	if (UnitMana("player") >= (UnitLevel("player") * 6)) then
		stop_wand()
		-- Useable trinkets
        -- UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
        -- UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		warlock_curse(curse)
		corruption()
		cast("Shadow Bolt")
	elseif (is_player_hp_over(0.3)) then
		cast("Life Tap")
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
	end
end

function corruption()
	cast_debuff("Spell_Shadow_AbominationExplosion", "Corruption")
end
