local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local tinsert = _G.table.insert
local tconcat = _G.table.concat
local unpack = _G.unpack
local select = _G.select
local sort = _G.sort
local pairs = _G.pairs
local table = _G.table
local format = _G.format
local MINIMAP_LABEL = _G.MINIMAP_LABEL
local AURAS = _G.AURAS
local BINDING_HEADER_CHAT = _G.BINDING_HEADER_CHAT
local HONOR = _G.HONOR
local CURRENCY = _G.CURRENCY
local tostring = _G.tostring
local PlaySoundFile = _G.PlaySoundFile
local tonumber = _G.tonumber
local SetCVar = _G.SetCVar
local C_CVar = _G.C_CVar
local OKAY = _G.OKAY
local Item = _G.Item
local tremove = _G.tremove
local AceGUIWidgetLSMlists = _G.AceGUIWidgetLSMlists
local IsAddOnLoaded = _G.IsAddOnLoaded

--Author list
local AUTHORS = {
	'|cff82B4ffEltreum|r',
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
}

local DONATORS = {
	'|cffB50909Akiao|r',
	'|cffB50909Artan|r',
	'|cffB50909BralumConquest|r',
	'|cffB50909Brovenn|r',
	'|cffB50909Daxxarri|r',
	'|cffB50909Dlarge|r',
	'|cffB50909Dreamador|r',
	'|cffB50909Dreandor|r',
	'|cffB50909Gently Caress the Constabulary|r',
	'|cffB50909Greevir|r',
	'|cffB50909Jazz|r',
	'|cffB50909Jiberish|r',
	'|cffB50909Madlampy|r',
	'|cffB50909Markpoops|r',
	'|cffB50909Michael_|r',
	'|cffB50909Morthart|r',
	'|cffB50909Mr.Ditto|r',
	'|cffB50909Nekator|r',
	'|cffB50909Nyhilatiant|r',
	'|cffB50909Oakshlam|r',
	'|cffB50909Smuve|r',
	'|cffB50909Trenchy|r',
	'|cffB50909Vxt|r',
}

local TRANSLATORS = {
	'|cffCC3333Khornan|r - German Translation',
	'|cffCC3333Dlarge|r - German Translation',
	'|cffCC3333Neo|r - Chinese Translation',
	'DeepL artificial intelligence for French and Spanish translations',
}

-- SortList
local function SortList(a, b)
	return E:StripString(a) < E:StripString(b)
end

sort(AUTHORS, SortList)
sort(THANKYOU, SortList)
sort(DONATORS, SortList)
sort(TRANSLATORS, SortList)

