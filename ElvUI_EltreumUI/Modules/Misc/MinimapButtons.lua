local E, L = unpack(ElvUI)
local M = E:GetModule('Minimap')
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local RegisterStateDriver = _G.RegisterStateDriver
local UnregisterStateDriver = _G.UnregisterStateDriver
local HasNewMail = _G.HasNewMail
local PlaySound = _G.PlaySound
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut
local GameTooltip = _G.GameTooltip
local Minimap = _G.Minimap
local pairs = _G.pairs
local select = _G.select
local type = _G.type
local unpack = _G.unpack
local math = _G.math
local table = _G.table
local string = _G.string

local buttonBar = CreateFrame("Frame", "EltruismMinimapButtonBar", E.UIParent, "BackdropTemplate")
local eventFrame = CreateFrame("Frame", "EltruismMinimapButtonBarEvents")
local toggleButton
local barButtons = {}
local visibleButtons = {}
local isUpdatingBar = false
local lastMinimapChildCount = 0

--frames on minimap that are part of blizzard/elvui/eltruism or map pins and should not be treated as addon buttons
local skippedMinimapFrames = {
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
	["EltruismMinimapButtonBar"] = true,
	["EltruismMinimapButtonToggle"] = true,
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
}

--textures commonly used as circular rings or background masks on minimap buttons
local ringTextures = {
	[136430] = true, --MiniMap-TrackingBorder
	[136467] = true, --UI-Minimap-Background
	[136477] = true, --MinimapButton-HighlightRing
	[130924] = true, --Calendar border
}

local function IsRingOrMaskTexture(tex, regionName)
	if not tex then return false end
	if ringTextures[tex] then return true end
	if type(tex) == "string" then
		local lower = string.lower(tex)
		if string.find(lower, "trackingborder") or string.find(lower, "minimap%-background") or string.find(lower, "border") or string.find(lower, "overlay") or string.find(lower, "mask") then
			return true
		end
	end
	if regionName then
		local lowerName = string.lower(regionName)
		if string.find(lowerName, "border") or string.find(lowerName, "background") or string.find(lowerName, "overlay") then
			return true
		end
	end
	return false
end

--shared hover and position hooks to avoid creating closures per button
local function ButtonOnEnter(self)
	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
	if not db.enable then return end
	if db.hoverHighlight and self.SetBackdropBorderColor then
		if db.hoverClassColor then
			self:SetBackdropBorderColor(E.myClassColor.r, E.myClassColor.g, E.myClassColor.b)
		elseif db.hoverColor then
			self:SetBackdropBorderColor(db.hoverColor.r, db.hoverColor.g, db.hoverColor.b)
		end
	end
	if db.barMouseOver and buttonBar:IsShown() then
		UIFrameFadeIn(buttonBar, 0.2, buttonBar:GetAlpha(), 1)
	end
end

local function ButtonOnLeave(self)
	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
	if not db.enable then return end
	if self.SetBackdropBorderColor then
		self:SetBackdropBorderColor(unpack(E.media.bordercolor))
	end
	if db.barMouseOver and buttonBar:IsShown() then
		UIFrameFadeOut(buttonBar, 0.2, buttonBar:GetAlpha(), db.mouseOverAlpha or 0)
	end
end

local function SortBarButtons(a, b)
	if not a or not b then return false end
	local aBlizz = a.EltruismBlizzButton and true or false
	local bBlizz = b.EltruismBlizzButton and true or false
	if aBlizz ~= bBlizz then
		if E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons.blizzardButtonsPosition == "END" then
			return not aBlizz
		end
		return aBlizz
	end
	local aName = (a.GetName and a:GetName()) or a.name or ""
	local bName = (b.GetName and b:GetName()) or b.name or ""
	return aName < bName
end

