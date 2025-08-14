local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G

-- Eltruism installer options
function ElvUI_EltreumUI:InstallerOptions()
	ElvUI_EltreumUI.Options.args.installer = E.Libs.ACH:Group(E:TextGradient(L["Installer"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Install, Reinstall or Update various parts of Eltruism"], 2, 'tab')
	ElvUI_EltreumUI.Options.args.installer.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\install'
	ElvUI_EltreumUI.Options.args.installer.args.tab1 = E.Libs.ACH:Group(L["Eltruism Installer"], nil, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.description1 = E.Libs.ACH:Description(L["Eltruism Installer"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.eltruisminstaller = E.Libs.ACH:Execute(L["Launch Eltruism Installer"], L["Launches the Eltruism install prompt"], 3, function() E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData) E:ToggleOptions() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.description2 = E.Libs.ACH:Description(L["Eltruism Settings"], 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.resetupdateeltruism = E.Libs.ACH:Execute(L["Reset/Update Eltruism Settings"], L["Resets/Updates Eltruism Settings to Eltreum's Defaults"], 5, function() ElvUI_EltreumUI:UpdateEltruismSettings() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.description3 = E.Libs.ACH:Description(L["ElvUI Settings"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab1.args.updateelvui = E.Libs.ACH:Execute(L["Reset/Update ElvUI Settings"], L["Resets/Updates ElvUI Settings to Eltreum's Defaults"], 7, function() ElvUI_EltreumUI:UpdateElvUISettings() E:StaticPopup_Show('CONFIG_RL') end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab2 = E.Libs.ACH:Group(L["Nameplates"], nil, 2)
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.description1 = E.Libs.ACH:Description(L["Reset Nameplates"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.resetnameplate = E.Libs.ACH:Execute(L["Reset nameplates to Eltruism settings"], nil, 3, function() ElvUI_EltreumUI:SetupNamePlates() ElvUI_EltreumUI:ResolutionOutline() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.description2 = E.Libs.ACH:Description(L["Reset Style Filters"], 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab2.args.resetstylefilter = E.Libs.ACH:Execute(L["Reset Nameplate Style Filters"], nil, 5, function() ElvUI_EltreumUI:SetupStyleFilters() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3 = E.Libs.ACH:Group(L["Layouts"], nil, 3)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.description1 = E.Libs.ACH:Description(L["Reinstall DPS Layout"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.resetdpslayout = E.Libs.ACH:Execute(L["Reset layout to Eltruism DPS/Tank"], nil, 3, function() E.data:SetProfile('Eltreum DPS/Tank ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutDPS() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.description2 = E.Libs.ACH:Description(L["Reinstall Healer Layout"], 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.resethealerlayout = E.Libs.ACH:Execute(L["Reset layout to Eltruism Healer"], nil, 5, function() E.data:SetProfile('Eltreum Healer ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutHealer() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.description3 = E.Libs.ACH:Description(L["Reinstall Eltruism Datatext"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.resetdatatext = E.Libs.ACH:Execute(L["Reset/Add Eltruism Datatext Panel"], nil, 7, function() ElvUI_EltreumUI:SetupDataText() E:UpdateMoverPositions() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.description4 = E.Libs.ACH:Description(L["Reinstall Thin Layout"], 8, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab3.args.thinmode = E.Libs.ACH:Execute(E.NewSign..L["Reset layout to Eltruism Thin"], nil, 9, function() E.data:SetProfile('Eltreum Thin ('..E.mynameRealm..')') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutThin() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4 = E.Libs.ACH:Group(L["General"], nil, 4)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.description1 = E.Libs.ACH:Description(L["Reinstall"].." ".._G.CHAT_LABEL or "Chat", 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.resetchat = E.Libs.ACH:Execute(L["Reset Chat to ElvUI Settings"], nil, 3, function()
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
				_G.ChatFrame_RemoveChannel(_G.ChatFrame1, lfg)
				_G.FCF_OpenNewWindow()
				_G.ChatFrame_RemoveAllMessageGroups(_G.ChatFrame5)
				_G.FCF_SetWindowName(_G.ChatFrame5, 'LFG')
				_G.ChatFrame_AddChannel(_G.ChatFrame5, lfg)
				_G.FCFTab_UpdateColors(_G.ChatFrame5Tab)
				_G.FCFDock_SelectWindow(_G.GENERAL_CHAT_DOCK, _G.ChatFrame1)
			end
		end
	end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.description2 = E.Libs.ACH:Description(L["Skip Plugins"], 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.skipplugin = E.Libs.ACH:Execute(L["Skip Plugins install message"], L["Make the warnings to install profiles for other plugins stop"], 5, function()
		E.private.ElvUI_EltreumUI.isInstalled.sle = true
		E.private.ElvUI_EltreumUI.isInstalled.windtools = true
		E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
	end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.description3 = E.Libs.ACH:Description(L["Database Check"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.databasecheck = E.Libs.ACH:Execute(L["Run Database Check"], L["Perform a Database Check if you are updating from a very old version as some settings have changed places and the Database Check will convert them"], 7, function() ElvUI_EltreumUI:DatabaseConversions(true) end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.description4 = E.Libs.ACH:Description(L["Clear Details! Damage Meter tables to free up memory"], 8, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.detailscache= E.Libs.ACH:Execute(L["Clear Details Tables"], L["Set Details tables to be empty"], 9, function() ElvUI_EltreumUI:EmptyDetailsTable() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.description5 = E.Libs.ACH:Description(_G.EDIT_MODE_LAYOUT_HYPERLINK_TEXT or "", 10, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.installer.args.tab4.args.blizzeditmodelayout = E.Libs.ACH:Execute(E.Retail and _G.HUD_EDIT_MODE_IMPORT_LAYOUT.." ".._G.EDIT_MODE_LAYOUT_HYPERLINK_TEXT or "", nil, 11, function() ElvUI_EltreumUI:NewRetailEditModeLayout() end,nil,false,'full',nil,nil,nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.installer.args.tab5 = E.Libs.ACH:Group(L["Gradient"], nil, 5, 'tab')
	ElvUI_EltreumUI.Options.args.installer.args.tab5.args.export = E.Libs.ACH:Group(L["Export"], nil, 1, 'tab')
	ElvUI_EltreumUI.Options.args.installer.args.tab5.args.export.args.input = E.Libs.ACH:Input(L["Exported Gradient Data:"], nil, 1, 27, "full", function() return ElvUI_EltreumUI:ExportImportGradient(nil,"export") end, function() return end)
	ElvUI_EltreumUI.Options.args.installer.args.tab5.args.export.args.input.disableButton = true
	ElvUI_EltreumUI.Options.args.installer.args.tab5.args.import = E.Libs.ACH:Group(L["Import"], nil, 2, 'tab')
	ElvUI_EltreumUI.Options.args.installer.args.tab5.args.import.args.input = E.Libs.ACH:Input(L["Import Gradient Data"], nil, 1, 27, "full", function() return "" end, function(_, data) ElvUI_EltreumUI:ExportImportGradient(data,"import") end)
	ElvUI_EltreumUI.Options.args.installer.args.tab5.args.import.args.input.focusSelect = true
end
