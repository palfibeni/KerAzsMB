azs.dps = function(targetingMode, param)
	if not azs.class.dps then
		azs.debug("This class is not supported yet or it doesnt have a dps option, please use old methods mage_attack_skull(), etc...")
		return
	end
	if azs.class.handleNefaCall then azs.class.handleNefaCall() end
	if not hasMandokirGaze() and azs.getTarget(targetingMode) then
		azs.class.dps(param)
	else
		azs.class.stop()
	end
end

azs.heal = function(healingProfile)
	if not azs.class.heal then
		azs.debug("This class is not supported yet or it doesnt have a heal option, please use old methods priestHeal(), etc...")
		return
	end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	azs.class.heal(healingProfile)
end

azs.dispel = function(healingProfile)
	if not azs.class.dispel then
		azs.debug("This class is not supported yet or it doesnt have a dispel option, please use old methods mage_decuse_raid(), etc...")
		return
	end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	azs.class.dispel(healingProfile)
end

azs.healOrDispel = function(healingProfile)
	if not azs.class.healOrDispel then
		azs.debug("This class is not supported yet or it doesnt have a healOrDispel option, please use old methods priestHealOrDispel(), etc...")
		return
	end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	azs.class.healOrDispel(healingProfile)
end

azs.cc = function(icon)
	if not azs.class.cc then
		azs.debug("This class is not supported yet or it doesnt have a cc option, please use old methods mage_poly_star(), etc...")
		return
	end
	azs.class.cc(icon)
end

azs.special = function(targetingMode, param)
	if not azs.class.special then
		azs.debug("This class is not supported yet or it doesnt have a special option, please use old methods warlock_drain_soul_skull(), etc...")
		return
	end
	if azs.getTarget(targetingMode) then
		azs.class.special(param)
	end
end

azs.aoe = function(targetingMode)
	if not azs.class.aoe then
		azs.debug("This class is not supported yet or it doesnt have an aoe option, please use old methods mage_aoe(), etc...")
		return
	end
	azs.class.aoe()
end

azs.buff = function(param)
	if not azs.class.buff then
		azs.debug("This class is not supported yet, or it doesnt have a buff option, please use old methods mage_buff_raid(), etc...")
		return
	end
	if hasMandokirGaze() then return end
	azs.class.buff(param)
end
