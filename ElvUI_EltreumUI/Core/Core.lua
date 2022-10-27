local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local C_CVar = _G.C_CVar
local S = E:GetModule('Skins')
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local print = print
local unpack = unpack
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded
local DisableAddOn = _G.DisableAddOn
local C_Timer = C_Timer
local GetPhysicalScreenSize = GetPhysicalScreenSize
local SetCVar = SetCVar
local UIParentLoadAddOn = _G.UIParentLoadAddOn
local select = select
local GetCursorInfo = GetCursorInfo
local GetItemInfo = GetItemInfo
local string = string
local DELETE_ITEM_CONFIRM_STRING = _G.DELETE_ITEM_CONFIRM_STRING
local InCombatLockdown = _G.InCombatLockdown
local HideUIPanel = _G.HideUIPanel
local LoadAddOn = LoadAddOn
local GameMenuFrame = _G.GameMenuFrame
local UIErrorsFrame = _G.UIErrorsFrame
local RaidWarningFrame = _G.RaidWarningFrame
local W
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	print('|cff82B4ffEltruism|r: '..msg)
end

--hide popups during install
function ElvUI_EltreumUI:HidePopups(delay)
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		W = unpack(WindTools)
		local function WindtoolsCompatHideWhileInstall()
			WTCompatibilityFrame:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibilityFrame", WindtoolsCompatHideWhileInstall)
	end
	if IsAddOnLoaded("Details_Streamer") then
		DisableAddOn("Details_Streamer")
	end
	C_Timer.After(delay, function()
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
		if _G["StaticPopup1"] then
			_G["StaticPopup1"]:Hide()
		end
		if _G["StaticPopup2"] then
			_G["StaticPopup2"]:Hide()
		end
		if _G["StaticPopup3"] then
			_G["StaticPopup3"]:Hide()
		end
		if _G["StaticPopup4"] then
			_G["StaticPopup4"]:Hide()
		end
		if _G["ElvUI_StaticPopup1"] then
			_G["ElvUI_StaticPopup1"]:Hide()
		end
		if _G["ElvUI_StaticPopup2"] then
			_G["ElvUI_StaticPopup2"]:Hide()
		end
		if _G["ElvUI_StaticPopup3"] then
			_G["ElvUI_StaticPopup3"]:Hide()
		end
		if _G["ElvUI_StaticPopup4"] then
			_G["ElvUI_StaticPopup4"]:Hide()
		end
		if _G["StreamOverlayWelcomeWindow"] then
			_G["StreamOverlayWelcomeWindow"]:Hide()
		end
		if _G["DetailsWelcomeWindow"] then
			_G["DetailsWelcomeWindow"]:Hide()
		end
		if _G["DetailsNewsWindow"] then
			_G["DetailsNewsWindow"]:Hide()
		end
		--if IsAddOnLoaded("Details") then
			--_detalhes:DisablePlugin ("DETAILS_PLUGIN_STREAM_OVERLAY")
			--_detalhes:DisablePlugin ("Details_Streamer")
		--end
		if _G["CappingFrame"] then
			_G["CappingFrame"]:Hide()
		end
		if IsAddOnLoaded("GladiusEx") then
			GladiusEx:HideFrames()
			--[[if _G["GladiusExPartyFrame"] then
				_G["GladiusExPartyFrame"]:Hide()
			end
			if _G["GladiusExArenaFrame"] then
				_G["GladiusExArenaFrame"]:Hide()
			end]]
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
		if tostring(C_CVar.GetCVar("enableFloatingCombatText")) == "1" then
			if E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext and not E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
				if IsAddOnLoaded('ElvUI_FCT') or IsAddOnLoaded('NameplateSCT') then
					SetCVar("enableFloatingCombatText", 0)
					SetCVar("floatingCombatTextCombatHealing", 0)
					SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0)
					SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)
					SetCVar("floatingCombatTextCombatDamage", 0)
				end
			end
		end
		if tostring(C_CVar.GetCVar("floatingCombatTextEnergyGains")) == "0" or tostring(C_CVar.GetCVar("enableFloatingCombatText")) == "0" then
			if E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
				SetCVar("floatingCombatTextEnergyGains", 1)
				SetCVar("enableFloatingCombatText", 1) ----this is damage taken without this the floating resource will not work
			end
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

		SetCVar('ActionButtonUseKeyDown', 1) --fix bc key down > right click
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
function ElvUI_EltreumUI:Anchors()
	if E.private.unitframe.enable then
		--Anchor for general weakauras, like those that replace actionbars
		EltreumWAAnchor:SetParent(_G["ElvUF_Player"])
		EltreumWAAnchor:SetFrameStrata("BACKGROUND")
		--position the anchor around the place where the action bars would be
		EltreumWAAnchor:Size(250, 70)
		--E:CreateMover(parent, name, textString, overlay, snapoffset, postdrag, types, shouldDisable, configString, ignoreSizeChanged)
		E:CreateMover(EltreumWAAnchor, "MoverEltruismWA", "EltruismWA", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')
		--do it again
		EltreumWAAnchor2:SetParent(_G["ElvUF_Player"])
		EltreumWAAnchor2:SetFrameStrata("BACKGROUND")
		EltreumWAAnchor2:Size(250, 70)
		E:CreateMover(EltreumWAAnchor2, "MoverEltruismWA2", "EltruismWA2", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')

		--consumable weakauras, usually placed near player unitframe
		EltruismWAConsumablesAnchor:SetParent(_G["ElvUF_Player"])
		EltruismWAConsumablesAnchor:SetFrameStrata("BACKGROUND")
		EltruismWAConsumablesAnchor:Size(270, 30)
		E:CreateMover(EltruismWAConsumablesAnchor, "MoverEltruismWAConsumables", L["EltruismConsumablesWA"], nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')
	end

	E:CreateMover(RaidWarningFrame, "MoverRaidWarningFrame", "Raid Warning Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")

	--mover for UI errors frame
	if E.db.ElvUI_EltreumUI.skins.blizzframes.hideerrorframe then
		UIErrorsFrame:Clear()
		UIErrorsFrame:Hide()
	else
		E:CreateMover(UIErrorsFrame, "MoverUIERRORS", "UI Error Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		if E.db.ElvUI_EltreumUI.skins.blizzframes.errorframe then
			if E.Retail and E.db.general.fontStyle == "NONE" then
				UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize, "")
			else
				UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize, E.db.general.fontStyle)
			end
		end
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
		E:CreateMover(RaidBossEmoteFrame, "MoverRaidBossEmoteFrame", "Raid/Boss Emote Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		--E:CreateMover(BossBanner, "MoverBossBanner", "Boss Loot Banner", nil, nil, nil, "ALL,SOLO,ELTREUMUI") --doesnt work
		--this doesnt seem to work well, rather if you set font size to like 200 it becomes less blurry, but if its 12 its very blurry
		--[[if E.db.ElvUI_EltreumUI.skins.blizzframes.raidbossframe then
			RaidWarningFrameSlot1:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.raidbossframefontsize, E.db.general.fontStyle)
			RaidWarningFrameSlot2:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.raidbossframefontsize, E.db.general.fontStyle)
			--RaidBossEmoteFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.raidbossframefontsize, E.db.general.fontStyle)
		end]]

		if E.db.ElvUI_EltreumUI.skins.blizzframes.hideboss then
			_G.BossBanner:UnregisterAllEvents()
			E:DisableMover('BossBannerMover')
		end

		if not _G["ObjectiveFrameHolder"] then --TODO DRAGONFLIGHT
			local B = E:GetModule('Blizzard')
			local holder = CreateFrame('Frame', 'ObjectiveFrameHolder', E.UIParent)
			holder:Point('TOPRIGHT', E.UIParent, 'TOPRIGHT', -135, -300)
			holder:Size(130, 22)

			E:CreateMover(holder, 'ObjectiveFrameMover', L["Objective Frame"], nil, nil, B.HandleMawBuffsFrame, nil, nil, 'ALL,general,blizzUIImprovements')
			holder:SetAllPoints(_G.ObjectiveFrameMover)

			E:Delay(0, function()
				local tracker = _G.ObjectiveTrackerFrame
				tracker:SetClampedToScreen(false)
				tracker:ClearAllPoints()
				tracker:Point('TOP', holder, 'TOP')
				tracker:SetMovable(true)
				tracker:SetUserPlaced(true) -- UIParent.lua line 3090 stops it from being moved <3
			end)

		end
	end
