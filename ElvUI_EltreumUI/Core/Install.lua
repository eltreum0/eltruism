local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local ReloadUI = _G.ReloadUI
local IsAddOnLoaded = _G.IsAddOnLoaded
local myclass = E.myclass

-- Set version & reload on "Skip" and "Finished"
local function InstallComplete()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	ReloadUI()
end

if ElvUI_EltreumUI.Retail then
	-- Installer Steps Retail
	ElvUI_EltreumUI.InstallerData = {
		Title = ElvUI_EltreumUI.Name,
		Name = ElvUI_EltreumUI.Name,
		tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
		Pages = {
			[1] = function()
					PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
					PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
					PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
					PluginInstallFrame.Option1:Enable()
					PluginInstallFrame.Option1:Show()
					PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
					PluginInstallFrame.Option1:SetText(L["Skip Install"])
			end,
			[2] = function()
				PluginInstallFrame.SubTitle:SetText(L["Layouts"])
				PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile, this process can take a few seconds"])
				PluginInstallFrame.Desc2:SetText("You can let ElvUI automatically calculate the best scale for you using the AutoScale option")
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alt Frames after clicking DPS/Tank"]..'|r')
				end
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"]) ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutDPS() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option1:SetText('DPS\nTank')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"]) ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutHealer() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option2:SetText('Healer')
				PluginInstallFrame.Option3:SetText('Automatic\nScale')
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AutoScale() end)
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Option4:SetText('Alternative\nFrames')
					PluginInstallFrame.Option4:Enable()
					PluginInstallFrame.Option4:Show()
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				end
			end,
			[3] = function()
				PluginInstallFrame.SubTitle:SetText(L["Fonts"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
				PluginInstallFrame.Desc2:SetText("You can replace it with one of the following")
				PluginInstallFrame.Desc3:SetText("Or change it later in Eltruism > Media options")
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				--PluginInstallFrame.Option2:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
				--PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option1:SetText('Roboto')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
				--PluginInstallFrame.Option2:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\exo2:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option2:SetText('Exo2')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
				--PluginInstallFrame.Option3:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\gotham:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option3:SetText('Gotham')
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsCrystalzcuhei() end)
				PluginInstallFrame.Option4:SetText('Crystalzcuhei')
			end,
			[4] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Eltruism Modes"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Dark Mode and Transparent chat by default"])
				PluginInstallFrame.Desc2:SetText(L["You can switch to Light Mode and/or Dark Chat by clicking the buttons below"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')

				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:LightMode() end)
				PluginInstallFrame.Option1:SetText(L["Light Mode"])

				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:DarkMode() end)
				PluginInstallFrame.Option2:SetText(L["Dark Mode"])

				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:TransparentChat() end)
				PluginInstallFrame.Option3:SetText(L["Transparent\nChat"])

				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:DarkChat() end)
				PluginInstallFrame.Option4:SetText(L["Dark Chat"])
			end,
			[5] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Details')
				PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
				PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
				PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
				PluginInstallFrame.Desc4:SetText('Choose the type of icons Details! will use:')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option1:SetText('Spec')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option2:SetText('Releaf Alpha')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleafv3() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option3:SetText('Releaf Solid')
				if (not IsAddOnLoaded("Details")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
					PluginInstallFrame.Desc3:SetText(L["It uses less memory and is more efficient than alternatives"])
					PluginInstallFrame.Desc4:SetText(L["And has many plugins to choose from"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
					PluginInstallFrame.Option3:Disable()
				end
			end,
			[6] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('PVP/PVE Addons')
				PluginInstallFrame.Desc1:SetText(L["Import GladiusEx profile for arenas, remember to disable ElvUI Arena Frames"])
				PluginInstallFrame.Desc2:SetText(L["Import DBM or BigWigs profiles for dungeons and raigs. (Uses DBM English Calanon and Bigwigs Voice)"])
				PluginInstallFrame.Desc3:SetText(L["Import Method Raid Tools profile with raid cooldowns and other settings"])
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupGladiusEx() end)
				PluginInstallFrame.Option1:SetText('GladiusEx')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
				PluginInstallFrame.Option2:SetText('DBM')
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
				PluginInstallFrame.Option3:SetText('BigWigs')
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupMRT() end)
				PluginInstallFrame.Option4:SetText(L["Method\nRaid Tools"])
				if (not IsAddOnLoaded("GladiusEx")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("GladiusEx"..L[" is not installed or enabled"])
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("DBM-Core")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc2:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc2:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
					PluginInstallFrame.Option3:Disable()
				end
				if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc2:SetText(L["Both DBM and BigWigs are not installed or enabled"])
					PluginInstallFrame.Option2:Disable()
					PluginInstallFrame.Option3:Disable()
				end
				if (not IsAddOnLoaded("MRT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc3:SetText(L["Method Raid Tools"]..L[" is not installed or enabled"])
					PluginInstallFrame.Option4:Disable()
				end
				if (not IsAddOnLoaded("MRT")) and (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) and (not IsAddOnLoaded("GladiusEx")) then
					PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
				end
			end,
			[7] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["QOL Addons"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
				PluginInstallFrame.Desc2:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				PluginInstallFrame.Desc3:SetText(L["Import Dynamic Cam profile"])
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
				PluginInstallFrame.Option1:SetText('NameplateSCT')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
				PluginInstallFrame.Option2:SetText('ElvUI FCT')
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
				PluginInstallFrame.Option3:SetText('Immersion')
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
				PluginInstallFrame.Option4:SetText(L["DynamicCam"])
				if (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("NameplateSCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("ElvUI_FCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("ElvUI FCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["NameplateSCT and ElvUI FCT are not installed or enabled"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("Immersion")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc2:SetText("Immersion"..L[" is not installed or enabled"])
					PluginInstallFrame.Option3:Disable()
				end
				if (not IsAddOnLoaded("DynamicCam")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc3:SetText("Dynamic Cam"..L[" is not installed or enabled"])
					PluginInstallFrame.Option4:Disable()
				end
				if (not IsAddOnLoaded("DynamicCam")) and (not IsAddOnLoaded("Immersion")) and (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
				end
			end,
			[8] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Discord')
				PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/rBXNxUY6pk') 	end)
				PluginInstallFrame.Option1:SetText('Discord')
			end,
			[9] = function()
				PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
				PluginInstallFrame.Desc1:SetText("You have completed the installation process")
				PluginInstallFrame.Desc2:SetText("Please click Finished to reload the UI")
				PluginInstallFrame.Desc3:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Finished"])
			end,
		},
		StepTitles = {
			[1] = L["Welcome"],
			[2] = L["Layouts"],
			[3] = L["Fonts"],
			[4] = 'Eltruism Modes',
			[5] = 'Details',
			[6] = L["PVP/PVE Addons"],
			[7] = L["QOL Addons"],
			[8] = 'Discord',
			[9] = L["Installation Complete"],
		},
		StepTitlesColor = {1, 1, 1},
		StepTitlesColorSelected = {70/255, 130/255, 180/255},
		StepTitleWidth = 200,
		StepTitleButtonWidth = 180,
		StepTitleTextJustification = 'CENTER',
	}
elseif ElvUI_EltreumUI.Classic then
	-- Installer Steps Classic
	ElvUI_EltreumUI.InstallerData = {
		Title = ElvUI_EltreumUI.Name,
		Name = ElvUI_EltreumUI.Name,
		tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
		Pages = {
			[1] = function()
					PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
					PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
					PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
					PluginInstallFrame.Option1:Show()
					PluginInstallFrame.Option1:Enable()
					PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
					PluginInstallFrame.Option1:SetText(L["Skip Install"])
			end,
			[2] = function()
				PluginInstallFrame.SubTitle:SetText(L["Layouts"])
				PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile, this process can take a few seconds"])
				PluginInstallFrame.Desc2:SetText("You can let ElvUI automatically calculate the best scale for you using the AutoScale option")
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alt Frames after clicking DPS/Tank"]..'|r')
				end
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"]) ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutDPS() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option1:SetText('DPS/Tank')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"]) ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutHealer() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option2:SetText('Healing')
				PluginInstallFrame.Option3:SetText('AutoScale')
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AutoScale() end)
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Option4:SetText('Alt Frames')
					PluginInstallFrame.Option4:Enable()
					PluginInstallFrame.Option4:Show()
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				end
			end,
			[3] = function()
				PluginInstallFrame.SubTitle:SetText(L["Fonts"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
				PluginInstallFrame.Desc2:SetText("You can replace it with one of the following")
				PluginInstallFrame.Desc3:SetText("Or change it later in Eltruism > Media options")
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				--PluginInstallFrame.Option2:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
				--PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option1:SetText('Roboto')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
				--PluginInstallFrame.Option2:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\exo2:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option2:SetText('Exo2')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
				--PluginInstallFrame.Option3:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\gotham:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option3:SetText('Gotham')
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsCrystalzcuhei() end)
				PluginInstallFrame.Option4:SetText('Crystalzcuhei')
			end,
			[4] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Details')
				PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
				PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
				PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
				PluginInstallFrame.Desc4:SetText('Choose the type of icons Details! will use:')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option1:SetText('Blizzard')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option2:SetText('Releaf Alpha')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleafv3() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option3:SetText('Releaf Solid')
				if (not IsAddOnLoaded("Details")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
					PluginInstallFrame.Desc3:SetText(L["It uses less memory and is more efficient than alternatives"])
					PluginInstallFrame.Desc4:SetText(L["And has many plugins to choose from"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
					PluginInstallFrame.Option3:Disable()
				end
			end,
			[5] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Boss Mods"])
				PluginInstallFrame.Desc1:SetText(L["Import DBM or Bigwigs profiles"])
				PluginInstallFrame.Desc2:SetText(L["These profiles are setup with DBM English Calanon and Bigwigs Voice"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
				PluginInstallFrame.Option1:SetText('DBM')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
				PluginInstallFrame.Option2:SetText('BigWigs')
				if (not IsAddOnLoaded("DBM-Core")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
					PluginInstallFrame.Desc2:SetText(L["BigWigs uses BigWigs voice in its profile"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
					PluginInstallFrame.Desc2:SetText(L["DBM uses DBM English by Calanon as a voice pack"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Both DBM and BigWigs are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["No boss mods found"])
					PluginInstallFrame.Desc3:SetText(L["Boss mods are highly recommended for modern encounters"])
					PluginInstallFrame.Desc4:SetText('')
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[6] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Combat Text"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
				PluginInstallFrame.Option1:SetText('NameplateSCT')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
				PluginInstallFrame.Option2:SetText('ElvUI FCT')
				if (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("NameplateSCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["ElvUI FCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("ElvUI_FCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("ElvUI FCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["NameplateSCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["NameplateSCT and ElvUI FCT are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Combat text addons enhance the default Blizzard Combat Text"])
					PluginInstallFrame.Desc3:SetText(L["NameplateSCT and ElvUI FCT make the combat text float from the nameplate/frame"])
					PluginInstallFrame.Desc4:SetText(L["And add effects to them with minimal memory usage"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[7] = function()
				PluginInstallFrame.SubTitle:SetText('Immersion')
				PluginInstallFrame.Desc1:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				PluginInstallFrame.Desc2:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Immersion')
				if (not IsAddOnLoaded("Immersion")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Immersion"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Immersion is an addon that changes the quest dialog with npcs"])
					PluginInstallFrame.Desc3:SetText(L["It transforms them into a talking head with dialog options on the side"])
					PluginInstallFrame.Desc4:SetText(L["Including the ability to press number keys to select an option"])
					PluginInstallFrame.Option1:Disable()
				end
			end,
			[8] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Dynamic Cam')
				PluginInstallFrame.Desc1:SetText(L["Import Dynamic Cam profile"])
				PluginInstallFrame.Desc2:SetText(L["It is recommended to copy the profile into Dynamic Cam's Settings"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
				PluginInstallFrame.Option1:SetText(L["Overwrite"])
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'dmIvbaGnvvZKkYSPGBtQSxSBsPFQs0We)McnuvkgUQWXizPQIwSkPwov1dvv6PkltfpNIAIurnvIPlDrsvpJsxNQSrvQAZQkMgvy0Qu5KQKCAvPRrroVkHltLomP4VQuAuiSh(g)8AWfHz(TEA6RrTMry2yrOmvSiuwowekl5hHYS5GqzXArOS8hekl5GqzQeek7KGqzQCqOSykiuwokekZgfcLLycHYIvHqzNOqOS8RqOSefcLLJdeklMuiuwIdekZMGqz5eekl2GqzQOqOSyDGqPSpV(M7tpTCnL1lE4YC(7T388Y7VYj9mTA05Y0BO(UE6yA86Dg9z6nuFxpDuaa') 	end)
				PluginInstallFrame.Option2:SetText(L["Copy"])
				if (not IsAddOnLoaded("DynamicCam")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Dynamic Cam"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["DynamicCam is addon that modifies the behavior of the camera"])
					PluginInstallFrame.Desc3:SetText(L["The profile uses some effects while questing"])
					PluginInstallFrame.Desc4:SetText(L["But in instances the effects are disabled"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[9] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Questie')
				PluginInstallFrame.Desc1:SetText(L["Import Questie profile"])
				PluginInstallFrame.Desc2:SetText(L["You will need to reload and wait for questie to rebuild the database"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				PluginInstallFrame.Option1:SetText(L["Import "])
				if (not IsAddOnLoaded("Questie")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Questie is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Questie is an addon that modifies the objective tracker"])
					PluginInstallFrame.Desc3:SetText(L["As such Questie adds a lot of features to it not available by default"])
					PluginInstallFrame.Desc4:SetText(L["Including TomTom support"])
					PluginInstallFrame.Option1:Disable()
				end
			end,
			[10] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Discord')
				PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/rBXNxUY6pk') 	end)
				PluginInstallFrame.Option1:SetText('Discord')
			end,
			[11] = function()
				PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
				PluginInstallFrame.Desc1:SetText("You have completed the installation process")
				PluginInstallFrame.Desc2:SetText("Please click Finished to reload the UI")
				PluginInstallFrame.Desc3:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Finished"])
			end,
		},
		StepTitles = {
			[1] = L["Welcome"],
			[2] = L["Layouts"],
			[3] = L["Fonts"],
			[4] = 'Details',
			[5] = L["Boss Mods"],
			[6] = L["Combat Text"],
			[7] = 'Immersion',
			[8] = 'Dynamic Cam',
			[9] = 'Questie',
			[10] = 'Discord',
			[11] = L["Installation Complete"],
		},
		StepTitlesColor = {1, 1, 1},
		StepTitlesColorSelected = {70/255, 130/255, 180/255},
		StepTitleWidth = 200,
		StepTitleButtonWidth = 180,
		StepTitleTextJustification = 'CENTER',
	}
elseif ElvUI_EltreumUI.TBC then
	-- Installer Steps Burning Crusade
	ElvUI_EltreumUI.InstallerData = {
		Title = ElvUI_EltreumUI.Name,
		Name = ElvUI_EltreumUI.Name,
		tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
		Pages = {
			[1] = function()
				PluginInstallFrame.Next:Enable()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
				PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
				PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Skip Install"])
			end,
			[2] = function()
				PluginInstallFrame.SubTitle:SetText(L["Layouts"])
				PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile, this process can take a few seconds"])
				PluginInstallFrame.Desc2:SetText("You can let ElvUI automatically calculate the best scale for you using the AutoScale option")
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alt Frames after clicking DPS/Tank"]..'|r')
				end
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"]) ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum DPS/Tank') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutDPS() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option1:SetText('DPS/Tank')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:SetupChat() ElvUI_EltreumUI:Print(L["ElvUI Chat has been Set"]) ElvUI_EltreumUI:AddonSetupPA() E.data:SetProfile('Eltreum Healer') ElvUI_EltreumUI:SetupGeneralLayout() ElvUI_EltreumUI:SetupLayoutHealer() ElvUI_EltreumUI:SetupNamePlates('ElvUI') ElvUI_EltreumUI:ResolutionOutline() end)
				PluginInstallFrame.Option2:SetText('Healing')
				PluginInstallFrame.Option3:SetText('AutoScale')
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AutoScale() end)
				if myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'MONK' or myclass == 'SHAMAN' or myclass == 'PALADIN' then
					PluginInstallFrame.Option4:SetText('Alt Frames')
					PluginInstallFrame.Option4:Enable()
					PluginInstallFrame.Option4:Show()
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				end
			end,
			[3] = function()
				PluginInstallFrame.SubTitle:SetText(L["Fonts"])
				PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
				PluginInstallFrame.Desc2:SetText("You can replace it with one of the following")
				PluginInstallFrame.Desc3:SetText("Or change it later in Eltruism > Media options")
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				--PluginInstallFrame.Option2:SetFont(E.LSM:Fetch('font', db.font), db.size, db.outline)
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
				--PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option1:SetText('Roboto')
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
				--PluginInstallFrame.Option2:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\exo2:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option2:SetText('Exo2')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:Enable()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
				--PluginInstallFrame.Option3:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\gotham:14:112:0:1:128:64:0:128:0:16|t')
				PluginInstallFrame.Option3:SetText('Gotham')
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsCrystalzcuhei() end)
				PluginInstallFrame.Option4:SetText('Crystalzcuhei')
			end,
			[4] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Details')
				PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
				PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
				PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
				PluginInstallFrame.Desc4:SetText('Choose the type of icons Details! will use:')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option1:SetText('Blizzard')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option2:SetText('Releaf Alpha')
				PluginInstallFrame.Option3:Show()
				PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleafv3() ElvUI_EltreumUI:GetASProfile() end)
				PluginInstallFrame.Option3:SetText('Releaf Solid')
				if (not IsAddOnLoaded("Details")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
					PluginInstallFrame.Desc3:SetText(L["It uses less memory and is more efficient than alternatives"])
					PluginInstallFrame.Desc4:SetText(L["And has many plugins to choose from"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
					PluginInstallFrame.Option3:Disable()
				end
			end,
			[5] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Boss Mods"])
				PluginInstallFrame.Desc1:SetText(L["Import DBM or Bigwigs profiles"])
				PluginInstallFrame.Desc2:SetText(L["These profiles are setup with DBM English Calanon and Bigwigs Voice"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
				PluginInstallFrame.Option1:SetText('DBM')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
				PluginInstallFrame.Option2:SetText('BigWigs')
				if (not IsAddOnLoaded("DBM-Core")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
					PluginInstallFrame.Desc2:SetText(L["BigWigs uses BigWigs voice in its profile"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
					PluginInstallFrame.Desc2:SetText(L["DBM uses DBM English by Calanon as a voice pack"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Both DBM and BigWigs are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["No boss mods found"])
					PluginInstallFrame.Desc3:SetText(L["Boss mods are highly recommended for modern encounters"])
					PluginInstallFrame.Desc4:SetText('')
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[6] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Arenas"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for Gladius or Gladdy"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["You might need to swap profiles to Eltreum in their settings"]..'|r')
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladius() end)
				PluginInstallFrame.Option1:SetText('Gladius')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
				PluginInstallFrame.Option2:SetText('Gladdy')
				if (not IsAddOnLoaded("Gladius")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Gladius is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Gladdy profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["You might need to swap profiles to Eltreum in their settings"]..'|r')
					PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("Gladdy")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Gladdy is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Gladius profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["You might need to swap profiles to Eltreum in their settings"]..'|r')
					PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("Gladius")) and (not IsAddOnLoaded("Gladdy")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Gladdy and Gladius are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Arena unitframes enhance the default Blizzard unitframes"])
					PluginInstallFrame.Desc3:SetText(L["Giving them additional features like DR tracking, trinket tracking, buffs and cooldowns"])
					PluginInstallFrame.Desc4:SetText(L["Being used by players for many years since 2008"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[7] = function()
				PluginInstallFrame.SubTitle:SetFormattedText(L["Combat Text"])
				PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
				PluginInstallFrame.Desc2:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
				PluginInstallFrame.Option1:SetText('NameplateSCT')
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
				PluginInstallFrame.Option2:SetText('ElvUI FCT')
				if (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("NameplateSCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["ElvUI FCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option1:Disable()
				end
				if (not IsAddOnLoaded("ElvUI_FCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("ElvUI FCT"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["NameplateSCT profile will be used"])
					PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
					PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
					PluginInstallFrame.Option2:Disable()
				end
				if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["NameplateSCT and ElvUI FCT are not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Combat text addons enhance the default Blizzard Combat Text"])
					PluginInstallFrame.Desc3:SetText(L["NameplateSCT and ElvUI FCT make the combat text float from the nameplate/frame"])
					PluginInstallFrame.Desc4:SetText(L["And add effects to them with minimal memory usage"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[8] = function()
				PluginInstallFrame.SubTitle:SetText('Immersion')
				PluginInstallFrame.Desc1:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				PluginInstallFrame.Desc2:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
				PluginInstallFrame.Option1:SetText(L["Import "]..'Immersion')
				if (not IsAddOnLoaded("Immersion")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Immersion"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Immersion is an addon that changes the quest dialog with npcs"])
					PluginInstallFrame.Desc3:SetText(L["It transforms them into a talking head with dialog options on the side"])
					PluginInstallFrame.Desc4:SetText(L["Including the ability to press number keys to select an option"])
					PluginInstallFrame.Option1:Disable()
				end
			end,
			[9] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Dynamic Cam')
				PluginInstallFrame.Desc1:SetText(L["Import Dynamic Cam profile"])
				PluginInstallFrame.Desc2:SetText(L["It is recommended to copy the profile into Dynamic Cam's Settings"])
				PluginInstallFrame.Desc3:SetText('|cffff0000'..L["Your current settings will be lost with overwrite, please back them up"]..'|r')
				PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
				PluginInstallFrame.Option1:SetText(L["Overwrite"])
				PluginInstallFrame.Option2:Enable()
				PluginInstallFrame.Option2:Show()
				PluginInstallFrame.Option2:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'dmIvbaGnvvZKkYSPGBtQSxSBsPFQs0We)McnuvkgUQWXizPQIwSkPwov1dvv6PkltfpNIAIurnvIPlDrsvpJsxNQSrvQAZQkMgvy0Qu5KQKCAvPRrroVkHltLomP4VQuAuiSh(g)8AWfHz(TEA6RrTMry2yrOmvSiuwowekl5hHYS5GqzXArOS8hekl5GqzQeek7KGqzQCqOSykiuwokekZgfcLLycHYIvHqzNOqOS8RqOSefcLLJdeklMuiuwIdekZMGqz5eekl2GqzQOqOSyDGqPSpV(M7tpTCnL1lE4YC(7T388Y7VYj9mTA05Y0BO(UE6yA86Dg9z6nuFxpDuaa') 	end)
				PluginInstallFrame.Option2:SetText(L["Copy"])
				if (not IsAddOnLoaded("DynamicCam")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText("Dynamic Cam"..L[" is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["DynamicCam is addon that modifies the behavior of the camera"])
					PluginInstallFrame.Desc3:SetText(L["The profile uses some effects while questing"])
					PluginInstallFrame.Desc4:SetText(L["But in instances the effects are disabled"])
					PluginInstallFrame.Option1:Disable()
					PluginInstallFrame.Option2:Disable()
				end
			end,
			[10] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Questie')
				PluginInstallFrame.Desc1:SetText(L["Import Questie profile"])
				PluginInstallFrame.Desc2:SetText(L["You will need to reload and wait for questie to rebuild the database"])
				PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				PluginInstallFrame.Option1:SetText(L["Import "])
				if (not IsAddOnLoaded("Questie")) then
					PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
					PluginInstallFrame.Desc1:SetText(L["Questie is not installed or enabled"])
					PluginInstallFrame.Desc2:SetText(L["Questie is an addon that modifies the objective tracker"])
					PluginInstallFrame.Desc3:SetText(L["As such Questie adds a lot of features to it not available by default"])
					PluginInstallFrame.Desc4:SetText(L["Including TomTom support"])
					PluginInstallFrame.Option1:Disable()
				end
			end,
			[11] = function()
				PluginInstallFrame.SubTitle:SetFormattedText('Discord')
				PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/rBXNxUY6pk') 	end)
				PluginInstallFrame.Option1:SetText('Discord')
			end,
			[12] = function()
				PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
				PluginInstallFrame.Desc1:SetText("You have completed the installation process")
				PluginInstallFrame.Desc2:SetText("Please click Finished to reload the UI")
				PluginInstallFrame.Desc3:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
				PluginInstallFrame.Option1:SetText(L["Finished"])
			end,
		},
		StepTitles = {
			[1] = L["Welcome"],
			--[[[2] = 'ProjectAzilroka',]]--
			[2] = L["Layouts"],
			[3] = L["Fonts"],
			[4] = 'Details',
			[5] = L["Boss Mods"],
			[6] = L["Arenas"],
			[7] = L["Combat Text"],
			[8] = 'Immersion',
			[9] = 'Dynamic Cam',
			[10] = 'Questie',
			[11] = 'Discord',
			[12] = L["Installation Complete"],
		},
		StepTitlesColor = {1, 1, 1},
		StepTitlesColorSelected = {70/255, 130/255, 180/255},
		StepTitleWidth = 200,
		StepTitleButtonWidth = 180,
		StepTitleTextJustification = 'CENTER',
	}
end
