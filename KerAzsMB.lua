azs = {}
azs.assistMe = "Cooperbeard"
azs.targetingMode = "skull" -- "skull", "cross", "assist", "solo"
azs.class={}
azs.mages = {
  Carla = { ccTarget = 1 },
  Fabregas = { ccTarget = 2 },
  Jaliana = { ccTarget = 3 },
  MiracleMike = { ccTarget = 4 },
  Pompedous = { ccTarget = 5 },
  Zara = { ccTarget = 6 },
  Xenophia = { ccTarget = 2 }
}
azs.warlocks = {
  Daemona = {curse = "CoE", summon = "DS", ccTarget = 1},
  PinkyPie = {curse = "CoS", summon = "DS", ccTarget = 2},
  Morbent = {curse = "CoE", summon = "Imp", ccTarget = 3},
  Maleficus = {curse = "CoW", summon = "Imp", ccTarget = 4},
  Sylvia = {curse = "CoS", summon = "Imp", ccTarget = 5},
}

azs.tank_list = {"Cooperbeard", "Stardancer", "Peacebringer", "Gaelber", "Llanewrynn",
	"Dobzse", "Harklen", "Bendegúz", "Pinky", "Obier"}

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
function addonLoadedEventListener()
	if event == "ADDON_LOADED" and arg1 == "KerAzsMB" then
		KerAzsMB_EventsFrame:UnregisterEvent("ADDON_LOADED")
		azs.debug("KerazsMB loaded")
		azs.avaliableMacroIcons = getAvaliableMacroIcons()
	end
	if event == "PLAYER_ENTERING_WORLD" then
		setTimer(0.5, azs.initClassData)
	end
end

azs.initClassData = function()
	if UnitClass("player") == "Warrior" then
		initWarriorData()
	elseif UnitClass("player") == "Mage" then
		initMageData()
	elseif UnitClass("player") == "Warlock" then
		initWarlockData()
	elseif UnitClass("player") == "Rogue" then
		initRogueData()
	elseif UnitClass("player") == "Hunter" then
		initHunterData()
	elseif UnitClass("player") == "Paladin" then
		initPaladinData()
	elseif UnitClass("player") == "Priest" then
		initPriestData()
	elseif UnitClass("player") == "Druid" then
		initDruidData()
	end
end

azs.debug = function(message)
	if message==nil then
		DEFAULT_CHAT_FRAME:AddMessage("nil")
	elseif message==true then
			DEFAULT_CHAT_FRAME:AddMessage("true")
	elseif message==false then
			DEFAULT_CHAT_FRAME:AddMessage("false")
	else
		DEFAULT_CHAT_FRAME:AddMessage(message)
	end
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
	initActionBar()
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

azs.dps = function(targetingMode, param)
	if not azs.class.dps then
		azs.debug("This class is not supported yet or it doesnt have a dps option, please use old methods mage_attack_skull(), etc...")
		return
	end
	-- handleJindoMark
	if azs.class.handleNefaCall then azs.class.handleNefaCall() end
	if azs.getTarget(targetingMode) then
		azs.class.dps(param)
	else
		azs.class.stopDps()
	end
end

azs.heal = function(icon)
	if not azs.class.heal then
		azs.debug("This class is not supported yet or it doesnt have a heal option, please use old methods PriestHeal(), etc...")
		return
	end
	-- handleJindoMark
	azs.class.heal()
end

azs.dispel = function(icon)
	if not azs.class.dispel then
		azs.debug("This class is not supported yet or it doesnt have a dispel option, please use old methods mage_decuse_raid(), etc...")
		return
	end
	-- handleJindoMark
	azs.class.dispel()
end

azs.healOrDispel = function(icon)
	if not azs.class.healOrDispel then
		azs.debug("This class is not supported yet or it doesnt have a healOrDispel option, please use old methods PriestHealOrDispel(), etc...")
		return
	end
	-- handleJindoMark
	azs.class.healOrDispel()
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
	azs.class.buff(param)
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
	local name, iconName, script, slots, superMacro = unpack(macroEntry)
	local macroId = CreateMacro(name, azs.avaliableMacroIcons["Interface\\Icons\\" .. iconName], script, 1, 1);
	azs.debug(slots)
	if slots then
		for i,slot in pairs(slots) do
			PickupMacro(macroId)
			PlaceAction(slot)
			ClearCursor()
			SM_EXTEND[name] = superMacro
		end
		return
	end
end

function clearCharacterMacros()
	for i = 36, 19, -1 do
		local name = GetMacroInfo(i)
		if name then
			DeleteMacro(i)
			SM_EXTEND[name] = nil
		end
	end
end

function getAvaliableMacroIcons()
	local icon={};
	for i=1,GetNumMacroIcons() do
		local texture=GetMacroIconInfo(i);
		icon[texture]=i;
	end
	return icon;
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

-- /script azs.debug(isMyMultibox("Cooperbeard"))
function isMyMultibox(targetName)
	for i,name in ipairs(nameList.multitank) do
		if targetName == name then return true end
	end
	for i,name in ipairs(nameList.multiheal) do
		if targetName == name then return true end
	end
	for i,name in ipairs(nameList.multidps) do
		if targetName == name then return true end
	end
	return false
end

-- /script inviteMultiBoxToRaid()
function inviteMultiBoxToRaid()
	for i,name in ipairs(nameList.multitank) do
		InviteByName(name)
		PromoteToAssistant(name)
	end
	ConvertToRaid()
	for i,name in ipairs(nameList.multiheal) do
		InviteByName(name)
	end
	for i,name in ipairs(nameList.multidps) do
		InviteByName(name)
	end
	SetLootMethod("freeforall")
end

-- /script kickEveryone()
function kickEveryone()
	for i = 1,40 do
		name = GetRaidRosterInfo(i)
		if name then
			UninviteByName(name)
		end
	end
end

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