--apply template, shadow and shared scripts to a button
local function ApplyButtonStyle(button, isBlizzButton)
	if not button or (button.IsForbidden and button:IsForbidden()) then return end
	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
	button.EltruismBlizzButton = isBlizzButton or false
	if not button.EltruismOrigParent then
		button.EltruismOrigParent = button:GetParent()
		button.EltruismOrigPoint = { button:GetPoint() }
	end

	button:SetTemplate("Transparent")
	if db.shadow then
		if not button.shadow then
			button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
		end
		ElvUI_EltreumUI:ShadowColor(button.shadow)
		button.shadow:Show()
	elseif button.shadow then
		button.shadow:Hide()
	end

	if not button.EltruismHook then
		button:HookScript("OnEnter", ButtonOnEnter)
		button:HookScript("OnLeave", ButtonOnLeave)
		button.EltruismHook = true
	end

	if not button.EltruismRegistered then
		barButtons[#barButtons + 1] = button
		button.EltruismRegistered = true
	end
	button.EltruismInBar = true
end

local function StripButtonRegions(mainIcon, ...)
	for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:IsObjectType("MaskTexture") then
			region:SetTexture("")
			region:Hide()
		elseif region and region:IsObjectType("Texture") then
			local tex = (region.GetTextureFileID and region:GetTextureFileID()) or (region.GetTexture and region:GetTexture())
			if region ~= mainIcon and IsRingOrMaskTexture(tex, region:GetName()) then
				region:SetTexture(nil)
				region:SetAlpha(0)
				region:Hide()
			elseif not mainIcon and tex then
				mainIcon = region
			end
		end
	end
	return mainIcon
end

local function HasValidTextureRegion(...)
	for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:IsObjectType("Texture") and region:GetTexture() then
			return true
		end
	end
	return false
end

local function HideTextureRegions(...)
	for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region and region:IsObjectType("Texture") then
			region:SetTexture(nil)
			region:Hide()
		end
	end
end

--skin an addon minimap button and strip its circular ring
local function SkinAddonMinimapButton(button)
	if not button or button.EltruismSkinned or button:IsForbidden() then return end

	if button.SetHighlightTexture then
		button:SetHighlightTexture("")
	end
	if button.SetPushedTexture then
		button:SetPushedTexture("")
	end

	local mainIcon = button.icon or button.Icon or (button.GetNormalTexture and button:GetNormalTexture())
	mainIcon = StripButtonRegions(mainIcon, button:GetRegions())

	if mainIcon and mainIcon.SetTexCoord then
		mainIcon:ClearAllPoints()
		mainIcon:SetInside(button, 1, 1)
		mainIcon:SetTexCoord(unpack(E.TexCoords))
		mainIcon:SetDrawLayer("ARTWORK")
	end

	button:RegisterForDrag()
	ApplyButtonStyle(button, false)
	button.EltruismSkinned = true
end

--check if a child of Minimap is a valid addon button
local function IsValidAddonButton(frame)
	if not frame or frame.EltruismSkinned or frame:IsForbidden() then return false end
	if not frame:IsObjectType("Button") then return false end

	local name = frame:GetName()
	if not name or skippedMinimapFrames[name] then return false end
	local lower = string.lower(name)
	if string.find(lower, "pin") or string.find(lower, "node") or string.find(lower, "note") or string.find(lower, "pointer") or string.find(lower, "questie") or string.find(lower, "gather") or string.find(lower, "handynotes") or string.find(lower, "tomtom") or string.find(lower, "elvui") or string.find(lower, "eltruism") or string.find(lower, "difficulty") or string.find(lower, "queue") or string.find(lower, "instance") or string.find(lower, "lfg") or string.find(lower, "lfd") or string.find(lower, "dungeon") or string.find(lower, "raid") or string.find(lower, "scenario") or string.find(lower, "boss") or string.find(lower, "cluster") or string.find(lower, "backdrop") then
		return false
	end

	if frame.icon or frame.Icon or (frame.GetNormalTexture and frame:GetNormalTexture()) then
		return true
	end
	return HasValidTextureRegion(frame:GetRegions())
end

local function ScanMinimapChildren(...)
	local found = false
	for i = 1, select("#", ...) do
		local child = select(i, ...)
		if IsValidAddonButton(child) then
			SkinAddonMinimapButton(child)
			found = true
		end
	end
	return found
end

--scan LibDBIcon and Minimap children for addon buttons
function ElvUI_EltreumUI:ScanMinimapButtons(forceScan)
	if InCombatLockdown() then
		eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end
	if not E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons.enable then return end

	local foundNew = false

	for i = 1, #barButtons do
		local btn = barButtons[i]
		if btn and not btn.EltruismBlizzButton and not btn.EltruismInBar then
			btn.EltruismInBar = true
			foundNew = true
		end
	end

	--grab LibDBIcon buttons directly
	local LDBI = _G.LibStub and _G.LibStub("LibDBIcon-1.0", true)
	if LDBI and LDBI.objects then
		for _, btn in pairs(LDBI.objects) do
			if btn and not btn.EltruismSkinned then
				SkinAddonMinimapButton(btn)
				foundNew = true
			end
		end
	end

	--only scan Minimap children if child count changed or forced
	if Minimap then
		local numChildren = Minimap:GetNumChildren()
		if forceScan or numChildren ~= lastMinimapChildCount then
			lastMinimapChildCount = numChildren
			if ScanMinimapChildren(Minimap:GetChildren()) then
				foundNew = true
			end
		end
	end

	if foundNew then
		ElvUI_EltreumUI:UpdateMinimapButtonBar()
	end
end

--restore a blizzard button when its move option is turned off
local function RestoreBlizzardButton(frame, skipUpdate)
	if not frame or not frame.EltruismInBar then return end
	frame.EltruismInBar = false
	if frame.EltruismOrigParent then
		frame:SetParent(frame.EltruismOrigParent)
	end
	if frame.EltruismOrigPoint and frame.EltruismOrigPoint[1] then
		frame:ClearAllPoints()
		frame:SetPoint(unpack(frame.EltruismOrigPoint))
	end
	if frame.shadow then
		frame.shadow:Hide()
	end
	if frame == _G.AddonCompartmentFrame and E.Modern then
		E:GetModule("Blizzard"):HandleAddonCompartment()
	end
	if not skipUpdate then
		ElvUI_EltreumUI:UpdateMinimapButtonBar()
	end
end

local function CropGarrisonTexture(btn, tex)
	if tex then
		tex:ClearAllPoints()
		tex:SetInside(btn, 1, 1)
		tex:SetTexCoord(0.2, 0.8, 0.2, 0.8)
	end
end

local function CropGarrisonTextures(btn)
	CropGarrisonTexture(btn, btn:GetNormalTexture())
	CropGarrisonTexture(btn, btn:GetPushedTexture())
	CropGarrisonTexture(btn, btn:GetHighlightTexture())
end

local function GarrisonUpdateIconHook(btn)
	if btn.EltruismInBar then
		local size = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons.iconSize or 24
		CropGarrisonTextures(btn)
		btn:SetSize(size, size)
	end
end

--handle moving or restoring blizzard minimap buttons
function ElvUI_EltreumUI:HandleBlizzardButtons()
	if InCombatLockdown() then
		eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end
	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
	if not db.enable then return end

	--mail (only move if mail animation is not enabled)
	local mailFrame = _G.MiniMapMailFrame or (_G.MinimapCluster and _G.MinimapCluster.IndicatorFrame and _G.MinimapCluster.IndicatorFrame.MailFrame)
	if mailFrame then
		if db.moveMail and not E.db.ElvUI_EltreumUI.otherstuff.mailAnimation then
			if _G.MiniMapMailBorder then _G.MiniMapMailBorder:Hide() end
			local mailIcon = _G.MiniMapMailIcon or mailFrame.MailIcon
			if mailIcon then
				mailIcon:ClearAllPoints()
				mailIcon:SetInside(mailFrame, 2, 2)
			end
			ApplyButtonStyle(mailFrame, true)
			if db.mailOnlyNew then
				mailFrame:SetShown(HasNewMail() and true or false)
			else
				mailFrame:Show()
			end
		else
			RestoreBlizzardButton(mailFrame)
		end
	end

	--tracking
	local trackFrame = _G.MiniMapTracking or _G.MiniMapTrackingFrame or (_G.MinimapCluster and _G.MinimapCluster.Tracking)
	if trackFrame then
		if db.moveTracker and not (E.private.general.minimap and E.private.general.minimap.hideTracking) then
			if _G.MiniMapTrackingBackground then _G.MiniMapTrackingBackground:Hide() end
			if _G.MiniMapTrackingButtonBorder then _G.MiniMapTrackingButtonBorder:Hide() end
			if trackFrame.Background then trackFrame.Background:Hide() end
			local trackBtn = _G.MiniMapTrackingButton or trackFrame.Button
			if trackBtn then
				if trackBtn.SetHighlightTexture then trackBtn:SetHighlightTexture("") end
				if trackBtn.SetPushedTexture then trackBtn:SetPushedTexture("") end
				if not trackBtn.EltruismForwardHover then
					trackBtn:HookScript("OnEnter", function() ButtonOnEnter(trackFrame) end)
					trackBtn:HookScript("OnLeave", function() ButtonOnLeave(trackFrame) end)
					trackBtn.EltruismForwardHover = true
				end
			end
			local trackIcon = _G.MiniMapTrackingIcon or (trackBtn and trackBtn.Icon)
			if trackIcon and trackIcon.SetTexCoord then
				trackIcon:ClearAllPoints()
				trackIcon:SetInside(trackFrame, 2, 2)
				trackIcon:SetTexCoord(unpack(E.TexCoords))
			end
			ApplyButtonStyle(trackFrame, true)
		else
			RestoreBlizzardButton(trackFrame)
		end
	end

	--calendar (classic/tbc/wrath/cata/mists)
	local gameTime = _G.GameTimeFrame
	if gameTime and not E.Retail then
		if db.moveGameTime and not (E.private.general.minimap and E.private.general.minimap.hideCalendar) then
			ApplyButtonStyle(gameTime, true)
		else
			RestoreBlizzardButton(gameTime)
		end
	end

	--expansion summary / garrison button (retail)
	local garrisonBtn = _G.ExpansionLandingPageMinimapButton or _G.GarrisonLandingPageMinimapButton
	if garrisonBtn and E.Retail then
		if db.moveGarrison and not (E.private.general.minimap and E.private.general.minimap.hideClassHallReport) then
			if garrisonBtn.CircleMask then garrisonBtn.CircleMask:Hide() end
			CropGarrisonTextures(garrisonBtn)
			if garrisonBtn.UpdateIcon and not garrisonBtn.EltruismIconHook then
				hooksecurefunc(garrisonBtn, "UpdateIcon", GarrisonUpdateIconHook)
				garrisonBtn.EltruismIconHook = true
			end
			ApplyButtonStyle(garrisonBtn, true)
		else
			RestoreBlizzardButton(garrisonBtn)
		end
	end

	--addon compartment (all game versions)
	local addonComp = _G.AddonCompartmentFrame
	if addonComp then
		if db.moveAddonCompartment and not (E.db.general.addonCompartment and E.db.general.addonCompartment.hide) then
			HideTextureRegions(addonComp:GetRegions())
			if addonComp.Text then
				addonComp.Text:FontTemplate(E.media.normFont, 12, E.db.ElvUI_EltreumUI.skins.armoryfontsize or "OUTLINE")
				addonComp.Text:SetTextColor(E.myClassColor.r, E.myClassColor.g, E.myClassColor.b)
			end
			ApplyButtonStyle(addonComp, true)
		else
			RestoreBlizzardButton(addonComp)
		end
	end
end

--create and update the toggle button
local function UpdateToggleButton()
	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
	if not db.enable or not db.toggleButton then
		if toggleButton then toggleButton:Hide() end
		return
	end

	if not toggleButton then
		toggleButton = CreateFrame("Button", "EltruismMinimapButtonToggle", E.UIParent, "BackdropTemplate")
		toggleButton:SetTemplate("Transparent")
		toggleButton:SetClampedToScreen(true)
		toggleButton:SetFrameStrata("HIGH")
		toggleButton:SetFrameLevel(20)
		toggleButton:RegisterForClicks("AnyUp")

		toggleButton.icon = toggleButton:CreateTexture(nil, "ARTWORK")
		toggleButton.icon:SetInside(toggleButton, 2, 2)
		toggleButton.icon:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga")
		toggleButton.icon:SetVertexColor(0.50, 0.70, 1)

		toggleButton:SetScript("OnEnter", function(self)
			self:SetBackdropBorderColor(E.myClassColor.r, E.myClassColor.g, E.myClassColor.b)
			self.icon:SetVertexColor(1, 1, 1)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
			GameTooltip:AddLine(E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1) .. " " .. (L["Minimap Buttons"] or "Minimap Buttons"))
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(L["Left Click:"], L["Toggle Minimap Button Bar"], 1, 1, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine(L["Right Click:"], E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1) .. " " .. (_G.SETTINGS or "Settings"), 1, 1, 1, 1, 1, 1)
			GameTooltip:Show()
		end)

		toggleButton:SetScript("OnLeave", function(self)
			self:SetBackdropBorderColor(unpack(E.media.bordercolor))
			self.icon:SetVertexColor(0.50, 0.70, 1)
			GameTooltip:Hide()
		end)

		toggleButton:SetScript("OnClick", function(_, mouseButton)
			local curDB = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
			if mouseButton == "LeftButton" then
				curDB.barCollapsed = not curDB.barCollapsed
				PlaySound(856)
				ElvUI_EltreumUI:UpdateMinimapButtonBar()
			elseif mouseButton == "RightButton" then
				E:ToggleOptions("ElvUI_EltreumUI,map,minimapbuttons")
			end
		end)
	end

	local size = db.toggleButtonSize or 20
	local spacing = db.buttonSpacing or 2
	toggleButton:SetSize(size, size)

	if db.shadow then
		if not toggleButton.shadow then
			toggleButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
		end
		ElvUI_EltreumUI:ShadowColor(toggleButton.shadow)
		toggleButton.shadow:Show()
	elseif toggleButton.shadow then
		toggleButton.shadow:Hide()
	end

	toggleButton:ClearAllPoints()
	if db.toggleButtonPosition == "BAR" then
		toggleButton:SetPoint("RIGHT", buttonBar, "LEFT", -spacing, 0)
	else
		local anchor = db.toggleButtonAnchor or "TOPLEFT"
		local offsetX = (anchor == "TOPRIGHT" or anchor == "BOTTOMRIGHT") and -2 or 2
		local offsetY = (anchor == "BOTTOMLEFT" or anchor == "BOTTOMRIGHT") and 2 or -2
		local inset = ElvUI_EltreumUI.rectangleMinimapInset
		if inset and inset > 0 then
			local scaledInset = inset * (E.db.general.minimap.scale or 1)
			if anchor == "TOPLEFT" or anchor == "TOPRIGHT" then
				offsetY = offsetY - scaledInset
			elseif anchor == "BOTTOMLEFT" or anchor == "BOTTOMRIGHT" then
				offsetY = offsetY + scaledInset
			end
		end
		toggleButton:SetPoint(anchor, Minimap, anchor, offsetX, offsetY)
	end
	toggleButton:Show()
