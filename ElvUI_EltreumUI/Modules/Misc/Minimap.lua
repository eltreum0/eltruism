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
local next = _G.next
local hooksecurefunc = _G.hooksecurefunc
local math = _G.math
local mathabs = math.abs
local mathfloor = math.floor
local mathmax = math.max
local utf8sub = _G.string.utf8sub
local ipairs = _G.ipairs
local select = _G.select
local type = _G.type
local rawget = _G.rawget

--scale the world map in retail
function ElvUI_EltreumUI:WorldMapScale()
	if E.db.ElvUI_EltreumUI.otherstuff.worldmapscale then
		if _G["WorldMapFrame"] then
			if not _G["WorldMapFrame"].EltruismScaleHooked then
				_G["WorldMapFrame"]:HookScript("OnShow", function()
					if not E.Modern then
						if not InCombatLockdown then
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
						if ElvUI_EltreumUI:IsThisASafeSecret(_G["WorldMapFrame"],true) then
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

--HereBeDragons pins fix for rectangle minimap (questie, rarescanner and others)
local HBD_PIN_LIBS = {
	"HereBeDragons-Pins-2.0",
	"HereBeDragonsQuestie-Pins-2.0",
}
local HBD_THROTTLE = 0 --controls how fast the OnUpdate runs, if higher than zero it will start blinking, i dont like that so for now keep it at zero

local function HereBeDragonsPinSetAlpha(self, alpha, skipFlag)
	if not skipFlag and self.EltruismHidden then
		if alpha and alpha > 0 then
			self.EltruismOrigAlpha = alpha
		end
		self:SetAlpha(0, true)
	end
end

local function HereBeDragonsPinShow(self)
	if self.EltruismHidden then
		self:SetAlpha(0, true)
	end
end

local function HereBeDragonsPinSetPoint(self)
	if self.EltruismLib then
		self.EltruismLib.EltruismPinsMoved = true
	end
end

--hook pins to track movement and keep alpha hidden if needed
local function HookHereBeDragonsPin(pin, lib)
	if not pin or pin.EltruismHbdHooked or not pin.IsObjectType or not pin:IsObjectType("Frame") then
		return
	end

	pin.EltruismLib = lib

	--if pin is hidden by rectangle minimap keep it hidden
	hooksecurefunc(pin, "SetAlpha", HereBeDragonsPinSetAlpha)
	hooksecurefunc(pin, "Show", HereBeDragonsPinShow)
	--flag lib as moved when a pin moves
	hooksecurefunc(pin, "SetPoint", HereBeDragonsPinSetPoint)
	pin.EltruismHbdHooked = true
end

--hide or show pins by setting alpha to avoid breaking other addons
function ElvUI_EltreumUI:SetHereBeDragonsPinShown(pin, isShown)
	if isShown then
		if pin.EltruismHidden then
			local restoreAlpha = pin.EltruismOrigAlpha or 1
			pin:SetAlpha(restoreAlpha, true)
			if pin.EnableMouse then
				pin:EnableMouse(true)
			end
			pin.EltruismHidden = nil
			pin.EltruismOrigAlpha = nil
			if pin.EltruismLib and pin.EltruismLib.EltruismHiddenPins then
				pin.EltruismLib.EltruismHiddenPins[pin] = nil
			end
		end
	else
		if not pin.EltruismHidden then
			local currentAlpha = pin:GetAlpha()
			if currentAlpha and currentAlpha > 0 then
				pin.EltruismOrigAlpha = currentAlpha
			end
			pin:SetAlpha(0, true)
			if pin.EnableMouse then
				pin:EnableMouse(false)
			end
			pin.EltruismHidden = true
			if pin.EltruismLib then
				pin.EltruismLib.EltruismHiddenPins = pin.EltruismLib.EltruismHiddenPins or {}
				pin.EltruismLib.EltruismHiddenPins[pin] = true
			end
		end
	end
end

local function RestoreInactiveHiddenPins(lib)
	if not lib or not lib.EltruismHiddenPins or not lib.activeMinimapPins or not next(lib.EltruismHiddenPins) then
		return
	end
	for pin in pairs(lib.EltruismHiddenPins) do
		if not lib.activeMinimapPins[pin] then
			ElvUI_EltreumUI:SetHereBeDragonsPinShown(pin, true)
		end
	end
end

--refresh pin visibility based on rectangle minimap crop
function ElvUI_EltreumUI:RefreshHereBeDragonsPins(lib)
	if not lib or not lib.activeMinimapPins or not Minimap then
		return
	end

	local crop = GetMinimapVerticalCrop()
	if crop <= 0 then
		if lib.EltruismHiddenPins and next(lib.EltruismHiddenPins) then
			for pin in pairs(lib.EltruismHiddenPins) do
				ElvUI_EltreumUI:SetHereBeDragonsPinShown(pin, true)
			end
		end
		return
	end

	--restore any pins hidden
	if lib.EltruismHiddenPins and next(lib.EltruismHiddenPins) then
		RestoreInactiveHiddenPins(lib)
	end

	local mapHeight = Minimap:GetHeight() or E.MinimapSize or 140
	local halfHeightLimit = ((mapHeight - (crop * 2)) * 0.5) - 2
	local minimapCenterY, scale

	--check if pins are inside the rectangle boundaries
	for pin in pairs(lib.activeMinimapPins) do
		local shouldShow = true
		local _, _, _, _, yOfs = pin:GetPoint(1)
		if yOfs then
			shouldShow = mathabs(yOfs) <= halfHeightLimit
		elseif pin.GetCenter then
			if minimapCenterY == nil then
				minimapCenterY = select(2, Minimap:GetCenter()) or false
				scale = Minimap:GetEffectiveScale() or 1
			end
			if minimapCenterY then
				local pinCenterY = select(2, pin:GetCenter())
				if pinCenterY then
					shouldShow = (mathabs(pinCenterY - minimapCenterY) / scale) <= halfHeightLimit
				end
			end
		end
		if shouldShow ~= not pin.EltruismHidden then
			self:SetHereBeDragonsPinShown(pin, shouldShow)
		end
	end
end

local function ApplyHereBeDragonsPinsFix(lib)
	if not lib or not lib.updateFrame or not lib.activeMinimapPins then
		return
	end

	if not lib.EltruismHbdHooked then
		--hook icon creation and removal methods
		if lib.AddMinimapIconWorld then
			hooksecurefunc(lib, "AddMinimapIconWorld", function(_, icon)
				if icon then
					HookHereBeDragonsPin(icon, lib)
					lib.EltruismPinsMoved = true
				end
			end)
		end
		if lib.AddMinimapIconMap then
			hooksecurefunc(lib, "AddMinimapIconMap", function(_, icon)
				if icon then
					HookHereBeDragonsPin(icon, lib)
					lib.EltruismPinsMoved = true
				end
			end)
		end
		if lib.RemoveMinimapIcon then
			hooksecurefunc(lib, "RemoveMinimapIcon", function(_, _, icon)
				if icon and icon.EltruismHidden then
					ElvUI_EltreumUI:SetHereBeDragonsPinShown(icon, true)
				end
			end)
		end
		if lib.RemoveAllMinimapIcons then
			hooksecurefunc(lib, "RemoveAllMinimapIcons", function()
				RestoreInactiveHiddenPins(lib)
			end)
		end

		--throttle onupdate to avoid unnecessary checks
		lib.updateFrame:HookScript("OnUpdate", function(_, elapsed)
			if GetMinimapVerticalCrop() <= 0 and (not lib.EltruismHiddenPins or not next(lib.EltruismHiddenPins)) then
				return
			end
			lib.EltruismTimer = (lib.EltruismTimer or 0) + elapsed
			if lib.EltruismTimer < HBD_THROTTLE then
				return
			end
			lib.EltruismTimer = 0

			--hook any new pin that became active
			local foundUnhookedPin = false
			for pin in pairs(lib.activeMinimapPins) do
				if pin and not pin.EltruismHbdHooked then
					HookHereBeDragonsPin(pin, lib)
					foundUnhookedPin = true
				end
			end

			--return early if stationary and no new pins
			if not foundUnhookedPin and not lib.EltruismPinsMoved then
				return
			end
			lib.EltruismPinsMoved = nil

			ElvUI_EltreumUI:RefreshHereBeDragonsPins(lib)
		end)
		lib.EltruismHbdHooked = true
	end

	--hook existing pins
	if lib.minimapPins then
		for pin in pairs(lib.minimapPins) do
			HookHereBeDragonsPin(pin, lib)
		end
	end
	for pin in pairs(lib.activeMinimapPins) do
		HookHereBeDragonsPin(pin, lib)
	end
	ElvUI_EltreumUI:RefreshHereBeDragonsPins(lib)
end

--hook herebedragons to mask pins outside rectangle minimap
function ElvUI_EltreumUI:HereBeDragonsPinsFix()
	if not E.db or not E.db.ElvUI_EltreumUI or not E.db.ElvUI_EltreumUI.otherstuff then return end

	if _G.LibStub then
		for _, libName in ipairs(HBD_PIN_LIBS) do
			local lib = _G.LibStub(libName, true)
			if lib then
				ApplyHereBeDragonsPinsFix(lib)
			end
		end
	end

	--Questie 12.8+ moved HereBeDragons-Pins into QuestieLoader._modules["HBDPins"] instead of LibStub
	local loader = _G.QuestieLoader
	local modules = type(loader) == "table" and rawget(loader, "_modules")
	local questiePins = type(modules) == "table" and rawget(modules, "HBDPins")
	if type(questiePins) == "table" then
		ApplyHereBeDragonsPinsFix(questiePins)
	end
end

--some addons like questie or rarescanner load late
local hbdEventFrame = CreateFrame("Frame")
hbdEventFrame:RegisterEvent("ADDON_LOADED")
hbdEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
hbdEventFrame:SetScript("OnEvent", function(_, event, addon)
	local isLoaded = IsAddOnLoaded("Questie") or IsAddOnLoaded("RareScanner")
	if event == "PLAYER_ENTERING_WORLD" or addon == "Questie" or addon == "RareScanner" or isLoaded or (addon and string.find(addon, "HereBeDragons")) then
		ElvUI_EltreumUI:HereBeDragonsPinsFix()
	end
end)

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
		self:HereBeDragonsPinsFix()
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

	self:HereBeDragonsPinsFix()
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
