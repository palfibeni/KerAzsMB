function warrior_fury_aoe_skull()
	if azs.targetCross() then
        warrior_fury_aoe()
	else
		stop_autoattack()
		azs.targetSkull()
	end
end

function warrior_fury_aoe_cross()
	if azs.targetCross() then
        warrior_fury_aoe()
	else
		stop_autoattack()
		azs.targetCross()
	end
end

function warrior_fury_aoe()
	warriorBerserkerStance()
	berserkerRage()
	bloodrage()
	whirlwind()
  CastSpellByName("Cleave")
	use_autoattack()
end
