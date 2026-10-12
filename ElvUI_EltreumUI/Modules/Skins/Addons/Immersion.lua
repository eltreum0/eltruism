local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
--local classcolor = E.myClassColor
local pairs = _G.pairs
local ipairs = _G.ipairs
local tostring = _G.tostring
local tonumber = _G.tonumber
local InCombatLockdown = _G.InCombatLockdown
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local GetQuestItemInfo = _G.GetQuestItemInfo
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local hooksecurefunc = _G.hooksecurefunc

local function SkinTitleButton(v)
	if not v then return end

	if not v.isSkinned then
		--S:HandleButton(v,true,nil,nil,true,"TRANSPARENT")
		S:HandleButton(v)
		--v:CreateBackdrop('Transparent')
		v.isSkinned = true
	end

	if v.Hilite then
		v.Hilite:StripTextures()
		v.Hilite:Hide()
	end
	if v.Overlay then
		v.Overlay:StripTextures()
		v.Overlay:Hide()
	end

	--v:StyleButton()
	if v.Center then
		v:SetBackdropColor(0, 0, 0, E.db.general.backdropfadecolor.a)
		v.Center:Show()
		if E.db.general and E.db.general.backdropfadecolor then
			v.Center:SetAlpha(E.db.general.backdropfadecolor.a)
		end
	end
	--v.Center.SetAlpha = E.noop
	--v.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
	if v.backdrop and v.backdrop.Center then
		v.backdrop.Center:Show()
		if E.db.general and E.db.general.backdropfadecolor then
			v.backdrop.Center:SetAlpha(E.db.general.backdropfadecolor.a)
		end
	end

	--v.hover:SetVertexColor(classcolor.r, classcolor.g,classcolor.b, 0.7) --hover color
	--v.pushed:SetColorTexture(classcolor.r, classcolor.g,classcolor.b, 0.8) --pushed color

	if v.Label and E.LSM:Fetch("font", E.db.general.font) then
		v.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 3, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		v.Label:SetShadowOffset(1, -1)
	end

	if v.Counter and E.LSM:Fetch("font", E.db.general.font) then
		v.Counter:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	end

	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
		if not v.shadow then
			v:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(v.shadow)
		end
	end

	if not v.EltruismPoint then
		local point, relativeTo, relativePoint, xOfs, yOfs = v:GetPoint()
		if point then
			v:ClearAllPoints()
			v:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs - 5)
			v.EltruismPoint = true
		end
	end
end

local function SkinAllTitleButtons()
	if not E.db.general or not E.db.general.font or not E.LSM:Fetch("font", E.db.general.font) then return end

	local titleButtons = _G["ImmersionFrame"] and _G["ImmersionFrame"].TitleButtons
	if not titleButtons then return end

	if titleButtons.Buttons then
		for _, btn in pairs(titleButtons.Buttons) do
			SkinTitleButton(btn)
		end
	end

	for _, child in ipairs({ titleButtons:GetChildren() }) do
		if child and child.Label then
			SkinTitleButton(child)
		end
	end

	for i = 1, 30 do
		local btn = _G["ImmersionTitleButton" .. i]
		if btn then
			SkinTitleButton(btn)
		end
	end
end

local function SkinRewardItem(item, isProgress)
	if not item then return end

	if not item.EltruismSkin then
		if item.NameFrame then
			item.NameFrame:StripTextures()
			item.NameFrame:CreateBackdrop('Transparent')
			if item.NameFrame.backdrop then
				item.NameFrame.backdrop:ClearAllPoints()
				item.NameFrame.backdrop:SetPoint("TOPLEFT", item.Name, "TOPLEFT", -3, isProgress and 0 or -1)
				item.NameFrame.backdrop:SetPoint("BOTTOMRIGHT", item.Name, "BOTTOMRIGHT", -7, 0)
				--item.NameFrame.backdrop:SetOutside(item.Name)
				item.NameFrame.backdrop:SetAlpha(0.5) --transparent is setting alpha to 1 for some reason
			end
		end
		item.EltruismSkin = true
	else
		if item.NameFrame and item.NameFrame.backdrop and item.Name then
			item.NameFrame.backdrop:ClearAllPoints()
			item.NameFrame.backdrop:SetPoint("TOPLEFT", item.Name, "TOPLEFT", -3, isProgress and 0 or -1)
			item.NameFrame.backdrop:SetPoint("BOTTOMRIGHT", item.Name, "BOTTOMRIGHT", -7, 0)
		end
	end

	if item.Name then
		if E.LSM:Fetch("font", E.db.general.font) then
			item.Name:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		end
		if item.objectType and item.objectType == "item" and item.type and item.GetID and item:GetID() then
			local _, _, _, quality = GetQuestItemInfo(tostring(item.type), tonumber(item:GetID()))
			if quality then
				local r, g, b = GetItemQualityColor(quality)
				if r and g and b then
					item.Name:SetTextColor(r, g, b)
					--item.NameFrame.backdrop:SetBackdropBorderColor(r, g, b)
				end
			end
		elseif item.objectType and item.objectType == "currency" and item.type and item.GetID and item:GetID() then
			local currencyInfo = _G.ImmersionAPI and _G.ImmersionAPI.GetQuestCurrencyInfo and _G.ImmersionAPI:GetQuestCurrencyInfo(item.type, item:GetID())
			if currencyInfo and currencyInfo.quality then
				local r, g, b = GetItemQualityColor(currencyInfo.quality)
				if r and g and b then
					item.Name:SetTextColor(r, g, b)
				end
			end
		end
	end
