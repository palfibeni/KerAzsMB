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

function mageBuff()
  if UnitLevel("player") == 60 then
    buffTargetList("Spell_Holy_ArcaneIntellect", "Arcane Brilliance")
    cast_buff_player("Spell_MageArmor", "Mage Armor")
  else
    buffTargetList("Spell_Holy_MagicalSentry", "Arcane Intellect")
  end
end

function mageArmor()
  if UnitLevel("player") >= 34 then
    cast_buff_player("Spell_MageArmor", "Mage Armor")
  elseif if UnitLevel("player") >= 30
    cast_buff_player("Spell_Frost_FrostArmor02", "Ice Armor")
  else
    cast_buff_player("Spell_Frost_FrostArmor02", "Frost Armor")
end
