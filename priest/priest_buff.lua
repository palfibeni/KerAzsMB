function priest_raid_buff()
  holyFire()
  buffTargetList("Spell_Holy_PrayerofSpirit", "Prayer of Spirit")
  buffTargetList("Spell_Holy_PrayerOfFortitude", "Prayer of Fortitude")
end

function priest_small_buff()
  holyFire()
	buffTargetList("Spell_Holy_WordFortitude", "Power Word: Fortitude")
end

function holyFire()
  cast_buff_player("Spell_Holy_InnerFire", "Inner Fire")
end
