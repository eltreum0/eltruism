local E, L = unpack(ElvUI)
local _G = _G
local S = E:GetModule('Skins')
local CreateFrame = _G.CreateFrame
local print = _G.print
local unpack = _G.unpack
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local DisableAddOn = _G.C_AddOns and _G.C_AddOns.DisableAddOn
local LoadAddOn = _G.C_AddOns and _G.C_AddOns.LoadAddOn
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
local strsub = _G.strsub
local ShowUIPanel = _G.ShowUIPanel
local EditModeManagerFrame = _G.EditModeManagerFrame
local SOUNDKIT = _G.SOUNDKIT
local pairs = _G.pairs
local StaticPopupDialogs = _G.StaticPopupDialogs
local ceil = _G.ceil
local BuffFrame = _G.BuffFrame
local GetSpellInfo = _G.C_Spell and _G.C_Spell.GetSpellInfo or _G.GetSpellInfo
local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
local select = _G.select

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	--print('|cff82B4ffEltruism|r: '..msg)
	if not msg then return end
	print(E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1)..': '..msg)
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
		if IsAddOnLoaded("GladiusEx") then
			_G.GladiusEx:HideFrames()
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
			if E.Retail then
				SetCVar("floatingCombatTextCombatDamage_v2", 0)
			end
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

		if E.Retail then
			SetCVar("floatingCombatTextCombatDamage_v2", 1)
			SetCVar("floatingCombatTextCombatLogPeriodicSpells_v2", 1)
			SetCVar("floatingCombatTextPetMeleeDamage_v2", 1)
			SetCVar("floatingCombatTextPetSpellDamage_v2", 1)
		end
	end
end

--to get the correct name for the files
--https://stackoverflow.com/questions/2421695/first-character-uppercase-lua
function ElvUI_EltreumUI:firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

--copy of elvui abbrev
function ElvUI_EltreumUI:Abbrev(name)
	local letters, lastWord = '', _G.strmatch(name, '.+%s(.+)$')
	if lastWord then
		for word in _G.gmatch(name, '.-%s') do
			local firstLetter = string.utf8sub(_G.gsub(word, '^[%s%p]*', ''), 1, 1)
			if firstLetter ~= string.utf8lower(firstLetter) then
				letters = format('%s%s. ', letters, firstLetter)
			end
		end
		name = format('%s%s', letters, lastWord)
	end
	return name
end

local classcolorcast = {
	["DEATHKNIGHT"]	= "FFC41E3A",
	["DEMONHUNTER"]	= "FFA330C9",
	["DRUID"] = "FFFF7C0A",
	["HUNTER"] = "FFAAD372",
	["MAGE"] = "FF3FC7EB",
	["MONK"] = "FF00FF98",
	["PALADIN"]	= "FFF48CBA",
	["PRIEST"] = "FFFFFFFF",
	["ROGUE"] = "FFFFF468",
	["SHAMAN"] = "FF0070DD",
	["WARLOCK"] = "FF8788EE",
	["WARRIOR"] = "FFC69B6D",
	["HOSTILE"] = "FFFF0000",
	["UNFRIENDLY"] = "FFF26000",
	["NEUTRAL"] = "FFE4E400",
	["FRIENDLY"] = "FF33FF33",
	["EVOKER"] = "FF33937F",
}
function ElvUI_EltreumUI:classcolorcast(unitclass)
	if classcolorcast[unitclass] then
		return classcolorcast[unitclass]
	end
end

--level difference table based on blizzard's
local eltruismdif = {
	["-9"] = "|cFF808080",
	["-8"] = "|cFF008000",
	["-7"] = "|cFF008000",
	["-6"] = "|cFF008000",
	["-5"] = "|cFF008000",
	["-4"] = "|cFF008000",
	["-3"] = "|cFF008000",
	["-2"] = "|cFFFFFF00",
	["-1"] = "|cFFFFFF00",
	["0"] = "|cFFFFFF00",
	["1"] = "|cFFFFFF00",
	["2"] = "|cFFFFFF00",
	["3"] = "|cFFFFA500",
	["4"] = "|cFFA50000",
	["5"] = "|cFFFF0000",
}
function ElvUI_EltreumUI:eltruismdif(value)
	if value and eltruismdif[value] then
		return eltruismdif[value]
	end
end

-- Ghost frame for Automatic Weakauras Positioning
local EltreumWAAnchor
local EltreumWAAnchor2
local EltruismWAConsumablesAnchor
if not E.Retail then
	EltreumWAAnchor = CreateFrame("Frame", "EltruismWA", E.UIParent)
	EltreumWAAnchor:SetPoint("CENTER", E.UIParent, "CENTER", 0, -380)
	EltreumWAAnchor2 = CreateFrame("Frame", "EltruismWA2", E.UIParent)
	EltreumWAAnchor2:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 320)
	EltruismWAConsumablesAnchor = CreateFrame("Frame", "EltruismConsumablesWA", E.UIParent)
	--postion the anchor right below the player unitframe
	EltruismWAConsumablesAnchor:SetPoint("LEFT", _G["ElvUF_Player"], 0, -75)
