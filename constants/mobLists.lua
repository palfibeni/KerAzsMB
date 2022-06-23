-- Tranqualizable mobs:
TRANQABLE_MOBS = {"Magmadar", "Flamegor", "Chromaggus", "Maws", "Princess Huhuran",
  "Hakkar the Soulflayer", "Gluth", "Death Talon Seether", "Qiraji Slayer"}

-- Fire immune mobs:
FIRE_IMMUNE_MOBS = {"Nefarian", "Onyxia", "Firemaw", "Ebonroc", "Flamegore",
  "Firelord", "Firewalker", "Flameguard", "Lava Spawn", "Vaelastrasz",
  "Baron Geddon", "Ragnaros", "Pyroguard Emberseer", "Fireguard",
  "Fireguard Destroyer", "Blazing Fireguard", "Ambassador Flamelash",
  "Lord Incendius", "Blazing Elemental", "Inferno Elemental",
  "Scorching Elemental", "Living Blaze", "Blazerunner"}

-- High fire damage mobs:
HIGH_FIRE_DAMAGE_MOBS = {"Onyxia", "Firemaw", "Vaelastrasz",
  "Baron Geddon", "Ragnaros", "Pyroguard Emberseer", "Firewalker", "Flameguard"}

-- High frost damage mobs:
HIGH_FROST_DAMAGE_MOBS = {"Azuregos", "Sapphiron"}

-- High shadow damage mobs:
HIGH_SHADOW_DAMAGE_MOBS = {"Kazzak"}

FEARING_MOBS = {"Soulflayer", "Hakkari Priest", "High Priestess Jeklik",
  "Gurubashi Berserker", "Hakkari Blood Priest", "Nefarian", "Onyxia",
  "Postmaster Malown", "Sothos",  "Gordok Captain"}

function isTargetFireImmune()
  return isTargetInMobList(FIRE_IMMUNE_MOBS)
end

function isTargetInMobList(list)
  if not UnitExists("target") then return false end
  for k,mob in pairs(list) do
    if UnitName("target") == mob then
      return true
    end
  end
  return false
end
