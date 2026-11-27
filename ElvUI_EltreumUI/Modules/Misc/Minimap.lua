local E, L, _, P = unpack(ElvUI)
local M = E:GetModule('Minimap')
local S = E:GetModule('Skins')
local valuecolors = E.myClassColor
local _G = _G
local CreateFrame = _G.CreateFrame
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local Minimap = _G.Minimap
local GetPlayerFacing = _G.GetPlayerFacing
local GetMinimapZoneText = _G.GetMinimapZoneText
local Enum = _G.Enum
local InCombatLockdown = _G.InCombatLockdown
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc
local math = _G.math
local mathabs = math.abs
local mathfloor = math.floor
local mathmax = math.max
local utf8sub = _G.string.utf8sub
local strfind = _G.string.find
local EnumerateFrames = _G.EnumerateFrames
local type = _G.type
local setmetatable = _G.setmetatable

--scale the world map in retail
function ElvUI_EltreumUI:WorldMapScale()
	if E.db.ElvUI_EltreumUI.otherstuff.worldmapscale then
		if _G["WorldMapFrame"] then
			if not _G["WorldMapFrame"].EltruismScaleHooked then
				_G["WorldMapFrame"]:HookScript("OnShow", function()
					if not E.Modern then
						if not InCombatLockdown() then
							if not IsAddOnLoaded("Leatrix_Maps") then
								_G["WorldMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.worldmapscalevalue)
							end
							if not _G["WorldMapFrame"]:HasScript("OnDragStart") then
								_G["WorldMapFrame"]:SetMovable(true)
								_G["WorldMapFrame"]:EnableMouse(true)
								_G["WorldMapFrame"]:RegisterForDrag("LeftButton")
								_G["WorldMapFrame"]:SetScript("OnDragStart", _G["WorldMapFrame"].StartMoving)
								_G["WorldMapFrame"]:SetScript("OnDragStop", _G["WorldMapFrame"].StopMovingOrSizing)
								_G["WorldMapFrame"]:SetClampedToScreen(true)
							end
						end
					else
						if not InCombatLockdown() and ElvUI_EltreumUI:IsThisASafeSecret(_G["WorldMapFrame"],true) then
							_G["WorldMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.worldmapscalevalue)
						end
					end
				end)
				_G["WorldMapFrame"].EltruismScaleHooked = true
			end

			--make the bounty select mouseover
			if E.Modern then
				for _, v in pairs({_G["WorldMapFrame"]:GetChildren()}) do
					if v and not v.EltruismBountySkinned then
						if v.BountyDropDown and v.BountyDropdownButton then
							v:SetAlpha(0)
							v:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdownButton:SetAlpha(1) end)
							v:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdownButton:SetAlpha(0) end)
							v.BountyDropdownButton:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdownButton:SetAlpha(1) end)
							v.BountyDropdownButton:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdownButton:SetAlpha(0) end)

							--skin the bounty button
							S:HandleButton(v.BountyDropdownButton)
							v.BountyDropdownButton:SetNormalTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdownButton:SetPushedTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdownButton:SetDisabledTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdownButton:GetNormalTexture():SetRotation(-1.57)
							v.BountyDropdownButton:GetPushedTexture():SetRotation(-1.57)
							v.BountyDropdownButton:GetDisabledTexture():SetRotation(-1.57)
							v.EltruismBountySkinned = true
						elseif v.BountyDropdown then
							v:SetAlpha(0)
							v:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdown:SetAlpha(1) end)
							v:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdown:SetAlpha(0) end)
							v.BountyDropdown:SetScript('OnEnter', function() v:SetAlpha(1) v.BountyDropdown:SetAlpha(1) end)
							v.BountyDropdown:SetScript('OnLeave', function() v:SetAlpha(0) v.BountyDropdown:SetAlpha(0) end)

							--skin the bounty button
							S:HandleButton(v.BountyDropdown)
							v.BountyDropdown:SetNormalTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdown:SetPushedTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdown:SetDisabledTexture(E.Media.Textures.ArrowUp)
							v.BountyDropdown:GetNormalTexture():SetRotation(-1.57)
							v.BountyDropdown:GetPushedTexture():SetRotation(-1.57)
							v.BountyDropdown:GetDisabledTexture():SetRotation(-1.57)
							v.EltruismBountySkinned = true
						end
					end
				end
			end
		end
	end
end

local onupdatesetup = false
local TimeSinceLastUpdate2 = 0
local ONUPDATE_INTERVAL2 = 0.016 --smooth for 60fps

