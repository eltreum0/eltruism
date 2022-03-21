local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local C_CVar = _G.C_CVar
local S = E:GetModule('Skins')

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	print('|cff82B4ffEltruism|r: '..msg)
end

--hide popups during install
function ElvUI_EltreumUI:HidePopups()
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		local W = unpack(WindTools)
		local function WindtoolsCompatHideWhileInstall()
			WTCompatibilityFrame:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibilityFrame", WindtoolsCompatHideWhileInstall)
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
	C_Timer.After(5, function()
		if IsAddOnLoaded('Details') then
			if _G["StreamOverlayWelcomeWindow"] then
				_G["StreamOverlayWelcomeWindow"]:Hide()
			end
			if _G["DetailsWelcomeWindow"] then
				_G["DetailsWelcomeWindow"]:Hide()
			end
			if _G["DetailsNewsWindow"] then
				_G["DetailsNewsWindow"]:Hide()
			end
		end
		if IsAddOnLoaded('GladiusEx') then
			if _G["GladiusExPartyFrame"] then
				_G["GladiusExPartyFrame"]:Hide()
			end
			if _G["GladiusExArenaFrame"] then
				_G["GladiusExArenaFrame"]:Hide()
			end
		end
		if IsAddOnLoaded('Gladius') then
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
	--C_CVar.GetCVar('gxFullscreenResolution') == "3840x2160"
	--C_CVar.GetCVar('gxWindowedResolution') == "3840x2160"
	if width == 3840 then
		ElvUI_EltreumUI:Print(L["4K resolution detected, setting fonts to default mode."])
		ElvUI_EltreumUI:SetupFontsOutlineDefault()
	elseif width == 2560 then
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["1440p resolution detected, setting fonts to outline mode."])
	elseif width == 1920 then
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["1080p resolution detected, setting fonts to outline mode."])
	else
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["Fonts were set to Outline due to your resolution."])
	end
end

--turn and off blizzard combat text
function ElvUI_EltreumUI:BlizzCombatText()
	if IsAddOnLoaded('ElvUI_FCT') or IsAddOnLoaded('NameplateSCT') then
		if E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext then
			if E.Retail then
				if not E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
					SetCVar("enableFloatingCombatText", 0)
				end
				SetCVar("floatingCombatTextCombatHealing", 0)
				SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0)
				SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)
				SetCVar("floatingCombatTextCombatDamage", 0)
			elseif E.TBC or E.Classic then
				SetCVar("floatingCombatTextCombatDamage", 0)
			end
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
		SetCVar("floatingCombatTextEnergyGains", 1)
		SetCVar("enableFloatingCombatText", 1) ----this is damage taken without this the floating resource will not work
	end
end

