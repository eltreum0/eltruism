local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--based on Improved Stable Frame by Cybeloras
function ElvUI_EltreumUI:ExpandedStable()
	if E.myclass == 'HUNTER' then
		if E.db.ElvUI_EltreumUI.skins.expandedstable then
			local NUM_PET_STABLE_PAGES = NUM_PET_STABLE_PAGES
			local NUM_PET_STABLE_SLOTS = NUM_PET_STABLE_SLOTS
			local maxSlots = NUM_PET_STABLE_PAGES * NUM_PET_STABLE_SLOTS
			local NUM_PER_ROW = 10

			for i = NUM_PET_STABLE_SLOTS + 1, maxSlots do
				if not _G["PetStableStabledPet"..i] then
					CreateFrame("Button", "PetStableStabledPet"..i, PetStableFrame, "PetStableSlotTemplate", i)
				end
			end

			for i = 1, maxSlots do
				local frame = _G["PetStableStabledPet"..i]
				if i > 1 then
					frame:ClearAllPoints()
					frame:SetPoint("LEFT", _G["PetStableStabledPet"..i-1], "RIGHT", 7.3, 0)
				end
				frame:SetFrameLevel(PetStableFrame:GetFrameLevel() + 1)
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

			PetStableNextPageButton:Hide()
			PetStablePrevPageButton:Hide()
			local widthDelta = 315
			local heightDelta = 204
			local EltruismExpandedStableFrame = CreateFrame("Frame", "EltruismExpandedStable", PetStableFrame, "InsetFrameTemplate")
			EltruismExpandedStableFrame:ClearAllPoints()
			EltruismExpandedStableFrame:SetSize(widthDelta, PetStableFrame:GetHeight() + heightDelta - 28)
			EltruismExpandedStableFrame:SetPoint(PetStableFrame.Inset:GetPoint(1))
			PetStableFrame.Inset:SetPoint("TOPLEFT", EltruismExpandedStableFrame, "TOPRIGHT")
			PetStableFrame:SetWidth(PetStableFrame:GetWidth() + widthDelta)
			PetStableFrame:SetHeight(PetStableFrame:GetHeight() + heightDelta)
			PetStableFrameModelBg:SetHeight(281 + heightDelta)

			local p, r, rp, x, y = PetStableModel:GetPoint(1)
			PetStableModel:SetPoint(p, r, rp, x, y - 32)
			PetStableStabledPet1:ClearAllPoints()
			PetStableStabledPet1:SetPoint("TOPLEFT", EltruismExpandedStableFrame, 8, -36)

			local searchInput = CreateFrame("EditBox", "EltruismES_SearchInput", EltruismExpandedStableFrame, "SearchBoxTemplate")
			searchInput:SetPoint("TOPLEFT", 9, 0)
			searchInput:SetPoint("RIGHT", -3, 0)
			searchInput:SetHeight(20)

			local function ExpandedStable_Update()
				--local input = ES_SearchInput:GetText()
				local input = searchInput:GetText()
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

							if name:lower():find(str)
							or family:lower():find(str)
							or talent:lower():find(str)
							then
								matched = matched + 1
							end
						end
						if matched == expected then
							button.dimOverlay:Hide()
						end
					end
				end
			end
			searchInput:HookScript("OnTextChanged", ExpandedStable_Update)
			searchInput.Instructions:SetText(SEARCH .. " (" .. NAME .. ", " .. PET_FAMILIES .. ", " .. PET_TALENTS .. ")")
			hooksecurefunc("PetStable_Update", ExpandedStable_Update)
			NUM_PET_STABLE_SLOTS = maxSlots
			NUM_PET_STABLE_PAGES = 1
			PetStableFrame.page = 1
		end
	end
end
