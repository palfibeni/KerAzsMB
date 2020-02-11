function priest_heal_group1()
    priest_heal_by_group(1)
end

function priest_heal_group2()
    priest_heal_by_group(2)
end

function priest_heal_by_group(group)
    TargetByName(group_list[group].tank)
    priest_heal_tank()
    priest_heal_self()
    TargetByName(group_list[group].heal)
    priest_heal_dps()
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        priest_heal_dps()
	end
end

function priest_heal_self()
    if is_player_hp_under(0.25) then
        if casting_or_channeling() then SpellStopCasting() end
        cast("Desperate Prayer")
        cast("Fade")
    end
end

function priest_heal_tank()
    if UnitIsDead("target") then return end
    heal_under_percent(0.4, "Flash Heal")
    heal_under_percent(0.7, "Heal")
    priest_shield_over_70()
    fear_ward()
end

function priest_dispel()
    for x=1,16 do
	    local name,count,debuffType=UnitDebuff("target",x,1)
	    if debuffType=="Magic" then
            cast("Dispel Magic")
        end
    end
end

function priest_heal_dps()
    if casting_or_channeling() then return end
    if UnitIsDead("target") then return end
    priest_dispel()
    heal_under_percent(0.5, "Flash Heal")
end

function priest_shield_over_70()
    if casting_or_channeling() then return end
    if is_target_hp_over(0,7) then
        if (UnitMana("player")>=2000) then
            cast("Power Word: Shield")
        end
    end
end

function fear_ward()
    cast_buff("Spell_Holy_Excorcism", "Fear Ward")
end
