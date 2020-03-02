tank_list = {"Copperbeard", "Liberton", "Oakheart", "Gaelber", "LLanewryn", "Naderius"}

group_list = {
	[1] = {
		tank="Cooperbeard",
		heal="Baleog",
		dps_list={"Liberton", "Azsgrof", "Daemona", "Jaliana", "Carla"}
	},
	[2] = {
		tank="Liberton",
		heal="Lionel",
		dps_list={"Cooperbeard", "PinkyPe", "Fabregas", "Windou"}
	},
	[3] = {
		tank="Oakheart",
		heal="Nobleforged",
		dps_list={"Cromwell", "Leilena", "Featherfire"}
	},
	[4] = {}
}

-- test command:
-- RunLine("/say " .. "test" )

function is_tank_by_name(name)
	for i,tank in pairs(tank_list) do
		if tank == name then return true end
	end
	return nil
end

function is_target_hp_over(percent)
	return UnitHealth("target") / UnitHealthMax("target") > percent
end

function is_target_hp_under(percent)
	return UnitHealth("target") / UnitHealthMax("target") < percent
end

function is_player_hp_over(percent)
	return UnitHealth("player") / UnitHealthMax("player") > percent
end

function is_player_hp_under(percent)
	return UnitHealth("player") / UnitHealthMax("player") < percent
end

function get_rage()
    return UnitMana("player")
end

function target_cross()
	target_by_icon(7)
end

function is_target_cross()
	return (GetRaidTargetIndex("target") == 7)
end

function target_skull()
	target_by_icon(8)
end

function is_target_skull()
	return (GetRaidTargetIndex("target") == 8)
end

function target_by_icon(icon)
	for k,tank in pairs(tank_list) do
		TargetByName(tank)
		TargetUnit("targettarget")
		if (GetRaidTargetIndex("target") == icon) then
			return
		end
	end
	tab_target_by_icon(icon)
end

function tab_target_by_icon(icon)
	for i=1,10 do
		TargetNearestEnemy()
		if (GetRaidTargetIndex("target") == icon) then
			return
		end
	end
	TargetUnit("player")
end

function cast_debuff(icon, spell_name)
	if target_has_debuff(icon) then return end
	cast(spell_name)
end

function target_has_debuff(icon)
	local i,x=1,0
	while (UnitDebuff("target",i)) do
		if (UnitDebuff("target",i) == ("Interface\\Icons\\" .. icon)) then
			x=1
		end
		i=i+1
	end
	return x == 1
end

function cast_buff(icon, spell_name)
	if target_has_buff(icon) then return end
	cast(spell_name)
end

function target_has_buff(icon)
	return has_buff("target", icon)
end

function cast_buff_player(icon, spell_name)
	if player_has_buff(icon) then return end
	cast(spell_name)
end

function player_has_buff(icon)
	return has_buff("player", icon)
end

function has_buff(target, icon)
	local i,x=1,0
	while (UnitBuff(target,i)) do
		if (UnitBuff(target,i) == ("Interface\\Icons\\" .. icon)) then
			x=1
		end
		i=i+1
	end
	return x == 1
end

function is_in_melee_range()
	return CheckInteractDistance("target",3)
end

function stop_autoattack()
	PickupAction(63)
	PlaceAction(62)
end

function use_autoattack()
	if not IsCurrentAction(62) and not IsCurrentAction(63) then
		UseAction(62)
		PickupAction(62)
		PlaceAction(63)
	end
end

function pick_up_item(name)
	if not CursorHasItem() then
		for bag=0,4 do
			for slot = 1,GetContainerNumSlots(bag) do
				local texture = GetContainerItemInfo(bag,slot)
				if texture then
					local link = GetContainerItemLink(bag,slot)
					if string.find(link, name) then PickupContainerItem(bag,slot) return end
				end
			end
		end
	end
	ResetCursor()
end

function pick_up_item_from_list(name_list)
	if not CursorHasItem() then
		for bag=0,4 do
			for slot = 1,GetContainerNumSlots(bag) do
				local texture = GetContainerItemInfo(bag,slot)
				if texture then
					local link = GetContainerItemLink(bag,slot)
					for k,name in pairs(name_list) do
						if string.find(link, name) then PickupContainerItem(bag,slot) return end
					end
				end
			end
		end
	end
	ResetCursor()
end

