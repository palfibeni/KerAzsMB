lastFireTotem = 0

function shamanAttack()
  if castingOrChanneling() then return end
  if player_hasBuff("Spell_Shadow_Manaburn") then
		CastSpellByName("Chain Lightning")
	end
  fireTotem()
	CastSpellByName("Earth Shock")
	CastSpellByName("Lightning Bolt")
  use_autoattack()
end

function fireTotem()
  if lastFireTotem + 20 < GetTime() then
    CastSpellByName(getFireTotemByLevel())
    lastFireTotem = GetTime()
  end
end

function getFireTotemByLevel()
  if UnitLevel("player") > 25 then
    return "Magma Totem"
  end
  return "Searing Totem"
end
