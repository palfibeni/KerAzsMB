function warrior_fury_aoe_skull()
	if azs.targetSkull() then
        warrior_fury_aoe()
	else
		stop_autoattack()
	end
end

function warrior_fury_aoe_cross()
	if azs.targetCross() then
        warrior_fury_aoe()
	else
		stop_autoattack()
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
