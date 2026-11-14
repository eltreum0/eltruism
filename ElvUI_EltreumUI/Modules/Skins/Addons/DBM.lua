local E = unpack(ElvUI)
local S = E:GetModule("Skins")
local _G = _G
local unpack = _G.unpack
local pairs = _G.pairs
local ipairs = _G.ipairs
local type = _G.type
local getmetatable = _G.getmetatable
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local max = _G.math.max

local function AddShadow(frame)
	local shadowDB = E.db.ElvUI_EltreumUI.skins.shadow
	if
		frame
		and shadowDB
		and shadowDB.enable
		and not E.db.ElvUI_EltreumUI.borders.universalborders
		and not frame.shadow
	then
		frame:CreateShadow(shadowDB.length)
		ElvUI_EltreumUI:ShadowColor(frame.shadow)
	end
end

local function StyleBarIcon(frame, statusbar, icon, isRight)
	if not icon then
		return
	end

	icon:SetSize(22.5, 22.5) --(bar.frame:GetHeight()*1.5, bar.frame:GetHeight()*1.5)
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	icon:ClearAllPoints()
	if isRight then
		icon:SetPoint("BOTTOMLEFT", statusbar, "BOTTOMRIGHT", E.PixelMode and 5 or 10, 0)
	else
		icon:SetPoint("BOTTOMRIGHT", statusbar, "BOTTOMLEFT", E.PixelMode and -5 or -10, 0)
	end

	local backdrop = icon.EltruismBackdrop
	if not backdrop then
		backdrop = CreateFrame("Frame", nil, frame)
		backdrop:SetFrameLevel(max(0, statusbar:GetFrameLevel() - 1))
		backdrop:SetOutside(icon)
		backdrop:SetTemplate("Transparent")
		AddShadow(backdrop)
		icon.EltruismBackdrop = backdrop
	end

	backdrop:SetShown(icon:IsShown())
end

local function HideTexture(tex)
	if tex and tex:IsShown() then
		tex:SetAlpha(0)
		tex:Hide()
	end
end

local function StyleBar(bar)
	if not bar or not bar.frame then
		return
	end

	local frame = bar.frame
	local cache = bar.EltruismCache
	if not cache then
		local frameName = frame:GetName()
		if not frameName then
			return
		end
		local barName = frameName .. "Bar"
		local statusbar = _G[barName]
		if not statusbar then
			return
		end

		cache = {
			statusbar = statusbar,
			icon1 = _G[barName .. "Icon1"],
			icon2 = _G[barName .. "Icon2"],
			spark = _G[barName .. "Spark"],
			background = _G[barName .. "Background"],
			borderTop = _G[barName .. "BarBorderTop"] or _G[barName .. "BorderTop"],
			borderBottom = _G[barName .. "BarBorderBottom"] or _G[barName .. "BorderBottom"],
			borderLeft = _G[barName .. "BarBorderLeft"] or _G[barName .. "BorderLeft"],
			borderRight = _G[barName .. "BarBorderRight"] or _G[barName .. "BorderRight"],
		}
		bar.EltruismCache = cache

		if not statusbar.backdrop then
			statusbar:CreateBackdrop("Transparent")
		end
		AddShadow(statusbar.backdrop)
	end

	local statusbar = cache.statusbar
	frame:SetHeight(15) --same as bigwigs
	--keep statusbar height locked to 15 while width tracks frame during AnimateEnlarge
	statusbar:SetHeight(15)
	statusbar:ClearAllPoints()
	statusbar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	statusbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")

	if cache.spark then
		cache.spark:SetTexture(nil)
		cache.spark:SetAlpha(0)
		cache.spark:Hide()
	end
	HideTexture(cache.background)
	HideTexture(cache.borderTop)
	HideTexture(cache.borderBottom)
	HideTexture(cache.borderLeft)
	HideTexture(cache.borderRight)

	StyleBarIcon(frame, statusbar, cache.icon1, false)
	StyleBarIcon(frame, statusbar, cache.icon2, true)

	bar.EltruismSkin = true
end

