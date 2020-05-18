-- SUCCUBUS
function warlock_buffs_succubus()
    demon_armor()
    demonic_sacrifice()
end

-- IMP
function warlock_buffs_imp()
    demon_armor()
    summon_imp()
end

function demon_armor()
    if player_has_buff("Spell_Shadow_RagingScream") then
        return
    end
    if (UnitMana("player") >= (UnitLevel("player") * 26)) then
        cast("Demon Armor")
    else
        cast("Life Tap")
    end
end

function demonic_sacrifice()
    if player_has_buff("Spell_Shadow_PsychicScream") then
        return
    end
    cast("Demonic Sacrifice")
    if (UnitMana("player") >= (UnitLevel("player") * 22)) then
        cast("Fel Domination")
        cast("Summon Succubus")
    else
        cast("Life Tap")
    end
end

function summon_imp()
    if player_has_buff("Spell_Shadow_BloodBoil") then
        return
    end
    if (UnitMana("player") >= (UnitLevel("player") * 16)) then
        cast("Fel Domination")
        cast("Summon Imp")
    else
        cast("Life Tap")
    end
end
