local E = unpack(ElvUI)
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
local vellumbutton,disenchantbutton
local classcolor = E:ClassColor(E.myclass, true)
local string = _G.string

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

--gradient loot roll/mirror/breath/feigndeath
function ElvUI_EltreumUI:GradientMirrorLoot()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then

		--breath/mirror
		if not E.Retail then
			for i = 1, 3 do
				local statusBar = _G['MirrorTimer'..i..'StatusBar']
				if statusBar then
					statusBar:HookScript("OnShow", function()
						statusBar:SetSize(E.db.ElvUI_EltreumUI.otherstuff.mirrorx, E.db.ElvUI_EltreumUI.otherstuff.mirrory)
						statusBar:SetScale(E.db.ElvUI_EltreumUI.otherstuff.mirrorscale)
						local r,g,b,a = statusBar:GetStatusBarColor()
						statusBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.3,g= g - 0.3,b= b - 0.3,a= a}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= a})
					end)
				end
			end
		else
			if not _G.MirrorTimerContainer.EltruismHook then
				hooksecurefunc(_G.MirrorTimerContainer, 'SetupTimer', function(container, timer) --based on elvui
					_G.MirrorTimerContainer.EltruismHook = true
					local bar = container:GetAvailableTimer(timer)
					if not bar then return end
					if bar.StatusBar then

						--size/scale settings, but blizzard controls the mover and sizer too, so there might be issues
						bar:SetSize(E.db.ElvUI_EltreumUI.otherstuff.mirrorx, E.db.ElvUI_EltreumUI.otherstuff.mirrory)
						_G.MirrorTimerContainer:SetScale(E.db.ElvUI_EltreumUI.otherstuff.mirrorscale)
						bar.StatusBar:SetAllPoints(bar)
						bar:SetPoint("CENTER", _G.MirrorTimerContainer, "CENTER")

						--shadows
						if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.blizzard then
							if not bar.shadow then
								bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(bar.shadow)
							end
						end

						--gradient
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
							local atlas = bar.StatusBar:GetStatusBarTexture():GetAtlas()
							local alpha = bar.StatusBar:GetAlpha()
							--print(atlas)
							bar.StatusBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.private.general.glossTex))

							--print(timer, value, maxvalue, scale, paused, label)
							local MirrorTimerAtlasCheck = {
								["EXHAUSTION"] = "UI-CastingBar-Filling-Standard", --yellow
								["BREATH"] = "UI-CastingBar-Filling-ApplyingCrafting", --changing talents (blue)
								--["DEATH"] = "UI-CastingBar-Filling-Standard", --same as EXHAUSTION
								["FEIGNDEATH"] = "UI-CastingBar-Filling-Channel", --green
							}
							if atlas == MirrorTimerAtlasCheck["EXHAUSTION"] then
								bar.StatusBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=1,g= 0.68,b= 0,a= alpha}, {r=1,g= 0.83,b= 0.25,a= alpha})
							elseif atlas == MirrorTimerAtlasCheck["BREATH"] then
								bar.StatusBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=0,g= 0.33,b= 0.53,a= alpha}, {r=0.49,g= 0.87,b= 1,a= alpha})
							elseif atlas == MirrorTimerAtlasCheck["FEIGNDEATH"] then
								bar.StatusBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=0.01,g= 0.6,b= 0.36,a= alpha}, {r=0,g= 1,b= 0.58,a= alpha})
							end
						end

						bar:StripTextures()
						bar:SetTemplate('Transparent')
					end
				end)
			end
		end

		--loot roll
		for i = 1, 4 do
			local frame = _G["ElvUI_LootRollFrame"..i]
			if frame then
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not frame.status.shadow then
						frame.status:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.status.shadow)
					end
				end
				if not frame.GradientHook then
					frame:HookScript("OnShow", function()
						local r,g,b = frame.status:GetStatusBarColor()
						frame.status:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.5,g= g - 0.5,b= b - 0.5,a= 1}, {r=r + 0.3,g= g + 0.3,b= b + 0.3,a= 1})
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
					E:Delay(0, function()
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

						--[[_G.TradeSkillSkillName:ClearAllPoints()
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
						_G.TradeSkillRequirementText:SetParent(_G.TradeSkillFrame)]]

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

						--if _G.TradeSkillDescription then
							--_G.TradeSkillDescription:ClearAllPoints()
							--_G.TradeSkillDescription:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", 74, -114)
							--.TradeSkillDescription:SetParent(_G.TradeSkillFrame)
						--end

						--[[_G.TradeSkillReagentLabel:ClearAllPoints()
						_G.TradeSkillReagentLabel:SetPoint("BOTTOM", _G.TradeSkillRequirementLabel, "TOP", -35, -120)
						_G.TradeSkillReagentLabel:SetParent(_G.TradeSkillFrame)]]

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
					E:Delay(0, function()
						if not CraftFrame.backdrop.shadow then
							CraftFrame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(CraftFrame.backdrop.shadow)
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
						if E.Wrath then
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
				end)
			end
		end)
	end
