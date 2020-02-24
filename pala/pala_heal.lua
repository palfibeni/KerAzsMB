function pala_heal_group1()
    pala_heal_by_group(1)
end

function pala_heal_group2()
    pala_heal_by_group(2)
end

function pala_heal_by_group(group)
    TargetByName(group_list[group].tank)
    pala_heal_tank()
    priest_heal_self()
    TargetByName(group_list[group].heal)
    pala_heal_dps()
    for i,dps in pairs(group_list[group].dps_list) do
		TargetByName(dps)
        pala_heal_dps()
	end
end

function pala_heal_tank()
    if UnitIsDead("target") then return end
    pala_cleanse()
    pala_heal_under_50()
    lay_on_hand()
    heal_under_percent(0.8, "Flash of Light")
end

function pala_cleanse()
    for x=1,16 do
	    local name,count,debuffType=UnitDebuff("target",x,1)
	    if debuffType=="Magic" then
            cast("Cleanse")
        end
    end
end

function pala_heal_under_50()
    if is_target_hp_under(0.4) then
        cast("Divine Favor")
        cast("Holy Light")
    end
end

function lay_on_hand()
    if is_target_hp_under(0.15) and UnitMana("player") < 1000 then
        if casting_or_channeling() then SpellStopCasting() end
        cast("Lay on Hands")
    end
end

function pala_heal_self()
    if is_player_hp_under(0.4) then
        if casting_or_channeling() then SpellStopCasting() end
        cast("Divine Shield")
    end
end

function pala_heal_dps()
    heal_under_percent(0.2, "Blessing of Protection")
    pala_cleanse()
    heal_under_percent(0.4, "Holy Light")
    heal_under_percent(0.7, "Flash of Light")
end
