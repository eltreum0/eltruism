local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local GetContainerItemID = _G.C_Container and _G.C_Container.GetContainerItemID or _G.GetContainerItemID
local B = E:GetModule('Bags')
local S = E:GetModule('Skins')

--based on Scrap_ElvUI by RainForDays, which was removed and not updated, and is also no longer available
function ElvUI_EltreumUI:ScrapFix()
	if IsAddOnLoaded("Scrap_ElvUI") then return end

	local Scrap = _G.Scrap

	local function NewIcon(button)
		button.ScrapAddonIcon = button:CreateTexture(button:GetName().."ScrapAddonIcon", 'OVERLAY', nil, 3)
		button.ScrapAddonIcon:SetTexture('Interface/Buttons/UI-GroupLoot-Coin-Up')
		button.ScrapAddonIcon:SetPoint('TOPLEFT', 2, -2)
		button.ScrapAddonIcon:SetSize(15, 15)

		return button.ScrapAddonIcon
	end

	local function UpdateContainerElvUI(bag)
		local frame = E.Retail and _G['ElvUI_ContainerFrameBag' .. bag] or _G['ElvUI_ContainerFrameBag' .. bag - 1]
		if not frame then return end
		local name = frame:GetName()
		local size = frame.numSlots

		if not size then return end

		for i = 1, size do
			local slot = i
			local button = _G[name .. 'Slot' .. slot]
			local id = GetContainerItemID(bag, i)

			local isJunk = id and Scrap:IsJunk(id, bag, slot)
			local icon = button.ScrapAddonIcon or NewIcon(button)
			icon:SetShown(isJunk and Scrap.sets.icons)
		end
	end

	-- Update bags
	local function UpdateAll()
		for i = 0, NUM_BAG_SLOTS do
			UpdateContainerElvUI(i)
		end
	end

	local function UpdateSlot(_, frame, bagID, slotID)
		if not frame then return end
		if not frame.Bags then return end
		if not frame.Bags[bagID] or not frame.Bags[bagID][slotID] then return end

		local button = frame.Bags[bagID][slotID]
		local id = C_Container.GetContainerItemID(bagID, slotID)

		local isJunk = id and Scrap:IsJunk(id, bagID, slotID)
		local icon = button.ScrapAddonIcon or NewIcon(button)

		button.ScrapAddonIcon:SetShown(isJunk and icon)
	end

	-- Hooks
	hooksecurefunc(Scrap, 'ToggleJunk', UpdateAll)
	hooksecurefunc(B, "UpdateSlot", UpdateSlot)

	UpdateAll()
end
S:AddCallbackForAddon('Scrap', "EltruismScrapFix", ElvUI_EltreumUI.ScrapFix)
