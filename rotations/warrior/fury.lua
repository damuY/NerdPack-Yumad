local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Enraged Regeneration', key = 'S_ERE', default = true},
	{type = 'spinner', text = '', key = 'S_ER', default = 40},
	{type = 'checkbox', text = 'Enable Commanding Shout', key = 'S_CSE', default = true},
	{type = 'spinner', text = '', key = 'S_CS', default = 20},
	{type = 'checkbox', text = 'Enable Intimidating Shout', key = 'S_ISE', default = true},
	{type = 'spinner', text = '', key = 'S_IS', default = 30},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Keybinds
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'checkbox', text = 'L-Shift: Heroic Leap @ Cursor', key = 'K_HL', default = true},
	{type = 'checkbox', text = 'L-Alt: Shockwave', key = 'K_SW', default = true},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cffc79c6e ----------------------------------------------------------------------|r')
	print('|cffc79c6e --- |rWarrior: |cffc79c6eFURY|r')
	print('|cffc79c6e --- |rTalents: 1/2 - 2/3 - 3/3 - 4/3 - 5/2 - 6/3 - 7/2|r')
	print('|cffc79c6e ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')
end

local Survival = {
	-- Enraged Regeneration usage if enabled in UI.
	{'&Enraged Regeneration', 'UI(S_ERE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_ER)'},
	-- Commanding Shout usage if enabled in UI.
	{'&Commanding Shout', 'UI(S_CSE)&player.health<=UI(S_CS)'},
	-- Intimidating Shout usage if enabled in UI.
	{'Intimidating Shout', 'UI(S_ISE)&player.area(8).enemies>2&player.health<=UI(S_IS)'},
	-- Gift of the Naaru usage if enabled in UI.
	{'&Gift of the Naaru', 'UI(S_GOTNE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_GOTN)'},
	-- Healthstone usage if enabled in UI.
	{'#5512', 'UI(S_HSE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HS)'},
	-- Ancient Healing Potion usage if enabled in UI.
	{'#127834', 'UI(S_AHPE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_AHP)'},
}

local Keybinds = {
	-- Heroic Leap at cursor on Left-Shift if enabled in UI.
	{'!Heroic Leap', 'UI(K_HL)&keybind(lshift)', 'cursor.ground'},
	-- Shockwave on Left-Alt if enabled in UI.
	{'!Shockwave', 'talent(2,1)&UI(K_SW)&keybind(lalt)'},
}

local Interrupts = {
	{'&Pummel', 'target.range<=5'},
	{'&Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!lastgcd(Pummel)'},
}

-- ####################################################################################
-- Primairly sourced from legion-dev SimC.
-- Updates to rotations from sources are considered for implementation.
-- ####################################################################################

-- SimC APL 4/20/2017
-- https://github.com/simulationcraft/simc/blob/legion-dev/profiles/Tier19M/Warrior_Fury_T19M.simc

local Cooldowns = {
	--actions+=/battle_cry,if=gcd.remains=0&(!talent.reckless_abandon.enabled&(cooldown.bloodthirst.remains=0|buff.enrage.remains>cooldown.bloodthirst.remains))|(talent.reckless_abandon.enabled&(talent.dragon_roar.enabled&buff.dragon_roar.up|!talent.dragon_roar.enabled))
	{'&Battle Cry', 'gcd.remains=0&{!talent(7,2)&{spell(Bloodthirst).cooldown=0||player.buff(Enrage).duration>spell(Bloodthirst).cooldown}}||talent(7,2)'},
	--actions+=/battle_cry,if=gcd.remains=0&!talent.dragon_roar.enabled&(!equipped.convergence_of_fates|!talent.bloodbath.enabled|!cooldown.bloodbath.remains|cooldown.bloodbath.remains>=10)
	{'&Battle Cry', 'gcd.remains=0&!talent(7,3)&{!talent(6,1)||spell(Bloodbath).cooldown=0||spell(Bloodbath).cooldown>=10}'},
	--actions+=/battle_cry,if=gcd.remains=0&buff.dragon_roar.up&(cooldown.bloodthirst.remains=0|buff.enrage.remains>cooldown.bloodthirst.remains)
	{'&Battle Cry', 'gcd.remains=0&player.buff(Dragon Roar)&{spell(Bloodthirst).cooldown=0||player.buff(Enrage).duration>spell(Bloodthirst).cooldown}'},
	--actions+=/avatar,if=buff.battle_cry.up|(target.time_to_die<(cooldown.battle_cry.remains+10))
	{'&Avatar', 'talent(3,3)&player.buff(Battle Cry)'},
	--actions+=/bloodbath,if=buff.dragon_roar.up|!talent.dragon_roar.enabled&buff.battle_cry.up
	{'&Bloodbath', 'talent(6,1)&{player.buff(Dragon Roar)||!talent(7,3)&player.buff(Battle Cry)}'},
	--actions+=/blood_fury,if=buff.battle_cry.up
	{'&Blood Fury', 'player.buff(Battle Cry)'},
	--actions+=/berserking,if=buff.battle_cry.up
	{'&Berserking', 'player.buff(Battle Cry)'},
	--actions+=/arcane_torrent,if=rage<rage.max-40
	{'&Arcane Torrent', 'player.rage<=60'},
}