end

--enchanting vellum/disenchant buttons
function ElvUI_EltreumUI:EnchantScroll()
	if E.db.ElvUI_EltreumUI.skins.professions and E.private.skins.blizzard.enable then

		--hijack here because retail is different
		if E.Retail then
			if _G.ProfessionsFrame then
				--_G.ProfessionsFrame:SetScale(E.db.ElvUI_EltreumUI.skins.professionscale)
				_G.ProfessionsFrame:HookScript("OnEvent", function()
					_G.ProfessionsFrame:SetScale(E.db.ElvUI_EltreumUI.skins.professionscale or 1)
				end)
				_G.ProfessionsFrame:HookScript("OnShow", function()
					_G.ProfessionsFrame:SetScale(E.db.ElvUI_EltreumUI.skins.professionscale or 1)
				end)
				_G.ProfessionsFrame:SetScript('OnSizeChanged', function()
					_G.ProfessionsFrame:SetScale(E.db.ElvUI_EltreumUI.skins.professionscale or 1)
				end)
			end
		end

		--create vellum button
		if E.Retail then
			if not _G["EltruismVellumButton"] then
				if E.Retail then
					vellumbutton = CreateFrame("BUTTON", "EltruismVellumButton", _G["ProfessionsFrame"], "MagicButtonTemplate")
					vellumbutton:SetPoint("RIGHT", _G.ProfessionsFrame.CraftingPage.CreateAllButton, "LEFT", -1, 0)
				else
					vellumbutton = CreateFrame("BUTTON", "EltruismVellumButton", _G["TradeSkillFrame"], "MagicButtonTemplate")
					vellumbutton:SetPoint("RIGHT", _G.TradeSkillFrame.DetailsFrame.CreateButton, "LEFT", -1, 0)
				end
				S:HandleButton(vellumbutton)
			else
				vellumbutton = _G["EltruismVellumButton"]
			end
		end

		--create disenchant button
		if not _G["EltruismDisenchantButton"] then
			if E.Retail then
				disenchantbutton = CreateFrame("BUTTON", "EltruismDisenchantButton", _G["ProfessionsFrame"], "MagicButtonTemplate,InsecureActionButtonTemplate")
				disenchantbutton:SetPoint("RIGHT", "EltruismVellumButton", "LEFT", -1, 0)
			else
				disenchantbutton = CreateFrame("BUTTON", "EltruismDisenchantButton", _G["TradeSkillFrame"], "MagicButtonTemplate,InsecureActionButtonTemplate")
				disenchantbutton:SetPoint("LEFT", _G.TradeSkillCreateButton, "RIGHT", 1, 0)
			end
			S:HandleButton(disenchantbutton)
		else
			disenchantbutton = _G["EltruismDisenchantButton"]
		end

		--script buttons
		local hookedframe
		if E.Retail then
			hookedframe = _G.ProfessionsFrame
		else
			hookedframe = _G.TradeSkillFrame
		end
		if not hookedframe.isEltruismScripted then
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
							--C_TradeSkillUI.CraftRecipe(_G["TradeSkillFrame"].DetailsFrame.selectedRecipeID)
							C_TradeSkillUI.CraftRecipe(_G["ProfessionsFrame"].CraftingPage.RecipeList.previousRecipeID)
							UseItemByName(38682)
						else
							vellumbutton:SetEnabled(false)
						end
					end)
				end
			end

			hookedframe.isEltruismScripted = true
		end

		--fix disenchant overlap with create all
		if E.Retail then
			if _G.ProfessionsFrame.CraftingPage.CreateAllButton then
				_G.ProfessionsFrame.CraftingPage.CreateAllButton:SetScript("OnShow", function()
					vellumbutton:ClearAllPoints()
					vellumbutton:SetPoint("RIGHT", _G.ProfessionsFrame.CraftingPage.CreateAllButton, "LEFT", -1, 0)
				end)
				_G.ProfessionsFrame.CraftingPage.CreateAllButton:SetScript("OnHide", function()
					vellumbutton:ClearAllPoints()
					vellumbutton:SetPoint("RIGHT", _G.ProfessionsFrame.CraftingPage.CreateButton, "LEFT", -1, 0)
				end)
			end
		end

		--hook tradeskill because it shoul show only with enchanting
		local function UpdateButtons()
			E:Delay(0.08, function()
				local enchantingtext = GetSpellInfo(7411)
				local tradeskilltext
				if E.Retail then
					tradeskilltext = _G.ProfessionsFrameTitleText:GetText()
				else
					tradeskilltext = _G.TradeSkillFrameTitleText:GetText()
				end
				if tradeskilltext and tradeskilltext:match(enchantingtext) then
					if E.Retail then
						vellumbutton:Show()
					end
					disenchantbutton:Show()
				else
					if E.Retail then
						vellumbutton:Hide()
					end
					disenchantbutton:Hide()
				end
			end)
		end
		if E.Retail then
			_G.ProfessionsFrame:HookScript("OnShow",function() UpdateButtons() end)
			_G.ProfessionsFrame:HookScript("OnEvent",function() UpdateButtons() end)
		else
			_G.TradeSkillFrame:HookScript("OnShow",function() UpdateButtons() end)
			_G.TradeSkillFrame:HookScript("OnEvent",function() UpdateButtons() end)
		end
	end
