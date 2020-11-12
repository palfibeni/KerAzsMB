# KerAzsMB - Vanilla WoW Multibox Framework

Works with World of Warcraft version 1.12 and [Vanilla compatible SuperMacro](https://legacy-wow.com/vanilla-addons/SuperMacro/)

## Intro
This repository contains many prewritten macros to certain classes, making multiboxing life easier.
In it's current state it could be used as a SuperMacro extension.
Before you start using, understand a few things:
This addon helps you build 1 liner macros, which makes each character only a few button class, 
for example, the mage's primary functionality will be on the button 1, where we put a simple macro: 
```
/script mage_attack_skull()
```
This will target the enemy with the skull (ID = 8) raidTargetIcon, and start dps-ing with frostbolt, using burst trinkets, arcane power if avaliable, and when out of mana use Evocation, if it's on CD, just start wanding.

## How to setup
### Wiring in the addon:
1. Download the scripts and place them inside you Interface/Addons/SuperMacro folder.
2. Add the following line to the SuperMacro.xml, inside it's <UI> tag:
```
<Include file="KerAzsMB\KerAzs_mb.xml"/>
```
3. Now you can access the functions in the game with macros like this:
```
/script mage_attack_skull()
```
4. enjoy :)

### How to setup healing:
To create healer class with only one button, you need to edit some files in the addon extension.
1. In the SuperMacro/KerAzs/ you will find a KerAzs.lua file, open it in a text editor, I advice to download notepad++ for this purpose.
2. Edit the tank_list by adding before the } at the end your tank's name like: "last_name_in_the_list" ,"your_tank_name" }.
3. Edit the group_list, where you can just edit the [1] = {...} part, by adding switching the existing names to your party's members.
By doing these changes, you can start using the buff macros like:
```
/script mage_buff_group1()
```
and heal macros like :
```
/script priest_heal_group1() 
```
please note that priest uses flash heal, and heal spells in this macro, for leveling to level ~25 you might wanna use
/script priest_heal_lesser_group1()

### Hotkey.net
To use this framework in its full potential I use Hotkey.net for a keydown broadcasting tool.
Please visit [this tutorial] (https://www.dual-boxing.com/threads/16177-Guide-HowTo-use-HotKeyNet-for-boxing) for more info how to setup it.
I also added a hotkeynet_script_example.txt to the project, which you can edit.

## Tactic:

### My keybindings

| Slot | Dps | Heal | Tank |
| - | ----------------------------- | --------------------- | ------------------- |
| 1 | dps skull 					| healing all groups 	| threat attack |
| 2 | dps cross 					| healing all groups 	| threat attack |
| 3 | cc 							| healing all groups 	| cc |
| 4 | manaDrain/soulDrain/dps skull | healing all groups 	| threat attack/taunt |
| 5 | aoe dps 						| aoe heal 				| aoe threat attack |
| 6 | - 							| aoe hea 				| aoe threat attack |
| 7 | drink 						| drink 				| drink |
| 8 | buff 							| buff 					| buff |
| 9 | mount up 						| mount up 				| mount up |
| 0 | follow 						| follow 				| follow |
| H | ranged move backward 			| ranged move backward 	| ranged move backward |
| V | mellee move backward 			| mellee move backward 	| mellee move backward |
| R | ranged/caster move forward 	| mellee move backward 	| mellee move backward |

### Example

lets see an example with the following character:
| Name | Role |
| --------- | ------------- |
| Liberton 	| warrior tank 	|
| Lionel 	| paladin heal 	|
| Pinkypie 	| warlock dps 	|
| Fabregas 	| mage dps 		|
| Windou	| sh priest dps |

#### Liberton, the tank:
- 1,2,4: /script warrior_tank_attack() 
- 3: Concussion Blow
- 5,6: /script warrior_tank_aoe()
- 9: mount
- Marking skull, somewhere on the actionbar, preferably on slot "-": /script SetRaidTarget("target",8)

#### Lionel, the heal:
- 1,2,3,4: /script pala_heal_group1() 
- 5,6: /script pala_heal_aoe()
- 7: mana drink
- 8: /script pala_buff_group1() // this will only add might/wisdom but you can edit it in the KerAzsMB/pala/pala_buff.lua file
- 9: mount
- 0: /follow Liberton

#### Pinkypie, the warlock:
- 1: /script warlock_skull_coe() // coe refers to using curse of elements, you can use cos, coa, cow instead
- 2: /script warlock_cross_coe()
- 3: /script banish_green() // banishes the target with the green triangle raid icon, find more options in /warlock/warlock_banish.lua
- 4: /script warlock_drain_soul_skull()
- 5: /script warlock_aoe()
- 7: mana drink
- 8: /script warlock_buffs_imp()
- 9: mount
- 0: /follow Liberton

Note: in raid on certain bosses I setup for button 4 /script warlock_drain_mana_skull() or /script warlock_skull_coe()

#### Fabregas, the mage:
- 1,4: /script mage_attack_skull() // mage just continue to dps when warlock tries to drain soul or mana.
- 2: /script mage_attack_cross()
- 3: /script poly_star() // polymorphs the target with the yellow star raid icon, find more options in mage/mage_poly.lua
- 5: /script mage_aoe()
- 7: mana drink
- 8: /script mage_buff_group1()
- 9: mount
- 0: /follow Liberton

Note: in raid on certain bosses I setup for 1-2-4 buttons the /script mage_decurse_raid() macro

#### Windou, the shadow priest:
- 1,4: /script sh_priest_skull()
- 2: /script sh_priest_cross()
- 3: /script hackle_orange() // shakles the target with the orange shield raid icon, find more options in /priest/priest_shackle.lua
- 5,6: Prayer of Healing // this might need to manually remove the shadow form if needed. Mainly used on Vaelstrasz fight
- 7: mana drink
- 8: /script priest_small_buff_group1()
- 9: mount
- 0: /follow Liberton

Note: in raid on certain bosses I setup for button 4 /script priest_mana_burn_skull()

### Other notes:
It's important to note, that there is a few spells that should be placed in specific positions, to the macros to use them:
- Mage's Evocation should be in the actionbar slot 61 (just above the actionbar slot 1)
- Holy Priest's Desperate Prayer same slot
- Wand(every class using wand)/Mellee Auto Attack (rouges, warriors, feral druid, hunter): slot 62 (slot 63 needs to be empty, the attack macro uses this slot)
- Autoshot for hunters should be put into slot 64 (slot 65 should be empty, becasue the attack macro uses this slot)

## Special Thanks
#### Kearlah
He is my guildmaster, and without him, I wouldn't even know multiboxing exists, and most of these macros are written by him. You can find them [here](https://github.com/KocsiLevente/multibox).
#### FurySwipes
He made the 5MMB framework which is really similar project, and from I learnt, and copied a lot. Check it out [here](https://furyswipes.wixsite.com/mysite).

## Useful links
- [WoW LUA API](https://vanilla-wow.fandom.com/wiki/World_of_Warcraft_API)
- [Buff/Debuff icons](https://wowwiki.fandom.com/wiki/Queriable_buff_effects)
- [Inventory slot names](https://wowwiki.fandom.com/wiki/InventorySlotName)
