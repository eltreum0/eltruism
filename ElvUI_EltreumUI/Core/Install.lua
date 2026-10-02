local E, L = unpack(ElvUI)
local _G = _G
local ReloadUI = _G.ReloadUI
local PlaySound = _G.PlaySound
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut
local hooksecurefunc = _G.hooksecurefunc
local Enum = _G.Enum
local CHAT_LABEL = _G.CHAT_LABEL
local string = _G.string
local stringlen = string.len
local stringlower = string.lower
local stringformat = string.format
local type = _G.type
local C_EditMode = _G.C_EditMode
local tonumber = _G.tonumber
local ChatFrame_RemoveChannel = _G.ChatFrame_RemoveChannel or _G.ChatFrameMixin.RemoveChannel
local FCF_OpenNewWindow = _G.FCF_OpenNewWindow
local ChatFrame_RemoveAllMessageGroups = _G.ChatFrame_RemoveAllMessageGroups or _G.ChatFrameMixin.RemoveAllMessageGroups
local FCF_SetWindowName = _G.FCF_SetWindowName
local FCFTab_UpdateColors = _G.FCFTab_UpdateColors
local FCFDock_SelectWindow = _G.FCFDock_SelectWindow
local W
local DisableAddOn = _G.C_AddOns and _G.C_AddOns.DisableAddOn
local unpack = _G.unpack

local installPreviews = {
	dps = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\DPS.jpg",
	healer = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\HEALER.jpg",
	thin = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\THIN.jpg",
	alternative = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\alternativeframes.jpg",
	lightdark = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\lightdark.jpg",
	gradient = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\gradient.jpg",
	borders = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\borders.jpg",
	backgroundcolors = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\backgroundcolors.jpg",
	chattransparent = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\chattransparent.jpg",
	chatdark = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\chatdark.jpg",
	detailsspec = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\detailsspec.jpg",
	detailsreleafalpha = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\detailsreleafalpha.jpg",
	detailsreleafsolid = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\detailsreleafsolid.jpg",
	gladdy = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\gladdy.jpg",
	DBM = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\DBM.jpg",
	BigWigs = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\BigWigs.jpg",
	WarpDeplete = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\WarpDeplete.jpg",
	NameplateSCT = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\NameplateSCT.jpg",
	ElvUIFCT = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\ElvUIFCT.jpg",
	Immersion = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Install\\Immersion.jpg",
}

local lfgChannels = {
	enUS = "LookingForGroup",
	deDE = "SucheNachGruppe",
	esMX = "BuscarGrupo",
	esES = "BuscarGrupo",
	frFR = "RechercheDeGroupe",
	ruRU = "ПоискСпутников",
	zhTW = "尋求組隊",
	zhCN = "寻求组队",
}

local supportClasses = {
	PRIEST = true,
	DRUID = true,
	MONK = true,
	SHAMAN = true,
	PALADIN = true,
	EVOKER = true,
}

local altFrameClasses = {
	PRIEST = true,
	DRUID = true,
	MONK = true,
	SHAMAN = true,
	PALADIN = true,
	WARLOCK = true,
	EVOKER = true,
}

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
	ReloadUI()
end

local function OnLeavePreview()
	ElvUI_EltreumUI:ImproveInstall(nil, "LEAVING")
end

local function ClearOptionScripts()
	local frame = _G.PluginInstallFrame
	if not frame then return end
	for i = 1, 4 do
		local opt = frame["Option" .. i]
		if opt then
			opt:SetScript('OnEnter', nil)
			opt:SetScript('OnLeave', nil)
		end
	end
end

local function ResetOptionButtonFonts()
	local font = E.LSM:Fetch("font", E.db.general.font)
	local style = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
	for i = 1, 4 do
		local btnText = _G["PluginInstallOption" .. i .. "ButtonText"]
		if btnText then
			btnText:SetFont(font, 12, style)
		end
	end
end

local function FadeElements(mode, maxAlpha)
	local frame = _G.PluginInstallFrame
	if not frame then return end

	local targetAlpha = maxAlpha or 1
	if mode == "ENTERING" then
		UIFrameFadeIn(frame.installpreview, 0.5, 0, targetAlpha)
		if _G.PluginInstallTutorialImage then
			UIFrameFadeOut(_G.PluginInstallTutorialImage, 0.5, 1, 0)
		end
		for i = 1, 4 do
			local desc = frame["Desc" .. i]
			if desc then
				UIFrameFadeOut(desc, 0.5, 1, 0)
			end
		end
		if frame.SubTitle then
			UIFrameFadeOut(frame.SubTitle, 0.5, 1, 0)
		end
	elseif mode == "LEAVING" then
		UIFrameFadeOut(frame.installpreview, 0.5, targetAlpha, 0)
		if _G.PluginInstallTutorialImage then
			UIFrameFadeIn(_G.PluginInstallTutorialImage, 0.5, 0, 1)
		end
		for i = 1, 4 do
			local desc = frame["Desc" .. i]
			if desc then
				UIFrameFadeIn(desc, 0.5, 0, 1)
			end
		end
		if frame.SubTitle then
			UIFrameFadeIn(frame.SubTitle, 0.5, 0, 1)
		end
	end
end