local BattleCry = {
	{'/startattack', '!isattacking'},
	--actions.cooldowns=rampage,if=talent.massacre.enabled&buff.massacre.react&buff.enrage.remains<1
	{'Rampage', 'talent(5,1)&player.buff(Massacre)&player.buff(Enrage).duration<1'},
	--actions.cooldowns+=/bloodthirst,if=target.health.pct<20&buff.enrage.remains<1
	{'Bloodthirst', 'target.health<=20&player.buff(Enrage).duration<1'},
	--actions.cooldowns+=/odyns_fury,if=spell_targets.odyns_fury>1
	{'Odyn\'s Fury', 'player.area(14).enemies>1&player.buff(Enrage)'},
	--actions.cooldowns+=/whirlwind,if=spell_targets.whirlwind>1&buff.meat_cleaver.down
	{'Whirlwind', 'player.area(8).enemies>1&!player.buff(Meat Cleaver)'},
	--actions.cooldowns+=/execute
	{'Execute'},
	--actions.cooldowns+=/raging_blow,if=talent.inner_rage.enabled&buff.enrage.up
	{'Raging Blow', 'talent(6,3)&player.buff(Enrage)'},
	--actions.cooldowns+=/odyns_fury
	{'Odyn\'s Fury', 'player.buff(Enrage)'},
	--actions.cooldowns+=/rampage,if=!talent.frothing_berserker.enabled|(talent.frothing_berserker.enabled&rage>=100)
	{'Rampage', '!talent(5,2)||{talent(5,2)&player.rage>=100}'},
	--actions.cooldowns+=/berserker_rage,if=talent.outburst.enabled&buff.enrage.down&buff.battle_cry.up
	{'&Berserker Rage', 'talent(3,2)&!player.buff(Enrage)&player.buff(Battle Cry)'},
	--actions.cooldowns+=/bloodthirst,if=buff.enrage.remains<1&!talent.outburst.enabled
	{'Bloodthirst', 'player.buff(Enrage).duration<1&!talent(3,2)'},
	--actions.cooldowns+=/raging_blow,if=talent.inner_rage.enabled
	{'Raging Blow', 'talent(6,3)'},
	--actions.cooldowns+=/odyns_fury
	{'Odyn\'s Fury', 'player.buff(Enrage)'},
	--actions.cooldowns+=/whirlwind,if=buff.wrecking_ball.react&buff.enrage.up
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	--actions.cooldowns+=/raging_blow,if=!talent.inner_rage.enabled
	{'Raging Blow', '!talent(6,3)'},
	--actions.cooldowns+=/bloodthirst
	{'Bloodthirst'},
	--actions.cooldowns+=/furious_slash
	{'Furious Slash'},
}

local AoE = {
	{'/startattack', '!isattacking'},
	--actions.aoe=bloodthirst,if=buff.enrage.down|rage<50
	{'Bloodthirst', '!player.buff(Enrage)||player.rage<=50'},
	--actions.aoe+=/bladestorm,if=raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>1
	{'Bladestorm', 'talent(7,1)&player.area(8).enemies>1'},
	--actions.aoe+=/whirlwind,if=buff.meat_cleaver.down
	{'Whirlwind', '!player.buff(Meat Cleaver)'},
	--actions.aoe+=/execute,if=spell_targets.whirlwind<6&talent.massacre.enabled&!buff.massacre.react
	{'Execute', 'player.area(8).enemies<6&talent(5,1)&!player.buff(Massacre)'},
	--actions.aoe+=/rampage,if=buff.meat_cleaver.up&(buff.enrage.down&!talent.frothing_berserker.enabled|buff.massacre.react|rage>=100)
	{'Rampage', 'player.buff(Meat Cleaver)&{!player.buff(Enrage)&!talent(5,2)||player.buff(Massacre)||player.rage>=100}'},
	--actions.aoe+=/bloodthirst
	{'Bloodthirst'},
	--actions.aoe+=/whirlwind
	{'Whirlwind'},
}