--KerAzs = CreateFrame("Button","KerAzs",UIParent)
--KerAzs:RegisterEvent("ADDON_LOADED") -- register event "ADDON_LOADED"

-- create the OnEvent function
--function KerAzs:OnEvent()
--	if (event == "ADDON_LOADED") and arg1 == "SuperMacro" then
--	-- do init things.
--		KerAzs:UnregisterEvent("ADDON_LOADED") -- unregister the event as we dont need it anymore
--		initKeyBindings()
--	end
--end

--  function createTankWarriorMacro()
--  	local index=CreateMacro("Attack def",16777218,"/script warrior_tank_attack()",1)
--		PickupMacro(index)
--		PlaceAction(1)
--		PickupMacro(index)
--		PlaceAction(2)
--		PickupMacro(index)
--		PlaceAction(3)
--      index=CreateMacro("aoe",16777219,"/script warrior_aoe()",1)
--		PickupMacro(index)
--		PlaceAction(5)
--  end

--  function initKeyBindings()
--	SetBinding("SHIFT-1","MULTIACTIONBAR1BUTTON1")
--	SetBinding("SHIFT-2","MULTIACTIONBAR1BUTTON2")
--	SetBinding("SHIFT-3","MULTIACTIONBAR1BUTTON3")
--	SetBinding("SHIFT-4","MULTIACTIONBAR1BUTTON4")
--	SetBinding("SHIFT-5","MULTIACTIONBAR1BUTTON5")
--	SetBinding("SHIFT-6","MULTIACTIONBAR1BUTTON6")
--	SetBinding("SHIFT-7","MULTIACTIONBAR1BUTTON7")
--	SetBinding("SHIFT-8","MULTIACTIONBAR1BUTTON8")
--	SetBinding("SHIFT-9","MULTIACTIONBAR1BUTTON9")
--	SetBinding("SHIFT-0","MULTIACTIONBAR1BUTTON10")
--	SetBinding("SHIFT--","MULTIACTIONBAR1BUTTON11")
--	SetBinding("SHIFT-=","MULTIACTIONBAR1BUTTON12")
--	SetBinding("F1","MULTIACTIONBAR2BUTTON1")
--	SetBinding("F2","MULTIACTIONBAR2BUTTON2")
--	SetBinding("F3","MULTIACTIONBAR2BUTTON3")
--	SetBinding("F4","MULTIACTIONBAR2BUTTON4")
--	SetBinding("F5","MULTIACTIONBAR2BUTTON5")
--	SetBinding("F6","MULTIACTIONBAR2BUTTON6")
--	SetBinding("F7","MULTIACTIONBAR2BUTTON7")
--	SetBinding("F8","MULTIACTIONBAR2BUTTON8")
--	SetBinding("F9","MULTIACTIONBAR2BUTTON9")
--	SetBinding("F10","MULTIACTIONBAR2BUTTON10")
--	SetBinding("F11","MULTIACTIONBAR2BUTTON11")
--	SetBinding("F12","MULTIACTIONBAR2BUTTON12")
--	SetBinding("SHIFT-F1","MULTIACTIONBAR2BUTTON1")
--	SetBinding("SHIFT-F2","MULTIACTIONBAR2BUTTON2")
--	SetBinding("SHIFT-F3","MULTIACTIONBAR2BUTTON3")
--	SetBinding("SHIFT-F4","MULTIACTIONBAR2BUTTON4")
--	SetBinding("SHIFT-F5","MULTIACTIONBAR2BUTTON5")
--	SetBinding("SHIFT-F6","MULTIACTIONBAR2BUTTON6")
--	SetBinding("SHIFT-F7","MULTIACTIONBAR2BUTTON7")
--	SetBinding("SHIFT-F8","MULTIACTIONBAR2BUTTON8")
--	SetBinding("SHIFT-F9","MULTIACTIONBAR2BUTTON9")
--	SetBinding("SHIFT-F0","MULTIACTIONBAR2BUTTON10")
--	SetBinding("SHIFT-F11","MULTIACTIONBAR2BUTTON11")
--	SetBinding("SHIFT-F12","MULTIACTIONBAR2BUTTON12")
--	ReloadUI()
--end

-- warrior
-- tankattack
-- /script warrior_tank_attack()

-- pala
-- palaAOE
-- /scipt pala_aoe_group2()