--hide popups during install
function ElvUI_EltreumUI:HidePopups(delay)
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		W = unpack(_G.WindTools)
		local function WindtoolsCompatHideWhileInstall()
			_G["WTCompatibilityFrame"]:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibilityFrame", WindtoolsCompatHideWhileInstall)
	end
	if IsAddOnLoaded("Details_Streamer") then
		DisableAddOn("Details_Streamer",E.myguid)
	end
	E:Delay(delay, function()
		if IsAddOnLoaded("Details") and _G['_detalhes'] then
			_G['_detalhes'].is_first_run = false
			_G['_detalhes']:DisablePlugin ("DETAILS_PLUGIN_STREAM_OVERLAY")
			_G['_detalhes']:DisablePlugin ("Details_Streamer")
			_G['_detalhes']:SetTutorialCVar ("STREAMER_PLUGIN_FIRSTRUN", true)
			if _G["DetailsWelcomeWindow"] then
				_G["DetailsWelcomeWindow"]:Hide()
			end
			if _G["DetailsNewsWindow"] then
				_G["DetailsNewsWindow"]:Hide()
			end
			if _G["StreamOverlayWelcomeWindow"] then
				_G["StreamOverlayWelcomeWindow"]:Hide()
			end
			if _G["DetailsBaseFrame1"] then
				_G["DetailsBaseFrame1"]:Hide()
			end
			if _G["DetailsProfilerProfileConfirmButton"] then
				local a = _G["DetailsProfilerProfileConfirmButton"]:GetParent()
				a:Hide()
			end
		end
		for i = 1, 4 do
			if _G["StaticPopup"..i] then
				_G["StaticPopup"..i]:Hide()
			end
			if _G["ElvUI_StaticPopup"..i] then
				_G["ElvUI_StaticPopup"..i]:Hide()
			end
		end
		if _G["CappingFrame"] then
			_G["CappingFrame"]:Hide()
		end
		if _G["BasicMessageDialog"] then
			_G["BasicMessageDialog"]:Hide()
		end
		if IsAddOnLoaded("Gladdy") then
			LibStub("AceConfigDialog-3.0"):Close("Gladdy") --using E.Libs seems delayed
		end
		if _G["SubscriptionInterstitialFrame"] then --hide the f2p popup during install
			--_G["SubscriptionInterstitialFrame"]:Hide()
			_G["SubscriptionInterstitialFrame"].ClosePanelButton:Click() --click instead since hide does some weird things
		end
		--hide elvui config
		E.Libs.AceConfigDialog:Close("ElvUI")
	end)
end

--add some stuff to the installer
local PIHook
function ElvUI_EltreumUI:ImproveInstall(installtype, mode, null, custom, path)
	local frame = _G.PluginInstallFrame
	if not frame then return end

	if null then
		ClearOptionScripts()
		if frame.gaptexture then frame.gaptexture:Hide() end
		if frame.classsymbol then frame.classsymbol:Hide() end
		if frame.shadow then frame.shadow:Hide() end
		return
	end

	if custom then
		if path and frame.installpreview then
			frame.installpreview:SetTexture(path)
		end
		FadeElements(mode, 0.7)
	else
		if not installtype and not mode then
			if not frame.gaptexture then
				frame.gaptexture = frame:CreateTexture()
				frame.gaptexture:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\square_mask.tga")
				frame.gaptexture:SetVertexColor(0, 0, 0, 1)
				frame.gaptexture:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, 0)
				frame.gaptexture:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, 0)
				frame.gaptexture:SetPoint("TOPRIGHT", _G.PluginInstallTitleFrame, "TOPLEFT", 0, 0)
				frame.gaptexture:SetPoint("BOTTOMRIGHT", _G.PluginInstallTitleFrame, "BOTTOMLEFT", 0, 0)
			else
				frame.gaptexture:Show()
			end

			if not frame.classsymbol then
				frame.classsymbol = _G.PluginInstallTitleFrame:CreateTexture()
				frame.classsymbol:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\" .. ElvUI_EltreumUI:firstToUpper(stringlower(E.myclass)) .. ".tga")
				--frame.classsymbol:SetTexture(tostring(ElvUI_EltreumUI:GetClassCrest(true)))
				frame.classsymbol:SetSize(128, 128)
				frame.classsymbol:SetPoint("BOTTOM", _G.PluginInstallTitleFrame, "BOTTOM", 0, 25)
			else
				frame.classsymbol:Show()
			end

			if not frame.installpreview then
				frame.installpreview = frame:CreateTexture("InstallTexturePreview")
				frame.installpreview:SetAllPoints(frame)
				frame.installpreview:SetAlpha(0)
			end
		else
			if installtype and installPreviews[installtype] and frame.installpreview then
				frame.installpreview:SetTexture(installPreviews[installtype])
			end
			FadeElements(mode, 1)
		end
	end

	if not PIHook then
		local plugininstaller = E:GetModule('PluginInstaller')
		local function GradientTabNames()
			if frame.StepTitles and frame.Title and frame.Title:GetText() == ElvUI_EltreumUI.Name then
				local color = frame.StepTitlesColor or {1, 1, 1}
				local cr, cg, cb = color[1] or color.r or 1, color[2] or color.g or 1, color[3] or color.b or 1
				local lines = frame.side and frame.side.Lines
				if not lines then return end

				for i = 1, #lines do
					local line = lines[i]
					local title = frame.StepTitles[i]
					local StepTitleText = type(title) == 'function' and title() or title
					if StepTitleText then
						if i == frame.CurrentPage then
							line.text:SetText(E:TextGradient(StepTitleText, 0.50, 0.70, 1, 0.67, 0.95, 1))
						else
							line.text:SetText(StepTitleText)
							line.text:SetTextColor(cr, cg, cb)
						end
					end
				end
			end
		end
		hooksecurefunc(plugininstaller, "SetPage", GradientTabNames)
		GradientTabNames()

		local startColor = { r = 0, g = 0, b = 0, a = 1 }
		local endColor = { r = 1, g = 1, b = 1, a = 1 }

		if _G.PluginInstallStatus then
			hooksecurefunc(_G.PluginInstallStatus, "SetStatusBarColor", function(statusBar, r, g, b)
				if frame.Title and frame.Title:GetText() == ElvUI_EltreumUI.Name then
					local tex = statusBar:GetStatusBarTexture()
					if tex and tex.SetGradient then
						startColor.r = (r - 0.5 < 0 and 0) or r - 0.5
						startColor.g = (g - 0.5 < 0 and 0) or g - 0.5
						startColor.b = (b - 0.5 < 0 and 0) or b - 0.5
						endColor.r = (r + 0.4 > 1 and 1) or r + 0.4
						endColor.g = (g + 0.4 > 1 and 1) or g + 0.4
						endColor.b = (b + 0.4 > 1 and 1) or b + 0.4
						tex:SetGradient("HORIZONTAL", startColor, endColor)
					end
				end
			end)
		end

		frame:HookScript("OnShow", function()
			if frame.Title and frame.Title:GetText() ~= ElvUI_EltreumUI.Name then
				ElvUI_EltreumUI:ImproveInstall(nil, nil, true)
			end
		end)

		PIHook = true
	end
