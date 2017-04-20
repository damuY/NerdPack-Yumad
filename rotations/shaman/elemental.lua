local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', key = 'S_ASE', default = true},
	{type = 'spinner', text = '', key = 'S_AS', default = 40},
	{type = 'checkbox', text = 'Enable Healing Surge', key = 'S_HSGE', default = true},
	{type = 'spinner', text = '', key = 'S_HSG', default = 35},
	{type = 'checkbox', text = 'Enable Earth Elemental', key = 'S_EEE', default = true},
	{type = 'spinner', text = '', key = 'S_EE', default = 20},
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
	{type = 'checkbox', text = 'L-Shift: Liquid Magma Totem @ Cursor', key = 'K_LMT', default = true},
	{type = 'checkbox', text = 'L-Control: Lightning Surge Totem @ Cursor', key = 'K_LST', default = true},
	{type = 'checkbox', text = 'L-Alt: Earthbind Totem @ Cursor', key = 'K_ET', default = true},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cff0070de --- |rShaman: |cff0070deELEMENTAL|r')
	print('|cff0070de --- |rLightning Rod: 1/3 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3 - 7/2|r')
	print('|cff0070de --- |rIcefury: 1/3 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3 - 7/3|r')
	print('|cff0070de --- |rAscendance: 1/3 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3 - 7/1|r')
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
	-- Earth Elemental usage if enabled in UI.
	{'Earth Elemental', '!ingroup&UI(S_EEE)&player.health<=UI(S_EE)'},
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
	-- Liquid Magma Totem at cursor on Left-Shift if enabled in UI.
	{'!Liquid Magma Totem', 'UI(K_LMT)&talent(6,1)&keybind(lshift)', 'cursor.ground'},
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
-- Primairly sourced from legion-dev SimC with additions from Storm, Earth and Lava.
-- Updates to rotations from sources are considered for implementation.
-- ####################################################################################

-- SimC APL 4/20/2017
-- https://github.com/simulationcraft/simc/blob/legion-dev/profiles/Tier19M/Shaman_Elemental_T19M.simc
-- Lightning Rod Rotation 4/20/2017
-- http://www.stormearthandlava.com/elemental-shaman-hub/lightning-rod-build-guide/
-- Icefury Rotaion 4/20/2017
-- http://www.stormearthandlava.com/elemental-shaman-hub/icefury-build-guide/
-- Ascendance Rotaion 4/20/2017
-- http://www.stormearthandlava.com/elemental-shaman-hub/ascendance-build-guide/

local AoE = {
	--actions.aoe+=/totem_mastery
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	--actions.aoe=stormkeeper
	{'Stormkeeper'},
	--actions.aoe+=/liquid_magma_totem
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)&!advanced', 'cursor.ground'},
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)&advanced', 'target.ground'},
	--actions.aoe+=/flame_shock,if=spell_targets.chain_lightning<4&maelstrom>=20,target_if=refreshable
	{'Flame Shock', '{!moving||moving}&player.maelstrom>=20&target.debuff(Flame Shock).duration<gcd'},
	--actions.aoe+=/earthquake
	{'Earthquake', '{!moving||moving}&player.maelstrom>=50&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.maelstrom>=50&advanced', 'target.ground'},
	--actions.aoe+=/lava_burst,if=dot.flame_shock.remains>cast_time&buff.lava_surge.up&!talent.lightning_rod.enabled&spell_targets.chain_lightning<4
	{'Lava Burst', '{!moving||moving}&{player.buff(Lava Surge)||!talent(7,2)&target.debuff(Flame Shock).duration>spell(Lava Burst).casttime}'},
	--actions.aoe+=/elemental_blast,if=!talent.lightning_rod.enabled&spell_targets.chain_lightning<5
	{'Elemental Blast', 'talent(5,3)'},
	--actions.aoe+=/lava_beam
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)'},
	--actions.aoe+=/chain_lightning,target_if=debuff.lightning_rod.down
	{'Chain Lightning', 'talent(7,2)&{!target.debuff(Lightning Rod)||player.buff(Stormkeeper)}'},
	--actions.aoe+=/chain_lightning
	{'Chain Lightning', nil, 'target'},
}

-- Lightning Rod Rotation ##############################################################
local LRCooldowns = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)||spell(Fire Elemental).cooldown>=255'},
	{'&Berserking', 'lastcast(Fire Elemental)||spell(Fire Elemental).cooldown>=250'},
}

