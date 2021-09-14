-- /script hunter_mana_burn_skull()
function hunter_mana_burn_skull()
    if castingOrChanneling() then return end
    if azs.targetSkull() then
        hunterManaDrain()
    end
end

function hunter_mana_burn_cross()
    if castingOrChanneling() then return end
    if azs.targetCross() then
        hunterManaDrain()
    end
end

function hunterManaDrain()
  cast_debuff("Ability_Hunter_AimedShot", "Viper Sting")
end