--dbm skin, made to look similar to bigwigs
function ElvUI_EltreumUI:DBMSkin()
	if not E.db.ElvUI_EltreumUI.skins.dbm or not _G.DBT then
		return
	end

	local prototypeHooked = false
	local function EnsurePrototypeHook(bar)
		if prototypeHooked or not bar then
			return false
		end
		local mt = getmetatable(bar)
		local proto = mt and mt.__index
		if proto and proto.ApplyStyle then
			prototypeHooked = true
			hooksecurefunc(proto, "ApplyStyle", StyleBar)
			return true
		end
		return false
	end

	for bar in _G.DBT:GetBarIterator() do
		EnsurePrototypeHook(bar)
		StyleBar(bar)
	end

	hooksecurefunc(_G.DBT, "CreateBar", function(bars)
		if prototypeHooked then
			return
		end
		for bar in bars:GetBarIterator() do
			EnsurePrototypeHook(bar)
			StyleBar(bar)
		end
	end)
end
S:AddCallbackForAddon("DBM-StatusBarTimers", "EltruismDBM", ElvUI_EltreumUI.DBMSkin)

local function GetAce3Colors()
	local ace3 = E.db.ElvUI_EltreumUI.skins.ace3
	if ace3 and ace3.enable and ace3.button and ace3.button.hovercolor and ace3.tab then
		local r, g, b, a
		if ace3.button.hovercolor.classcolor then
			r, g, b = E.myClassColor.r, E.myClassColor.g, E.myClassColor.b
			a = E.db.general.backdropfadecolor.a
		else
			r = ace3.button.hovercolor.r or 0.07
			g = ace3.button.hovercolor.g or 0.30
			b = ace3.button.hovercolor.b or 0.50
			a = ace3.button.hovercolor.a or 1
		end
		local sr, sg, sb
		if ace3.tab.TextSelected.classcolor then
			sr, sg, sb = E.myClassColor.r, E.myClassColor.g, E.myClassColor.b
		else
			sr = ace3.tab.TextSelected.r or 1
			sg = ace3.tab.TextSelected.g or 1
			sb = ace3.tab.TextSelected.b or 1
		end
		local er, eg, eb
		if ace3.tab.TextEnabled.classcolor then
			er, eg, eb = E.myClassColor.r, E.myClassColor.g, E.myClassColor.b
		else
			er = ace3.tab.TextEnabled.r or 1
			eg = ace3.tab.TextEnabled.g or 0.82
			eb = ace3.tab.TextEnabled.b or 0
		end
		local tex = (ace3.texture and E.LSM:Fetch("statusbar", ace3.texture)) or E.media.normTex
		return r, g, b, a, sr, sg, sb, er, eg, eb, tex
	end

	local vr, vg, vb = unpack(E.media.rgbvaluecolor)
	return vr, vg, vb, 0.3, 1, 1, 1, vr, vg, vb, E.media.normTex
end

local function SyncCollapseTexture(button, texture, skip)
	if skip then
		return
	end
	if texture == 130838 or texture == 130836 or (type(texture) == "string" and texture:find("Plus")) then
		button:SetNormalTexture(E.Media.Textures.PlusButton, true)
		button:SetPushedTexture(E.Media.Textures.PlusButton, true)
	elseif texture == 130821 or texture == 130820 or (type(texture) == "string" and texture:find("Minus")) then
		button:SetNormalTexture(E.Media.Textures.MinusButton, true)
		button:SetPushedTexture(E.Media.Textures.MinusButton, true)
	end
end

local function SkinCollapseToggle(toggle)
	if not toggle or toggle.EltruismSkin then
		return
	end
	toggle:StripTextures()
	toggle:SetHighlightTexture(E.ClearTexture)
	local normal = toggle:GetNormalTexture()
	SyncCollapseTexture(toggle, normal and normal:GetTexture(), false)
	hooksecurefunc(toggle, "SetNormalTexture", SyncCollapseTexture)
	toggle.EltruismSkin = true
end

local function SkinTooltipBackdrop(frame)
	if not frame then
		return
	end
	local mytype = frame.mytype
	if mytype == "line" then
		local name = frame:GetName()
		local lineBG = name and _G[name .. "BG"]
		if lineBG then
			lineBG:SetColorTexture(unpack(E.media.bordercolor))
			lineBG:SetHeight(1)
		end
		return
	end
	if not frame.GetBackdrop then
		return
	end
	local backdrop = frame:GetBackdrop()
	local edgeFile = backdrop and backdrop.edgeFile
	--TooltipBorderBackdropTemplate uses numeric FileDataID 137057 on modern clients
	if
		mytype == "area"
		or mytype == "ability"
		or edgeFile == 137057
		or (type(edgeFile) == "string" and edgeFile:find("Tooltip"))
	then
		frame.backdropInfo = nil
		frame:SetBackdrop(nil)
		frame:SetTemplate("Transparent")
		if mytype == "area" or mytype == "ability" then
			frame:SetBackdropColor(0, 0, 0, 0.25)
		end
	end