local LRSingle = {
	--actions.single_lr+=/totem_mastery
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	--actions.single_lr=flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
	{'Flame Shock', '{!moving||moving}&{!target.debuff(Flame Shock)||target.debuff(Flame Shock).duration<=gcd}'},
	--actions.single_lr+=/earthquake,if=buff.echoes_of_the_great_sundering.up&maelstrom>=86
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>=86&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>=86&advanced', 'target.ground'},
	--actions.single_lr+=/elemental_blast
	{'Elemental Blast', 'talent(5,3)'},
	--actions.single_lr+=/earth_shock,if=maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92
	{'Earth Shock', '{!moving||moving}&{player.maelstrom>=117||!artifact(Swelling Maelstrom).enabled&player.maelstrom>=92}'},
	--actions.single_lr+=/stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
	{'Stormkeeper'},
	--actions.single_lr+=/lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
	--added Stormkeeper check for hard-cast LB 
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&spell(Lava Burst).cooldown=0&{!player.buff(Stormkeeper)||player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}}'},
	--actions.single_lr+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	{'Flame Shock', '{!moving||moving}&player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--actions.single_lr+=/earth_shock,if=maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86
	{'Earth Shock', '{!moving||moving}&{player.maelstrom>=111||!artifact(Swelling Maelstrom).enabled&player.maelstrom>=86}'},
	--actions.single_lr+=/earthquake,if=buff.echoes_of_the_great_sundering.up
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&advanced', 'target.ground'},
	--actions.single_lr+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3,target_if=debuff.lightning_rod.down
	--added Stormkeeper check for PotM with AoE toggle disabled 
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&{!target.debuff(Lightning Rod)||player.buff(Stormkeeper)&!toggle(aoe)}'},
	--actions.single_lr+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	--actions.single_lr+=/lightning_bolt,target_if=debuff.lightning_rod.down
	{'Lightning Bolt', '!target.debuff(Lightning Rod)'},
	--actions.single_lr+=/lightning_bolt
	{'Lightning Bolt', nil, 'target'},
}

-- Icefury Rotation ###################################################################
local IFCooldowns = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)||spell(Fire Elemental).cooldown>=255'},
	{'&Berserking', 'lastcast(Fire Elemental)||spell(Fire Elemental).cooldown>=250'},
}

local IFSingle = {
	--actions.single_if+=/totem_mastery
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	--actions.single_if=flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
	{'Flame Shock', '{!moving||moving}&{!target.debuff(Flame Shock)||target.debuff(Flame Shock).duration<=gcd}'},
	--actions.single_if+=/earthquake,if=buff.echoes_of_the_great_sundering.up&maelstrom>=86
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>=86&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>=86&advanced', 'target.ground'},
	--actions.single_if+=/frost_shock,if=buff.icefury.up&maelstrom>=111
	--added Swelling Maelstrom check
	{'Frost Shock', 'player.buff(Icefury)&{player.maelstrom>=111||!artifact(Swelling Maelstrom).enabled&player.maelstrom>=86}'},
	--actions.single_if+=/elemental_blast
	{'Elemental Blast', 'talent(5,3)'},
	--actions.single_if+=/earth_shock,if=maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92
	{'Earth Shock', '{!moving||moving}&{player.maelstrom>=117||!artifact(Swelling Maelstrom).enabled&player.maelstrom>=92}'},
	--actions.single_if+=/stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
	--added Icefury check
	{'Stormkeeper', '!player.buff(Icefury)'},
	--actions.single_if+=/icefury,if=raid_event.movement.in<5|maelstrom<=101
	--added Swelling Maelstrom and Stormkeeper checks
	{'Icefury', '!player.buff(Stormkeeper)&{player.maelstrom>=101||!artifact(Swelling Maelstrom).enabled&player.maelstrom>=76}'},
	--actions.single_if+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&player.buff(Stormkeeper)'},
	--actions.single_if+=/lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
	--added Lava Surge, Swelling Maelstrom, and Lava Burst count=2 checks
	{'Lava Burst', '{!moving||moving}&{player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&{spell(Lava Burst).cooldown=0&{player.maelstrom<=113||!artifact(Swelling Maelstrom).enabled&player.maelstrom<=88||spell(Lava Burst).charges<=2}}}'},
	--actions.single_if+=/frost_shock,if=buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)|buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack+1))
	--added lastcast check for Icefury
	{'Frost Shock', '{!moving||moving}&player.buff(Icefury)&{lastcast(Icefury)||player.maelstrom>=20||player.buff(Icefury).duration<{1.5*{spell_haste}*player.buff(Icefury).count+1}}'},
	--actions.single_if+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	{'Flame Shock', '{!moving||moving}&player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--actions.single_if+=/frost_shock,moving=1,if=buff.icefury.up
	{'Frost Shock', '{!moving||moving}&player.buff(Icefury)'},
	--actions.single_if+=/earth_shock,if=maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86
	{'Earth Shock', '{!moving||moving}&{player.maelstrom>=111||!artifact(Swelling Maelstrom).enabled&player.maelstrom>=86}'},
	--actions.single_if+=/earthquake,if=buff.echoes_of_the_great_sundering.up
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&advanced', 'target.ground'},
	--actions.single_if+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	--actions.single_if+=/lightning_bolt
	{'Lightning Bolt', nil, 'target'},
}

