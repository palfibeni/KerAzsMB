-- burst heal:
-- /target Cooperbeard
-- /cast Divine Favor
-- /cast Flash of Light

function pala_heal_group1()
    pala_heal_by_group(1)
end

function pala_heal_group2()
    pala_heal_by_group(2)
end

function pala_heal_group3()
    pala_heal_by_group(3)
end

function pala_heal_group4()
    pala_heal_by_group(4)
end

function pala_heal_by_group(group)
	if (GetRaidTargetIndex("player") == 8 ) then
		SpellStopCasting()
		return
	end
    exact_target_by_name(group_list[group].tank)
    pala_heal_tank()
    pala_heal_self()
    exact_target_by_name(group_list[group].heal)
    pala_heal_dps()
    for i,dps in pairs(group_list[group].dps_list) do
		exact_target_by_name(dps)
        pala_heal_dps()
	end
    if UnitMana("player") / UnitManaMax("player") < 0.5 then
        UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
        UseInventoryItem(GetInventorySlotInfo("Trinket1Slot"));
    end
end

function pala_heal_tank()
    if not UnitExists("target") then return end
    if UnitIsDead("target") then return end
    if casting_or_channeling() then return end
    pala_cleanse()
    pala_heal_under_50()
    lay_on_hand()
    heal_under_percent(0.8, "Flash of Light")
end

function pala_cleanse()
    remove_debuff_types_target({"Magic", "Poison"}, "Cleanse")
end

function pala_heal_under_50()
    if is_target_hp_under(0.5) then
        CastSpellByName("Divine Favor")
        CastSpellByName("Holy Light")
    end
end

function lay_on_hand()
    if is_target_hp_under(0.15) and UnitMana("player") < 1000 then
        CastSpellByName("Lay on Hands")
    end
end

function pala_heal_self()
    local cd = GetActionCooldown(61)
    if is_player_hp_under(0.4) and cd == 0 then
        CastSpellByName("Divine Shield")
    end
end

function pala_heal_dps()
    if not UnitExists("target") then return end
    if casting_or_channeling() then return end
    heal_under_percent(0.2, "Blessing of Protection")
    pala_cleanse()
    heal_under_percent(0.4, "Holy Light")
    heal_under_percent(0.7, "Flash of Light")
end