end

local function SkinPanelTree(frame)
	if not frame or (frame.IsForbidden and frame:IsForbidden()) then
		return
	end

	local numChildren = frame:GetNumChildren()
	if frame.EltruismSkin and frame.EltruismChildCount == numChildren then
		return
	end

	if not frame.EltruismSkin then
		local objType = frame:GetObjectType()

		if objType == "DropdownButton" or frame.mytype == "dropdown2" then
			S:HandleDropDownBox(frame, frame:GetWidth(), "Transparent")
		elseif objType == "Button" then
			if frame.toggle then
				--ability header rows use OptionsListButtonTemplate with a toggle child
				SkinCollapseToggle(frame.toggle)
				local highlight = frame:GetHighlightTexture()
				if highlight then
					highlight:SetColorTexture(1, 1, 1, 0.08)
				end
			else
				local name = frame:GetName()
				if name and name:find("DropDown") then
					S:HandleDropDownBox(frame, frame:GetWidth(), "Transparent")
				elseif name and name:find("Close") then
					S:HandleCloseButton(frame)
				else
					S:HandleButton(frame)
				end
			end
		elseif objType == "EditBox" then
			S:HandleEditBox(frame)
		elseif objType == "Slider" then
			S:HandleSliderFrame(frame)
		elseif objType == "CheckButton" then
			S:HandleCheckBox(frame)
		elseif objType == "ScrollFrame" then
			if frame.ScrollBar and not frame.ScrollBar.EltruismSkin then
				S:HandleScrollBar(frame.ScrollBar)
				frame.ScrollBar.EltruismSkin = true
			end
		elseif objType == "Frame" then
			SkinTooltipBackdrop(frame)
		end

		frame.EltruismSkin = true
	end

	frame.EltruismChildCount = numChildren
	if numChildren > 0 then
		local children = { frame:GetChildren() }
		for _, child in ipairs(children) do
			SkinPanelTree(child)
		end
	end
end

local function UpdateTabVisuals(mainFrame)
	if not mainFrame or not mainFrame.tabs then
		return
	end
	local hr, hg, hb, ha, sr, sg, sb, er, eg, eb = GetAce3Colors()
	local br, bg, bb, ba = unpack(E.media.backdropfadecolor)
	local activeTab = mainFrame.tab
	for i = 1, #mainFrame.tabs do
		local tab = _G["DBM_GUI_OptionsFrameTab" .. i]
		if tab then
			local isSelected = (i == activeTab)
			tab.selected = isSelected
			if tab.backdrop then
				if isSelected then
					tab.backdrop:SetBackdropColor(hr, hg, hb, ha)
				else
					tab.backdrop:SetBackdropColor(br, bg, bb, ba)
				end
			end
			if tab.Text then
				if isSelected then
					tab.Text:SetTextColor(sr, sg, sb)
				else
					tab.Text:SetTextColor(er, eg, eb)
				end
			end
		end
	end
end

local function KeepSelectedTabText(tab)
	if tab.selected and tab.Text then
		local _, _, _, _, sr, sg, sb = GetAce3Colors()
		tab.Text:SetTextColor(sr, sg, sb)
	end
end

