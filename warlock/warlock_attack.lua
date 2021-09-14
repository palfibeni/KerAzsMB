corruptionEnabled = false;

function warlock_skull(curse, element)
	if azs.targetSkull() then
		warlockAttack(curse, element)
	end
end

function warlock_cross(curse, element)
	if azs.targetCross() then
		warlockAttack(curse, element)
	end
end

-- ATTACK
function warlockAttack(curse, element)
	curse = curse or azs.class.curse
	element = element or azs.class.element
	if castingOrChanneling() then return end
	if (UnitMana("player") >= (UnitLevel("player") * 6)) then
		stop_wand()
		if isTargetHpUnder(0.7) then
			-- Useable trinkets
			UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
			UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
		end
		if element == "Fire" then
			CastSpellByName("Immolation")
		else
			corruption()
			warlockCurse(curse)
			CastSpellByName("Shadow Bolt")
		end
	elseif (isPlayerHpOver(0.3)) then
		CastSpellByName("Life Tap")
	else
		use_wand()
	end
end

function warlockCurse(curse)
	if curse == "CoS" then
		cast_debuff("Spell_Shadow_CurseOfAchimonde", "Curse of Shadow")
	elseif curse == "CoE" then
		cast_debuff("Spell_Shadow_ChillTouch", "Curse of the Elements")
	elseif curse == "CoA" then
		CastSpellByName("Amplify Curse")
		cast_debuff("Spell_Shadow_CurseOfSargeras", "Curse of Agony")
	elseif curse == "CoT" then
		cast_debuff("Spell_Shadow_CurseOfTounges", "Curse of Tounges")
	elseif curse == "CoR" then
		cast_debuff("Spell_Shadow_UnholyStrength", "Curse of Recklessness")
	elseif curse == "CoW" then
		CastSpellByName("Amplify Curse")
		cast_debuff("Spell_Shadow_CurseOfMannoroth", "Curse of Weakness")
	end
end

function corruption()
	if corruptionEnabled then
		cast_debuff("Spell_Shadow_AbominationExplosion", "Corruption")
	end
end
