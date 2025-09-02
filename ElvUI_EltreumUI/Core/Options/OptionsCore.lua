local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local tinsert = _G.table.insert
local tconcat = _G.table.concat
local sort = _G.sort
local pairs = _G.pairs
local format = _G.format

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
	'|TInterface/AddOns/ElvUI/Core/Media/ChatLogos/Clover:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0ALuckyone|r Especially for allowing the usage of his installer/plugin as a model',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/releaf:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0AReleaf|r for the alternate class icons',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/tukuidiscord:15:15:0:0:64:64:5:59:5:59|t Tukui Community for all the help and motivation',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/addonsdiscord:15:15:0:0:64:64:5:59:5:59|t WoW AddOns; for answering a lot of questions',
	'AcidWeb |TInterface/AddOns/ElvUI/Core/Media/ChatLogos/Gem:15:15:-1:2:64:64:6:60:8:60|t',
	'|cff8E44ADB|r|cff2ECC71lin|r|cff3498DBkii|r',
	'|cff960000Atwood|r - for some of the role icons',
	'|cffB50909Dlarge|r - for the German localization',
	'|cff33937FFang2hou|r - for the compatibility function',
	E:TextGradient("Meowcactus", 1, 0.49, 0.04, 1, 0.96, 0.41),
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

-- SortList
local function SortList(a, b)
	local aUpper = a:gsub("^%l", string.upper)
	local bUpper = b:gsub("^%l", string.upper)
	if E:StripString(aUpper) < E:StripString(bUpper) then
		return true
	else
		return false
	end