local Execute = {
	{'/startattack', '!isattacking'},
	--actions.execute=bloodthirst,if=buff.fujiedas_fury.up&buff.fujiedas_fury.remains<2
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury)&player.buff(Fujieda\'s Fury).count<2'},
	--actions.execute+=/execute,if=artifact.juggernaut.enabled&(!buff.juggernaut.up|buff.juggernaut.remains<2)|buff.stone_heart.react
	{'Execute', 'artifact(Juggernaut).enabled&{!player.buff(Juggernaut)||player.buff(Juggernaut).duration<2}||player.buff(Stone Heart)'},
	--actions.execute+=/furious_slash,if=talent.frenzy.enabled&buff.frenzy.remains<=2
	{'Furious Slash', 'talent(6,2)&player.buff(Frenzy).count<=2}'},
	--actions.execute+=/rampage,if=buff.massacre.react&buff.enrage.remains<1
	{'Rampage', 'talent(5,1)&player.buff(Massacre)&player.buff(Enrage).duration<1'},
	--actions.execute+=/execute
	{'Execute'},
	--actions.execute+=/bloodthirst
	{'Bloodthirst'},
	--actions.execute+=/whirlwind,if=spell_targets.whirlwind=3&buff.wrecking_ball.react&buff.enrage.up
	{'Whirlwind', 'player.area(8).enemies=3&talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	--actions.execute+=/furious_slash,if=set_bonus.tier19_2pc
	{'Furious Slash', 'set_bonus(T19)>1'},
	--actions.execute+=/raging_blow
	{'Raging Blow'},
	--actions.execute+=/furious_slash
	{'Furious Slash'},
}

local ST ={
	{'/startattack', '!isattacking'},
	--actions.single_target=bloodthirst,if=buff.fujiedas_fury.up&buff.fujiedas_fury.remains<2
	{'Bloodthirst', 'player.buff(Fujieda\'s Fury)&player.buff(Fujieda\'s Fury).count<2'},
	--actions.single_target+=/furious_slash,if=talent.frenzy.enabled&(buff.frenzy.down|buff.frenzy.remains<=2)
	{'Furious Slash', 'talent(6,2)&{!player.buff(Frenzy)||player.buff(Frenzy).count<=2}'},
	--actions.single_target+=/whirlwind,if=spell_targets.whirlwind=3&buff.wrecking_ball.react
	{'Whirlwind', 'player.area(8).enemies=3&talent(3,1)&player.buff(Wrecking Ball)'},
	--actions.single_target+=/raging_blow,if=talent.inner_rage.enabled&buff.enrage.up
	{'Raging Blow', 'talent(6,3)&player.buff(Enrage)'},
	--actions.single_target+=/whirlwind,if=spell_targets.whirlwind>1&buff.meat_cleaver.down
	{'Whirlwind', 'player.area(8).enemies>1&!player.buff(Meat Cleaver)'},
	--actions.single_target+=/rampage,if=(buff.enrage.down&!talent.frothing_berserker.enabled)|buff.massacre.react|rage>=100
	{'Rampage', '{!player.buff(Enrage)&!talent(5,2)}||talent(5,1)&player.buff(Massacre)||player.rage>=100'},
	--actions.single_target+=/raging_blow,if=talent.inner_rage.enabled
	{'Raging Blow', 'talent(6,3)'},
	--actions.single_target+=/execute,if=buff.stone_heart.react
	{'Execute', 'player.buff(Stone Heart)'},
	--actions.single_target+=/whirlwind,if=buff.wrecking_ball.react&buff.enrage.up
	{'Whirlwind', 'talent(3,1)&player.buff(Wrecking Ball)&player.buff(Enrage)'},
	--actions.single_target+=/bladestorm,if=buff.enrage.remains>2&(raid_event.adds.in>90|!raid_event.adds.exists|spell_targets.bladestorm_mh>1)
	{'Bladestorm', 'talent(7,1)&player.buff(Enrage).duration>2&player.area(8).enemies>1'},
	--actions.single_target+=/bloodthirst
	{'Bloodthirst'},
	--actions.single_target+=/raging_blow,if=!set_bonus.tier19_2pc&!talent.inner_rage.enabled
	{'Raging Blow', 'set_bonus(T19)<2&!talent(6,3)'},
	--actions.single_target+=/whirlwind,if=spell_targets.whirlwind>2
	{'Whirlwind', 'player.area(8).enemies>2'},
	--actions.single_target+=/furious_slash
	{'Furious Slash'},
}

local inCombat = {
	{Keybinds, '{!moving||moving}'},
	{Survival, '{!moving||moving}'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront'},
	{Cooldowns, '{!moving||moving}&toggle(cooldowns)&target.range<=8'},
	{BattleCry, '{!moving||moving}&target.range<=8&target.infront&player.buff(Battle Cry)'},
	{AoE, '{!moving||moving}&toggle(aoe)&{player.area(8).enemies>3'},
	{Execute, '{!moving||moving}&target.range<=8&target.infront&target.health<=20&!player.buff(Battle Cry)'},
	{ST, '{!moving||moving}&target.range<=8&target.infront&target.health>20&!player.buff(Battle Cry)'},
}

local outCombat = {
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront'},
}

NeP.CR:Add(72, {
	name = '|r[|cff00fff0Yumad|r] |cffc79c6eWarrior|r - |cffc79c6eFURY|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
