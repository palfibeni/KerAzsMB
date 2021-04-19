function warlock_skull(curse, element)
	curse = curse or "CoE"
	element = element or "Shadow"
	if is_target_skull() then
		warlock_attack(curse, element)
	else
		target_skull()
	end
end

function warlock_cross(curse, element)
	curse = curse or "CoE"
	element = element or "Shadow"
	if is_target_cross() then
		warlock_attack(curse, element)
	else
		target_cross()
	end
end

-- ATTACK
function warlock_attack(curse, element)
	curse = curse or "CoE"
	element = element or "Shadow"
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
	if casting_or_channeling() then return end
	if (UnitMana("player") >= (UnitLevel("player") * 6)) then
		stop_wand()
		if is_target_hp_under(0.7) then
			-- Useable trinkets
			UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
			UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		end
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
		corruption()
		CastSpellByName("Amplify Curse")
		cast_debuff("Spell_Shadow_CurseOfSargeras", "Curse of Agony")
	elseif curse == "CoT" then
		cast_debuff("Spell_Shadow_CurseOfTounges", "Curse of Tounges")
	elseif curse == "CoR" then
		cast_debuff("Spell_Shadow_UnholyStrength", "Curse of Recklessness")
	elseif curse == "CoW" then
		corruption()
		CastSpellByName("Amplify Curse")
		cast_debuff("Spell_Shadow_CurseOfMannoroth", "Curse of Weakness")
	end
end

function corruption()
	cast_debuff("Spell_Shadow_AbominationExplosion", "Corruption")
end