end

function ElvUI_EltreumUI:ResizeInstall()
	--_G.PluginInstallFrame:SetSize(550,400) --default
	--_G.PluginInstallFrame:SetSize(1024,512)
	--_G.PluginInstallFrame:SetSize(715,520)
	_G.PluginInstallFrame:SetSize(1040, 520)
	_G.PluginInstallFrame.Desc1:ClearAllPoints()
	_G.PluginInstallFrame.Desc1:SetPoint("TOP", _G.PluginInstallFrame.SubTitle, "BOTTOM", 0, -30)
end

--create new edit mode layout and switch to it to prevent possible issues with movers/taints
function ElvUI_EltreumUI:NewRetailEditModeLayout(objectivetrackerfix)
	if not (C_EditMode and C_EditMode.GetLayouts and C_EditMode.SaveLayouts and C_EditMode.SetActiveLayout and _G.EditModePresetLayoutManager) then
		return
	end

	local layoutstable = C_EditMode.GetLayouts()
	local presets = _G.EditModePresetLayoutManager:GetCopyOfPresetLayouts()
	if not layoutstable.layouts then
		layoutstable = {}
		layoutstable.layouts = presets
	end
	local layoutGlobalText = _G.EDIT_MODE_LAYOUT_HYPERLINK_TEXT or _G.HUD_EDIT_MODE_TITLE
	local taintpreventlayout = presets[1] --wait thats the table
	taintpreventlayout.layoutType = Enum.EditModeLayoutType.Account
	taintpreventlayout.layoutName = "EltruismTaintPreventer"

	if objectivetrackerfix then
		if not layoutstable.layouts[1] then --they dont have a custom profile, add my own to fix the objective frame anchor
			layoutstable.layouts[1] = taintpreventlayout
			layoutstable.activeLayout = 3 --for some reason the 2 default ones count for it
			C_EditMode.SaveLayouts(layoutstable) --if not called then layout wont apply because its not saved
			C_EditMode.SetActiveLayout(layoutstable.activeLayout)
		end
	else
		if layoutstable.layouts[1] then
			local alreadyimported = false
			for i = 1, #layoutstable.layouts do
				if layoutstable.layouts[i].layoutName == "EltruismTaintPreventer" then
					alreadyimported = true
					layoutstable.layouts[i] = taintpreventlayout
					layoutstable.activeLayout = i + 2
					C_EditMode.SetActiveLayout(layoutstable.activeLayout)
					ElvUI_EltreumUI:Print(stringformat(_G.HUD_EDIT_MODE_LAYOUT_APPLIED, taintpreventlayout.layoutName))
					break
				end
			end
			if not alreadyimported then
				--local numlayouts = Enum.EditModePresetLayoutsMeta.NumValues
				local numlayouts = #layoutstable.layouts + 1
				--tinsert(layoutstable.layouts, numlayouts + 1, taintpreventlayout)
				layoutstable.layouts[tonumber(numlayouts)] = taintpreventlayout
				--layoutstable.activeLayout = numlayouts + 1
				layoutstable.activeLayout = numlayouts + 2
				C_EditMode.SaveLayouts(layoutstable) --if not called then layout wont apply because its not saved
				C_EditMode.SetActiveLayout(layoutstable.activeLayout)
				ElvUI_EltreumUI:Print(L["Importing"].." "..layoutGlobalText)
			end
		else
			layoutstable.layouts[1] = taintpreventlayout
			layoutstable.activeLayout = 3 --for some reason the 2 default ones count for it
			C_EditMode.SaveLayouts(layoutstable) --if not called then layout wont apply because its not saved
			C_EditMode.SetActiveLayout(layoutstable.activeLayout)
			ElvUI_EltreumUI:Print(L["Importing"].." "..layoutGlobalText)
		end
	end
