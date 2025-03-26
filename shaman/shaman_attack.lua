function shamanElementalAttack()
  if castingOrChanneling() then return end
  if isTargetHpUnder(0.7) then
		shamanCooldown()
	end
  if player_hasBuff("Spell_Shadow_ManaBurn") then
		CastSpellByName("Chain Lightning")
	end
	CastSpellByName("Frost Shock")
	CastSpellByName("Lightning Bolt")
  use_autoattack()
end

function shamanCooldown()
  cast_buff_player("Spell_Nature_WispHeal", "Elemental Mastery")
  useRacials()
  if useTrinkets() then return end
end

function shamanCementAttack()
  if castingOrChanneling() then return end
  if isTargetHpUnder(0.5) then
		shamanCooldown()
	end
	CastSpellByName("Stormstrike")
	CastSpellByName("Frost Shock")
  use_autoattack()
end

function shamanCooldown()
  cast_buff_player("Spell_Nature_WispHeal", "Elemental Mastery")
  useRacials()
  if useTrinkets() then return end
end
