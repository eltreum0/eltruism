local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local pairs = _G.pairs
local ipairs = _G.ipairs
local select = _G.select
local unpack = _G.unpack
local tostring = _G.tostring
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local valuecolors = E.myClassColor

--skin image popup
local function SkinImagePopup(popup)
	if not popup or popup.IsSkinned then return end

	popup:SetTemplate('Transparent')
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
		if not popup.shadow then
			popup:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(popup.shadow)
		end
	end

	for _, child in pairs({ popup:GetChildren() }) do
		if child:IsObjectType('Button') then
			local p1 = select(1, child:GetPoint())
			local tex = child:GetNormalTexture() and child:GetNormalTexture():GetTexture()
			local texStr = tex and tostring(tex) or ''
			if texStr:find('Close') or p1 == 'TOPRIGHT' or (child:GetWidth() >= 20 and child:GetWidth() <= 40 and not child:GetText()) then
				S:HandleCloseButton(child)
				child:ClearAllPoints()
				child:SetPoint('TOPRIGHT', popup, 'TOPRIGHT', -4, -4)
			end
		end
	end

	if popup._title and E.LSM:Fetch('font', E.db.general.font) then
		popup._title:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 2, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	end

	popup.IsSkinned = true
end

--skin rows and elements inside the scroll child
local function SkinRows(scrollChild)
	if not scrollChild then return end

	--embed thumbnail button when no guide is selected
	if scrollChild._embedThumb and not scrollChild._embedThumb.IsSkinned then
		if scrollChild._embedThumb._border then
			scrollChild._embedThumb._border:Hide()
		end
		scrollChild._embedThumb:CreateBackdrop('Transparent')
		if scrollChild._embedThumb._tex then
			scrollChild._embedThumb._tex:SetTexCoord(unpack(E.TexCoords))
		end
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			if not scrollChild._embedThumb.shadow then
				scrollChild._embedThumb:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(scrollChild._embedThumb.shadow)
			end
		end
		scrollChild._embedThumb.IsSkinned = true
	end

	--empty message font
	if scrollChild._emptyMessage and E.LSM:Fetch('font', E.db.general.font) then
		scrollChild._emptyMessage:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	end

	--headers
	if scrollChild._ftaHeaders then
		for _, header in ipairs(scrollChild._ftaHeaders) do
			if header and E.LSM:Fetch('font', E.db.general.font) then
				header:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 2, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
		end
	end

	--loop over row children in scrollChild
	for i = 1, scrollChild:GetNumChildren() do
		local row = select(i, scrollChild:GetChildren())
		if row and row:IsShown() then
			--row text
			if row.text and E.LSM:Fetch('font', E.db.general.font) then
				row.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
			if row.sub and E.LSM:Fetch('font', E.db.general.font) then
				row.sub:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize - 1, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end

			--module button
			if row.btn and not row.btn.IsSkinned then
				S:HandleButton(row.btn)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not row.btn.shadow then
						row.btn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(row.btn.shadow)
					end
				end
				row.btn.IsSkinned = true
			end

			--manual check button
			if row.manualCheck and not row.manualCheck.IsSkinned then
				S:HandleCheckBox(row.manualCheck)
				if row.manualCheckHolder then
					row.manualCheckHolder:SetBackdrop(nil)
				end
				row.manualCheck.IsSkinned = true
			end

			--thumb button
			if row.thumbBtn and not row.thumbBtn.IsSkinned then
				if row.thumbBorderFrame then
					row.thumbBorderFrame:Hide()
				end
				row.thumbBtn:CreateBackdrop('Transparent')
				if row.thumbIcon then
					row.thumbIcon:SetTexCoord(unpack(E.TexCoords))
				end
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not row.thumbBtn.shadow then
						row.thumbBtn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(row.thumbBtn.shadow)
					end
				end
				row.thumbBtn:HookScript('OnClick', function()
					E:Delay(0, function()
						if _G['FollowTheArrow_ImagePopup'] then
							SkinImagePopup(_G['FollowTheArrow_ImagePopup'])
						end
					end)
				end)
				row.thumbBtn.IsSkinned = true
			end

			--choice tiles
			if row._choiceTiles then
				for _, tile in ipairs(row._choiceTiles) do
					if tile and not tile.IsSkinned then
						if tile.thumbBorderFrame then
							tile.thumbBorderFrame:Hide()
						end
						if tile.thumbBtn then
							tile.thumbBtn:CreateBackdrop('Transparent')
							if tile.thumbIcon then
								tile.thumbIcon:SetTexCoord(unpack(E.TexCoords))
							end
							if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
								if not tile.thumbBtn.shadow then
									tile.thumbBtn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(tile.thumbBtn.shadow)
								end
							end
							tile.thumbBtn:HookScript('OnClick', function()
								E:Delay(0, function()
									if _G['FollowTheArrow_ImagePopup'] then
										SkinImagePopup(_G['FollowTheArrow_ImagePopup'])
									end
								end)
							end)
						end
						if tile.btn then
							S:HandleButton(tile.btn)
							if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
								if not tile.btn.shadow then
									tile.btn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(tile.btn.shadow)
								end
							end
						end
						tile.IsSkinned = true
					end
				end
			end

			--item buttons
			if row.itemButtons and not InCombatLockdown() then
				for _, itemBtn in pairs(row.itemButtons) do
					if itemBtn and not itemBtn.IsSkinned then
						itemBtn:CreateBackdrop()
						if itemBtn.icon then
							itemBtn.icon:SetTexCoord(unpack(E.TexCoords))
						end
						if itemBtn.cooldown then
							E:RegisterCooldown(itemBtn.cooldown)
						end
						if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
							if not itemBtn.shadow then
								itemBtn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(itemBtn.shadow)
							end
						end
						itemBtn.IsSkinned = true
					end
				end
			end

			--craft button
			if row.craftButton and not row.craftButton.IsSkinned and not InCombatLockdown() then
				row.craftButton:CreateBackdrop()
				if row.craftButton.icon then
					row.craftButton.icon:SetTexCoord(unpack(E.TexCoords))
				end
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not row.craftButton.shadow then
						row.craftButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(row.craftButton.shadow)
					end
				end
				row.craftButton.IsSkinned = true
			end

			--spell button
			if row.spellButton and not row.spellButton.IsSkinned and not InCombatLockdown() then
				row.spellButton:CreateBackdrop()
				if row.spellButton.icon then
					row.spellButton.icon:SetTexCoord(unpack(E.TexCoords))
				end
				if row.spellButton.cooldown then
					E:RegisterCooldown(row.spellButton.cooldown)
				end
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not row.spellButton.shadow then
						row.spellButton:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(row.spellButton.shadow)
					end
				end
				row.spellButton.IsSkinned = true
			end
		end
	end
