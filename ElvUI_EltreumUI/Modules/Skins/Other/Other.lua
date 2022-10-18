local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
local GetSpellInfo = _G.GetSpellInfo
local GetItemInfo = _G.GetItemInfo
local GetItemCount = _G.GetItemCount

local WideTradeSkill = CreateFrame("Frame")
WideTradeSkill:RegisterEvent("PLAYER_ENTERING_WORLD")
local WideTradeSkillEnchant = CreateFrame("Frame")
WideTradeSkillEnchant:RegisterEvent("PLAYER_ENTERING_WORLD")
local dontexpandanymoreEnchant = 0
local dontexpandanymore = 0
local skillbutton,skillTitle
local vellumbutton,disenchantbutton,tradeskilloadmonitor
local classcolor = E:ClassColor(E.myclass, true)
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--flight master scale
function ElvUI_EltreumUI:TaxiScale()
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
end

--add cardinal directions to minimap
local Cardinals = CreateFrame("FRAME", "Eltruism Cardinal Directions")
Cardinals:SetParent(Minimap)
function ElvUI_EltreumUI:MinimapCardinalDirections()
	if C_CVar.GetCVar("rotateMinimap") == "1" then return end
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

		Cardinals.N:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.E:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.S:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)
		Cardinals.W:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.fontsize, E.db.general.fontStyle)

		if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.colors.classcolor then
			Cardinals.N:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.E:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.S:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
			Cardinals.W:SetTextColor(classcolor.r,classcolor.g,classcolor.b)
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

--gradient misc
function ElvUI_EltreumUI:GradientMirrorLoot()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then

		--breath/mirror
		for i = 1, _G.MIRRORTIMER_NUMTIMERS do
			local statusBar = _G['MirrorTimer'..i..'StatusBar']
			if statusBar then
				statusBar:HookScript("OnShow", function()
					local r,g,b,a = statusBar:GetStatusBarColor()
					statusBar:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", r - 0.3, g - 0.3, b - 0.3, a, r + 0.2, g + 0.2, b + 0.2, a)
				end)
			end
		end

		--loot roll
		for i = 1, NUM_GROUP_LOOT_FRAMES do
			local frame = _G["ElvUI_LootRollFrame"..i]
			if frame then
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not frame.status.shadow then
						frame.status:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.status.shadow) end
					end
				end
				if not frame.GradientHook then
					frame:HookScript("OnShow", function()
						local r,g,b = frame.status:GetStatusBarColor()
						frame.status:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", r - 0.5, g - 0.5, b - 0.5, 1, r + 0.3, g + 0.3, b + 0.3, 1)
					end)
					frame.GradientHook = true
				end
			end
		end

	end
end

