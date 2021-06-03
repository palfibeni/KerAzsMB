-- /script hunter_mana_burn_skull()
function hunter_mana_burn_skull()
    if casting_or_channeling() then return end
    if azs.targetCross() then
        hunterManaDrain()
    else
        azs.targetSkull()
    end
end

function hunter_mana_burn_cross()
    if casting_or_channeling() then return end
    if azs.targetCross() then
        hunterManaDrain()
    else
        azs.targetCross()
    end
end

function hunterManaDrain()
  cast_debuff("Ability_Hunter_AimedShot", "Viper Sting")
end
