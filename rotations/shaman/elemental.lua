local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', key = 'S_ASE', default = true},
	{type = 'spinner', text = 'Astral Shift (Health %)', key = 'S_AS', default = 40},
	{type = 'checkbox', text = 'Enable Healing Surge', key = 'S_HSGE', default = true},
	{type = 'spinner', text = 'Healing Surge (Health %)', key = 'S_HSG', default = 35},
	{type = 'checkbox', text = 'Enable Earth Elemental', key = 'S_EEE', default = true},
	{type = 'spinner', text = 'Earth Elemental (Health %)', key = 'S_EE', default = 50},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = 'Gift of the Naaru (Health %)', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = 'Healthstone (Health %)', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = 'Ancient Healing Potion (Health %)', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Emergency Healing
	{type = 'header', text = 'Emergency Healing', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Healing', key = 'E_HSGE', default = true},
	{type = 'text', text = 'Thresholds set to ensure party member survival.'},
	{type = 'spinner', text = 'Healing Surge (Health %)', key = 'E_HSG', default = 35},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Shift: Liquid Magma Totem @ Cursor', key = 'K_LMT', default = true},
	{type = 'checkbox', text = 'L-Control: Lightning Surge Totem @ Cursor', key = 'K_LST', default = true},
	{type = 'checkbox', text = 'L-Alt: Earthbind Totem @ Cursor', key = 'K_ET', default = true},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Trinkets
	{type = 'header', text = 'Trinkets', align = 'center'},
	{type = 'text', text = 'Activate on-use trinkets on cooldown.'},
	{type = 'checkbox', text = 'Enable Top Trinket', key = 'trinket_1', default = false},
	{type = 'checkbox', text = 'Enable Bottom Trinket', key = 'Trinket_2', default = false},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cff0070de --- |rShaman: |cff0070deELEMENTAL|r')
	print('|cff0070de --- |rLightning Rod (Mythic+) Talents: 1/3 - 2/1 - 3/1 - 4/2 - 5/2 or 5/3 (Fortified) - 6/1 - 7/2')
	print('|cff0070de --- |rIcefury Talents: 1/2 - 2/1 - 3/1 - 4/2 - 5/3 - 6/3 - 7/3')
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Cleanse Spirit
		key = 'yuPS',
		name = 'Cleanse Spirit',
		text = 'Enable/Disable: Automatic removal of curses.',
		icon = 'Interface\\ICONS\\ability_shaman_cleansespirit',
	})
end

local Survival = {
	-- Astral Shift usage if enabled in UI.
	{'&Astral Shift', 'UI(S_ASE)&player.health<=UI(S_AS)'},
	-- Earth Elemental usage if enabled in UI.
	{'Earth Elemental', 'UI(S_EEE)&player.health<=UI(S_EE)'},
	-- Gift of the Naaru usage if enabled in UI.
	{'&Gift of the Naaru', 'UI(S_GOTNE)&player.health<=UI(S_GOTN)'},
	-- Healthstone usage if enabled in UI.
	{'#Healthstone', 'UI(S_HSE)&player.health<=UI(S_HS)'},
	-- Ancient Healing Potion usage if enabled in UI.
	{'#Ancient Healing Potion', 'UI(S_AHPE)&player.health<=UI(S_AHP)'},
}

local Player = {
	-- Healing Surge usage if enabled in UI.
	{'!Healing Surge', '!moving&UI(S_HSGE)&player.health<=UI(S_HSG)', 'player'},
}

local Emergency = {
	-- Healing Surge usage if enabled in UI.
	{'!Healing Surge', '!moving&UI(E_HSGE)&lowest.health<=UI(E_HSG)', 'lowest'},
}