--wide professions for classic
function ElvUI_EltreumUI:SkinProfessions()
	if E.db.ElvUI_EltreumUI.skins.professions and E.private.skins.blizzard.enable then

		--skin and expand the tradeskills
		WideTradeSkill:RegisterEvent("ADDON_LOADED")
		WideTradeSkill:SetScript("OnEvent", function(_, _, arg)
			if IsAddOnLoaded("Blizzard_TradeSkillUI") or IsAddOnLoaded("Blizzard_RuneforgeUI") or (arg == "Blizzard_TradeSkillUI") or (arg == "Blizzard_RuneforgeUI") then
				WideTradeSkill:UnregisterAllEvents()
				local TradeSkillFrame = _G.TradeSkillFrame
				local TradeSkillDetailScrollFrame = _G.TradeSkillDetailScrollFrame
				local TradeSkillDetailScrollChildFrame = _G.TradeSkillDetailScrollChildFrame
				local TradeSkillListScrollFrameScrollBar = _G.TradeSkillListScrollFrameScrollBar
				local TradeSkillCreateAllButton = _G.TradeSkillCreateAllButton
				local TradeSkillCreateButton = _G.TradeSkillCreateButton
				local TradeSkillCancelButton = _G.TradeSkillCancelButton

				if dontexpandanymore == 0 then
					-- Create the additional rows
					--local numSkills = _G.TRADE_SKILLS_DISPLAYED
					--local numSkills = 8
					_G.TRADE_SKILLS_DISPLAYED = 22

					--_G.TRADE_SKILLS_DISPLAYED = _G.TRADE_SKILLS_DISPLAYED + 14
					--for i = numSkills + 1, 22 do
					for i = 9, 22 do
						skillbutton = CreateFrame("Button", "TradeSkillSkill" .. i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
						skillbutton:SetID(i)
						skillbutton:Hide()
						skillbutton:ClearAllPoints()
						skillbutton:SetPoint("TOPLEFT", _G["TradeSkillSkill" .. (i - 1)], "BOTTOMLEFT", 0, 1)
					end
					--increase the width of the rows so the title fits
					for i = 1, 22 do
						skillTitle = _G["TradeSkillSkill"..i]
						skillTitle:SetWidth(335)
					end
					dontexpandanymore = 1
				end

				TradeSkillFrame:HookScript("OnShow", function()
					TradeSkillFrame:SetWidth(765)
					TradeSkillFrame:SetHeight(550)

					TradeSkillDetailScrollFrame:SetHeight(390)
					TradeSkillDetailScrollFrame:SetWidth(350)

					TradeSkillDetailScrollFrame:ClearAllPoints()
					TradeSkillDetailScrollFrame:SetPoint("RIGHT", TradeSkillFrame, 0, -35)
					TradeSkillDetailScrollFrame:SetHeight(390)

					--mouse wheel scroll frame
					_G.TradeSkillListScrollFrame:ClearAllPoints()
					_G.TradeSkillListScrollFrame:SetPoint("LEFT", TradeSkillFrame, "LEFT", 40, 0)
					_G.TradeSkillListScrollFrame:SetHeight(350)
					_G.TradeSkillListScrollFrame:SetWidth(330)

					_G.TradeSkillSkillName:ClearAllPoints()
					_G.TradeSkillSkillName:SetPoint("CENTER", TradeSkillFrame, 200, 150) --main
					_G.TradeSkillSkillName:SetParent(_G.TradeSkillFrame)
					_G.TradeSkillSkillIcon:ClearAllPoints()
					_G.TradeSkillSkillIcon:SetPoint("RIGHT", _G.TradeSkillSkillName, "LEFT", -5, -10)
					_G.TradeSkillSkillIcon:SetParent(_G.TradeSkillFrame)

					_G.TradeSkillRequirementLabel:ClearAllPoints()
					_G.TradeSkillRequirementLabel:SetPoint("BOTTOMLEFT", _G.TradeSkillSkillName, "TOPLEFT", 0, -35)
					_G.TradeSkillRequirementLabel:SetParent(_G.TradeSkillFrame)
					_G.TradeSkillRequirementText:ClearAllPoints()
					_G.TradeSkillRequirementText:SetPoint("LEFT", _G.TradeSkillRequirementLabel,"RIGHT", 5, 0)
					_G.TradeSkillRequirementText:SetParent(_G.TradeSkillFrame)

					--Auctionator search fix
					if IsAddOnLoaded("Auctionator") then
						E:Delay(0, function()
							if _G.AuctionatorTradeSkillSearch then
								_G.AuctionatorTradeSkillSearch:ClearAllPoints()
								_G.AuctionatorTradeSkillSearch:SetPoint("RIGHT", _G.TradeSkillSkillName,"RIGHT", 0, -40)
							end
							if _G.AuctionatorCraftSkillSearch then
								_G.AuctionatorCraftSkillSearch:ClearAllPoints()
								_G.AuctionatorCraftSkillSearch:SetPoint("RIGHT", _G.TradeSkillSkillName,"RIGHT", 0, -40)
							end
						end)
					end

					if _G.TradeSkillDescription then
						_G.TradeSkillDescription:ClearAllPoints()
						_G.TradeSkillDescription:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", 74, -114)
						_G.TradeSkillDescription:SetParent(_G.TradeSkillFrame)
					end
					_G.TradeSkillReagentLabel:ClearAllPoints()
					_G.TradeSkillReagentLabel:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", -35, -120)
					_G.TradeSkillReagentLabel:SetParent(_G.TradeSkillFrame)

					TradeSkillListScrollFrameScrollBar:ClearAllPoints()
					TradeSkillListScrollFrameScrollBar:SetPoint("LEFT", TradeSkillDetailScrollChildFrame, -30, -70)
					TradeSkillListScrollFrameScrollBar:SetHeight(320)

					for i = 1, 15 do
						if _G["TradeSkillReagent"..i] then
							_G["TradeSkillReagent"..i]:SetParent(_G.TradeSkillFrame)
						else
							break
						end
					end

					if _G.TradeSkillDetailScrollFrameScrollBar then
						_G.TradeSkillDetailScrollFrameScrollBar:Hide()
					end

					TradeSkillCreateAllButton:ClearAllPoints()
					TradeSkillCreateAllButton:SetPoint("LEFT", TradeSkillFrame, "BOTTOMLEFT", 15, 95)

					TradeSkillCreateButton:ClearAllPoints()
					TradeSkillCreateButton:SetPoint("LEFT", TradeSkillFrame, "BOTTOMLEFT", 180, 95)

					TradeSkillCancelButton:ClearAllPoints()
					TradeSkillCancelButton:SetPoint("RIGHT", TradeSkillFrame, "BOTTOMRIGHT", -50, 95)
				end)
			end
		end)

		--and enchanting which uses a different system apparently
		WideTradeSkillEnchant:RegisterEvent("ADDON_LOADED")
		WideTradeSkillEnchant:SetScript("OnEvent", function(_, _, arg)
			if IsAddOnLoaded("Blizzard_CraftUI") or (arg == "Blizzard_CraftUI") then
				WideTradeSkillEnchant:UnregisterAllEvents()
				local CraftFrame = _G.CraftFrame
				local CraftFrameAvailableFilterCheckButton = _G.CraftFrameAvailableFilterCheckButton
				local CraftFrameFilterDropDown = _G.CraftFrameFilterDropDown
				local CraftCreateButton = _G.CraftCreateButton
				local CraftCancelButton = _G.CraftCancelButton
				local CraftListScrollFrameScrollChildFrame = _G.CraftListScrollFrameScrollChildFrame
				local CraftListScrollFrameScrollBar = _G.CraftListScrollFrameScrollBar
				local CraftDetailScrollFrame = _G.CraftDetailScrollFrame
				local CraftDetailScrollChildFrame = _G.CraftDetailScrollChildFrame
				local CraftDetailScrollFrameScrollBar = _G.CraftDetailScrollFrameScrollBar

				CraftFrame:HookScript("OnShow", function()
					if not CraftFrame.backdrop.shadow then
						CraftFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(CraftFrame.backdrop.shadow) end
					end
					CraftFrame:SetWidth(765)
					CraftFrame:SetHeight(550)

					_G.CraftListScrollFrame:ClearAllPoints()
					_G.CraftListScrollFrame:SetPoint("LEFT", CraftFrame, "LEFT", 20, 10)
					_G.CraftListScrollFrame:SetHeight(340)
					_G.CraftListScrollFrame:SetWidth(330)

					CraftListScrollFrameScrollChildFrame:SetHeight(390)
					CraftListScrollFrameScrollChildFrame:SetWidth(350)

					CraftListScrollFrameScrollBar:ClearAllPoints()
					CraftListScrollFrameScrollBar:SetPoint("CENTER", CraftFrame, "CENTER", 10, 12)
					CraftListScrollFrameScrollBar:SetHeight(320)

					CraftDetailScrollChildFrame:ClearAllPoints()
					CraftDetailScrollChildFrame:SetParent(CraftFrame)
					CraftDetailScrollChildFrame:SetPoint("LEFT", CraftListScrollFrameScrollBar, 30, -46)
					CraftDetailScrollChildFrame:SetHeight(390)

					CraftDetailScrollFrame:Hide()
					CraftDetailScrollFrameScrollBar:Hide()
					if E.Wrath or E.TBC then
						CraftFrameFilterDropDown:ClearAllPoints()
						CraftFrameFilterDropDown:SetPoint("TOPRIGHT", CraftDetailScrollChildFrame, 0, 50)
						CraftFrameAvailableFilterCheckButton:ClearAllPoints()
						CraftFrameAvailableFilterCheckButton:SetPoint("TOPLEFT", CraftFrame, 64,-48)
					end

					_G.CraftFramePointsLabel:ClearAllPoints()
					_G.CraftFramePointsLabel:SetPoint("LEFT", _G["CraftCreateButton"], "RIGHT", 5, 0)
					_G.CraftFramePointsText:ClearAllPoints()
					_G.CraftFramePointsText:SetPoint("LEFT", _G.CraftFramePointsLabel, "RIGHT", 5, 0)

					CraftCancelButton:ClearAllPoints()
					CraftCancelButton:SetPoint("RIGHT", CraftFrame, "BOTTOMRIGHT", -50, 95)

					if dontexpandanymoreEnchant == 0 then
						-- Create the additional rows
						--local numCrafts = CRAFTS_DISPLAYED
						local numCrafts = 8
						--CRAFTS_DISPLAYED = CRAFTS_DISPLAYED + 14
						_G.CRAFTS_DISPLAYED = 22
						for i = numCrafts + 1, 22 do
							local craftbutton = CreateFrame("Button", "Craft" .. i, CraftFrame, "CraftButtonTemplate")
							craftbutton:SetID(i)
							craftbutton:Hide()
							craftbutton:ClearAllPoints()
							craftbutton:SetPoint("TOPLEFT", _G["Craft" .. (i - 1)], "BOTTOMLEFT", 0, 1)
						end
						--increase the width of the rows so the title fits
						for i = 1, 8 do
							local craftTitle = _G["Craft"..i]
							craftTitle:Width(335)
						end
						dontexpandanymoreEnchant = 1
					end

					CraftCreateButton:ClearAllPoints()
					CraftCreateButton:SetPoint("LEFT", CraftFrame, "BOTTOMLEFT", 25, 95)
					CraftCancelButton:ClearAllPoints()
					CraftCancelButton:SetPoint("RIGHT", CraftFrame, "BOTTOMRIGHT", -50, 95)
				end)
			end
		end)
	end
end

--enchanting vellum/disenchant buttons
function ElvUI_EltreumUI:EnchantScroll()
	if E.db.ElvUI_EltreumUI.skins.professions and E.private.skins.blizzard.enable then
		--create vellum button
		if E.Retail then
			if not _G["EltruismVellumButton"] then
				vellumbutton = CreateFrame("BUTTON", "EltruismVellumButton", _G["TradeSkillFrame"], "MagicButtonTemplate")
				vellumbutton:SetPoint("RIGHT", _G.TradeSkillFrame.DetailsFrame.CreateButton, "LEFT", -1, 0)
				S:HandleButton(vellumbutton)
			else
				vellumbutton = _G["EltruismVellumButton"]
			end
		end

		--create disenchant button
		if not _G["EltruismDisenchantButton"] then
			disenchantbutton = CreateFrame("BUTTON", "EltruismDisenchantButton", _G["TradeSkillFrame"], "MagicButtonTemplate,InsecureActionButtonTemplate")
			if E.Retail then
				disenchantbutton:SetPoint("RIGHT", "EltruismVellumButton", "LEFT", -1, 0)
			else
				disenchantbutton:SetPoint("LEFT", _G.TradeSkillCreateButton, "RIGHT", 1, 0)
			end
			S:HandleButton(disenchantbutton)
		else
			disenchantbutton = _G["EltruismDisenchantButton"]
		end

		--script buttons
		if not self.isScripted then
			local disenchant = GetSpellInfo(13262)
			disenchantbutton:SetText(disenchant)
			disenchantbutton:SetAttribute("type1", "spell")
			disenchantbutton:SetAttribute("spell", "13262")
			if E.Retail then
				local vellum = GetItemInfo(38682)
				if vellum then
					vellum = string.match(vellum, "%s+(%S+)")
					vellumbutton:SetText(vellum)
					vellumbutton:SetScript("OnShow", function()
						if GetItemCount(38682) > 0 then
							vellumbutton:SetEnabled(true)
						else
							vellumbutton:SetEnabled(false)
						end
					end)
					vellumbutton:SetScript("OnClick", function()
						if GetItemCount(38682) > 0 then
							vellumbutton:SetEnabled(true)
							C_TradeSkillUI.CraftRecipe(_G["TradeSkillFrame"].DetailsFrame.selectedRecipeID)
							UseItemByName(38682)
						else
							vellumbutton:SetEnabled(false)
						end
					end)
				end
			end

			self.isScripted = true
		end

		--fixx disenchant overlap with create all
		if E.Retail then
			if _G.TradeSkillFrame.DetailsFrame.CreateAllButton then
				_G.TradeSkillFrame.DetailsFrame.CreateAllButton:SetScript("OnShow", function()
					disenchantbutton:ClearAllPoints()
					disenchantbutton:SetPoint("BOTTOM", "EltruismVellumButton", "TOP", 0, 1)
				end)
				_G.TradeSkillFrame.DetailsFrame.CreateAllButton:SetScript("OnHide", function()
					disenchantbutton:ClearAllPoints()
					disenchantbutton:SetPoint("RIGHT", "EltruismVellumButton", "LEFT", -1, 0)
				end)
			end
		end

		--hook tradeskill because it shoul show only with enchanting
		local function UpdateButtons()
			E:Delay(0, function()
				local enchantingtext = GetSpellInfo(7411)
				local tradeskilltext = _G.TradeSkillFrameTitleText:GetText()
				if enchantingtext == tradeskilltext then
					if E.Retail then
						vellumbutton:Show()
						_G.TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:ClearAllPoints()
						_G.TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:SetPoint("BOTTOM", _G.TradeSkillFrame.DetailsFrame.CreateButton, "TOP", 0, 1)
					end
					disenchantbutton:Show()
				else
					if E.Retail then
						vellumbutton:Hide()
						_G.TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:ClearAllPoints()
						_G.TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:SetPoint("RIGHT", _G.TradeSkillFrame.DetailsFrame.CreateButton, "LEFT", -26, 0)
					end
					disenchantbutton:Hide()
				end
			end)
		end
		_G.TradeSkillFrame:HookScript("OnShow",function() UpdateButtons() end)
		_G.TradeSkillFrame:HookScript("OnEvent",function() UpdateButtons() end)
	end
end

--frame that checks for the blizzard addon for the enchanting buttons
local tradeskilloadmonitor = CreateFrame("FRAME")
tradeskilloadmonitor:RegisterEvent("PLAYER_ENTERING_WORLD")
tradeskilloadmonitor:RegisterEvent("ADDON_LOADED")
tradeskilloadmonitor:SetScript("OnEvent", function(_,_,arg)
	if IsAddOnLoaded("Blizzard_TradeSkillUI") or (arg == "Blizzard_TradeSkillUI") then
		ElvUI_EltreumUI:EnchantScroll()
		tradeskilloadmonitor:UnregisterAllEvents()
	end
end)

function ElvUI_EltreumUI:SkinMailZone()
	if E.db.ElvUI_EltreumUI.skins.zones then
		if not IsAddOnLoaded("ElvUI_SLE") then
			--[[hooksecurefunc("SetZoneText", function()
				ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, E.db.general.fontStyle)
				SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, E.db.general.fontStyle)
				PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
				PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			end)]]
			--[[_G.ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, "NONE")
			_G.ZoneTextString:SetShadowColor(0,0,0,1)
			_G.ZoneTextString:SetShadowOffset(3, -3)
			_G.SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, "NONE")
			_G.SubZoneTextString:SetShadowColor(0,0,0,1)
			_G.SubZoneTextString:SetShadowOffset(3, -3)]]
			_G.ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, E.db.general.fontStyle)
			_G.SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, E.db.general.fontStyle)
			_G.PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			_G.PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			--if _G.OpenMailBodyText then
			--	_G.OpenMailBodyText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
			--end
			if E.Retail then
				_G.SendMailBodyEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
			--elseif E.TBC or E.Classic then
				--MailEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
			end
		end
	end
end