local function SkinMainFrame()
	local mainFrame = _G.DBM_GUI_OptionsFrame
	if not mainFrame or mainFrame.EltruismSkin then
		return
	end

	S:HandleFrame(mainFrame, true, "Transparent")
	if mainFrame.Bg then
		mainFrame.Bg:Hide()
	end
	AddShadow(mainFrame)

	local hr, hg, hb, _, _, _, _, _, _, _, statusTex = GetAce3Colors()
	local listFrame = _G.DBM_GUI_OptionsFrameList
	local container = _G.DBM_GUI_OptionsFramePanelContainer
	local wrapper = container and container:GetParent()

	if wrapper and wrapper ~= mainFrame and not wrapper.EltruismSkin then
		--split wrapper into two ace3-style boxed panels (left tree + right options)
		wrapper:StripTextures(true)
		wrapper.backdropInfo = nil
		wrapper:SetBackdrop(nil)
		wrapper.EltruismSkin = true
	end

	if listFrame then
		if not listFrame.backdrop then
			listFrame:CreateBackdrop("Transparent")
			listFrame.backdrop:ClearAllPoints()
			listFrame.backdrop:SetPoint("TOPLEFT", listFrame, "TOPLEFT", -2, 2)
			listFrame.backdrop:SetPoint("BOTTOMRIGHT", listFrame, "BOTTOMRIGHT", 2, -2)
		end
		if listFrame.buttons then
			for _, button in ipairs(listFrame.buttons) do
				SkinCollapseToggle(button.toggle)
				local highlight = button:GetHighlightTexture()
				if highlight and not button.EltruismHighlight then
					highlight:SetTexture(statusTex)
					highlight:SetBlendMode("BLEND")
					highlight:SetVertexColor(hr, hg, hb, 0.35)
					highlight:ClearAllPoints()
					highlight:SetAllPoints(button)
					button.EltruismHighlight = true
				end
			end
		end
	end

	if container then
		if listFrame and wrapper and wrapper ~= mainFrame then
			container:ClearAllPoints()
			container:SetPoint("TOPLEFT", listFrame, "TOPRIGHT", 29, 0)
			container:SetPoint("BOTTOMRIGHT", wrapper, "BOTTOMRIGHT", 0, 2)
		end
		if not container.backdrop then
			container:CreateBackdrop("Transparent")
			container.backdrop:ClearAllPoints()
			container.backdrop:SetPoint("TOPLEFT", container, "TOPLEFT", -2, 2)
			container.backdrop:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, -2)
		end
		if container:GetNumChildren() > 0 then
			local children = { container:GetChildren() }
			for _, child in ipairs(children) do
				if child and child:IsShown() then
					local name = child:GetName()
					if name and name:find("^DBM_GUI_Option_") then
						SkinPanelTree(child)
					end
				end
			end
		end
	end

	if _G.DBM_GUI_OptionsFrameClosePanelButton and not _G.DBM_GUI_OptionsFrameClosePanelButton.EltruismSkin then
		S:HandleCloseButton(_G.DBM_GUI_OptionsFrameClosePanelButton)
		_G.DBM_GUI_OptionsFrameClosePanelButton.EltruismSkin = true
	end

	local buttons = {
		_G.DBM_GUI_OptionsFrameCollapseButton,
		_G.DBM_GUI_OptionsFrameOkay,
		_G.DBM_GUI_OptionsFrameWebsiteButton,
		_G.DBM_GUI_OptionsFrameSearchClear,
	}
	for _, btn in pairs(buttons) do
		if btn and not btn.EltruismSkin then
			S:HandleButton(btn)
			btn.EltruismSkin = true
		end
	end

	local searchBox = _G.DBM_GUI_OptionsFrameSearchBox
	if searchBox and not searchBox.EltruismSkin then
		S:HandleEditBox(searchBox)
		searchBox:ClearAllPoints()
		searchBox:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -40, -35)
		local anchor = searchBox.backdrop or searchBox
		if _G.DBM_GUI_OptionsFrameSearchLabel then
			_G.DBM_GUI_OptionsFrameSearchLabel:ClearAllPoints()
			_G.DBM_GUI_OptionsFrameSearchLabel:SetPoint("RIGHT", anchor, "LEFT", -6, 0)
		end
		if _G.DBM_GUI_OptionsFrameSearchClear then
			_G.DBM_GUI_OptionsFrameSearchClear:ClearAllPoints()
			_G.DBM_GUI_OptionsFrameSearchClear:SetPoint("LEFT", anchor, "RIGHT", 3, 0)
		end
		if _G.DBM_GUI_OptionsFrameSearchCount then
			_G.DBM_GUI_OptionsFrameSearchCount:ClearAllPoints()
			_G.DBM_GUI_OptionsFrameSearchCount:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", 2, 2)
		end
		searchBox.EltruismSkin = true
	end

	--skin bottom-right resize grabber to match elvui config arrow
	if mainFrame:GetNumChildren() > 0 then
		local mainChildren = { mainFrame:GetChildren() }
		for _, child in ipairs(mainChildren) do
			if child and not child.EltruismSkin and child:GetObjectType() == "Button" and not child:GetName() then
				local point = child:GetPoint()
				if point == "BOTTOMRIGHT" and child:GetNormalTexture() and child:GetScript("OnMouseDown") then
					child:ClearAllPoints()
					child:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -2, 2)
					child:SetSize(14, 14)
					for _, texMethod in ipairs({ "GetNormalTexture", "GetPushedTexture", "GetHighlightTexture" }) do
						local region = child[texMethod] and child[texMethod](child)
						if region then
							region:SetTexture(E.Media.Textures.ArrowUp)
							region:SetTexCoord(0, 1, 0, 1)
							region:SetRotation(-2.35)
							region:ClearAllPoints()
							region:SetAllPoints(child)
							region:SetVertexColor(hr, hg, hb, texMethod == "GetHighlightTexture" and 1 or 0.8)
						end
					end
					child.EltruismSkin = true
					break
				end
			end
		end
	end

	local containerScrollBar = _G.DBM_GUI_OptionsFramePanelContainerFOVScrollBar
	if containerScrollBar and not containerScrollBar.EltruismSkin then
		--dbm anchors TOPRIGHT at -4,-15 and BOTTOMRIGHT at 0,15 with an anonymous tooltip backdrop child
		containerScrollBar:ClearAllPoints()
		containerScrollBar:SetPoint("TOPRIGHT", -4, -19)
		containerScrollBar:SetPoint("BOTTOMRIGHT", -4, 19)
		if containerScrollBar:GetNumChildren() > 0 then
			local sbChildren = { containerScrollBar:GetChildren() }
			for _, child in ipairs(sbChildren) do
				if child and not child:GetName() and child.GetBackdrop then
					local backdrop = child:GetBackdrop()
					local edgeFile = backdrop and backdrop.edgeFile
					if edgeFile == 137057 or (type(edgeFile) == "string" and edgeFile:find("Tooltip")) then
						child.backdropInfo = nil
						child:SetBackdrop(nil)
						child:Hide()
					end
				end
			end
		end
	end

	local scrollBars = {
		_G.DBM_GUI_OptionsFrameListScrollBar,
		containerScrollBar,
	}
	for _, sb in pairs(scrollBars) do
		if sb and not sb.EltruismSkin then
			S:HandleScrollBar(sb)
			sb.EltruismSkin = true
		end
	end

	local numTabs = (mainFrame.tabs and #mainFrame.tabs) or 8
	for i = 1, numTabs do
		local tab = _G["DBM_GUI_OptionsFrameTab" .. i]
		if tab and not tab.EltruismSkin then
			--zero alpha so MinimalTabMixin/PanelTemplates atlas updates stay hidden
			tab:StripTextures(nil, true)
			local width = (tab.Text and tab.Text:GetStringWidth() or 60) + 18
			tab:SetSize(max(width, 40), 23)
			if i == 1 then
				tab:ClearAllPoints()
				tab:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 15, -34)
			end
			S:HandleTab(tab)
			if tab.backdrop then
				tab.backdrop:ClearAllPoints()
				tab.backdrop:SetAllPoints(tab)
			end
			if not tab.EltruismTabHook then
				tab:HookScript("OnLeave", KeepSelectedTabText)
				tab.EltruismTabHook = true
			end
			tab.EltruismSkin = true
		end
	end

	hooksecurefunc(mainFrame, "ShowTab", UpdateTabVisuals)
	UpdateTabVisuals(mainFrame)

	mainFrame.EltruismSkin = true
