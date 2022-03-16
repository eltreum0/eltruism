local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Set version & reload on "Skip" and "Finished"
local function InstallComplete()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	ReloadUI()
end

-- Installer Steps
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
			PluginInstallOption1ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallOption2ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallOption3ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallOption4ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallFrame.SubTitle:SetText(L["Layouts"])
			PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile.\nThis process can take a few seconds"])
			PluginInstallFrame.Desc2:SetText(L["Eltruism uses a 0.7 scale, but ElvUI can calculate the best scale for you using the Automatic Scale option"].." ("..((math.floor(E:PixelBestSize()*100))/100)..")")
			if E.myclass == 'PRIEST' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'SHAMAN' or E.myclass == 'PALADIN' then
				PluginInstallFrame.Desc3:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alternative Frames after clicking DPS/Tank"]..'|r')
			end
			PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function()
				E:SetupChat()
				ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])
				ElvUI_EltreumUI:AddonSetupPA()
				E.data:SetProfile('Eltreum DPS/Tank ('..E.mynameRealm..')')
				ElvUI_EltreumUI:SetupGeneralLayout()
				ElvUI_EltreumUI:SetupLayoutDPS()
				ElvUI_EltreumUI:SetupNamePlates('ElvUI')
				ElvUI_EltreumUI:ResolutionOutline()
			end)
			PluginInstallFrame.Option1:SetText(L['DPS\nTank'])
			PluginInstallFrame.Option2:Enable()
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function()
				E:SetupChat()
				ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])
				ElvUI_EltreumUI:AddonSetupPA()
				E.data:SetProfile('Eltreum Healer ('..E.mynameRealm..')')
				ElvUI_EltreumUI:SetupGeneralLayout()
				ElvUI_EltreumUI:SetupLayoutHealer()
				ElvUI_EltreumUI:SetupNamePlates('ElvUI')
				ElvUI_EltreumUI:ResolutionOutline()
			end)
			PluginInstallFrame.Option2:SetText(L['Healer'])
			PluginInstallFrame.Option3:SetText(L['Automatic\nScale'])
			PluginInstallFrame.Option3:Enable()
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AutoScale() end)
			if E.myclass == 'PRIEST' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'SHAMAN' or E.myclass == 'PALADIN' then
				PluginInstallFrame.Option4:SetText(L['Alternative\nFrames'])
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
			end
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText(L["Fonts"])
			PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
			PluginInstallFrame.Desc2:SetText(L["You can replace it with one of the following:"])
			PluginInstallFrame.Desc3:SetText(L["Or change it later in Eltruism > Media options"])
			PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsRoboto() end)
			--PluginInstallFrame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\roboto:14:112:0:1:128:64:0:128:0:16|t')
			PluginInstallFrame.Option1:SetText('Roboto')
			PluginInstallOption1ButtonText:SetFont('Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\Roboto-Bold.TTF', 12, E.db.general.fontStyle)
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:Enable()
			PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsExo2() end)
			PluginInstallFrame.Option2:SetText('Exo2')
			PluginInstallOption2ButtonText:SetFont('Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\Exo2-ExtraBold.TTF', 12, E.db.general.fontStyle)
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:Enable()
			PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsGotham() end)
			PluginInstallFrame.Option3:SetText('Gotham')
			PluginInstallOption3ButtonText:SetFont('Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\GothamNarrowBlack.TTF', 12, E.db.general.fontStyle)
			PluginInstallFrame.Option4:Show()
			PluginInstallFrame.Option4:Enable()
			PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFontsCrystalzcuhei() end)
			PluginInstallFrame.Option4:SetText('Crystalzcuhei')
			PluginInstallOption4ButtonText:SetFont("Fonts\\ARHei.TTF", 12, E.db.general.fontStyle)
		end,
		[4] = function()
			PluginInstallOption1ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallOption2ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallOption3ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallOption4ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			PluginInstallFrame.SubTitle:SetFormattedText(L["Eltruism Modes"])
			PluginInstallFrame.Desc1:SetText(L["Eltruism uses Dark Mode by default"])
			PluginInstallFrame.Desc2:SetText(L["You can switch to Light Mode or Gradient Mode by clicking the buttons below"])
			PluginInstallFrame.Desc3:SetText(L["You can customize the textures and colors in Eltruism > Unitframes"])
			PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
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
			PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:GradientMode() end)
			PluginInstallFrame.Option3:SetText(L["Gradient Mode"])
		end,
		[5] = function()
			PluginInstallFrame.SubTitle:SetFormattedText(L["Chat"])
			PluginInstallFrame.Desc1:SetText(L["Eltruism uses Transparent chat by default"])
			PluginInstallFrame.Desc2:SetText(L["You can switch to Dark Chat by clicking the buttons below"])
			PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:TransparentChat() end)
			PluginInstallFrame.Option1:SetText(L["Transparent\nChat"])
			PluginInstallFrame.Option2:Enable()
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:DarkChat() end)
			PluginInstallFrame.Option2:SetText(L["Dark Chat"])
		end,
		[6] = function()
			PluginInstallFrame.SubTitle:SetFormattedText(L['Details! DPS Meter'])
			PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
			PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
			PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
			PluginInstallFrame.Desc4:SetText(L['Choose the type of icons Details! will use:'])
			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
			if E.Retail then
				PluginInstallFrame.Option1:SetText('Spec')
			elseif E.Classic or E.TBC then
				PluginInstallFrame.Option1:SetText('Blizzard')
			end
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
				PluginInstallFrame.Desc3:SetText(L["It has many plugins to choose from"])
				PluginInstallFrame.Option1:Disable()
				PluginInstallFrame.Option2:Disable()
				PluginInstallFrame.Option3:Disable()
			end
		end,
		[7] = function()
			PluginInstallFrame.SubTitle:SetFormattedText(L['PVP/PVE Addons'])
			if E.Retail then
				PluginInstallFrame.Desc1:SetText(L["Import GladiusEx profile for arenas, remember to disable ElvUI Arena Frames"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupGladiusEx() end)
				PluginInstallFrame.Option1:SetText(L['GladiusEx'])
			elseif E.Classic or E.TBC then
				PluginInstallFrame.Desc1:SetText(L["Import Questie profile, which uses the DBM radar"])
				PluginInstallFrame.Option1:Enable()
				PluginInstallFrame.Option1:Show()
				PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				PluginInstallFrame.Option1:SetText(L["Questie"])
			end
			PluginInstallFrame.Desc2:SetText(L["Import DBM or BigWigs profiles for dungeons and raids. (Uses DBM English Calanon and Bigwigs Voice)"])
			if E.Retail then
				PluginInstallFrame.Desc3:SetText(L["Import Method Raid Tools profile with raid cooldowns and other settings"])
			elseif E.TBC then
				if IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Desc3:SetText(L["Import profiles for Gladdy"])
				elseif IsAddOnLoaded("Gladius") and IsAddOnLoaded("Gladdy") then
					PluginInstallFrame.Desc3:SetText(L["Import profiles for Gladdy (Gladius can be found in Eltruism settings)"])
				elseif not IsAddOnLoaded("Gladdy") and IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Desc3:SetText(L["Import profiles for Gladius"])
				elseif not IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Desc3:SetText(L["Gladdy and Gladius are not installed or enabled"])
				end
			end
			PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')
			PluginInstallFrame.Option2:Enable()
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
			PluginInstallFrame.Option2:SetText('DBM')
			PluginInstallFrame.Option3:Enable()
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
			PluginInstallFrame.Option3:SetText('BigWigs')
			if E.Retail then
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:Show()
				PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupMRT() end)
				PluginInstallFrame.Option4:SetText(L["Method\nRaid Tools"])
			elseif E.TBC then
				PluginInstallFrame.Option4:Enable()
				PluginInstallFrame.Option4:Show()
				if IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					PluginInstallFrame.Option4:SetText('Gladdy')
				elseif IsAddOnLoaded("Gladdy") and IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					PluginInstallFrame.Option4:SetText('Gladdy')
				elseif not IsAddOnLoaded("Gladdy") and IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladius() end)
					PluginInstallFrame.Option4:SetText('Gladius')
				elseif not IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					PluginInstallFrame.Option4:SetText('Gladdy')
				end
			end
			if (not IsAddOnLoaded("Questie")) and (E.Classic or E.TBC) then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText(L["Questie is not installed or enabled"])
				PluginInstallFrame.Option1:Disable()
			end
			if (not IsAddOnLoaded("GladiusEx")) and E.Retail then
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
			if (not IsAddOnLoaded("MRT")) and E.Retail then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc3:SetText(L["Method Raid Tools"]..L[" is not installed or enabled"])
				PluginInstallFrame.Option4:Disable()
			end
			if not IsAddOnLoaded("Gladdy") and E.TBC and not IsAddOnLoaded("Gladius") then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc3:SetText(L["Both Gladdy and Gladius are not installed or enabled"])
				PluginInstallFrame.Option4:Disable()
			end
			if E.Retail and ((not IsAddOnLoaded("MRT")) and (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) and (not IsAddOnLoaded("GladiusEx"))) then
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
			if E.Classic and ((not IsAddOnLoaded("Questie")) and (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs"))) then
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
			if E.TBC and ((not IsAddOnLoaded("Questie")) and (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) and (not IsAddOnLoaded("Gladdy")) and (not IsAddOnLoaded("Gladius"))) then
				PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
		end,
		[8] = function()
			PluginInstallFrame.SubTitle:SetFormattedText(L["QOL Addons"])
			PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
			PluginInstallFrame.Desc2:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
			PluginInstallFrame.Desc3:SetText(L["Import Dynamic Cam profile"])
			PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')
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
			if (not IsAddOnLoaded("NameplateSCT")) and IsAddOnLoaded("ElvUI_FCT") then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText(L["Import a profile for Simpy's ElvUI FCT configured for Eltruism"])
				PluginInstallFrame.Option1:Disable()
			end
			if (not IsAddOnLoaded("ElvUI_FCT")) and IsAddOnLoaded("NameplateSCT") then
				PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				PluginInstallFrame.Desc1:SetText(L["Import a profile for NameplateSCT configured for Eltruism"])
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
		[9] = function()
			PluginInstallFrame.SubTitle:SetFormattedText('Discord')
			PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
			PluginInstallFrame.Option1:Enable()
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/rBXNxUY6pk') 	end)
			PluginInstallFrame.Option1:SetText('Discord')
		end,
		[10] = function()
			PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
			PluginInstallFrame.Desc1:SetText(L["You have completed the installation process"])
			PluginInstallFrame.Desc2:SetText(L["Feel free to explore Eltruism settings in ElvUI > Eltruism. There are lot of settings that are disabled by default."])
			PluginInstallFrame.Desc3:SetText(L["Please click Finished to reload the UI"])
			PluginInstallFrame.Desc4:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
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
		[4] = L['Eltruism Modes'],
		[5] = L['Chat'],
		[6] = L['Details! DPS Meter'],
		[7] = L["PVP/PVE Addons"],
		[8] = L["QOL Addons"],
		[9] = 'Discord',
		[10] = L["Installation Complete"],
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {70/255, 130/255, 180/255},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = 'RIGHT',
}
