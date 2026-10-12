local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc
local math = _G.math
local string = _G.string
local tostring = _G.tostring
local classColor = E:ClassColor(E.myclass)

local function SkinDropdownArrow(dropdown, arrow)
	if not arrow then return end
	local db = E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor
	arrow:SetTexture(E.Media.Textures.ArrowUp)
	arrow:SetRotation(S.ArrowRotation.down)
	arrow:SetSize(12, 12)
	arrow:ClearAllPoints()
	arrow:SetPoint('RIGHT', dropdown, 'RIGHT', -6, 0)
	if not db.classcolor then
		arrow:SetVertexColor(db.r, db.g, db.b, db.a)
	else
		arrow:SetVertexColor(classColor.r, classColor.g, classColor.b, 0.8)
	end
end

local function SkinOptions(parent)
	if not parent or parent.IsSkinned then return end
	local db = E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor
	local dbShadow = E.db.ElvUI_EltreumUI.skins.shadow
	local dbBorders = E.db.ElvUI_EltreumUI.borders

	for _, child in pairs({ parent:GetChildren() }) do
		if child:IsObjectType('CheckButton') then
			S:HandleCheckBox(child)
		elseif child:IsObjectType('Frame') then
			local dropdown, previewBtn
			for _, subChild in pairs({ child:GetChildren() }) do
				if (subChild.intrinsic == 'DropdownButton') or (subChild.SetupMenu ~= nil) or (subChild.Arrow ~= nil) then
					dropdown = subChild
				elseif subChild:IsObjectType('Button') then
					previewBtn = subChild
				end
			end

			if dropdown then
				if S.HandleDropdownButton then
					S:HandleDropdownButton(dropdown)
				elseif S.HandleDropDownButton then
					S:HandleDropDownButton(dropdown)
				end
				if dropdown.Background then
					dropdown.Background:SetAlpha(0)
					dropdown.Background:Hide()
					if dropdown.Background.Show then
						hooksecurefunc(dropdown.Background, 'Show', dropdown.Background.Hide)
					end
				end

				dropdown:SetTemplate('Transparent')

				if dropdown.Arrow and not dropdown.Arrow.IsSkinned then
					SkinDropdownArrow(dropdown, dropdown.Arrow)
					hooksecurefunc(dropdown.Arrow, 'SetAtlas', function(arrowSelf)
						SkinDropdownArrow(dropdown, arrowSelf)
					end)
					if dropdown.OnButtonStateChanged then
						hooksecurefunc(dropdown, 'OnButtonStateChanged', function(btnSelf)
							if btnSelf.Arrow then
								SkinDropdownArrow(btnSelf, btnSelf.Arrow)
							end
						end)
					end
					dropdown.Arrow.IsSkinned = true
				end

				dropdown:HookScript('OnEnter', function()
					if dropdown.Arrow then
						local r, g, b
						if not db.classcolor then
							r = db.r
							g = db.g
							b = db.b
						else
							r = classColor.r
							g = classColor.g
							b = classColor.b
						end
						dropdown.Arrow:SetVertexColor(r, g, b, 1)
					end
				end)
				dropdown:HookScript('OnLeave', function()
					if dropdown.Arrow then
						if not db.classcolor then
							dropdown.Arrow:SetVertexColor(db.r, db.g, db.b, db.a)
						else
							dropdown.Arrow:SetVertexColor(classColor.r, classColor.g, classColor.b, 0.8)
						end
					end
				end)

				if dbShadow.enable and not dbBorders.universalborders then
					if dropdown.backdrop and not dropdown.backdrop.shadow then
						dropdown.backdrop:CreateShadow(dbShadow.length)
						ElvUI_EltreumUI:ShadowColor(dropdown.backdrop.shadow)
					elseif not dropdown.shadow then
						dropdown:CreateShadow(dbShadow.length)
						ElvUI_EltreumUI:ShadowColor(dropdown.shadow)
					end
				end
			end

			if previewBtn then
				S:HandleButton(previewBtn, nil, nil, nil, true, 'Transparent')
				if dropdown then
					previewBtn:ClearAllPoints()
					previewBtn:SetPoint('RIGHT', dropdown, 'LEFT', -6, 0)
				end
				for _, region in pairs({ previewBtn:GetRegions() }) do
					if region:IsObjectType('Texture') and region ~= previewBtn.backdrop and region ~= previewBtn:GetNormalTexture() and region ~= previewBtn:GetPushedTexture() and region ~= previewBtn:GetDisabledTexture() and region ~= previewBtn:GetHighlightTexture() then
						region:ClearAllPoints()
						region:SetPoint('CENTER', previewBtn, 'CENTER', 1, 0)
						region:SetSize(14, 14)
					end
				end
				if dbShadow.enable and not dbBorders.universalborders then
					if previewBtn.backdrop and not previewBtn.backdrop.shadow then
						previewBtn.backdrop:CreateShadow(dbShadow.length)
						ElvUI_EltreumUI:ShadowColor(previewBtn.backdrop.shadow)
					end
				end
			end
		end
	end
	parent.IsSkinned = true
