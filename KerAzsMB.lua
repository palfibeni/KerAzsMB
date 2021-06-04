azs = {}
azs.assistMe = "Cooperbeard"
azs.targetingMode = "skull" -- "skull", "cross", "assist", "solo"
azs.class={}

azs.tank_list = {"Cooperbeard", "Stardancer", "Peacebringer", "Gaelber", "Llanewrynn", "Dobzse", "Harklen", "Bendegúz"}

local timer = CreateFrame("FRAME");
--"duration" is in seconds and "func" is the function that will be executed in the end
local function setTimer(duration, func)
	local endTime = GetTime() + duration;

	timer:SetScript("OnUpdate", function()
		if(endTime < GetTime()) then
			--time is up
			func();
			timer:SetScript("OnUpdate", nil);
		end
	end);
end

-- create the OnEvent function
function AddonLoadedEventListener()
	if (event == "ADDON_LOADED") and arg1 == "KerAzsMB" then
		KerAzsMB_EventsFrame:UnregisterEvent("ADDON_LOADED") -- unregister the event as we dont need it anymore
		-- do init things.
		--setTimer(2, performCDproffs)
		-- initKeyBindings()
		azs.debug("KerazsMB loaded")
	end
end

azs.debug = function(message)
	if message==nil then
		DEFAULT_CHAT_FRAME:AddMessage("nil")
	else
		DEFAULT_CHAT_FRAME:AddMessage(message)
	end
end

azs.deprectedWarning = function()
	azs.debug("The method you are using is deprecated, please check the github page for more info.")
end

SLASH_INIT1="/init"
SLASH_INIT2="/azs.init"
SlashCmdList["INIT"]=function()
	initActionBar()
end

SLASH_DEEPINIT1="/deepInit"
SLASH_DEEPINIT2="/deepinit"
SLASH_DEEPINIT3="/DeepInit"
SlashCmdList["DEEPINIT"]=function()
	initMacros()
end

SLASH_AZSHELP1="/azs.help"
SLASH_AZSHELP2="/azshelp"
SLASH_AZSHELP3="/azsh"
SlashCmdList["AZSHELP"]=function()
	azs.debug("To setup actionbars please write /init")
	if azs.class.help then
		azs.class.help()
	end
	azs.debug("You can find more information on https://github.com/palfibeni/KerAzsMB")
end

azs.getTarget = function(targetingMode)
	targetingMode = targetingMode or azs.targetingMode
	if targetingMode == "skull" then
		return azs.targetSkull()
	elseif targetingMode == "cross" then
		return azs.targetCross()
	elseif targetingMode == "assist" then
		return AssistByName(azs.assistMe)
	elseif targetingMode == "solo" then
		return true
	end
end

azs.dps = function(targetingMode)
	if not azs.class.dps then
		azs.debug("This class is not supported yet or it doesnt have a dps option, please use old methods mage_attack_skull(), etc...")
		return
	end
	-- handleJindoMark
	if azs.getTarget(targetingMode) then
		if azs.class.handleNefaCall then azs.class.handleNefaCall() end
		azs.class.dps()
	else
		azs.class.stopDps()
	end
end

azs.cc = function(icon)
	if not azs.class.cc then
		azs.debug("This class is not supported yet or it doesnt have a cc option, please use old methods mage_poly_star(), etc...")
		return
	end
	azs.class.cc(icon)
end

azs.special = function(targetingMode)
	if not azs.class.special then
		azs.debug("This class is not supported yet or it doesnt have a special option, please use old methods warlock_drain_soul_skull(), etc...")
		return
	end
	if azs.getTarget(targetingMode) then
		azs.class.special(targetingMode)
	end
end

azs.aoe = function(targetingMode)
	if not azs.class.aoe then
		azs.debug("This class is not supported yet or it doesnt have an aoe option, please use old methods mage_aoe(), etc...")
		return
	end
	azs.class.aoe()
end

azs.buff = function()
	if not azs.class.buff then
		azs.debug("This class is not supported yet, or it doesnt have a buff option, please use old methods mage_buff_raid(), etc...")
		return
	end
	azs.class.buff()
end