local Keybinds = {
	-- Liquid Magma Totem at cursor on Left-Shift if enabled in UI.
	{'!Liquid Magma Totem', 'talent(6,1)&keybind(lshift)&UI(K_LMT)', 'cursor.ground'},
	-- Lightning Surge Totem at cursor on Left-Control if enabled in UI.
	{'!Lightning Surge Totem', 'keybind(lcontrol)&UI(K_LST)', 'cursor.ground'},
	-- Earthbind Totem at cursor on Left-Alt if enabled in UI.
	{'!Earthbind Totem', 'keybind(lalt)&UI(K_ET)', 'cursor.ground'},
}

local Trinkets = {
	-- Top Trinket usage if enabled in UI.
	{'#trinket1', 'UI(trinket_1)'},
	-- Bottom Trinket usage if enabled in UI.
	{'#trinket2', 'UI(trinket_2)'},
}

local Interrupts = {
	{'&Wind Shear'},
}

local Dispel = {
	{'%dispelall'},
}

-- ####################################################################################
-- Primairly sourced from legion-dev SimC with additions from Storm, Earth and Lava.
-- Updates to rotations from both sources are considered for implementation.
-- ####################################################################################

-- SimC APL 1/7/2017
-- https://github.com/simulationcraft/simc/blob/legion-dev/profiles/Tier19M/Shaman_Elemental_T19M.simc
-- Lightning Rod Rotation 12/18/2016
-- http://www.stormearthandlava.com/elemental-shaman-hub/lightning-rod-build-guide/
-- Icefury Rotaion 1/8/2017
-- http://www.stormearthandlava.com/elemental-shaman-hub/icefury-build-guide/
-- Ascendance Rotaion 1/8/2017
-- http://www.stormearthandlava.com/elemental-shaman-hub/ascendance-build-guide/

local AoE = {
	--actions.aoe+=/totem_mastery
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	--actions.aoe=stormkeeper
	{'Stormkeeper'},
	--actions.aoe+=/ascendance
	{'Ascendance', '{!moving||moving}&talent(7,1)'},
	--actions.aoe+=/liquid_magma_totem
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)', 'cursor.ground'},
	--actions.aoe+=/flame_shock,if=spell_targets.chain_lightning<4&maelstrom>=20&!talent.lightning_rod.enabled,target_if=refreshable
	--***Flame Shock according to AoE Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Flame Shock', '{!moving||moving}&!talent(7,2)&player.maelstrom>=20&target.debuff(Flame Shock).duration<gcd'},
	{'Flame Shock', '{!moving||moving}&talent(7,2)&{player.area(40).enemies<4&!target.debuff(Flame Shock)||player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9}'},
	--actions.aoe+=/earthquake
	{'Earthquake', '{!moving||moving}&player.maelstrom>=50', 'cursor.ground'},
	--actions.aoe+=/lava_burst,if=dot.flame_shock.remains>cast_time&buff.lava_surge.up&!talent.lightning_rod.enabled&spell_targets.chain_lightning<4
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||!moving&!talent(7,2)&target.debuff(Flame Shock).duration>spell(Lava Burst).casttime'},
	--actions.aoe+=/elemental_blast,if=!talent.lightning_rod.enabled&spell_targets.chain_lightning<5
	--***Elemental Blast according to Fortified affix Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Elemental Blast', 'talent(5,3)'},
	--actions.aoe+=/lava_beam
	{'Lava Beam', 'talent(7,1)&player.buff(Ascendance)'},
	--actions.aoe+=/chain_lightning,target_if=debuff.lightning_rod.down
	{'Chain Lightning', 'talent(7,2)&!target.debuff(Lightning Rod)'},
	--actions.aoe+=/chain_lightning
	{'Chain Lightning', nil, 'target'},
}

-- Lightning Rod Rotation ##############################################################
local LRCooldowns = {
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Elemental Mastery', 'talent(6,1)'}, -- Remove when 7.1.5 is LIVE.
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
}