--add cardinal directions to minimap
local Cardinals = CreateFrame("FRAME", "Eltruism Cardinal Directions")
Cardinals:SetParent(Minimap)
local function UpdateCardinalsRotation(_, elapsed)
	TimeSinceLastUpdate2 = TimeSinceLastUpdate2 + elapsed
	if TimeSinceLastUpdate2 >= ONUPDATE_INTERVAL2 then
		TimeSinceLastUpdate2 = 0
		if not (_G.Minimap and _G.Minimap:IsShown()) then return end
		local facing = GetPlayerFacing()
		if facing and E:NotSecretValue(facing) then
			if Minimap.EltruismLastFacing ~= facing then
				Minimap.EltruismRotate:SetRotation(-facing)
				Minimap.EltruismLastFacing = facing
			end
		end
	end
end

local function RotateMinimap()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		if E.Modern then
			Enum.EditModeMinimapSetting.RotateMinimap = 1
		end
		SetCVar("rotateMinimap",1)
		E.db["general"]["minimap"]["rotate"] = true
	else
		if E.Modern then
			Enum.EditModeMinimapSetting.RotateMinimap = 0
		end
		SetCVar("rotateMinimap",0)
		E.db["general"]["minimap"]["rotate"] = false
	end
end

--hide the backdrop here due to elvui function showing it
local function FixElvUIMinimapBorder()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle then
		if _G.MinimapBackdrop then
			_G.MinimapBackdrop:Hide()
		end
		if _G.Minimap.backdrop then
			_G.Minimap.backdrop:Hide()
		end

		--show icons that could be hidden by hiding the backdrop
		local minimapTrackingIcons = {
			_G.MinimapCluster.Tracking,
			_G.MinimapCluster.TrackingFrame,
			_G.MiniMapTrackingFrame,
			_G.MiniMapTracking,
			_G.ExpansionLandingPageMinimapButton,
			_G.MiniMapLFGFrame,
			_G.LFGMinimapFrame,
		}
		for _, frame in pairs(minimapTrackingIcons) do
			if frame then
				frame:SetParent(_G.Minimap)
			end
		end
	else
		if _G.MinimapBackdrop then
			_G.MinimapBackdrop:Show()
		end
		if _G.Minimap.backdrop then
			_G.Minimap.backdrop:Show()
		end
	end
end