end

--frame that checks for the blizzard addon for the enchanting buttons
local tradeskilloadmonitor = CreateFrame("FRAME")
tradeskilloadmonitor:RegisterEvent("PLAYER_ENTERING_WORLD")
tradeskilloadmonitor:RegisterEvent("ADDON_LOADED")
local function TSMCheck(arg)
	if IsAddOnLoaded("Blizzard_TradeSkillUI") or (arg == "Blizzard_TradeSkillUI") or _G.ProfessionsFrame then
		tradeskilloadmonitor:UnregisterAllEvents()
		if not E.private.ElvUI_EltreumUI then return end
		if not E.db.ElvUI_EltreumUI then return end
		if not E.db.ElvUI_EltreumUI.skins then return end
		if not E.db.ElvUI_EltreumUI.skins.professions then return end
		ElvUI_EltreumUI:EnchantScroll()
	end
end
tradeskilloadmonitor:SetScript("OnEvent", function(_,_,arg)
	--in 10.1.5 the addon load order seems to not be reliable and tsm can error, so check for tsm being enabled (because it wont be loaded)
	if GetAddOnEnableState(E.myname,"TradeSkillMaster") == 0 then
		TSMCheck(arg)
	else
		if E.Retail then
			tradeskilloadmonitor:UnregisterAllEvents()
			S:AddCallbackForAddon('TradeSkillMaster', "EltruismTSMWorkaround", ElvUI_EltreumUI.EnchantScroll)
		else
			TSMCheck(arg)
		end
	end
end)

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

function ElvUI_EltreumUI:SkinMailZone()
	if E.db.ElvUI_EltreumUI.skins.zones then
		if not ElvUI_EltreumUI:SLCheck("media") then
			_G.ZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 42, E.db.general.fontStyle)
			_G.SubZoneTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 28, E.db.general.fontStyle)
			_G.PVPInfoTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			_G.PVPArenaTextString:SetFont(E.LSM:Fetch('font', E.db.general.font), 20, E.db.general.fontStyle)
			if E.db.general.fontStyle ~= "NONE" then
				_G.ZoneTextString:SetShadowColor(0,0,0,1)
				_G.ZoneTextString:SetShadowOffset(1, -1)
				_G.SubZoneTextString:SetShadowColor(0,0,0,1)
				_G.SubZoneTextString:SetShadowOffset(1, -1)
			end

			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not self.ZoneSkinned then
				_G.ZoneTextFrame:HookScript("OnUpdate", function()
					--_G.ZoneTextString:SetWidth(512)
					--_G.ZoneTextString:SetMaxLines(1)
					--_G.ZoneTextString:SetWordWrap(false)
					--_G.ZoneTextString:SetText("Putricide's Laboratory of Alchemical Horrors and Fun") --debug for length
					if _G.ZoneTextString:GetText() ~= nil and not _G.ZoneTextString:GetText():match("|r|c") then
						local r,g,b = _G.ZoneTextString:GetTextColor()
						local r2 = r-0.3
						if r2 < 0 then r2 = 0 end
						local g2 = g-0.3
						if g2 < 0 then g2 = 0 end
						local b2 = b-0.3
						if b2 < 0 then b2 = 0 end
						_G.ZoneTextString:SetText(E:TextGradient(_G.ZoneTextString:GetText(), r, g, b, r2, g2, b2))
					end
					if _G.PVPInfoTextString:GetText() ~= nil and not _G.PVPInfoTextString:GetText():match("|r|c") then
						local r,g,b = _G.PVPInfoTextString:GetTextColor()
						local r2 = r-0.3
						if r2 < 0 then r2 = 0 end
						local g2 = g-0.3
						if g2 < 0 then g2 = 0 end
						local b2 = b-0.3
						if b2 < 0 then b2 = 0 end
						_G.PVPInfoTextString:SetText(E:TextGradient(_G.PVPInfoTextString:GetText(), r, g, b, r2, g2, b2))
					end
				end)
				_G.SubZoneTextFrame:HookScript("OnUpdate", function()
					--_G.SubZoneTextString:SetWidth(512)
					--_G.SubZoneTextString:SetMaxLines(1)
					--_G.SubZoneTextString:SetWordWrap(false)
					if _G.SubZoneTextString:GetText() ~= nil and not _G.SubZoneTextString:GetText():match("|r|c") then
						local r,g,b = _G.SubZoneTextString:GetTextColor()
						local r2 = r-0.3
						if r2 < 0 then r2 = 0 end
						local g2 = g-0.3
						if g2 < 0 then g2 = 0 end
						local b2 = b-0.3
						if b2 < 0 then b2 = 0 end
						_G.SubZoneTextString:SetText(E:TextGradient(_G.SubZoneTextString:GetText(), r, g, b, r2, g2, b2))
					end
					if _G.PVPArenaTextString:GetText() ~= nil and not _G.PVPArenaTextString:GetText():match("|r|c") then
						local r,g,b = _G.PVPArenaTextString:GetTextColor()
						local r2 = r-0.3
						if r2 < 0 then r2 = 0 end
						local g2 = g-0.3
						if g2 < 0 then g2 = 0 end
						local b2 = b-0.3
						if b2 < 0 then b2 = 0 end
						_G.PVPArenaTextString:SetText(E:TextGradient(_G.PVPArenaTextString:GetText(), r, g, b, r2, g2, b2))
					end
				end)
				self.ZoneSkinned = true
			end

			if _G.OpenMailBodyText then
				if E.db.general.fontStyle == "NONE" then
					_G.OpenMailBodyText:SetFont("P", E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, "")
				else
					_G.OpenMailBodyText:SetFont("P", E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
				end
			end
			if E.Retail then
				if E.db.general.fontStyle == "NONE" then
					_G.SendMailBodyEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, "")
				else
					_G.SendMailBodyEditBox:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
				end
			end
		end
	end