-- Ghost frame for Automatic Weakauras Positioning
local EltreumWAAnchor = CreateFrame("Frame", "EltruismWA", E.UIParent)
local EltreumWAAnchor2 = CreateFrame("Frame", "EltruismWA2", E.UIParent)
local EltruismWAConsumablesAnchor = CreateFrame("Frame", "EltruismConsumablesWA", E.UIParent)
function ElvUI_EltreumUI:Anchors()
	if E.private.unitframe.enable then
		--Anchor for general weakauras, like those that replace actionbars
		EltreumWAAnchor:SetParent("ElvUF_Player")
		EltreumWAAnchor:SetFrameStrata("BACKGROUND")
		--position the anchor around the place where the action bars would be
		EltreumWAAnchor:Point("CENTER", E.UIParent, "CENTER", 0, -380)
		EltreumWAAnchor:Size(250, 70)
		--E:CreateMover(parent, name, textString, overlay, snapoffset, postdrag, types, shouldDisable, configString, ignoreSizeChanged)
		E:CreateMover(EltreumWAAnchor, "MoverEltruismWA", "EltruismWA", nil, nil, nil, "ALL,SOLO")
		--do it again
		EltreumWAAnchor2:SetParent("ElvUF_Player")
		EltreumWAAnchor2:SetFrameStrata("BACKGROUND")
		EltreumWAAnchor2:Point("BOTTOM", E.UIParent, "BOTTOM", 0, 320)
		EltreumWAAnchor2:Size(250, 70)
		E:CreateMover(EltreumWAAnchor2, "MoverEltruismWA2", "EltruismWA2", nil, nil, nil, "ALL,SOLO")

		--consumable weakauras, usually placed near player unitframe
		EltruismWAConsumablesAnchor:SetParent("ElvUF_Player")
		EltruismWAConsumablesAnchor:SetFrameStrata("BACKGROUND")
		--postion the anchor right below the player unitframe
		EltruismWAConsumablesAnchor:Point("LEFT", _G["ElvUF_Player"], 0, -75)
		EltruismWAConsumablesAnchor:Size(270, 30)
		E:CreateMover(EltruismWAConsumablesAnchor, "MoverEltruismWAConsumables", L["EltruismConsumablesWA"], nil, nil, nil, "ALL,SOLO")
	end

	--mover for UI errors frame
	if E.db.ElvUI_EltreumUI.blizzframes.hideerrorframe then
		_G.UIErrorsFrame:Clear()
		_G.UIErrorsFrame:Hide()
	else
		E:CreateMover(_G.UIErrorsFrame, "MoverUIERRORS", "UI Error Frame", nil, nil, nil, "ALL,SOLO")
		if E.db.ElvUI_EltreumUI.blizzframes.errorframe then
			_G.UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.blizzframes.errorframefontsize, E.db.general.fontStyle)
		end
	end

	E:CreateMover(_G.RaidWarningFrame, "MoverRaidWarningFrame", "Raid Warning Frame", nil, nil, nil, "ALL,SOLO")

	if E.Retail then
		E:CreateMover(_G.RaidBossEmoteFrame, "MoverRaidBossEmoteFrame", "Raid/Boss Emote Frame", nil, nil, nil, "ALL,SOLO")
		--E:CreateMover(_G.BossBanner, "MoverBossBanner", "Boss Loot Banner", nil, nil, nil, "ALL,SOLO") --doesnt work
		--this doesnt seem to work well, rather if you set font size to like 200 it becomes less blurry, but if its 12 its very blurry
		--[[if E.db.ElvUI_EltreumUI.blizzframes.raidbossframe then
			_G.RaidWarningFrameSlot1:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.blizzframes.raidbossframefontsize, E.db.general.fontStyle)
			_G.RaidWarningFrameSlot2:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.blizzframes.raidbossframefontsize, E.db.general.fontStyle)
			--_G.RaidBossEmoteFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.blizzframes.raidbossframefontsize, E.db.general.fontStyle)
		end]]
	end
end

-- UI Scale
function ElvUI_EltreumUI:SetupScale()
	E.global["general"]["UIScale"] = 0.7
	if (not IsAddOnLoaded("ElvUI_SLE")) then
		SetCVar('uiScale', 0.7)
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
	if E.Retail then
		SetCVar('showInGameNavigation', E.db.ElvUI_EltreumUI.cvars.showInGameNavigation)
	elseif E.Classic or E.TBC then
		SetCVar('clampTargetNameplateToScreen', E.db.ElvUI_EltreumUI.cvars.clampTargetNameplateToScreen)
	end
end

function ElvUI_EltreumUI:AlternativeGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
		E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,UIParent,TOPLEFT,53,-302"
		--E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,UIParent,TOPLEFT,236,-324"
		E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,UIParent,TOPLEFT,58,-439"
		if E.TBC then
			E.db["unitframe"]["units"]["raid"]["numGroups"] = 5
		else
			E.db["unitframe"]["units"]["raid"]["numGroups"] = 4
		end

		E.db["unitframe"]["units"]["raid"]["height"] = 30
		E.db["unitframe"]["units"]["raid"]["growthDirection"] = "DOWN_RIGHT"
		--E.db["unitframe"]["units"]["raid"]["groupSpacing"] = 10
		E.db["unitframe"]["units"]["raid"]["groupSpacing"] = 2
		--E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 1
		--E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 25
		E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 3
		E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid"]["width"] = 120

		E.db["unitframe"]["units"]["raid40"]["groupSpacing"] = 5
		E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid40"]["height"] = 30
		E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid40"]["width"] = 120
		E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Alternative Group, Raid and Raid40 layout has been set"])

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
		E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		if E.TBC then
			E.db["unitframe"]["units"]["raid"]["numGroups"] = 5
		else
			E.db["unitframe"]["units"]["raid"]["numGroups"] = 4
		end
		E.db["unitframe"]["units"]["raid"]["height"] = 28
		E.db["unitframe"]["units"]["raid"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 0
		E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid"]["width"] = 120
		E.db["unitframe"]["units"]["raid40"]["height"] = 28
		E.db["unitframe"]["units"]["raid40"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid40"]["height"] = 29
		E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid40"]["width"] = 120
		E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Original Group, Raid and Raid40 layout has been set"])

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
		if not EventTraceFrame then
			UIParentLoadAddOn("Blizzard_DebugTools")
			_G.TableAttributeDisplay:SetWidth(800)
			_G.TableAttributeDisplay.LinesScrollFrame:SetWidth(700)
			_G.TableAttributeDisplay.TitleButton.Text:SetWidth(600)
		end
		if not IsAddOnLoaded("Blizzard_EventTrace") then
			LoadAddOn("Blizzard_EventTrace")
		end
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
					frame:UnregisterAllEvents()
				end
			end)
		end
	end
end

function ElvUI_EltreumUI:DeleteItem()
	if E.db.ElvUI_EltreumUI.otherstuff.delete then
		hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"],"OnShow",function(self) --Interface/FrameXML/StaticPopup.lua line 1965/2074
			local itemLink = select(3, GetCursorInfo())
			local lootName = select(1, GetItemInfo(itemLink))
			local lootTexture = select(10, GetItemInfo(itemLink))
			if lootName == nil or lootTexture == nil then
				return
			end
			local text = StaticPopup1Text:GetText()
			if not text:match("|T") then
				local deletetext = string.gsub(text, lootName, "|T"..lootTexture..":".. 14 .."|t"..itemLink.."")
				StaticPopup1Text:SetText(deletetext)
			end
			self.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028
			ElvUI_EltreumUI:Print("DELETE automatically typed")
		end)

		hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"],"OnShow",function(self) --Interface/FrameXML/StaticPopup.lua line 2125
			local itemLink = select(3, GetCursorInfo())
			local lootName = select(1, GetItemInfo(itemLink))
			local lootTexture = select(10, GetItemInfo(itemLink))
			if lootName == nil or lootTexture == nil then
				return
			end
			local text = StaticPopup1Text:GetText()
			if not text:match("|T") then
				local deletetext = string.gsub(text, lootName, "|T"..lootTexture..":".. 14 .."|t"..itemLink.."")
				StaticPopup1Text:SetText(deletetext)
			end
			self.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028
			ElvUI_EltreumUI:Print("DELETE automatically typed")
		end)
	end
