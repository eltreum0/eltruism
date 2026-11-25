local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local tinsert = _G.table.insert
local tconcat = _G.table.concat
local sort = _G.sort
local pairs = _G.pairs
local format = _G.format
local stringupper = _G.string.upper
local mathfloor = _G.math.floor
local next = _G.next

-- SortList
local function SortList(a, b)
	local aUpper = a:gsub("^%l", stringupper)
	local bUpper = b:gsub("^%l", stringupper)
	if E:StripString(aUpper) < E:StripString(bUpper) then
		return true
	else
		return false
	end
end

-- Eltruism ingame options
function ElvUI_EltreumUI:Configtable()
	--Author list
	local AUTHORS = {
		E:TextGradient("Eltreum", 0.50, 0.70, 1, 0.67, 0.95, 1),
	}

	-- Credits and Thank yous list
	local THANKYOU = {
		'|cff0070DEAzilroka|r',
		'|cffC41F3BKringel|r',
		'|cFF99CCFFAftermathh|r',
		'|cffF58CBARepooc|r Especially for the huge helps',
		'Blazeflack',
		'Botanica',
		'|cffFFC44DHydra|r',
		'|T134297:15:15:0:0:64:64:5:59:5:59|t |cffff7d0aMerathilis|r',
		'|cff9482c9Darth Predator|r',
		'Caedis',
		'Elv',
		E:TextGradient('Simpy, his name might be shorter sometimes even though he fixes a lot of things', 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43),
		--E:TextGradient('Simpy he fixes a lot of things but he cant see power colors right', 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43),
		'Shrom',
		'Pat',
		'|cff00c0faBenik|r',
		'|T136012:15:15:0:0:64:64:5:59:5:59|t |cff006fdcRubgrsch|r',
		'|TInterface/AddOns/ElvUI/Game/Shared/Media/ChatLogos/Clover:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0ALuckyone|r Especially for allowing the usage of his installer/plugin as a model',
		'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/releaf:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0AReleaf|r for the alternate class icons',
		'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/tukuidiscord:15:15:0:0:64:64:5:59:5:59|t Tukui Community for all the help and motivation',
		'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/addonsdiscord:15:15:0:0:64:64:5:59:5:59|t WoW AddOns; for answering a lot of questions',
		'AcidWeb |TInterface/AddOns/ElvUI/Game/Shared/Media/ChatLogos/Gem:15:15:-1:2:64:64:6:60:8:60|t',
		'|cff8E44ADB|r|cff2ECC71lin|r|cff3498DBkii|r', --blinkii's colored name
		'|cff960000Atwood|r - for some of the role icons',
		'|cffB50909Dlarge|r - for the German localization',
		'|cff33937FFang2hou|r - for the compatibility function',
		E:TextGradient("Meowcactus", 1, 0.49, 0.04, 1, 0.96, 0.41),
		'plusmouse',
		'Burzolog - inspiration for Rogue Door Opener',
		'mitchnull - inspiration for Cursor Cooldowns (CooldownToGo)',
		'Aezay - inspiration for Quest Items (QBar)',
		'michaelsp - inspiration for Cursor (CastCursor)',
		'xavjer - inspiration for Loot Text (Scrolling Loot Text / SLoTe)',
	}

	local DONATORS = {
		'Akiao',
		'Artan',
		'BralumConquest',
		'Brovenn',
		'Daxxarri',
		'Dlarge',
		'Dreamador',
		'Dreandor',
		'Gently Caress the Constabulary',
		'Greevir',
		'Jazz',
		'Jiberish',
		'Madlampy',
		'Markpoops',
		'Michael_',
		'Morthart',
		'Mr.Ditto',
		'Nekator',
		'Nyhilatiant',
		'Oakshlam',
		'Smuve',
		'Trenchy',
		'Vxt',
		'BioVenom',
		'bansheeirl',
		'Ante',
		'Spectated',
		'Volo',
		'seba4287',
		'orangepaw3',
		'Jaraxal',
		'BlazeFury',
		'Marynia',
		'Garrgamell',
		'dartworth',
		'Rocket Surgery',
		'Embee',
		'mercenariosgx',
		'Deathclaw',
		'AegisX',
		'windseeker',
		'crusty',
		'clozure',
		'Aphadon',
		'shifty',
		'Baleos',
		'hunty',
		'Tel',
		'Capra Demon/domingoose',
		'Numnuts',
	}

	local TRANSLATORS = {
		'|cffCC3333Khornan|r - German Translation',
		'|cffCC3333Dlarge|r - German Translation',
		'|cffCC3333Neo|r - Simplified Chinese Translation',
		'DeepL artificial intelligence for French and Spanish translations',
		'|cffCC3333魔能機曱 (Johnson)|r - Traditional Chinese translation',
		'|cffCC3333Meowcactus|r - Simplified Chinese Translation',
		'|cffCC3333ZamestoTV|r - Russian Translation',
	}

	sort(AUTHORS, SortList)
	sort(THANKYOU, SortList)
	sort(DONATORS, SortList)
	sort(TRANSLATORS, SortList)

	-- Author table
	local AUTHORS_STRING = tconcat(AUTHORS, '|n')

	-- Thank you table
	local THANKYOU_STRING = tconcat(THANKYOU, '|n')

	-- Donators table
	local donator1,donator2 = {},{}
	local donatordivisor = mathfloor(#DONATORS/2)
	for i, name in pairs(DONATORS) do
		local namecolor = "|cffB50909"..name.."|r"
		if i <= donatordivisor then
			tinsert(donator1, namecolor)
		elseif i >= donatordivisor then
			tinsert(donator2, namecolor)
		end
	end
	local DONATORS_STRING1 = tconcat(donator1, '|n')
	local DONATORS_STRING2 = tconcat(donator2, '|n')

	-- Translators table
	local TRANSLATORS_STRING = tconcat(TRANSLATORS, '|n')

	-- Add Eltruism version on top of the ElvUI config
	E.Options.name = E.Options.name .. " + " .. ElvUI_EltreumUI.Name .. format(" |cffffffff%s|r", ElvUI_EltreumUI.Version)

	ElvUI_EltreumUI.Options = E.Libs.ACH:Group("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0|t" .. ElvUI_EltreumUI.Name, nil, 6)
	ElvUI_EltreumUI.Options.args.logo = E.Libs.ACH:Description(nil, 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq', nil, 320, 80)

	--line breaks so these non options are not with the others
	ElvUI_EltreumUI.Options.args.linebreak1 = E.Libs.ACH:Group(" ", nil, 2)
	ElvUI_EltreumUI.Options.args.linebreak1.disabled = true

	ElvUI_EltreumUI.Options.args.linebreak2 = E.Libs.ACH:Group(" ", nil, 4)
	ElvUI_EltreumUI.Options.args.linebreak2.disabled = true

	ElvUI_EltreumUI.Options.args.linebreak3 = E.Libs.ACH:Group(" ", nil, 6)
	ElvUI_EltreumUI.Options.args.linebreak3.disabled = true

	ElvUI_EltreumUI.Options.args.linebreak4 = E.Libs.ACH:Group(" ", nil, 8)
	ElvUI_EltreumUI.Options.args.linebreak4.disabled = true

	ElvUI_EltreumUI.Options.args.linebreak5 = E.Libs.ACH:Group(" ", nil, 10)
	ElvUI_EltreumUI.Options.args.linebreak5.disabled = true

	--help
	ElvUI_EltreumUI.Options.args.help = E.Libs.ACH:Group(E:TextGradient(_G.HELP_LABEL or L["Help"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Frequently Asked Questions"], 0.5, 'tab')
	ElvUI_EltreumUI.Options.args.help.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\faq'

	ElvUI_EltreumUI.Options.args.help.args.frames = E.Libs.ACH:Group(L["Frames & ActionBars"], nil, 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q1 = E.Libs.ACH:Group(E:TextGradient(L["My action bars and unitframes keep disappearing!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q1.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q1.args.answer = E.Libs.ACH:Description(L["ElvUI > ActionBars > Player Bars > on each Bar disable Inherit Global Fade\nElvUI > Unitframes > Type of Unit > Unit > Fader, disable the fader"].."\n\n"..L["You can also toggle the Fader in Eltruism > Media > Fader or with the /eltruism fader command, then reload"], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q1.args.fader = E.Libs.ACH:Execute(L["Fader"], L["Eltruism uses Fading of UnitFrames and ActionBars by default"], 2, function() ElvUI_EltreumUI:ToggleFader() E:StaticPopup_Show('CONFIG_RL') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.frames.args.q2 = E.Libs.ACH:Group(E:TextGradient(L["How do I make bar 1 my action paging bar instead of bar 4?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 2)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q2.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q2.args.answer = E.Libs.ACH:Description(L["You can swap them out in Eltruism > Media, or by using the command /eltruism paging, make sure to reload"].."\n"..L["You can also use /eltruism paging <1-10> to set action paging to a specific bar"], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q2.args.paging = E.Libs.ACH:Execute(L["Swap Action Paging and visibility for Bar1 and Bar4"], nil, 2, function() ElvUI_EltreumUI:ActionPagingSwap() E:StaticPopup_Show('CONFIG_RL') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.frames.args.q3 = E.Libs.ACH:Group(E:TextGradient(L["My Unitframes and/or ActionBars keep reverting positions!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q3.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q3.args.answer = E.Libs.ACH:Description(L["If your actionbars or other frames are moving or resetting after a reload,\ncheck ElvUI > Eltruism > Borders for the Auto Adjust option.\n\nThis option is enabled when you enable Borders, it will not enable otherwise.\n\nAuto Adjust moves frames to a set position due to how borders need\ndifferent settings per layout and need to be changed so that borders don't overlap.\nDisable this option to stop the automatic changes.\n\nYou can also use the /eltruism autoadjust command to toggle it off"], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q3.args.autoadjust = E.Libs.ACH:Execute(L["Enable Auto-adjusting the actionbar spacing and position"], L["Adjusts actionbar spacing and position based on borders being enabled or not"], 2, function() E.db.ElvUI_EltreumUI.borders.borderautoadjust = not E.db.ElvUI_EltreumUI.borders.borderautoadjust ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.frames.args.q4 = E.Libs.ACH:Group(E:TextGradient(L["How do I remove the lines/skin on all the frames?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q4.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q4.args.answer = E.Libs.ACH:Description(L["If you want to disable the ElvUI skin that adds textures to ElvUI you can go into\n\nEltruism > Skins > Addons > ElvUI\n\nWhere you can disable it or change its color, transparency and texture.\nYou can also type /eltruism elvuiskin to disable it."], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q4.args.elvuiskin = E.Libs.ACH:Execute(L["Toggle ElvUI Skin"], nil, 2, function() ElvUI_EltreumUI:RunCommands('elvuiskin') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.frames.args.q5 = E.Libs.ACH:Group(E:TextGradient(L["How do I disable the WeakAuras-like ActionBar layout?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 5)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q5.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q5.args.answer = E.Libs.ACH:Description(L["You can toggle it in Eltruism > Media > Move ActionBars and Power to be similar to WeakAuras, or by typing /eltruism weakauras."], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q5.args.weakauras = E.Libs.ACH:Execute(L["Move ActionBars and Power to be similar to WeakAuras"], L["Overwrites some profile settings to move ActionBars, Unitframes and Powers to look more similar to a WeakAura. |cffFF0000WARNING:|r This will overwrite some of your profile settings with no way to restore"], 2, function() ElvUI_EltreumUI:RunCommands('weakauras') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.frames.args.q6 = E.Libs.ACH:Group(E:TextGradient(L["How do I disable the class color texture at the bottom of the screen?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 6)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q6.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q6.args.answer = E.Libs.ACH:Description(L["This is the texture that comes with the Eltruism Datatext, to disable go to:\n\nElvUI > Eltruism > Misc > DataTexts > Uncheck Class Color Texture with Eltruism Datatext"], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q6.args.datatexttexture = E.Libs.ACH:Execute(L["Class Color Texture with Eltruism Datatext"], nil, 2, function() E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar = not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar ElvUI_EltreumUI:BottomDatabarTexture() end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.frames.args.q7 = E.Libs.ACH:Group(E:TextGradient(L["My Details! or Damage Meter window disappears after combat!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 7)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q7.inline = true
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q7.args.answer = E.Libs.ACH:Description(L["If you have AddOnSkins then go to ElvUI > AddOnSkins > Embed Settings > Turn off Out of Combat (Hide)\nIf details is showing up on top of the trade chat, try going to AddOnSkins > Embed Settings and making sure that its hiding the Trade/Loot chat, you can also right click the > arrow in order to toggle the details embed.\nIf you do not have AddOnSkins then go to Eltruism > Skins > Addons > Details > Embed > Hide out of Combat, you can also change the amount of time it takes for it to hide.\nIn either AddOnSkins or Eltruism embeds you can also Right Click the Chat Toggle (the Arrow [ > ] on the bottom right) to Toggle the Visibility\nA shortcut to disabling the combat hide is /eltruism detailshide"].."\n"..L["For Blizzard's Damage Meter in Retail and Forever, check Eltruism > Skins > Damage Meter > Hide Out of Combat (or right click the Chat Toggle [ > ])."], 1)
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q7.args.detailshide = E.Libs.ACH:Execute(L["Toggle Details Out of Combat Hide"], nil, 2, function() ElvUI_EltreumUI:RunCommands('detailshide') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.frames.args.q7.args.damagemeterhide = E.Libs.ACH:Execute(L["Toggle Damage Meter Out of Combat Hide"], nil, 3, function() E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhideooc = not E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhideooc E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double", nil, nil, nil, not E.Modern)

	--ElvUI_EltreumUI.Options.args.help.args.frames.args.q8 = E.Libs.ACH:Group(E:TextGradient(L["My nameplates flash once an enemy is below 20% Health!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 8)
	--ElvUI_EltreumUI.Options.args.help.args.frames.args.q8.inline = true
	--ElvUI_EltreumUI.Options.args.help.args.frames.args.q8.args.answer = E.Libs.ACH:Description(L["That is due to the EltreumExecute filter, you can disable it in:\nElvUI > Nameplates > Style Filter > (from the dropdown) EltreumExecute > Triggers > Uncheck Enable"], 1)

	ElvUI_EltreumUI.Options.args.help.args.chat = E.Libs.ACH:Group(L["Chat, Audio & Combat Text"], nil, 2)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q1 = E.Libs.ACH:Group(E:TextGradient(L["How do I disable the chat hide?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q1.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q1.args.answer = E.Libs.ACH:Description(L["If you are coming from a version before 2.3.0 then check ElvUI > Shadow and Light > Chat > Set Hide to None\nOtherwise, check Eltruism > Chat"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q1.args.leftmouseover = E.Libs.ACH:Execute(L["Left Chat Mouse Over"], nil, 2, function() E.db.ElvUI_EltreumUI.chat.leftmouseover = not E.db.ElvUI_EltreumUI.chat.leftmouseover E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q1.args.leftfade = E.Libs.ACH:Execute(L["Left Inactivity Fader"], nil, 3, function() E.db.ElvUI_EltreumUI.chat.leftfader = not E.db.ElvUI_EltreumUI.chat.leftfader E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q2 = E.Libs.ACH:Group(E:TextGradient(L["My chat hides when my mouse leaves it"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 2)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q2.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q2.args.answer = E.Libs.ACH:Description(L["Disable Mouse over in Eltruism > Chat"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q2.args.leftmouseover = E.Libs.ACH:Execute(L["Left Chat Mouse Over"], nil, 2, function() E.db.ElvUI_EltreumUI.chat.leftmouseover = not E.db.ElvUI_EltreumUI.chat.leftmouseover E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q2.args.rightmouseover = E.Libs.ACH:Execute(L["Right Chat Mouse Over"], nil, 3, function() E.db.ElvUI_EltreumUI.chat.rightmouseover = not E.db.ElvUI_EltreumUI.chat.rightmouseover E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q3 = E.Libs.ACH:Group(E:TextGradient(L["My chat hides after a few seconds"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q3.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q3.args.answer = E.Libs.ACH:Description(L["Disable Inactivity/Fader in Eltruism > Chat"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q3.args.leftfade = E.Libs.ACH:Execute(L["Left Inactivity Fader"], nil, 2, function() E.db.ElvUI_EltreumUI.chat.leftfader = not E.db.ElvUI_EltreumUI.chat.leftfader E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q3.args.rightfade = E.Libs.ACH:Execute(L["Right Inactivity Fader"], nil, 3, function() E.db.ElvUI_EltreumUI.chat.rightfader = not E.db.ElvUI_EltreumUI.chat.rightfader E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q4 = E.Libs.ACH:Group(E:TextGradient(L["After the Chat fades I still see some icons"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q4.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q4.args.answer = E.Libs.ACH:Description(L["This is a Blizzard bug that was found a long time ago"], 1)

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q5 = E.Libs.ACH:Group(E:TextGradient(L["Music keeps playing when AFK"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 5)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q5.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q5.args.answer = E.Libs.ACH:Description(L["Disable the AFK music in Eltruism > AFK in order to stop the music from playing"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q5.args.afkmusic = E.Libs.ACH:Execute(L["Toggle AFK Music"], nil, 2, function() E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable = not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q6 = E.Libs.ACH:Group(E:TextGradient(L["How can I get Blizzard's floating Mana/Energy/Rage/Other combat text back?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 6)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q6.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q6.args.answer = E.Libs.ACH:Description(L["Go to ElvUI > Eltruism > CVars > Combat Text and uncheck Disable Combat Text and Check Enable Resource Gains, then reload"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q6.args.restorecvars = E.Libs.ACH:Execute(L["Restore All Blizzard Combat Text"], nil, 2, function() ElvUI_EltreumUI:RestoreBlizzCombatText() E:StaticPopup_Show('CONFIG_RL') end, nil, true, "full")

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q7 = E.Libs.ACH:Group(E:TextGradient(L["Where is my floating combat text?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 7)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q7.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q7.args.answer = E.Libs.ACH:Description(L["It's possible you installed NameplateSCT/FCT and removed it so the floating combat text was not enabled back\nYou can go into Eltruism > CVars > Combat Text > Restore All Blizzard Combat Text to restore them"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q7.args.restorecvars = E.Libs.ACH:Execute(L["Restore All Blizzard Combat Text"], nil, 2, function() ElvUI_EltreumUI:RestoreBlizzCombatText() E:StaticPopup_Show('CONFIG_RL') end, nil, true, "full")

	ElvUI_EltreumUI.Options.args.help.args.chat.args.q8 = E.Libs.ACH:Group(E:TextGradient(L["My Loot Rolls are missing!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 8)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q8.inline = true
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q8.args.answer = E.Libs.ACH:Description(L["You have enabled Hide Alert Frame, disable that setting to restore the Alert Frame/Loot Rolls"], 1)
	ElvUI_EltreumUI.Options.args.help.args.chat.args.q8.args.hidealert = E.Libs.ACH:Execute(L["Hide Alert Frame"], L["Hide the Alert Frame that appears when looting a rare item or earning an achievement"], 2, function() E.db.ElvUI_EltreumUI.skins.blizzframes.hidealert = not E.db.ElvUI_EltreumUI.skins.blizzframes.hidealert E:StaticPopup_Show('CONFIG_RL') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.setup = E.Libs.ACH:Group(L["Setup, Modes & Performance"], nil, 3)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q1 = E.Libs.ACH:Group(E:TextGradient(L["How do I set up a new character or alt?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 1)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q1.inline = true
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q1.args.answer = E.Libs.ACH:Description(L["On a new character, it is recommended to either run the Eltruism installer (/eltruism setup or Eltruism > Installer), or select/import an existing profile first and then type /eltruism newchar.\nThe /eltruism newchar command runs Chat Setup, applies Eltruism CVars, and imports the Edit Mode layout on the current character."], 1)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q1.args.installer = E.Libs.ACH:Execute(L["Launch Eltruism Installer"], L["Launches the Eltruism install prompt"], 2, function() E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData) E:ToggleOptions() end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q1.args.newchar = E.Libs.ACH:Execute(L["Run New Character Setup"], nil, 3, function() ElvUI_EltreumUI:RunCommands('newchar') end, nil, true, "double")

	ElvUI_EltreumUI.Options.args.help.args.setup.args.q2 = E.Libs.ACH:Group(E:TextGradient(L["How do I update or reset Eltruism settings after an addon update?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 2)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q2.inline = true
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q2.args.answer = E.Libs.ACH:Description(L["You can reset or update Eltruism settings to Eltreum's defaults in Eltruism > Installer or by typing /eltruism update.\nIf you want Eltruism and ElvUI settings to update automatically when a new Eltruism version is installed, type /eltruism autoupdate to toggle Auto Update."], 1)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q2.args.update = E.Libs.ACH:Execute(L["Reset/Update Eltruism Settings"], L["Resets/Updates Eltruism Settings to Eltreum's Defaults"], 2, function() ElvUI_EltreumUI:RunCommands('update') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q2.args.autoupdate = E.Libs.ACH:Execute(L["Toggle Auto Update"], nil, 3, function() ElvUI_EltreumUI:RunCommands('autoupdate') end, nil, false, "double")

	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3 = E.Libs.ACH:Group(E:TextGradient(L["How do I switch between Dark, Light, Gradient, Transparent, or Chat modes?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.inline = true
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.args.answer = E.Libs.ACH:Description(L["You can customize these in Eltruism > UnitFrames, Eltruism > Gradient, Eltruism > Media, and Eltruism > Chat, or quickly toggle them with commands:\n/eltruism color - Toggles UnitFrames between Light and Dark mode\n/eltruism gradient - Toggles Gradient mode\n/eltruism transparent - Toggles transparent UnitFrame health\n/eltruism background - Toggles between grey and black ElvUI backgrounds\n/eltruism chat - Toggles Chat between dark and transparent modes"], 1)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.args.color = E.Libs.ACH:Execute(L["Toggle Light / Dark Mode"], nil, 2, function() ElvUI_EltreumUI:RunCommands('color') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.args.gradient = E.Libs.ACH:Execute(L["Toggle Gradient Mode"], nil, 3, function() ElvUI_EltreumUI:RunCommands('gradient') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.args.transparent = E.Libs.ACH:Execute(L["Toggle Transparent Health"], nil, 4, function() ElvUI_EltreumUI:RunCommands('transparent') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.args.background = E.Libs.ACH:Execute(L["Toggle Grey / Black Background"], nil, 5, function() ElvUI_EltreumUI:RunCommands('background') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q3.args.chat = E.Libs.ACH:Execute(L["Toggle Dark / Transparent Chat"], nil, 6, function() ElvUI_EltreumUI:RunCommands('chat') E:StaticPopup_Show('CONFIG_RL') end, nil, false, "double")

	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4 = E.Libs.ACH:Group(E:TextGradient(L["How can I improve performance and FPS with Eltruism?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4.inline = true
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4.args.answer = E.Libs.ACH:Description(L["Eltruism includes several commands to optimize performance:\n/eltruism performance - Disables demanding ElvUI and Eltruism features and applies performance CVars\n/eltruism performancecvars - Applies performance-oriented game CVars\n/eltruism encountercheck - Toggles Encounter Check to disable some effects during boss fights\n/eltruism togglemodels - Toggles 3D portrait and frame models on or off"], 1)
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4.args.performance = E.Libs.ACH:Execute(L["Performance Optimization"], nil, 2, function() ElvUI_EltreumUI:RunCommands('performance') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4.args.performancecvars = E.Libs.ACH:Execute(L["Apply Performance CVars"], nil, 3, function() ElvUI_EltreumUI:RunCommands('performancecvars') end, nil, true, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4.args.encountercheck = E.Libs.ACH:Execute(L["Toggle Encounter Check"], nil, 4, function() ElvUI_EltreumUI:RunCommands('encountercheck') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.setup.args.q4.args.togglemodels = E.Libs.ACH:Execute(L["Toggle 3D Models"], nil, 5, function() ElvUI_EltreumUI:RunCommands('togglemodels') end, nil, false, "double")

	ElvUI_EltreumUI.Options.args.help.args.commands = E.Libs.ACH:Group(L["Commands"], nil, 4)
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q1 = E.Libs.ACH:Group(E:TextGradient(L["What slash commands does Eltruism have?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 1)
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q1.inline = true
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q1.args.answer = E.Libs.ACH:Description(L["Type /eltruism help in chat to see the full list of commands.\n\nCommon commands include:\n/eltruism - Opens Eltruism options\n/eltruism setup - Opens the Eltruism installer\n/eltruism fader - Toggles UnitFrame and ActionBar fading\n/eltruism paging <1-10> - Swaps ActionBar paging between Bar 1 and Bar 4, or sets a specific bar\n/eltruism newchar - Sets up Chat, CVars, and Edit Mode on the current character\n/eltruismdebug on/off - Toggles debug mode (disables other addons and enables Lua errors)"], 1)
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q1.args.help = E.Libs.ACH:Execute(L["Print Commands in Chat"], nil, 2, function() ElvUI_EltreumUI:RunCommands('help') end, nil, false, "full")

	ElvUI_EltreumUI.Options.args.help.args.commands.args.q2 = E.Libs.ACH:Group(E:TextGradient(L["How do /way and !key commands work?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 2)
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q2.inline = true
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q2.args.answer = E.Libs.ACH:Description(L["In modern WoW (Retail), Eltruism provides:\n/way or /waypoint (moved to /eway and /ewaypoint if TomTom is loaded) - Sets a map waypoint at the given coordinates (Eltruism > Maps > Chat Command)\n!key or !keys in guild or party chat (and /!key) - Links your Mythic+ keystone and automatically slots it when opening the keystone pedestal (Eltruism > Chat)"], 1)

	ElvUI_EltreumUI.Options.args.help.args.commands.args.q3 = E.Libs.ACH:Group(E:TextGradient(L["What other utility and testing commands does Eltruism have?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q3.inline = true
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q3.args.answer = E.Libs.ACH:Description(L["/eltruism modeldebug - Prints your target's 3D portrait model ID (useful for custom models in Eltruism > UnitFrames > Models)\n/eltruism universalborders - Toggles test mode to add borders everywhere (also in Eltruism > Borders)\n/eltruism universalshadows - Toggles test mode to add shadows everywhere\n/eltruism loot - Demonstrates Eltruism LootText\n/eltruism screenshotcomparison - Takes screenshots at multiple resolutions"], 1)
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q3.args.loot = E.Libs.ACH:Execute(L["Test LootText"], nil, 2, function() ElvUI_EltreumUI:RunCommands('loot') end, nil, false, "double")
	ElvUI_EltreumUI.Options.args.help.args.commands.args.q3.args.debug = E.Libs.ACH:Execute(L["Debug"], nil, 3, function() if next(ElvDB.EltruismDisabledAddOns) then ElvUI_EltreumUI:DebugMode("off") else ElvUI_EltreumUI:DebugMode("on") end end, nil, true, "double")

	--support
	ElvUI_EltreumUI.Options.args.support = E.Libs.ACH:Group(E:TextGradient(_G.GAMEMENU_SUPPORT, 0.50, 0.70, 1, 0.67, 0.95, 1), L["Direct links to GitHub, CurseForge, Wago and Tukui"], 13, 'tab')
	ElvUI_EltreumUI.Options.args.support.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\support'
	ElvUI_EltreumUI.Options.args.support.args.debug = E.Libs.ACH:Execute(L["Debug"], nil, 1, function()
		if next(ElvDB.EltruismDisabledAddOns) then
			ElvUI_EltreumUI:DebugMode("off")
		else
			ElvUI_EltreumUI:DebugMode("on")
		end
	end)
	ElvUI_EltreumUI.Options.args.support.args.issues = E.Libs.ACH:Input(L["Report issues and problems here:"], "", 8, false, "full", function() return 'https://github.com/eltreum0/eltruism/issues' end)
	--[[ElvUI_EltreumUI.Options.args.support.args.tukui = E.Libs.ACH:Input(L["Addon on Tukui:"], "", 9, false, "full", function()
		if E.Modern then
			return 'https://www.tukui.org/addons.php?id=209'
		elseif E.Cata then
			return 'https://www.tukui.org/classic-wotlk-addons.php?id=10'
		elseif E.Classic then
			return 'https://www.tukui.org/classic-addons.php?id=49'
		end
	end)]]
	ElvUI_EltreumUI.Options.args.support.args.site = E.Libs.ACH:Input(ElvUI_EltreumUI.Name, "", 9, false, "full", function() return 'https://eltruism.com/' end)
	ElvUI_EltreumUI.Options.args.support.args.curse = E.Libs.ACH:Input(L["Addon on CurseForge:"], "", 10, false, "full", function() return 'https://www.curseforge.com/wow/addons/elvui-eltruism' end)
	ElvUI_EltreumUI.Options.args.support.args.wago = E.Libs.ACH:Input(L["Addon on Wago:"], "", 10, false, "full", function() return 'https://addons.wago.io/addons/elvui-eltruism' end)
	ElvUI_EltreumUI.Options.args.support.args.discord = E.Libs.ACH:Description(" ", 42, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\disc', nil, 256, 128)
	ElvUI_EltreumUI.Options.args.support.args.discord2 = E.Libs.ACH:Description(L["Join the Discord for faster support and to report any issues you might encounter"], 43, nil)
	ElvUI_EltreumUI.Options.args.support.args.discord3 = E.Libs.ACH:Description(L["Join the Discord if you have any questions or issues"], 44, nil)
	ElvUI_EltreumUI.Options.args.support.args.discord4 = E.Libs.ACH:Description(L["Keep in mind the discord is in English"], 45, nil)
	ElvUI_EltreumUI.Options.args.support.args.discordlink = E.Libs.ACH:Input("", "", 46, false, "full", function() return 'https://discord.gg/rBXNxUY6pk' end)

	--weakauras anchor
	if not E.Modern then
		ElvUI_EltreumUI.Options.args.weakauras = E.Libs.ACH:Group(E:TextGradient(L["WeakAuras"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Learn how to use the WeakAuras anchors to attach WeakAuras and use ElvUI's movers to move them"], 14)
		ElvUI_EltreumUI.Options.args.weakauras.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\weakauras'
		ElvUI_EltreumUI.Options.args.weakauras.args.description1 = E.Libs.ACH:Description(L["WeakAuras"], 2, nil)
		ElvUI_EltreumUI.Options.args.weakauras.args.description2 = E.Libs.ACH:Description(L["You can set your Weakauras to anchor to custom locations making it easier to move them"], 3, nil)
		ElvUI_EltreumUI.Options.args.weakauras.args.description3 = E.Libs.ACH:Description(L["In order to use this feature, simply go to your Weakaura, and go to its Group options, scroll down to Position Settings and set the Anchored To Select Frame, then type either |cff82B4ffEltruismWA|r or |cff82B4ffEltruismConsumablesWA|r to anchor the weakaura to the preset location"], 4, nil)
		ElvUI_EltreumUI.Options.args.weakauras.args.description4 = E.Libs.ACH:Description(format(L["Setting %s or %s as the anchor will move them to the locations, keep in mind you might need to change the X and Y offset of the weakaura to zero"], "|cff82B4ffEltruismWA|r", "|cff82B4ffEltruismConsumablesWA|r"), 5, nil)
		ElvUI_EltreumUI.Options.args.weakauras.args.image = E.Libs.ACH:Group(L["How to use the Anchors"], nil, 6)
		ElvUI_EltreumUI.Options.args.weakauras.args.image.inline = true
		ElvUI_EltreumUI.Options.args.weakauras.args.image.args.description1 = E.Libs.ACH:Description(L["Open WeakAuras, go to your group Weakauras and in Group change Position Settings > Anchored To > Select Frame > EltruismWA or EltruismConsumablesWA"], 2, nil)
		ElvUI_EltreumUI.Options.args.weakauras.args.image.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\WADemo', nil, 512, 512)
	end

	--credits
	ElvUI_EltreumUI.Options.args.credits = E.Libs.ACH:Group(E:TextGradient(L["Credits"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Credits and Licenses"], 15)
	ElvUI_EltreumUI.Options.args.credits.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\credits'
	ElvUI_EltreumUI.Options.args.credits.args.author = E.Libs.ACH:Group(L["Author"], nil, 1)
	ElvUI_EltreumUI.Options.args.credits.args.author.inline = true
	ElvUI_EltreumUI.Options.args.credits.args.author.args.description1 = E.Libs.ACH:Description(AUTHORS_STRING, 2, "medium")
	ElvUI_EltreumUI.Options.args.credits.args.thankyous = E.Libs.ACH:Group(L["Credits and Thank yous"], nil, 3)
	ElvUI_EltreumUI.Options.args.credits.args.thankyous.inline = true
	ElvUI_EltreumUI.Options.args.credits.args.thankyous.args.description1 = E.Libs.ACH:Description(THANKYOU_STRING, 4, "medium")
	ElvUI_EltreumUI.Options.args.credits.args.donators = E.Libs.ACH:Group(L["Donators"], nil, 5)
	ElvUI_EltreumUI.Options.args.credits.args.donators.inline = true
	ElvUI_EltreumUI.Options.args.credits.args.donators.args.description1 = E.Libs.ACH:Description(DONATORS_STRING1, 6,"MEDIUM",nil,nil,nil,nil,"fill")
	ElvUI_EltreumUI.Options.args.credits.args.donators.args.description2 = E.Libs.ACH:Description(DONATORS_STRING2, 7,"MEDIUM",nil,nil,nil,nil,"fill")
	ElvUI_EltreumUI.Options.args.credits.args.translators = E.Libs.ACH:Group(L["Translators"], nil, 17)
	ElvUI_EltreumUI.Options.args.credits.args.translators.inline = true
	ElvUI_EltreumUI.Options.args.credits.args.translators.args.description1 = E.Libs.ACH:Description(TRANSLATORS_STRING, 18, "medium")
	ElvUI_EltreumUI.Options.args.credits.args.licenses = E.Libs.ACH:Group(L["License"], nil, 19)
	ElvUI_EltreumUI.Options.args.credits.args.licenses.inline = true
	local licenses = {
		'Cooldown includes portions from Doom Cooldown Pulse by discoteq (MIT License)',
		'FreeVector (www.freevector.com) for some icons (see Licenses/Textures License.txt)',
		'Icons8 (www.icons8.com) for some icons (see Licenses/Textures License.txt)',
		'LibEltreumGlow includes portions from LibCustomGlow by Benjamin Staneck (Stanzilla), Dooez, and Hendrick "nevcairiel" Leppkes (MIT License)',
		'Loot Icons include portions from Chat Loot Icons by Stanzilla (Public Domain)',
	}
	if E.Modern then
		tinsert(licenses, 'Hold to Cast includes portions from HoldToCastFix by JulianNorton and ElvUI-HoldToCastFix by danielbehrens (MIT License)')
	end
	if not E.Retail then
		tinsert(licenses, 'Sockets and Enchants include portions from Kibs Item Levels by Kibsgaard (Public Domain)')
		tinsert(licenses, 'Character Panel Item Levels include portions from Simple Item Levels by Kemayo (BSD 3-Clause License)')
	end
	sort(licenses, SortList)
	local licenseText = "Eltruism is All Rights Reserved (see License.md). Permissive (MIT/BSD) and Public Domain notices below apply only to original upstream portions; all Eltruism modifications and additions remain All Rights Reserved.\n\n" .. tconcat(licenses, '\n')
	ElvUI_EltreumUI.Options.args.credits.args.licenses.args.description1 = E.Libs.ACH:Description(licenseText, 10, "small", nil, nil, nil, nil, "full")

	--[[
	E.Libs.ACH:Header(name, order, get, set, hidden)
	E.Libs.ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	E.Libs.ACH:Description(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)
	E.Libs.ACH:Spacer(order, width, hidden)

	E.Libs.ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Execute(name, desc, order, func, image, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Select(name, desc, order, values, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Input(name, desc, order, multiline, width, get, set, disabled, hidden, validate)
	E.Libs.ACH:Color(name, desc, order, alpha, width, get, set, disabled, hidden)
	E.Libs.ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)
	E.Libs.ACH:MultiSelect(name, desc, order, values, confirm, width, get, set, disabled, hidden, sortByValue)

	E.Libs.ACH:SharedMediaFont(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaSound(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaStatusbar(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaBackground(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaBorder(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:FontFlags(name, desc, order, width, get, set, disabled, hidden)
	]]--

	E.Options.args.ElvUI_EltreumUI = ElvUI_EltreumUI.Options

	ElvUI_EltreumUI:BorderOptions()
	ElvUI_EltreumUI:ChatOptions()
	ElvUI_EltreumUI:CombatMusicOptions()
	ElvUI_EltreumUI:CooldownOptions()
	ElvUI_EltreumUI:CursorOptions()
	ElvUI_EltreumUI:CustomGlowOptions()
	ElvUI_EltreumUI:CVarOptions()
	ElvUI_EltreumUI:GradientOptions()
	ElvUI_EltreumUI:InstallerOptions()
	ElvUI_EltreumUI:LootOptions()
	ElvUI_EltreumUI:MapOptions()
	ElvUI_EltreumUI:MediaOptions()
	ElvUI_EltreumUI:MiscOptions()
	ElvUI_EltreumUI:NameplateOptions()
	ElvUI_EltreumUI:PartyOptions()
	ElvUI_EltreumUI:QuestOptions()
	ElvUI_EltreumUI:SkinsOptions()
	ElvUI_EltreumUI:UnitframeOptions()
	ElvUI_EltreumUI:PortraitOptions()
	ElvUI_EltreumUI:Changelog()
end
