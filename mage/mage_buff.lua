manaGems = {"Mana Ruby", "Mana Citrine", "Mana Jade", "Mana Agate"}

function mage_amplify()
  cast_buff("Spell_Holy_FlashHeal", "Amplify Magic")
end

function mageBuff()
  if UnitLevel("player") == 60 then
    buffTargetList("Spell_Holy_ArcaneIntellect", "Arcane Brilliance")
    mageArmor()
    craftManaGem()
  else
    buffTargetList("Spell_Holy_MagicalSentry", "Arcane Intellect")
    mageArmor()
    craftManaGem()
  end
end

-- /script mageArmor()
function mageArmor()
  if UnitLevel("player") >= 34 then
    cast_buff_player("Spell_MageArmor", "Mage Armor")
  elseif UnitLevel("player") >= 30 then
    cast_buff_player("Spell_Frost_FrostArmor02", "Ice Armor")
  else
    cast_buff_player("Spell_Frost_FrostArmor02", "Frost Armor")
  end
end

function craftManaGem(manaGem)
  local manaGem = manaGem or deduceManaGem()
  if hasManaGem(manaGem) then return end
  if manaGem ~= nil then
    CastSpellByName("Conjure " .. manaGem)
  end
end

function hasManaGem(manaGem)
  local manaGem = manaGem or deduceManaGem()
  return manaGem ~= nil and findItemInInventory(manaGem) ~= nil
end

function useManaGem(manaGem)
  local manaGem = manaGem or deduceManaGem()
  if hasManaGem() then
    useItem(manaGem)
  end
end

function deduceManaGem()
  if UnitLevel("player") == 60 then return "Mana Ruby" end
  if UnitLevel("player") < 28 then return nil end
  if UnitLevel("player") < 38 then return "Mana Agate" end
  if UnitLevel("player") < 48 then return "Mana Jade" end
  if UnitLevel("player") < 60 then return "Mana Citrine" end
end
