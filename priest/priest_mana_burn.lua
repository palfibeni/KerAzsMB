function priest_mana_burn_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        cast('Mana Burn')
    else
        target_skull()
    end
end

function priest_mana_burn_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        cast('Mana Burn')
    else
        target_cross()
    end
end