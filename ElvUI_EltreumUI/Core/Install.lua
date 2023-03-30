local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local ReloadUI = _G.ReloadUI
local math = _G.math
local PlaySound = _G.PlaySound
local IsAddOnLoaded = _G.IsAddOnLoaded

-- Set version & reload on "Finished"
local function InstallComplete()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	E.private.ElvUI_EltreumUI.skippedcheck = nil
	ReloadUI()
end

-- Set version & reload on "Skip"
local function SkipInstallComplete()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	if E.private.ElvUI_EltreumUI.skippedcheck then
		E.private.ElvUI_EltreumUI.skippedcheck = nil
		E.private.install_complete = nil --reset so that elvui install pops up again in case they didnt run it
	end
	E.private.ElvUI_EltreumUI.isInstalled.sle = true
	E.private.ElvUI_EltreumUI.isInstalled.windtools = true
	E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
	ReloadUI()
end

--add some stuff to the installer
local function ImproveInstall(installtype,mode,null)
	if null then
		_G.PluginInstallFrame.Option1:SetScript('OnEnter', nil)
		_G.PluginInstallFrame.Option1:SetScript('OnLeave', nil)
		_G.PluginInstallFrame.Option2:SetScript('OnEnter', nil)
		_G.PluginInstallFrame.Option2:SetScript('OnLeave', nil)
		_G.PluginInstallFrame.Option3:SetScript('OnEnter', nil)
		_G.PluginInstallFrame.Option3:SetScript('OnLeave', nil)
		_G.PluginInstallFrame.Option4:SetScript('OnEnter', nil)
		_G.PluginInstallFrame.Option4:SetScript('OnLeave', nil)
	end
	if not installtype and not mode then
		--_G.PluginInstallFrame:SetSize(1024,512)
		if not _G.PluginInstallFrame.gaptexture then
			_G.PluginInstallFrame.gaptexture = _G.PluginInstallFrame:CreateTexture()
			_G.PluginInstallFrame.gaptexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\square_mask.tga")
			_G.PluginInstallFrame.gaptexture:SetVertexColor(0, 0, 0, 1)
			_G.PluginInstallFrame.gaptexture:SetPoint("TOPLEFT", _G.PluginInstallFrame, "TOPRIGHT", 0, 0)
			_G.PluginInstallFrame.gaptexture:SetPoint("BOTTOMLEFT", _G.PluginInstallFrame, "BOTTOMRIGHT",0,0)
			_G.PluginInstallFrame.gaptexture:SetPoint("TOPRIGHT", _G.PluginInstallTitleFrame, "TOPLEFT",0,0)
			_G.PluginInstallFrame.gaptexture:SetPoint("BOTTOMRIGHT", _G.PluginInstallTitleFrame, "BOTTOMLEFT",0,0)
		end
		if not _G.PluginInstallFrame.installpreview then
			_G.PluginInstallFrame.installpreview = _G.PluginInstallFrame:CreateTexture("InstallTexturePreview")
			_G.PluginInstallFrame.installpreview:SetAllPoints(_G.PluginInstallFrame)
			_G.PluginInstallFrame.installpreview:SetTexCoord(0,0.72,0,1)
		else
			_G.PluginInstallFrame.installpreview:SetAllPoints(_G.PluginInstallFrame)
			_G.PluginInstallFrame.installpreview:SetTexCoord(0,0.72,0,1)
		end
	else
		if installtype == "dps" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\DPS.jpg")
		elseif installtype == "healer" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\HEALER.jpg")
		elseif installtype == "alternative" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\alternativeframes.jpg")
		elseif installtype == "lightdark" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\lightdark.jpg")
		elseif installtype == "gradient" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\gradient.jpg")
		elseif installtype == "borders" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\borders.jpg")
		elseif installtype == "backgroundcolors" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\backgroundcolors.jpg")
		elseif installtype == "chattransparent" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\chattransparent.jpg")
		elseif installtype == "chatdark" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\chatdark.jpg")
		elseif installtype == "detailsspec" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\detailsspec.jpg")
		elseif installtype == "detailsreleafalpha" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\detailsreleafalpha.jpg")
		elseif installtype == "detailsreleafsolid" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\detailsreleafsolid.jpg")
		elseif installtype == "gladiusEX" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\gladiusEX.jpg")
		elseif installtype == "gladius" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\gladius.jpg")
		elseif installtype == "gladdy" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\gladdy.jpg")
		elseif installtype == "DBM" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\DBM.jpg")
		elseif installtype == "BigWigs" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\BigWigs.jpg")
		elseif installtype == "BattlegroundEnemies" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\BattlegroundEnemies.jpg")
		elseif installtype == "Capping" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\Capping.jpg")
		elseif installtype == "WarpDeplete" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\WarpDeplete.jpg")
		elseif installtype == "NameplateSCT" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\NameplateSCT.jpg")
		elseif installtype == "ElvUIFCT" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\ElvUIFCT.jpg")
		elseif installtype == "Immersion" then
			_G.PluginInstallFrame.installpreview:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Install\\Immersion.jpg")
		end

		if mode == "ENTERING" then
			UIFrameFadeIn(_G.PluginInstallFrame.installpreview, 0.5, 0, 0.7)
			UIFrameFadeOut(_G.PluginInstallTutorialImage, 0.5, 1, 0)
			UIFrameFadeOut(_G.PluginInstallFrame.Desc1, 0.5, 1, 0)
			UIFrameFadeOut(_G.PluginInstallFrame.Desc2, 0.5, 1, 0)
			UIFrameFadeOut(_G.PluginInstallFrame.Desc3, 0.5, 1, 0)
			UIFrameFadeOut(_G.PluginInstallFrame.Desc4, 0.5, 1, 0)
			UIFrameFadeOut(_G.PluginInstallFrame.SubTitle, 0.5, 1, 0)
		elseif mode == "LEAVING" then
			UIFrameFadeOut(_G.PluginInstallFrame.installpreview, 0.5, 0.7, 0)
			UIFrameFadeIn(_G.PluginInstallTutorialImage, 0.5, 0, 1)
			UIFrameFadeIn(_G.PluginInstallFrame.Desc1, 0.5, 0, 1)
			UIFrameFadeIn(_G.PluginInstallFrame.Desc2, 0.5, 0, 1)
			UIFrameFadeIn(_G.PluginInstallFrame.Desc3, 0.5, 0, 1)
			UIFrameFadeIn(_G.PluginInstallFrame.Desc4, 0.5, 0, 1)
			UIFrameFadeIn(_G.PluginInstallFrame.SubTitle, 0.5, 0, 1)
		end

	end
