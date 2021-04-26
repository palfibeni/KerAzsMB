function hunter_mana_burn_skull()
    if casting_or_channeling() then return end
    if is_target_skull() then
        cast_debuff("Ability_Hunter_AimedShot", "Viper Sting")
    else
        target_skull()
    end
end

function hunter_mana_burn_cross()
    if casting_or_channeling() then return end
    if is_target_cross() then
        cast_debuff("Ability_Hunter_AimedShot", "Viper Sting")
    else
        target_cross()
    end
end
