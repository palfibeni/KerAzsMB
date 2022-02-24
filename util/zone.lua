function isInAQ40()
  return GetRealZoneText() == AQ40
end

function isInAQ20()
  return GetRealZoneText() == AQ20
end

function isInBWL()
  return GetRealZoneText() == BWL
  -- GetMinimapZoneText() Dragonmaw Garrison (Razorgore the Untamed)
  -- GetMinimapZoneText() Shadow Wing Lair (Vaelastrasz the Corrupt)
  -- GetMinimapZoneText() Halls of Strife (Broodlord Lashlayer)
  -- GetMinimapZoneText() Crimson Laboratories (Firemaw, Ebonroc, Flamegor, Chromaggus)
  -- GetMinimapZoneText() Nefarian's Lair (Nefarian, Black Drakonid, Blue Drakonid, Bronze Drakonid, Green Drakonid, Red Drakonid Chromatic Drakonid)
end

function isInMC()
  return GetRealZoneText() == MC
end

function isInZG()
  return GetRealZoneText() == ZG
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

function isInNaxx()
  return GetRealZoneText() == NAXX
end

function isInSubZone(subZone)
  return GetMinimapZoneText() == subZone
end

function hasMandokirGaze()
	return isInZG() and has_debuff("player", "Spell_Shadow_Charm")
end
