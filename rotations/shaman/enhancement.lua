local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', key = 'S_ASE', default = true},
	{type = 'spinner', text = '', key = 'S_AS', default = 40},
	{type = 'checkbox', text = 'Enable Healing Surge', key = 'S_HSGE', default = true},
	{type = 'spinner', text = '', key = 'S_HSG', default = 35},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Emergency Group Healing
	{type = 'header', text = 'Emergency Group Healing', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Group Healing', key = 'E_HSGE', default = false},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'E_HSG', default = 35},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Control: Lightning Surge Totem @ Cursor', key = 'K_LST', default = true},
	{type = 'checkbox', text = 'L-Alt: Earthbind Totem @ Cursor', key = 'K_ET', default = true},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cff0070de --- |rShaman: |cff0070deENHANCEMENT|r')
	print('|cff0070de --- |rSuggested Talents: 1/2 - 2/X - 3/1 - 4/2 - 5/2 - 6/2 - 7/2|r')
	print('|cff0070de --- |rNo Multitarget (AoE) enabled settings|r')
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Cleanse Spirit
		key = 'yuPS',
		name = 'Cleanse Spirit',
		text = 'Enable/Disable: Automatic removal of curses',
		icon = 'Interface\\ICONS\\ability_shaman_cleansespirit',
	})
end

local Survival = {
	-- Astral Shift usage if enabled in UI.
	{'&Astral Shift', 'UI(S_ASE)&player.health<=UI(S_AS)'},
	-- Gift of the Naaru usage if enabled in UI.
	{'&Gift of the Naaru', 'UI(S_GOTNE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_GOTN)'},
	-- Healthstone usage if enabled in UI.
	{'#5512', 'UI(S_HSE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HS)'},
	-- Ancient Healing Potion usage if enabled in UI.
	{'#127834', 'UI(S_AHPE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_AHP)'},
}

local Player = {
	-- Healing Surge usage if enabled in UI.
	{'!Healing Surge', 'UI(S_HSGE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HSG)', 'player'},
}

local Emergency = {
	-- Healing Surge usage if enabled in UI.
	{'!Healing Surge', 'UI(E_HSGE)&{!lowest.debuff(Ignite Soul)}&lowest.health<=UI(E_HSG)', 'lowest'},
}

local Keybinds = {
	-- Lightning Surge Totem at cursor on Left-Control if enabled in UI.
	{'!Lightning Surge Totem', 'UI(K_LST)&keybind(lcontrol)', 'cursor.ground'},
	-- Earthbind Totem at cursor on Left-Alt if enabled in UI.
	{'!Earthbind Totem', 'UI(K_ET)&keybind(lalt)', 'cursor.ground'},
}

local Interrupts = {
	{'&Wind Shear'},
}

local Dispel = {
	{'%dispelself'},
}

-- ####################################################################################
-- Primairly sourced from legion-dev SimC.
-- Updates to rotations from sources are considered for implementation.
-- ####################################################################################

-- SimC APL 4/20/2017
-- https://github.com/simulationcraft/simc/blob/legion-dev/profiles/Tier19M/Shaman_Enhancement_T19M.simc

local Cooldowns = {
	{'Ascendance','talent(7,1)&player.buff(Stormbringer)'},
	{'Feral Spirit','!artifact(Alpha Wolf).enabled||player.maelstrom>=20&spell(Crash Lightning).cooldown<=gcd'},
	{'&Blood Fury', 'player.buff(Ascendance)||spell(Feral Spirit).cooldown>1'},
	{'&Berserking', 'player.buff(Ascendance)||spell(Feral Spirit).cooldown>1'},
}

