local E = unpack(ElvUI)
local _G = _G
local S = E:GetModule('Skins')
local CreateFrame = _G.CreateFrame

--based on Improved Stable Frame by Cybeloras
function ElvUI_EltreumUI:ExpandedStable()
	if E.db.ElvUI_EltreumUI.skins.expandedstable and not self.StableSkinned then
		self.StableSkinned = true

		local maxSlots = NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS
		local NUM_PER_ROW = 10

		for i = NUM_PET_STABLE_SLOTS + 1, maxSlots do
			if not _G["PetStableStabledPet"..i] then
				CreateFrame("Button", "PetStableStabledPet"..i, _G["PetStableFrame"], "PetStableSlotTemplate", i)
				S:HandleItemButton(_G["PetStableStabledPet"..i], true)
			end
		end

		for i = 1, maxSlots do
			local frame = _G["PetStableStabledPet"..i]
			if i > 1 then
				frame:ClearAllPoints()
				frame:SetPoint("LEFT", _G["PetStableStabledPet"..i-1], "RIGHT", 7.3, 0)
			end
			frame:SetFrameLevel(_G["PetStableFrame"]:GetFrameLevel() + 1)
			frame:SetScale(7/NUM_PER_ROW)
			frame.dimOverlay = frame:CreateTexture(nil, "OVERLAY")
			frame.dimOverlay:SetColorTexture(0, 0, 0, 0.8)
			frame.dimOverlay:SetAllPoints()
			frame.dimOverlay:Hide()
		end

		for i = NUM_PER_ROW+1, maxSlots, NUM_PER_ROW do
			_G["PetStableStabledPet"..i]:ClearAllPoints()
			_G["PetStableStabledPet"..i]:SetPoint("TOPLEFT", _G["PetStableStabledPet"..i-NUM_PER_ROW], "BOTTOMLEFT", 0, -5)
		end

		_G["PetStableNextPageButton"]:Hide()
		_G["PetStablePrevPageButton"]:Hide()

		local function ExpandedStable_Update()
			local input = _G["EltruismES_SearchInput"]:GetText()
			--local input = searchInput:GetText()
			if not input or input:trim() == "" then
				for i = 1, maxSlots do
					local button = _G["PetStableStabledPet"..i]
					button.dimOverlay:Hide()
				end
				return
			end

			for i = 1, maxSlots do
				local icon, name, _, family, talent = GetStablePetInfo(NUM_PET_ACTIVE_SLOTS + i)
				--local icon, name, level, family, talent = GetStablePetInfo(NUM_PET_ACTIVE_SLOTS + i)
				local button = _G["PetStableStabledPet"..i]

				button.dimOverlay:Show()
				if icon then
					local matched, expected = 0, 0
					for str in input:gmatch("([^%s]+)") do
						expected = expected + 1
						str = str:trim():lower()

						if name:lower():find(str) or family:lower():find(str) or talent:lower():find(str) then
							matched = matched + 1
						end
					end
					if matched == expected then
						button.dimOverlay:Hide()
					end
				end
			end
		end

		local widthDelta = 315
		local heightDelta = 204
		local EltruismExpandedStableFrame = CreateFrame("Frame", "EltruismExpandedStable", _G["PetStableFrame"], "InsetFrameTemplate")
		EltruismExpandedStableFrame:ClearAllPoints()
		EltruismExpandedStableFrame:SetSize(widthDelta, _G["PetStableFrame"]:GetHeight() + heightDelta - 28)
		EltruismExpandedStableFrame:SetPoint(_G["PetStableFrame"].Inset:GetPoint(1))
		_G["PetStableFrame"].Inset:SetPoint("TOPLEFT", EltruismExpandedStableFrame, "TOPRIGHT")
		_G["PetStableFrame"]:SetWidth(_G["PetStableFrame"]:GetWidth() + widthDelta)
		_G["PetStableFrame"]:SetHeight(_G["PetStableFrame"]:GetHeight() + heightDelta)

		--_G["PetStableFrameModelBg"]:SetHeight(281 + heightDelta)
		--local p, r, rp, x, y = _G["PetStableModel"]:GetPoint(1)
		--_G["PetStableModel"]:SetPoint(p, r, rp, x, y - 32)

		_G["PetStableStabledPet1"]:ClearAllPoints()
		_G["PetStableStabledPet1"]:SetPoint("TOPLEFT", EltruismExpandedStableFrame, 8, -36)

		--nineslice
		if EltruismExpandedStableFrame.NineSlice then
			EltruismExpandedStableFrame.NineSlice:Hide()
		end

		--fix diet icon
		local texture = _G.PetStableDiet:GetRegions()
		texture:SetTexture(134372)
		texture:SetTexCoord(0.08,0.92,0.08,0.92)

		--[[S:HandleRotateButton(_G.PetStableModelRotateRightButton)
		_G.PetStableModelRotateRightButton:SetNormalTexture(E.Media.Textures.ArrowUp)
		_G.PetStableModelRotateRightButton:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
		_G.PetStableModelRotateRightButton:GetNormalTexture():SetRotation(-1.57)
		_G.PetStableModelRotateRightButton:SetPushedTexture(E.Media.Textures.ArrowUp)
		_G.PetStableModelRotateRightButton:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
		_G.PetStableModelRotateRightButton:GetPushedTexture():SetRotation(-1.57)

		S:HandleRotateButton(_G.PetStableModelRotateLeftButton)
		_G.PetStableModelRotateLeftButton:SetNormalTexture(E.Media.Textures.ArrowUp)
		_G.PetStableModelRotateLeftButton:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
		_G.PetStableModelRotateLeftButton:GetNormalTexture():SetRotation(1.57)
		_G.PetStableModelRotateLeftButton:SetPushedTexture(E.Media.Textures.ArrowUp)
		_G.PetStableModelRotateLeftButton:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
		_G.PetStableModelRotateLeftButton:GetPushedTexture():SetRotation(1.57)]]

		local searchInput = CreateFrame("EditBox", "EltruismES_SearchInput", EltruismExpandedStableFrame, "SearchBoxTemplate")
		S:HandleFrame(searchInput)
		searchInput:SetPoint("TOPLEFT", 9, 0)
		searchInput:SetPoint("RIGHT", -3, 0)
		searchInput:SetHeight(20)
		searchInput:HookScript("OnTextChanged", ExpandedStable_Update)
		searchInput.Instructions:SetText(SEARCH .. " (" .. NAME .. ", " .. PET_FAMILIES .. ", " .. PET_TALENTS .. ")")
		hooksecurefunc("PetStable_Update", ExpandedStable_Update)
		NUM_PET_STABLE_SLOTS = maxSlots
		NUM_PET_STABLE_PAGES = 1
		_G["PetStableFrame"].page = 1
	end
end