end

--dbm gui
function ElvUI_EltreumUI:DBMGUISkin()
	if not E.db.ElvUI_EltreumUI.skins.dbm or not _G.DBM_GUI or not _G.DBM_GUI_OptionsFrame then
		return
	end

	hooksecurefunc(_G.DBM_GUI_OptionsFrame, "DisplayFrame", function(_, targetFrame)
		if targetFrame then
			SkinPanelTree(targetFrame)
		end
	end)

	local function SkinOnShow()
		if not _G.DBM_GUI_OptionsFrame.EltruismSkin and _G.DBM_GUI_OptionsFrame:IsShown() then
			SkinMainFrame()
		end
	end

	hooksecurefunc(_G.DBM_GUI, "ShowHide", SkinOnShow)
	SkinOnShow()
end
S:AddCallbackForAddon("DBM-GUI", "EltruismDBMGUI", ElvUI_EltreumUI.DBMGUISkin)

local function SkinPopupDialog(frame)
	if not frame or frame.EltruismSkin then
		return
	end
	frame.backdropInfo = nil
	frame:SetTemplate("Transparent")
	AddShadow(frame)
	SkinPanelTree(frame)
end

local function SkinDefaultPanel(frame)
	if not frame or frame.EltruismSkin then
		return
	end

	S:HandleFrame(frame, true, "Transparent")
	if frame.Bg then
		frame.Bg:Hide()
	end
	AddShadow(frame)

	--only skin outer controls
	if frame:GetNumChildren() > 0 then
		local children = { frame:GetChildren() }
		for _, child in ipairs(children) do
			if not child.EltruismSkin then
				local objType = child:GetObjectType()
				if objType == "ScrollFrame" then
					if child.ScrollBar and not child.ScrollBar.EltruismSkin then
						S:HandleScrollBar(child.ScrollBar)
						child.ScrollBar.EltruismSkin = true
					end
				elseif objType == "Button" then
					local name = child:GetName()
					if child.LeftActive or child.RightDisabled or (name and name:find("Tab%d+$")) then
						child:StripTextures(nil, true)
						S:HandleTab(child)
						child.EltruismSkin = true
					elseif child:GetWidth() <= 32 and child:GetHeight() <= 32 then
						local normalTex = child:GetNormalTexture()
						local tex = normalTex and normalTex:GetTexture()
						local atlas = normalTex and normalTex.GetAtlas and normalTex:GetAtlas()
						if
							(type(atlas) == "string" and atlas:find("Exit"))
							or (type(tex) == "string" and tex:find("Minimize"))
						then
							S:HandleCloseButton(child)
							child.EltruismSkin = true
						end
					end
				end
			end
		end
	end

	frame.EltruismSkin = true
