azs.dps = function(targetingMode, param)
	if not azs.class.dps then
		azs.debug("This class is not supported yet or it doesnt have a dps option, please use old methods mage_attack_skull(), etc...")
		return
	end
	if azs.class.handleNefaCall then azs.class.handleNefaCall() end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	local class = UnitClass("player")
	if azs.getTarget(targetingMode) then
		azs.class.dps(param)
	elseif class == "Warrior" or class == "Rogue" or class == "Hunter" or azs.class.talent == PALADIN_RETRI or class == "Shaman" then
		stop_autoattack()
		stop_ranged_attack()
	end
end

azs.heal = function(healingProfile, param)
	if not azs.class.heal then
		azs.debug("This class is not supported yet or it doesnt have a heal option, please use old methods priestHeal(), etc...")
		return
	end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	azs.class.heal(healingProfile, param)
end

azs.dispel = function(healingProfile, param)
	if not azs.class.dispel then
		azs.debug("This class is not supported yet or it doesnt have a dispel option, please use old methods mage_decuse_raid(), etc...")
		return
	end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	azs.class.dispel(healingProfile, param)
end

azs.healOrDispel = function(healingProfile, param)
	if not azs.class.healOrDispel then
		azs.debug("This class is not supported yet or it doesnt have a healOrDispel option, please use old methods priestHealOrDispel(), etc...")
		return
	end
	if hasMandokirGaze() then
		azs.class.stop()
		return
	end
	azs.class.healOrDispel(healingProfile, param)
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

-- /script azs.debug(getPlayerRoleByName(UnitName("player")))
azs.follow = function(param)
	if hasMandokirGaze() then return end
	local name = UnitName("player")
	if IsShiftKeyDown() and not getPlayerRoleByName(name) == "multimelee" then return end
	local followTarget = getFollowTarget()
	if followTarget ~= nil and followTarget ~= name then
		FollowByName(followTarget, true);
	end
end