function initActionBar()
	if azs.class.initActionBar then
		for i,actionbarEntry in ipairs(azs.class.initActionBar) do
			local spellName,slot = unpack(actionbarEntry)
			placeSpellByName(spellName, slot)
		end
	end
	if UnitClass("player") == "Warrior" then
		initActionBarForWarrior()
	elseif UnitClass("player") == "Rogue" then
		placeSpellByName("Attack", autoAttackActionSlot)
	elseif UnitClass("player") == "Paladin" then
		placeSpellByName("Divine Shield", divineShieldActionSlot)
		placeSpellByName("Attack", autoAttackActionSlot)
	elseif UnitClass("player") == "Priest" then
		placeSpellByName("Desperate Prayer", desperatePrayerActionSlot)
		placeSpellByName("Shoot", autoAttackActionSlot)
	elseif UnitClass("player") == "Druid" then
		placeSpellByName("Innervate", innervateActionSlot)
		placeSpellByName("Attack", autoAttackActionSlot)
	end
end

function initActionBarForWarrior()
	placeSpellByName("Attack", autoAttackActionSlot)
	placeSpellByName("Heroic Strike", heroicStrikeActionSlot)
	placeSpellByName("Bloodrage", bloodrageActionSlot)
	if is_tank_by_name(UnitName("player")) then
		placeSpellByName("Revenge", revengeActionSlot)
		placeSpellByName("Sunder Armor", sunderArmorActionSlot)
		placeSpellByName("Shield Slam", shieldSlamActionSlot)
	else
		placeSpellByName("Berserker Rage", berserkerRageActionSlot)
		placeSpellByName("Whirlwind", whirlwindActionSlot)
		placeSpellByName("Bloodthirst", bloodThirstActionSlot)
	end
end

function placeSpellByName(spellName, slot)
	spellId = getSpellId(spellName)
	if spellId ~= -1 then
		PickupAction(slot)
		ClearCursor()
		PickupSpell(spellId, "BOOKTYPE_SPELL")
		PlaceAction(slot)
	end
end

function initMacros()
	if azs.class.initMacros then
		clearCharacterMacros()
		for i,macroEntry in ipairs(azs.class.initMacros) do
			initMacro(macroEntry)
		end
	end
end

function initMacro(macroEntry)
	local name, iconName, script, slots = unpack(macroEntry)
	local numIcons = GetNumMacroIcons()
	for icon = 1,numIcons do
	 if string.find(GetMacroIconInfo(icon), iconName) then
		 local macroId = CreateMacro(name, icon, script, 1, 1);
		 if slots then
			 for i,slot in pairs(slots) do
				 PickupMacro(macroId)
				 PlaceAction(slot)
				 ClearCursor()
			 end
			 return
		 end
	 end
	end
end

function clearCharacterMacros()
	for i = 36, 19, -1 do
		if GetMacroInfo(i) then
			DeleteMacro(i)
		end
	end
end

function performCDproffs()
	createArcanite()
	createRefinedSalt()
	createMooncloth()
end

-- /script createArcanite()
function createArcanite()
	if getSpellId("Alchemy") ~= nil then
		CastSpellByName("Alchemy")
		performTradeSkill("Transmute: Arcanite")
	end
end

-- /script createRefinedSalt()
function createRefinedSalt()
	if getSpellId("Leatherworking") ~= nil then
		useItem("Salt Shaker")
	end
end

-- /script createMooncloth()
function createMooncloth()
	if getSpellId("Tailoring") ~= nil then
		CastSpellByName("Tailoring")
		performTradeSkill("Mooncloth")
	end
end

function performTradeSkill(tradeSkillName)
	for i=1,GetNumTradeSkills() do
		if GetTradeSkillInfo(i) == tradeSkillName then
			CloseTradeSkill()
			DoTradeSkill(i)
			break
		end
	end
end

function taxiToSentinelHill()
	takeTaxi("Sentinel Hill")
end

function taxiToSilithus()
	takeTaxi("Cenarion Hold")
end

function takeTaxi(destination)
	if not UnitExists("target") then return end
	for node = 1, NumTaxiNodes() do
		if string.find(TaxiNodeName(node), destination) then
			TakeTaxiNode(node)
		end
	end
end

--  function createTankWarriorMacro()
--  	local index=CreateMacro("Tank Attack",16777218,"/script warrior_tank_attack()",1)
--		PickupMacro(index)
--		PlaceAction(1)
--		PickupMacro(index)
--		PlaceAction(2)
--		PickupMacro(index)
--		PlaceAction(3)
--      index=CreateMacro("Tank Aoe",16777219,"/script warrior_aoe()",0)
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