end

local function SkinAllRewardButtons()
	if not E.db.general or not E.db.general.font or not E.LSM:Fetch("font", E.db.general.font) then return end

	for i = 1, 30 do --button seems to go to 20, but there might be more somewhere
		local questItem = _G["ImmersionQuestInfoItem" .. i]
		if questItem then
			SkinRewardItem(questItem, false)
		end
		local progItem = _G["ImmersionProgressItem" .. i]
		if progItem then
			SkinRewardItem(progItem, true)
		end
	end

	local elements = _G["ImmersionFrame"] and _G["ImmersionFrame"].TalkBox and _G["ImmersionFrame"].TalkBox.Elements
	if elements then
		if elements.Content and elements.Content.RewardsFrame and elements.Content.RewardsFrame.Buttons then
			for _, btn in pairs(elements.Content.RewardsFrame.Buttons) do
				SkinRewardItem(btn, false)
			end
		end
		if elements.Progress and elements.Progress.Buttons then
			for _, btn in pairs(elements.Progress.Buttons) do
				SkinRewardItem(btn, true)
			end
		end
	end
end

--update buttons on events/show
local function updatebuttons()
	if not E.db.general then return end
	if not E.db.general.font then return end
	if not E.db.general.fontSize then return end
	if not E.db.general.fontStyle then return end
	if not E.LSM:Fetch("font", E.db.general.font) then return end

	--move so it doesnt overlap
	if not InCombatLockdown() and _G["ImmersionFrame"] and _G["ImmersionFrame"].TalkBox and _G["ImmersionFrame"].TalkBox.Elements then
		_G["ImmersionFrame"].TalkBox.Elements:ClearAllPoints()
		_G["ImmersionFrame"].TalkBox.Elements:SetPoint("TOP", _G["ImmersionFrame"].TalkBox, "BOTTOM", 0, -10)
	end

	SkinAllRewardButtons()
	SkinAllTitleButtons()
end

