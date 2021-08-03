function warrior_fury_aoe_skull()
	if azs.targetSkull() then
		warriorFuryAoe()
	else
		stop_autoattack()
	end
end

function warrior_fury_aoe_cross()
	if azs.targetCross() then
		warriorFuryAoe()
	else
		stop_autoattack()
	end
end

function warriorFuryAoe()
	warriorBerserkerStance()
	berserkerRage()
	bloodrage()
	whirlwind()
  CastSpellByName("Cleave")
	use_autoattack()
end