end

--hide talking head
local EltruismHideTalkingHead = CreateFrame('Frame', "EltruismHideTalkingHeadFrame")
EltruismHideTalkingHead:RegisterEvent('PLAYER_ENTERING_WORLD')
EltruismHideTalkingHead:RegisterEvent('ADDON_LOADED')
function ElvUI_EltreumUI:EltruismHideTalkingHead()
	if E.db.ElvUI_EltreumUI.skins.hidetalkinghead then
		EltruismHideTalkingHead:SetScript('OnEvent', function(_, event)
			if event == 'PLAYER_ENTERING_WORLD' or event == 'ADDON_LOADED' or IsAddOnLoaded("Blizzard_TalkingHeadUI") then
				if E.Retail then
					local TalkingHeadFrame = _G.TalkingHeadFrame
					if TalkingHeadFrame then
						hooksecurefunc(_G["TalkingHeadFrame"], "PlayCurrent", function()
							TalkingHeadFrame:Hide()
						end)
						hooksecurefunc(_G["TalkingHeadFrame"], "Reset", function()
							TalkingHeadFrame:Hide()
						end)
						EltruismHideTalkingHead:UnregisterAllEvents()
					end
				else
					EltruismHideTalkingHead:UnregisterAllEvents()
				end
			end
		end)
	end
end

--skin the vehicle button, since its been a long time unskinned
if _G["MainMenuBarVehicleLeaveButton"] then
	S:HandleButton(_G["MainMenuBarVehicleLeaveButton"])
	if _G["MainMenuBarVehicleLeaveButton"].hover then
		_G["MainMenuBarVehicleLeaveButton"].hover:Hide()
	end
	if _G["MainMenuBarVehicleLeaveButton"].Highlight then
		_G["MainMenuBarVehicleLeaveButton"].Highlight:SetTexture(nil)
	end
	_G["MainMenuBarVehicleLeaveButton"]:GetNormalTexture():SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ExitVehicle")
	_G["MainMenuBarVehicleLeaveButton"]:GetPushedTexture():SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ExitVehicle")
	_G["MainMenuBarVehicleLeaveButton"]:GetPushedTexture():SetVertexColor(1,0,0,1)
	_G["MainMenuBarVehicleLeaveButton"]:GetDisabledTexture():SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ExitVehicle")
	_G["MainMenuBarVehicleLeaveButton"]:GetDisabledTexture():SetVertexColor(1,0,0,1)
end

--make shamans blue again in classic
if E.Classic then
	_G.RAID_CLASS_COLORS['SHAMAN']["r"] = 0.00
	_G.RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44
	_G.RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87
	_G.RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070DD"
	E.oUF.colors.class['SHAMAN'][1] = 0.00
	E.oUF.colors.class['SHAMAN'][2] = 0.44
	E.oUF.colors.class['SHAMAN'][3] = 0.87
	E.oUF.colors.class['SHAMAN']["r"] = 0.00
	E.oUF.colors.class['SHAMAN']["g"] = 0.44
	E.oUF.colors.class['SHAMAN']["b"] = 0.87
end