local LRSingle = {
	--actions.single_lr+=/totem_mastery
	{'Totem Mastery', '{!moving||moving}&talent(1,3)&{totem(Totem Mastery).duration<1||!player.buff(Tailwind Totem)||!player.buff(Storm Totem)||!player.buff(Resonance Totem)||!player.buff(Ember Totem)}'},
	--actions.single_lr=flame_shock,if=!ticking
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)'},
	--actions.single_lr+=/earthquake,if=buff.echoes_of_the_great_sundering.up&maelstrom>=86
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>=86', 'cursor.ground'},
	--actions.single_lr+=/earth_shock,if=maelstrom>=92
	{'Earth Shock', '{!moving||moving}&player.maelstrom>=92'},
	--actions.single_lr+=/stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
	{'Stormkeeper'},
	--actions.single_lr+=/elemental_blast
	{'Elemental Blast', 'talent(5,3)'},
	--actions.single_lr+=/liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)', 'cursor.ground'},
	--actions.single_lr+=/lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
	--***Lava Burst according to Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&spell(Lava Burst).cooldown=0'},
	{'Lava Burst', 'player.buff(Stormkeeper)&target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&spell(Lava Burst).cooldown=0&player.buff(Stormkeeper).duration>spell(Lava Burst).casttime+{1.5*{spell_haste}*player.buff(Stormkeeper).count+1}'},
	--actions.single_lr+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	{'Flame Shock', '{!moving||moving}&player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--actions.single_lr+=/earth_shock,if=maelstrom>=86
	--***Earth Shock according to AoE Lightning Rod Rotaion from Storm, Earth and Lava***
	{'Earth Shock', '{!moving||moving}&player.maelstrom>=86&!player.buff(Lava Surge)'},
	--actions.single_lr+=/earthquake,if=buff.echoes_of_the_great_sundering.up
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)', 'cursor.ground'},
	--actions.single_lr+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3,target_if=debuff.lightning_rod.down
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&!target.debuff(Lightning Rod)'},
	--actions.single_lr+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	--actions.single_lr+=/lightning_bolt,target_if=debuff.lightning_rod.down
	{'Lightning Bolt', '!target.debuff(Lightning Rod)'},
	--actions.single_lr+=/lightning_bolt
	{'Lightning Bolt', nil, 'target'},
}

-- Icefury Rotation ###################################################################
local IFCooldowns = {
	{'Stormkeeper'},
	{'Fire Elemental', '!talent(6,2)'},
	{'&Blood Fury', 'lastcast(Fire Elemental)'},
	{'&Berserking', 'lastcast(Fire Elemental)'},
}

local IFSingle = {
	--actions.single_if=flame_shock,if=!ticking
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)'},
	--actions.single_if+=/earthquake,if=buff.echoes_of_the_great_sundering.up&maelstrom>=86
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)&player.maelstrom>=86', 'cursor.ground'},
	--actions.single_if+=/earth_shock,if=maelstrom>=92
	{'Earth Shock', '{!moving||moving}&player.maelstrom>=92'},
	--actions.single_if+=/stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
	{'Stormkeeper'},
	--actions.single_if+=/elemental_blast
	{'Elemental Blast', 'talent(5,3)'},
	--actions.single_if+=/icefury,if=raid_event.movement.in<5|maelstrom<=76
	{'Icefury', 'player.maelstrom<=76'},
	--actions.single_if+=/liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
	{'Liquid Magma Totem', '{!moving||moving}&talent(6,1)', 'cursor.ground'},
	--actions.single_if+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)&player.buff(Stormkeeper)'},
	--actions.single_if+=/lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
	--***Lava Burst according to Icefury Rotaion from Storm, Earth and Lava***
	{'Lava Burst', '{!moving||moving}&player.buff(Lava Surge)||target.debuff(Flame Shock).duration>spell(Lava Burst).casttime&{spell(Lava Burst).cooldown=0||player.maelstrom<=88&spell(Lava Burst).charges<=2}'},
	--actions.single_if+=/frost_shock,if=buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)|buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack+1))
	--***Frost Shock according to Icefury Rotaion from Storm, Earth and Lava***
	{'Frost Shock', '{!moving||moving}&player.buff(Icefury)&{lastcast(Icefury)||player.maelstrom>=20||player.buff(Icefury).duration<{1.5*{spell_haste}*player.buff(Icefury).count+1}}'},
	--actions.single_if+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	{'Flame Shock', '{!moving||moving}&player.maelstrom>=20&player.buff(Elemental Focus)&target.debuff(Flame Shock).duration<9'},
	--actions.single_if+=/frost_shock,moving=1,if=buff.icefury.up
	{'Frost Shock', '{!moving||moving}&player.buff(Icefury)'},
	--actions.single_if+=/earth_shock,if=maelstrom>=86
	{'Earth Shock', '{!moving||moving}&player.maelstrom>=86'},
	--actions.single_if+=/earthquake,if=buff.echoes_of_the_great_sundering.up
	{'Earthquake', '{!moving||moving}&player.buff(Echoes of the Great Sundering)', 'cursor.ground'},
	--actions.single_if+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
	{'Lightning Bolt', 'player.buff(Power of the Maelstrom)'},
	--actions.single_if+=/lightning_bolt
	{'Lightning Bolt', nil, 'target'},
}