end

local function SkinBugSack()
	if not _G["BugSackFrame"] or _G["BugSackFrame"].IsSkinned then return end
	local dbShadow = E.db.ElvUI_EltreumUI.skins.shadow
	local dbBorders = E.db.ElvUI_EltreumUI.borders

	S:HandleFrame(_G["BugSackFrame"])

	if _G["BugSackFrameScrollBar"] then
		S:HandleScrollBar(_G["BugSackFrameScrollBar"])
	elseif _G["BugSackScrollText"] then
		local ScrollBar =  _G["BugSackScrollText"]:GetParent().ScrollBar
		if E.Modern then
			S:HandleTrimScrollBar(ScrollBar)
		else
			S:HandleScrollBar(ScrollBar)
		end
	end

	--S:HandleButton(button, strip, isDecline, noStyle, createBackdrop, template, noGlossTex, overrideTex, frameLevel, regionsKill, regionsZero, isFilterButton, filterDirection)
	S:HandleButton(_G["BugSackNextButton"], nil, nil, nil, true,'Transparent')
	_G["BugSackNextButton"]:SetHeight(20) --default is 40
	_G["BugSackNextButton"]:ClearAllPoints()
	_G["BugSackNextButton"]:Point('BOTTOMRIGHT', _G["BugSackFrame"], 'BOTTOMRIGHT', -12, 6)

	S:HandleButton(_G["BugSackPrevButton"], nil, nil, nil, true,'Transparent')
	_G["BugSackPrevButton"]:SetHeight(20) --default is 40
	_G["BugSackPrevButton"]:ClearAllPoints()
	_G["BugSackPrevButton"]:Point('BOTTOMLEFT', _G["BugSackFrame"], 'BOTTOMLEFT', 12, 6)

	if _G["BugSackSendButton"] then
		S:HandleButton(_G["BugSackSendButton"], nil, nil, nil, true,'Transparent')
		_G["BugSackSendButton"]:SetHeight(20) --default is 40
	end
	if _G["BugSackWipeButton"] then
		S:HandleButton(_G["BugSackWipeButton"], nil, nil, nil, true,'Transparent')
		_G["BugSackWipeButton"]:SetHeight(20) --default is 40
	end

	if E.Modern then
		local modernTabs = {
			_G["BugSackTabLast"],
			_G["BugSackTabSession"],
			_G["BugSackTabAll"],
			_G["BugSackTabOptions"],
		}
		local maxTextWidth = 0
		for _, tab in pairs(modernTabs) do
			if tab then
				local text = tab.Text or (tab.GetFontString and tab:GetFontString())
				if text and text.GetStringWidth then
					maxTextWidth = math.max(maxTextWidth, text:GetStringWidth())
				end
			end
		end
		local tabWidth = math.max(136, maxTextWidth + 30)
		local gap = 12

		if _G["BugSackTabOptions"] then
			for _, tab in pairs(modernTabs) do
				if tab then
					S:HandleTab(tab)
					tab:SetWidth(tabWidth)
					tab:ClearAllPoints()
					if not tab.EltruismWidthHooked then
						tab:HookScript('OnShow', function(self)
							self:SetWidth(tabWidth)
						end)
						tab.EltruismWidthHooked = true
					end
				end
			end
			_G["BugSackTabSession"]:Point('RIGHT', _G["BugSackFrame"], 'BOTTOM', -(gap / 2), -16)
			_G["BugSackTabLast"]:Point('RIGHT', _G["BugSackTabSession"], 'LEFT', -gap, 0)
			_G["BugSackTabAll"]:Point('LEFT', _G["BugSackFrame"], 'BOTTOM', (gap / 2), -16)
			_G["BugSackTabOptions"]:Point('LEFT', _G["BugSackTabAll"], 'RIGHT', gap, 0)
		else
			local threeTabs = {
				_G["BugSackTabLast"],
				_G["BugSackTabSession"],
				_G["BugSackTabAll"],
			}
			for _, tab in pairs(threeTabs) do
				if tab then
					S:HandleTab(tab)
					tab:SetWidth(tabWidth)
					tab:ClearAllPoints()
					if not tab.EltruismWidthHooked then
						tab:HookScript('OnShow', function(self)
							self:SetWidth(tabWidth)
						end)
						tab.EltruismWidthHooked = true
					end
				end
			end
			_G["BugSackTabSession"]:Point('CENTER', _G["BugSackFrame"], 'BOTTOM', 0, -16)
			_G["BugSackTabLast"]:Point('RIGHT', _G["BugSackTabSession"], 'LEFT', -gap, 0)
			_G["BugSackTabAll"]:Point('LEFT', _G["BugSackTabSession"], 'RIGHT', gap, 0)
		end
	else
		if _G["BugSackTabOptions"] then
			S:HandleTab(_G["BugSackTabSession"])
			_G["BugSackTabSession"]:ClearAllPoints()
			_G["BugSackTabSession"]:Point('RIGHT', _G["BugSackFrame"], 'BOTTOM', 2, -16)
			S:HandleTab(_G["BugSackTabAll"])
			_G["BugSackTabAll"]:ClearAllPoints()
			_G["BugSackTabAll"]:Point('LEFT', _G["BugSackTabSession"], 'RIGHT', -5, 0)
			S:HandleTab(_G["BugSackTabLast"])
			_G["BugSackTabLast"]:ClearAllPoints()
			_G["BugSackTabLast"]:Point('RIGHT', _G["BugSackTabSession"], 'LEFT', 5, 0)
			S:HandleTab(_G["BugSackTabOptions"])
			_G["BugSackTabOptions"]:ClearAllPoints()
			_G["BugSackTabOptions"]:Point('LEFT', _G["BugSackTabAll"], 'RIGHT', -5, 0)
		else
			S:HandleTab(_G["BugSackTabSession"])
			_G["BugSackTabSession"]:ClearAllPoints()
			_G["BugSackTabSession"]:Point('CENTER', _G["BugSackFrame"], 'BOTTOM', 0, -16)
			S:HandleTab(_G["BugSackTabAll"])
			_G["BugSackTabAll"]:ClearAllPoints()
			_G["BugSackTabAll"]:Point('LEFT', _G["BugSackTabSession"], 'RIGHT', -5, 0)
			S:HandleTab(_G["BugSackTabLast"])
			_G["BugSackTabLast"]:ClearAllPoints()
			_G["BugSackTabLast"]:Point('RIGHT', _G["BugSackTabSession"], 'LEFT', 5, 0)
		end
	end

	if dbShadow.enable and not dbBorders.universalborders then
		local frames = {
			_G["BugSackFrame"],
			_G["BugSackTabAll"] and _G["BugSackTabAll"].backdrop,
			_G["BugSackTabSession"] and _G["BugSackTabSession"].backdrop,
			_G["BugSackTabLast"] and _G["BugSackTabLast"].backdrop,
			_G["BugSackTabOptions"] and _G["BugSackTabOptions"].backdrop,
		}
		for _, frame in pairs(frames) do
			if frame and not frame.shadow then
				frame:CreateShadow(dbShadow.length)
				ElvUI_EltreumUI:ShadowColor(frame.shadow)
			end
		end
	end

	--from addonskins
	local closeButton = _G["BugSackFrame"].CloseButton
	if closeButton then
		S:HandleCloseButton(closeButton)
	else
		for _, v in pairs({ _G["BugSackFrame"]:GetChildren() }) do
			if v:IsObjectType('Button') then
				local isClose = false
				if _G.BugSack and _G.BugSack.CloseSack and v:GetScript('OnClick') == _G.BugSack.CloseSack then
					isClose = true
				elseif v:GetPoint() == 'TOPRIGHT' and not v:GetName() then
					isClose = true
				end
				if not isClose then
					local norm = v:GetNormalTexture()
					local atlas = norm and norm.GetAtlas and norm:GetAtlas()
					local tex = norm and norm.GetTexture and norm:GetTexture()
					if (atlas and string.find(atlas, 'RedButton')) or (tex and string.find(tostring(tex), 'Close')) then
						isClose = true
					end
				end
				if isClose then
					S:HandleCloseButton(v)
					v:ClearAllPoints()
					v:SetPoint('TOPRIGHT', _G["BugSackFrame"], 'TOPRIGHT', -3, -3)
					closeButton = v
					_G["BugSackFrame"].CloseButton = v
					break
				end
			end
		end
	end

	--ty luckyone for the idea, modified with ElvUI functions and Eltruism version listing
	-- Game version left of page count (top right)
	--needs more checks now after this options menu
	local countLabel
	local labelParent = _G["BugSackFrame"].TitleContainer or _G["BugSackFrame"]
	for _, region in pairs({ labelParent:GetRegions() }) do
		if region and region:IsObjectType('FontString') and region:GetJustifyH() == 'RIGHT' then
			countLabel = region
			break
		end
	end
	if not countLabel and labelParent ~= _G["BugSackFrame"] then
		for _, region in pairs({ _G["BugSackFrame"]:GetRegions() }) do
			if region and region:IsObjectType('FontString') and region:GetJustifyH() == 'RIGHT' then
				countLabel = region
				labelParent = _G["BugSackFrame"]
				break
			end
		end
	end
	if not countLabel then
		for _, region in pairs({ labelParent:GetRegions() }) do
			if region and region:IsObjectType('FontString') then
				countLabel = region
				break
			end
		end
	end

	if countLabel then
		if closeButton then
			countLabel:ClearAllPoints()
			countLabel:SetPoint('RIGHT', closeButton, 'LEFT', -6, 0)
		end
		local _, elvVersion = E:ParseVersionString('ElvUI')
		local hex = E:RGBToHex(classColor.r, classColor.g, classColor.b, '|cff')
		local versionLabel = labelParent:CreateFontString(nil, 'ARTWORK')
		versionLabel:SetFontObject(countLabel:GetFontObject())
		versionLabel:SetTextColor(countLabel:GetTextColor())
		versionLabel:SetText(_G.format('%sElvUI:|r %s %sEltruism:|r %s %sPatch:|r %s %sPage:|r', hex, elvVersion, hex, ElvUI_EltreumUI.Version, hex, _G.GetBuildInfo(), hex))
		versionLabel:ClearAllPoints()
		versionLabel:SetPoint('RIGHT', countLabel, 'LEFT', -6, 0)
	end

	--filter searchbox
	local searchParent = _G["BugSackFrame"].TitleContainer or _G["BugSackFrame"]
	for _, child in pairs({ searchParent:GetChildren() }) do
		if child:IsObjectType('EditBox') and child ~= _G["BugSackScrollText"] then
			S:HandleEditBox(child)
			break
		end
	end

	--skin options tab
	for _, child in pairs({ _G["BugSackFrame"]:GetChildren() }) do
		if child:IsObjectType('Frame') and not child:GetName() and child ~= _G["BugSackFrame"].TitleContainer and not child:IsObjectType('ScrollFrame') then
			SkinOptions(child)
		end
	end

	_G["BugSackFrame"].IsSkinned = true
end

--skin bugsack
function ElvUI_EltreumUI:EltruismBugSack()
	if E.db.ElvUI_EltreumUI.skins.bugsack then

		--frame doesnt get created at start, but with a function, hook to skin
		hooksecurefunc(_G.BugSack, "OpenSack", SkinBugSack)

		if _G.BugSack.OpenConfig then
			hooksecurefunc(_G.BugSack, "OpenConfig", SkinBugSack)
		end

		if _G.BugSack.CreateOptionsTab then
			hooksecurefunc(_G.BugSack, "CreateOptionsTab", function(_, parent)
				SkinOptions(parent)
			end)
		end
	end
end
S:AddCallbackForAddon('BugSack', "EltruismBugSack", ElvUI_EltreumUI.EltruismBugSack)