end

--skin main window
local function SkinFollowTheArrowMainFrame(main)
	if not main or main.IsSkinned then return end

	main:SetTemplate('Transparent')

	--prevent default backdrop from overriding
	hooksecurefunc(main, 'SetBackdrop', function(frame, backdrop)
		if backdrop and backdrop ~= E.media.blankTex and not frame._eltruismBackdropHook then
			frame._eltruismBackdropHook = true
			frame:SetTemplate('Transparent')
			frame._eltruismBackdropHook = nil
		end
	end)

	--shadows
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
		if not main.shadow then
			main:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(main.shadow)
		end
	end

	local scrollFrame, scrollChild
	local nextBtn, syncBtn
	for _, child in pairs({ main:GetChildren() }) do
		if child:IsObjectType('ScrollFrame') then
			scrollFrame = child
			scrollChild = child:GetScrollChild()
		elseif child:IsObjectType('Button') then
			local p1 = select(1, child:GetPoint())
			local text = child:GetText()
			local tex = child:GetNormalTexture() and child:GetNormalTexture():GetTexture()
			local texStr = tex and tostring(tex) or ''

			--close button
			if p1 == 'TOPRIGHT' and (not text or text == '') and child:GetWidth() >= 20 and child:GetWidth() <= 40 then
				S:HandleCloseButton(child)
				child:ClearAllPoints()
				child:SetPoint('TOPRIGHT', main, 'TOPRIGHT', -4, -4)

			--prev button
			elseif text == 'Prev' then
				S:HandleButton(child)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not child.shadow then
						child:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(child.shadow)
					end
				end

			--next button
			elseif text == 'Next' then
				nextBtn = child
				S:HandleButton(child)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not child.shadow then
						child:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(child.shadow)
					end
				end

			--sync / refresh button
			elseif child._icon
				or (child:GetWidth() >= 20 and child:GetWidth() <= 30 and child:GetHeight() >= 20 and child:GetHeight() <= 30 and (not text or text == '') and p1 ~= 'TOPRIGHT' and p1 ~= 'BOTTOMRIGHT')
			then
				syncBtn = child

			--gear / options button
			elseif child:GetWidth() == 16 and child:GetHeight() == 16 and (texStr:find('UI%-OptionsButton') or p1 == 'LEFT' or p1 == 'TOPLEFT') then
				if child:GetNormalTexture() then
					child:GetNormalTexture():SetVertexColor(1, 1, 1, 0.8)
					child:HookScript('OnEnter', function()
						child:GetNormalTexture():SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
					end)
					child:HookScript('OnLeave', function()
						child:GetNormalTexture():SetVertexColor(1, 1, 1, 0.8)
					end)
				end
			end
		elseif child:IsObjectType('Frame') then
			if child.MinimizeButton and child.MaximizeButton then
				if S.HandleMaxMinFrame then
					S:HandleMaxMinFrame(child)
				end
			end
		end
	end

	--fallback sync button search if not found in first pass
	if not syncBtn then
		for _, child in pairs({ main:GetChildren() }) do
			if child:IsObjectType('Button') and (not child:GetText() or child:GetText() == '') and child:GetWidth() >= 20 and child:GetWidth() <= 30 then
				local p1 = select(1, child:GetPoint())
				if p1 ~= 'TOPRIGHT' and p1 ~= 'BOTTOMRIGHT' then
					syncBtn = child
					break
				end
			end
		end
	end

	--skin sync / refresh button
	if syncBtn and not syncBtn.IsSkinned then
		S:HandleButton(syncBtn)
		syncBtn:SetSize(22, 22)
		if nextBtn then
			syncBtn:ClearAllPoints()
			syncBtn:SetPoint('LEFT', nextBtn, 'RIGHT', 6, 0)
		end

		--find or restore icon texture
		local icon = syncBtn._icon
		if not icon then
			for _, r in pairs({ syncBtn:GetRegions() }) do
				if r:IsObjectType('Texture') then
					local t = r:GetTexture()
					local ts = t and tostring(t) or ''
					if ts:find('Refresh') or ts:find('130839') or r:GetDrawLayer() == 'ARTWORK' then
						icon = r
						break
					end
				end
			end
		end

		if icon then
			icon:ClearAllPoints()
			icon:SetPoint('CENTER', syncBtn, 'CENTER', 0, 0)
			icon:SetSize(16, 16)
			icon:SetTexture('Interface\\Buttons\\UI-RefreshButton')
			icon:SetTexCoord(0, 1, 0, 1)
			syncBtn:HookScript('OnEnter', function()
				icon:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
			end)
			syncBtn:HookScript('OnLeave', function()
				icon:SetVertexColor(1, 1, 1, 1)
			end)
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			if not syncBtn.shadow then
				syncBtn:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(syncBtn.shadow)
			end
		end

		syncBtn.IsSkinned = true
	end

	--scroll bar
	if scrollFrame and scrollFrame.ScrollBar then
		S:HandleScrollBar(scrollFrame.ScrollBar)
		if scrollFrame.ScrollBar.thumbTexture then
			scrollFrame.ScrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
			scrollFrame.ScrollBar.thumbTexture:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
		end
	end

	--route dropdown
	local routeDD = _G['FollowTheArrowRouteDropdown']
	if routeDD then
		S:HandleDropDownBox(routeDD)
		if routeDD.backdrop and E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			if not routeDD.backdrop.shadow then
				routeDD.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(routeDD.backdrop.shadow)
			end
		end

		local ddText = _G['FollowTheArrowRouteDropdownText']
		if ddText and routeDD.backdrop then
			local function FixDropdownText()
				if ddText._eltruismFixing then return end
				ddText._eltruismFixing = true
				ddText:ClearAllPoints()
				ddText:SetPoint('LEFT', routeDD.backdrop, 'LEFT', 6, 0)
				ddText:SetPoint('RIGHT', routeDD.backdrop, 'RIGHT', -22, 0)
				ddText:SetJustifyH('LEFT')
				ddText:SetWidth(0)
				if E.LSM:Fetch('font', E.db.general.font) then
					ddText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				end
				ddText._eltruismFixing = nil
			end

			--hook SetPoint to prevent EnsureDropdownLeftJustify / UIDropDownMenu_JustifyText from misaligning
			hooksecurefunc(ddText, 'SetPoint', function(_, _, relTo)
				if ddText._eltruismFixing then return end
				if relTo ~= routeDD.backdrop then
					FixDropdownText()
				end
			end)

			--hook SetWidth to prevent UIDropDownMenu_SetWidth from constraining text
			hooksecurefunc(ddText, 'SetWidth', function(_, width)
				if ddText._eltruismFixing then return end
				if width and width > 0 then
					FixDropdownText()
				end
			end)

			--hook UIDropDownMenu_SetText to ensure font & alignment persist on guide change
			hooksecurefunc('UIDropDownMenu_SetText', function(frame)
				if frame == routeDD and ddText then
					FixDropdownText()
				end
			end)

			--hook UIDropDownMenu_SetWidth to ensure text is never constrained
			hooksecurefunc('UIDropDownMenu_SetWidth', function(frame)
				if frame == routeDD and ddText then
					FixDropdownText()
				end
			end)

			FixDropdownText()
		end
	end

	--fonts & underline
	for _, region in pairs({ main:GetRegions() }) do
		if region:IsObjectType('FontString') then
			if E.LSM:Fetch('font', E.db.general.font) then
				if region:GetText() == 'Follow The Arrow' then
					region:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 3, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				else
					region:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				end
			end
		elseif region:IsObjectType('Texture') and region:GetHeight() == 2 then
			region:SetColorTexture(valuecolors.r, valuecolors.g, valuecolors.b, 0.6)
		end
	end

	--hook scrollChild SetHeight to skin dynamically created/refreshed rows
	if scrollChild and not scrollChild._eltruismHooked then
		hooksecurefunc(scrollChild, 'SetHeight', function(self)
			SkinRows(self)
		end)
		scrollChild._eltruismHooked = true
		SkinRows(scrollChild)
	end

	main:HookScript('OnShow', function()
		if scrollChild then
			SkinRows(scrollChild)
		end
	end)

	main.IsSkinned = true
