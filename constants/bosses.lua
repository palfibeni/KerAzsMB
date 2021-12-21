BOSSES_IN_MC = {"Lucifron", "Magmadar", "Gehennas", "Garr", "Shazzrah", "Baron Geddon",
"Golemagg the Incinerator", "Sulfuron Harbinger", "Majordomo Executus", "Ragnaros"}

BOSSES_IN_BWL = {"Razorgore the Untamed", "Vaelastrasz the Corrupt",
  "Broodlord Lashlayer", "Firemaw", "Ebonroc",
  "Flamegor", "Chromaggus", "Nefarian"}

BOSSES_IN_ZG = {"High Priestess Jeklik", "High Priest Venoxis", "High Priestess Mar'li",
  "Bloodlord Mandokir", "High Priest Thekal", "High Priestess Arlokk",
  "Gahz'ranka", "Jin'do the Hexxer", "Hakkar the Soulflayer"}

BOSSES_IN_AQ20 = {"Kurinnaxx", "General Rajaxx", "Moam", "Buru the Gorger",
  "Ayamiss the Hunter", "Ossirian the Unscarred"}

BOSSES_IN_AQ40 = {"The Prophet Skeram", "Battleguard Sartura", "Fankriss the Unyielding",
  "Princess Huhuran", "Vek'lor", "Vek'nilash", "C'Thun", "Yauj", "Vem", "Kri", "Viscidus", "Ouro"}

BOSSES_IN_NAXX = {
  --  The Arachnid Quarter
  "Anub'Rekhan", "Grand Widow Faerlina", "Maexxna",
  -- The Plague Quarter
  "Noth the Plaguebringer", "Heigan the Unclean", "Loatheb",
  -- The Military Quarter
  "Instructor Razuvious", "Gothik the Harvester", "The Four Horsemen",
  -- The Construct Quarter
  "Patchwerk", "Grobbulus", "Gluth", "Thaddius",
  -- Frostwyrm lastInner
  "Sapphiron", "Kel'Thuzad"}

function isTargetBossInMC()
  return isTargetInMobList(BOSSES_IN_MC)
end

function isTargetBossInBWL()
  return isTargetInMobList(BOSSES_IN_BWL)
end

function isTargetBossInZG()
  return isTargetInMobList(BOSSES_IN_ZG)
end

function isTargetBossInAQ20()
  return isTargetInMobList(BOSSES_IN_AQ20)
end

function isTargetBossInAQ40()
  return isTargetInMobList(BOSSES_IN_AQ40)
end

function isTargetBossInNaxx()
  return isTargetInMobList(BOSSES_IN_NAXX)
end