end

-- Installer Steps
ElvUI_EltreumUI.InstallerData = {
	Title = ElvUI_EltreumUI.Name,
	Name = ElvUI_EltreumUI.Name,
	tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
	Pages = {
		[1] = function()
			ImproveInstall()

			--hide on other plugins
			if _G.PluginInstallFrame then
				_G.PluginInstallFrame:HookScript("OnShow", function()
					if _G.PluginInstallFrame.Title then
						if _G.PluginInstallFrame.Title:GetText() ~= ElvUI_EltreumUI.Name then
							ImproveInstall(nil,nil,true)
						end
					end
				end)
			end

			ElvUI_EltreumUI:HidePopups(0.1)
			if not _G.PluginInstallFrame.shadow then
				_G.PluginInstallFrame:CreateShadow()
				_G.PluginInstallFrame.shadow:SetPoint("TOPLEFT", _G.PluginInstallFrame, "TOPLEFT",-3,3)
				_G.PluginInstallFrame.shadow:SetPoint("BOTTOMLEFT", _G.PluginInstallFrame, "BOTTOMLEFT",-3,-3)
				_G.PluginInstallFrame.shadow:SetPoint("TOPRIGHT", _G.PluginInstallTitleFrame, "TOPRIGHT",3,3)
				_G.PluginInstallFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PluginInstallTitleFrame, "BOTTOMRIGHT",3,-3)
			end
			ElvUI_EltreumUI:ElvUIVersionCheck()
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["Welcome"])
			_G.PluginInstallFrame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
			_G.PluginInstallFrame.Desc2:SetText(L["Please read the instructions to avoid issues"])
			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript("OnClick", SkipInstallComplete)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option1:SetText(L["Skip Install"])
		end,
		[2] = function()
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

			_G.PluginInstallFrame.SubTitle:SetText(L["Layouts"])
			_G.PluginInstallFrame.Desc1:SetText(L["Please select the role for your character, which will create a new profile.\nThis process can take a few seconds"])
			--_G.PluginInstallFrame.Desc2:SetText(L["Eltruism uses a 0.7 scale, but ElvUI can calculate the best scale for you using the Automatic Scale option"].." ("..((math.floor(E:PixelBestSize()*100))/100)..")")
			if E.myclass == 'PRIEST' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'SHAMAN' or E.myclass == 'PALADIN' or E.myclas == 'EVOKER' then
				_G.PluginInstallFrame.Desc2:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alternative Frames after clicking DPS/Tank"]..'|r')
			end
			if IsAddOnLoaded("Plater") or IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Kui_Nameplates") or IsAddOnLoaded("TidyPlates_ThreatPlates") then
				_G.PluginInstallFrame.Desc3:SetText('|cFFFF0000'..L["You have another Nameplate Addon installed and loaded, and many nameplate features will not work with it"]..'|r')
				_G.PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
			else
				_G.PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
			end

			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function()
				E:SetupChat()
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
				ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])
				ElvUI_EltreumUI:AddonSetupPA()
				if (E.Wrath or E.Retail) and E.data:IsDualSpecEnabled() then
					E.data:SetDualSpecProfile('Eltreum DPS/Tank ('..E.mynameRealm..')', E.Libs.DualSpec.currentSpec)
				else
					E.data:SetProfile('Eltreum DPS/Tank ('..E.mynameRealm..')')
				end
				ElvUI_EltreumUI:SetupGeneralLayout()
				ElvUI_EltreumUI:SetupLayoutDPS()
				ElvUI_EltreumUI:SetupNamePlates()
				ElvUI_EltreumUI:ResolutionOutline()
				ElvUI_EltreumUI:UpdateEltruismSettings()
				PlaySound(888)
			end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("dps","ENTERING") end)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING")end)
			_G.PluginInstallFrame.Option1:SetText(L["DPS\nTank"])

			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function()
				E:SetupChat()
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
				ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])
				ElvUI_EltreumUI:AddonSetupPA()
				if (E.Wrath or E.Retail) and E.data:IsDualSpecEnabled() then
					E.data:SetDualSpecProfile('Eltreum Healer ('..E.mynameRealm..')', E.Libs.DualSpec.currentSpec)
				else
					E.data:SetProfile('Eltreum Healer ('..E.mynameRealm..')')
				end
				ElvUI_EltreumUI:SetupGeneralLayout()
				ElvUI_EltreumUI:SetupLayoutHealer()
				ElvUI_EltreumUI:SetupNamePlates()
				ElvUI_EltreumUI:ResolutionOutline()
				ElvUI_EltreumUI:UpdateEltruismSettings()
				PlaySound(888)
			end)
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("healer","ENTERING") end)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option2:SetText(L["Healer"])

			if E.myclass == 'PRIEST' or E.myclass == 'DRUID' or E.myclass == 'MONK' or E.myclass == 'SHAMAN' or E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' or E.myclass == 'EVOKER' then
				_G.PluginInstallFrame.Option3:SetText(L["Alternative\nFrames"])
				_G.PluginInstallFrame.Option3:Enable()
				_G.PluginInstallFrame.Option3:Show()
				_G.PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				_G.PluginInstallFrame.Option3:SetScript('OnEnter', function() ImproveInstall("alternative","ENTERING") end)
				_G.PluginInstallFrame.Option3:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			end
		end,
		[3] = function()
			_G.PluginInstallOption1ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallOption2ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallOption3ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallOption4ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["Eltruism Modes"])
			_G.PluginInstallFrame.Desc1:SetText(L["Eltruism uses Dark Mode by default"])
			_G.PluginInstallFrame.Desc2:SetText(L["You can switch to Light Mode or Gradient Mode by clicking the buttons below"])
			_G.PluginInstallFrame.Desc3:SetText(L["You can customize the textures and colors in Eltruism > Unitframes"])
			_G.PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')

			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:ColorModes() end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("lightdark","ENTERING") end)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option1:SetText(L["Light Mode"].."\n"..L["Dark Mode"])

			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function()
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
					E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable = false
					E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = false
					E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower = false
					E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture = true
					E:UpdateMediaItems()
					E:UpdateUnitFrames()

					ElvUI_EltreumUI:Print("Gradient Mode Disabled")
				else
					ElvUI_EltreumUI:GradientMode()
				end
			end)
			_G.PluginInstallFrame.Option2:SetText(L["Gradient Mode"])
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("gradient","ENTERING") end)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)

			_G.PluginInstallFrame.Option3:Enable()
			_G.PluginInstallFrame.Option3:Show()
			_G.PluginInstallFrame.Option3:SetScript('OnClick', function()
				ElvUI_EltreumUI:BorderAdjust()
				ElvUI_EltreumUI:AuraBorders()
				ElvUI_EltreumUI:ShowHideBorders(true)
			end)
			_G.PluginInstallFrame.Option3:SetScript('OnEnter', function() ImproveInstall("borders","ENTERING") end)
			_G.PluginInstallFrame.Option3:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option3:SetText(L["Borders"])


			_G.PluginInstallFrame.Option4:Enable()
			_G.PluginInstallFrame.Option4:Show()
			_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:CheckBackground() end)
			_G.PluginInstallFrame.Option4:SetScript('OnEnter', function() ImproveInstall("backgroundcolors","ENTERING") end)
			_G.PluginInstallFrame.Option4:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option4:SetText(L["Background"].."\n"..L["Color"])
		end,
		[4] = function()
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["Fonts"])
			_G.PluginInstallFrame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
			_G.PluginInstallFrame.Desc2:SetText(L["You can replace it with one of the following:"])
			_G.PluginInstallFrame.Desc3:SetText(L["Or change it later in Eltruism > Media options"])
			_G.PluginInstallFrame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')
			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("Roboto") end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option1:SetText('Roboto')
			_G.PluginInstallOption1ButtonText:SetFont('Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\Roboto-Bold.TTF', 12, E.db.general.fontStyle)
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("Exo2 Extra Bold") end)
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option2:SetText('Exo2')
			_G.PluginInstallOption2ButtonText:SetFont('Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\Exo2-ExtraBold.TTF', 12, E.db.general.fontStyle)
			_G.PluginInstallFrame.Option3:Show()
			_G.PluginInstallFrame.Option3:Enable()
			_G.PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("GothamNarrow Black") end)
			_G.PluginInstallFrame.Option3:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option3:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option3:SetText('Gotham')
			_G.PluginInstallOption3ButtonText:SetFont('Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\GothamNarrowBlack.TTF', 12, E.db.general.fontStyle)
			_G.PluginInstallFrame.Option4:Show()
			_G.PluginInstallFrame.Option4:Enable()
			_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("AR CrystalzcuheiGBK Demibold") end)
			_G.PluginInstallFrame.Option4:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option4:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option4:SetText('Crystalzcuhei')
			_G.PluginInstallOption4ButtonText:SetFont("Fonts\\ARHei.TTF", 12, E.db.general.fontStyle)
		end,
		[5] = function()
			_G.PluginInstallOption1ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallOption2ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallOption3ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallOption4ButtonText:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
			_G.PluginInstallFrame.SubTitle:SetFormattedText(CHAT_LABEL)
			_G.PluginInstallFrame.Desc1:SetText(L["Eltruism uses Transparent chat by default"])
			_G.PluginInstallFrame.Desc2:SetText(L["You can switch to Dark Chat by clicking the buttons below"])
			_G.PluginInstallFrame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')

			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:TransparentChat() end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("chattransparent","ENTERING") end)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option1:SetText(L["Transparent\nChat"])

			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:DarkChat() end)
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("chatdark","ENTERING") end)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option2:SetText(L["Dark Chat"])
		end,
		[6] = function()
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["Details! DPS Meter"])
			_G.PluginInstallFrame.Desc1:SetText(L["Import Details! profile with dual panels"])
			_G.PluginInstallFrame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
			_G.PluginInstallFrame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
			_G.PluginInstallFrame.Desc4:SetText(L["Choose the type of icons Details! will use:"])

			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT() ElvUI_EltreumUI:GetASProfile() end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("detailsspec","ENTERING") end)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			if E.Retail then
				_G.PluginInstallFrame.Option1:SetText('Spec')
			elseif E.Classic or E.Wrath then
				_G.PluginInstallFrame.Option1:SetText('Blizzard')
			end

			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleaf() ElvUI_EltreumUI:GetASProfile() end)
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("detailsreleafalpha","ENTERING") end)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option2:SetText('Releaf Alpha')

			_G.PluginInstallFrame.Option3:Enable()
			_G.PluginInstallFrame.Option3:Show()
			_G.PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDTReleafv3() ElvUI_EltreumUI:GetASProfile() end)
			_G.PluginInstallFrame.Option3:SetScript('OnEnter', function() ImproveInstall("detailsreleafsolid","ENTERING") end)
			_G.PluginInstallFrame.Option3:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option3:SetText('Releaf Solid')
			if (not IsAddOnLoaded("Details")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc1:SetText("Details"..L[" is not installed or enabled"])
				_G.PluginInstallFrame.Desc2:SetText(L["Details is an advanced combat parser"])
				_G.PluginInstallFrame.Desc3:SetText(L["It has many plugins to choose from"])
				_G.PluginInstallFrame.Option1:Disable()
				_G.PluginInstallFrame.Option2:Disable()
				_G.PluginInstallFrame.Option3:Disable()
			end
		end,
		[7] = function()
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["PVP/PVE Addons"])
			if E.Retail then
				_G.PluginInstallFrame.Desc1:SetText(L["Import GladiusEx profile for arenas, remember to disable ElvUI Arena Frames"])
				_G.PluginInstallFrame.Option1:Enable()
				_G.PluginInstallFrame.Option1:Show()
				_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupGladiusEx() end)
				_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("gladiusEX","ENTERING") end)
				_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
				_G.PluginInstallFrame.Option1:SetText(L["GladiusEx"])
			elseif E.Classic or E.Wrath then
				_G.PluginInstallFrame.Desc1:SetText(L["Import Questie profile, which uses the DBM radar"])
				_G.PluginInstallFrame.Option1:Enable()
				_G.PluginInstallFrame.Option1:Show()
				_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				_G.PluginInstallFrame.Option1:SetScript('OnEnter', nil)
				_G.PluginInstallFrame.Option1:SetScript('OnLeave', nil)
				_G.PluginInstallFrame.Option1:SetText(L["Questie"])
			end
			_G.PluginInstallFrame.Desc2:SetText(L["Import DBM or BigWigs profiles for dungeons and raids. (Uses DBM English Calanon and Bigwigs Voice)"])
			if E.Wrath then
				if IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Desc3:SetText(L["Import profiles for Gladdy"])
				elseif IsAddOnLoaded("Gladius") and IsAddOnLoaded("Gladdy") then
					_G.PluginInstallFrame.Desc3:SetText(L["Import profiles for Gladdy (Gladius can be found in Eltruism settings)"])
				elseif not IsAddOnLoaded("Gladdy") and IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Desc3:SetText(L["Import profiles for Gladius"])
				elseif not IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Desc3:SetText(L["Gladdy and Gladius are not installed or enabled"])
				end
			end
			_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')

			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("DBM","ENTERING") end)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option2:SetText('DBM')

			_G.PluginInstallFrame.Option3:Enable()
			_G.PluginInstallFrame.Option3:Show()
			_G.PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
			_G.PluginInstallFrame.Option3:SetScript('OnEnter', function() ImproveInstall("BigWigs","ENTERING") end)
			_G.PluginInstallFrame.Option3:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option3:SetText('BigWigs')
			if E.Wrath then
				_G.PluginInstallFrame.Option4:Enable()
				_G.PluginInstallFrame.Option4:Show()
				if IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					_G.PluginInstallFrame.Option4:SetScript('OnEnter', function() ImproveInstall("gladdy","ENTERING") end)
					_G.PluginInstallFrame.Option4:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
					_G.PluginInstallFrame.Option4:SetText('Gladdy')
				elseif IsAddOnLoaded("Gladdy") and IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					_G.PluginInstallFrame.Option4:SetScript('OnEnter', function() ImproveInstall("gladdy","ENTERING") end)
					_G.PluginInstallFrame.Option4:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
					_G.PluginInstallFrame.Option4:SetText('Gladdy')
				elseif not IsAddOnLoaded("Gladdy") and IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladius() end)
					_G.PluginInstallFrame.Option4:SetScript('OnEnter', function() ImproveInstall("gladius","ENTERING") end)
					_G.PluginInstallFrame.Option4:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
					_G.PluginInstallFrame.Option4:SetText('Gladius')
				elseif not IsAddOnLoaded("Gladdy") and not IsAddOnLoaded("Gladius") then
					_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					_G.PluginInstallFrame.Option4:SetScript('OnEnter', function() ImproveInstall("gladdy","ENTERING") end)
					_G.PluginInstallFrame.Option4:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
					_G.PluginInstallFrame.Option4:SetText('Gladdy')
				end
			end
			if (not IsAddOnLoaded("Questie")) and (E.Classic or E.Wrath) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc1:SetText(L["Questie is not installed or enabled"])
				_G.PluginInstallFrame.Option1:Disable()
			end
			if (not IsAddOnLoaded("GladiusEx")) and E.Retail then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc1:SetText("GladiusEx"..L[" is not installed or enabled"])
				_G.PluginInstallFrame.Option1:Disable()
			end
			if (not IsAddOnLoaded("DBM-Core")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc2:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
				_G.PluginInstallFrame.Option2:Disable()
			end
			if (not IsAddOnLoaded("BigWigs")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc2:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
				_G.PluginInstallFrame.Option3:Disable()
			end
			if (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc2:SetText(L["Both DBM and BigWigs are not installed or enabled"])
				_G.PluginInstallFrame.Option2:Disable()
				_G.PluginInstallFrame.Option3:Disable()
			end
			if not IsAddOnLoaded("Gladdy") and (E.Wrath) and not IsAddOnLoaded("Gladius") then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc3:SetText(L["Both Gladdy and Gladius are not installed or enabled"])
				_G.PluginInstallFrame.Option4:Disable()
			end
			if E.Retail and ((not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) and (not IsAddOnLoaded("GladiusEx"))) then
				_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
			if E.Classic and ((not IsAddOnLoaded("Questie")) and (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs"))) then
				_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
			if (E.Wrath) and ((not IsAddOnLoaded("Questie")) and (not IsAddOnLoaded("DBM-Core")) and (not IsAddOnLoaded("BigWigs")) and (not IsAddOnLoaded("Gladdy")) and (not IsAddOnLoaded("Gladius"))) then
				_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
		end,
		[8] = function()
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["PVP/PVE Addons"].." 2")
			if IsAddOnLoaded("BattleGroundEnemies") then
				_G.PluginInstallFrame.Desc1:SetText(L["Import BattlegroundEnemies profile for battlegrounds"])
				_G.PluginInstallFrame.Option1:Enable()
				_G.PluginInstallFrame.Option1:Show()
				_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:GetBattleGroundEnemiesProfile() end)
				_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("BattlegroundEnemies","ENTERING") end)
				_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
				_G.PluginInstallFrame.Option1:SetText("Battleground\nEnemies")
			else
				_G.PluginInstallFrame.Desc1:SetText(L["BattlegroundEnemies is not installed or enabled"])
				_G.PluginInstallFrame.Option1:Disable()
				_G.PluginInstallFrame.Option1:Show()
				_G.PluginInstallFrame.Option1:SetText("Battleground\nEnemies")
			end
			if IsAddOnLoaded("Capping") then
				_G.PluginInstallFrame.Desc2:SetText(L["Import Capping profile for battlegrounds"])
				_G.PluginInstallFrame.Option2:Enable()
				_G.PluginInstallFrame.Option2:Show()
				_G.PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:GetCappingProfile() end)
				_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("Capping","ENTERING") end)
				_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
				_G.PluginInstallFrame.Option2:SetText("Capping")
			else
				_G.PluginInstallFrame.Desc2:SetText(L["Capping is not installed or enabled"])
				_G.PluginInstallFrame.Option2:Disable()
				_G.PluginInstallFrame.Option2:Show()
				_G.PluginInstallFrame.Option2:SetText("Capping")
			end
			if E.Retail then
				if IsAddOnLoaded("WarpDeplete") then
					_G.PluginInstallFrame.Desc3:SetText(L["Import WarpDeplete profile for Mythic Plus"]..", "..L["WarpDeplete profile requires an import per class in order to have the correct texture"])
					_G.PluginInstallFrame.Option3:Enable()
					_G.PluginInstallFrame.Option3:Show()
					_G.PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:GetWarpDepleteProfile() end)
					_G.PluginInstallFrame.Option3:SetScript('OnEnter', function() ImproveInstall("WarpDeplete","ENTERING") end)
					_G.PluginInstallFrame.Option3:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
					_G.PluginInstallFrame.Option3:SetText(L["WarpDeplete"])
				else
					_G.PluginInstallFrame.Desc3:SetText(L["WarpDeplete is not installed or enabled"])
					_G.PluginInstallFrame.Option3:Disable()
					_G.PluginInstallFrame.Option3:Show()
					_G.PluginInstallFrame.Option3:SetText(L["WarpDeplete"])
				end
			end
			if not ( IsAddOnLoaded("WarpDeplete") or IsAddOnLoaded("Capping") or IsAddOnLoaded("BattleGroundEnemies") ) then
				_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			else
				_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')
			end
		end,
		[9] = function()
			_G.PluginInstallFrame.SubTitle:SetFormattedText(L["QOL Addons"])
			_G.PluginInstallFrame.Desc1:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
			_G.PluginInstallFrame.Desc2:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
			_G.PluginInstallFrame.Desc3:SetText(L["Import Dynamic Cam profile"])
			_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')
			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupNameplateSCT() end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', function() ImproveInstall("NameplateSCT","ENTERING") end)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option1:SetText('NameplateSCT')

			_G.PluginInstallFrame.Option2:Enable()
			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupFCT() end)
			_G.PluginInstallFrame.Option2:SetScript('OnEnter', function() ImproveInstall("ElvUIFCT","ENTERING") end)
			_G.PluginInstallFrame.Option2:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option2:SetText('ElvUI FCT')

			_G.PluginInstallFrame.Option3:Enable()
			_G.PluginInstallFrame.Option3:Show()
			_G.PluginInstallFrame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
			_G.PluginInstallFrame.Option3:SetScript('OnEnter', function() ImproveInstall("Immersion","ENTERING") end)
			_G.PluginInstallFrame.Option3:SetScript('OnLeave', function() ImproveInstall(nil,"LEAVING") end)
			_G.PluginInstallFrame.Option3:SetText('Immersion')

			_G.PluginInstallFrame.Option4:Enable()
			_G.PluginInstallFrame.Option4:Show()
			_G.PluginInstallFrame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
			_G.PluginInstallFrame.Option4:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option4:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option4:SetText(L["DynamicCam"])

			if (not IsAddOnLoaded("NameplateSCT")) and IsAddOnLoaded("ElvUI_FCT") then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc1:SetText(L["Import a profile for Simpy's ElvUI FCT configured for Eltruism"])
				_G.PluginInstallFrame.Option1:Disable()
			end
			if (not IsAddOnLoaded("ElvUI_FCT")) and IsAddOnLoaded("NameplateSCT") then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc1:SetText(L["Import a profile for NameplateSCT configured for Eltruism"])
				_G.PluginInstallFrame.Option2:Disable()
			end
			if (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc1:SetText(L["NameplateSCT and ElvUI FCT are not installed or enabled"])
				_G.PluginInstallFrame.Option1:Disable()
				_G.PluginInstallFrame.Option2:Disable()
			end
			if (not IsAddOnLoaded("Immersion")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc2:SetText("Immersion"..L[" is not installed or enabled"])
				_G.PluginInstallFrame.Option3:Disable()
			end
			if (not IsAddOnLoaded("DynamicCam")) then
				_G.PluginInstallFrame.SubTitle:SetFormattedText("|cffff0000"..L["WARNING"])
				_G.PluginInstallFrame.Desc3:SetText("Dynamic Cam"..L[" is not installed or enabled"])
				_G.PluginInstallFrame.Option4:Disable()
			end
			if (not IsAddOnLoaded("DynamicCam")) and (not IsAddOnLoaded("Immersion")) and (not IsAddOnLoaded("ElvUI_FCT")) and (not IsAddOnLoaded("NameplateSCT")) then
				_G.PluginInstallFrame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
		end,
		[10] = function()
			_G.PluginInstallFrame.SubTitle:SetFormattedText('Discord')
			_G.PluginInstallFrame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/rBXNxUY6pk')  end)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option1:SetText('Discord')
		end,
		[11] = function()
			_G.PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
			_G.PluginInstallFrame.Desc1:SetText(L["You have completed the installation process"])
			_G.PluginInstallFrame.Desc2:SetText(L["Feel free to explore Eltruism settings in ElvUI > Eltruism.\nThere are lot of settings that are disabled by default."])
			_G.PluginInstallFrame.Desc3:SetText(L["Please click Finished to reload the UI"])
			_G.PluginInstallFrame.Desc4:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
			_G.PluginInstallFrame.Option1:Enable()
			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
			_G.PluginInstallFrame.Option1:SetScript('OnEnter', nil)
			_G.PluginInstallFrame.Option1:SetScript('OnLeave', nil)
			_G.PluginInstallFrame.Option1:SetText(L["Finished"])
		end,
	},
	StepTitles = {
		[1] = L["Welcome"],
		[2] = L["Layouts"],
		[3] = L["Eltruism Modes"],
		[4] = L["Fonts"],
		[5] = CHAT_LABEL,
		[6] = L["Details! DPS Meter"],
		[7] = L["PVP/PVE Addons"],
		[8] = L["PVP/PVE Addons"].." 2",
		[9] = L["QOL Addons"],
		[10] = 'Discord',
		[11] = L["Installation Complete"],
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {0.50, 0.70, 1},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = 'RIGHT',
}