local Combat = {
	{'/startattack', '!isattacking'},
	--actions+=/crash_lightning,if=artifact.alpha_wolf.rank&prev_gcd.1.feral_spirit
	{'Crash Lightning', 'artifact(Alpha Wolf).enabled&lastcast(Feral Spirit)'},
	--actions+=/boulderfist,if=buff.boulderfist.remains<gcd|(maelstrom<=50&active_enemies>=3)
	{'Boulderfist', 'talent(1,3)&player.buff(Boulderfist).remains<gcd||{player.maelstrom<=50&player.area(8).enemies>=3}'},
	--actions+=/boulderfist,if=buff.boulderfist.remains<gcd|(charges_fractional>1.75&maelstrom<=100&active_enemies<=2)
	{'Boulderfist', 'talent(1,3)&player.buff(Boulderfist).remains<gcd||{spell(Boulderfist).charges>1.75&player.maelstrom<=100&player.area(8).enemies<=2}'},
	--actions+=/rockbiter,if=talent.landslide.enabled&buff.landslide.remains<gcd
	{'Rockbiter', 'talent(7,2)&player.buff(Landslide).remains<gcd'},
	--actions+=/fury_of_air,if=!ticking&maelstrom>22
	{'Fury of Air', 'talent(6,2)&!player.buff(Fury of Air)&player.maelstrom>22'},
	--actions+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<gcd&((!talent.fury_of_air.enabled)|(talent.fury_of_air.enabled&maelstrom>25))
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<gcd&{!talent(6,2)||talent(6,2)&player.maelstrom>25}'},
	--actions+=/flametongue,if=buff.flametongue.remains<gcd|(cooldown.doom_winds.remains<6&buff.flametongue.remains<4)
	{'Flametongue', 'player.buff(Flametongue).remains<gcd||{spell(Doom Winds).cooldown<6&player.buff(Flametongue).remains<4}'},
	--actions+=/doom_winds
	{'&Doom Winds'},
	--actions+=/crash_lightning,if=talent.crashing_storm.enabled&active_enemies>=3&(!talent.hailstorm.enabled|buff.frostbrand.remains>gcd)
	{'Crash Lightning', 'talent(6,1)&player.area(8).enemies>=3&{!talent(4,3)||player.buff(Frostbrand).remains>gcd}'},
	--actions+=/earthen_spike
	{'Earthen Spike', 'talent(7,3)'},
	--actions+=/lightning_bolt,if=(talent.overcharge.enabled&maelstrom>=40&!talent.fury_of_air.enabled)|(talent.overcharge.enabled&talent.fury_of_air.enabled&maelstrom>46)
	{'Lightning Bolt', '{talent(5,2)&player.maelstrom>=40&!talent(6,2)}||{talent(5,2)&talent(6,2)&player.maelstrom>46}'},
	--actions+=/crash_lightning,if=buff.crash_lightning.remains<gcd&active_enemies>=2
	{'Crash Lightning', 'player.buff(Crash Lightning).remains<gcd&player.area(8).enemies>=2'},
	--actions+=/windsong
	{'Windsong', 'talent(1,1)'},
	--actions+=/windstrike,if=buff.stormbringer.react&((talent.fury_of_air.enabled&maelstrom>=26)|(!talent.fury_of_air.enabled))
	{'Windstrike', 'talent(7,1)&player.buff(Ascendance)&player.buff(Stormbringer)&{{talent(6,2)&player.maelstrom>=26}||{!talent(6,2)}}'},
	--actions+=/stormstrike,if=buff.stormbringer.react&((talent.fury_of_air.enabled&maelstrom>=26)|(!talent.fury_of_air.enabled))
	{'Stormstrike', 'player.buff(Stormbringer)&{{talent(6,2)&player.maelstrom>=26}||{!talent(6,2)}}'},
	--actions+=/frostbrand,if=equipped.137084&talent.hot_hand.enabled&buff.hot_hand.react&!buff.frostbrand.up&((!talent.fury_of_air.enabled)|(talent.fury_of_air.enabled&maelstrom>25))
	{'Frostbrand', 'equipped(Akainu\'s Absolute Justice)&talent(1,2)&player.buff(Hot Hand)&!player.buff(Frostbrand)&{!talent(6,2)||talent(6,2)&player.maelstrom>25}'},
	--actions+=/lava_lash,if=talent.hot_hand.enabled&buff.hot_hand.react
	{'Lava Lash', 'talent(1,2)&player.buff(Hot Hand)'},
	--actions+=/sundering,if=active_enemies>=3
	{'Sundering', 'talent(6,3)&player.area(8).enemies>=3'},
	--actions+=/crash_lightning,if=active_enemies>=4
	{'Crash Lightning', 'player.area(8).enemies>=4'},
	--actions+=/windstrike,if=talent.overcharge.enabled&cooldown.lightning_bolt.remains<gcd&maelstrom>80
	{'Windstrike', 'talent(5,2)&spell(Lightning Bolt).cooldown<gcd&player.maelstrom>80'},
	--actions+=/windstrike,if=talent.fury_of_air.enabled&maelstrom>46&(cooldown.lightning_bolt.remains>gcd|!talent.overcharge.enabled)
	{'Windstrike', 'talent(6,2)&player.maelstrom>46&{spell(Lightning Bolt).cooldown>gcd||!talent(5,2)}'},
	--actions+=/windstrike,if=!talent.overcharge.enabled&!talent.fury_of_air.enabled
	{'Windstrike', '!talent(5,2)&!talent(6,2)'},
	--actions+=/stormstrike,if=talent.overcharge.enabled&cooldown.lightning_bolt.remains<gcd&maelstrom>80
	{'Stormstrike', 'talent(5,2)&spell(Lightning Bolt).cooldown<gcd&player.maelstrom>80'},
	--actions+=/stormstrike,if=talent.fury_of_air.enabled&maelstrom>46&(cooldown.lightning_bolt.remains>gcd|!talent.overcharge.enabled)
	{'Stormstrike', 'talent(6,2)&player.maelstrom>46&{spell(Lightning Bolt).cooldown>gcd||!talent(5,2)}'},
	--actions+=/stormstrike,if=!talent.overcharge.enabled&!talent.fury_of_air.enabled
	{'Stormstrike', '!talent(5,2)&!talent(6,2)'},
	--actions+=/crash_lightning,if=((active_enemies>1|talent.crashing_storm.enabled|talent.boulderfist.enabled)&!set_bonus.tier19_4pc)|feral_spirit.remains>5
	{'Crash Lightning', '{player.area(8).enemies>1||talent(6,1)||talent(1,3)}&!set_bonus(T19)>=4||spell(Feral Spirit).cooldown>110'},
	--actions+=/crash_lightning,if=active_enemies>=3
	{'Crash Lightning', 'player.area(8).enemies>=3'},
	--actions+=/frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remains<4.8&((!talent.fury_of_air.enabled)|(talent.fury_of_air.enabled&maelstrom>25))
	{'Frostbrand', 'talent(4,3)&player.buff(Frostbrand).remains<4.8&{!talent(6,2)||talent(6,2)&player.maelstrom>25}'},
	--actions+=/frostbrand,if=equipped.137084&!buff.frostbrand.up&((!talent.fury_of_air.enabled)|(talent.fury_of_air.enabled&maelstrom>25))
	{'Frostbrand', 'equipped(Akainu\'s Absolute Justice)&!player.buff(Frostbrand)&{!talent(6,2)||talent(6,2)&player.maelstrom>25}'},
	--actions+=/lava_lash,if=talent.fury_of_air.enabled&talent.overcharge.enabled&(set_bonus.tier19_4pc&maelstrom>=80)
	{'Lava Lash', 'talent(6,2)&talent(5,2)&{set_bonus(T19)>=4&player.maelstrom>=80}'},
	--actions+=/lava_lash,if=talent.fury_of_air.enabled&!talent.overcharge.enabled&(set_bonus.tier19_4pc&maelstrom>=53)
	{'Lava Lash', 'talent(6,2)&!talent(5,2)&{set_bonus(T19)>=4&player.maelstrom>=80}'},
	--actions+=/lava_lash,if=(!set_bonus.tier19_4pc&maelstrom>=120)|(!talent.fury_of_air.enabled&set_bonus.tier19_4pc&maelstrom>=40)
	{'Lava Lash', '!set_bonus(T19)>=4&player.maelstrom>=120||{!talent(6,2)&set_bonus(T19)>=4&player.maelstrom>=40}'},
	--actions+=/flametongue,if=buff.flametongue.remains<4.8
	{'Flametongue', 'player.buff(Flametongue).remains<4.8'},
	--actions+=/rockbiter
	{'Rockbiter'},
	--actions+=/flametongue
	{'Flametongue'},
	--actions+=/boulderfist
	{'Boulderfist', 'talent(1,3)'},
}

local inCombat = {
	{Keybinds, '{!moving||moving}'},
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Cleanse Spirit).cooldown=0'},
	{Survival, '{!moving||moving}'},
	{Player, '!moving&{!ingroup||ingroup}'},
	{Emergency, '!moving&ingroup'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{Cooldowns, '{!moving||moving}&toggle(cooldowns)'},
	{Combat, 'target.infront&target.range<=8'},
}

local outCombat = {
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Cleanse Spirit).cooldown=0'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{Emergency, '!moving&ingroup'},
	{'Healing Surge', '!moving&player.health<=70', 'player'},
	{'Ghost Wolf', 'movingfor>=2&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(263, {
	name = '|r[|cff00fff0Yumad|r] |cff0070deShaman|r - |cff0070deENHANCEMENT|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