function ElvUI_EltreumUI:MinimapCardinalDirections()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle then

		RotateMinimap()
		FixElvUIMinimapBorder()

		if Minimap.backdrop then
			Minimap.backdrop:Hide()
		end
		if _G["EltruismMiniMapShadowFrame"] then
			_G["EltruismMiniMapShadowFrame"]:Hide()
		end
		Minimap:SetMaskTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\map_circle")

		--add a shadow texture
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not Minimap.EltruismRotateShadow then
			Minimap.EltruismRotateShadow = Minimap:CreateTexture(nil, "BACKGROUND", nil, -3)
			Minimap.EltruismRotateShadow:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\map_circle_shadow")
			Minimap.EltruismRotateShadow:SetSize(Minimap:GetWidth(),Minimap:GetHeight())
			Minimap.EltruismRotateShadow:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
		end

		--elvui forces square, force round in this case
		_G.GetMinimapShape = function()
			return 'ROUND'
		end

		if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable and E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
			if not Minimap.EltruismRotate then
				Minimap.EltruismRotate = Minimap:CreateTexture()
				Minimap.EltruismRotate:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\cardinals.tga")
				Minimap.EltruismRotate:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
			end
			Minimap.EltruismRotate:SetSize(Minimap:GetWidth()+E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset,Minimap:GetHeight()+E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
			if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
				Minimap.EltruismRotate:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
			else
				Minimap.EltruismRotate:SetVertexColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b,1)
			end

			ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
		else
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Hide()
			end
			Cardinals:SetScript("OnUpdate",nil)
			onupdatesetup = false

			if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable then
				if not Cardinals.N then
					Cardinals.N = Cardinals:CreateFontString("EltruismNorth", "ARTWORK", "GameFontNormal")
				end
				Cardinals.N:SetText("N")
				if not Cardinals.E then
					Cardinals.E = Cardinals:CreateFontString("EltruismEast", "ARTWORK", "GameFontNormal")
				end
				Cardinals.E:SetText("E")
				if not Cardinals.S then
					Cardinals.S = Cardinals:CreateFontString("EltruismSouth", "ARTWORK", "GameFontNormal")
				end
				Cardinals.S:SetText("S")
				if not Cardinals.W then
					Cardinals.W = Cardinals:CreateFontString("EltruismWest", "ARTWORK", "GameFontNormal")
				end
				Cardinals.W:SetText("W")

				Cardinals.N:SetPoint("BOTTOM", Minimap, "TOP", 0, -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
				Cardinals.E:SetPoint("LEFT", Minimap, "RIGHT", -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)
				Cardinals.S:SetPoint("TOP", Minimap, "BOTTOM", 0, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset)
				Cardinals.W:SetPoint("RIGHT", Minimap, "LEFT", E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)

				Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

				if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
					Cardinals.N:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
					Cardinals.E:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
					Cardinals.S:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
					Cardinals.W:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				else
					Cardinals.N:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
					Cardinals.E:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
					Cardinals.S:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
					Cardinals.W:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
				end
			end
		end
	else

		if E.Modern then
			Enum.EditModeMinimapSetting.RotateMinimap = 0
		end
		SetCVar("rotateMinimap",0)
		if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable then
			if not Cardinals.N then
				Cardinals.N = Cardinals:CreateFontString("EltruismNorth", "ARTWORK", "GameFontNormal")
			end
			Cardinals.N:SetText("N")
			if not Cardinals.E then
				Cardinals.E = Cardinals:CreateFontString("EltruismEast", "ARTWORK", "GameFontNormal")
			end
			Cardinals.E:SetText("E")
			if not Cardinals.S then
				Cardinals.S = Cardinals:CreateFontString("EltruismSouth", "ARTWORK", "GameFontNormal")
			end
			Cardinals.S:SetText("S")
			if not Cardinals.W then
				Cardinals.W = Cardinals:CreateFontString("EltruismWest", "ARTWORK", "GameFontNormal")
			end
			Cardinals.W:SetText("W")

			local verticalInset = (ElvUI_EltreumUI.rectangleMinimapInset or 0) * (E.db.general.minimap.scale or 1)
			Cardinals.N:ClearAllPoints()
			Cardinals.E:ClearAllPoints()
			Cardinals.S:ClearAllPoints()
			Cardinals.W:ClearAllPoints()
			Cardinals.N:SetPoint("BOTTOM", Minimap, "TOP", 0, -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset - verticalInset)
			Cardinals.E:SetPoint("LEFT", Minimap, "RIGHT", -E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)
			Cardinals.S:SetPoint("TOP", Minimap, "BOTTOM", 0, E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset + verticalInset)
			Cardinals.W:SetPoint("RIGHT", Minimap, "LEFT", E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.offset, 0)

			Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

			if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
				Cardinals.N:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				Cardinals.E:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				Cardinals.S:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				Cardinals.W:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
			else
				Cardinals.N:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
				Cardinals.E:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
				Cardinals.S:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
				Cardinals.W:SetTextColor(E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.r,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.g,E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.b)
			end
		else
			if Cardinals.N then
				Cardinals.N:SetText("")
			end
			if Cardinals.E then
				Cardinals.E:SetText("")
			end
			if Cardinals.S then
				Cardinals.S:SetText("")
			end
			if Cardinals.W then
				Cardinals.W:SetText("")
			end
		end
	end
end

-- Eltruism Rectangle Minimap
local rectangleMaskPresets = {
	["16:9"] = { heightFactor = 9 / 16, mask = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\map_rectangle_16_9" },
	["4:3"] = { heightFactor = 3 / 4, mask = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\map_rectangle_4_3" },
	["2:1"] = { heightFactor = 1 / 2, mask = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\map_rectangle_2_1" },
}
local function GetMinimapVerticalCrop()
	local otherstuff = E.db and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.otherstuff
	if not otherstuff or not otherstuff.rectangleMinimap or not otherstuff.rectangleMinimap.enable then
		return 0, nil
	end
	if otherstuff.minimapcardinaldirections and otherstuff.minimapcardinaldirections.circle then
		return 0, nil
	end
	local preset = rectangleMaskPresets[otherstuff.rectangleMinimap.preset] or rectangleMaskPresets["16:9"]
	local mapSize = E.MinimapSize or (Minimap and Minimap:GetWidth()) or 140
	local crop = mathfloor((mapSize * (1 - preset.heightFactor)) * 0.5 + 0.5)
	return crop, preset.mask
end

--Clip minimap pins outside the rectangle minimap area
local clipHalfHeight = 0
local lastMinimapChildCount = 0
local pinClipElapsed = 0
local pinClipActive = false
local PIN_SCAN_INTERVAL = 0.25
local MAX_DIRECT_CHILDREN = 1000
local hookedPins = setmetatable({}, { __mode = "k" })
local hiddenPins = setmetatable({}, { __mode = "k" })
local overlayClipFrame
local clippedOverlays = setmetatable({}, { __mode = "k" })
local lastEnumeratedFrame

local skippedPinFrames = {
	["MinimapBackdrop"] = true,
	["MinimapCompassTexture"] = true,
	["MinimapCluster"] = true,
	["TimeManagerClockButton"] = true,
	["GameTimeFrame"] = true,
	["MiniMapTracking"] = true,
	["MiniMapTrackingFrame"] = true,
	["MiniMapTrackingButton"] = true,
	["MiniMapMailFrame"] = true,
	["MiniMapLFGFrame"] = true,
	["LFGMinimapFrame"] = true,
	["QueueStatusMinimapButton"] = true,
	["QueueStatusButton"] = true,
	["QueueStatusFrame"] = true,
	["ElvUIQueueStatus"] = true,
	["GarrisonLandingPageMinimapButton"] = true,
	["ExpansionLandingPageMinimapButton"] = true,
	["AddonCompartmentFrame"] = true,
	["ElvConfigToggle"] = true,
	["MMHolder"] = true,
	["MiniMapInstanceDifficulty"] = true,
	["GuildInstanceDifficulty"] = true,
	["InstanceDifficulty"] = true,
	["MiniMapBattlefieldFrame"] = true,
	["BattlegroundShine"] = true,
	["MiniMapRecordingButton"] = true,
	["MiniMapVoiceChatFrame"] = true,
	["MinimapZoneTextButton"] = true,
	["SubZoneTextFrame"] = true,
	["MinimapZoomIn"] = true,
	["MinimapZoomOut"] = true,
	["MiniMapWorldMapButton"] = true,
	["MinimapNorthTag"] = true,
	["MinimapPanel"] = true,
	["HybridMinimap"] = true,
	["FeedbackUIButton"] = true,
}

local function SetMinimapPinShown(pin, isShown)
	if isShown then
		if pin.EltruismHidden then
			pin:SetAlpha(pin.EltruismOrigAlpha or 1, true)
			if pin.EltruismMouseEnabled then
				pin:EnableMouse(true)
				pin.EltruismMouseEnabled = nil
			end
			if pin.EltruismMouseMotion then
				pin:SetMouseMotionEnabled(true)
				pin.EltruismMouseMotion = nil
			end
			pin.EltruismHidden = nil
			pin.EltruismOrigAlpha = nil
			hiddenPins[pin] = nil
		end
	elseif not pin.EltruismHidden then
		local currentAlpha = pin:GetAlpha()
		if currentAlpha and currentAlpha > 0 then
			pin.EltruismOrigAlpha = currentAlpha
		end
		pin:SetAlpha(0, true)
		if pin:IsMouseEnabled() then
			pin.EltruismMouseEnabled = true
			pin:EnableMouse(false)
		end
		if pin.IsMouseMotionEnabled and pin:IsMouseMotionEnabled() then
			pin.EltruismMouseMotion = true
			pin:SetMouseMotionEnabled(false)
		end
		pin.EltruismHidden = true
		hiddenPins[pin] = true
	end
end

local function OnPinSetAlpha(self, alpha, skipFlag)
	if not skipFlag and self.EltruismHidden then
		if alpha and alpha > 0 then
			self.EltruismOrigAlpha = alpha
		end
		self:SetAlpha(0, true)
	end
end

local function OnPinShow(self)
	if self.EltruismHidden then
		self:SetAlpha(0, true)
		if self:IsMouseEnabled() then
			self.EltruismMouseEnabled = true
			self:EnableMouse(false)
		end
	end
end

local function ApplyPinClip(pin, yOfs)
	if clipHalfHeight <= 0 then
		if pin.EltruismHidden then
			SetMinimapPinShown(pin, true)
		end
		return
	end
	if yOfs == nil then
		local point, relativeTo, relativePoint, _, y = pin:GetPoint(1)
		if point == "CENTER" and relativeTo == Minimap and relativePoint == "CENTER" then
			yOfs = y
		end
	end
	if yOfs then
		local shouldShow = mathabs(yOfs * pin:GetScale()) <= clipHalfHeight
		if shouldShow == (pin.EltruismHidden == true) then
			SetMinimapPinShown(pin, shouldShow)
		end
	end
end

local function OnPinSetPoint(self, point, arg2, arg3, arg4, arg5)
	if clipHalfHeight <= 0 then
		if self.EltruismHidden then
			SetMinimapPinShown(self, true)
		end
		return
	end
	if point == "CENTER" then
		local yOfs
		if arg2 == Minimap and arg3 == "CENTER" and type(arg5) == "number" then
			yOfs = arg5
		elseif arg2 == Minimap and type(arg4) == "number" then
			yOfs = arg4
		elseif type(arg2) == "number" and type(arg3) == "number" and self:GetParent() == Minimap then
			yOfs = arg3
		end
		if yOfs then
			ApplyPinClip(self, yOfs)
			return
		end
	end
	if self.EltruismHidden then
		SetMinimapPinShown(self, true)
	end
end

local function IsSkippedMinimapChild(frame)
	if frame:IsForbidden() or frame == overlayClipFrame then
		return true
	end
	if frame == Minimap.backdrop or frame == Minimap.location or frame == Minimap.ZoomIn or frame == Minimap.ZoomOut or frame == Minimap.ZoomHitArea or frame == Minimap.EltruismRotateShadow then
		return true
	end
	if frame.dataObject or frame.EltruismInBar or frame.EltruismSkinned or frame:GetScript("OnDragStart") then
		return true
	end
	local name = frame:GetName()
	if name then
		if skippedPinFrames[name]
			or strfind(name, "^LibDBIcon10_")
			or strfind(name, "^ElvUI")
			or strfind(name, "^Eltruism")
			or strfind(name, "^Minimap")
			or strfind(name, "^MiniMap")
			or strfind(name, "^SexyMap") then
			return true
		end
	end
	return false
end

local function IsFullMinimapOverlay(frame)
	if frame:IsProtected() or frame:IsMouseEnabled() or frame:GetFrameStrata() ~= Minimap:GetFrameStrata() or frame:GetNumPoints() ~= 2 then
		return false
	end
	local p1, rel1, rp1, x1, y1 = frame:GetPoint(1)
	local p2, rel2, rp2, x2, y2 = frame:GetPoint(2)
	if rel1 ~= Minimap or rel2 ~= Minimap then
		return false
	end
	local isTopBottom = (p1 == "TOPLEFT" and rp1 == "TOPLEFT" and p2 == "BOTTOMRIGHT" and rp2 == "BOTTOMRIGHT")
		or (p1 == "BOTTOMRIGHT" and rp1 == "BOTTOMRIGHT" and p2 == "TOPLEFT" and rp2 == "TOPLEFT")
	if not isTopBottom then
		return false
	end
	return mathabs(x1 or 0) <= 1 and mathabs(y1 or 0) <= 1 and mathabs(x2 or 0) <= 1 and mathabs(y2 or 0) <= 1
end

local function ClipMinimapOverlay(frame)
	local level = frame:GetFrameLevel()
	local origClips = frame:DoesClipChildren()
	if clippedOverlays[frame] == nil then
		clippedOverlays[frame] = origClips
	end
	frame:SetParent(overlayClipFrame)
	frame:SetFrameLevel(mathmax(level, overlayClipFrame:GetFrameLevel() + 1))
	if origClips then
		frame:SetClipsChildren(false)
	end
end

local function HookMinimapPin(pin)
	hookedPins[pin] = true
	hooksecurefunc(pin, "SetAlpha", OnPinSetAlpha)
	hooksecurefunc(pin, "Show", OnPinShow)
	hooksecurefunc(pin, "SetPoint", OnPinSetPoint)
	ApplyPinClip(pin)
end

local function ProcessMinimapChild(child)
	if not IsSkippedMinimapChild(child) then
		if overlayClipFrame and IsFullMinimapOverlay(child) then
			ClipMinimapOverlay(child)
		elseif not hookedPins[child] and child:GetNumPoints() <= 1 then
			HookMinimapPin(child)
		end
	end
end

local function ScanMinimapViaEnumerate(full, grew)
	local startFrame = (not full) and lastEnumeratedFrame or nil
	local found = 0
	local frame = EnumerateFrames(startFrame)
	while frame do
		lastEnumeratedFrame = frame
		if (not E.Modern and not frame:IsForbidden()) or (E.Modern and frame:CanBeAccessedInContext()) then
			local parent = frame:GetParent()
			if E:NotSecretValue(parent) and parent == Minimap then
				ProcessMinimapChild(frame)
				found = found + 1
			end
		end
		frame = EnumerateFrames(frame)
	end
	if not full and startFrame and grew and found == 0 then
		ScanMinimapViaEnumerate(true, false)
	end
end

local function ScanMinimapPins(force)
	local numChildren = Minimap:GetNumChildren()
	if not force and numChildren == lastMinimapChildCount then
		return
	end
	local grew = numChildren > lastMinimapChildCount
	if numChildren <= MAX_DIRECT_CHILDREN then
		local children = { Minimap:GetChildren() }
		for i = 1, #children do
			ProcessMinimapChild(children[i])
		end
	else
		ScanMinimapViaEnumerate(force, grew)
	end
	lastMinimapChildCount = Minimap:GetNumChildren()
end

local pinClipFrame = CreateFrame("Frame")

local function OnPinClipUpdate(_, elapsed)
	pinClipElapsed = pinClipElapsed + elapsed
	if pinClipElapsed < PIN_SCAN_INTERVAL then
		return
	end
	pinClipElapsed = 0
	ScanMinimapPins()
end

local function OnPinClipEvent(_, event)
	if event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
		ScanMinimapPins(true)
	else
		ScanMinimapPins()
	end
end
pinClipFrame:SetScript("OnEvent", OnPinClipEvent)

function ElvUI_EltreumUI:UpdateMinimapPinClip()
	local crop = GetMinimapVerticalCrop()
	if crop <= 0 then
		clipHalfHeight = 0
		lastMinimapChildCount = 0
		lastEnumeratedFrame = nil
		if pinClipActive then
			pinClipFrame:UnregisterAllEvents()
			pinClipFrame:SetScript("OnUpdate", nil)
			pinClipActive = false
		end
		for pin in pairs(hiddenPins) do
			SetMinimapPinShown(pin, true)
		end
		if overlayClipFrame then
			overlayClipFrame:SetClipsChildren(false)
			for frame, origClips in pairs(clippedOverlays) do
				if not frame:IsForbidden() and not frame:IsProtected() then
					local level = frame:GetFrameLevel()
					frame:SetParent(Minimap)
					frame:SetFrameLevel(level)
					if origClips then
						frame:SetClipsChildren(true)
					end
				end
				clippedOverlays[frame] = nil
			end
			overlayClipFrame:Hide()
		end
		return
	end

	local mapHeight = Minimap:GetHeight() or E.MinimapSize or 140
	clipHalfHeight = ((mapHeight - (crop * 2)) * 0.5) - 2

	local targetLevel = Minimap:GetFrameLevel() + 2
	if not overlayClipFrame then
		overlayClipFrame = CreateFrame("Frame", "EltruismMinimapOverlayClip", Minimap)
		overlayClipFrame:EnableMouse(false)
		overlayClipFrame:SetFrameLevel(targetLevel)
	elseif overlayClipFrame:GetFrameLevel() ~= targetLevel then
		overlayClipFrame:SetFrameLevel(targetLevel)
	end
	overlayClipFrame:ClearAllPoints()
	overlayClipFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, -crop)
	overlayClipFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, crop)
	overlayClipFrame:SetClipsChildren(true)
	overlayClipFrame:Show()

	if not pinClipActive then
		pinClipActive = true
		pinClipFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		pinClipFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		pinClipFrame:RegisterEvent("ZONE_CHANGED")
		pinClipFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
		pinClipFrame:RegisterEvent("MINIMAP_UPDATE_ZOOM")
		pinClipFrame:RegisterEvent("ADDON_LOADED")
		pinClipFrame:SetScript("OnUpdate", OnPinClipUpdate)
	end

	ScanMinimapPins(true)
	for pin in pairs(hookedPins) do
		ApplyPinClip(pin)
	end
end

function ElvUI_EltreumUI:GetIconSettings(button)
	local defaults = P.general.minimap.icons[button]
	local profile = E.db.general.minimap.icons[button]
	local scale = profile.scale or defaults.scale
	local position = profile.position or defaults.position
	local xOffset = profile.xOffset or defaults.xOffset
	local yOffset = profile.yOffset or defaults.yOffset

	local crop = GetMinimapVerticalCrop()
	if crop > 0 and position then
		local shift = crop * (E.db.general.minimap.scale or 1)
		if string.find(position, "TOP") then
			yOffset = (yOffset or 0) - shift
		elseif string.find(position, "BOTTOM") then
			yOffset = (yOffset or 0) + shift
		end
	end

	return scale, position, xOffset, yOffset
end

local GetIconSettingsHook = false
function ElvUI_EltreumUI:UpdateRectangleMinimap()
	if InCombatLockdown() or not M.MapHolder then
		return
	end

	if not GetIconSettingsHook and E.db.ElvUI_EltreumUI.otherstuff.rectangleMinimap.enable and M.GetIconSettings ~= ElvUI_EltreumUI.GetIconSettings then
		M.GetIconSettings = ElvUI_EltreumUI.GetIconSettings
		GetIconSettingsHook = true
		M:UpdateSettings()
		return
	end

	local crop, maskPath = GetMinimapVerticalCrop()
	local borderOffset = E.PixelMode and 1 or 3

	if crop <= 0 then
		if self.rectangleMinimapInset then
			self.rectangleMinimapInset = nil
			Minimap:SetHitRectInsets(0, 0, 0, 0)
			Minimap:SetClampRectInsets(0, 0, 0, 0)
			if _G.MinimapMover then
				_G.MinimapMover:SetClampRectInsets(0, 0, 0, 0)
			end

			local isCircle = E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.circle
			if not isCircle then
				if M.SetMinimapMask then
					M:SetMinimapMask(true)
				else
					Minimap:SetMaskTexture(E.Modern and 130937 or [[interface\chatframe\chatframebackground]])
				end
			end

			if Minimap.backdrop then
				Minimap.backdrop:ClearAllPoints()
				Minimap.backdrop:SetOutside(Minimap, borderOffset, borderOffset)
			end
			self:UpdateMinimapLocationPosition()
			local shadowFrame = _G["EltruismMiniMapShadowFrame"]
			if shadowFrame and not isCircle then
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.minimap and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.minimapborder) then
					shadowFrame:ClearAllPoints()
					shadowFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
					if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable and _G.MinimapPanel and _G.MinimapPanel:IsShown() then
						shadowFrame:SetPoint("BOTTOMLEFT", _G.MinimapPanel, "BOTTOMLEFT", 0, 0)
					else
						shadowFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0)
					end
					shadowFrame:Show()
				else
					shadowFrame:Hide()
				end
			end
		end
		self:UpdateMinimapPinClip()
		return
	end

	self.rectangleMinimapInset = crop

	local scale = E.db.general.minimap.scale or 1
	local scaledCrop = crop * scale

	Minimap:SetMaskTexture(maskPath)
	Minimap:SetHitRectInsets(0, 0, crop, crop)
	Minimap:SetClampedToScreen(true)
	Minimap:SetClampRectInsets(0, 0, 0, 0)
	Minimap:ClearAllPoints()
	Minimap:Point("TOPRIGHT", M.MapHolder, "TOPRIGHT", -borderOffset / scale, (-borderOffset / scale) + crop)

	if Minimap.backdrop then
		Minimap.backdrop:ClearAllPoints()
		Minimap.backdrop:SetOutside(Minimap, borderOffset, borderOffset - scaledCrop)
	end

	self:UpdateMinimapLocationPosition()

	local panel = _G.MinimapPanel
	if panel and panel:IsShown() then
		panel:ClearAllPoints()
		panel:Point("TOPLEFT", Minimap, "BOTTOMLEFT", -E.Border, (E.PixelMode and 0 or -3) + scaledCrop)
		panel:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", E.Border, -23 + scaledCrop)
	end

	local visibleHeight = ((E.MinimapSize or Minimap:GetWidth()) - (crop * 2)) * scale
	local panelHeight = (panel and panel:IsShown() and panel:GetHeight()) or 0
	local croppedHeight = visibleHeight + panelHeight + (borderOffset * 2)
	M.MapHolder:SetHeight(croppedHeight)
	if _G.MinimapMover then
		_G.MinimapMover:SetHeight(croppedHeight)
		local topClamp = mathmax(0, E:Scale(scaledCrop) - E:Scale(borderOffset))
		local bottomClamp = mathmax(0, E:Scale(scaledCrop) - panelHeight - E:Scale(borderOffset))
		_G.MinimapMover:SetClampRectInsets(0, 0, topClamp, -bottomClamp)
	end

	local shadowFrame = _G["EltruismMiniMapShadowFrame"]
	if shadowFrame then
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.minimap and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.minimapborder) then
			local targetBackdrop = Minimap.backdrop or Minimap
			shadowFrame:ClearAllPoints()
			shadowFrame:SetPoint("TOPRIGHT", targetBackdrop, "TOPRIGHT", 0, 0)
			if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable and panel and panel:IsShown() then
				shadowFrame:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 0, 0)
			else
				shadowFrame:SetPoint("BOTTOMLEFT", targetBackdrop, "BOTTOMLEFT", 0, 0)
			end
			shadowFrame:Show()
		else
			shadowFrame:Hide()
		end
	end
	if Minimap.EltruismRotateShadow then
		Minimap.EltruismRotateShadow:Hide()
	end

	if _G.HybridMinimap and _G.HybridMinimap.MapCanvas then
		if not _G.HybridMinimap.EltruismMask then
			_G.HybridMinimap.EltruismMask = _G.HybridMinimap:CreateMaskTexture()
			_G.HybridMinimap.EltruismMask:SetAllPoints(_G.HybridMinimap)
		end
		_G.HybridMinimap.EltruismMask:SetTexture(maskPath)
		_G.HybridMinimap.MapCanvas:SetMaskTexture(_G.HybridMinimap.EltruismMask)
		_G.HybridMinimap.MapCanvas:SetUseMaskTexture(true)
	end

	self:UpdateMinimapPinClip()
