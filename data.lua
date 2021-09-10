-- azs.targetingMode = "skull" -- "skull", "cross", "assist", "solo"
-- azs.assistMe = "Cooperbeard" -- assist targeting mode will

-- Group Management
azs.nameList={
	tank={"Cooperbeard", "Stardancer", "Peacebringer", "Obier", "Dobzse",
  "Bendegúz", "Harklen", "Gaelber", "Llanewrynn", "Nyavalyás", "Pinky"},
	heal={},
	multitank={"Stardancer","Cooperbeard", "Peacebringer", "Obier"},
	multiheal={"Lightbeard", "Baleog", "Lionel", "Nobleforged", "Bronzecoat",
	"Fordragon", "Moonflower", "Lightweight", "Greenshadow", "Brunhilde"},
	multidps={"Azsgrof", "Daemona", "Jaliana", "Carla", "Liberton", "Pinkypie",
	"Fabregas", "Windou", "Oakheart", "Cromwell", "Leilena", "Featherfire",
	"Miraclemike", "Pompedous", "Morbent", "Maleficus", "Nightleaf", "Ravencloud",
	"Barbariana", "Lemonjuice", "Thinarms", "Toxica", "Zara", "Sylvia", "Xenophia"}
}

-- ccTarget to setup polymorph target, options: 1: star, 2: orange, 3: purple, 4: green, 5: moon, 6: blue, 7: x, 8: skull
azs.mages = {
  Carla = { ccTarget = 1 },
  Fabregas = { ccTarget = 2 },
  Jaliana = { ccTarget = 3 },
  MiracleMike = { ccTarget = 4 },
  Pompedous = { ccTarget = 5 },
  Zara = { ccTarget = 6 },
  Xenophia = { ccTarget = 2 }
}

-- Setup your warlock's defaults:
-- curse options: "CoE", "CoT", "CoR", "CoW" or "Cos"
-- summon option: "Imp" or "DS" (for Demonic Sacrifice  Succubus)
-- ccTarget to setup banish target, options: 1: star, 2: orange, 3: purple, 4: green, 5: moon, 6: blue, 7: x, 8: skull
azs.warlocks = {
  Daemona = {curse = "CoE", summon = "DS", ccTarget = 1},
  PinkyPie = {curse = "CoS", summon = "DS", ccTarget = 2},
  Morbent = {curse = "CoE", summon = "Imp", ccTarget = 3},
  Maleficus = {curse = "CoW", summon = "Imp", ccTarget = 4},
  Sylvia = {curse = "CoS", summon = "Imp", ccTarget = 5},
}

-- Setup your healer's defaults:
-- which group of the raid they will heal more likely
-- for dwarf priests you can also setup who they will fear ward
azs.healers = {
  Lightbeard = {group = 8, fearWard = "Baleog"},
  Baleog = {group = 7, fearWard = "Cooperbeard"},
  Lionel = {group = 3},
  Nobleforged = {group = 4},
  Bronzecoat = {group = 5, fearWard = "Peacebringer"},
	Fordragon = {group = 6},
  Moonflower = {group = 7},
  Lightweight = {group = 2, fearWard = "Stardancer"},
  Greenshadow = {group = 1},
  Brunhilde = {group = 1, fearWard = "Bronzecoat"}
}