end

-- UI Scale
function ElvUI_EltreumUI:SetupScale()
	E.global["general"]["UIScale"] = 0.71111111111111
	if (not IsAddOnLoaded("ElvUI_SLE")) then
		SetCVar('uiScale', 0.71111111111111)
	end
end

function ElvUI_EltreumUI:AutoScale()
	local a = E:PixelBestSize()
	SetCVar('uiScale', a)
	E.global["general"]["UIScale"] = a
	ElvUI_EltreumUI:Print(L["A scale of "..a.." has automatically been set."])
end

--World text Scale
function ElvUI_EltreumUI:WorldTextScale(value)
	E.db.ElvUI_EltreumUI.otherstuff.worldtextscale = value
	SetCVar('WorldTextScale', value)
end

--set some CVars when entering world
function ElvUI_EltreumUI:EnteringWorldCVars()
	--SetCVars at start
	SetCVar('nameplateOtherBottomInset', E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset)
	SetCVar('nameplateOtherTopInset', E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset)
	SetCVar('cameraDistanceMaxZoomFactor', E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor)
	SetCVar('nameplateTargetRadialPosition', E.db.ElvUI_EltreumUI.cvars.nameplateTargetRadialPosition)
	--ElvUI_EltreumUI:Print(L["Custom Nameplate CVars were set."])
	if E.Retail and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable then
		SetCVar('showInGameNavigation', E.db.ElvUI_EltreumUI.cvars.showInGameNavigation)
	elseif E.Classic or E.Wrath or E.TBC then
		SetCVar('clampTargetNameplateToScreen', E.db.ElvUI_EltreumUI.cvars.clampTargetNameplateToScreen)
	end
