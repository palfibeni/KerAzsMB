-- Settings
aimedShotWindow = 1 -- low value, with 3.0+ ranged attack speed (full/auto shot rotation), or a higher value with 2.9- ranged attack speed (clipped/aimed shot rotation)
instantShotWindow = 1.9 -- should be around ranged attack speed minus 1

aimedShotExpire = 0
instantShotExpire = 0
arrowCount = GetInventoryItemCount("player", 0)
ignoreNext = false

feignDeathActionSlot = 61
raptorStrikeActionSlot = 14
mongooseBiteActionSlot = 13
aimedShotActionSlot = 15
multiShotActionSlot = 16
tranqShotActionSlot = 17

local f = CreateFrame("FRAME", "HunterFrame")
f:RegisterEvent("BAG_UPDATE")

function HunterEventHandler()
  if not UnitClass("player") == "Hunter" then return end
  local newArrowCount = GetInventoryItemCount("player", 0)
  if arrowCount ~= newArrowCount then
    arrowCount = newArrowCount
    if ignoreNext then
      ignoreNext = false
    else
      aimedShotExpire = GetTime() + aimedShotWindow
      instantShotExpire = GetTime() + instantShotWindow
    end
  end
end

f:SetScript("OnEvent", HunterEventHandler)

function hunterDps(params)
  handleNefaCallHunter()
  if isInMeleeRange() then
		hunterMeleeDps()
	else
		hunterRangedDps(params)
  end
	PetAttack("target")
end

function hunterMeleeDps()
	stop_ranged_attack()
	if not hasBuff("player", "Spell_Nature_ProtectionformNature") then
		cast_buff_player("Ability_Hunter_AspectOfTheMonkey", "Aspect of the Monkey")
	end
    if IsActionReady(mongooseBiteActionSlot) then
        CastSpellByName("Mongoose Bite")
    elseif not IsCurrentAction(raptorStrikeActionSlot) and IsActionReady(raptorStrikeActionSlot) then
        CastSpellByName("Raptor Strike")
    end
	use_autoattack()
end

-- Hunter ranged dps rotation (Aspect, Hunter's Mark, Auto Shot, Aimed Shot, Multi Shot)
-- Multishot will be only used if 'azs.class.multiShotEnabled' is set to true.
function hunterRangedDps(params)
  local multiShotEnabled = params.multiShotEnabled or azs.class.multiShotEnabled
  stop_autoattack()
	if not hasBuff("player", "Spell_Nature_ProtectionformNature") then
		cast_buff_player("Spell_Nature_RavenForm", "Aspect of the Hawk")
	end
	cast_debuff("Ability_Hunter_SniperShot", "Hunter's Mark")
	if isTargetHpUnder(0.7) then
		cast_buff_player("Ability_Hunter_RunningShot", "Rapid Fire")
		useRacials()
		if useTrinkets() then return end
	end
	use_ranged_attack()
	if not IsCurrentAction(aimedShotActionSlot) and not IsCurrentAction(multiShotActionSlot) then
    if instantShotExpire >= GetTime() and isTargetInMobList(TRANQABLE_MOBS) and IsActionReady(tranqShotActionSlot) then
      CastSpellByName("Tranquilizing Shot")
      ignoreNext = true
    elseif aimedShotExpire >= GetTime() and IsActionReady(aimedShotActionSlot) then
      CastSpellByName("Aimed Shot")
      ignoreNext = true
    elseif multiShotEnabled and instantShotExpire >= GetTime() and IsActionReady(multiShotActionSlot) then
      CastSpellByName("Multi-Shot")
      ignoreNext = true
    end
  end
end

function hunterFeignDeath()
  if UnitAffectingCombat("player") and IsActionReady(feignDeathActionSlot) then
    CastSpellByName("Feign Death")
  end
end