end

--skin settings panel
local function SkinSettingsPanel()
	local scroll1 = _G['FTASettingsScrollFrame1']
	if not scroll1 then return end

	local content = scroll1:GetParent()
	if not content or content.IsSkinned then return end

	local panel = content:GetParent()
	if not panel then return end

	content:SetTemplate('Transparent')
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
		if not content.shadow then
			content:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(content.shadow)
		end
	end

	for _, child in pairs({ panel:GetChildren() }) do
		if child ~= content and child:IsObjectType('Frame') then
			child:SetTemplate('Transparent')
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
				if not child.shadow then
					child:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(child.shadow)
				end
			end
			for _, navChild in pairs({ child:GetChildren() }) do
				if navChild:IsObjectType('Button') then
					S:HandleButton(navChild)
				end
			end
		end
	end

	for i = 1, 3 do
		local scroll = _G['FTASettingsScrollFrame' .. i]
		if scroll then
			local scrollBar = _G['FTASettingsScrollFrame' .. i .. 'ScrollBar']
			if scrollBar then
				S:HandleScrollBar(scrollBar)
				if scrollBar.thumbTexture then
					scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					scrollBar.thumbTexture:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
				end
			end

			local scrollChild = scroll:GetScrollChild()
			if scrollChild then
				for _, element in pairs({ scrollChild:GetChildren() }) do
					if element:IsObjectType('CheckButton') then
						S:HandleCheckBox(element)
					elseif element:IsObjectType('Slider') then
						S:HandleSliderFrame(element)
					elseif element:IsObjectType('Button') then
						S:HandleButton(element)
						if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
							if not element.shadow then
								element:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(element.shadow)
							end
						end
					elseif element:IsObjectType('Frame') then
						for _, subChild in pairs({ element:GetChildren() }) do
							if subChild:IsObjectType('Button') then
								S:HandleButton(subChild)
								if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
									if not subChild.shadow then
										subChild:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(subChild.shadow)
									end
								end
							end
						end
					end
				end
			end
		end
	end

	content.IsSkinned = true