-- Ascendance Rotation ################################################################
local ASCooldowns = {
}

local ASSingle = {
	--actions.single_asc=ascendance,if=dot.flame_shock.remains>buff.ascendance.duration&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&!buff.stormkeeper.up
	--actions.single_asc+=/flame_shock,if=!ticking
	--actions.single_asc+=/flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
	--actions.single_asc+=/earthquake,if=buff.echoes_of_the_great_sundering.up&!buff.ascendance.up&maelstrom>=86
	--actions.single_asc+=/earth_shock,if=maelstrom>=92&!buff.ascendance.up
	--actions.single_asc+=/stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
	--actions.single_asc+=/elemental_blast
	--actions.single_asc+=/liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
	--actions.single_asc+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
	--actions.single_asc+=/lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react|buff.ascendance.up)
	--actions.single_asc+=/flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
	--actions.single_asc+=/earth_shock,if=maelstrom>=86
	--actions.single_asc+=/totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
	--actions.single_asc+=/earthquake,if=buff.echoes_of_the_great_sundering.up
	--actions.single_asc+=/lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
	--actions.single_asc+=/lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
	--actions.single_asc+=/chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
	--actions.single_asc+=/lightning_bolt
	--actions.single_asc+=/flame_shock,moving=1,target_if=refreshable
	--actions.single_asc+=/earth_shock,moving=1
	--actions.single_asc+=/flame_shock,moving=1,if=movement.distance>6
}

local inCombat = {
	{Keybinds, '{!moving||moving}'},
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Cleanse Spirit).cooldown=0'},
	{Survival, '{!moving||moving}'},
	{Player, 'player.health<100'},
	{Emergency},
	{Trinkets, '{!moving||moving}'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{LRCooldowns, '{!moving||moving}&talent(7,2)&toggle(cooldowns)'},
	{IFCooldowns, '{!moving||moving}&talent(7,3)&toggle(cooldowns)'},
	{AoE, 'toggle(aoe)&player.area(40).enemies>2'},
	{LRSingle, 'talent(7,2)&target.infront&target.range<=40'},
	{IFSingle, 'talent(7,3)&target.infront&target.range<=40'},
}

local outCombat = {
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Cleanse Spirit).cooldown=0'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{'Healing Surge', '!moving&lowest.health<=70', 'lowest'},
	{'Ghost Wolf', 'movingfor>=2&!player.buff(Ghost Wolf)'},
}

NeP.CR:Add(262, {
	name = '|r[|cff00fff0Yumad|r] Shaman - |cff0068ffElemental|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})