end

-- Minimap location text gradient and mover
local locationHolder
local pendingLocationUpdate

local function ShouldDisableLocationMover()
	return M.db.locationText == "HIDE" or not M.db.clusterDisable
end

function ElvUI_EltreumUI:UpdateMinimapLocationText(fromHook)
	if not M.Initialized or not E.private.general.minimap.enable then return end

	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapLocation
	if not db.gradient then
		if not fromHook then
			M:Update_ZoneText()
			if not M.db.clusterDisable and _G.Minimap_Update then
				_G.Minimap_Update()
			end
		end
		return
	end

	local zone = GetMinimapZoneText()
	if not zone or zone == "" then return end

	local text = utf8sub(zone, 1, 46)
	local gradText
	if db.gradientMode == "CLASS" then
		gradText = ElvUI_EltreumUI:GradientName(text, E.myclass)
	elseif db.gradientMode == "CUSTOM" then
		local c1, c2 = db.customColor1, db.customColor2
		gradText = E:TextGradient(text, c1.r, c1.g, c1.b, c2.r, c2.g, c2.b)
	else
		local r, g, b = M:GetLocTextColor()
		gradText = E:TextGradient(text, r, g, b, E:Clamp(r + 0.35, 0, 1), E:Clamp(g + 0.35, 0, 1), E:Clamp(b + 0.35, 0, 1))
	end

	if Minimap.location and M.db.locationText ~= "HIDE" then
		Minimap.location:SetTextColor(1, 1, 1)
		Minimap.location:SetText(gradText)
	end

	if not M.db.clusterDisable and _G.MinimapZoneText then
		_G.MinimapZoneText:SetTextColor(1, 1, 1)
		_G.MinimapZoneText:SetText(gradText)
	end
