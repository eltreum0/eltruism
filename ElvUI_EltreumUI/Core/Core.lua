local E, L = unpack(ElvUI)
local _G = _G
local S = E:GetModule('Skins')
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local print = _G.print
local unpack = _G.unpack
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local DisableAddOn = _G.C_AddOns and _G.C_AddOns.DisableAddOn or _G.DisableAddOn
local LoadAddOn = _G.C_AddOns and _G.C_AddOns.LoadAddOn or _G.LoadAddOn
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize
local UIParentLoadAddOn = _G.UIParentLoadAddOn
local GetCursorInfo = _G.GetCursorInfo
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local string = _G.string
local DELETE_ITEM_CONFIRM_STRING = _G.DELETE_ITEM_CONFIRM_STRING
local InCombatLockdown = _G.InCombatLockdown
local HideUIPanel = _G.HideUIPanel
local GameMenuFrame = _G.GameMenuFrame
local UIErrorsFrame = _G.UIErrorsFrame
local RaidWarningFrame = _G.RaidWarningFrame
local tostring = _G.tostring
local math = _G.math
local PlaySound = _G.PlaySound
local W
local GetCVar = _G.C_CVar and _G.C_CVar.GetCVar or _G.GetCVar
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local utf8sub = _G.string.utf8sub
local format = _G.format
local IsInInstance = _G.IsInInstance
local IsEncounterInProgress = _G.IsEncounterInProgress
local strsub = _G.strsub
local ShowUIPanel = _G.ShowUIPanel
local EditModeManagerFrame = _G.EditModeManagerFrame
local SOUNDKIT = _G.SOUNDKIT
local pairs = _G.pairs
local StaticPopupDialogs = _G.StaticPopupDialogs
local ceil = _G.ceil
local BuffFrame = _G.BuffFrame

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	--print('|cff82B4ffEltruism|r: '..msg)
	print(E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1)..': '..msg)
end

--hide popups during install
function ElvUI_EltreumUI:HidePopups(delay)
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		W = unpack(WindTools)
		local function WindtoolsCompatHideWhileInstall()
			_G["WTCompatibilityFrame"]:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibilityFrame", WindtoolsCompatHideWhileInstall)
	end
	if IsAddOnLoaded("Details_Streamer") then
		DisableAddOn("Details_Streamer")
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
		if IsAddOnLoaded("GladiusEx") then
			GladiusEx:HideFrames()
		end
		if IsAddOnLoaded("Gladius") then
			if _G["GladiusButtonFramearena1"] then
				_G["GladiusButtonFramearena1"]:Hide()
			end
			if _G["GladiusButtonFramearena2"] then
				_G["GladiusButtonFramearena2"]:Hide()
			end
			if _G["GladiusButtonFramearena3"] then
				_G["GladiusButtonFramearena3"]:Hide()
			end
			if _G["GladiusButtonFramearena4"] then
				_G["GladiusButtonFramearena4"]:Hide()
			end
			if _G["GladiusButtonFramearena5"] then
				_G["GladiusButtonFramearena5"]:Hide()
			end
			if _G["GladiusButtonAnchor"] then
				_G["GladiusButtonAnchor"]:Hide()
			end
			if _G["GladiusButtonBackground"] then
				_G["GladiusButtonBackground"]:Hide()
			end
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

--Resolution check for font outline
function ElvUI_EltreumUI:ResolutionOutline()
	local width = GetPhysicalScreenSize()
	if width == 3840 then
		ElvUI_EltreumUI:Print(L["4K resolution detected, setting fonts to default mode."])
		ElvUI_EltreumUI:SetupFontsOutlineDefault()
	elseif width == 2560 then
		ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE")
		ElvUI_EltreumUI:Print(L["1440p resolution detected, setting fonts to outline mode."])
	elseif width == 1920 then
		ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE")
		ElvUI_EltreumUI:Print(L["1080p resolution detected, setting fonts to outline mode."])
	else
		ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE")
		ElvUI_EltreumUI:Print(L["Fonts were set to Outline due to your resolution."])
	end
end

--turn and off blizzard combat text
function ElvUI_EltreumUI:BlizzCombatText()
	if not E.private.ElvUI_EltreumUI then
		return
	elseif not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.otherstuff then
		return
	end
	if not InCombatLockdown() then
		if E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext and not E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
			SetCVar("enableFloatingCombatText", 0)
			SetCVar("floatingCombatTextCombatHealing", 0)
			SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0)
			SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)
			SetCVar("floatingCombatTextCombatDamage", 0)
		elseif E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
			SetCVar("floatingCombatTextEnergyGains", 1)
			SetCVar("enableFloatingCombatText", 1) ----this is damage taken without this the floating resource will not work
		end
	end
end

--restore blizzard combat text
function ElvUI_EltreumUI:RestoreBlizzCombatText()
	if not InCombatLockdown() then
		SetCVar("enableFloatingCombatText", 1)
		SetCVar("floatingCombatTextCombatHealing", 1)
		SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 1)
		SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 1)
		SetCVar("floatingCombatTextCombatDamage", 1)
		SetCVar("floatingCombatTextEnergyGains", 1)
	end
end

-- Ghost frame for Automatic Weakauras Positioning
local EltreumWAAnchor = CreateFrame("Frame", "EltruismWA", UIParent)
EltreumWAAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, -380)
local EltreumWAAnchor2 = CreateFrame("Frame", "EltruismWA2", UIParent)
EltreumWAAnchor2:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 320)
local EltruismWAConsumablesAnchor = CreateFrame("Frame", "EltruismConsumablesWA", UIParent)
--postion the anchor right below the player unitframe
EltruismWAConsumablesAnchor:SetPoint("LEFT", _G["ElvUF_Player"], 0, -75)
--archeology mover
local EltreumArcheologyAnchor = CreateFrame("Frame", "EltruismArcheology", UIParent)
EltreumArcheologyAnchor:SetPoint("TOP", UIParent, "TOP", 0, -230)
EltreumArcheologyAnchor:SetSize(200, 50)

