-- /script mage_raid_buff()
function mage_raid_buff()
    buffTargetList("Spell_Holy_ArcaneIntellect", "Arcane Brilliance")
    mage_armor()
end

function mage_small_int()
	buffTargetList("Spell_Holy_MagicalSentry", "Arcane Intellect")
end

function mage_armor()
    cast_buff_player("Spell_MageArmor", "Mage Armor")
end

function mage_amplify()
    cast_buff("Spell_Holy_FlashHeal", "Amplify Magic")
end

function mage_water()
  if count_item("Conjured Crystal Water") < 39 then
    CastSpellByName("Conjure Water")
  end
end
