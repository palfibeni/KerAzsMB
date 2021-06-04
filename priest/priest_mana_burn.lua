function priest_mana_burn_skull()
    if casting_or_channeling() then return end
    if azs.targetSkull() then
      if casting_or_channeling() then return end
      CastSpellByName("Mana Burn")
    end
end

function priest_mana_burn_cross()
    if casting_or_channeling() then return end
    if azs.targetCross() then
      if casting_or_channeling() then return end
      CastSpellByName("Mana Burn")
    end
end