end

function ElvUI_EltreumUI:AlternativeGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,UIParent,TOPLEFT,4,-432"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,UIParent,TOPLEFT,104,-328"
		E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,7,-321"
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid1"]["height"] = 30
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_LEFT"
		--E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 10
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 2
		--E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 1
		--E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 25
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["width"] = 120
		E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 5
		E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid3"]["height"] = 30
		E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Alternative Group, Raid and Raid40 layout has been set"])

		E.db.ElvUI_EltreumUI.otherstuff.alternativegroups = true

		E:UpdateLayout()
		E:UpdateUnitFrames()
		E:UpdateMoverPositions()
	else
		ElvUI_EltreumUI:Print(L["The alternative layout was made for the Eltruism DPS/Tank profile, please switch to it to use it"])
	end
end

function ElvUI_EltreumUI:OriginalGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-247"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid1"]["height"] = 28
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 0
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid1"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["height"] = 28
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid3"]["height"] = 29
		E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Original Group, Raid and Raid40 layout has been set"])

		E.db.ElvUI_EltreumUI.otherstuff.alternativegroups = false

		E:UpdateLayout()
		E:UpdateUnitFrames()
		E:UpdateMoverPositions()
	else
		ElvUI_EltreumUI:Print(L["The original layout was made for the Eltruism DPS/Tank profile, please switch to it to use it"])
	end
end