end

--from elvui api
--function ElvUI_EltreumUI:SkinGameMenu()
local function SkinGameMenu()
	if E.private == nil then
		return
	elseif E.private.ElvUI_EltreumUI == nil then
		return
	elseif E.private.ElvUI_EltreumUI.install_version == nil then
		return
	end
	if E.db.ElvUI_EltreumUI.otherstuff.gamemenu then
		local EltruismMenuButton = CreateFrame('Button', nil, _G.GameMenuFrame, 'GameMenuButtonTemplate')
		--EltruismMenuButton:SetText("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0:64:64:5:59:5:59|t".. ElvUI_EltreumUI.Name)
		EltruismMenuButton:SetText(ElvUI_EltreumUI.Name)
		S:HandleButton(EltruismMenuButton)
		local x, y = _G["GameMenuButtonLogout"]:GetSize()
		EltruismMenuButton:SetSize(x,y)
		EltruismMenuButton:SetScript("OnClick", function()
			E:ToggleOptionsUI()
			E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
			if not InCombatLockdown() then
				HideUIPanel(_G["GameMenuFrame"])
			end
		end)

		hooksecurefunc('GameMenuFrame_UpdateVisibleButtons', function ()
			EltruismMenuButton:Point("TOP", _G.GameMenuFrame.ElvUI, "BOTTOM", 0, -1)
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
	end
end
SkinGameMenu()

--make the video options movable because its annoying when adjusting settings
_G.VideoOptionsFrame:SetMovable(true)
_G.VideoOptionsFrame:EnableMouse(true)
_G.VideoOptionsFrame:RegisterForDrag("LeftButton")
_G.VideoOptionsFrame:SetScript("OnDragStart", _G.VideoOptionsFrame.StartMoving)
_G.VideoOptionsFrame:SetScript("OnDragStop",_G.VideoOptionsFrame.StopMovingOrSizing)
_G.VideoOptionsFrame:SetClampedToScreen(true)

--click casting button toggle
if E.Retail then
	local clickbindopenbutton = CreateFrame("Button", nil)
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
		_G['GameTooltip']:SetOwner(clickbindopenbutton, 'ANCHOR_RIGHT')
		_G['GameTooltip']:AddLine(L["Toggle the Click Casting Menu"])
		_G['GameTooltip']:Show()
	end)
	clickbindopenbutton:SetScript("OnLeave", function()
		_G['GameTooltip']:Hide()
	end)

	clickbindopenbutton:SetScript('OnClick', function()
		if not IsAddOnLoaded("Blizzard_ClickBindingUI") then
			LoadAddOn("Blizzard_ClickBindingUI")
			if not _G["ClickBindingFrame"].shadow then
				_G["ClickBindingFrame"]:CreateShadow()
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