end
--archeology mover
local EltreumArcheologyAnchor = CreateFrame("Frame", "EltruismArcheology", E.UIParent)
EltreumArcheologyAnchor:SetPoint("TOP", E.UIParent, "TOP", 0, -230)
EltreumArcheologyAnchor:SetSize(200, 50)

function ElvUI_EltreumUI:Anchors()
	if E.private.unitframe.enable then

		if not E.Retail then
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
		end

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

		--recreate the mirror timer mover
		--E:CreateMover(_G.MirrorTimerContainer, 'MirrorTimerMover', L["MirrorTimer"], nil, nil, nil, 'ALL,SOLO')
		E:CreateMover(_G.MirrorTimerContainer, 'MirrorTimerMover', L["MirrorTimer"], nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,skins,general,blizzard')

		_G.ArcheologyDigsiteProgressBar:BreakFromFrameManager()
		_G.ArcheologyDigsiteProgressBar:ClearAllPoints()
		_G.ArcheologyDigsiteProgressBar:SetPoint("CENTER", _G["EltruismArcheology"], "CENTER", 0, 0)

		if E.db.ElvUI_EltreumUI.skins.blizzframes.hideboss then
			_G.BossBanner:UnregisterAllEvents()
			E:DisableMover('BossBannerMover')
		end
	end

	if E.db.ElvUI_EltreumUI.skins.blizzframes.hideeventoaster then
		if _G.EventToastManagerFrame then
			_G.EventToastManagerFrame:UnregisterAllEvents()
		end
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
	elseif E.Classic or E.Mists or E.TBC or E.Wrath then
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
				frame:LogEvent_Original(event, _G.CombatLogGetCurrentEventInfo())
			elseif event == "COMBAT_TEXT_UPDATE" then
				frame:LogEvent_Original(event, (...), _G.GetCurrentCombatTextEventInfo())
			else
				frame:LogEvent_Original(event, ...)
			end
		end

		local function OnEventTraceLoaded()
			_G.EventTrace.LogEvent_Original = _G.EventTrace.LogEvent
			_G.EventTrace.LogEvent = LogEvent
		end

		if _G.EventTrace then
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
					_G.TableAttributeDisplay:SetWidth(800)
					_G.TableAttributeDisplay.LinesScrollFrame:SetWidth(700)
					_G.TableAttributeDisplay.TitleButton.Text:SetWidth(600)
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

			if E.db.ElvUI_EltreumUI.skins.shadow.enable and _G[datatextname].template and _G[datatextname].template ~= 'NoBackdrop' and not E.db.ElvUI_EltreumUI.borders.universalborders then
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

		if _G.StaticPopup1.EditBox then
			_G.StaticPopup1.EditBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028
		else
			_G.StaticPopup1.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028
		end

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
		if E.Retail or E.TBC then
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

				local offset = E.TBC and 19 or 36
				local xMenubutton = _G.GameMenuFrame:GetSize()
				if E.TBC then
					Menubutton:Size(xMenubutton-118, offset)
				else
					Menubutton:Size(xMenubutton-62, offset)
				end

				GameMenuFrame.Eltruism = Menubutton
				GameMenuFrame.MenuButtons.Eltruism = Menubutton

				hooksecurefunc(GameMenuFrame, 'Layout', function()
					GameMenuFrame.MenuButtons.Eltruism:SetPoint("CENTER", _G.GameMenuFrame, "TOP", 0, -20)
					for _, button in pairs(GameMenuFrame.MenuButtons) do
						if button then
							local point, anchor, point2, x, y = button:GetPoint()
							button:SetPoint(point, anchor, point2, x, y - offset)
						end
					end

					--local originalMenuHeight = GameMenuFrame:GetHeight() --this gives 538 so,
					if E.Retail then
						GameMenuFrame:Height(538 + offset) --yes i can set the actual math but this lets me recall its + menubutton height
					end

					--use elvui moveui instead of blizzard edit mode
					local EditModeButton = _G.GameMenuFrame.MenuButtons and _G.GameMenuFrame.MenuButtons[_G.HUD_EDIT_MODE_MENU]
					if EditModeButton then
						EditModeButton:RegisterForClicks("AnyUp")
						EditModeButton:SetScript("OnClick", function(_, button)
							if not InCombatLockdown() then
								if button == "LeftButton" then
									E:ToggleMoveMode()
									HideUIPanel(_G["GameMenuFrame"])
								else
									PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)
									ShowUIPanel(EditModeManagerFrame)
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
					if GameMenuFrame.ElvUI then
						EltruismMenuButton:Point("TOP", GameMenuFrame.ElvUI, "BOTTOM", 0, -1)
					else
						EltruismMenuButton:Point("TOP", _G.GameMenuButtonAddons, "BOTTOM", 0, -1)
					end
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
if VideoOptionsFrame and not VideoOptionsFrame:HasScript("OnDragStart") then
	VideoOptionsFrame:SetMovable(true)
	VideoOptionsFrame:EnableMouse(true)
	VideoOptionsFrame:RegisterForDrag("LeftButton")
	VideoOptionsFrame:SetScript("OnDragStart", VideoOptionsFrame.StartMoving)
	VideoOptionsFrame:SetScript("OnDragStop", VideoOptionsFrame.StopMovingOrSizing)
	VideoOptionsFrame:SetClampedToScreen(true)
end
local SettingsPanel = _G.SettingsPanel --Dragonflight onwards
if SettingsPanel then
	if SettingsPanel:HasScript("OnDragStart") then
		SettingsPanel:SetScript("OnDragStart", nil)
		SettingsPanel:SetScript("OnDragStop", nil)
		SettingsPanel:SetMovable(true)
		SettingsPanel:EnableMouse(true)
		SettingsPanel:RegisterForDrag("LeftButton")
		SettingsPanel:SetScript("OnDragStart", SettingsPanel.StartMoving)
		SettingsPanel:SetScript("OnDragStop", SettingsPanel.StopMovingOrSizing)
		SettingsPanel:SetClampedToScreen(true)
	else
		SettingsPanel:SetMovable(true)
		SettingsPanel:EnableMouse(true)
		SettingsPanel:RegisterForDrag("LeftButton")
		SettingsPanel:SetScript("OnDragStart", SettingsPanel.StartMoving)
		SettingsPanel:SetScript("OnDragStop", SettingsPanel.StopMovingOrSizing)
		SettingsPanel:SetClampedToScreen(true)
	end
end

--click casting button toggle
local clickbindopenbutton, bindexture,clickcastingmonitor
function ElvUI_EltreumUI:ClickCastingShortcut()
	if not E.db.ElvUI_EltreumUI.otherstuff.ClickCastingShortcut then return end
	if not _G["EltruismClickCastingToggle"] then
		clickbindopenbutton = CreateFrame("Button", "EltruismClickCastingToggle")
		bindexture = clickbindopenbutton:CreateTexture("EltruismClickCastingToggleTexture")
		clickbindopenbutton:SetWidth(32)
		clickbindopenbutton:SetHeight(32)
		S:HandleButton(clickbindopenbutton)
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

		clickcastingmonitor = CreateFrame("FRAME","EltruismClickCastingAddOnMonitor")
		clickcastingmonitor:RegisterEvent("ADDON_LOADED") --add option to disable this
		clickcastingmonitor:SetScript("OnEvent", function(_,_,addon)
			if (addon == "Blizzard_PlayerSpells") or IsAddOnLoaded("Blizzard_PlayerSpells") then
				if not InCombatLockdown() then
					SetCVar("enableMouseoverCast", 1) --this will prevent people not having mouse over cast if the blizzard addon is loaded
				end
				clickcastingmonitor:UnregisterEvent("ADDON_LOADED")
				clickbindopenbutton:SetParent(_G["PlayerSpellsFrame"])
				clickbindopenbutton:SetPoint("LEFT", _G["PlayerSpellsFrame"], "TOPRIGHT", 0, -80)
				clickbindopenbutton:SetScript('OnClick', function()
					if not IsAddOnLoaded("Blizzard_ClickBindingUI") then
						LoadAddOn("Blizzard_ClickBindingUI")
						if not _G["ClickBindingFrame"].shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
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

--reforged armory compatibility check
function ElvUI_EltreumUI:ReforgedCheck(setting)
	if not IsAddOnLoaded("ReforgedArmory") or not setting or not (E.Mists or E.TBC or E.Wrath) then return false end
	if setting == 'avgItemLevel' and E.db.cataarmory.character.avgItemLevel.enable then
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

function ElvUI_EltreumUI:SpellInfoShapeshift(spellID,ShapeshiftFormID)
	if ShapeshiftFormID then
		if GetShapeshiftFormInfo(1) then
			spellID = select(4,GetShapeshiftFormInfo(ShapeshiftFormID))
			if spellID then
				local spellData = GetSpellInfo(spellID)
				if spellData.name then
					return spellData.name
				else
					return ""
				end
			else
				return ""
			end
		else
			return ""
		end
	elseif spellID then
		local spellData = GetSpellInfo(spellID)
		return spellData.name
	end
end

function ElvUI_EltreumUI:EltruismSpellInfo(spellID)
	local spellData = GetSpellInfo(spellID)
	if spellData then
		return spellData.name, spellData.spellID, spellData.iconID
	else
		return "UNKNOWN", 187874, 136244--fallback value
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

function ElvUI_EltreumUI:RetailInstanceSecret(value,hasValue)
	if E.Retail then
		if hasValue then
			if _G.canaccessvalue(value) then --new api to check if value is secret
				return false
			else
				return true
			end
		else
			local _, instanceType = _G.IsInInstance()
			if instanceType ~= "none" then
				return true
			else
				return false
			end
		end
	else
		return false
	end
end