end

--update button bar layout, size, backdrop and visibility
function ElvUI_EltreumUI:UpdateMinimapButtonBar()
	if not buttonBar.EltruismMoverCreated then
		return
	end
	if InCombatLockdown() then
		eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
	if not db.enable then
		UnregisterStateDriver(buttonBar, "visibility")
		buttonBar:Hide()
		if toggleButton then toggleButton:Hide() end
		return
	end

	isUpdatingBar = true

	if not E:HasMoverBeenMoved("MoverEltruismMinimapButtonBar") then
		local offsetY = -5
		local inset = ElvUI_EltreumUI.rectangleMinimapInset
		if inset and inset > 0 then
			offsetY = offsetY + (inset * (E.db.general.minimap.scale or 1))
		end
		buttonBar:ClearAllPoints()
		buttonBar:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, offsetY)
		if buttonBar.mover then
			buttonBar.mover:ClearAllPoints()
			buttonBar.mover:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, offsetY)
		end
	end

	buttonBar:SetFrameStrata(db.strata or "MEDIUM")
	buttonBar:SetFrameLevel(db.level or 12)

	table.sort(barButtons, SortBarButtons)
	table.wipe(visibleButtons)

	for i = 1, #barButtons do
		local btn = barButtons[i]
		if btn and btn.EltruismInBar then
			btn:SetParent(buttonBar)
			if db.shadow then
				if not btn.shadow then
					btn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				ElvUI_EltreumUI:ShadowColor(btn.shadow)
				btn.shadow:Show()
			elseif btn.shadow then
				btn.shadow:Hide()
			end
			if btn:IsShown() then
				visibleButtons[#visibleButtons + 1] = btn
			end
		end
	end

	local totalVisible = #visibleButtons
	local iconSize = db.iconSize or 24
	local spacing = db.buttonSpacing or 2
	local perRow = db.buttonsPerRow or 12
	local isVertical = (db.orientation == "VERTICAL")
	local reverse = db.reverseDirection or false

	local anchor = "TOPLEFT"
	local dirX, dirY = 1, -1
	if isVertical then
		if reverse then
			anchor = "BOTTOMLEFT"
			dirY = 1
		end
	elseif reverse then
		anchor = "TOPRIGHT"
		dirX = -1
	end

	for index = 1, totalVisible do
		local btn = visibleButtons[index]
		local col, row
		if isVertical then
			row = (index - 1) % perRow
			col = math.floor((index - 1) / perRow)
		else
			col = (index - 1) % perRow
			row = math.floor((index - 1) / perRow)
		end

		local posX = dirX * (spacing + col * (iconSize + spacing))
		local posY = dirY * (spacing + row * (iconSize + spacing))

		btn:SetParent(buttonBar)
		btn:SetSize(iconSize, iconSize)
		btn:SetScale(1)
		if btn.SetIgnoreParentScale then
			btn:SetIgnoreParentScale(false)
		end
		if btn.SetFixedFrameStrata then
			btn:SetFixedFrameStrata(false)
		end
		if btn.SetFixedFrameLevel then
			btn:SetFixedFrameLevel(false)
		end
		btn:ClearAllPoints()
		btn:SetPoint(anchor, buttonBar, anchor, posX, posY)
		btn:SetFrameStrata(db.strata or "MEDIUM")
		btn:SetFrameLevel((db.level or 12) + 1)
	end

	local numCols, numRows
	if totalVisible == 0 then
		numCols, numRows = 1, 1
	elseif isVertical then
		numRows = math.min(totalVisible, perRow)
		numCols = math.ceil(totalVisible / perRow)
	else
		numCols = math.min(totalVisible, perRow)
		numRows = math.ceil(totalVisible / perRow)
	end

	buttonBar:SetSize(spacing + numCols * (iconSize + spacing), spacing + numRows * (iconSize + spacing))
	UpdateToggleButton()

	if db.backdrop then
		buttonBar:SetTemplate(db.transparent and "Transparent" or "Default")
		if db.shadow then
			if not buttonBar.shadow then
				buttonBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			end
			ElvUI_EltreumUI:ShadowColor(buttonBar.shadow)
			buttonBar.shadow:Show()
		elseif buttonBar.shadow then
			buttonBar.shadow:Hide()
		end
	else
		buttonBar:SetBackdrop(nil)
		if buttonBar.shadow then
			buttonBar.shadow:Hide()
		end
	end

	--turns out RegisterStateDriver is what can toggle things like macros do in elvui
	if (db.toggleButton and db.barCollapsed) or (totalVisible == 0 and not db.toggleButton) then
		UnregisterStateDriver(buttonBar, "visibility")
		buttonBar:Hide()
	else
		if db.hideInCombat then
			RegisterStateDriver(buttonBar, "visibility", "[petbattle][combat] hide; show")
		else
			RegisterStateDriver(buttonBar, "visibility", db.visibility or "[petbattle] hide; show")
		end
		buttonBar:Show()
		if db.barMouseOver then
			if not buttonBar:IsMouseOver() then
				buttonBar:SetAlpha(db.mouseOverAlpha or 0)
			else
				buttonBar:SetAlpha(1)
			end
		else
			buttonBar:SetAlpha(1)
		end
	end

	isUpdatingBar = false
end

--initialize minimap button bar
function ElvUI_EltreumUI:MinimapButtonBar()
	local db = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons

	if not db.enable then
		UnregisterStateDriver(buttonBar, "visibility")
		buttonBar:Hide()
		if toggleButton then toggleButton:Hide() end
		eventFrame:UnregisterAllEvents()
		local restoredAny = false
		for i = 1, #barButtons do
			if barButtons[i] and barButtons[i].EltruismInBar then
				RestoreBlizzardButton(barButtons[i], true)
				restoredAny = true
			end
		end
		if restoredAny then
			ElvUI_EltreumUI:UpdateMinimapButtonBar()
		end
		return
	end

	if not buttonBar.EltruismMoverCreated then
		local offsetY = -5
		local inset = ElvUI_EltreumUI.rectangleMinimapInset
		if inset and inset > 0 then
			offsetY = offsetY + (inset * (E.db.general.minimap.scale or 1))
		end
		buttonBar:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, offsetY)
		buttonBar:SetClampedToScreen(true)
		buttonBar:SetMovable(true)
		buttonBar:EnableMouse(true)
		buttonBar:SetSize(200, 28)

		buttonBar:SetScript("OnEnter", function(bar)
			if E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons.barMouseOver then
				UIFrameFadeIn(bar, 0.2, bar:GetAlpha(), 1)
			end
		end)
		buttonBar:SetScript("OnLeave", function(bar)
			local curDB = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
			if curDB.barMouseOver then
				UIFrameFadeOut(bar, 0.2, bar:GetAlpha(), curDB.mouseOverAlpha or 0)
			end
		end)

		E:CreateMover(buttonBar, "MoverEltruismMinimapButtonBar", L["Eltruism Minimap Button Bar"] or "Eltruism Minimap Button Bar", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, "ElvUI_EltreumUI,otherstuff,minimapbuttons")
		buttonBar.EltruismMoverCreated = true
	end

	--listen to LibDBIcon callback instead of polling with a repeating timer
	local LDBI = _G.LibStub and _G.LibStub("LibDBIcon-1.0", true)
	if LDBI and LDBI.RegisterCallback and not buttonBar.EltruismLDBIHooked then
		LDBI.RegisterCallback(ElvUI_EltreumUI, "LibDBIcon_IconCreated", function(_, button)
			if E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons.enable then
				SkinAddonMinimapButton(button)
				ElvUI_EltreumUI:UpdateMinimapButtonBar()
			end
		end)
		buttonBar.EltruismLDBIHooked = true
	end

	eventFrame:RegisterEvent("ADDON_LOADED")
	eventFrame:RegisterEvent("UPDATE_PENDING_MAIL")
	eventFrame:SetScript("OnEvent", function(_, event)
		local curDB = E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons
		if event == "ADDON_LOADED" then
			ElvUI_EltreumUI:ScanMinimapButtons()
		elseif event == "UPDATE_PENDING_MAIL" then
			if curDB.enable and curDB.moveMail and not E.db.ElvUI_EltreumUI.otherstuff.mailAnimation then
				ElvUI_EltreumUI:HandleBlizzardButtons()
				ElvUI_EltreumUI:UpdateMinimapButtonBar()
			end
		elseif event == "PLAYER_REGEN_ENABLED" then
			eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
			ElvUI_EltreumUI:HandleBlizzardButtons()
			ElvUI_EltreumUI:ScanMinimapButtons(true)
			ElvUI_EltreumUI:UpdateMinimapButtonBar()
		end
	end)

	ElvUI_EltreumUI:HandleBlizzardButtons()
	ElvUI_EltreumUI:ScanMinimapButtons(true)
	ElvUI_EltreumUI:UpdateMinimapButtonBar()

	--single delayed scan after login for addons that create minimap buttons on PLAYER_ENTERING_WORLD
	E:Delay(2, function()
		if E.db.ElvUI_EltreumUI.otherstuff.minimapbuttons.enable then
			ElvUI_EltreumUI:HandleBlizzardButtons()
			ElvUI_EltreumUI:ScanMinimapButtons(true)
			ElvUI_EltreumUI:UpdateMinimapButtonBar()
		end
	end)
end