end

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
local donatordivisor = math.floor(#DONATORS/2)
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

-- Eltruism ingame options
function ElvUI_EltreumUI:Configtable()
	-- Add Eltruism version on top of the ElvUI config
	E.Options.name = E.Options.name .. " + " .. ElvUI_EltreumUI.Name .. format(" |cffffffff%s|r", ElvUI_EltreumUI.Version)

	ElvUI_EltreumUI.Options = E.Libs.ACH:Group("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0|t" .. ElvUI_EltreumUI.Name, nil, 6)
	ElvUI_EltreumUI.Options.args.logo = E.Libs.ACH:Description(nil, 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq', nil, 320, 80)

	--line break so these non options are not with the others
	ElvUI_EltreumUI.Options.args.linebreak = E.Libs.ACH:Group(" ", nil, 86)
	ElvUI_EltreumUI.Options.args.linebreak.disabled = true

	--weakauras anchor
	ElvUI_EltreumUI.Options.args.weakauras = E.Libs.ACH:Group(E:TextGradient(L["WeakAuras"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Learn how to use the WeakAuras anchors to attach WeakAuras and use ElvUI's movers to move them"], 85)
	ElvUI_EltreumUI.Options.args.weakauras.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\weakauras'
	ElvUI_EltreumUI.Options.args.weakauras.args.description1 = E.Libs.ACH:Description(L["WeakAuras"], 2, nil)
	ElvUI_EltreumUI.Options.args.weakauras.args.description2 = E.Libs.ACH:Description(L["You can set your Weakauras to anchor to custom locations making it easier to move them"], 3, nil)
	ElvUI_EltreumUI.Options.args.weakauras.args.description3 = E.Libs.ACH:Description(L["In order to use this feature, simply go to your Weakaura, and go to its Group options, scroll down to Position Settings and set the Anchored To Select Frame, then type either |cff82B4ffEltruismWA|r or |cff82B4ffEltruismConsumablesWA|r to anchor the weakaura to the preset location"], 4, nil)
	ElvUI_EltreumUI.Options.args.weakauras.args.description4 = E.Libs.ACH:Description(L["Setting "].."|cff82B4ffEltruismWA|r"..L[" or "].."|cff82B4ffEltruismConsumablesWA|r"..L[" as the anchor will move them to the locations, keep in mind you might need to change the X and Y offset of the weakaura to zero"], 5, nil)
	ElvUI_EltreumUI.Options.args.weakauras.args.image = E.Libs.ACH:Group(L["How to use the Anchors"], nil, 6)
	ElvUI_EltreumUI.Options.args.weakauras.args.image.inline = true
	ElvUI_EltreumUI.Options.args.weakauras.args.image.args.description1 = E.Libs.ACH:Description(L["Open WeakAuras, go to your group Weakauras and in Group change Position Settings > Anchored To > Select Frame > EltruismWA or EltruismConsumablesWA"], 2, nil)
	ElvUI_EltreumUI.Options.args.weakauras.args.image.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\WADemo', nil, 512, 512)

	--credits
	ElvUI_EltreumUI.Options.args.credits = E.Libs.ACH:Group(E:TextGradient(L["Credits"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Credits and Licenses"], 98)
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
	ElvUI_EltreumUI.Options.args.credits.args.licenses.args.description1 = E.Libs.ACH:Description(
			E.Retail and [[
Cooldown is a fork of discoteq's Doom Cooldown Pulse which is licensed under MIT License
Cursor Cooldowns is a fork of CooldownToGo by mitchnull which is licensed under Public Domain
Cursor is a fork of CastCursor by michaelsp which licensed under GNU GPLv3
FreeVector (www.freevector.com) for some of the icons. List in license.txt
Icons8 (www.icons8.com) for some of the icons. List in license.txt
Loot Icons are merged from Chat Loot Icons by Stanzilla which is licensed under Public Domain
LootText is a fork of SLoTe from xavjer which is licensed under GNU GPLv3
Quest Items is a merge of QBar by Aezay, which is licensed under GNU GPLv3
Rogue Door Opener is a fork of Rogue Door Opener by Burzolog which licensed under GNU GPLv3
]] or [[
Cooldown is a fork of discoteq's Doom Cooldown Pulse which is licensed under MIT License
Cursor Cooldowns is a fork of CooldownToGo by mitchnull which is licensed under Public Domain
Cursor is a fork of CastCursor by michaelsp which licensed under GNU GPLv3
FreeVector (www.freevector.com) for some of the icons. List in license.txt
Icons8 (www.icons8.com) for some of the icons. List in license.txt
Loot Icons are merged from Chat Loot Icons by Stanzilla which is licensed under Public Domain
LootText is a fork of SLoTe from xavjer which is licensed under GNU GPLv3
Quest Items is a merge of QBar by Aezay, which is licensed under GNU GPLv3
Sockets and Enchants is a fork of Kibs Item Levels by Kibsgaard which is licensed under Public Domain
The Item Level shown on the Character Panel Skin uses code from Simple Item level by Kemayo, licensed under BSD
]], 10, "small", nil, nil, nil, nil, "full")

	--support
	ElvUI_EltreumUI.Options.args.support = E.Libs.ACH:Group(E:TextGradient(_G.GAMEMENU_SUPPORT, 0.50, 0.70, 1, 0.67, 0.95, 1), L["Direct links to GitHub, CurseForge, Wago and Tukui"], 88, 'tab')
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
		if E.Retail then
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

	--faq
	ElvUI_EltreumUI.Options.args.faq = E.Libs.ACH:Group(E:TextGradient("F.A.Q", 0.50, 0.70, 1, 0.67, 0.95, 1), L["Frequently Asked Questions"], 88, 'tab')
	ElvUI_EltreumUI.Options.args.faq.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\faq'
	ElvUI_EltreumUI.Options.args.faq.args.faq = E.Libs.ACH:Group(E:TextGradient(L["Frequently Asked Questions"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 20)
	ElvUI_EltreumUI.Options.args.faq.args.faq.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q1 = E.Libs.ACH:Group(E:TextGradient(L["How do I disable the chat hide?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q1.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q1.args.answer = E.Libs.ACH:Description(L["If you are coming from a version before 2.3.0 then check ElvUI > Shadow and Light > Chat > Set Hide to None\nOtherwise, check Eltruism > Chat"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q2 = E.Libs.ACH:Group(E:TextGradient(L["After the Chat fades I still see some icons"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q2.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q2.args.answer = E.Libs.ACH:Description(L["This is a Blizzard bug that was found a long time ago"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q3 = E.Libs.ACH:Group(E:TextGradient(L["My chat hides when my mouse leaves it"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q3.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q3.args.answer = E.Libs.ACH:Description(L["Disable Mouse over in Eltruism > Chat"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q4 = E.Libs.ACH:Group(E:TextGradient(L["My chat hides after a few seconds"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q4.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q4.args.answer = E.Libs.ACH:Description(L["Disable Inactivity/Fader in Eltruism > Chat"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q5 = E.Libs.ACH:Group(E:TextGradient(L["My action bars and unitframes keep disappearing!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q5.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q5.args.answer = E.Libs.ACH:Description(L["ElvUI > ActionBars > Player Bars > on each Bar disable Inherit Global Fade\nElvUI > Unitframes > Type of Unit > Unit > Fader, disable the fader"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q6 = E.Libs.ACH:Group(E:TextGradient(L["My Details! window disappears after combat!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q6.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q6.args.answer = E.Libs.ACH:Description(L["If you have AddOnSkins then go to ElvUI > AddOnSkins > Embed Settings > Turn off Out of Combat (Hide)\nIf details is showing up on top of the trade chat, try going to AddOnSkins > Embed Settings and making sure that its hiding the Trade/Loot chat, you can also right click the > arrow in order to toggle the details embed.\nIf you do not have AddOnSkins then go to Eltruism > Skins > Addons > Details > Embed > Hide out of Combat, you can also change the amount of time it takes for it to hide.\nIn either AddOnSkins or Eltruism embeds you can also Right Click the Chat Toggle (the Arrow [ > ] on the bottom right) to Toggle the Visibility\nA shortcut to disabling the combat hide is /eltruism detailshide"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q7 = E.Libs.ACH:Group(E:TextGradient(L["Music keeps playing when AFK"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q7.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q7.args.answer = E.Libs.ACH:Description(L["Disable the AFK music in Eltruism > AFK in order to stop the music from playing"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q7 = E.Libs.ACH:Group(E:TextGradient(L["How do I make bar 1 my action paging bar instead of bar 4?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q7.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q7.args.answer = E.Libs.ACH:Description(L["You can swap them out in Eltruism > Media, or by using the command /eltruism paging, make sure to reload"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q8 = E.Libs.ACH:Group(E:TextGradient(L["How can I get Blizzard's floating Mana/Energy/Rage/Other combat text back?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q8.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q8.args.answer = E.Libs.ACH:Description(L["Go to ElvUI > Eltruism > Misc > Blizzard Combat Text and uncheck Disable Combat Text and Check Enable Resource Gains, then reload"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q9 = E.Libs.ACH:Group(E:TextGradient(L["My Loot Rolls are missing!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q9.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q9.args.answer = E.Libs.ACH:Description(L["You have enabled Hide Alert Frame, disable that setting to restore the Alert Frame/Loot Rolls"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q10 = E.Libs.ACH:Group(E:TextGradient(L["Where is my floating combat text?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q10.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q10.args.answer = E.Libs.ACH:Description(L["It's possible you installed NameplateSCT/FCT and removed it so the floating combat text was not enabled back\nYou can go into Eltruism > CVars > Other CVars > Restore All Combat Text to restore them"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q11 = E.Libs.ACH:Group(E:TextGradient(L["My nameplates flash once an enemy is below 20% Health!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q11.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q11.args.answer = E.Libs.ACH:Description(L["That is due to the EltreumExecute filter, you can disable it in:\nElvUI > Nameplates > Style Filter > (from the dropdown) EltreumExecute > Triggers > Uncheck Enable"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q12 = E.Libs.ACH:Group(E:TextGradient(L["My Unitframes and/or ActionBars keep reverting positions!"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q12.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q12.args.answer = E.Libs.ACH:Description(L["If your actionbars or other frames are moving or resetting after a reload,\ncheck ElvUI > Eltruism > Borders for the Auto Adjust option.\n\nThis option is enabled when you enable Borders, it will not enable otherwise.\n\nAuto Adjust moves frames to a set position due to how borders need\ndifferent settings per layout and need to be changed so that borders don't overlap.\nDisable this option to stop the automatic changes.\n\nYou can also use the /eltruism autoadjust command to toggle it off"])
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q13 = E.Libs.ACH:Group(E:TextGradient(L["How do I remove the lines/skin on all the frames?"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 22)
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q13.inline = true
	ElvUI_EltreumUI.Options.args.faq.args.faq.args.q13.args.answer = E.Libs.ACH:Description(L["If you want to disable the ElvUI skin that adds textures to ElvUI you can go into\n\nEltruism > Skins > Addons > ElvUI\n\nWhere you can disable it or change its color, transparency and texture.\nYou can also type /eltruism elvuiskin to disable it "])

	--changelog
	ElvUI_EltreumUI.Options.args.changelog = E.Libs.ACH:Group(E:TextGradient(L["Changelog"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Check what has changed in the current version of Eltruism"], 88, 'tab')
	ElvUI_EltreumUI.Options.args.changelog.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\changelog'
	ElvUI_EltreumUI.Options.args.changelog.args.changelog = E.Libs.ACH:Input(L["Changelog"], "", 1, false, "full", function() return 'https://github.com/eltreum0/eltruism/blob/main/Changelog.md' end)
	ElvUI_EltreumUI.Options.args.changelog.args.description1 = E.Libs.ACH:Description(E.NewSign..E:TextGradient("v"..ElvUI_EltreumUI.Version, 0.50, 0.70, 1, 0.67, 0.95, 1), 2, "large", nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.changelog.args.added = E.Libs.ACH:Group(E:TextGradient("Added", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.added.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.added.args.description = E.Libs.ACH:Description([[
Added an experimental instant DPS tag [eltruism:unitdps]
Added more models to the Portrait Fix
Added shadows to Fly outs
]], 3, "small", nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.changelog.args.updated = E.Libs.ACH:Group(E:TextGradient("Updated", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 3)
	ElvUI_EltreumUI.Options.args.changelog.args.updated.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.updated.args.description = E.Libs.ACH:Description([[
Updated Portrait function to enable overlay and toggle the 3D models alongside the setting
Updated Combat Music to better handle Boss units that don't trigger Encounter Start events
Updated some tags and other functions to allow AI party members to use class colors
Updated Sockets in Classic Era to better show tooltips for the Enchants
Updated Quest Item Bar to allow item usage in combat
Updated Bag Profession Icons to add missing IDs
Updated the maximum size shadows can be set to
Updated Immersion skin to better handle fonts
Updated music for Earthen and Dracthyr
]], 5, "small", nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.changelog.args.fixed = E.Libs.ACH:Group(E:TextGradient("Fixed", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4)
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.inline = true
	ElvUI_EltreumUI.Options.args.changelog.args.fixed.args.description = E.Libs.ACH:Description([[
Fixed an issue with the Bag Profession missing Icons in Mists of Pandaria Classic and Classic Era
Fixed an issue when disabling ElvUI's spellbook skin would still have the shadows
Fixed an issue when using Leatrix Maps and having ElvUI world map disabled
Fixed shadows on unitframes when the infopanel was enabled but not shown
Fixed an error with the Item Delete due to a change on Blizzard's API
Fixed an error in Classic Era when inspecting units
Fixed an issue with the Leatrix Maps DB when not using Leatrix Maps
]], 7, "small", nil, nil, nil, nil, "full")

	--[[
	E.Libs.ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	E.Libs.ACH:Description(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)

	E.Libs.ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Execute(name, desc, order, func, image, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Select(name, desc, order, values, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Input(name, desc, order, multiline, width, get, set, disabled, hidden, validate)
	E.Libs.ACH:Color(name, desc, order, alpha, width, get, set, disabled, hidden)
	E.Libs.ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)

	E.Libs.ACH:SharedMediaFont(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaSound(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaStatusbar(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaBackground(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaBorder(name, desc, order, width, get, set, disabled, hidden)
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
end
