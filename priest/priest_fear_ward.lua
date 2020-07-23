function fear_ward_tanks()
	for i,tank in pairs(tank_list) do
		exact_target_by_name(tank)
        if not UnitName("targettarget") == nil then
            cast_buff("Spell_Holy_Excorcism", "Fear Ward")
        end
	end
	return nil
end