end

function ElvUI_EltreumUI:UpdateMinimapLocationPosition(overrideOffsetY)
	if not Minimap.location then return end

	local offsetY = overrideOffsetY
	if not offsetY then
		local inset = self.rectangleMinimapInset
		offsetY = (inset and inset > 0) and (-4 - (inset * (E.db.general.minimap.scale or 1))) or -2
	end

	if locationHolder then
		Minimap.location:ClearAllPoints()
		Minimap.location:SetPoint("CENTER", locationHolder, "CENTER", 0, 0)

		if not InCombatLockdown() then
			local holder = E:GetMoverHolder("MoverEltruismMinimapLocation")
			holder.originPoint = { "TOP", Minimap, "TOP", 0, offsetY }

			if not E:HasMoverBeenMoved("MoverEltruismMinimapLocation") then
				if E.CreatedMovers["MoverEltruismMinimapLocation"] then
					E:SetMoverPoints("MoverEltruismMinimapLocation")
				else
					holder.mover:ClearAllPoints()
					holder.mover:SetPoint("TOP", Minimap, "TOP", 0, offsetY)
				end
			end
		end
	else
		Minimap.location:ClearAllPoints()
		Minimap.location:Point("TOP", Minimap, "TOP", 0, offsetY)
	end
end

function ElvUI_EltreumUI:UpdateMinimapLocation()
	if not E.private.general.minimap.enable or not Minimap.location then return end

	if InCombatLockdown() then
		pendingLocationUpdate = true
		self:UpdateMinimapLocationText(true)
		return
	end

	pendingLocationUpdate = nil

	local width = E.MinimapSize or Minimap:GetWidth()
	local height = mathmax(M.db.locationFontSize + 6, 18)

	if not locationHolder then
		locationHolder = CreateFrame("Frame", "EltruismMinimapLocationHolder", E.UIParent)
		locationHolder:SetFrameStrata("LOW")
		locationHolder:SetFrameLevel(20)
		locationHolder:SetSize(width, height)
		locationHolder:SetPoint("TOP", Minimap, "TOP", 0, -2)

		E:CreateMover(locationHolder, "MoverEltruismMinimapLocation", L["Eltruism Minimap Location"], nil, nil, nil, "ALL,SOLO,ELTREUMUI", ShouldDisableLocationMover, "ElvUI_EltreumUI,map,general")
	else
		locationHolder:SetSize(width, height)
	end

	if ShouldDisableLocationMover() then
		E:DisableMover("MoverEltruismMinimapLocation")
	else
		E:EnableMover("MoverEltruismMinimapLocation")
	end

	self:UpdateMinimapLocationPosition()
	self:UpdateMinimapLocationText(true)