--Better EventTrace CLEU logging thanks to ;Meorawr.wtf.lua;
function ElvUI_EltreumUI:DevTools()
	if E.db.ElvUI_EltreumUI.dev then
		--addon specific cpu/memory usage
		--/run UpdateAddOnCPUUsage() UpdateAddOnMemoryUsage() print("cpu: "..((math.floor(GetAddOnCPUUsage("ElvUI_EltreumUI")))).."ms | memory: "..((math.floor(GetAddOnMemoryUsage("ElvUI_EltreumUI")/10))/100).."mb")

		local function LogEvent(self, event, ...)
			if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then
				self:LogEvent_Original(event, CombatLogGetCurrentEventInfo())
			elseif event == "COMBAT_TEXT_UPDATE" then
				self:LogEvent_Original(event, (...), GetCurrentCombatTextEventInfo())
			else
				self:LogEvent_Original(event, ...)
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
			frame:SetScript("OnEvent", function(self, event, ...)
				if event == "ADDON_LOADED" and (...) == "Blizzard_EventTrace" then
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
		--[[
			_G.RightChatToggleButton:SetPoint('TOPLEFT', _G.DTPanelEltruismMover, 'TOPRIGHT', 0, 0)
			_G.RightChatToggleButton:SetPoint('BOTTOMRIGHT', _G.DTPanelEltruismMover, 'BOTTOMRIGHT', 0, 0)
			_G.LeftChatToggleButton:SetPoint("RIGHT", _G.DTPanelEltruismMover,"LEFT",0,0)
		]]
		_G.LeftChatToggleButton:SetAlpha(1)
		_G.LeftChatToggleButton:Show()

		--nice but the fix datatext button should solve it already
		--local buttonwidth = _G.RightChatToggleButton:GetWidth()
		--local width = GetScreenWidth()
		--E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 2 + math.ceil(width - (buttonwidth * 2))
		--E:UpdateDataTexts()

		--[[
			_G.LeftChatToggleButton:SetPoint('TOPRIGHT', _G.DTPanelEltruismMover, 'TOPLEFT', 0, 0)
			_G.LeftChatToggleButton:SetPoint('BOTTOMLEFT', _G.DTPanelEltruismMover, 'BOTTOMLEFT', 0, 0)
			_G.RightChatToggleButton:SetPoint("LEFT", _G.DTPanelEltruismMover,"RIGHT",0,0)
		]]
		_G.RightChatToggleButton:SetAlpha(1)
		_G.RightChatToggleButton:Show()
	end
end

function ElvUI_EltreumUI:DeleteItem()
	if E.db.ElvUI_EltreumUI.otherstuff.delete and not self.isDeleteHooked then
		local throttle = 0
		self.isDeleteHooked = true
		local function TypeDelete(self)
			local itemLink = select(3, GetCursorInfo())
			local lootName = select(1, GetItemInfo(itemLink))
			local lootTexture = select(10, GetItemInfo(itemLink))
			if lootName == nil or lootTexture == nil then
				return
			else
				local text = _G.StaticPopup1Text:GetText()
				if not text:match("|T") then
					local deletetext = string.gsub(text, lootName, "|T"..lootTexture..":".. 14 .."|t"..itemLink.."")
					_G.StaticPopup1Text:SetText(deletetext)
				end
				self.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028
				if throttle == 0 then
					throttle = 1
					ElvUI_EltreumUI:Print("DELETE automatically typed")
					C_Timer.After(1, function()
						throttle = 0
					end)
				end
			end
		end
		hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"],"OnShow",function(self) --Interface/FrameXML/StaticPopup.lua line 1965/2074
			TypeDelete(self)
		end)
		hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"],"OnShow",function(self) --Interface/FrameXML/StaticPopup.lua line 2125
			TypeDelete(self)
		end)
	end
end