function ElvUI_EltreumUI:Anchors()
	if E.private.unitframe.enable then
		--Anchor for general weakauras, like those that replace actionbars
		EltreumWAAnchor:SetParent(_G["ElvUF_Player"])
		EltreumWAAnchor:SetFrameStrata("BACKGROUND")
		--position the anchor around the place where the action bars would be
		EltreumWAAnchor:Size(250, 70)
		--E:CreateMover(parent, name, textString, overlay, snapoffset, postdrag, types, shouldDisable, configString, ignoreSizeChanged)
		E:CreateMover(EltreumWAAnchor, "MoverEltruismWA", "EltruismWA", nil, nil, nil, "ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')
		--do it again
		EltreumWAAnchor2:SetParent(_G["ElvUF_Player"])
		EltreumWAAnchor2:SetFrameStrata("BACKGROUND")
		EltreumWAAnchor2:Size(250, 70)
		E:CreateMover(EltreumWAAnchor2, "MoverEltruismWA2", "EltruismWA2", nil, nil, nil, "ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')

		--consumable weakauras, usually placed near player unitframe
		EltruismWAConsumablesAnchor:SetParent(_G["ElvUF_Player"])
		EltruismWAConsumablesAnchor:SetFrameStrata("BACKGROUND")
		EltruismWAConsumablesAnchor:Size(270, 30)
		E:CreateMover(EltruismWAConsumablesAnchor, "MoverEltruismWAConsumables", L["EltruismConsumablesWA"], nil, nil, nil, "ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')

		if E.private.general.raidUtility and E.private.unitframe.disabledBlizzardFrames.raid and E.private.unitframe.disabledBlizzardFrames.party then
			if _G.RaidUtility_ShowButton then
				E:CreateMover(_G.RaidUtility_ShowButton, "MoverRaidUtility", "Raid Utility", nil, nil, nil, "ALL,RAID,ELTREUMUI")
			end
		end
	end
	E:CreateMover(RaidWarningFrame, "MoverRaidWarningFrame", "Raid Warning Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")

	if _G["GhostFrame"] then
		E:CreateMover(_G["GhostFrame"], "GhostFrameMover", "Ghost Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
	end

	--mover for UI errors frame
	if E.db.ElvUI_EltreumUI.skins.blizzframes.hideerrorframe then
		UIErrorsFrame:Clear()
		UIErrorsFrame:Hide()
	else
		E:CreateMover(UIErrorsFrame, "MoverUIERRORS", "UI Error Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
	end

	--fix tutorial frames getting in the way
	if _G.TutorialMainFrame_Frame then
		_G.TutorialMainFrame_Frame:Kill()
	end
	if _G.TutorialSingleKey_Frame then
		_G.TutorialSingleKey_Frame:Kill()
	end
	if _G.TutorialWalk_Frame then
		_G.TutorialWalk_Frame:Kill()
	end
	if _G.TutorialFrame then
		_G.TutorialFrame:Kill()
	end
	if _G.TutorialKeyboardMouseFrame_Frame then
		_G.TutorialKeyboardMouseFrame_Frame:Kill()
	end

	if not E.private.auras.enable and not InCombatLockdown() then --in case elvui's buffs are disabled
		if _G.BuffFrame then
			E:CreateMover(BuffFrame, 'BlizzardBuffsMover', L["Blizzard Buff Frame"], nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		end
	end

	if E.db.ElvUI_EltreumUI.skins.blizzframes.hidealert then
		_G.AlertFrame:UnregisterAllEvents()
		E:DisableMover('AlertFrameMover')
	end

	if E.db.ElvUI_EltreumUI.skins.blizzframes.hidezone then
		_G.ZoneTextFrame:UnregisterAllEvents()
	end

	if E.Retail then
		E:CreateMover(_G.RaidBossEmoteFrame, "MoverRaidBossEmoteFrame", "Raid/Boss Emote Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		E:CreateMover(EltreumArcheologyAnchor, "MoverEltreumArcheologyAnchor", "EltruismArcheology", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		_G.ArcheologyDigsiteProgressBar:BreakFromFrameManager()
		_G.ArcheologyDigsiteProgressBar:ClearAllPoints()
		_G.ArcheologyDigsiteProgressBar:SetPoint("CENTER", _G["EltruismArcheology"], "CENTER", 0, 0)

		if E.db.ElvUI_EltreumUI.skins.blizzframes.hideboss then
			_G.BossBanner:UnregisterAllEvents()
			E:DisableMover('BossBannerMover')
		end
	end

	if E.db.ElvUI_EltreumUI.skins.blizzframes.hideeventoaster then
		_G.EventToastManagerFrame:UnregisterAllEvents()
		if E.Retail and _G.ChallengeModeCompleteBanner then
			_G.ChallengeModeCompleteBanner:UnregisterAllEvents()
		end
	end
end

--World text Scale
function ElvUI_EltreumUI:WorldTextScale(value)
	E.db.ElvUI_EltreumUI.otherstuff.worldtextscale = value
	SetCVar('WorldTextScale', value)
end

--Set some CVars when entering world
function ElvUI_EltreumUI:EnteringWorldCVars()
	if E.Retail then
		SetCVar("nameplatePlayerMaxDistance", 60)
	end
	SetCVar('nameplateOtherBottomInset', E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset)
	SetCVar('nameplateOtherTopInset', E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset)
	SetCVar('cameraDistanceMaxZoomFactor', E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor)
	SetCVar('nameplateTargetRadialPosition', E.db.ElvUI_EltreumUI.cvars.nameplateTargetRadialPosition)
	SetCVar('nameplateOccludedAlphaMult', E.db.ElvUI_EltreumUI.cvars.nameplateOccludedAlphaMult)
	SetCVar('DynamicRenderScaleMin', E.db.ElvUI_EltreumUI.cvars.dynamicrenderscalemin)
	if E.Retail and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable then
		SetCVar('showInGameNavigation', E.db.ElvUI_EltreumUI.cvars.showInGameNavigation)
	elseif E.Classic or E.Cata then
		SetCVar('clampTargetNameplateToScreen', E.db.ElvUI_EltreumUI.cvars.clampTargetNameplateToScreen)
	end
end

--Better EventTrace CLEU logging thanks to ;Meorawr.wtf.lua;
function ElvUI_EltreumUI:DevTools()
	if E.db.ElvUI_EltreumUI.dev then
		--addon specific cpu/memory usage
		--/run UpdateAddOnCPUUsage() UpdateAddOnMemoryUsage() print("cpu: "..((math.floor(GetAddOnCPUUsage("ElvUI_EltreumUI")))).."ms | memory: "..((math.floor(GetAddOnMemoryUsage("ElvUI_EltreumUI")/10))/100).."mb")

		ElvUI_EltreumUI:Print("Development Tools Enabled, this uses more resources to detect events")

		local function LogEvent(frame, event, ...)
			if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then
				frame:LogEvent_Original(event, CombatLogGetCurrentEventInfo())
			elseif event == "COMBAT_TEXT_UPDATE" then
				frame:LogEvent_Original(event, (...), GetCurrentCombatTextEventInfo())
			else
				frame:LogEvent_Original(event, ...)
			end
		end

		local function OnEventTraceLoaded()
			EventTrace.LogEvent_Original = EventTrace.LogEvent
			EventTrace.LogEvent = LogEvent
		end

		if EventTrace then
			OnEventTraceLoaded()
		else
			local frame = CreateFrame("Frame")
			frame:RegisterEvent("ADDON_LOADED")
			frame:SetScript("OnEvent", function(_, _, arg)
				if arg then
					ElvUI_EltreumUI:Print("Addon Loaded: "..arg)
				end
				if arg == "Blizzard_EventTrace" then
					OnEventTraceLoaded()
					if not IsAddOnLoaded("Blizzard_DebugTools") then
						UIParentLoadAddOn("Blizzard_DebugTools")
					end
					TableAttributeDisplay:SetWidth(800)
					TableAttributeDisplay.LinesScrollFrame:SetWidth(700)
					TableAttributeDisplay.TitleButton.Text:SetWidth(600)
					frame:UnregisterAllEvents()
				end
			end)
		end
	end
end

--fix the toggles hiding when chat panels hide
function ElvUI_EltreumUI:FixChatToggles()
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
		ElvUI_EltreumUI:BottomDatabarTexture()
		if E.db.ElvUI_EltreumUI.chat.chattoggles then
			_G.LeftChatToggleButton:SetAlpha(1)
			_G.LeftChatToggleButton:Show()
			_G.RightChatToggleButton:SetAlpha(1)
			_G.RightChatToggleButton:Show()

			--fix shadows when backdrop is shown
			local DT = E:GetModule("DataTexts")
			local eltruismdata = DT:FetchFrame("EltruismDataText")
			local datatextname = tostring(eltruismdata:GetName())

			--try again due to chat faders
			E:Delay(1,function()
				_G.LeftChatToggleButton:SetAlpha(1)
				_G.LeftChatToggleButton:Show()
				_G.RightChatToggleButton:SetAlpha(1)
				_G.RightChatToggleButton:Show()
			end)

			if E.db.ElvUI_EltreumUI.skins.shadow.enable and _G[datatextname].template and _G[datatextname].template ~= 'NoBackdrop' then
				if not _G[datatextname].shadow then
					_G[datatextname]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G[datatextname].shadow)
				end

				if not _G.LeftChatToggleButton.shadow then
					_G.LeftChatToggleButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.LeftChatToggleButton.shadow)
					_G.LeftChatToggleButton.shadow.RightEdge:Hide()
					_G.LeftChatToggleButton.shadow.RightEdge:Hide()
					_G.LeftChatToggleButton.shadow.BottomRightCorner:Hide()
					_G.LeftChatToggleButton.shadow.TopRightCorner:Hide()
					if _G[datatextname].shadow then
						_G[datatextname].shadow.RightEdge:Hide()
						_G[datatextname].shadow.BottomRightCorner:Hide()
						_G[datatextname].shadow.TopRightCorner:Hide()
					end
				end
				if not _G.RightChatToggleButton.shadow then
					_G.RightChatToggleButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G.RightChatToggleButton.shadow)
					_G.RightChatToggleButton.shadow.LeftEdge:Hide()
					_G.RightChatToggleButton.shadow.LeftEdge:Hide()
					_G.RightChatToggleButton.shadow.BottomLeftCorner:Hide()
					_G.RightChatToggleButton.shadow.TopLeftCorner:Hide()
					if _G[datatextname].shadow then
						_G[datatextname].shadow.LeftEdge:Hide()
						_G[datatextname].shadow.BottomLeftCorner:Hide()
						_G[datatextname].shadow.TopLeftCorner:Hide()
					end
				end
			end

			if E.db["datatexts"]["panels"]["EltruismDataText"]["backdrop"] then
				_G.LeftChatPanel.backdrop:Show()
				_G.RightChatPanel.backdrop:Show()
			end
		end

		--fix if the value changed since install
		local buttonwidth = _G.RightChatToggleButton:GetWidth()
		--local width = GetPhysicalScreenSize()
		local width = ceil(E.screenWidth)
		if E.global["datatexts"]["customPanels"]["EltruismDataText"] then
			if E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] >= width then
				if E.db.ElvUI_EltreumUI.chat.chattoggles then
					E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 2 + math.ceil(width - (buttonwidth * 2))
				else
					E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = math.ceil(width)
				end
				E:UpdateDataTexts()
			end
		end
	end
end

do
	local throttle = 0
	local function ClearThrottle()
		throttle = 0
	end

	local function TypeDelete()
		local _, _, itemLink = GetCursorInfo()
		if not itemLink then return end

		local lootName, _, _, _, _, _, _, _, _, lootTexture = GetItemInfo(itemLink)
		if itemLink:match("|Hbattlepet:") then
			lootName, _, _, _, _, _, _, _, _, lootTexture = GetItemInfo(82800)
		end
		if not (lootName and lootTexture) then return end

		local text = _G.StaticPopup1Text:GetText()
		if not text:match("|T") then
			local deletetext = string.gsub(text, lootName, "|T"..lootTexture..":".. 14 .."|t"..itemLink.."")
			_G.StaticPopup1Text:SetText(deletetext)
		end

		_G.StaticPopup1.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028

		if throttle == 0 then
			throttle = 1
			ElvUI_EltreumUI:Print("DELETE automatically typed")
			E:Delay(1, ClearThrottle)
		end
	end

	local isDeleteHooked = false
	local petdetect = CreateFrame("FRAME")
	function ElvUI_EltreumUI:DeleteItem()
		if not isDeleteHooked and E.db.ElvUI_EltreumUI.otherstuff.delete and not (IsAddOnLoaded("ConsolePort") or IsAddOnLoaded("AnnoyingPopupRemover")) then
			hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_ITEM,"OnShow",TypeDelete) --Interface/FrameXML/StaticPopup.lua line 1965/2074
			hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_QUEST_ITEM,"OnShow",TypeDelete) --Interface/FrameXML/StaticPopup.lua line 2125

			if E.Retail then
				petdetect:RegisterEvent("DELETE_ITEM_CONFIRM")
				petdetect:SetScript("OnEvent", function(_,_,deletetype)
					if deletetype == "Pet Cage" then
						TypeDelete()
					end
				end)
			end

			isDeleteHooked = true
		end
	end
end

--from elvui api, add button to game menu
local EltruismMenuButton = CreateFrame('Button', nil, GameMenuFrame, 'GameMenuButtonTemplate')
local isMenuExpanded = false
local EltruismGameMenu = CreateFrame("Frame")
EltruismGameMenu:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismGameMenu:SetScript("OnEvent", function()

	if E.db.ElvUI_EltreumUI.otherstuff.gamemenu then
		if E.Retail then
			local EM = E:GetModule('EditorMode')
			local Menubutton
			if not _G["EltruismGameMenu"] then
				Menubutton = CreateFrame('Button', 'EltruismGameMenu', GameMenuFrame, 'MainMenuFrameButtonTemplate')
				Menubutton:SetScript('OnClick', function()
					if InCombatLockdown() then return end
					E:ToggleOptions()
					E.Libs['AceConfigDialog']:SelectGroup('ElvUI', 'ElvUI_EltreumUI') --if the old way it would always open on load
					HideUIPanel(_G.GameMenuFrame)
				end)
				Menubutton:SetText("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:12:12:0:0:64:64|t".. ElvUI_EltreumUI.Name)
				S:HandleButton(Menubutton,nil,nil,nil,true)

				local xMenubutton = _G.GameMenuFrame:GetSize()
				Menubutton:Size(xMenubutton-62, 36)

				GameMenuFrame.Eltruism = Menubutton
				GameMenuFrame.MenuButtons.Eltruism = Menubutton

				hooksecurefunc(GameMenuFrame, 'Layout', function()
					GameMenuFrame.MenuButtons.Eltruism:SetPoint("CENTER", _G.GameMenuFrame, "TOP", 0, -20)
					for _, button in pairs(GameMenuFrame.MenuButtons) do
						if button then
							local point, anchor, point2, x, y = button:GetPoint()
							button:SetPoint(point, anchor, point2, x, y - 35)
						end
					end

					--local originalMenuHeight = GameMenuFrame:GetHeight() --this gives 538 so,
					GameMenuFrame:Height(538 + 36) --yes i can set the actual math but this lets me recall its + menubutton height

					--use elvui moveui instead of blizzard edit mode
					local EditModeButton = EM:GetGameMenuEditModeButton()
					if EditModeButton then
						EditModeButton:RegisterForClicks("AnyUp")
						EditModeButton:SetScript("OnClick", function(_, button)
							if not InCombatLockdown() then
								if button == "LeftButton" then
									E:ToggleMoveMode()
									HideUIPanel(_G["GameMenuFrame"])
								else
									PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
									ShowUIPanel(EditModeManagerFrame);
								end
							end
						end)
						EditModeButton:HookScript("OnEnter", function()
							_G["GameTooltip"]:SetOwner(EditModeButton, 'ANCHOR_RIGHT')
							_G["GameTooltip"]:AddDoubleLine(L["Left Click:"], L["Toggle ElvUI Anchors"], 1, 1, 1)
							_G["GameTooltip"]:AddDoubleLine(L["Right Click:"], L["Toggle Edit Mode"], 1, 1, 1)
							_G["GameTooltip"]:Show()
						end)
						EditModeButton:HookScript("OnLeave", function()
							_G["GameTooltip"]:Hide()
						end)
					end

				end)
			end
		else
			if not isMenuExpanded then
				EltruismMenuButton:SetText("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:12:12:0:0:64:64|t".. ElvUI_EltreumUI.Name) --new 64x64 icon
				S:HandleButton(EltruismMenuButton)
				local x, y = _G["GameMenuButtonLogout"]:GetSize()
				EltruismMenuButton:SetSize(x,y)
				EltruismMenuButton:SetScript("OnClick", function()
					if not InCombatLockdown() then
						E:ToggleOptions("ElvUI_EltreumUI")
						--E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
						HideUIPanel(_G["GameMenuFrame"])
					end
				end)

				hooksecurefunc('GameMenuFrame_UpdateVisibleButtons', function ()
					EltruismMenuButton:Point("TOP", GameMenuFrame.ElvUI, "BOTTOM", 0, -1)
					if _G["GameMenu_SLEConfig"] and not _G["GameMenuReloadUI"] and not _G.TXUI_GAME_BUTTON then
						EltruismMenuButton:Point("TOP", _G["GameMenu_SLEConfig"], "BOTTOM", 0, -1)
					elseif _G["GameMenuReloadUI"] and not _G.TXUI_GAME_BUTTON then
						EltruismMenuButton:Point("TOP", _G["GameMenuReloadUI"], "BOTTOM", 0, -1)
					elseif _G.TXUI_GAME_BUTTON then
						EltruismMenuButton:Point("TOP", _G.TXUI_GAME_BUTTON, "BOTTOM", 0, -1)
					elseif _G["GameMenuFrame"].GameMenu_TXUI then
						EltruismMenuButton:Point("TOP", _G["GameMenuFrame"].GameMenu_TXUI, "BOTTOM", 0, -1)
					end
				end)

				_G["GameMenuFrame"]:HookScript("OnShow", function()
					_G["GameMenuButtonLogout"]:ClearAllPoints()
					_G["GameMenuButtonLogout"]:SetPoint("TOP", EltruismMenuButton, "BOTTOM", 0, -y)
					_G["GameMenuFrame"]:SetHeight(_G["GameMenuFrame"]:GetHeight() + _G["GameMenuButtonLogout"]:GetHeight() + 4)
				end)
				isMenuExpanded = true
			end
		end
	end
end)

--make the video options movable because its annoying when adjusting settings
local VideoOptionsFrame = _G.VideoOptionsFrame --Classic/Cata
if VideoOptionsFrame then
	VideoOptionsFrame:SetMovable(true)
	VideoOptionsFrame:EnableMouse(true)
	VideoOptionsFrame:RegisterForDrag("LeftButton")
	VideoOptionsFrame:SetScript("OnDragStart", VideoOptionsFrame.StartMoving)
	VideoOptionsFrame:SetScript("OnDragStop", VideoOptionsFrame.StopMovingOrSizing)
	VideoOptionsFrame:SetClampedToScreen(true)
end
local SettingsPanel = _G.SettingsPanel --Dragonflight
if SettingsPanel then
	SettingsPanel:SetMovable(true)
	SettingsPanel:EnableMouse(true)
	SettingsPanel:RegisterForDrag("LeftButton")
	SettingsPanel:SetScript("OnDragStart", SettingsPanel.StartMoving)
	SettingsPanel:SetScript("OnDragStop", SettingsPanel.StopMovingOrSizing)
	SettingsPanel:SetClampedToScreen(true)
end

--click casting button toggle
if E.Retail then
	local clickbindopenbutton = CreateFrame("Button", "EltruismClickCastingToggle")
	clickbindopenbutton:SetWidth(32)
	clickbindopenbutton:SetHeight(32)
	S:HandleButton(clickbindopenbutton)
	local bindexture = clickbindopenbutton:CreateTexture()
	--bindexture:SetTexture(4238928)
	bindexture:SetTexture("interface\\cursor\\crosshair\\cast")
	bindexture:SetTexCoord(0.08,0.92,0.08,0.92)
	bindexture:SetAllPoints(clickbindopenbutton)
	clickbindopenbutton:RegisterForClicks("AnyUp")

	clickbindopenbutton:SetScript("OnEnter", function()
		_G["GameTooltip"]:SetOwner(clickbindopenbutton, 'ANCHOR_RIGHT')
		_G["GameTooltip"]:AddLine(L["Toggle the Click Casting Menu"])
		_G["GameTooltip"]:Show()
	end)
	clickbindopenbutton:SetScript("OnLeave", function()
		_G["GameTooltip"]:Hide()
	end)

	local clickcastingmonitor = CreateFrame("frame")
	clickcastingmonitor:RegisterEvent("ADDON_LOADED")
	clickcastingmonitor:SetScript("OnEvent", function(_,_,addon)
		if (addon == "Blizzard_PlayerSpells") or IsAddOnLoaded("Blizzard_PlayerSpells") then
			clickcastingmonitor:UnregisterEvent("ADDON_LOADED")
			clickbindopenbutton:SetParent(_G["PlayerSpellsFrame"])
			clickbindopenbutton:SetPoint("LEFT", _G["PlayerSpellsFrame"], "TOPRIGHT", 0, -80)
			clickbindopenbutton:SetScript('OnClick', function()
				if not IsAddOnLoaded("Blizzard_ClickBindingUI") then
					LoadAddOn("Blizzard_ClickBindingUI")
					if not _G["ClickBindingFrame"].shadow then
						_G["ClickBindingFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["ClickBindingFrame"].shadow)
					end
				end
				if not _G["ClickBindingFrame"]:IsShown() then
					_G["ClickBindingFrame"]:Show()
				elseif _G["ClickBindingFrame"]:IsShown() then
					_G["ClickBindingFrame"]:Hide()
					_G["PlayerSpellsFrame"]:Show()
				end
				_G["ClickBindingFrame"]:ClearAllPoints()
				_G["ClickBindingFrame"]:SetParent(_G["PlayerSpellsFrame"])
				_G["ClickBindingFrame"]:SetPoint("LEFT", _G["PlayerSpellsFrame"], "RIGHT", 50, -37)
			end)
		end
	end)
end

--shadow and light compatibility check
function ElvUI_EltreumUI:SLCheck(setting)
	if not IsAddOnLoaded("ElvUI_SLE") or not setting then return false end
	if setting == 'char' and E.db.sle.armory.character.enable then
		return true
	end
	if setting == 'stats' and E.private.sle.armory.stats.enable then
		return true
	end
	if setting == 'inspect' and E.db.sle.armory.inspect.enable then
		return true
	end
	if setting == 'media' and E.private.sle.media.enable then
		return true
	end
	if setting == 'quest' and E.private.sle.skins.objectiveTracker.enable then
		return true
	end

	return false
end

--check for blinkii's kick on cd function
function ElvUI_EltreumUI:CheckmMediaTagInterrupt()
	if IsAddOnLoaded("ElvUI_mMediaTag") and E.Retail then
		if (E.db.mMT and E.db.mMT.interruptoncd and E.db.mMT.interruptoncd.enable) then
			return _G.mMT:mMediaTag_interruptOnCD() or false
		else
			return false
		end
	else
		return false
	end
end

do
	local shortenReplace = function(t) return t:utf8sub(1,1)..'. ' end
	function ElvUI_EltreumUI:ShortenString(text, length, cut,firstname)
		if text and string.len(text) > length then
			if cut then
				text = E:ShortenString(text,length)
			else
				if firstname then
					local first, last = text:match('^(%a*)(.*)$')
					if first and last then
						text = first.." "..last:gsub('(%S+)', shortenReplace)
					else
						text = text:gsub('(%S+) ', shortenReplace)
					end
				else
					text = text:gsub('(%S+) ', shortenReplace)
				end
			end
		end
		return text
	end
end

--10.1 addon compartment
function ElvUI_EltreumUI_OnAddonCompartmentClick()
	E:ToggleOptions("ElvUI_EltreumUI") --has msg arg which can be used
	--E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
end

--set value between two other values
function ElvUI_EltreumUI:Interval(value, minValue, maxValue)
	return math.max(minValue, math.min(maxValue, value))
end

function ElvUI_EltreumUI:FontFlag(style)
	if strsub(style, 0, 6) == 'SHADOW' then
		style = strsub(style, 7)
		if not style then style = '' end
		return style
	else
		if style == 'NONE' then style = '' end
		return style
	end
end

--apply recommended ElvUI perforamnce optimizations
function ElvUI_EltreumUI:PerformanceOptimization()
	--ElvUI
	E.private["general"]["pixelPerfect"] = true
	E.db["unitframe"]["thinBorders"] = true
	E.db["nameplates"]["thinBorders"] = true
	E.db["unitframe"]["units"]["target"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid1"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raidpet"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["healPrediction"]["enable"] = false

	E.db["auras"]["buffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["debuffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["cooldown"]["override"] = false
	E.db["chat"]["fade"] = true -- fade text again
	E.db["unitframe"]["units"]["assist"]["enable"] = false --disable assist/tank frames
	E.db["unitframe"]["units"]["tank"]["enable"] = false --disable assist/tank frames
	E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["player"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["target"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["targettarget"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["focus"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["pet"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["arena"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["party"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["raid1"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["raid2"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["raid3"]["fader"]["smooth"] = 0
	E.db["general"]["altPowerBar"]["smoothbars"] = false --was true
	E.db["nameplates"]["smoothbars"] = false --was true
	E.db["unitframe"]["smoothbars"] = false --was true
	E.db["tooltip"]["inspectDataEnable"] = false --was true
	E.db["tooltip"]["mythicDataEnable"] = false --was true
	E.db["tooltip"]["role"] = false --was true
	E.db["tooltip"]["targetInfo"] = false --was true
	E.db["tooltip"]["showMount"] = false --was true
	E.db["unitframe"]["units"]["boss"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid1"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["focus"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["pet"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["portrait"]["enable"] = false

	--Eltruism
	E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable = false
	E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly = true
	E.db.ElvUI_EltreumUI.chat.enable = false
	E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.classbarautohide = false
	E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = false
	E.db.ElvUI_EltreumUI.nameplates.classification.enable = false
	E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient = false
	E.db.ElvUI_EltreumUI.skins.shadow.nameplates = false
	E.db.ElvUI_EltreumUI.skins.shadow.nppower = false
	E.db.ElvUI_EltreumUI.skins.shadow.npcastbar = false
	E.db.ElvUI_EltreumUI.skins.shadow.npportraits = false
	E.db.ElvUI_EltreumUI.skins.shadow.npauras = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow = false
	E.db.ElvUI_EltreumUI.nameplates.auras.enable = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPower = false
	E.db.ElvUI_EltreumUI.unitframes.models.powerbar = false
	E.db.ElvUI_EltreumUI.unitframes.models.castbar = false
	E.db.ElvUI_EltreumUI.unitframes.models.unitframe = false
	E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable = false
	E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars = false
	E.db.ElvUI_EltreumUI.unitframes.portraitfix = false
	E.db.ElvUI_EltreumUI.skins.shadow.aura = false
	E.db.ElvUI_EltreumUI.skins.shadow.ufaura = false
	E.db.ElvUI_EltreumUI.skins.bigwigs = false
	E.db.ElvUI_EltreumUI.skins.shadow.bigwigs = false
	E.db.ElvUI_EltreumUI.skins.details = false
	E.db.ElvUI_EltreumUI.skins.bugsack = false
	E.db.ElvUI_EltreumUI.skins.warpdeplete = false
	E.db.ElvUI_EltreumUI.skins.omnicd = false
	E.db.ElvUI_EltreumUI.skins.cell = false
	E.db.ElvUI_EltreumUI.skins.dbm = false
	E.db.ElvUI_EltreumUI.glow.enable = false
	E.db.ElvUI_EltreumUI.cursors.cursor.enable = false
	E.db.ElvUI_EltreumUI.cursors.cursor.cooldown = false
	E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable = false
	E.db.ElvUI_EltreumUI.loot.loottext.enable = false
	E.private.ElvUI_EltreumUI.nameplatepower.enable = false
	E.db.ElvUI_EltreumUI.quests.anchor = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop = false
	E.db.ElvUI_EltreumUI.chat.chatgradient = false
end

--toggle 3d models
function ElvUI_EltreumUI:ModelsToggle(install)
	if install then
		E.db.ElvUI_EltreumUI.disabledmodels = true

		E.db.unitframe.units.boss.portrait.enable = false
		E.db.unitframe.units.player.portrait.enable = false
		E.db.unitframe.units.pet.portrait.enable = false
		E.db.unitframe.units.target.portrait.enable = false
		E.db.unitframe.units.targettarget.portrait.enable = false
		E.db.unitframe.units.focus.portrait.enable = false
		E.db.unitframe.units.party.portrait.enable = false
		E.db.unitframe.units.raid1.portrait.enable = false
		E.db.unitframe.units.raid2.portrait.enable = false
		E.db.unitframe.units.raid3.portrait.enable = false
		E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = false
		E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = false
		E.db.ElvUI_EltreumUI.unitframes.models.powerbar = false
		E.db.ElvUI_EltreumUI.unitframes.models.castbar = false
		E.db.ElvUI_EltreumUI.unitframes.models.unitframe = false
	else
		if E.db.ElvUI_EltreumUI.disabledmodels then
			E.db.ElvUI_EltreumUI.disabledmodels = false

			E.db.unitframe.units.boss.portrait.enable = true
			E.db.unitframe.units.player.portrait.enable = true
			E.db.unitframe.units.pet.portrait.enable = true
			E.db.unitframe.units.target.portrait.enable = true
			--E.db.unitframe.units.targettarget.portrait.enable = true
			--E.db.unitframe.units.focus.portrait.enable = true
			E.db.unitframe.units.party.portrait.enable = true
			--E.db.unitframe.units.raid1.portrait.enable = true
			--E.db.unitframe.units.raid2.portrait.enable = true
			--E.db.unitframe.units.raid3.portrait.enable = true
			E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = true
			E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = true
			E.db.ElvUI_EltreumUI.unitframes.models.powerbar = true
			--E.db.ElvUI_EltreumUI.unitframes.models.castbar = true
			--E.db.ElvUI_EltreumUI.unitframes.models.unitframe = true

			ElvUI_EltreumUI:Print("Enabled several models in ElvUI and Eltruism")
		else
			E.db.ElvUI_EltreumUI.disabledmodels = true

			E.db.unitframe.units.boss.portrait.enable = false
			E.db.unitframe.units.player.portrait.enable = false
			E.db.unitframe.units.pet.portrait.enable = false
			E.db.unitframe.units.target.portrait.enable = false
			E.db.unitframe.units.targettarget.portrait.enable = false
			E.db.unitframe.units.focus.portrait.enable = false
			E.db.unitframe.units.party.portrait.enable = false
			E.db.unitframe.units.raid1.portrait.enable = false
			E.db.unitframe.units.raid2.portrait.enable = false
			E.db.unitframe.units.raid3.portrait.enable = false
			E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = false
			E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = false
			E.db.ElvUI_EltreumUI.unitframes.models.powerbar = false
			E.db.ElvUI_EltreumUI.unitframes.models.castbar = false
			E.db.ElvUI_EltreumUI.unitframes.models.unitframe = false

			ElvUI_EltreumUI:Print("Disabled several models to improve performance")
		end

		E:StaticPopup_Show('CONFIG_RL')
	end
end

function ElvUI_EltreumUI:EncounterCheck() --let other functions know if its a boss fight
	if E.db.ElvUI_EltreumUI.encountercheck then
		return IsEncounterInProgress()
	else
		return false
	end
end

--make mage and warlock use their original class colors
function ElvUI_EltreumUI:OriginalClassColors()
	--_G.RAID_CLASS_COLORS can cause issues inside instances if friendly nameplates are enabled, so check for that
	local inInstance = IsInInstance()
	local canTouchRaidClassColors
	local mapID = _G.WorldMapFrame:GetMapID()
	if not inInstance and not (mapID == 1662 or mapID == 582 or mapID == 590) then
		canTouchRaidClassColors = true
	else
		if GetCVar('nameplateShowFriends') == 0 then
			canTouchRaidClassColors = true
		else
			canTouchRaidClassColors = false
		end
	end

	if E.db.ElvUI_EltreumUI.skins.oldclasscolors then
		if canTouchRaidClassColors and not inInstance then
			_G.RAID_CLASS_COLORS['MAGE']["r"] = 0.41
			_G.RAID_CLASS_COLORS['MAGE']["g"] = 0.8
			_G.RAID_CLASS_COLORS['MAGE']["b"] = 0.94
			_G.RAID_CLASS_COLORS['MAGE']["colorStr"] = "ff69CCF0"
		end
		E.oUF.colors.class['MAGE'][1] = 0.41
		E.oUF.colors.class['MAGE'][2] = 0.8
		E.oUF.colors.class['MAGE'][3] = 0.94
		E.oUF.colors.class['MAGE']["r"] = 0.41
		E.oUF.colors.class['MAGE']["g"] = 0.8
		E.oUF.colors.class['MAGE']["b"] = 0.94

		if canTouchRaidClassColors and not inInstance then
			_G.RAID_CLASS_COLORS['WARLOCK']["r"] = 0.58
			_G.RAID_CLASS_COLORS['WARLOCK']["g"] = 0.51
			_G.RAID_CLASS_COLORS['WARLOCK']["b"] = 0.79
			_G.RAID_CLASS_COLORS['WARLOCK']["colorStr"] = "9482C9"
		end
		E.oUF.colors.class['WARLOCK'][1] = 0.58
		E.oUF.colors.class['WARLOCK'][2] = 0.51
		E.oUF.colors.class['WARLOCK'][3] = 0.79
		E.oUF.colors.class['WARLOCK']["r"] = 0.58
		E.oUF.colors.class['WARLOCK']["g"] = 0.51
		E.oUF.colors.class['WARLOCK']["b"] = 0.79
	end

	--make shamans blue again in classic
	if E.Classic then
		if E.db.ElvUI_EltreumUI.skins.classicblueshaman then
			if canTouchRaidClassColors and not inInstance then
				_G.RAID_CLASS_COLORS['SHAMAN']["r"] = 0.00
				_G.RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44
				_G.RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87
				_G.RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070DD"
			end
			E.oUF.colors.class['SHAMAN'][1] = 0.00
			E.oUF.colors.class['SHAMAN'][2] = 0.44
			E.oUF.colors.class['SHAMAN'][3] = 0.87
			E.oUF.colors.class['SHAMAN']["r"] = 0.00
			E.oUF.colors.class['SHAMAN']["g"] = 0.44
			E.oUF.colors.class['SHAMAN']["b"] = 0.87
		end
	end
end

--Export/Import Gradient Colors, basically copied from elvui distributor/core
function ElvUI_EltreumUI:ExportImportGradient(data,mode)
	local D = E:GetModule('Distributor')
	local LibDeflate = E.Libs.Deflate
	if mode == "export" then
		local gradienttable = {}
		gradienttable = E:CopyTable(gradienttable, E.db.ElvUI_EltreumUI.unitframes.gradientmode)
		local profile = D:Serialize(gradienttable)
		local compressed = LibDeflate:CompressDeflate(profile, LibDeflate.compressLevel)
		local exportProfile = LibDeflate:EncodeForPrint(compressed)
		return exportProfile
	elseif mode == "import" then
		local decodedData = LibDeflate:DecodeForPrint(data)

local decompressed = LibDeflate:DecompressDeflate(decodedData)

local serializedData = format('%s%s', decompressed, '^^')

local success, profileData = D:Deserialize(serializedData)

if not success then
			E:Print('Error deserializing:', profileData)
			return
		end
		E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.gradientmode, profileData)
		E:StaticPopup_Show('CONFIG_RL')
	end
end

--color picker wheel better masking
if E.Retail then
	local bettermask = _G.ColorPickerFrame:CreateMaskTexture()
	bettermask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\map_circle.TGA", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	bettermask:SetPoint("TOPRIGHT", _G.ColorPickerFrame.Content.ColorPicker.Wheel, "TOPRIGHT", 3, 3)
	bettermask:SetPoint("BOTTOMLEFT", _G.ColorPickerFrame.Content.ColorPicker.Wheel, "BOTTOMLEFT", -2, -2)
	_G.ColorPickerFrame.Content.ColorPicker.Wheel:AddMaskTexture(bettermask)
else
	local bettermask = _G.ColorPickerFrame:CreateMaskTexture()
	bettermask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\map_circle.TGA", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	bettermask:SetPoint("TOPRIGHT", _G.ColorPickerWheel, "TOPRIGHT", 3, 3)
	bettermask:SetPoint("BOTTOMLEFT", _G.ColorPickerWheel, "BOTTOMLEFT", -2, -2)
	_G.ColorPickerWheel:AddMaskTexture(bettermask)
end
--for fps testing
--[[
local framerate = CreateFrame("Frame", nil, UIParent)
framerate.TimeText = framerate:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
framerate.TimeText:SetJustifyV("TOP")
framerate.TimeText:SetSize(0, 26)
framerate.TimeText:SetPoint("CENTER", UIParent, "CENTER",0, 400)
framerate.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), 36, E.db.general.fontStyle)
framerate.TimeText:SetTextColor(1,1,1)
UIParent.ClearAllPoints(FramerateText)
_G.FramerateText:SetPoint("RIGHT",UIParent,"CENTER",0, 2035)
_G.FramerateLabel:SetText("")
ToggleFramerate()

framerate:SetScript("OnUpdate", function()
	_G.FRAMERATE_FREQUENCY = 0.1
	if _G.FramerateText:GetText() ~= nil then
		if tonumber(_G.FramerateText:GetText()) < 60 then
			framerate.TimeText:SetTextColor(1,0,0)
			framerate.TimeText:SetText(_G.FramerateText:GetText())
		elseif tonumber(_G.FramerateText:GetText()) > 60 then
			framerate.TimeText:SetTextColor(1,1,1)
			framerate.TimeText:SetText(_G.FramerateText:GetText())
		end
	end
end)
]]
