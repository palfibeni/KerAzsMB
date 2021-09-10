# KerAzsMB - Vanilla WoW Multibox Framework

Works with World of Warcraft version 1.12

## Intro
This repository contains many prewritten macros to certain classes, making multiboxing life easier.

Before you start using, understand a few things:
This addon enables lot of one-button or a few button logic for all classes,
The macros you need can be generated through the addon's dash command /deepinit
For example if you setup your mage with this addon, if you press the button 1, which is the main functionality macro:
```
/script azs.dps("skull")
```
the following will happen:
This will find the target enemy with the skull (ID = 8) raid target icon on it, and start dps-ing with frostbolt, using burst trinkets, arcane power if available, and when out of mana use Evocation, if it's on CD, just start wanding, til you can afford a frostbolt again.

## How to setup
### Wiring in the addon:
1. Download the scripts and place them inside you Interface/Addons/ folder.
2. Make a copy of the data.lua.sample file, with the name data.lua.
3. Edit the azs.nameList according to the tanks you and your team is using in raids, in the newly created data.lua.
Optional: edit the remaining arrays in data.lua, according to the comments
3. Login to your character and run the command: /deepinit
4. Now you can access to this powerful multiboxing framework. Enjoy :)

### Hotkey.net
To use this framework in its full potential I use Hotkey.net for a keydown broadcasting tool.
Please visit [thier page] (http://www.hotkeynet.com/p/download.html) to download it, and for more information about the program.
I also added a hotkeynet_script_example.txt to the project, which you can edit into the main directory.
You have to add your wow.exe path in place of PATH_TO_WoW.exe
ACCOUNT_NAMEX, PASSWORDX should be replaced with your login information.
To start multiboxing load the script file into the Hotkey.net client, and after turning ScrollLock on, you can start multiboxing.
CTRL+ALT+M will start your wow clients, while the process is ongoing, you cannot do anything else with mouse, keyboard.
While the Scroll Lock is ON the numbers 0-9, will be redirected to each WoW client you have set up, and  only to them,.
I have setup in this example an R, H keybind also, only for the sub clients, when pressed, you will send an ArrowUp, or ArrowDown to these, resulting in going forward, or backward with only on windows 2-5.
You can add further key logic, like separate movement for mellee, and casters, or strafe for example with Numpad 4,6 keys.

## Tactic:

### My keybindings

This is your hammer, which works in most cases against those nasty nails.
/deepinit will setup something similar like this, except for the drink/follow.

| Slot | Dps | Heal | Tank |
| - | ----------------------------- | --------------------- | ------------------- |
| 1 | dps skull 					| healing all groups 	| threat attack |
| 2 | dps cross 					| healing all groups 	| threat attack |
| 3 | cc 							    | healing all groups 	| cc |
| 4 | manaDrain/soulDrain/dps skull | healing all groups 	| threat attack/taunt |
| 5 | aoe dps 						| healing all groups 	| aoe threat attack |
| 6 | - 							    | aoe heal 				    | aoe threat attack |
| 7 | drink 						  | drink 				      | drink |
| 8 | buff 							  | buff 					      | buff |
| 9 | mount up 						| mount up 				    | mount up |
| 0 | follow 						  | follow 				      | follow |
| R | mellee move forward 	| mellee move backward 	| mellee move backward |
| V | mellee move backward 	| mellee move backward 	| mellee move backward |
| Z | ranged move backward 	| ranged move backward 	| ranged move backward |
| H | ranged move backward 	| ranged move backward 	| ranged move backward |

There is also a /help command which gives you a few tips for each class.
To setup each character according to the above setup just write /deepinit in the chat with each character.
It is advised to level each character to around lvl 10 indivually, before you can start leveling them together,
because the talent allocation is a big part of how the roles are set.
To set skull on the target you can use the following macro:
```
/script SetRaidTarget("target",8)
```

### How to setup healing:
1. Edit the azs.nameList, setup all the main/off tanks, in the tank, who attend to raids/dungeons, and add you dps, heal to multiheal, multidps. This is just a bit of help for your healer, on who should they focus on.
Optional: If you have multiple healers, consider modifying the data.lua file to setup thier preffered groups, to heal more likely in case there is aoe damage.
After you did this, the /deepinit will also add the following line to your macro's supermacro part, the "1" here
```
SetBias(-0.15,"group",1)
```
The last number 1 here refer to the first group, the healer will prioritize the first group with this line added to supermacro extension.

## Special Thanks
#### Ryonn/Alaniel
He made a similar addon, a bit after I started, and I used a lot of his awesome solution, salute to you Alaniel. Check it out [here](https://github.com/Ryonn-0/ryn-multibox).
#### Kearlah
He is my guildmaster, and without him, I wouldn't even know multiboxing exists.

## Useful links
- [WoW LUA API](https://vanilla-wow.fandom.com/wiki/World_of_Warcraft_API)
- [Buff/Debuff icons](https://wowwiki.fandom.com/wiki/Queriable_buff_effects)
- [Inventory slot names](https://wowwiki.fandom.com/wiki/InventorySlotName)
- [All actionbar slot](https://wowwiki-archive.fandom.com/wiki/ActionSlot)
- [WoW addon designer tool](https://www.wowinterface.com/downloads/info4222-WoWUIDesigner.html)
