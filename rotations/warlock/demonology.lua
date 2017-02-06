local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Unending Resolve', key = 'S_UEE', default = true},
	{type = 'spinner', text = '', key = 'S_UE', default = 40},
	{type = 'checkbox', text = 'Enable Dark Pact', key = 'S_DPE', default = true},
	{type = 'spinner', text = '', key = 'S_DP', default = 50},
	{type = 'checkbox', text = 'Enable Drain Life', key = 'S_DLE', default = true},
	{type = 'spinner', text = '', key = 'S_DL', default = 30},
	{type = 'checkbox', text = 'Enable Health Funnel', key = 'S_HFE', default = true},
	{type = 'spinner', text = '', key = 'S_HF', default = 60},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Control: Shadowfury @ Cursor', key = 'K_SF', default = true},
	{type = 'checkbox', text = 'L-Alt: Demonic Circle', key = 'K_DC', default = true},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cff8788ee ----------------------------------------------------------------------|r')
	print('|cff8788ee --- |rWarlock: |cff8788eeDEMONOLOGY|r')
	print('|cff8788ee --- |rSpecific Talents: 1/3 - 2/2 - 3/X - 4/2 - 5/X - 6/2 - 7/2|r')
	print('|cff8788ee --- |rPet: Felguard|r')
	print('|cff8788ee ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Doom
		key = 'yuDoom',
		name = 'Doom',
		text = 'Enable/Disable: Casting of Doom on targets',
		icon = 'Interface\\ICONS\\spell_shadow_auraofdarkness',
	})
end

local Survival = {
	-- Unending Resolve usage if enabled in UI.
	{'&Unending Resolve', 'UI(S_UEE)&player.health<=UI(S_UE)'},
	-- Dark Pact usage if enabled in UI.
	{'&Dark Pact', 'UI(S_DPE)&talent(5,3)&pet.exists&player.health<=UI(S_DP)'},
	-- Gift of the Naaru usage if enabled in UI.
	{'&Gift of the Naaru', 'UI(S_GOTNE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_GOTN)'},
	-- Healthstone usage if enabled in UI.
	{'#5512', 'UI(S_HSE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HS)'},
	-- Ancient Healing Potion usage if enabled in UI.
	{'#127834', 'UI(S_AHPE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_AHP)'},
}

local Player = {
	-- Drain Life usage if enabled in UI.
	{'!Drain Life', 'UI(S_DLE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_DL)', 'target'},
	-- Health Funnel usage if enabled in UI.
	{'!Health Funnel', 'UI(S_HFE)&pet.exists&pet.health<=UI(S_HF)', 'pet'},
}

local Keybinds = {
	-- Shadowfury at cursor on Left-Control if enabled in UI.
	{'!Shadowfury', '!moving&UI(K_SF)&talent(3,3)&keybind(lcontrol)', 'cursor.ground'},
	-- Demonic Circle on Left-Alt if enabled in UI.
	{'!Demonic Circle', '{!moving||moving}UI(K_DC)&talent(3,1)&keybind(lalt)'},
}

-- ####################################################################################
-- Primairly sourced from legion-dev SimC.
-- Updates to rotations from sources are considered for implementation.
-- ####################################################################################

-- SimC APL 1/17/2017
-- https://github.com/simulationcraft/simc/blob/legion-dev/profiles/Tier19M/Warlock_Demonology_T19M.simc

local Cooldowns = {
	{'&Arcane Torrent'},
	{'&Berserking'},
	{'&Blood Fury'},
	{'Grimoire: Felguard', 'talent(6,2)'},	
	{'Summon Doomguard', '!talent(6,1)&target.area(10).enemies<=2'},
	{'Summon Infernal', '!talent(6,1)&target.area(10).enemies>2&!advanced', 'cursor.ground'},
	{'Summon Infernal', '!talent(6,1)&target.area(10).enemies>2&advanced', 'target.ground'},
	{'Summon Doomguard', 'talent(6,1)&target.area(10).enemies=1&player.buff(Sin\'dorei Spite)'},
	{'Summon Infernal', 'talent(6,1)&target.area(10).enemies>1&player.buff(Sin\'dorei Spite)&!advanced', 'cursor.ground'},
	{'Summon Infernal', 'talent(6,1)&target.area(10).enemies>1&player.buff(Sin\'dorei Spite)&advanced', 'target.ground'},
}