end

--dbm core standalone frames
function ElvUI_EltreumUI:DBMCoreSkin()
	if not E.db.ElvUI_EltreumUI.skins.dbm or not _G.DBM then
		return
	end

	local DBM = _G.DBM

	if _G.DBMInfoFrame then
		SkinPopupDialog(_G.DBMInfoFrame)
	elseif DBM.InfoFrame then
		local function OnInfoShow()
			SkinPopupDialog(_G.DBMInfoFrame)
		end
		if DBM.InfoFrame.Show then
			hooksecurefunc(DBM.InfoFrame, "Show", OnInfoShow)
		end
		if DBM.InfoFrame.ShowDirect then
			hooksecurefunc(DBM.InfoFrame, "ShowDirect", OnInfoShow)
		end
	end

	if _G.DBMRangeCheck then
		SkinPopupDialog(_G.DBMRangeCheck)
	elseif DBM.RangeCheck and DBM.RangeCheck.Show then
		hooksecurefunc(DBM.RangeCheck, "Show", function()
			SkinPopupDialog(_G.DBMRangeCheck)
		end)
	end

	if _G.DBMBattleRezTimerFrame then
		SkinPopupDialog(_G.DBMBattleRezTimerFrame)
	elseif DBM.BattleRezTimer and DBM.BattleRezTimer.Show then
		hooksecurefunc(DBM.BattleRezTimer, "Show", function()
			SkinPopupDialog(_G.DBMBattleRezTimerFrame)
		end)
	end

	if _G.DBMKeystonesFrame then
		SkinDefaultPanel(_G.DBMKeystonesFrame)
	end

	if _G.DBMRaidChecksFrame then
		SkinDefaultPanel(_G.DBMRaidChecksFrame)
	elseif DBM.RaidChecks and DBM.RaidChecks.Show then
		hooksecurefunc(DBM.RaidChecks, "Show", function()
			SkinDefaultPanel(_G.DBMRaidChecksFrame)
		end)
	end

	if _G.DBMNotesEditor then
		SkinPopupDialog(_G.DBMNotesEditor)
	else
		local function OnNotesShow()
			SkinPopupDialog(_G.DBMNotesEditor)
		end
		if DBM.ShowNoteEditor then
			hooksecurefunc(DBM, "ShowNoteEditor", OnNotesShow)
		end
		if DBM.ShowTextEditor then
			hooksecurefunc(DBM, "ShowTextEditor", OnNotesShow)
		end
	end

	if _G.DBMUpdateReminder then
		SkinPopupDialog(_G.DBMUpdateReminder)
	elseif DBM.ShowUpdateReminder then
		hooksecurefunc(DBM, "ShowUpdateReminder", function()
			SkinPopupDialog(_G.DBMUpdateReminder)
		end)
	end
end
S:AddCallbackForAddon("DBM-Core", "EltruismDBMCore", ElvUI_EltreumUI.DBMCoreSkin)