end

local function HandleLFG()
	--if there is an edit mode, import the profile
	if C_EditMode and C_EditMode.SaveLayouts and C_EditMode.GetLayouts then
		ElvUI_EltreumUI:NewRetailEditModeLayout()
	end

	--remove lfg spam from general and create tab for it
	if E.Retail then
		ChatFrame_RemoveChannel(_G.ChatFrame1, "services") --get rid of the gold seller chat
	else --for classic chat lfg
		local lfg = lfgChannels[E.global.general.locale] or "LookingForGroup"
		ChatFrame_RemoveChannel(_G.ChatFrame1, lfg)
		FCF_OpenNewWindow()
		ChatFrame_RemoveAllMessageGroups(_G.ChatFrame5)
		FCF_SetWindowName(_G.ChatFrame5, 'LFG')
		_G.ChatFrame5:AddChannel(lfg)
		FCFTab_UpdateColors(_G.ChatFrame5Tab)
		FCFDock_SelectWindow(_G.GENERAL_CHAT_DOCK, _G.ChatFrame1)
	end
end

local function ApplyRoleLayout(role)
	E:SetupChat()
	HandleLFG()
	ElvUI_EltreumUI:Print(L["ElvUI Chat has been set."])

	local profileName, shortName
	if role == "dps" then
		profileName = 'Eltreum DPS/Tank ('..E.mynameRealm..')'
		shortName = 'Eltreum DPS('..E.mynameRealm..')'
	elseif role == "healer" then
		profileName = 'Eltreum Healer ('..E.mynameRealm..')'
		shortName = 'EltreumHeal('..E.mynameRealm..')'
	elseif role == "thin" then
		profileName = 'Eltreum Thin ('..E.mynameRealm..')'
		shortName = 'EltreumThin('..E.mynameRealm..')'
	end

	if stringlen(profileName) > 50 then --ace3 will set default
		profileName = shortName
	end

	--wait for forever to be added here
	if (E.Mists or E.Wrath or E.Modern or E.ClassicSOD) and E.data:IsDualSpecEnabled() then
		E.data:SetDualSpecProfile(profileName, E.Libs.DualSpec.currentSpec)
	else
		E.data:SetProfile(profileName)
	end

	ElvUI_EltreumUI:SetupGeneralLayout()
	if role == "dps" then
		ElvUI_EltreumUI:SetupLayoutDPS()
	elseif role == "healer" then
		ElvUI_EltreumUI:SetupLayoutHealer()
	elseif role == "thin" then
		ElvUI_EltreumUI:SetupLayoutThin()
	end
	ElvUI_EltreumUI:SetupNamePlates()
	ElvUI_EltreumUI:ResolutionOutline()
	ElvUI_EltreumUI:UpdateEltruismSettings()
	ElvUI_EltreumUI:ModelsToggle(true) --disable models after layout for now due to the 3D model bug
	PlaySound(888)
end