local DW_Clip = {
	--actions+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
	{'!Summon Felguard', '!moving&!pet.exists&!talent(6,1)'},
	--actions+=/call_dreadstalkers,if=(!talent.summon_darkglare.enabled|talent.power_trip.enabled)&(spell_targets.implosion<3|!talent.implosion.enabled)
	{'!Call Dreadstalkers', '!moving||!moving&player.buff(Demonic Calling)'},
	--actions+=/hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
	{'!Hand of Gul\'dan', '!moving&soulshards>=4'},
	--actions+=/thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
	{'!Thal\'kiel\'s Consumption', '!moving&spell(Call Dreadstalkers).cooldown>3&lastgcd(Hand of Gul\'dan)'},
	--actions+=/demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
	{'!Demonic Empowerment', '!moving&!lastgcd(Demonic Empowerment)&{warlock.empower=0||lastgcd(Summon Felguard)||lastgcd(Call Dreadstalkers)||lastgcd(Hand of Gul\'dan)||lastgcd(Summon Darkglare)||lastgcd(Summon Doomguard)||lastgcd(Grimoire: Felguard)||lastgcd(Thal\'kiel\'s Consumption)}'},
	--actions+=/doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
	{'!Doom', '{moving||!moving}&!talent(4,1)&toggle(yuDoom)&!target.debuff(Doom)'},
	--actions+=/life_tap,if=mana.pct<=30
	{'!Life Tap', '{moving||!moving}&mana<=30&player.health>=15&{!lastgcd(Summon Felguard)||!lastgcd(Call Dreadstalkers)||!lastgcd(Hand of Gul\'dan)||!lastgcd(Summon Darkglare)||!lastgcd(Summon Doomguard)||!lastgcd(Grimoire: Felguard)}'},
	--actions+=/demonbolt
	{'!Demonbolt', '!moving&talent(7,2)&!soulshards=4'},
	--actions+=/shadow_bolt
	{'!Shadow Bolt', '!moving&!talent(7,2)&!soulshards=4'},
	--actions+=/felstorm
	{'!&Felstorm', 'combat(player).time>2'},
}

local ST = {
	{DW_Clip, 'player.channeling(Demonwrath)&pet.exists'},
	--actions+=/summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
	{'!Summon Felguard', '!moving&!pet.exists&!talent(6,1)'},
	--actions+=/call_dreadstalkers,if=(!talent.summon_darkglare.enabled|talent.power_trip.enabled)&(spell_targets.implosion<3|!talent.implosion.enabled)
	{'Call Dreadstalkers', '!moving||!moving&player.buff(Demonic Calling)'},
	--actions+=/hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
	{'Hand of Gul\'dan', '!moving&soulshards>=4'},
	--actions+=/thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
	{'Thal\'kiel\'s Consumption', '!moving&spell(Call Dreadstalkers).cooldown>3&lastgcd(Hand of Gul\'dan)'},
	--actions+=/demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
	{'Demonic Empowerment', '!moving&!lastgcd(Demonic Empowerment)&{warlock.empower=0||lastgcd(Summon Felguard)||lastgcd(Call Dreadstalkers)||lastgcd(Hand of Gul\'dan)||lastgcd(Summon Darkglare)||lastgcd(Summon Doomguard)||lastgcd(Grimoire: Felguard)||lastgcd(Thal\'kiel\'s Consumption)}'},
	--actions+=/doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
	{'Doom', '{moving||!moving}&!talent(4,1)&toggle(yuDoom)&!target.debuff(Doom)'},
	--actions+=/life_tap,if=mana.pct<=30
	{'Life Tap', '{moving||!moving}&mana<=30&player.health>=15&{!lastgcd(Summon Felguard)||!lastgcd(Call Dreadstalkers)||!lastgcd(Hand of Gul\'dan)||!lastgcd(Summon Darkglare)||!lastgcd(Summon Doomguard)||!lastgcd(Grimoire: Felguard)}'},
	--actions+=/demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
	{'Demonwrath', 'movingfor>=2&combat(player).time>2'},
	--actions+=/demonbolt
	{'Demonbolt', '!moving&talent(7,2)&!soulshards=4'},
	--actions+=/shadow_bolt
	{'Shadow Bolt', '!moving&!talent(7,2)&!soulshards=4'},
	--actions+=/felstorm
	{'&Felstorm', 'combat(player).time>2'},
}

local inCombat = {
	{Keybinds},
	{Survival, '{!moving||moving}'},
	{Player, '!moving'},
	{Cooldowns, 'toggle(cooldowns)'},
	{ST, 'target.infront&target.range<=40'},
}

local outCombat = {
	{'Life Tap', '{moving||!moving}&mana<=60&player.health>=60'},
}

NeP.CR:Add(266, {
	name = '|r[|cff00fff0Yumad|r] |cff8788eeWarlock|r - |cff8788eeDEMONOLOGY|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
