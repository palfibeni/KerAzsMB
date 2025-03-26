corruptionEnabled = false;

-- ATTACK
function warlockAttack(params)
	local curse = params.curse or azs.class.curse
	local element = params.element or azs.class.element
	if castingOrChanneling() then return end
	if isPlayerRelativeManaAbove(6) then
		stop_wand()
		if isTargetHpUnder(0.7) then
			if useTrinkets() then return end
		end
		if element == "Fire" then
			CastSpellByName("Searing Pain")
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