--skin immersion
function ElvUI_EltreumUI:EltruismImmersion()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then return end
	if not E.db.general.font then return end
	if not E.db.general.fontSize then return end
	if not E.db.general.fontStyle then return end
	if not E.LSM:Fetch("font", E.db.general.font) then return end
	if E.db.ElvUI_EltreumUI.skins.immersion then
		local frames = {
			_G["ImmersionFrame"].TalkBox.BackgroundFrame,
			_G["ImmersionFrame"].TalkBox.Elements,
			_G["ImmersionFrame"].TalkBox.PortraitFrame,
		}
		for _, v in pairs(frames) do
			S:HandleFrame(v)
		end

		if _G["ImmersionFrame"].TalkBox.ReputationBar then
			S:HandleStatusBar(_G["ImmersionFrame"].TalkBox.ReputationBar)
			_G["ImmersionFrame"].TalkBox.ReputationBar:ClearAllPoints()
			_G["ImmersionFrame"].TalkBox.ReputationBar:SetPoint("BOTTOMLEFT", _G["ImmersionFrame"].TalkBox, "TOPLEFT", 0, E.db.ElvUI_EltreumUI.skins.shadow.length)
			_G["ImmersionFrame"].TalkBox.ReputationBar:SetPoint("BOTTOMRIGHT", _G["ImmersionFrame"].TalkBox, "TOPRIGHT", 0, E.db.ElvUI_EltreumUI.skins.shadow.length)
			_G["ImmersionFrame"].TalkBox.ReputationBar:SetHeight(4)
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
				if not _G["ImmersionFrame"].TalkBox.ReputationBar.shadow then
					_G["ImmersionFrame"].TalkBox.ReputationBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(_G["ImmersionFrame"].TalkBox.ReputationBar.shadow)
				end
			end
		end

		if _G["ImmersionFrame"].TalkBox.ProgressionBar then
			S:HandleStatusBar(_G["ImmersionFrame"].TalkBox.ProgressionBar)
			local width, height = _G["ImmersionFrame"].TalkBox.ProgressionBar:GetSize()
			_G["ImmersionFrame"].TalkBox.ProgressionBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(E.myclass, false, false))
			_G["ImmersionFrame"].TalkBox.ProgressionBar:SetSize(width,height+5)
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			for _, frame in pairs(frames) do
				if frame and not frame.shadow then
					frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(frame.shadow)
				end
			end
			if E.Classic then
				if _G["ImmersionFrame"].TalkBox.BackgroundFrame.shadow then
					_G["ImmersionFrame"].TalkBox.BackgroundFrame.shadow:Hide()
				end
				local classicframes = {
					_G["ImmersionFrame"].TalkBox.MainFrame,
					_G["ImmersionFrame"].TalkBox.Elements,
				}
				for _, frame in pairs(classicframes) do
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
			end
		end

		S:HandleCloseButton(_G["ImmersionFrame"].TalkBox.MainFrame.CloseButton)

		--hide highlights/animations
		_G["ImmersionFrame"].TalkBox.MainFrame.Model.ModelShadow:Hide()
		_G["ImmersionFrame"].TalkBox.MainFrame.Model.PortraitBG:Hide()
		_G["ImmersionFrame"].TalkBox.Hilite:Hide()
		_G["ImmersionFrame"].TalkBox.PortraitFrame:Hide()
		_G["ImmersionFrame"].TalkBox.MainFrame.TextSheen:StripTextures()
		_G["ImmersionFrame"].TalkBox.MainFrame.Sheen:StripTextures()
		_G["ImmersionFrame"].TalkBox.MainFrame.Overlay:StripTextures()

		--fonts
		if _G["ImmersionFrame"].TalkBox.TextFrame then
			if _G["ImmersionFrame"].TalkBox.TextFrame.SpeechProgress then
				_G["ImmersionFrame"].TalkBox.TextFrame.SpeechProgress:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
			if _G["ImmersionFrame"].TalkBox.NameFrame.Name then
				_G["ImmersionFrame"].TalkBox.NameFrame.Name:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
			if _G["ImmersionFrame"].TalkBox.TextFrame.Text then
				_G["ImmersionFrame"].TalkBox.TextFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 2, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
		end
		if _G["ImmersionContentFrame"] then
			if _G["ImmersionContentFrame"].ObjectivesHeader then
				_G["ImmersionContentFrame"].ObjectivesHeader:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
			if _G["ImmersionContentFrame"].ObjectivesText then
				_G["ImmersionContentFrame"].ObjectivesText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 1, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end

			if _G["ImmersionContentFrame"].RewardsFrame then
				if _G["ImmersionContentFrame"].RewardsFrame.Header then
					_G["ImmersionContentFrame"].RewardsFrame.Header:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				end
				if _G["ImmersionContentFrame"].RewardsFrame.ItemChooseText then
					_G["ImmersionContentFrame"].RewardsFrame.ItemChooseText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 1, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				end
				if _G["ImmersionContentFrame"].RewardsFrame.ItemReceiveText then
					_G["ImmersionContentFrame"].RewardsFrame.ItemReceiveText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize + 1, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				end
			end
		end

		--buttons are created depending on quest, hook frame to update them
		_G["ImmersionFrame"]:HookScript("OnShow", updatebuttons)
		_G["ImmersionFrame"]:HookScript("OnEvent", updatebuttons)

		local titleButtons = _G["ImmersionFrame"].TitleButtons
		if titleButtons then
			titleButtons:HookScript("OnShow", SkinAllTitleButtons)
			titleButtons:HookScript("OnEvent", SkinAllTitleButtons)
			if titleButtons.UpdateActive then
				hooksecurefunc(titleButtons, "UpdateActive", SkinAllTitleButtons)
			end
			if titleButtons.GetButton then
				hooksecurefunc(titleButtons, "GetButton", function(_, index)
					local btn = (titleButtons.Buttons and titleButtons.Buttons[index]) or _G["ImmersionTitleButton" .. index]
					if btn then
						SkinTitleButton(btn)
					end
				end)
			end
		end

		local elements = _G["ImmersionFrame"].TalkBox and _G["ImmersionFrame"].TalkBox.Elements
		if elements then
			elements:HookScript("OnShow", updatebuttons)
			if elements.Display then
				hooksecurefunc(elements, "Display", SkinAllRewardButtons)
			end
			if elements.ShowRewards then
				hooksecurefunc(elements, "ShowRewards", SkinAllRewardButtons)
			end
			if elements.ShowProgress then
				hooksecurefunc(elements, "ShowProgress", SkinAllRewardButtons)
			end
			if elements.Content and elements.Content.RewardsFrame then
				elements.Content.RewardsFrame:HookScript("OnShow", SkinAllRewardButtons)
			end
			if elements.Progress then
				elements.Progress:HookScript("OnShow", SkinAllRewardButtons)
			end
		end

		updatebuttons() --fire before it shows just in case
	end
end
S:AddCallbackForAddon('Immersion', "EltruismImmersion", ElvUI_EltreumUI.EltruismImmersion)
