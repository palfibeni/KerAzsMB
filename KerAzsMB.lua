tank_list = {"Copperbeard", "Gaelber", "Llanewrynn", "Naderius", "Obier", "Vynnes", "Dobzse", "Stardancer", "Moonflower"}

group_list = {
	[1] = {
		tank="Cooperbeard",
		heal="Baleog",
		dps_list={"Azsgrof", "Daemona", "Jaliana", "Carla"}
	},
	[2] = {
		tank="Cooperbeard",
		heal="Lionel",
		dps_list={"Liberton", "Pinkypie", "Fabregas", "Windou"}
	},
	[3] = {
		tank="Cooperbeard",
		heal="Nobleforged",
		dps_list={"Oakheart", "Cromwell", "Leilena", "Featherfire"}
	},
	[4] = {
		tank="Stardancer",
		heal="Lightbeard",
		dps_list={"Miraclemike", "Pompedous", "Morbent"}
	},
	[5] = {
		tank="Moonflower",
		heal="Bronzecoat",
		dps_list={"Maleficus", "Nightleaf", "Ravencloud"}
	},
}

horde_group_list = {
	[1] = {
		tank="Gorebleed",
		heal="Bluelight",
		dps_list={"Felfire", "Flamestorm", "Coldbringer"}
	}
}

KerAzs = CreateFrame("Button","KerAzsMB",UIParent)
KerAzs:RegisterEvent("ADDON_LOADED") -- register event "ADDON_LOADED"

-- create the OnEvent function
function KerAzs:OnEvent()
	if (event == "ADDON_LOADED") and arg1 == "SuperMacro" then
	-- do init things.
		KerAzs:UnregisterEvent("ADDON_LOADED") -- unregister the event as we dont need it anymore
		-- initKeyBindings()
		debug("/init")
	end
end

SLASH_INIT1="/init"
SlashCmdList["INIT"]=function()
	initActionBar()
end

function initActionBar()
	if UnitClass("player") == "Hunter" then
		initActionBarForHunter()
	elseif UnitClass("player") == "Warrior" then
		placeSpellByName("Attack", autoAttackActionSlot)
	elseif UnitClass("player") == "Rogue" then
		placeSpellByName("Attack", autoAttackActionSlot)
	elseif UnitClass("player") == "Paladin" then
		placeSpellByName("Divine Shield", 61)
		placeSpellByName("Attack", autoAttackActionSlot)
	elseif UnitClass("player") == "Mage" then
		placeSpellByName("Evocation", 61)
		placeSpellByName("Shoot", autoAttackActionSlot)
	elseif UnitClass("player") == "Warlock" then
		placeSpellByName("Shoot", autoAttackActionSlot)
	elseif UnitClass("player") == "Priest" then
		placeSpellByName("Desperate Prayer", 61)
		placeSpellByName("Shoot", autoAttackActionSlot)
	end
end

function initActionBarForHunter()
	placeSpellByName("Attack", autoAttackActionSlot)
	placeSpellByName("Auto Shot", autoShotActionSlot)
	placeSpellByName("Aimed Shot", aimedShotActionSlot)
	placeSpellByName("Multi-Shot", multiShotActionSlot)
	placeSpellByName("Raptor Strike", raptorStrikeActionSlot)
	placeSpellByName("Mongoose Bite", mongooseBiteActionSlot)
end

function placeSpellByName(spellName, slot)
	spellId = getSpellId(spellName)
	if spellId ~= nil then
		PickupSpell(spellId, "BOOKTYPE_SPELL")
		PlaceAction(slot)
	end
end

function debug(text)
    RunLine("/say " .. text )
end

--  function createTankWarriorMacro()
--  	local index=CreateMacro("Tank Attack",16777218,"/script warrior_tank_attack()",1)
--		PickupMacro(index)
--		PlaceAction(1)
--		PickupMacro(index)
--		PlaceAction(2)
--		PickupMacro(index)
--		PlaceAction(3)
--      index=CreateMacro("Tank Aoe",16777219,"/script warrior_aoe()",1)
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