end

function ElvUI_EltreumUI:MinimapLocationCombatUpdate()
	if pendingLocationUpdate then
		self:UpdateMinimapLocation()
	end
end

function ElvUI_EltreumUI:M_UpdateSettings()
	ElvUI_EltreumUI:UpdateRectangleMinimap()
	ElvUI_EltreumUI:MinimapCardinalDirections()
	ElvUI_EltreumUI:ElvUIMailTexture()
	ElvUI_EltreumUI:HandleBlizzardButtons()
	ElvUI_EltreumUI:UpdateMinimapButtonBar()
	ElvUI_EltreumUI:UpdateMinimapLocation()
end
ElvUI_EltreumUI:SecureHook(M, "UpdateSettings", "M_UpdateSettings")

function ElvUI_EltreumUI:M_Update_ZoneText()
	ElvUI_EltreumUI:UpdateMinimapLocationText(true)
end
ElvUI_EltreumUI:SecureHook(M, "Update_ZoneText", "M_Update_ZoneText")
if _G.Minimap_Update then
	ElvUI_EltreumUI:SecureHook("Minimap_Update", "M_Update_ZoneText")
end

--setup onupdate and also get rid of it
function ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
	RotateMinimap()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.enable and E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
		if instanceType == "none" then
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Show()
				if not onupdatesetup then
					TimeSinceLastUpdate2 = 0
					Cardinals:SetScript("OnUpdate", UpdateCardinalsRotation)
					onupdatesetup = true
				end
			end
		else
			if Minimap.EltruismRotate then
				Minimap.EltruismRotate:Hide()
			end
			if onupdatesetup then
				Cardinals:SetScript("OnUpdate", nil)
				onupdatesetup = false
			end
		end
	else
		if Minimap.EltruismRotate then
			Minimap.EltruismRotate:Hide()
		end
		if onupdatesetup then
			Cardinals:SetScript("OnUpdate", nil)
			onupdatesetup = false
		end
	end
end
