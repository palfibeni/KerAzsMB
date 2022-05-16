function shamanAttack()
  if castingOrChanneling() then return end
  if isTargetHpUnder(0.7) then
		shamanCooldown()
	end
  if player_hasBuff("Spell_Shadow_ManaBurn") then
		CastSpellByName("Chain Lightning")
	end
	-- CastSpellByName("Earth Shock")
	CastSpellByName("Lightning Bolt")
  use_autoattack()
end

function shamanCooldown()
  cast_buff_player("Spell_Nature_WispHeal", "Elemental Mastery")
  useRacials()
  if useTrinkets() then return end
end