--from elvui api
local EltruismMenuButton = CreateFrame('Button', nil, GameMenuFrame, 'GameMenuButtonTemplate')
local isMenuExpanded = false
local EltruismGameMenu = CreateFrame("Frame")
EltruismGameMenu:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismGameMenu:SetScript("OnEvent", function()

	--use elvui moveui instead of blizzard edit mode
	--[[if _G.GameMenuButtonEditMode then --TODO DRAGONFLIGHT
		_G.GameMenuButtonEditMode:SetScript("OnClick", function()
			E:ToggleMoveMode()
			HideUIPanel(_G["GameMenuFrame"])
		end)
	end]]

	if E.db.ElvUI_EltreumUI.otherstuff.gamemenu and isMenuExpanded == false then
		--EltruismMenuButton:SetText("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0:64:64:5:59:5:59|t".. ElvUI_EltreumUI.Name)
		EltruismMenuButton:SetText(ElvUI_EltreumUI.Name)
		S:HandleButton(EltruismMenuButton)
		local x, y = _G["GameMenuButtonLogout"]:GetSize()
		EltruismMenuButton:SetSize(x,y)
		EltruismMenuButton:SetScript("OnClick", function()
			if not InCombatLockdown() then
				E:ToggleOptionsUI()
				E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
				HideUIPanel(_G["GameMenuFrame"])
			end
		end)

		hooksecurefunc('GameMenuFrame_UpdateVisibleButtons', function ()
			EltruismMenuButton:Point("TOP", GameMenuFrame.ElvUI, "BOTTOM", 0, -1)
			if _G["GameMenu_SLEConfig"] and not _G["GameMenuReloadUI"] then
				EltruismMenuButton:Point("TOP", _G["GameMenu_SLEConfig"], "BOTTOM", 0, -1)
			elseif _G["GameMenuReloadUI"] then
				EltruismMenuButton:Point("TOP", _G["GameMenuReloadUI"], "BOTTOM", 0, -1)
			end
		end)

		_G["GameMenuFrame"]:HookScript("OnShow", function()
			_G["GameMenuButtonLogout"]:ClearAllPoints()
			_G["GameMenuButtonLogout"]:SetPoint("TOP", EltruismMenuButton, "BOTTOM", 0, -y)
			_G["GameMenuFrame"]:SetHeight(_G["GameMenuFrame"]:GetHeight() + _G["GameMenuButtonLogout"]:GetHeight() + 4)
		end)
		isMenuExpanded = true
	end
end)

--make the video options movable because its annoying when adjusting settings
local VideoOptionsFrame = _G.VideoOptionsFrame  --TODO DRAGONFLIGHT
if VideoOptionsFrame then
	VideoOptionsFrame:SetMovable(true)
	VideoOptionsFrame:EnableMouse(true)
	VideoOptionsFrame:RegisterForDrag("LeftButton")
	VideoOptionsFrame:SetScript("OnDragStart", VideoOptionsFrame.StartMoving)
	VideoOptionsFrame:SetScript("OnDragStop", VideoOptionsFrame.StopMovingOrSizing)
	VideoOptionsFrame:SetClampedToScreen(true)
end

--click casting button toggle
if E.Retail then
	local clickbindopenbutton = CreateFrame("Button", "EltruismClickCastingToggle")
	clickbindopenbutton:SetWidth(32)
	clickbindopenbutton:SetHeight(32)
	clickbindopenbutton:SetParent(_G["SpellBookSpellIconsFrame"])
	clickbindopenbutton:SetPoint("LEFT", _G["SpellBookFrame"], "RIGHT", 0, -105)
	if _G["CliqueSpellTab"] then
		clickbindopenbutton:SetPoint("BOTTOM", _G["CliqueSpellTab"], 0, -50)
	end

	S:HandleButton(clickbindopenbutton)
	local bindexture = clickbindopenbutton:CreateTexture()
	bindexture:SetTexture(4238928)
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

	clickbindopenbutton:SetScript('OnClick', function()
		if not IsAddOnLoaded("Blizzard_ClickBindingUI") then
			LoadAddOn("Blizzard_ClickBindingUI")
			if not _G["ClickBindingFrame"].shadow then
				_G["ClickBindingFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["ClickBindingFrame"].shadow) end
			end
		end
		if not _G["ClickBindingFrame"]:IsShown() then
			_G["ClickBindingFrame"]:Show()
		elseif _G["ClickBindingFrame"]:IsShown() then
			_G["ClickBindingFrame"]:Hide()
			_G["SpellBookFrame"]:Show()
		end
		_G["ClickBindingFrame"]:ClearAllPoints()
		_G["ClickBindingFrame"]:SetParent(_G["SpellBookFrame"])
		_G["ClickBindingFrame"]:SetPoint("LEFT", _G["SpellBookFrame"], "RIGHT", 50, -37)
	end)
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
