local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

--frame scaling
function ElvUI_EltreumUI:FrameScales()
	--flight master scale
	if _G["TaxiFrame"] then
		_G["TaxiFrame"]:HookScript("OnShow", function()
			_G["TaxiFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.taxiscale)
		end)
	end
	if _G["FlightMapFrame"] then
		_G["FlightMapFrame"]:HookScript("OnShow", function()
			_G["FlightMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.taxiscale)
		end)
	end

	--bag scale
	if _G["ElvUI_ContainerFrame"] then
		_G["ElvUI_ContainerFrame"]:HookScript("OnShow", function()
			_G["ElvUI_ContainerFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.bagscale)
		end)
	end

	--bank scale
	if _G["ElvUI_BankContainerFrame"] then
		_G["ElvUI_BankContainerFrame"]:HookScript("OnShow", function()
			_G["ElvUI_BankContainerFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.bankscale)
		end)
	end

	if _G["ElvLootFrame"] then
		_G["ElvLootFrame"]:HookScript("OnShow", function()
			_G["ElvLootFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.lootscale)
		end)
	end
end

--frame that checks for taxi/flightmaster
local taxiloadmonitor = CreateFrame("FRAME")
taxiloadmonitor:RegisterEvent("PLAYER_ENTERING_WORLD")
taxiloadmonitor:RegisterEvent("ADDON_LOADED")
taxiloadmonitor:SetScript("OnEvent", function(_,_,arg)
	if IsAddOnLoaded("Blizzard_FlightMap") or (arg == "Blizzard_FlightMap") or _G["FlightMapFrame"] then
		taxiloadmonitor:UnregisterAllEvents()
		if not E.private.ElvUI_EltreumUI then return end
		if not E.db.ElvUI_EltreumUI then return end
		if not E.db.ElvUI_EltreumUI.otherstuff then return end
		if not E.db.ElvUI_EltreumUI.otherstuff.taxiscale then return end
		if _G["FlightMapFrame"] then
			_G["FlightMapFrame"]:HookScript("OnShow", function()
				_G["FlightMapFrame"]:SetScale(E.db.ElvUI_EltreumUI.otherstuff.taxiscale)
			end)
		end
	end
end)
