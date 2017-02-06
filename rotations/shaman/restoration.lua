local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Astral Shift', key = 'S_ASE', default = true},
	{type = 'spinner', text = '', key = 'S_AS', default = 40},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},
	
	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Shift: Healing Rain @ Cursor', key = 'K_HR', default = true},
	{type = 'checkbox', text = 'L-Control: Lightning Surge Totem @ Cursor', key = 'K_LST', default = true},
	{type = 'checkbox', text = 'L-Alt: Cloudburst Totem @ Cursor', key = 'K_CT', default = true},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Healing Stream Totem
	{type = 'header', text = 'Healing Stream Totem', align = 'center'},
	{type = 'checkbox', text = 'Enable Healing Stream Totem', key = 'To_HSTE', default = true},
	{type = 'text', text = 'Deploy totem on cooldown.'},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Earthen Shield Totem
	{type = 'header', text = 'Earthen Shield Totem', align = 'center'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required to deploy Earthen Shield Totem on top of tank.|r'},
	{type = 'checkbox', text = 'Enable Earthen Shield Totem', key = 'To_ESTE', default = true},
	{type = 'text', text = 'Deploy totem on cooldown.'},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Emergency Healing
	{type = 'header', text = 'Emergency Healing', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Healing', key = 'E_EH', default = true},
	{type = 'text', text = 'Riptide'},
	{type = 'spinner', text = 'Riptide', key = 'E_RT', default = 25},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'E_HSG', default = 35},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Tank Healing
	{type = 'header', text = 'Tank Healing', align = 'center'},
	{type = 'text', text = 'Force Riptide'},
	{type = 'spinner', text = '', key = 'T_FRT', default = 90},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'T_HS', default = 80},
	{type = 'spacer'},
	{type = 'header', text = 'AoE Tank Healing', align = 'center'},
	{type = 'text', text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of tank.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', key = 'T_HRE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'checkbox', text = 'Enable Chain Heal', key = 'T_CHE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Player Healing
	{type = 'header', text = 'Player Healing', align = 'center'},
	{type = 'text', text = 'Force Riptide'},
	{type = 'spinner', text = '', key = 'P_FRT', default = 85},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'P_HS', default = 75},
	{type = 'spacer'},
	{type = 'header', text = 'AoE Player Healing', align = 'center'},
	{type = 'text', text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of player.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', key = 'P_HRE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'checkbox', text = 'Enable Chain Heal', key = 'P_CHE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Lowest Healing
	{type = 'header', text = 'Lowest Healing', align = 'center'},
	{type = 'text', text = 'Force Riptide'},
	{type = 'spinner', text = '', key = 'L_FRT', default = 80},
	{type = 'text', text = 'Healing Surge'},
	{type = 'spinner', text = '', key = 'L_HS', default = 70},
	{type = 'text', text = '|cffff0000Elemental DPS rotation is dependent on the value set for Healing Wave.|r'},
	{type = 'text', text = '|cffff0000@ 100% = Healing Wave filler spam at all times.|r'},
	{type = 'text', text = '|cffff0000@ < 100% = Elemental DPS takes precedence.|r'},
	{type = 'text', text = 'Healing Wave'},
	{type = 'spinner', text = '', key = 'L_HW', default = 100},
	{type = 'spacer'},
	{type = 'header', text = 'AoE Lowest Healing', align = 'center'},
	{type = 'text', text = 'Toggle Multitarget on NeP Bar.'},
	{type = 'text', text = '|cffff0000Advanced LUA unlocker required for Healing Rain ontop of lowest health player.|r'},
	{type = 'checkbox', text = 'Enable Healing Rain', key = 'L_HRE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'checkbox', text = 'Enable Chain Heal', key = 'L_CHE', default = true},
	{type = 'text', text = 'Active: when 3 or more players within 40yds. drop below 80% health.'},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cff0070de --- |rShaman: |cff0070deRESTORATION|r')
	print('|cff0070de --- |rTalents: 1/3 - 2/2 - 3/1 - 4/2 - 5/3 - 6/2 - 7/?|r')
	print('|cff0070de ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Purify Spirit
		key = 'yuPS',
		name = 'Purify Spirit',
		text = 'Enable/Disable: Automatic removal of a curse or magic effect',
		icon = 'Interface\\ICONS\\ability_shaman_cleansespirit',
	})
	
	NeP.Interface:AddToggle({
		-- Elemental DPS
		key = 'yuDPS',
		name = 'Elemental DPS',
		text = 'Enable/Disable: Elemental DPS in rotation. Set Healing Wave value to < 100',
		icon = 'Interface\\ICONS\\spell_fire_flameshock',
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

local Keybinds = {
	-- Healing Rain at cursor on Left-Shift if enabled in UI.
	{'!Healing Rain', 'UI(K_HR)&keybind(lshift)', 'cursor.ground'},
	-- Lightning Surge Totem at cursor on Left-Control if enabled in UI.
	{'!Lightning Surge Totem', 'UI(K_LST)&keybind(lcontrol)', 'cursor.ground'},
	-- Cloudburst Totem at cursor on Left-Alt if enabled in UI.
	{'!Cloudburst Totem', 'UI(K_CT)&keybind(lalt)', 'cursor.ground'},
}

local Totems = {
	-- Healing Stream Totem usage if enabled in UI.
	{'Healing Stream Totem', 'UI(To_HSTE)'},
	-- Earthen Shield Totem usage if enabled in UI.
	{'Earthen Shield Totem', 'advanced&UI(To_ESTE)', 'tank.ground'},
}

local Emergency = {
	-- Riptide usage if enabled in UI.
	{'!Riptide', '{!moving||moving}&{!lowest.debuff(Ignite Soul)}&UI(E_EH)&lowest.health<=UI(E_RT)', 'lowest'},
	-- Healing Surge usage if enabled in UI.
	{'!Healing Surge', '!moving&UI(E_EH)&{!lowest.debuff(Ignite Soul)}&lowest.health<=UI(E_HSG)', 'lowest'},
}

local Interrupts = {
	{'&Wind Shear'},
}

local Dispel ={
	{'%dispelall'},
}

local DPS = {
	{'Flame Shock', '{!moving||moving}&!target.debuff(Flame Shock)'},
	{'Lava Burst', 'target.debuff(Flame Shock).duration>spell(Lava Burst).casttime'},
	{'Chain Lightning', 'player.area(40).enemies>=2', 'target'},
	{'Lightning Bolt', nil, 'target'},
}

local Tank = {
	{'Riptide', '{!moving||moving}&tank.buff(Riptide).duration<=5||tank.health<=UI(T_FRT)', 'tank'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'tank.health<=UI(T_HS)', 'tank'},
		{'Healing Rain', 'advanced&UI(T_HRE)&toggle(AoE)&tank.area(10,90).heal>=1', 'tank.ground'},
		{'Chain Heal', 'UI(T_CHE)&toggle(AoE)&tank.area(40,80).heal>=2', 'tank'},
	}, {'!moving||player.buff(Spiritwalker\'s Grace)&moving'}},
}

local Player = {
	{'Riptide', '{!moving||moving}&player.buff(Riptide).duration<=5||player.health<=UI(P_FRT)', 'player'},
	{{ -- Spiritwalker's Grace
		{'Healing Surge', 'player.health<=UI(P_HS)', 'player'},
		{'Healing Rain', 'advanced&UI(P_HRE)&toggle(AoE)&player.area(10,90).heal>=2', 'player.ground'},
		{'Chain Heal', 'UI(P_CHE)&toggle(AoE)&player.area(40,80).heal>=2', 'player'},
	}, {'!moving||player.buff(Spiritwalker\'s Grace)&moving'}},
}

local Lowest = {
	{'Riptide', '{!moving||moving}&lowest.buff(Riptide).duration<=5||lowest.health<=UI(L_FRT)', 'lowest'},
	{{ -- Spiritwalker's Grace
		{'Healing Wave', 'lowest.health<=UI(L_HW)', 'lowest'},
		{'Healing Rain', 'advanced&UI(L_HRE)&toggle(AoE)&lowest.area(10,90).heal>=2', 'lowest.ground'},
		{'Chain Heal', 'UI(L_CHE)&toggle(AoE)&lowest.area(40,80).heal>=2', 'lowest'},
		{'Healing Surge', 'lowest.health<=UI(L_HS)', 'lowest'},
	}, {'!moving||player.buff(Spiritwalker\'s Grace)&moving'}},
}

local inCombat = {
	{Keybinds, '{!moving||moving}'},
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Purify Spirit).cooldown=0'},
	{Survival, '{!moving||moving}'},
	{Emergency},
	{Totems, '{!moving||moving}'},
	{Tank, 'tank.exists&tank.health<100'},
	{Lowest, 'lowest.health<100'},
	{Player, 'player.health<100'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{DPS, 'toggle(yuDPS)&target.range<40&target.infront'},
}

local outCombat = {
	{Dispel, '{!moving||moving}&toggle(yuPS)&spell(Purify Spirit).cooldown=0'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront&target.range<=30'},
	{'Riptide', '{!moving||moving}&lowest.health<100', 'lowest'},
	{Lowest, 'lowest.health<100'},
}

NeP.CR:Add(264, {
	name = '|r[|cff00fff0Yumad|r] |cff0070deShaman|r - |cff0070deRESTORATION|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