end

--skin guide arrow
local function SkinGuideArrow(guideArrow)
	if not guideArrow or guideArrow.IsSkinned then return end
	if E.LSM:Fetch('font', E.db.general.font) then
		for _, region in pairs({ guideArrow:GetRegions() }) do
			if region:IsObjectType('FontString') then
				region:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
		end
	end
	guideArrow.IsSkinned = true
end

--skin FollowTheArrow
function ElvUI_EltreumUI:EltruismFollowTheArrow()
	if E.db.ElvUI_EltreumUI.skins.followthearrow then
		--delay to ensure frames exist
		E:Delay(0, function()
			if _G['FollowTheArrowMainFrame'] then
				SkinFollowTheArrowMainFrame(_G['FollowTheArrowMainFrame'])
			end
			if _G['FTA_GuideArrow'] then
				SkinGuideArrow(_G['FTA_GuideArrow'])
			end
			if _G['FollowTheArrow_ImagePopup'] then
				SkinImagePopup(_G['FollowTheArrow_ImagePopup'])
			end
			SkinSettingsPanel()
		end)

		--hook minimap button to skin main frame if opened later
		if _G['FollowTheArrowMinimapButton'] then
			_G['FollowTheArrowMinimapButton']:HookScript('OnClick', function()
				if _G['FollowTheArrowMainFrame'] then
					SkinFollowTheArrowMainFrame(_G['FollowTheArrowMainFrame'])
				end
			end)
		end
	end
end
S:AddCallbackForAddon('FollowTheArrow', "EltruismFollowTheArrow", ElvUI_EltreumUI.EltruismFollowTheArrow)
