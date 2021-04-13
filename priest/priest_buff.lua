function priest_raid_buff()
  cast_buff_player("Spell_Holy_InnerFire", "Inner Fire")
  buffTargetList("Spell_Holy_PrayerofSpirit", "Prayer of Spirit")
  buffTargetList("Spell_Holy_PrayerOfFortitude", "Prayer of Fortitude")
end

function priest_small_buff()
  cast_buff_player("Spell_Holy_InnerFire", "Inner Fire")
	buffTargetList("Spell_Holy_WordFortitude", "Power Word: Fortitude")
end