-- Installer Steps
ElvUI_EltreumUI.InstallerData = {
	Title = ElvUI_EltreumUI.Name,
	Name = ElvUI_EltreumUI.Name,
	tutorialImage = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logo.tga',
	Pages = {
		[1] = function()
			ElvUI_EltreumUI:ResizeInstall()
			E:Delay(0, function() --compatibility during plugin install hides install so hide it instead
				if _G.MERCompatibilityFrame then
					_G.MERCompatibilityFrame:Hide()
				end
			end)
			ElvUI_EltreumUI:ImproveInstall()
			local frame = _G.PluginInstallFrame

			ElvUI_EltreumUI:HidePopups(0.1)
			if not frame.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
				frame:CreateShadow()
				frame.shadow:SetPoint("TOPLEFT", frame, "TOPLEFT", -3, 3)
				frame.shadow:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -3, -3)
				frame.shadow:SetPoint("TOPRIGHT", _G.PluginInstallTitleFrame, "TOPRIGHT", 3, 3)
				frame.shadow:SetPoint("BOTTOMRIGHT", _G.PluginInstallTitleFrame, "BOTTOMRIGHT", 3, -3)
			elseif frame.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
				frame.shadow:Show()
			end
			ElvUI_EltreumUI:ElvUIVersionCheck()
			frame.SubTitle:SetText(L["Welcome"])
			frame.Desc1:SetText(L["This prompt will help you install "]..ElvUI_EltreumUI.Name..L[" and import its settings"])
			frame.Desc2:SetText(L["Please read the instructions to avoid issues"])
			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript("OnClick", SkipInstallComplete)
			frame.Option1:SetScript('OnEnter', nil)
			frame.Option1:SetScript('OnLeave', nil)
			frame.Option1:SetText(L["Skip Install"])

			frame.Option2:SetScript('OnEnter', nil)
			frame.Option2:SetScript('OnLeave', nil)
			frame.Option3:SetScript('OnEnter', nil)
			frame.Option3:SetScript('OnLeave', nil)
			frame.Option4:SetScript('OnEnter', nil)
			frame.Option4:SetScript('OnLeave', nil)
		end,
		[2] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame

			frame.SubTitle:SetText(L["Layout"])
			frame.Desc1:SetText(L["Please select the role for your character, which will create a new profile.\nThis process can take a few seconds"])
			--_G.PluginInstallFrame.Desc2:SetText(L["Eltruism uses a 0.7 scale, but ElvUI can calculate the best scale for you using the Automatic Scale option"].." ("..((math.floor(E:PixelBestSize()*100))/100)..")")
			if supportClasses[E.myclass] then
				frame.Desc2:SetText('|cff82B4ff'..L["You can support the group with your class, if you select DPS/Tank then its recommended to click Alternative Frames after clicking DPS/Tank"]..'|r')
			end
			if IsAddOnLoaded("Plater") or IsAddOnLoaded("TidyPlates") or IsAddOnLoaded("Kui_Nameplates") or IsAddOnLoaded("TidyPlates_ThreatPlates") then
				frame.Desc3:SetText('|cFFFF0000'..L["You have another Nameplate Addon installed and loaded, and many nameplate features will not work with it"]..'|r')
				frame.Desc4:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
			else
				frame.Desc3:SetText(L["Importance: "]..'|cFFFF0000'..L["Very High (but Optional)"]..'|r')
			end

			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', function() ApplyRoleLayout("dps") end)
			frame.Option1:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("dps", "ENTERING") end)
			frame.Option1:SetScript('OnLeave', OnLeavePreview)
			frame.Option1:SetText(L["DPS\nTank"])

			frame.Option2:Enable()
			frame.Option2:Show()
			frame.Option2:SetScript('OnClick', function() ApplyRoleLayout("healer") end)
			frame.Option2:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("healer", "ENTERING") end)
			frame.Option2:SetScript('OnLeave', OnLeavePreview)
			frame.Option2:SetText(L["Healer"])

			frame.Option3:Enable()
			frame.Option3:Show()
			frame.Option3:SetScript('OnClick', function() ApplyRoleLayout("thin") end)
			frame.Option3:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("thin", "ENTERING") end)
			frame.Option3:SetScript('OnLeave', OnLeavePreview)
			frame.Option3:SetText(L["Thin Mode"])

			if altFrameClasses[E.myclass] then
				frame.Option4:SetText(L["Alternative\nFrames"])
				frame.Option4:Enable()
				frame.Option4:Show()
				frame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AlternativeGroupsDPS() end)
				frame.Option4:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("alternative", "ENTERING") end)
				frame.Option4:SetScript('OnLeave', OnLeavePreview)
			else
				frame.Option4:SetScript('OnEnter', nil)
				frame.Option4:SetScript('OnLeave', nil)
			end
		end,
		[3] = function()
			ElvUI_EltreumUI:ResizeInstall()
			ResetOptionButtonFonts()
			local frame = _G.PluginInstallFrame

			frame.SubTitle:SetText(L["Eltruism Modes"])
			frame.Desc1:SetText(L["Eltruism uses Dark Mode by default"])
			frame.Desc2:SetText(L["You can switch to Light Mode or Gradient Mode by clicking the buttons below"])
			frame.Desc3:SetText(L["You can customize the textures and colors in Eltruism > Unitframes"])
			frame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')

			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:ColorModes() end)
			frame.Option1:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("lightdark", "ENTERING") end)
			frame.Option1:SetScript('OnLeave', OnLeavePreview)
			frame.Option1:SetText(L["Light Mode"].."\n"..L["Dark Mode"])

			frame.Option2:Enable()
			frame.Option2:Show()
			frame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:GradientMode() end)
			frame.Option2:SetText(L["Gradient Mode"])
			frame.Option2:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("gradient", "ENTERING") end)
			frame.Option2:SetScript('OnLeave', OnLeavePreview)

			frame.Option3:Enable()
			frame.Option3:Show()
			frame.Option3:SetScript('OnClick', function()
				ElvUI_EltreumUI:BorderAdjust()
				ElvUI_EltreumUI:ShowHideBorders(true)
			end)
			frame.Option3:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("borders", "ENTERING") end)
			frame.Option3:SetScript('OnLeave', OnLeavePreview)
			frame.Option3:SetText(L["Borders"])

			frame.Option4:Enable()
			frame.Option4:Show()
			frame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:CheckBackground() end)
			frame.Option4:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("backgroundcolors", "ENTERING") end)
			frame.Option4:SetScript('OnLeave', OnLeavePreview)
			frame.Option4:SetText(L["BACKGROUND"].."\n"..L["COLOR"])
		end,
		[4] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame
			local fontStyle = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)

			frame.SubTitle:SetText(L["Fonts"])
			frame.Desc1:SetText(L["Eltruism uses Kimberley as the default font"])
			frame.Desc2:SetText(L["You can replace it with one of the following:"])
			frame.Desc3:SetText(L["Or change it later in Eltruism > Media options"])
			frame.Desc4:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')

			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("Roboto") end)
			frame.Option1:SetScript('OnEnter', nil)
			frame.Option1:SetScript('OnLeave', nil)
			frame.Option1:SetText('Roboto')
			_G.PluginInstallOption1ButtonText:SetFont('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Fonts\\Roboto-Bold.TTF', 12, fontStyle)

			frame.Option2:Show()
			frame.Option2:Enable()
			frame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("Exo2 Extra Bold") end)
			frame.Option2:SetScript('OnEnter', nil)
			frame.Option2:SetScript('OnLeave', nil)
			frame.Option2:SetText('Exo2')
			_G.PluginInstallOption2ButtonText:SetFont('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Fonts\\Exo2-ExtraBold.TTF', 12, fontStyle)

			frame.Option3:Show()
			frame.Option3:Enable()
			frame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("GothamNarrow Black") end)
			frame.Option3:SetScript('OnEnter', nil)
			frame.Option3:SetScript('OnLeave', nil)
			frame.Option3:SetText('Gotham')
			_G.PluginInstallOption3ButtonText:SetFont('Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Fonts\\GothamNarrowBlack.TTF', 12, fontStyle)

			frame.Option4:Show()
			frame.Option4:Enable()
			frame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupFont("AR CrystalzcuheiGBK Demibold") end)
			frame.Option4:SetScript('OnEnter', nil)
			frame.Option4:SetScript('OnLeave', nil)
			frame.Option4:SetText('Crystalzcuhei')
			_G.PluginInstallOption4ButtonText:SetFont("Fonts\\ARHei.TTF", 12, fontStyle)
		end,
		[5] = function()
			ElvUI_EltreumUI:ResizeInstall()
			ResetOptionButtonFonts()
			local frame = _G.PluginInstallFrame

			frame.SubTitle:SetText(CHAT_LABEL)
			frame.Desc1:SetText(L["Eltruism uses Transparent chat by default"])
			frame.Desc2:SetText(L["You can switch to Dark Chat by clicking the buttons below"])
			frame.Desc3:SetText(L["Importance: "]..'|cff82B4ff'..L["Optional"]..'|r')

			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:TransparentChat() end)
			frame.Option1:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("chattransparent", "ENTERING") end)
			frame.Option1:SetScript('OnLeave', OnLeavePreview)
			frame.Option1:SetText(L["Transparent\nChat"])

			frame.Option2:Enable()
			frame.Option2:Show()
			frame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:DarkChat() end)
			frame.Option2:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("chatdark", "ENTERING") end)
			frame.Option2:SetScript('OnLeave', OnLeavePreview)
			frame.Option2:SetText(L["Dark Chat"])

			frame.Option3:SetScript('OnEnter', nil)
			frame.Option3:SetScript('OnLeave', nil)
			frame.Option4:SetScript('OnEnter', nil)
			frame.Option4:SetScript('OnLeave', nil)
		end,
		[6] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame
			local hasDetails = IsAddOnLoaded("Details")

			frame.SubTitle:SetText(L["Details! DPS Meter"])
			frame.Desc1:SetText(L["Import Details! profile with dual panels"])
			frame.Desc2:SetText(L["You can right click the bottom right arrow to toggle the Details! Window"])
			frame.Desc3:SetText(L["Remember to swap the second window to Healing Done or Tiny Threat"])
			frame.Desc4:SetText(L["Choose the type of icons Details! will use:"])

			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT("spec") ElvUI_EltreumUI:GetASProfile() end)
			frame.Option1:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("detailsspec", "ENTERING") end)
			frame.Option1:SetScript('OnLeave', OnLeavePreview)
			frame.Option1:SetText((E.Modern or E.Mists or E.TBC or E.Wrath) and 'Spec' or 'Blizzard')

			frame.Option2:Show()
			frame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT("releafalpha") ElvUI_EltreumUI:GetASProfile() end)
			frame.Option2:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("detailsreleafalpha", "ENTERING") end)
			frame.Option2:SetScript('OnLeave', OnLeavePreview)
			frame.Option2:SetText('Releaf Alpha')

			frame.Option3:Show()
			frame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDT("releafsolid") ElvUI_EltreumUI:GetASProfile() end)
			frame.Option3:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("detailsreleafsolid", "ENTERING") end)
			frame.Option3:SetScript('OnLeave', OnLeavePreview)
			frame.Option3:SetText('Releaf Solid')

			frame.Option4:SetScript('OnEnter', nil)
			frame.Option4:SetScript('OnLeave', nil)

			if hasDetails then
				frame.Option1:Enable()
				frame.Option2:Enable()
				frame.Option3:Enable()
			else
				frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
				frame.Desc1:SetText("Details"..L[" is not installed or enabled"])
				frame.Desc2:SetText(L["Details is an advanced combat parser"])
				frame.Desc3:SetText(L["It has many plugins to choose from"])
				frame.Option1:Disable()
				frame.Option2:Disable()
				frame.Option3:Disable()
			end
		end,
		[7] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame
			local hasDBM = IsAddOnLoaded("DBM-Core")
			local hasBigWigs = IsAddOnLoaded("BigWigs")
			local hasQuestie = not E.Retail and IsAddOnLoaded("Questie")
			local hasWarpDeplete = E.Retail and IsAddOnLoaded("WarpDeplete")
			local isTBCWrathMists = E.Mists or E.TBC or E.Wrath
			local hasGladdy = isTBCWrathMists and IsAddOnLoaded("Gladdy")

			frame.SubTitle:SetText(L["PVP/PVE Addons"])
			frame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')

			frame.Option1:Show()
			if not E.Retail then
				frame.Option1:SetText(L["Questie"])
				frame.Option1:SetScript('OnEnter', nil)
				frame.Option1:SetScript('OnLeave', nil)
				if hasQuestie then
					frame.Desc1:SetText(L["Import Questie profile, which uses the DBM radar"])
					frame.Option1:Enable()
					frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupQuestie() end)
				else
					frame.Desc1:SetText(L["Questie is not installed or enabled"])
					frame.Option1:Disable()
				end
			else
				frame.Option1:SetText(L["WarpDeplete"])
				if hasWarpDeplete then
					frame.Desc1:SetText(L["Import WarpDeplete profile for Mythic Plus"]..", "..L["WarpDeplete profile requires an import per class in order to have the correct texture"])
					frame.Option1:Enable()
					frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:GetWarpDepleteProfile() end)
					frame.Option1:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("WarpDeplete", "ENTERING") end)
					frame.Option1:SetScript('OnLeave', OnLeavePreview)
				else
					frame.Desc1:SetText(L["WarpDeplete is not installed or enabled"])
					frame.Option1:Disable()
					frame.Option1:SetScript('OnEnter', nil)
					frame.Option1:SetScript('OnLeave', nil)
				end
			end

			frame.Option2:Show()
			frame.Option2:SetText('DBM')
			frame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDBM() end)
			frame.Option2:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("DBM", "ENTERING") end)
			frame.Option2:SetScript('OnLeave', OnLeavePreview)

			frame.Option3:Show()
			frame.Option3:SetText('BigWigs')
			frame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupBW() end)
			frame.Option3:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("BigWigs", "ENTERING") end)
			frame.Option3:SetScript('OnLeave', OnLeavePreview)

			if hasDBM and hasBigWigs then
				frame.Desc2:SetText(L["Import DBM or BigWigs profiles for dungeons and raids. (Uses DBM English Calanon and Bigwigs Voice)"])
				frame.Option2:Enable()
				frame.Option3:Enable()
			elseif hasDBM then
				frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
				frame.Desc2:SetText(L["BigWigs is not installed or enabled so DBM will be used"])
				frame.Option2:Enable()
				frame.Option3:Disable()
			elseif hasBigWigs then
				frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
				frame.Desc2:SetText(L["DBM is not installed or enabled so BigWigs will be used"])
				frame.Option2:Disable()
				frame.Option3:Enable()
			else
				frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
				frame.Desc2:SetText(L["Both DBM and BigWigs are not installed or enabled"])
				frame.Option2:Disable()
				frame.Option3:Disable()
			end

			if isTBCWrathMists then
				frame.Option4:Show()
				frame.Option4:SetText('Gladdy')
				if hasGladdy then
					frame.Desc3:SetText(L["Import profiles for Gladdy"])
					frame.Option4:Enable()
					frame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:SetupGladdy() end)
					frame.Option4:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("gladdy", "ENTERING") end)
					frame.Option4:SetScript('OnLeave', OnLeavePreview)
				else
					frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
					frame.Desc3:SetText(L["Gladdy is not installed or enabled"])
					frame.Option4:Disable()
					frame.Option4:SetScript('OnEnter', nil)
					frame.Option4:SetScript('OnLeave', nil)
				end
			else
				frame.Option4:SetScript('OnEnter', nil)
				frame.Option4:SetScript('OnLeave', nil)
			end

			local hasNone = false
			if E.Retail then
				hasNone = not (hasDBM or hasBigWigs or hasWarpDeplete)
			elseif isTBCWrathMists then
				hasNone = not (hasDBM or hasBigWigs or hasQuestie or hasGladdy)
			elseif E.Classic or E.Forever then
				hasNone = not (hasDBM or hasBigWigs or hasQuestie)
			end
			if hasNone then
				frame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
		end,
		[8] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame
			local hasImmersion = IsAddOnLoaded("Immersion")
			local hasDynamicCam = IsAddOnLoaded("DynamicCam")
			local hasNameplateSCT = not E.Modern and IsAddOnLoaded("NameplateSCT")
			local hasElvUI_FCT = not E.Modern and IsAddOnLoaded("ElvUI_FCT")

			frame.SubTitle:SetText(L["QOL Addons"])
			frame.Desc4:SetText('|cffff0000'..L["Your current settings will be lost, please back them up"]..'|r')

			frame.Option1:Show()
			frame.Option1:SetText('Immersion')
			frame.Option1:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupImmersion() end)
			frame.Option1:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("Immersion", "ENTERING") end)
			frame.Option1:SetScript('OnLeave', OnLeavePreview)
			if hasImmersion then
				frame.Desc1:SetText(L["Import "]..'Immersion '..L["settings configured for "]..'Eltruism')
				frame.Option1:Enable()
			else
				frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
				frame.Desc1:SetText("Immersion"..L[" is not installed or enabled"])
				frame.Option1:Disable()
			end

			frame.Option2:Show()
			frame.Option2:SetText(L["DynamicCam"])
			frame.Option2:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupDynamicCam() end)
			frame.Option2:SetScript('OnEnter', nil)
			frame.Option2:SetScript('OnLeave', nil)
			if hasDynamicCam then
				frame.Desc2:SetText(L["Import Dynamic Cam profile"])
				frame.Option2:Enable()
			else
				frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
				frame.Desc2:SetText("Dynamic Cam"..L[" is not installed or enabled"])
				frame.Option2:Disable()
			end

			if not E.Modern then
				frame.Option3:Show()
				frame.Option3:SetText('NameplateSCT')
				frame.Option3:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupCombatText("NameplateSCT") end)
				frame.Option3:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("NameplateSCT", "ENTERING") end)
				frame.Option3:SetScript('OnLeave', OnLeavePreview)

				frame.Option4:Show()
				frame.Option4:SetText('ElvUI FCT')
				frame.Option4:SetScript('OnClick', function() ElvUI_EltreumUI:AddonSetupCombatText("ElvUI_FCT") end)
				frame.Option4:SetScript('OnEnter', function() ElvUI_EltreumUI:ImproveInstall("ElvUIFCT", "ENTERING") end)
				frame.Option4:SetScript('OnLeave', OnLeavePreview)

				if hasNameplateSCT and hasElvUI_FCT then
					frame.Desc3:SetText(L["Import profiles for NameplateSCT or ElvUI Floating Combat Text"])
					frame.Option3:Enable()
					frame.Option4:Enable()
				elseif hasNameplateSCT then
					frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
					frame.Desc3:SetText(L["Import a profile for NameplateSCT configured for Eltruism"])
					frame.Option3:Enable()
					frame.Option4:Disable()
					frame.Option4:SetScript('OnEnter', nil)
					frame.Option4:SetScript('OnLeave', nil)
				elseif hasElvUI_FCT then
					frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
					frame.Desc3:SetText(L["Import a profile for Simpy's ElvUI FCT configured for Eltruism"])
					frame.Option3:Disable()
					frame.Option3:SetScript('OnEnter', nil)
					frame.Option3:SetScript('OnLeave', nil)
					frame.Option4:Enable()
				else
					frame.SubTitle:SetText("|cffff0000"..L["WARNING"]..'|r')
					frame.Desc3:SetText(L["NameplateSCT and ElvUI FCT are not installed or enabled"])
					frame.Option3:Disable()
					frame.Option3:SetScript('OnEnter', nil)
					frame.Option3:SetScript('OnLeave', nil)
					frame.Option4:Disable()
					frame.Option4:SetScript('OnEnter', nil)
					frame.Option4:SetScript('OnLeave', nil)
				end
			else
				frame.Option3:SetScript('OnEnter', nil)
				frame.Option3:SetScript('OnLeave', nil)
				frame.Option4:SetScript('OnEnter', nil)
				frame.Option4:SetScript('OnLeave', nil)
			end

			if not (hasImmersion or hasDynamicCam or hasNameplateSCT or hasElvUI_FCT) then
				frame.Desc4:SetText('|cffff0000'..L["You have none of these addons installed or enabled"]..'|r')
			end
		end,
		[9] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame

			frame.SubTitle:SetText('Discord')
			frame.Desc1:SetText(L["Join the Discord if you have any questions or issues (English Support)"])
			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/rBXNxUY6pk') end)
			frame.Option1:SetText('|TInterface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\tinydisc.tga:0:0:0:0|t Discord')
			frame.Option1:SetScript('OnEnter', nil)
			frame.Option1:SetScript('OnLeave', nil)
			frame.Option2:SetScript('OnEnter', nil)
			frame.Option2:SetScript('OnLeave', nil)
			frame.Option3:SetScript('OnEnter', nil)
			frame.Option3:SetScript('OnLeave', nil)
			frame.Option4:SetScript('OnEnter', nil)
			frame.Option4:SetScript('OnLeave', nil)
		end,
		[10] = function()
			ElvUI_EltreumUI:ResizeInstall()
			local frame = _G.PluginInstallFrame

			frame.SubTitle:SetText(L["Installation Complete"])
			frame.Desc1:SetText(L["You have completed the installation process"])
			frame.Desc2:SetText(L["Feel free to explore Eltruism settings in ElvUI > Eltruism.\nThere are lot of settings that are disabled by default."])
			frame.Desc3:SetText(L["Please click Finished to reload the UI"])
			frame.Desc4:SetText(L["Importance: "].."|cff82B4ff"..L["Very High"]..'|r')
			frame.Option1:Enable()
			frame.Option1:Show()
			frame.Option1:SetScript('OnClick', InstallComplete)
			frame.Option1:SetScript('OnEnter', nil)
			frame.Option1:SetScript('OnLeave', nil)
			frame.Option2:SetScript('OnEnter', nil)
			frame.Option2:SetScript('OnLeave', nil)
			frame.Option3:SetScript('OnEnter', nil)
			frame.Option3:SetScript('OnLeave', nil)
			frame.Option4:SetScript('OnEnter', nil)
			frame.Option4:SetScript('OnLeave', nil)
			frame.Option1:SetText(L["Finished"])
		end,
	},
	StepTitles = {
		[1] = L["Welcome"],
		[2] = L["Layout"],
		[3] = L["Eltruism Modes"],
		[4] = L["Fonts"],
		[5] = CHAT_LABEL,
		[6] = L["Details! DPS Meter"],
		[7] = L["PVP/PVE Addons"],
		[8] = L["QOL Addons"],
		[9] = 'Discord',
		[10] = L["Installation Complete"],
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {0.50, 0.70, 1},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = 'RIGHT',
}
