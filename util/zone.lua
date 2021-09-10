function isInBWL()
  return GetRealZoneText() == "Blackwing Lair"
  -- GetMinimapZoneText() Dragonmaw Garrison (Razorgore the Untamed)
  -- GetMinimapZoneText() Shadow Wing Lair (Vaelastrasz the Corrupt)
  -- GetMinimapZoneText() Halls of Strife (Broodlord Lashlayer)
  -- GetMinimapZoneText() Crimson Laboratories (Firemaw, Ebonroc, Flamegor, Chromaggus)
  -- GetMinimapZoneText() Nefarian's Lair (Nefarian, Black Drakonid, Blue Drakonid, Bronze Drakonid, Green Drakonid, Red Drakonid Chromatic Drakonid)
end

function isInMC()
  return GetRealZoneText() == "Molten Core"
end


function isInZG()
  return GetRealZoneText() == "Zul'Gurub"
  -- GetMinimapZoneText() Altar of Hir'eek (High Priestess Jeklik)
  -- GetMinimapZoneText() Coil (High Priest Venoxis)
  -- GetMinimapZoneText() Shadra'zaar (High Priestess Mar'li)
  -- GetMinimapZoneText() Hakkari Grounds (Bloodlord Mandokir)
  -- GetMinimapZoneText() Naze of Shirvallah (High Priest Thekal)
  -- GetMinimapZoneText() Edge of Madness (Gri'lek, Renataki, Hazza'rah, Wushoolay)
  -- GetMinimapZoneText() Temple of Bethekk (High Priestess Arlokk)
  -- GetMinimapZoneText() Pagle's Pointe (Gahz'ranka)
  -- GetMinimapZoneText() Bloodfire Pit (Jin'do the Hexxer, Brain Wash Totem, Powerful Healing Ward, Shade of Jin'do)
  -- GetMinimapZoneText() Altar of the Blood God (Hakkar the Soulflayer)
end

function hasMandokirGaze()
	return has_debuff("player", "Spell_Shadow_Charm")
end
