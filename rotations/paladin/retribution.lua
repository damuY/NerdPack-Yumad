local GUI = {
	-- GUI Survival
	{type = 'header', text = 'Survival', align = 'center'},
	{type = 'checkbox', text = 'Enable Lay on Hands', key = 'S_LOHE', default = true},
	{type = 'spinner', text = '', key = 'S_LOH', default = 10},
	{type = 'checkbox', text = 'Enable Flash of Light', key = 'S_FOLE', default = true},
	{type = 'spinner', text = '', key = 'S_FOL', default = 40},
	{type = 'checkbox', text = 'Enable Shield of Vengeance', key = 'S_SOVE', default = true},
	{type = 'spinner', text = '', key = 'S_SOV', default = 75},
	{type = 'checkbox', text = 'Enable Eye for an Eye', key = 'S_EFAEE', default = true},
	{type = 'spinner', text = '', key = 'S_EFAE', default = 90},
	--{type = 'checkbox', text = 'Enable Every Man for Himself (Stun)', key = 'S_EMFHSE', default = true},
	--{type = 'checkbox', text = 'Enable Blessing of Freedom (Root)', key = 'S_BOFRE', default = true},
	--{type = 'checkbox', text = 'Enable Blessing of Freedom (Snare)', key = 'S_BOFSE', default = true},
	{type = 'checkbox', text = 'Enable Gift of the Naaru', key = 'S_GOTNE', default = true},
	{type = 'spinner', text = '', key = 'S_GOTN', default = 40},
	{type = 'checkbox', text = 'Enable Healthstone', key = 'S_HSE', default = true},
	{type = 'spinner', text = '', key = 'S_HS', default = 20},
	{type = 'checkbox', text = 'Enable Ancient Healing Potion', key = 'S_AHPE', default = true},
	{type = 'spinner', text = '', key = 'S_AHP', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Emergency Group Assistance
	{type = 'header', text = 'Emergency Group Assistance', align = 'center'},
	{type = 'checkbox', text = 'Enable Emergency Group Assistance', key = 'E_GAE', default = false},
	{type = 'text', text = 'Flash of Light'},
	{type = 'spinner', text = '', key = 'E_FOL', default = 35},
	{type = 'text', text = 'Lay on Hands'},
	{type = 'spinner', text = '', key = 'E_LOH', default = 10},
	{type = 'text', text = 'Blessing of Protection'},
	{type = 'spinner', text = '', key = 'E_BOP', default = 10},
	{type = 'ruler'},{type = 'spacer'},

	-- GUI Blessings
	{type = 'header', text = 'Blessings', align = 'center'},
	{type = 'text', text = 'Check to enable blessings on yourself'},
	{type = 'checkbox', text = 'Blessing of Kings', key = 'B_BOKP', default = false},
	{type = 'checkbox', text = 'Blessing of Wisdom', key = 'B_BOWP', default = false},
	{type = 'ruler'},{type = 'spacer'},
}

local exeOnLoad = function()
	-- Rotation loaded message.
	print('|cfff58cba ----------------------------------------------------------------------|r')
	print('|cfff58cba --- |rPaladin: |cfff58cbaRETRIBUTION|r')
	print('|cfff58cba --- |rTalents: 1/2 - 2/2 - 3/1 - 4/2 - 5/2 - 6/1 - 7/2|r')
	print('|cfff58cba --- |rNo Multitarget (AoE) enabled settings|r')
	print('|cfff58cba ----------------------------------------------------------------------|r')
	print('|cffff0000 Configuration: |rRight-click the MasterToggle and go to Combat Routines Settings|r')

	NeP.Interface:AddToggle({
		-- Cleanse Toxin
		key = 'yuCT',
		name = 'Cleanse Toxin',
		text = 'Enable/Disable: Automatic removal of Poison and Diseases',
		icon = 'Interface\\ICONS\\spell_holy_renew',
	})
	NeP.Interface:AddToggle({
		-- Emergency Group Assistance
		key = 'yuEGA',
		name = 'Emergency Group Assistance',
		text = 'Enable/Disable: Automatic LoH/BoP/FoL on group members',
		icon = 'Interface\\ICONS\\ability_fiegndead',
	})
end

local Survival = {
	-- Lay on Hands usage if enabled in UI.
	{'&Lay on Hands', 'UI(S_LOHE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_LOH)'},
	-- Shield of Vengeance usage if enabled in UI.
	{'&Shield of Vengeance', 'UI(S_SOVE)&player.health<=UI(S_SOV)'},
	-- Eye for an Eye usage if enabled in UI.
	{'Eye for an Eye', 'talent(5,2)&UI(S_EFAEE)&player.health<=UI(S_EFAE)'},
	-- Every Man for Himself usage if enabled in UI.
	--{'&Every Man for Himself', 'UI(S_EMFHSE)&player.state(stun)'},
	-- Blessing of Freedom usage if enabled in UI.
	--{'!Blessing of Freedom', 'UI(S_BOFRE)&player.state(root)'},
	-- Blessing of Freedom usage if enabled in UI.
	--{'!Blessing of Freedom', 'UI(S_BOFSE)&player.state(snare)'},
	-- Gift of the Naaru usage if enabled in UI.
	{'&Gift of the Naaru', 'UI(S_GOTNE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_GOTN)'},
	-- Healthstone usage if enabled in UI.
	{'#5512', 'UI(S_HSE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_HS)'},
	-- Ancient Healing Potion usage if enabled in UI.
	{'#127834', 'UI(S_AHPE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_AHP)'},
}

local Player = {
	-- Flash of Light usage if enabled in UI.
	{'!Flash of Light', 'UI(S_FOLE)&{!player.debuff(Ignite Soul)}&player.health<=UI(S_FOL)', 'player'},
}

local Emergency = {
	-- Flash of Light usage if enabled in UI.
	{'!Flash of Light', 'UI(E_GAE)&{!lowest.debuff(Ignite Soul)}&lowest.health<=UI(E_FOL)', 'lowest'},
	-- Lay on Hands usage if enabled in UI.
	{'!Lay on Hands', 'UI(E_GAE)&{!lowest.debuff(Ignite Soul)}&lowest.health<=UI(E_LOH)', 'lowest'},
	-- Blessing of Protection usage if enabled in UI.
	{'!Blessing of Protection', 'UI(E_GAE)&{!lowest.debuff(Ignite Soul)}&lowest.health<=UI(E_BOP)', 'lowest'},
}

local Interrupts = {
	{'&Rebuke', 'target.range<=5'},
	{'Hammer of Justice', '!equipped(Justice Gaze)&target.range<=10&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
	{'Hammer of Justice', 'equipped(Justice Gaze)&target.health>=75&target.range<=10&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
	{'Blinding Light', 'talent(3,3)&target.range<=10&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
	{'&Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!lastgcd(Rebuke)'},
}

local Dispel = {
	{'%dispelself'},
}

local Blessings = {
	{'Greater Blessing of Kings', 'UI(B_BOKP)&!player.buff(Greater Blessing of Kings)', 'player'},
	{'Greater Blessing of Wisdom', 'UI(B_BOWP)&!player.buff(Greater Blessing of Wisdom)', 'player'},
}

-- ####################################################################################
-- Primairly sourced from legion-dev SimC.
-- Updates to rotations from sources are considered for implementation.
-- ####################################################################################

-- SimC APL 4/20/2017
-- https://github.com/simulationcraft/simc/blob/legion-dev/profiles/Tier19M/Paladin_Retribution_T19M.simc

local Cooldowns = {
	--actions+=/arcane_torrent,if=holy_power<5&(buff.crusade.up|buff.avenging_wrath.up|time<2)
	{'&Arcane Torrent', 'holypower<5&{player.buff(Crusade)||player.buff(Avenging Wrath)||combat(player).time<2}'},
	--actions+=/holy_wrath
	{'Holy Wrath', 'talent(7,3)'},
	--actions+=/avenging_wrath
	{'&Avenging Wrath', '!talent(7,2)'},
	--actions+=/crusade,if=holy_power>=5&!equipped.137048|((equipped.137048|race.blood_elf)&holy_power>=2)
	{'&Crusade', 'talent(7,2)&{holypower>=5&!equipped(Liadrin\'s Fury Unleashed)||{equipped(Liadrin\'s Fury Unleashed)&holypower>=2}}'},
}

local Combat = {
	{'/startattack', '!isattacking'},
	--actions+=/judgment,if=time<2
	{'Judgment', 'combat(player).time<2'},
	--actions+=/blade_of_justice,if=time<2&(equipped.137048|race.blood_elf)
	{'Blade of Justice', 'combat(player).time<2&equipped(Liadrin\'s Fury Unleashed)'},
	--actions+=/divine_hammer,if=time<2&(equipped.137048|race.blood_elf)
	{'Divine Hammer', 'talent(4,3)&combat(player).time<2&equipped(Liadrin\'s Fury Unleashed)'},
	--actions+=/wake_of_ashes,if=holy_power<=1&time<2
	{'Wake of Ashes', 'holypower<=1&combat(player).time<2'},
	--actions+=/execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remains<gcd*4.5|debuff.judgment.remains>gcd*4.5)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*2)
	{'Execution Sentence','talent(1,2)&player.area(8).enemies<=3&{spell(Judgment).cooldown<gcd*4.5||target.debuff(judgment).duration>gcd*4.5}&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*2}'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&player.buff(Divine Purpose).duration<gcd*2'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&holypower>=5&player.buff(Divine Purpose)'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=3&(buff.crusade.up&(buff.crusade.stack<15|buff.bloodlust.up)|buff.liadrins_fury_unleashed.up)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&holypower>=3&{player.buff(Crusade)&{player.buff(Crusade).count<15||hashero}||player.buff(Liadrin\'s Fury Unleashed)}'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&holypower>=5&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*3}'},
	--actions+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remains<gcd*2
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose).duration<gcd*2'},
	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holypower>=5&player.buff(Divine Purpose)'},
	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(buff.crusade.up&(buff.crusade.stack<15|buff.bloodlust.up)|buff.liadrins_fury_unleashed.up)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holypower>=3&{player.buff(Crusade)&{player.buff(Crusade).count<15||hashero}||player.buff(Liadrin\'s Fury Unleashed)}'},
	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holypower>=5&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*3}&{!talent(1,2)||spell(Execution Sentence).cooldown>gcd}'},
	--actions+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Divine Storm', 'target.debuff(Judgment)&holypower>=3&player.area(8).enemies>=2&{spell(Wake of Ashes).cooldown<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim).duration<gcd}&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*4}'},
	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remains<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remains<gcd)&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holypower>=3&{spell(Wake of Ashes).cooldown<gcd*2&artifact(Wake of Ashes).enabled||player.buff(Whisper of the Nathrezim).duration<gcd}&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*4}'},
	--actions+=/judgment,if=dot.execution_sentence.ticking&dot.execution_sentence.remains<gcd*2&debuff.judgment.remains<gcd*2
	{'Judgment', 'target.debuff(Execution Sentence).duration<gcd*2&target.debuff(Judgment).duration<gcd*2'},
	--actions+=/wake_of_ashes,if=(!raid_event.adds.exists|raid_event.adds.in>15)&(holy_power=0|holy_power=1&(cooldown.blade_of_justice.remains>gcd|cooldown.divine_hammer.remains>gcd)|holy_power=2&(cooldown.zeal.charges_fractional<=0.65|cooldown.crusader_strike.charges_fractional<=0.65))
	{'Wake of Ashes', 'holypower=0||holypower=1&{spell(Blade of Justice).cooldown>gcd||spell(Divine Hammer).cooldown>gcd}||holypower=2&{spell(Zeal).charges<=0.65||spell(Crusader Strike).charges<=0.65}'},
	--actions+=/blade_of_justice,if=(holy_power<=2&set_bonus.tier20_2pc=1|holy_power<=3&set_bonus.tier20_2pc=0)
	{'Blade of Justice', 'holypower<=2&set_bonus(T20)>=2||holypower<=3&set_bonus(T20)=0'},
	--actions+=/divine_hammer,if=(holy_power<=2&set_bonus.tier20_2pc=1|holy_power<=3&set_bonus.tier20_2pc=0)
	{'Divine Hammer', 'holypower<=2&set_bonus(T20)>=2||holypower<=3&set_bonus(T20)=0'},
	--actions+=/hammer_of_justice,if=equipped.137065&target.health.pct>=75&holy_power<=4
	{'Hammer of Justice', 'equipped(Justice Gaze)&target.health>=75&holypower<=4'},
	--actions+=/judgment
	{'Judgment'},
	--actions+=/zeal,if=charges=2&(set_bonus.tier20_2pc=0&holy_power<=2|(holy_power<=4&(cooldown.divine_hammer.remains>gcd*2|cooldown.blade_of_justice.remains>gcd*2)&cooldown.judgment.remains>gcd*2))|(set_bonus.tier20_2pc=1&holy_power<=1|(holy_power<=4&(cooldown.divine_hammer.remains>gcd*2|cooldown.blade_of_justice.remains>gcd*2)&cooldown.judgment.remains>gcd*2))
	{'Zeal', 'talent(2,2)&spell(Zeal).charges=2&{set_bonus(T20)=0&holypower<=2||{holypower<=4&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}||{set_bonus(T20)>=2&holypower<=1||{holypower<=4&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}'},
	--actions+=/crusader_strike,if=charges=2&(set_bonus.tier20_2pc=0&holy_power<=2|(holy_power<=4&(cooldown.divine_hammer.remains>gcd*2|cooldown.blade_of_justice.remains>gcd*2)&cooldown.judgment.remains>gcd*2))|(set_bonus.tier20_2pc=1&holy_power<=1|(holy_power<=4&(cooldown.divine_hammer.remains>gcd*2|cooldown.blade_of_justice.remains>gcd*2)&cooldown.judgment.remains>gcd*2))
	{'Crusader Strike', '!talent(2,2)&spell(Crusader Strike).charges=2&{set_bonus(T20)=0&holypower<=2||{holypower<=4&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}||{set_bonus(T20)>=2&holypower<=1||{holypower<=4&{spell(Divine Hammer).cooldown>gcd*2||spell(Blade of Justice).cooldown>gcd*2}&spell(Judgment).cooldown>gcd*2}}'},
	--actions+=/consecration
	{'Consecration', 'talent(1,3)'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&player.buff(Divine Purpose)'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&player.buff(The Fires of Justice)&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*3}'},
	--actions+=/divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)
	{'Divine Storm', 'target.debuff(Judgment)&player.area(8).enemies>=2&holypower>=4&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*4}'},
	--actions+=/templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(Divine Purpose)'},
	--actions+=/templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*3)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&player.buff(The Fires of Justice)&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*3}'},
	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=4&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*4)&(!talent.execution_sentence.enabled|cooldown.execution_sentence.remains>gcd*2)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holypower>=4&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*4}&{!talent(1,2)||spell(Execution Sentence).cooldown>gcd*2}'},
	--actions+=/zeal,if=holy_power<=4
	{'Zeal', 'talent(2,2)&holypower<=4'},
	--actions+=/crusader_strike,if=holy_power<=4
	{'Crusader Strike', '!talent(2,2)&holypower<=4'},
	--actions+=/divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
	{'Divine Storm', 'target.debuff(Judgment)&holypower>=3&player.area(8).enemies>=2&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*5}'},
	--actions+=/templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remains>gcd*5)
	{'Templar\'s Verdict', 'target.debuff(Judgment)&holypower>=3&{!talent(7,2)||talent(7,2)&!toggle(cooldowns)||spell(Crusade).cooldown>gcd*5}'},
}

local inCombat = {
	{Dispel, '{!moving||moving}&toggle(yuCT)&spell(Cleanse Toxins).cooldown=0'},
	{Survival, '{!moving||moving}'},
	{Blessings, '{!moving||moving}'},
	{Player, '!moving&{!ingroup||ingroup}'},
	{Emergency, '!moving&ingroup&toggle(yuEGA)'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront'},
	{Cooldowns, '{!moving||moving}&toggle(cooldowns)'},
	{Combat, '{!moving||moving}&target.infront&target.range<=8'},
}

local outCombat = {
	{Dispel, '{!moving||moving}&toggle(yuCT)&spell(Cleanse Toxins).cooldown=0'},
	{Interrupts, '{!moving||moving}&toggle(interrupts)&target.interruptAt(70)&target.infront'},
	{Blessings, '{!moving||moving}'},
	{Emergency, '!moving&ingroup&toggle(yuEGA)'},
	{'Flash of Light', '!moving&player.health<=70', 'player'},
}

NeP.CR:Add(70, {
	name = '|r[|cff00fff0Yumad|r] |cfff58cbaPaladin|r - |cfff58cbaRETRIBUTION|r',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
