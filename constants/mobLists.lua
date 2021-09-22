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