-- Author table
for _, name in pairs(AUTHORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local AUTHORS_STRING = tconcat(AUTHORS, '|n')

-- Thank you table
for _, name in pairs(THANKYOU) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local THANKYOU_STRING = tconcat(THANKYOU, '|n')

-- Donators table
for _, name in pairs(DONATORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local DONATORS_STRING = tconcat(DONATORS, '|n')

-- Translators table
for _, name in pairs(TRANSLATORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local TRANSLATORS_STRING = tconcat(TRANSLATORS, '|n')

-- Eltruism ingame options
function ElvUI_EltreumUI:Configtable()
	-- Add Eltruism version on top of the ElvUI config
	E.Options.name = E.Options.name .. " + " .. ElvUI_EltreumUI.Name .. format(" |cffffffff%s|r", ElvUI_EltreumUI.Version)
	local ACH = E.Libs.ACH
	ElvUI_EltreumUI.Options = ACH:Group("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0|t" .. ElvUI_EltreumUI.Name, nil, 6)
	ElvUI_EltreumUI.Options.args.logo = ACH:Description(nil, 1, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq', 320, 80 end)

	-- installer
	ElvUI_EltreumUI.Options.args.installer = ACH:Group(E:TextGradient(L["Installer"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Install, Reinstall or Update various parts of Eltruism"], 2, 'tab')
	ElvUI_EltreumUI.Options.args.installer.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\install'
	ElvUI_EltreumUI.Options.args.installer.args.tab1 = ACH:Group(L["Eltruism Installer"], nil, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.header1 = ACH:Description(L["Eltruism Installer"], 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.eltruisminstaller = ACH:Execute(L["Launch Eltruism Installer"], L["Launches the Eltruism install prompt"], 3, function() E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData) E:ToggleOptions() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.header2 = ACH:Description(L["Eltruism Settings"], 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.resetupdateeltruism = ACH:Execute(L["Reset/Update Eltruism Settings"], L["Resets/Updates Eltruism Settings to Eltreum's Defaults"], 5, function() ElvUI_EltreumUI:UpdateEltruismSettings() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.header3 = ACH:Description(L["ElvUI Settings"], 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.updateelvui = ACH:Execute(L["Reset/Update ElvUI Settings"], L["Resets/Updates ElvUI Settings to Eltreum's Defaults"], 7, function() ElvUI_EltreumUI:UpdateElvUISettings() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab2 = ACH:Group(L["Nameplates"], nil, 2)
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.header1 = ACH:Description(L["Reset Nameplates"], 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.resetnameplate = ACH:Execute(L["Reset nameplates to Eltruism settings"], nil, 3, function() ElvUI_EltreumUI:SetupNamePlates() ElvUI_EltreumUI:ResolutionOutline() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.header2 = ACH:Description(L["Reset Style Filters"], 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.resetstylefilter = ACH:Execute(L["Reset Nameplate Style Filters"], nil, 5, function() ElvUI_EltreumUI:SetupStyleFilters() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3 = ACH:Group(L["Layouts"], nil, 3)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.header1 = ACH:Description(L["Reinstall DPS Layout"], 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.resetdpslayout = ACH:Execute(L["Reset layout to Eltruism DPS/Tank"], nil, 3, function() E.data:SetProfile('Eltreum DPS/Tank ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutDPS() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.header2 = ACH:Description(L["Reinstall Healer Layout"], 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.resethealerlayout = ACH:Execute(L["Reset layout to Eltruism Healer"], nil, 5, function() E.data:SetProfile('Eltreum Healer ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutHealer() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.header3 = ACH:Description(L["Reinstall Eltruism Datatext"], 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.resetdatatext = ACH:Execute(L["Reset/Add Eltruism Datatext Panel"], nil, 7, function() ElvUI_EltreumUI:SetupDataText() E:UpdateMoverPositions() end,nil,false,'full')

	ElvUI_EltreumUI.Options.args.installer.args.tab4 = ACH:Group(L["General"], nil, 4)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.header1 = ACH:Description(L["Reinstall"].." "..CHAT_LABEL, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.resetchat = ACH:Execute(L["Reset Chat to ElvUI Settings"], nil, 3, function()
		E:SetupChat()
		ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])
		--for classic chat lfg
		local lfg
		if E.global.general.locale == "enUS" then
			lfg = "LookingForGroup"
		elseif E.global.general.locale == "deDE" then
			lfg = "SucheNachGruppe"
		elseif E.global.general.locale == "esMX" or E.global.general.locale == "esES" then
			lfg = "BuscarGrupo"
		elseif E.global.general.locale == "frFR" then
			lfg = "RechercheDeGroupe"
		elseif E.global.general.locale == "ruRU" then
			lfg = "ПоискСпутников"
		elseif E.global.general.locale == "zhTW" then
			lfg = "尋求組隊"
		else
			lfg = "LookingForGroup"
		end
		if not E.Retail then --remove lfg spam from general and creat tab for it
			if lfg then
				ChatFrame_RemoveChannel(_G.ChatFrame1, lfg)
				FCF_OpenNewWindow()
				ChatFrame_RemoveAllMessageGroups(_G.ChatFrame5)
				FCF_SetWindowName(_G.ChatFrame5, 'LFG')
				ChatFrame_AddChannel(_G.ChatFrame5, lfg)
				FCFTab_UpdateColors(_G.ChatFrame5Tab)
				FCFDock_SelectWindow(_G.GENERAL_CHAT_DOCK, _G.ChatFrame1)
			end
		end
	end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.header2 = ACH:Description(L["Skip Plugins"], 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.skipplugin = ACH:Execute(L["Skip Plugins install message"], L["Make the warnings to install profiles for other plugins stop"], 5, function()
		E.private.ElvUI_EltreumUI.isInstalled.sle = true
		E.private.ElvUI_EltreumUI.isInstalled.windtools = true
		E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
	end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.header3 = ACH:Description(L["Database Check"], 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.databasecheck = ACH:Execute(L["Run Database Check"], L["Perform a Database Check if you are updating from a very old version as some settings have changed places and the Database Check will convert them"], 7, function() ElvUI_EltreumUI:DatabaseConversions(true) end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.header4 = ACH:Description(L["Clear Details! Damage Meter tables to free up memory"], 8, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.detailscache= ACH:Execute(L["Clear Details Tables"], L["Set Details tables to be empty"], 9, function() ElvUI_EltreumUI:EmptyDetailsTable() end,nil,false,'full')

	-- aurafilters
	ElvUI_EltreumUI.Options.args.aurafilters = ACH:Group(E:TextGradient(L["Aura Filters"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Choose to show all debuffs/buffs or use default Filters"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.aurafilters.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\aurafilter'
	ElvUI_EltreumUI.Options.args.aurafilters.args.player = ACH:Group(L["Player"], nil, 2)
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player = ACH:Group(L["Select how auras will be displayed for Player"], nil, 1)
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.inline = true
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.args.header1 = ACH:Description(nil, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.args.allbuffs = ACH:Execute(L["All Player Buffs"], L["Set filters to show more buffs on Player"], 2, function() ElvUI_EltreumUI:SetupBuffs('player', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.args.alldebuffs = ACH:Execute(L["All Player Debuffs"], L["Set filters to show more debuffs on Player"], 3, function() ElvUI_EltreumUI:SetupDebuffs('player', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.args.header2 = ACH:Description(nil, 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.args.eltruismbuffs = ACH:Execute(L["Eltruism Player Buffs"], L["Set filters to be Eltruism defaults on Player"], 5, function() ElvUI_EltreumUI:SetupBuffs('player', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.player.args.player.args.eltruismdebuffs = ACH:Execute(L["Eltruism Player Debuffs"], L["Set filters to be Eltruism defaults on Player"], 6, function() ElvUI_EltreumUI:SetupDebuffs('player', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.target = ACH:Group(TARGET, nil, 2)
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target = ACH:Group(L["Select how auras will be displayed for Target"], nil, 1)
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.inline = true
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.args.header1 = ACH:Description(nil, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.args.allbuffs = ACH:Execute(L["All Target Buffs"], L["Set filters to show more buffs on Target"], 2, function() ElvUI_EltreumUI:SetupBuffs('target', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.args.alldebuffs = ACH:Execute(L["All Target Debuffs"], L["Set filters to show more debuffs on Target"], 3, function() ElvUI_EltreumUI:SetupDebuffs('target', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.args.header2 = ACH:Description(nil, 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.args.eltruismbuffs = ACH:Execute(L["Eltruism Target Buffs"], L["Set filters to be Eltruism defaults on Target"], 5, function() ElvUI_EltreumUI:SetupBuffs('target', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.target.args.target.args.eltruismdebuffs = ACH:Execute(L["Eltruism Target Debuffs"], L["Set filters to be Eltruism defaults on Target"], 6, function() ElvUI_EltreumUI:SetupDebuffs('target', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus = ACH:Group(POWER_TYPE_FOCUS, nil, 2, nil, nil, nil, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus = ACH:Group(L["Select how auras will be displayed for Focus"], nil, 1)
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.inline = true
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.args.header1 = ACH:Description(nil, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.args.allbuffs = ACH:Execute(L["All Focus Buffs"], L["Set filters to show more buffs on Focus"], 2, function() ElvUI_EltreumUI:SetupBuffs('focus', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.args.alldebuffs = ACH:Execute(L["All Focus Debuffs"], L["Set filters to show more debuffs on Focus"], 3, function() ElvUI_EltreumUI:SetupDebuffs('focus', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.args.header2 = ACH:Description(nil, 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.args.eltruismbuffs = ACH:Execute(L["Eltruism Focus Buffs"], L["Set filters to be Eltruism defaults on Focus"], 5, function() ElvUI_EltreumUI:SetupBuffs('focus', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.focus.args.focus.args.eltruismdebuffs = ACH:Execute(L["Eltruism Focus Debuffs"], L["Set filters to be Eltruism defaults on Focus"], 6, function() ElvUI_EltreumUI:SetupDebuffs('focus', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss = ACH:Group(L["Boss"], nil, 2, nil, nil, nil, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss = ACH:Group(L["Select how auras will be displayed for Boss"], nil, 1)
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.inline = true
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.args.header1 = ACH:Description(nil, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.args.allbuffs = ACH:Execute(L["All Boss Buffs"], L["Set filters to show more buffs on Boss"], 2, function() ElvUI_EltreumUI:SetupBuffs('boss', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.args.alldebuffs = ACH:Execute(L["All Boss Debuffs"], L["Set filters to show more debuffs on Boss"], 3, function() ElvUI_EltreumUI:SetupDebuffs('boss', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.args.header2 = ACH:Description(nil, 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.args.eltruismbuffs = ACH:Execute(L["Eltruism Boss Buffs"], L["Set filters to be Eltruism defaults on Boss"], 5, function() ElvUI_EltreumUI:SetupBuffs('boss', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.boss.args.boss.args.eltruismdebuffs = ACH:Execute(L["Eltruism Boss Debuffs"], L["Set filters to be Eltruism defaults on Boss"], 6, function() ElvUI_EltreumUI:SetupDebuffs('boss', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate = ACH:Group(L["Nameplates"], nil, 2)
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate = ACH:Group(L["Select how auras will be displayed for Nameplates"], nil, 1)
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.inline = true
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.args.header1 = ACH:Description(nil, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.args.allbuffs = ACH:Execute(L["All Nameplate Buffs"], L["Set filters to show more buffs on Nameplates"], 2, function() ElvUI_EltreumUI:SetupBuffs('nameplate', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.args.alldebuffs = ACH:Execute(L["All Nameplate Debuffs"], L["Set filters to show more debuffs on Nameplates"], 3, function() ElvUI_EltreumUI:SetupDebuffs('nameplate', 'Everything') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.args.header2 = ACH:Description(nil, 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.args.eltruismbuffs = ACH:Execute(L["Eltruism Nameplate Buffs"], L["Set filters to be Eltruism defaults on Nameplates"], 5, function() ElvUI_EltreumUI:SetupBuffs('nameplate', 'Eltruism') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.aurafilters.args.nameplate.args.nameplate.args.eltruismdebuffs = ACH:Execute(L["Eltruism Nameplate Debuffs"], L["Set filters to be Eltruism defaults on Nameplates"], 6, function() ElvUI_EltreumUI:SetupDebuffs('nameplate', 'Eltruism') end,nil,false,'full')

	--addons
	ElvUI_EltreumUI.Options.args.addons = ACH:Group(E:TextGradient(L["Addons"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Install or update other Addon profiles"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.addons.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\addon'
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins = ACH:Group(L["ElvUI Plugins"], nil, 2)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.header1 = ACH:Description("Azilroka Addons", 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.addonskins = ACH:Execute('|cff16C3F2AddOn|r|cFFFFFFFFSkins|r', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:AddonSetupAS() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("AddOnSkins") end)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.projectazilroka = ACH:Execute('|cFF16C3F2Project|r|cFFFFFFFFAzilroka|r', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:AddonSetupPA() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("ProjectAzilroka") end)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.header2 = ACH:Description("Shadow and Light", 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.shadowandlight = ACH:Execute("|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r", L["Reset to Eltruism defaults."], 5, function() ElvUI_EltreumUI:GetSLEProfile() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("ElvUI_SLE") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.header3 = ACH:Description("WindTools", 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.windtools = ACH:Execute("|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r", L["Reset to Eltruism defaults."], 7, function() ElvUI_EltreumUI:GetWindToolsProfile() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("ElvUI_WindTools") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.header4 = ACH:Description("Dynamic Status Icons", 8, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.elvuiplugins.args.dyamicstatusicons = ACH:Execute('|cFF16C3F2Dynamic Status |r|cFFFFFFFFIcons|r', L["Reset to Eltruism defaults."], 9, function() ElvUI_EltreumUI:SetupDynamicStatusIcons() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("ElvUI_DynamicStatusIcons") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods = ACH:Group(L["BossMods Profiles"], nil, 3)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods.args.header1 = ACH:Description(nil, 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods.args.bigwigs = ACH:Execute('BigWigs', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:AddonSetupBW() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("BigWigs_Core") end)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods.args.header2 = ACH:Description(nil, 4, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods.args.dbm = ACH:Execute('DBM', L["Reset to Eltruism defaults."], 5, function() ElvUI_EltreumUI:AddonSetupDBM() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("DBM-Core") end)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods.args.header3 = ACH:Description(nil, 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.bossmods.args.methodraidtools = ACH:Execute('Method Raid Tools', L["Reset to Eltruism defaults."], 7, function() ElvUI_EltreumUI:AddonSetupMRT() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("MRT") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons = ACH:Group(L["Addon Profiles"], nil, 4)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.header1 = ACH:Description(L["Misc"].." "..L["AddOns"], 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.dynamiccam = ACH:Execute('Dynamic Cam', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:AddonSetupDynamicCam() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("DynamicCam") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.immersion = ACH:Execute('Immersion', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:AddonSetupImmersion() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Immersion") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.warpdeplete = ACH:Execute('WarpDeplete', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:GetWarpDepleteProfile() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("WarpDeplete") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.questie = ACH:Execute('Questie', L["Reset to Eltruism defaults."], 3, function() ElvUI_EltreumUI:AddonSetupQuestie() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Questie") end, E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.omnicddps = ACH:Execute('OmniCD DPS', L["Reset to Eltruism defaults."], 4, function() ElvUI_EltreumUI:GetOmniCDProfile("dps") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("OmniCD") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.omnicdhealer = ACH:Execute('OmniCD Healer', L["Reset to Eltruism defaults."], 4, function() ElvUI_EltreumUI:GetOmniCDProfile("healer") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("OmniCD") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.BattleGroundEnemies = ACH:Execute('BattleGroundEnemies', L["Reset to Eltruism defaults."], 5, function() ElvUI_EltreumUI:GetBattleGroundEnemiesProfile() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("BattleGroundEnemies") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.Capping = ACH:Execute('Capping', L["Reset to Eltruism defaults."], 5, function() ElvUI_EltreumUI:GetCappingProfile() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Capping") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.GladiusEx = ACH:Execute('Gladius Ex', L["Reset to Eltruism defaults."], 6, function() ElvUI_EltreumUI:AddonSetupGladiusEx() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("GladiusEx") end, not E.Retail)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.Gladdy = ACH:Execute('Gladdy', L["Reset to Eltruism defaults."], 6, function() ElvUI_EltreumUI:SetupGladdy() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Gladdy") end, not E.Wrath)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.Gladius = ACH:Execute('Gladius', L["Reset to Eltruism defaults."], 6, function() ElvUI_EltreumUI:SetupGladius() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Gladius") end, not E.Wrath)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.header2 = ACH:Description(L["Combat Text Addons"], 7, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.NameplateSCT = ACH:Execute('NameplateSCT', L["Reset to Eltruism defaults."], 8, function() ElvUI_EltreumUI:AddonSetupCombatText("NameplateSCT") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("NameplateSCT") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.ElvUI_FCT = ACH:Execute('ElvUI Floating Combat Text', L["Reset to Eltruism defaults."], 8, function() ElvUI_EltreumUI:AddonSetupCombatText("ElvUI_FCT") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("ElvUI_FCT") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.header3 = ACH:Description(L["Details Profiles"], 9, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.detailsv1 = ACH:Execute(L["Details v1 - Blizzard Flat Icons"], L["Reset to Eltruism defaults."], 10, function() ElvUI_EltreumUI:AddonSetupDT("spec") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Details") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.detailsv2 = ACH:Execute(L["Details v2 - Releaf Transparent Icons"], L["Reset to Eltruism defaults."], 10, function() ElvUI_EltreumUI:AddonSetupDT("releafalpha") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Details") end)
	ElvUI_EltreumUI.Options.args.addons.args.otheraddons.args.detailsv3 = ACH:Execute(L["Details v3 - Releaf Solid Icons"], L["Reset to Eltruism defaults."], 10, function() ElvUI_EltreumUI:AddonSetupDT("releafsolid") E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full',nil,nil, function() return not IsAddOnLoaded("Details") end)

	--afk
	ElvUI_EltreumUI.Options.args.afk = ACH:Group(E:TextGradient(L["A.F.K"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Enhance the AFK screen"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.afk.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\afk'
	ElvUI_EltreumUI.Options.args.afk.args.header1 = ACH:Description(L["Play music while you are AFK"], 2, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.afk.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false,"full",function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable = value end)
	ElvUI_EltreumUI.Options.args.afk.args.header2 = ACH:Description(L["Select a type of music"], 4, nil, nil, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.afk.args.racialmusic = ACH:Toggle(L["Racial Music"], nil, 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end, not E.Retail)
	ElvUI_EltreumUI.Options.args.afk.args.classmusic = ACH:Toggle(L["Class Music"], nil, 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end, not E.Retail)
	ElvUI_EltreumUI.Options.args.afk.args.header3 = ACH:Description("Eltruism Logo", 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.afk.args.eltruismlogo = ACH:Toggle(L["Enable"], nil, 7, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.afklogo end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afklogo = value end)

	--borders
	ElvUI_EltreumUI.Options.args.borders = ACH:Group(E:TextGradient(L["Borders"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Add Borders to frames and customize them"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.borders.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\border'
	ElvUI_EltreumUI.Options.args.borders.args.general = ACH:Group(L["General"], nil, 1)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.header1 = ACH:Description(L["Enable Borders"], 3, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.enable = ACH:Toggle(L["Enable"], nil, 4, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.borders = value ElvUI_EltreumUI:ShowHideBorders() ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.enableautoadjust = ACH:Toggle(L["Enable Auto-adjusting the actionbar spacing and position"], L["Adjusts actionbar spacing and position based on borders being enabled or not"], 5, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust end,function(_, value) E.db.ElvUI_EltreumUI.borders.borderautoadjust = value ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.header2 = ACH:Description(L["Choose the Border Texture to be used:"], 6, nil, function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', 3240, 1 end)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.bordertexture = ACH:SharedMediaBorder("", nil, 7, "full", function() return E.db.ElvUI_EltreumUI.borders.texture end, function(self,key) E.db.ElvUI_EltreumUI.borders.texture = key ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.classcolors = ACH:Toggle(L["Use Class Colors"], nil, 8, nil, false,nil,function() return E.db.ElvUI_EltreumUI.borders.classcolor end,function(_, value) E.db.ElvUI_EltreumUI.borders.classcolor = value ElvUI_EltreumUI:Borders() E:StaticPopup_Show('CONFIG_RL') end,function() return not E.db.ElvUI_EltreumUI.borders.borders end)
	ElvUI_EltreumUI.Options.args.borders.args.general.args.colorborders = ACH:Color(L["Custom Color"], nil, 9, false, nil, function()
		local customcolorborders = E.db.ElvUI_EltreumUI.borders.bordercolors
		local d = P.ElvUI_EltreumUI.borders.bordercolors
		return customcolorborders.r, customcolorborders.g, customcolorborders.b, customcolorborders.a, d.r, d.g, d.b, d.a
	end,
	function(_, r, g, b, a)
		local customcolorborders = E.db.ElvUI_EltreumUI.borders.bordercolors
		customcolorborders.r, customcolorborders.g, customcolorborders.b = r, g, b E:StaticPopup_Show('CONFIG_RL') ElvUI_EltreumUI:Borders()
	end, function() return E.db.ElvUI_EltreumUI.borders.classcolor end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders = ACH:Group(L["ActionBars"], nil, 2, nil,nil,nil,function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.header0 = ACH:Group(L["(All settings require a reload)"], nil, 1)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.header0.inline = true
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.header0.args.header1 = ACH:Description(L["Change the size of the borders:"], 2)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.header0.args.ABsize = ACH:Range(L["Actionbar Thickness"], nil, 3, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.baredgesize end, function(_, value) E.db.ElvUI_EltreumUI.borders.baredgesize = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.private.actionbar.enable end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar1 = ACH:Group(L["Action Bar 1"], nil, 2,"tab")
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar1.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.bar1borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.bar1borders = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar1.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar1.args.bar1xsize = ACH:Range(L["Bar 1 X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar1xborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar1xborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar1.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar1.args.bar1ysize = ACH:Range(L["Bar 1 Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar1yborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar1yborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar1.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar2 = ACH:Group(L["Action Bar 2"], nil, 2,"tab")
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar2.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.bar2borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.bar2borders = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar2.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar2.args.bar2xsize = ACH:Range(L["Bar 2 X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar2xborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar2xborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar2.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar2.args.bar2ysize = ACH:Range(L["Bar 2 Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar2yborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar2yborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar2.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar3 = ACH:Group(L["Action Bar 3"], nil, 2,"tab")
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar3.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.bar3borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.bar3borders = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar3.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar3.args.bar3xsize = ACH:Range(L["Bar 3 X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar3xborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar3xborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar3.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar3.args.bar3ysize = ACH:Range(L["Bar 3 Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar3yborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar3yborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar3.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar4 = ACH:Group(L["Action Bar 4"], nil, 2,"tab")
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar4.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.bar4borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.bar4borders = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar4.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar4.args.bar4xsize = ACH:Range(L["Bar 4 X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar4xborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar4xborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar4.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar4.args.bar4ysize = ACH:Range(L["Bar 4 Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar4yborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar4yborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar4.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar5 = ACH:Group(L["Action Bar 5"], nil, 2,"tab")
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar5.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.bar5borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.bar5borders = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar5.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar5.args.bar5xsize = ACH:Range(L["Bar 5 X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar5xborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar5xborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar5.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar5.args.bar5ysize = ACH:Range(L["Bar 5 Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar5yborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar5yborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar5.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar6 = ACH:Group(L["Action Bar 6"], nil, 2,"tab")
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar6.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.bar6borders end,function(_, value) E.db.ElvUI_EltreumUI.borders.bar6borders = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar6.args.bar6xsize = ACH:Range(L["Bar 6 X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar6xborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar6xborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.actionbar6.args.bar6ysize = ACH:Range(L["Bar 6 Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.bar6yborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.bar6yborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.bar6.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.totem = ACH:Group(L["Shaman Totem Bar"], nil, 2,"tab",nil,nil,nil,not E.Wrath)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.totem.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.totembar end,function(_, value) E.db.ElvUI_EltreumUI.borders.totembar = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.totemBar.enable end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.totem.args.bordertotemsize = ACH:Range(L["Shaman Totem Thickness"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.totemedgesize end, function(_, value) E.db.ElvUI_EltreumUI.borders.totemedgesize = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.totemBar.enable end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.totem.args.totemxsize = ACH:Range(L["Totem X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.totemxborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.totemxborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.totemBar.enable end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.totem.args.totemysize = ACH:Range(L["Totem Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.totemyborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.totemyborder = value ElvUI_EltreumUI:Borders() end, function() return not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.totemBar.enable end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.stance = ACH:Group(L["Stance Bar"], nil, 2,"tab",nil,nil,nil)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.stance.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.stanceborders end,function(_, value) E.db.ElvUI_EltreumUI.borders.stanceborders = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.stanceBar.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.stance.args.borderstancesize = ACH:Range(L["Stance Bar Thickness"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.stanceedgesize end, function(_, value) E.db.ElvUI_EltreumUI.borders.stanceedgesize = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.stanceBar.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.stance.args.stancexsize = ACH:Range(L["Stance X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.stancexborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.stancexborder = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.stanceBar.enablede end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.stance.args.stanceysize = ACH:Range(L["Stance Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.stanceyborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.stanceyborder = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.stanceBar.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.pet = ACH:Group(L["Pet Action Bar"], nil, 2,"tab",nil,nil,nil)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.pet.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, false,"full",function() return E.db.ElvUI_EltreumUI.borders.petactionborders end,function(_, value) E.db.ElvUI_EltreumUI.borders.petactionborders = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.barPet.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.pet.args.borderpetabsize = ACH:Range(L["Pet Action Bar Thickness"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.petactionedgesize end, function(_, value) E.db.ElvUI_EltreumUI.borders.petactionedgesize = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.barPet.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.pet.args.petactionxsize = ACH:Range(L["Pet Action Bar X offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.petactionxborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.petactionxborder = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.barPet.enabled end)
	ElvUI_EltreumUI.Options.args.borders.args.actionbarsborders.args.pet.args.petactionysize = ACH:Range(L["Pet Action Bar Y offset"], nil, 2, { min = 1, max = 200, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.borders.petactionyborder end, function(_, value) E.db.ElvUI_EltreumUI.borders.petactionyborder = value ElvUI_EltreumUI:Borders() end, function() return E.db.ElvUI_EltreumUI.borders.borderautoadjust or not E.db.ElvUI_EltreumUI.borders.borders or not E.db.actionbar.barPet.enabled end)

	--ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)
	--ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	--ACH:Header(name, order, get, set, hidden)
	--ACH:Execute(name, desc, order, func, image, confirm, width, get, set, disabled, hidden)
	--ACH:Description(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)
	--ACH:Select(name, desc, order, values, confirm, width, get, set, disabled, hidden)
	--ACH:MultiSelect(name, desc, order, values, confirm, width, get, set, disabled, hidden) --??

	--ACH:Color(name, desc, order, alpha, width, get, set, disabled, hidden)
	--ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)

	--ACH:SharedMediaFont(name, desc, order, width, get, set, disabled, hidden)
	--ACH:SharedMediaSound(name, desc, order, width, get, set, disabled, hidden)
	--ACH:SharedMediaStatusbar(name, desc, order, width, get, set, disabled, hidden)
	--ACH:SharedMediaBackground(name, desc, order, width, get, set, disabled, hidden)
	--ACH:SharedMediaBorder(name, desc, order, width, get, set, disabled, hidden)



	E.Options.args.ElvUI_EltreumUI = ElvUI_EltreumUI.Options
end