-- Ascendance Rotation ################################################################
local ASCooldowns = {
	{'Ascendance', 'spell(Lava Burst).cooldown>0&!player.buff(Stormkeeper)'},
	{'Stormkeeper', '!player.buff(Ascendance)'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)||spell(Fire Elemental).cooldown>=255'},
	{'&Berserking', 'lastcast(Fire Elemental)||spell(Fire Elemental).cooldown>=250'},
}

local ASSingle = {
	--actions.single_asc+=/flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)||target.debuff(Flame Shock).duration<=gcd'},
	--actions.single_asc+=/flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
	{'Flame Shock', 'player.maelstrom>=20&target.debuff(Flame Shock).duration<=player.buff(Ascendance).duration&spell(Ascendance).cooldown+player.buff(Ascendance).duration<=target.debuff(Flame Shock).duration'},
	--actions.single_asc+=/elemental_blast
	{'Elemental Blast', 'talent(5,3)'},
	--actions.single_asc+=/earthquake,if=buff.echoes_of_the_great_sundering.up&!buff.ascendance.up&maelstrom>=86
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&player.maelstrom>=86&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&player.maelstrom>=86&advanced', 'target.ground'},
	--actions.single_asc+=/earth_shock,if=maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92
	--added Ascendance check
	{'Earth Shock', '{!moving||moving}&{player.maelstrom>=117||!player.buff(Ascendance)&!artifact(Swelling Maelstrom).enabled&player.maelstrom>=92}'},
	--actions.single_asc+=/stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
	{'Stormkeeper', '!player.buff(Ascendance)'},
	--actions.single_asc+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
	--added Lava Burst count<2 check
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&player.buff(Stormkeeper)'},
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&spell(Lava Burst).charges<2'},
	--actions.single_asc+=/lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react|buff.ascendance.up)
	--added Lava Surge and Stormkeeper check
	{'Lava Burst', '{!moving||moving}&{player.buff(Lava Surge)&{!player.buff(Ascendance)&player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}}||player.buff(Ascendance)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&spell(Lava Burst).cooldown=0}'},
	--actions.single_asc+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	{'Flame Shock', '{!moving||moving}&player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--actions.single_asc+=/earth_shock,if=maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86
	--added Ascendance check
	{'Earth Shock', '{!moving||moving}&{player.maelstrom>=111||!player.buff(Ascendance)&!artifact(Swelling Maelstrom).enabled&player.maelstrom>=86}'},
	--actions.single_asc+=/earthquake,if=buff.echoes_of_the_great_sundering.up
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&!advanced', 'cursor.ground'},
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&!player.buff(Ascendance)&advanced', 'target.ground'},
	--actions.single_asc+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	--actions.single_asc+=/lightning_bolt
	{'Lightning Bolt', nil, 'target'},
}

local inCombat = {
	{Keybinds, '{!moving||moving}'},
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Cleanse Spirit).cooldown=0'},
	{Survival, '{!moving||moving}'},
	{Player, '!moving&{!ingroup||ingroup}'},
	{Emergency, '!moving&ingroup'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{LRCooldowns, '{!moving||moving}&talent(7,2)&toggle(cooldowns)'},
	{IFCooldowns, '{!moving||moving}&talent(7,3)&toggle(cooldowns)'},
	{ASCooldowns, '{!moving||moving}&talent(7,1)&toggle(cooldowns)'},
	{AoE, 'toggle(aoe)&player.area(40).enemies>2'},
	{LRSingle, 'talent(7,2)&target.infront&target.range<=40'},
	{IFSingle, 'talent(7,3)&target.infront&target.range<=40'},
	{ASSingle, 'talent(7,1)&target.infront&target.range<=40'},
}

local outCombat = {
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Cleanse Spirit).cooldown=0'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{Emergency, '!moving&ingroup'},
	{'Healing Surge', '!moving&player.health<=70', 'player'},
	{'Ghost Wolf', 'movingfor>=2&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(262, {
	name = '|r[|cff00fff0Yumad|r] |cff0070deShaman|r - |cff0070deELEMENTAL|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
