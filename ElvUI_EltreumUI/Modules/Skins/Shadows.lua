local E = unpack(ElvUI)
local DT = E:GetModule('DataTexts')
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local A = E:GetModule('Auras')
local M = E:GetModule('Misc')
local valuecolors = E.myClassColor
local _G = _G
local next = _G.next
local pairs = _G.pairs
local ipairs = _G.ipairs
local type = _G.type
local tostring = _G.tostring
local unpack = _G.unpack
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = (_G.C_AddOns and _G.C_AddOns.IsAddOnLoaded) or _G.IsAddOnLoaded
local isMasqueLoaded = (IsAddOnLoaded and IsAddOnLoaded("Masque")) or false

local EltruismBlizzShadows
local MinimapShadow
local RightChatShadow
local LeftChatShadow
local timermonitor

--seems to throw a LinkAchievementInWhisper in 12.0.7
--[[do -- Midnight API Fix. Credit: fang (WindTools)
	local BackdropTemplateMixin_SetupTextureCoordinates = _G.BackdropTemplateMixin.SetupTextureCoordinates
	function _G.BackdropTemplateMixin:SetupTextureCoordinates(...)
		if E:NotSecretValue(self:GetWidth()) then
			BackdropTemplateMixin_SetupTextureCoordinates(self, ...)
		end
	end
end]]

--simple function to set shadow color
function ElvUI_EltreumUI:ShadowColor(shadow, shadowDB, needsLowering)
	if shadow then
		if not shadowDB then
			local eltreumDB = E.db.ElvUI_EltreumUI
			shadowDB = eltreumDB and eltreumDB.skins and eltreumDB.skins.shadow
		end
		if shadowDB then
			if shadowDB.classcolor then
				shadow:SetBackdropBorderColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
			elseif shadowDB.customcolor then
				shadow:SetBackdropBorderColor(shadowDB.r, shadowDB.g, shadowDB.b, shadowDB.a)
			end
		end
		if needsLowering then
			shadow:SetFrameLevel(1)
			shadow:SetFrameStrata("LOW")
		end
	end
end

--glowtex uv coords for the 8 shadow pieces
local shadowCoords = {
	TopLeftCorner = { 0.5078125, 0.0625, 0.5078125, 0.9375, 0.6171875, 0.0625, 0.6171875, 0.9375 },
	TopRightCorner = { 0.6328125, 0.0625, 0.6328125, 0.9375, 0.7421875, 0.0625, 0.7421875, 0.9375 },
	BottomLeftCorner = { 0.7578125, 0.0625, 0.7578125, 0.9375, 0.8671875, 0.0625, 0.8671875, 0.9375 },
	BottomRightCorner = { 0.8828125, 0.0625, 0.8828125, 0.9375, 0.9921875, 0.0625, 0.9921875, 0.9375 },
	TopEdge = { 0.2578125, 0.9375, 0.3671875, 0.9375, 0.2578125, 0.0625, 0.3671875, 0.0625 },
	BottomEdge = { 0.3828125, 0.9375, 0.4921875, 0.9375, 0.3828125, 0.0625, 0.4921875, 0.0625 },
	LeftEdge = { 0.0078125, 0.0625, 0.0078125, 0.9375, 0.1171875, 0.0625, 0.1171875, 0.9375 },
	RightEdge = { 0.1328125, 0.0625, 0.1328125, 0.9375, 0.2421875, 0.0625, 0.2421875, 0.9375 },
}

--set vertex color on all 8 shadow pieces
local function SetShadowBorderColor(self, r, g, b, a)
	for piece in next, shadowCoords do
		self[piece]:SetVertexColor(r, g, b, a or 1)
	end
end

--create the 8 shadow textures without BackdropTemplate
local function CreateShadowTextures(shadow, size)
	local glowTex = E.Media.Textures.GlowTex
	for piece, coords in next, shadowCoords do
		local tex = shadow:CreateTexture(nil, "BORDER")
		tex:SetTexture(glowTex)
		tex:SetTexCoord(unpack(coords))
		shadow[piece] = tex
	end

	local topLeft, topRight = shadow.TopLeftCorner, shadow.TopRightCorner
	local bottomLeft, bottomRight = shadow.BottomLeftCorner, shadow.BottomRightCorner
	topLeft:SetSize(size, size)
	topLeft:SetPoint("TOPLEFT", shadow, "TOPLEFT")
	topRight:SetSize(size, size)
	topRight:SetPoint("TOPRIGHT", shadow, "TOPRIGHT")
	bottomLeft:SetSize(size, size)
	bottomLeft:SetPoint("BOTTOMLEFT", shadow, "BOTTOMLEFT")
	bottomRight:SetSize(size, size)
	bottomRight:SetPoint("BOTTOMRIGHT", shadow, "BOTTOMRIGHT")

	shadow.TopEdge:SetPoint("TOPLEFT", topLeft, "TOPRIGHT")
	shadow.TopEdge:SetPoint("BOTTOMRIGHT", topRight, "BOTTOMLEFT")
	shadow.BottomEdge:SetPoint("TOPLEFT", bottomLeft, "TOPRIGHT")
	shadow.BottomEdge:SetPoint("BOTTOMRIGHT", bottomRight, "BOTTOMLEFT")
	shadow.LeftEdge:SetPoint("TOPLEFT", topLeft, "BOTTOMLEFT")
	shadow.LeftEdge:SetPoint("BOTTOMRIGHT", bottomLeft, "TOPRIGHT")
	shadow.RightEdge:SetPoint("TOPLEFT", topRight, "BOTTOMLEFT")
	shadow.RightEdge:SetPoint("BOTTOMRIGHT", bottomRight, "TOPRIGHT")
end

--local shadow fallback when elvui still uses BackdropTemplate
local function CreateLocalShadow(frame, size, pass)
	if not pass and frame.shadow then return end
	if not size then size = 3 end

	local offset = (E.PixelMode and size) or (size + 1)
	local shadow = CreateFrame("Frame", nil, frame)
	shadow:SetFrameLevel(1)
	shadow:SetOutside(frame, offset, offset, nil, true)

	CreateShadowTextures(shadow, size)
	shadow.SetBackdropBorderColor = SetShadowBorderColor
	shadow:SetBackdropBorderColor(0, 0, 0, 0.9)

	local strata = frame:GetFrameStrata()
	if E:NotSecretValue(strata) then
		shadow:SetFrameStrata(strata)
	end

	if pass then
		return shadow
	else
		frame.shadow = shadow
		return shadow
	end
end

local useElvUIShadow

--check once if elvui already uses texture shadows instead of BackdropTemplate
local function CheckElvUIShadow()
	local probe = CreateFrame("Frame")
	probe:Hide()
	probe:CreateShadow(3)
	useElvUIShadow = not (probe.shadow and probe.shadow.GetBackdrop)
	if probe.shadow then
		probe.shadow:Hide()
	end
end

--create and color a shadow using elvui or local texture shadows
local function AddShadow(frame, length, shadowDB, needsLowering, pass)
	if not frame then return end
	if not pass and frame.shadow then
		return frame.shadow
	end
	if useElvUIShadow == nil then
		CheckElvUIShadow()
	end
	local shadow
	if useElvUIShadow then
		shadow = frame:CreateShadow(length, pass)
		if not pass then
			shadow = frame.shadow
		end
	else
		shadow = CreateLocalShadow(frame, length, pass)
	end
	ElvUI_EltreumUI:ShadowColor(shadow, shadowDB, needsLowering)
	return shadow
end

--public shadow helper used by other modules
function ElvUI_EltreumUI:CreateFastShadow(target, length, shadowDB, needsLowering, pass)
	return AddShadow(target, length, shadowDB, needsLowering, pass)
end

--anchor shadow around one or two frames
local function AnchorShadow(shadow, topLeft, bottomRight, left, top, right, bottom)
	shadow:ClearAllPoints()
	shadow:SetPoint("TOPLEFT", topLeft, "TOPLEFT", -left, top or left)
	shadow:SetPoint("BOTTOMRIGHT", bottomRight or topLeft, "BOTTOMRIGHT", right or left, -(bottom or top or left))
end

--anchor all four shadow corners to top and bottom frames
local function AnchorShadowCorners(shadow, topFrame, bottomFrame, left, top, right, bottom)
	local topOffset = top or left
	local rightOffset = right or left
	local bottomOffset = bottom or topOffset
	local bottomTarget = bottomFrame or topFrame
	shadow:ClearAllPoints()
	shadow:SetPoint("TOPLEFT", topFrame, "TOPLEFT", -left, topOffset)
	shadow:SetPoint("TOPRIGHT", topFrame, "TOPRIGHT", rightOffset, topOffset)
	shadow:SetPoint("BOTTOMLEFT", bottomTarget, "BOTTOMLEFT", -left, -bottomOffset)
	shadow:SetPoint("BOTTOMRIGHT", bottomTarget, "BOTTOMRIGHT", rightOffset, -bottomOffset)
end

--anchor shadow horizontally across two frames while matching height to one
local function AnchorHorizontalShadow(shadow, leftFrame, rightFrame, heightTarget, length)
	shadow:ClearAllPoints()
	shadow:SetPoint("LEFT", leftFrame, "LEFT", -length, 0)
	shadow:SetPoint("RIGHT", rightFrame, "RIGHT", length, 0)
	shadow:SetPoint("TOP", heightTarget, "TOP", 0, length)
	shadow:SetPoint("BOTTOM", heightTarget, "BOTTOM", 0, -length)
end

--add shadows to child backdrops
local function ShadowChildren(length, shadowDB, requireShown, child, ...)
	if not child then return end
	local backdrop = child.backdrop
	if backdrop and (not requireShown or backdrop:IsShown()) then
		AddShadow(backdrop, length, shadowDB)
	end
	return ShadowChildren(length, shadowDB, requireShown, ...)
end

--shadow weakauras options when windtools skins it
local function SkinWeakAurasOptions(length, shadowDB)
	if IsAddOnLoaded("ElvUI_WindTools") and E.private.WT.skins.addons.weakAuras then
		E:Delay(0, function()
			local db = shadowDB or E.db.ElvUI_EltreumUI.skins.shadow
			AddShadow(_G["WeakAurasOptions"], length or db.length, db)
		end)
	end
end

--blizzard addons
local blizzShadowData = {
	["Blizzard_DamageMeter"] = {
		backdrops = { "DamageMeterSessionWindow1" },
	},
	["Blizzard_Transmog"] = {
		frames = { "TransmogFrame" },
	},
	["Blizzard_HousingCornerstone"] = {
		frames = { "HousingCornerstoneVisitorFrame", "HousingCornerstoneHouseInfoFrame" },
	},
	["Blizzard_HousingHouseSettings"] = {
		frames = { "HousingHouseSettingsFrame" },
	},
	["Blizzard_HousingHouseFinder"] = {
		frames = { "HouseFinderFrame" },
	},
	["Blizzard_HousingModelPreview"] = {
		frames = { "HousingModelPreviewFrame" },
	},
	["Blizzard_HousingDashboard"] = {
		frames = { "HousingDashboardFrame" },
	},
	["Blizzard_DelvesDifficultyPicker"] = {
		frames = { "DelvesDifficultyPickerFrame" },
	},
	["Blizzard_ProfessionsBook"] = {
		frames = { "ProfessionsBookFrame" },
	},
	["Blizzard_ScrappingMachineUI"] = {
		frames = { "ScrappingMachineFrame" },
	},
	["Blizzard_EngravingUI"] = {
		backdrops = { "EngravingFrame" },
	},
	["Blizzard_BattlefieldMap"] = {
		backdrops = { "BattleFieldFrame", "BattlefieldMapFrame", "BattlefieldMapTab" },
	},
	["Blizzard_ArtifactUI"] = {
		frames = { "ArtifactFrame" },
		tabs = { "ArtifactFrameTab", 2 },
	},
	["Blizzard_GenericTraitUI"] = {
		frames = { "GenericTraitFrame" },
	},
	["Blizzard_TalkingHeadUI"] = {
		frames = { "TalkingHeadFrame" },
	},
	["Blizzard_ItemInteractionUI"] = {
		frames = { "ItemInteractionFrame" },
	},
	["Blizzard_OrderHallUI"] = {
		frames = { "OrderHallCommandBar", "OrderHallTalentFrame" },
	},
	["Blizzard_DeathRecap"] = {
		frames = { "DeathRecapFrame" },
	},
	["Blizzard_FlightMap"] = {
		frames = { "FlightMapFrame" },
	},
	["Blizzard_ItemSocketingUI"] = {
		frames = { "ItemSocketingFrame" },
	},
	["Blizzard_ItemUpgradeUI"] = {
		frames = { "ItemUpgradeFrame" },
	},
	["Blizzard_ChromieTimeUI"] = {
		frames = { "ChromieTimeFrame" },
	},
	["Blizzard_BlackMarketUI"] = {
		frames = { "BlackMarketFrame" },
	},
	["Blizzard_BindingUI"] = {
		frames = { "KeyBindingFrame" },
	},
	["Blizzard_Calendar"] = {
		frames = { "CalendarFrame", "CalendarViewHolidayFrame", "CalendarContextMenu", "CalendarCreateEventFrame" },
	},
	["Blizzard_GuildControlUI"] = {
		frames = { "CommunitiesGuildLogFrame", "GuildControlUI" },
	},
	["Blizzard_CovenantSanctum"] = {
		frames = { "CovenantSanctumFrame" },
	},
	["Blizzard_Soulbinds"] = {
		frames = { "SoulbindViewer" },
	},
	["Blizzard_Collections"] = {
		frames = { "CollectionsJournal", "ToyBox", "HeirloomsJournal", "PetJournal", "WardrobeFrame", "WardrobeOutfitEditFrame" },
		tabs = { "CollectionsJournalTab", 6 },
	},
	["Blizzard_ReforgingUI"] = {
		frames = { "ReforgingFrame" },
	},
	["Blizzard_ChallengesUI"] = {
		frames = { "PVEFrame", "ChallengesKeystoneFrame" },
	},
	["Blizzard_WeeklyRewards"] = {
		frames = { "WeeklyRewardsFrame" },
	},
	["Blizzard_AuctionHouseUI"] = {
		backdrops = { "AuctionHouseFrameBuyTab", "AuctionHouseFrameSellTab", "AuctionHouseFrameAuctionsTab" },
		frames = { "AuctionHouseFrame" },
	},
	["Blizzard_AuctionUI"] = {
		backdrops = { "AuctionFrame" },
		tabs = { "AuctionFrameTab", 3 },
	},
}

local function ApplyBlizzShadowData(entry, len, shadowDB)
	if entry.frames then
		for i = 1, #entry.frames do
			AddShadow(_G[entry.frames[i]], len, shadowDB)
		end
	end
	if entry.backdrops then
		for i = 1, #entry.backdrops do
			local f = _G[entry.backdrops[i]]
			if f then
				AddShadow(f.backdrop, len, shadowDB)
			end
		end
	end
	if entry.tabs then
		local prefix, count = entry.tabs[1], entry.tabs[2]
		for i = 1, count do
			local tab = _G[prefix..i]
			if tab then
				AddShadow(tab.backdrop, len, shadowDB)
			end
		end
	end
end

local blizzShadowHandlers = {
	["Blizzard_SwingTimer"] = function(len, shadowDB)
		if E.private.skins.blizzard.swingTimer then
			local main = _G.SwingTimerMainHandFrame
			if main and main.StatusBar then
				AddShadow(main.StatusBar.backdrop or main.StatusBar, len, shadowDB)
			end
			local off = _G.SwingTimerOffHandFrame
			if off and off.StatusBar then
				AddShadow(off.StatusBar.backdrop or off.StatusBar, len, shadowDB)
			end
			local ranged = _G.SwingTimerRangedFrame
			if ranged and ranged.StatusBar then
				AddShadow(ranged.StatusBar.backdrop or ranged.StatusBar, len, shadowDB)
			end
		end
	end,
	["Blizzard_HousingBulletinBoard"] = function(len, shadowDB)
		local frame = _G.HousingBulletinBoardFrame
		if frame and not frame.shadow then
			local shadow = AddShadow(frame, len, shadowDB)
			--the actual backdrop is the Background and its a texture so i need to do this instead
			if frame.Background then
				shadow:SetPoint("TOPLEFT", frame.Background, "TOPLEFT", -len, len)
				shadow:SetPoint("BOTTOMRIGHT", frame.Background, "BOTTOMRIGHT", len, -len)
			end
		end
	end,
	["Blizzard_HouseEditor"] = function(len, shadowDB)
		local frame = _G.HouseEditorFrame
		if frame then
			AddShadow(frame, len, shadowDB)
			if frame.StoragePanel then
				AddShadow(frame.StoragePanel, len, shadowDB)
				if frame.StoragePanel.TabSystem then
					ShadowChildren(len, shadowDB, false, frame.StoragePanel.TabSystem:GetChildren())
				end
			end
		end
	end,
	["Blizzard_PlayerSpells"] = function(len, shadowDB)
		local frame = _G.PlayerSpellsFrame
		if frame then
			AddShadow(frame, len, shadowDB)
			if frame.TabSystem then
				ShadowChildren(len, shadowDB, false, frame.TabSystem:GetChildren())
			end
		end
		AddShadow(_G.HeroTalentsSelectionDialog, len, shadowDB)
	end,
	["Blizzard_AdventureMap"] = function(len, shadowDB)
		local dialog = _G.AdventureMapQuestChoiceDialog
		if dialog then
			AddShadow(dialog.backdrop, len, shadowDB, true)
		end
	end,
	["Blizzard_PerksProgram"] = function(len, shadowDB)
		local perks = _G.PerksProgramFrame
		if not perks then return end
		local products = perks.ProductsFrame
		if products then
			AddShadow(products.PerksProgramProductDetailsContainerFrame, len, shadowDB)
			AddShadow(products.PerksProgramFilter, len, shadowDB)
			AddShadow(products.ProductsScrollBoxContainer, len, shadowDB)
			local currency = products.PerksProgramCurrencyFrame
			if currency and not currency.shadow then
				local shadow = AddShadow(currency, len, shadowDB)
				AnchorShadow(shadow, currency.Icon, currency.Icon, len, len)
			end
		end
		local footer = perks.FooterFrame
		if footer then
			AddShadow(footer.PurchaseButton, len, shadowDB)
			AddShadow(footer.AddToCartButton, len, shadowDB)
			AddShadow(footer.ViewCartButton, len, shadowDB)
			if footer.ToggleHideArmor then
				AddShadow(footer.ToggleHideArmor.backdrop, len, shadowDB)
			end
			AddShadow(footer.LeaveButton, len, shadowDB)
			if footer.ToggleAttackAnimation then
				AddShadow(footer.ToggleAttackAnimation.backdrop, len, shadowDB)
			end
			if footer.ToggleMountSpecial then
				AddShadow(footer.ToggleMountSpecial.backdrop, len, shadowDB)
			end
			local rotate = footer.RotateButtonContainer
			if rotate then
				AddShadow(rotate.RotateRightButton, len, shadowDB)
				AddShadow(rotate.RotateLeftButton, len, shadowDB)
				if footer.TogglePlayerPreview then
					AddShadow(footer.TogglePlayerPreview.backdrop, len, shadowDB)
				end
			end
		end
	end,
	["Blizzard_ProfessionsCustomerOrders"] = function(len, shadowDB)
		local frame = _G.ProfessionsCustomerOrdersFrame
		AddShadow(frame, len, shadowDB)
		if _G.ProfessionsCustomerOrdersFrameBrowseTab then
			AddShadow(_G.ProfessionsCustomerOrdersFrameBrowseTab.backdrop, len, shadowDB)
		end
		if _G.ProfessionsCustomerOrdersFrameOrdersTab then
			AddShadow(_G.ProfessionsCustomerOrdersFrameOrdersTab.backdrop, len, shadowDB)
		end
		if frame and frame.Form then
			AddShadow(frame.Form.QualityDialog, len, shadowDB)
		end
	end,
	["Blizzard_ClassTalentUI"] = function(len, shadowDB)
		local frame = _G.ClassTalentFrame
		if frame and not frame.shadow then
			AddShadow(frame, len, shadowDB)
			if frame.TabSystem then
				ShadowChildren(len, shadowDB, false, frame.TabSystem:GetChildren())
			end
		end
		AddShadow(_G.ClassTalentLoadoutImportDialog, len, shadowDB)
	end,
	["Blizzard_ArchaeologyUI"] = function(len, shadowDB)
		if _G.ArcheologyDigsiteProgressBar then
			AddShadow(_G.ArcheologyDigsiteProgressBar.FillBar, len, shadowDB)
		end
		AddShadow(_G.ArchaeologyFrame, len, shadowDB)
	end,
	["Blizzard_MacroUI"] = function(len, shadowDB)
		local frame = _G.MacroFrame
		if not frame then return end
		if E.Modern or E.Mists or E.TBC or E.Wrath then
			AddShadow(frame, len, shadowDB)
		elseif E.Classic then
			AddShadow(frame.backdrop, len, shadowDB)
		end
	end,
	["Blizzard_GuildBankUI"] = function(len, shadowDB)
		local frame = _G.GuildBankFrame
		if E.Modern or E.Mists or E.TBC or E.Wrath then
			if E.Modern then
				AddShadow(frame, len, shadowDB)
			elseif frame then
				AddShadow(frame.backdrop, len, shadowDB)
			end
			for i = 1, 6 do
				local tab = _G["GuildBankTab"..i]
				if tab then
					AddShadow(tab.Button, len, shadowDB)
				end
			end
			for i = 1, 4 do
				local tab = _G["GuildBankFrameTab"..i]
				if tab then
					AddShadow(tab.backdrop, len, shadowDB)
				end
			end
		elseif frame then
			AddShadow(frame.backdrop, len, shadowDB)
		end
	end,
	["Blizzard_TrainerUI"] = function(len, shadowDB)
		local frame = _G.ClassTrainerFrame
		if frame then
			AddShadow(E.Modern and frame or frame.backdrop, len, shadowDB)
		end
	end,
	["Blizzard_TradeSkillUI"] = function(len, shadowDB)
		local frame = _G.TradeSkillFrame
		if frame then
			AddShadow(E.Modern and frame or frame.backdrop, len, shadowDB)
		end
	end,
	["Blizzard_InspectUI"] = function(len, shadowDB)
		local inspect = _G.InspectFrame
		AddShadow(inspect, len, shadowDB)
		for i = 1, 4 do
			local tab = _G["InspectFrameTab"..i]
			if tab then
				AddShadow(tab.backdrop, len, shadowDB)
			end
		end
		if IsAddOnLoaded("ElvUI_WindTools") and E.db.WT.item.inspect.inspect and inspect and not inspect.EltruismShadowHooked then
			inspect:HookScript("OnShow", function()
				E:Delay(1, function()
					local db = E.db.ElvUI_EltreumUI.skins.shadow
					local shadowLength = db.length
					if inspect.inspectFrame then
						AddShadow(inspect.inspectFrame, shadowLength, db)
						AddShadow(inspect.inspectFrame.statsFrame, shadowLength, db)
						AddShadow(inspect.inspectFrame.inspectFrame, shadowLength, db)
					end
				end)
			end)
			inspect.EltruismShadowHooked = true
		end
	end,
	["Blizzard_TalentUI"] = function(len, shadowDB)
		local frame = _G.PlayerTalentFrame
		if E.Modern then
			AddShadow(frame, len, shadowDB)
		else
			if frame then
				AddShadow(frame.backdrop or frame, len, shadowDB)
			end
			for i = 3, 4 do
				local tab = _G["PlayerTalentFrameTab"..i]
				if tab then
					AddShadow(tab.backdrop, len, shadowDB)
				end
			end
			AddShadow(_G.PlayerSpecTab1, len, shadowDB)
			AddShadow(_G.PlayerSpecTab2, len, shadowDB)
		end
		for i = 1, 2 do
			local tab = _G["PlayerTalentFrameTab"..i]
			if tab then
				AddShadow(tab.backdrop, len, shadowDB)
			end
		end
	end,
	["Blizzard_Communities"] = function(len, shadowDB)
		local communities = _G.CommunitiesFrame
		if not communities then return end
		AddShadow(communities, len, shadowDB)
		for i = 1, 5 do
			local tab = _G["CommunitiesFrameTab"..i]
			if tab then
				AddShadow(tab.backdrop, len, shadowDB)
			end
		end
		if communities.ChatTab then AddShadow(communities.ChatTab.backdrop, len, shadowDB) end
		if communities.RosterTab then AddShadow(communities.RosterTab.backdrop, len, shadowDB) end
		if communities.GuildBenefitsTab then AddShadow(communities.GuildBenefitsTab.backdrop, len, shadowDB) end
		if communities.GuildInfoTab then AddShadow(communities.GuildInfoTab.backdrop, len, shadowDB) end
		AddShadow(communities.GuildMemberDetailFrame, len, shadowDB)
		AddShadow(communities.RecruitmentDialog, len, shadowDB)
		local guildFinder = _G.ClubFinderGuildFinderFrame
		if guildFinder then
			if guildFinder.ClubFinderSearchTab then AddShadow(guildFinder.ClubFinderSearchTab.backdrop, len, shadowDB) end
			if guildFinder.ClubFinderPendingTab then AddShadow(guildFinder.ClubFinderPendingTab.backdrop, len, shadowDB) end
		end
		local commFinder = _G.ClubFinderCommunityAndGuildFinderFrame
		if commFinder then
			if commFinder.ClubFinderSearchTab then AddShadow(commFinder.ClubFinderSearchTab.backdrop, len, shadowDB) end
			if commFinder.ClubFinderPendingTab then AddShadow(commFinder.ClubFinderPendingTab.backdrop, len, shadowDB) end
		end
	end,
	["Blizzard_AchievementUI"] = function(len, shadowDB)
		local achievementFrame = _G.AchievementFrame
		if E.Modern or E.Mists or E.Wrath then
			if achievementFrame then
				AddShadow(achievementFrame.backdrop or achievementFrame, len, shadowDB)
				if achievementFrame.SearchPreviewContainer then AddShadow(achievementFrame.SearchPreviewContainer.backdrop, len, shadowDB) end
				if achievementFrame.SearchResults then AddShadow(achievementFrame.SearchResults.backdrop, len, shadowDB) end
			end
			if _G.AchievementFrameTab3 then
				AddShadow(_G.AchievementFrameTab3.backdrop, len, shadowDB)
			end
		elseif achievementFrame then
			AddShadow(achievementFrame.backdrop, len, shadowDB)
		end
		if _G.AchievementFrameTab1 then AddShadow(_G.AchievementFrameTab1.backdrop, len, shadowDB) end
		if _G.AchievementFrameTab2 then AddShadow(_G.AchievementFrameTab2.backdrop, len, shadowDB) end
	end,
	["Blizzard_GarrisonUI"] = function(len, shadowDB)
		AddShadow(_G.GarrisonLandingPage, len, shadowDB)
		for i = 1, 3 do
			local tab = _G["GarrisonLandingPageTab"..i]
			if tab then
				AddShadow(tab.backdrop, len, shadowDB)
			end
		end
		if _G.CovenantMissionFrame then
			AddShadow(_G.CovenantMissionFrame, len, shadowDB)
			if _G.CovenantMissionFrameTab1 then AddShadow(_G.CovenantMissionFrameTab1.backdrop, len, shadowDB) end
			if _G.CovenantMissionFrameTab2 then AddShadow(_G.CovenantMissionFrameTab2.backdrop, len, shadowDB) end
		end
	end,
	["Blizzard_PlayerChoice"] = function(len, shadowDB)
		local frame = _G.PlayerChoiceFrame
		if frame and not frame.shadow then
			frame:CreateBackdrop('Transparent')
			AddShadow(frame, len, shadowDB)
		end
	end,
	["Blizzard_VoidStorageUI"] = function(len, shadowDB)
		local frame = _G.VoidStorageFrame
		if frame then
			AddShadow(frame, len, shadowDB)
			AddShadow(frame.Page1, len, shadowDB)
			AddShadow(frame.Page2, len, shadowDB)
		end
	end,
	["Blizzard_Professions"] = function(len, shadowDB)
		local frame = _G.ProfessionsFrame
		if not frame then return end
		if not frame.shadow then
			AddShadow(frame, len, shadowDB)
			if E.Forever then
				local overview = frame.ProfessionsOverviewTab
				if overview then
					AddShadow(overview.backdrop or overview, len, shadowDB)
				end
				for i = 1, 6 do
					local tab = frame["Professions"..i.."Tab"]
					if tab then
						AddShadow(tab.backdrop or tab, len, shadowDB)
					end
				end
			end
		end
		if frame.TabSystem then
			ShadowChildren(len, shadowDB, false, frame.TabSystem:GetChildren())
			if frame.CraftingPage then
				AddShadow(frame.CraftingPage.CraftingOutputLog, len, shadowDB)
			end
		end
	end,
	["Blizzard_EncounterJournal"] = function(len, shadowDB)
		local overflow = _G.EncounterJournalNavBarOverflowButton
		if overflow and not overflow.EltruismSkin then
			local S = E:GetModule('Skins')
			S:HandleButton(overflow)
			overflow.EltruismSkin = true
			local arrow = overflow:CreateTexture()
			arrow:SetTexture(E.Media.Textures.ArrowUp)
			arrow:SetRotation(1.57)
			arrow:SetScale(0.7)
			arrow:SetPoint("CENTER", overflow, "CENTER", 0, 0)
			overflow.EltruismArrow = arrow
		end
		local journal = _G.EncounterJournal
		AddShadow(journal, len, shadowDB)
		local ejTabNames = {
			"EncounterJournalSuggestTab",
			"EncounterJournalDungeonTab",
			"EncounterJournalRaidTab",
			"EncounterJournalLootJournalTab",
			"EncounterJournalEncounterFrameInfoOverviewTab",
			"EncounterJournalEncounterFrameInfoLootTab",
			"EncounterJournalEncounterFrameInfoBossTab",
			"EncounterJournalEncounterFrameInfoModelTab",
			"EncounterJournalMonthlyActivitiesTab",
		}
		for i = 1, #ejTabNames do
			local tab = _G[ejTabNames[i]]
			if tab then
				AddShadow(tab.backdrop, len, shadowDB)
			end
		end
		if journal and journal.TutorialsTab then
			AddShadow(journal.TutorialsTab.backdrop, len, shadowDB)
		end
	end,
	["Blizzard_LegacySystem"] = function(len, shadowDB)
		local frame = _G.LegacySystemFrame
		if frame and not frame.shadow then
			AddShadow(frame, len, shadowDB)
			if frame.Tabs then
				for _, tab in ipairs(frame.Tabs) do
					if tab then
						AddShadow(tab.backdrop or tab, len, shadowDB)
					end
				end
			end
		end
	end,
}

--split so it can be fired and the IsAddOnLoaded checks work
local function BlizzShadows(arg, len, shadowDB)
	if not shadowDB then
		shadowDB = E.db.ElvUI_EltreumUI.skins.shadow
		len = shadowDB.length
	end
	if arg then
		if arg == "WeakAurasOptions" then
			SkinWeakAurasOptions(len, shadowDB)
		elseif E.private.skins.blizzard.enable then
			local data = blizzShadowData[arg]
			if data then
				ApplyBlizzShadowData(data, len, shadowDB)
			else
				local handler = blizzShadowHandlers[arg]
				if handler then
					handler(len, shadowDB)
				end
			end
		end
	else
		if IsAddOnLoaded("WeakAurasOptions") then
			SkinWeakAurasOptions(len, shadowDB)
		end
		if E.private.skins.blizzard.enable then
			for addonName, data in pairs(blizzShadowData) do
				if IsAddOnLoaded(addonName) then
					ApplyBlizzShadowData(data, len, shadowDB)
				end
			end
			for addonName, handler in pairs(blizzShadowHandlers) do
				if IsAddOnLoaded(addonName) then
					handler(len, shadowDB)
				end
			end
		end
	end
end

--frame lists for shadows
local blizzardFrameNames = {
	"AddFriendFrame", "AddonCompartmentFrame", "AddonList", "AutoCompleteBox",
	"BNToastFrame", "BonusRollFrame", "ChannelFrame", "CharacterFrame",
	"CharacterFrameTab1", "CharacterFrameTab2", "CharacterFrameTab3", "CharacterFrameTab4", "CharacterFrameTab5",
	"CharacterFrameModeTab1", "CharacterFrameModeTab2", "CharacterFrameModeTab3",
	"CharacterFrameModeTab4", "CharacterFrameModeTab5", "CharacterFrameModeTab6",
	"ChatConfigFrame", "ChatFrame1EditBox", "CinematicFrameCloseDialog", "CliqueSpellTab",
	"CollectionsJournal", "ColorPickerFrame", "CopyChatFrame", "CovenantPreviewFrame",
	"DressUpFrame", "DropDownList1", "DropDownList2", "EditModeManagerFrame",
	"EltruismClickCastingToggle", "EmbeddedItemTooltip", "EquipmentFlyoutFrameButtons",
	"ExtraActionButton1", "ExtraActionButton2", "ExtraActionButton3",
	"FriendsFrame", "FriendsFrameTab1", "FriendsFrameTab2", "FriendsFrameTab3", "FriendsFrameTab4", "FriendsFrameTab5",
	"FriendsTooltip", "GhostFrameContentsFrame", "GossipFrame", "GroupLootHistoryFrame",
	"GuildInfoFrame", "HelpFrame", "InterfaceOptionsFrame",
	"ItemRefShoppingTooltip1", "ItemRefShoppingTooltip2", "ItemRefTooltip", "ItemTextFrame",
	"LFDReadyCheckPopup", "LFDRoleCheckPopup", "LFGBrowseFrame", "LFGDungeonReadyStatus",
	"LFGInvitePopup", "LFGListApplicationDialog", "LFGListCreateRoleDialog", "LFGListingFrame", "LFGListInviteDialog",
	"LFGParentFrameTab1", "LFGParentFrameTab2", "LootFrame", "LossOfControlFrame",
	"MailFrame", "MailFrameTab1", "MailFrameTab2", "MajorFactionRenownFrame",
	"MerchantFrame", "MerchantFrameTab1", "MerchantFrameTab2", "MinimapRightClickMenu",
	"MirrorTimer1StatusBar", "MirrorTimer2StatusBar", "MirrorTimer3StatusBar",
	"OpacityFrame", "OpenMailFrame", "OrderHallCommandBar", "OrderHallMissionFrame",
	"PetStableFrame", "ProfessionsFrame", "PVEFrame",
	"PVEFrameTab1", "PVEFrameTab2", "PVEFrameTab3", "PVEFrameTab4",
	"PVPFrameTab1", "PVPFrameTab2", "PVPFrameTab3", "PVPMatchResults", "PVPMatchScoreboard",
	"PVPParentFrameTab1", "PVPParentFrameTab2", "PVPReadyDialog",
	"QuestFrame", "QuestLogDetailFrame", "QuestLogFrame", "QuestModelScene", "QuestNPCModelTextFrame",
	"QueueStatusFrame", "QuickKeybindTooltip", "RaidInfoFrame",
	"RaidUtilityPanel", "RaidUtility_CloseButton", "RaidUtility_ShowButton", "RaidUtilityTargetIcons", "RaidUtilityRoleIcons",
	"ReadyCheckFrame", "ReadyStatus", "RecruitAFriendRecruitmentFrame", "RecruitAFriendRewardsFrame",
	"ReportFrame", "ReputationDetailFrame", "ReputationParagonTooltip", "RolePollPopup",
	"SettingsPanel", "ShoppingTooltip1", "ShoppingTooltip2",
	"SpellBookFrame", "SpellBookFrameTabButton1", "SpellBookFrameTabButton2", "SpellBookFrameTabButton3", "SpellBookFrameTabButton4", "SpellBookFrameTabButton5",
	"SpellBookSkillLineTab1", "SpellBookSkillLineTab2", "SpellBookSkillLineTab3", "SpellBookSkillLineTab4", "SpellBookSkillLineTab5",
	"StableFrame", "StackSplitFrame",
	"StaticPopup1", "StaticPopup2", "StaticPopup3", "StaticPopup4", "StaticPopup5",
	"StopwatchFrame", "SubscriptionInterstitialFrame", "TabardFrame", "TaxiFrame",
	"TicketStatusFrameButton", "TimeAlertFrame", "TimeManagerFrame",
	"TimerTrackerTimer1StatusBar", "TimerTrackerTimer2StatusBar", "TimerTrackerTimer3StatusBar",
	"TokenFramePopup", "TradeFrame", "VideoOptionsFrame", "VoidStorageFrame",
	"WardrobeFrame", "WeeklyRewardsFrame", "WorldMapTooltip",
	"WorldStateScoreFrame", "WorldStateScoreFrameTab1", "WorldStateScoreFrameTab2", "WorldStateScoreFrameTab3",
	"ZoneAbilityFrame", "GameMenuFrame",
	"DelvesCompanionConfigurationFrame", "DelvesCompanionAbilityListFrame",
	"GuildInviteFrame", "CurrencyTransferMenu", "CurrencyTransferLog",
	"PlayerSpellsFrame", "QuestTimerFrame", "CooldownViewerSettings", "SocialUIFrame",
}

local generalElvUIFrameNames = {
	"ElvLootFrame", "ElvUI_ReputationBar", "ElvUI_ExperienceBar", "ElvUI_ThreatBar",
	"ElvUIVendorGraysFrame", "ElvUI_ContainerFrameContainerHolder", "ElvUI_AltPowerBar",
	"ElvUISpellBookTooltip", "ElvUIConfigTooltip", "ElvUIAceConfigDialogTooltip",
	"ElvUIPetBattleActionBar", "ElvUI_TopPanel", "ElvUI_BottomPanel", "ElvUI_CopyChatFrame",
}

local microbarButtonNames = {
	"CharacterMicroButton", "SpellbookMicroButton", "TalentMicroButton", "QuestLogMicroButton",
	"SocialsMicroButton", "MainMenuMicroButton", "HelpMicroButton", "LFGMicroButton",
	"WorldMapMicroButton", "AchievementMicroButton", "GuildMicroButton", "LFDMicroButton",
	"EJMicroButton", "CollectionsMicroButton", "StoreMicroButton",
}

local unitframeBorderShadowPairs = {
	{ "ElvUF_Player_HealthBar", "playerborder" },
	{ "ElvUF_Player_PowerBar", "playerpower" },
	{ "ElvUF_Pet_HealthBar", "petborder" },
	{ "ElvUF_Pet_PowerBar", "petpower" },
	{ "ElvUF_Target_HealthBar", "targetborder" },
	{ "ElvUF_Target_PowerBar", "targetpower" },
	{ "ElvUF_TargetTarget_HealthBar", "targettargetborder" },
	{ "ElvUF_TargetTarget_PowerBar", "targettargetpower" },
	{ "ElvUF_Focus_HealthBar", "focusborder" },
	{ "ElvUF_Focus_PowerBar", "focuspower" },
	{ "ElvUF_Player_Stagger", "staggerclassbar" },
	{ "ElvUF_Player_CastBar", "playercastborder" },
	{ "ElvUF_Target_CastBar", "targetcastborder" },
	{ "ElvUF_Focus_CastBar", "focuscastborder" },
}

local unitframeExtraShadowFrames = {
	"ElvUF_TargetTargetTarget_HealthBar", "ElvUF_TargetTargetTarget_PowerBar",
	"ElvUF_FocusTarget_HealthBar", "ElvUF_FocusTarget_PowerBar",
	"ElvUF_Arena1", "ElvUF_Arena2", "ElvUF_Arena3", "ElvUF_Arena4", "ElvUF_Arena5",
	"ElvUF_Player_EclipsePowerBar",
}

local spellbookFrameNames = {
	"SpellBookFrame", "SpellBookFrameTabButton1", "SpellBookFrameTabButton2", "SpellBookFrameTabButton3",
	"SpellBookFrameTabButton4", "SpellBookFrameTabButton5", "SpellBookSkillLineTab1",
	"SpellBookSkillLineTab2", "SpellBookSkillLineTab3", "SpellBookSkillLineTab4", "SpellBookSkillLineTab5",
}

local function ShadowBlizzardTarget(frame, len, shadowDB)
	if frame then
		AddShadow(frame.backdrop or frame, len, shadowDB)
	end
end

local function ShadowBlizzardNestedFrames(len, shadowDB)
	if _G.DressUpFrame then
		ShadowBlizzardTarget(_G.DressUpFrame.OutfitDetailsPanel, len, shadowDB)
		ShadowBlizzardTarget(_G.DressUpFrame.SetSelectionPanel, len, shadowDB)
	end
	if _G.ExpansionLandingPage and _G.ExpansionLandingPage.Overlay then
		ShadowBlizzardTarget(_G.ExpansionLandingPage.Overlay.WarWithinLandingOverlay, len, shadowDB)
		ShadowBlizzardTarget(_G.ExpansionLandingPage.Overlay.DragonflightLandingOverlay, len, shadowDB)
	end
	if _G.FriendsFrame then
		ShadowBlizzardTarget(_G.FriendsFrame.IgnoreListWindow, len, shadowDB)
	end
	if _G.FriendsFrameBattlenetFrame then
		ShadowBlizzardTarget(_G.FriendsFrameBattlenetFrame.BroadcastFrame, len, shadowDB)
	end
	if _G.GroupLootHistoryFrame then
		ShadowBlizzardTarget(_G.GroupLootHistoryFrame.ResizeButton, len, shadowDB)
	end
	if _G.LFGDungeonReadyDialog then
		ShadowBlizzardTarget(_G.LFGDungeonReadyDialog.Border, len, shadowDB)
	end
	if _G.LFGParentFrame then
		ShadowBlizzardTarget(_G.LFGParentFrame.ListingTab, len, shadowDB)
		ShadowBlizzardTarget(_G.LFGParentFrame.BrowsingTab, len, shadowDB)
		ShadowBlizzardTarget(_G.LFGParentFrame.WhoListingTab, len, shadowDB)
	end
	if _G.LootHistoryFrame then
		ShadowBlizzardTarget(_G.LootHistoryFrame.ResizeButton, len, shadowDB)
	end
	if _G.MovieFrame then
		ShadowBlizzardTarget(_G.MovieFrame.CloseDialog, len, shadowDB)
	end
	if not E.TBC then
		ShadowBlizzardTarget(_G.PVPFrame, len, shadowDB)
	end
	if _G.QuestModelScene then
		ShadowBlizzardTarget(_G.QuestModelScene.ModelTextFrame, len, shadowDB)
	end
	if E.Modern then
		if _G.WorldMapFrame then
			ShadowBlizzardTarget(_G.WorldMapFrame, len, shadowDB)
			if _G.QuestMapFrame then
				ShadowBlizzardTarget(_G.QuestMapFrame.QuestsTab, len, shadowDB)
				ShadowBlizzardTarget(_G.QuestMapFrame.MapLegendTab, len, shadowDB)
				ShadowBlizzardTarget(_G.QuestMapFrame.EventsTab, len, shadowDB)
			end
		end
	elseif _G.WorldMapFrame then
		ShadowBlizzardTarget(_G.WorldMapFrame.BorderFrame, len, shadowDB)
		ShadowBlizzardTarget(_G.WorldMapFrame.MiniBorderFrame, len, shadowDB)
	end
	if _G.CooldownViewerSettings then
		if _G.CooldownViewerSettings.SpellsTab then
			ShadowBlizzardTarget(_G.CooldownViewerSettings.SpellsTab.backdrop, len, shadowDB)
		end
		if _G.CooldownViewerSettings.AurasTab then
			ShadowBlizzardTarget(_G.CooldownViewerSettings.AurasTab.backdrop, len, shadowDB)
		end
	end
end

local function ApplyStandardUnitPowerShadow(unitKey, prefix, isTargetStyle, benikDetached, len, shadowDB)
	local unitDB = E.db.unitframe.units[unitKey]
	local powerDB = unitDB.power
	if powerDB.width == "spaced" or not powerDB.enable then return end

	local frame = _G[prefix]
	local health = _G[prefix.."_HealthBar"]
	local power = _G[prefix.."_PowerBar"]

	if not powerDB.detachFromFrame then
		if not (powerDB.width == "offset" and powerDB.offset > 0) then
			if power and power.shadow then
				power.shadow:Hide()
			end
		end
		if health and health.shadow then
			health.shadow:Hide()
		end
		AddShadow(frame, len, shadowDB)
		if not (frame and frame.shadow) then return end

		if unitDB.portrait.enable and unitDB.portrait.style ~= "3D" and not benikDetached then
			if isTargetStyle then
				if powerDB.width == "offset" and powerDB.offset ~= 0 then
					if unitDB.orientation == "LEFT" then
						frame.shadow:SetPoint("BOTTOMLEFT", frame.Portrait, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", health, "TOPRIGHT", len, len)
					elseif unitDB.orientation == "RIGHT" then
						frame.shadow:SetPoint("BOTTOMLEFT", health, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", len, len)
					else
						frame.shadow:SetPoint("BOTTOMLEFT", health, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", health, "TOPRIGHT", len, len)
					end
				else
					if unitDB.orientation == "LEFT" then
						frame.shadow:SetPoint("BOTTOMLEFT", frame.Portrait, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", len, len)
					elseif unitDB.orientation == "RIGHT" then
						frame.shadow:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", len, len)
					else
						frame.shadow:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", len, len)
					end
				end
			else
				frame.shadow:SetPoint("BOTTOMLEFT", frame.Portrait, "BOTTOMLEFT", -len, -len)
				frame.shadow:SetPoint("TOPLEFT", frame.Portrait, "TOPLEFT", -len, len)
			end
		else
			if powerDB.width == "inset" then
				AnchorShadow(frame.shadow, health, frame, len, len)
			elseif powerDB.width == "fill" then
				AnchorShadow(frame.shadow, health, power, len, len)
			else
				local bottomTarget = (powerDB.offset == 0) and power or health
				if powerDB.offset ~= 0 and power and power.shadow then
					power.shadow:Show()
				end
				if unitDB.portrait.enable and not unitDB.portrait.overlay then
					if unitDB.orientation == "RIGHT" then
						frame.shadow:ClearAllPoints()
						frame.shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", len, len)
						frame.shadow:SetPoint("BOTTOMLEFT", power, "BOTTOMLEFT", -len, -len)
					elseif unitDB.orientation == "LEFT" then
						frame.shadow:ClearAllPoints()
						frame.shadow:SetPoint("BOTTOMLEFT", frame.Portrait, "BOTTOMLEFT", -len, -len)
						frame.shadow:SetPoint("TOPRIGHT", health, "TOPRIGHT", len, len)
					else
						AnchorShadow(frame.shadow, health, bottomTarget, len, len)
					end
				else
					AnchorShadow(frame.shadow, health, bottomTarget, len, len)
				end
			end
		end
	else
		AddShadow(frame, len, shadowDB)
		if health and health.shadow then
			health.shadow:Hide()
		end
		if frame and frame.shadow then
			AnchorShadow(frame.shadow, health, (unitKey == "target") and health or frame, len, len)
		end
	end
end

local function ApplyUnitPortraitShadow(unitKey, prefix, borderKey, hasStagger, len, shadowDB, bordersDB)
	local unitDB = E.db.unitframe.units[unitKey]
	if not (unitDB.enable and unitDB.portrait.enable and not unitDB.portrait.overlay) then return end

	local frame = _G[prefix]
	if not frame or frame.shadow then return end
	if bordersDB[borderKey] and bordersDB.borders then return end

	AddShadow(frame, len, shadowDB)
	frame.shadow:ClearAllPoints()
	local bottomAnchor = (unitDB.infoPanel.enable and frame.USE_INFO_PANEL) and _G[prefix.."_InfoPanel"] or _G[prefix.."_HealthBar"]
	if unitDB.orientation == "RIGHT" then
		frame.shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", len, len)
		frame.shadow:SetPoint("BOTTOMLEFT", bottomAnchor, "BOTTOMLEFT", -len, -len)
	elseif unitDB.orientation == "LEFT" then
		frame.shadow:SetPoint("TOPLEFT", frame.Portrait, "TOPLEFT", -len, len)
		frame.shadow:SetPoint("BOTTOMRIGHT", bottomAnchor, "BOTTOMRIGHT", len, -len)
	else
		frame.shadow:SetPoint("TOPRIGHT", _G[prefix.."_HealthBar"], "TOPRIGHT", len, len)
		frame.shadow:SetPoint("BOTTOMLEFT", bottomAnchor, "BOTTOMLEFT", -len, -len)
	end

	local health = _G[prefix.."_HealthBar"]
	if health.shadow then
		health.shadow:Hide()
	end
	if unitDB.power.width ~= "spaced" and not (unitDB.power.width == "offset" and unitDB.power.offset > 0) then
		local power = _G[prefix.."_PowerBar"]
		if power.shadow then
			power.shadow:Hide()
		end
	end
	if hasStagger and E.Modern then
		local stagger = _G[prefix.."_Stagger"]
		if stagger and stagger.shadow then
			stagger.shadow:Hide()
		end
	end
end

local function ApplyCastbarShadow(unitKey, frameName, borderKey, len, shadowDB, bordersDB)
	local unitDB = E.db.unitframe.units[unitKey]
	local cbDB = unitDB.castbar
	if not (unitDB.enable and cbDB.enable and cbDB.overlayOnFrame == "None" and cbDB.icon and not (bordersDB[borderKey] and bordersDB.borders)) then
		return
	end

	local bar = _G[frameName]
	if not (bar and bar.shadow) then return end

	if not cbDB.iconAttached then
		if cbDB.iconAttachedTo == "Castbar" and (cbDB.height == cbDB.iconSize or cbDB.iconXOffset == 0) then
			--use the shorter frame so the shadow stays flush without a gap
			local heightTarget = (cbDB.iconSize <= cbDB.height) and bar.Icon.bg or bar.backdrop
			if cbDB.iconPosition == "RIGHT" then
				AnchorHorizontalShadow(bar.shadow, bar.backdrop, bar.Icon.bg, heightTarget, len)
			else
				AnchorHorizontalShadow(bar.shadow, bar.Icon.bg, bar.backdrop, heightTarget, len)
			end
		elseif bar.Holder and not bar.Holder.shadow then
			local holderShadow = AddShadow(bar.Holder, len, shadowDB)
			AnchorShadow(holderShadow, bar.Icon, bar.Icon, len, len)
			holderShadow:SetParent(bar)
		end
	else
		if unitDB.orientation == "RIGHT" then
			AnchorHorizontalShadow(bar.shadow, bar.backdrop, bar.Icon, bar.Icon, len)
		else
			AnchorHorizontalShadow(bar.shadow, bar.Icon, bar.backdrop, bar.Icon, len)
		end
	end
	ElvUI_EltreumUI:ShadowColor(bar.shadow, shadowDB)
end

local function ApplyPartyOrBossShadows(unitKey, prefix, count, borderKey, infoOnTop, len, shadowDB, bordersDB)
	local unitDB = E.db.unitframe.units[unitKey]
	local hideForBorder = bordersDB[borderKey] and bordersDB.borders
	local powerDB = unitDB.power

	for i = 1, count do
		local frame = _G[prefix..i]
		if frame and not frame.shadow and not hideForBorder then
			local shadow = AddShadow(frame, len, shadowDB)
			local useInfoOnTop = infoOnTop and unitDB.infoPanel.enable and frame.USE_INFO_PANEL
			local anchorTop, anchorBottom
			if useInfoOnTop then
				anchorTop = frame.InfoPanel
				anchorBottom = powerDB.enable and frame.Power or frame.Health
			end

			if powerDB.enable then
				if powerDB.width == "spaced" then
					anchorBottom = frame.Health
					if not useInfoOnTop then
						anchorTop = frame.Health
					end
					AddShadow(frame.Power, len, shadowDB)
				elseif powerDB.width == "offset" and powerDB.offset >= 0 then
					AddShadow(frame.Power, len, shadowDB)
					anchorBottom = frame.Health
					if not useInfoOnTop then
						anchorTop = frame.Health
					end
				end
			end

			if anchorTop then
				AnchorShadowCorners(shadow, anchorTop, anchorBottom, len, len)
			end
		end
	end
end

local function ApplyGroupUnitShadows(prefix, count, suffix, infoOnTop, len, shadowDB)
	for i = 1, count do
		local frame = _G[prefix..i..(suffix or "")]
		if frame and not frame.shadow then
			local shadow = AddShadow(frame, len, shadowDB)
			if infoOnTop and frame.USE_INFO_PANEL and frame.InfoPanel then
				local bottomTarget = (frame.Power and frame.Power:IsShown()) and frame.Power or frame.Health
				AnchorShadowCorners(shadow, frame.InfoPanel, bottomTarget, len, len)
			end
		end
	end
end

local function ApplyPlayerPowerShadow(benikDetached, len, shadowDB)
	local playerDB = E.db.unitframe.units.player
	local powerDB = playerDB.power
	if powerDB.width == "spaced" or not powerDB.enable then return end

	local frame = _G["ElvUF_Player"]
	local health = _G["ElvUF_Player_HealthBar"]
	local power = _G["ElvUF_Player_PowerBar"]
	local classbar = _G["ElvUF_Player_ClassBar"]
	local classDB = playerDB.classbar

	if not powerDB.detachFromFrame then
		if not (powerDB.width == "offset" and powerDB.offset > 0) then
			if power and power.shadow then
				power.shadow:Hide()
			end
		end
		if health and health.shadow then
			health.shadow:Hide()
		end
		AddShadow(frame, len, shadowDB)
		if not (frame and frame.shadow) then return end

		local shadow = frame.shadow
		local hasPortrait = playerDB.portrait.enable and playerDB.portrait.style ~= "3D" and not benikDetached
		local hasNonOverlayPortrait = playerDB.portrait.enable and not playerDB.portrait.overlay

		local function AnchorPlayerOffsetPortrait()
			if powerDB.width == "inset" then
				AnchorShadow(shadow, health, frame, len, len)
				if not classDB.detachFromFrame and classbar and classbar:IsShown() then
					AnchorShadow(shadow, frame, frame, len, len - (classDB.height / 2), len, len)
				end
			elseif powerDB.width == "fill" then
				AnchorShadow(shadow, health, power, len, len)
				if not classDB.detachFromFrame and classbar and classbar:IsShown() then
					AnchorShadow(shadow, frame, frame, len, len - (classDB.height / 2), len, len)
				end
			else
				local bottomTarget = (powerDB.offset == 0) and power or health
				if powerDB.offset ~= 0 and power and power.shadow then
					power.shadow:Show()
				end
				if hasNonOverlayPortrait then
					if playerDB.orientation == "RIGHT" then
						shadow:ClearAllPoints()
						shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", len, len)
						shadow:SetPoint("BOTTOMLEFT", power, "BOTTOMLEFT", -len, -len)
					elseif playerDB.orientation == "LEFT" then
						shadow:ClearAllPoints()
						shadow:SetPoint("BOTTOMLEFT", frame.Portrait, "BOTTOMLEFT", -len, -len)
						shadow:SetPoint("TOPRIGHT", health, "TOPRIGHT", len, len)
					else
						AnchorShadow(shadow, health, bottomTarget, len, len)
					end
				else
					AnchorShadow(shadow, health, bottomTarget, len, len)
				end
			end
		end

		if classDB.enable then
			if not classDB.detachFromFrame then
				if classDB.fill == "spaced" then
					AnchorPlayerOffsetPortrait()
				else
					if powerDB.width == "inset" then
						AnchorShadow(shadow, health, frame, len, len + (classDB.height / 1.2), len, len)
						if classbar and classbar:IsShown() then
							AnchorShadow(shadow, frame, frame, len, len - (classDB.height / 2), len, len)
						end
					else
						AnchorShadow(shadow, health, power, len, len)
					end
				end
			else
				if powerDB.width == "inset" then
					AnchorShadow(shadow, health, health, len, len)
				elseif powerDB.width == "fill" then
					AnchorShadow(shadow, health, power, len, len)
				elseif powerDB.offset == 0 then
					AnchorShadow(shadow, health, power, len, len)
				else
					AnchorShadow(shadow, health, health, len, len)
					if power and power.shadow then
						power.shadow:Show()
					end
				end
			end
		else
			if hasPortrait then
				shadow:SetPoint("BOTTOMLEFT", frame.Portrait, "BOTTOMLEFT", -len, -len)
				shadow:SetPoint("TOPLEFT", frame.Portrait, "TOPLEFT", -len, len)
			else
				AnchorPlayerOffsetPortrait()
			end
		end
	else
		AddShadow(frame, len, shadowDB)
		if health and health.shadow then
			health.shadow:Hide()
		end
		if not (frame and frame.shadow) then return end

		if classDB.enable then
			if not classDB.detachFromFrame then
				AnchorShadow(frame.shadow, frame, frame, len, len)
				if (classbar and classbar:IsShown())
					or (_G["ElvUF_Player_AdditionalPowerBar"] and _G["ElvUF_Player_AdditionalPowerBar"]:IsShown())
					or (_G["ElvUF_Player_Stagger"] and _G["ElvUF_Player_Stagger"]:IsShown())
					or (frame.Totems and frame.Totems:IsVisible())
					or (_G.ElvUF_Player_Runes and _G.ElvUF_Player_Runes:IsVisible())
				then
					AnchorShadow(frame.shadow, frame, frame, len, len - (classDB.height / 2), len, len)
				end
			else
				AnchorShadow(frame.shadow, health, health, len, len)
			end
		else
			AnchorShadow(frame.shadow, health, frame, len, len)
		end
	end
end

local function ApplyBottomInfoPanelShadow(unitKey, prefix, portraitSide, hasClassbar, benikDetached, len, shadowDB)
	local unitDB = E.db.unitframe.units[unitKey]
	local frame = _G[prefix]
	if not (unitDB.infoPanel.enable and frame.USE_INFO_PANEL) then return end

	local health = _G[prefix.."_HealthBar"]
	local infoPanel = _G[prefix.."_InfoPanel"]

	if health.shadow then
		health.shadow:Hide()
	end
	local shadow = AddShadow(frame, len, shadowDB)
	if not shadow then return end

	shadow:Show()
	local thin = E.db.unitframe.thinBorders
	local pad = thin and len or (len + 1)
	AnchorShadowCorners(shadow, health, infoPanel, pad, pad)

	if unitDB.portrait.enable and unitDB.portrait.style ~= "3D" and not benikDetached then
		if portraitSide == "LEFT" then
			if not frame.USE_PORTRAIT_OVERLAY then
				shadow:SetPoint("TOPLEFT", frame.Portrait, "TOPLEFT", -pad, pad)
				shadow:SetPoint("BOTTOMLEFT", infoPanel, "BOTTOMLEFT", -pad, -pad)
			end
		else
			shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", pad, pad)
			shadow:SetPoint("BOTTOMRIGHT", infoPanel, "BOTTOMRIGHT", pad, -pad)
		end
	end

	if hasClassbar then
		local classDetached = unitDB.classbar.detachFromFrame and unitDB.classbar.enable
		local powerDetached = unitDB.power.detachFromFrame and unitDB.power.enable
		if classDetached or powerDetached then
			if classDetached and not unitDB.power.detachFromFrame then
				if thin then
					shadow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", len, len)
					shadow:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -len, -len)
				else
					shadow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", len - 1, len)
					shadow:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -len, -(len - 1))
				end
			else
				AnchorShadowCorners(shadow, health, infoPanel, len, len)
			end
		end
	elseif unitDB.power.detachFromFrame and unitDB.power.enable then
		AnchorShadowCorners(shadow, health, infoPanel, len, len)
	end

	if unitDB.portrait.enable and not unitDB.portrait.overlay then
		if unitDB.orientation == "RIGHT" then
			shadow:ClearAllPoints()
			shadow:SetPoint("TOPRIGHT", frame.Portrait, "TOPRIGHT", len, len)
			shadow:SetPoint("BOTTOMLEFT", infoPanel, "BOTTOMLEFT", -len, -len)
		elseif unitDB.orientation == "LEFT" then
			shadow:ClearAllPoints()
			shadow:SetPoint("TOPLEFT", frame.Portrait, "TOPLEFT", -len, len)
			shadow:SetPoint("BOTTOMRIGHT", infoPanel, "BOTTOMRIGHT", len, -len)
		end
	end
end

local blizzShadowsRegistered = false
local timerMonitorRegistered = false

--Frame Shadows, turns out ElvUI includes the function
function ElvUI_EltreumUI:Shadows()
	local eltreumDB = E.db.ElvUI_EltreumUI
	local shadowDB = eltreumDB.skins.shadow
	local bordersDB = eltreumDB.borders
	if not (shadowDB.enable and not bordersDB.universalborders and not shadowDB.universalshadows) then return end

	local len = shadowDB.length
	local benikDetached = false
	if IsAddOnLoaded("ElvUI_BenikUI") then
		benikDetached = E.db.benikui.unitframes.player.detachPortrait
	end

	------------------------------------------------------------------------------------------------------blizzard frames
	if shadowDB.blizzard and E.private.skins.blizzard.enable then
		if not blizzShadowsRegistered then
			EltruismBlizzShadows = CreateFrame("Frame")
			EltruismBlizzShadows:RegisterEvent("ADDON_LOADED")
			EltruismBlizzShadows:SetScript("OnEvent", function(_, _, arg)
				BlizzShadows(arg)
			end)
			blizzShadowsRegistered = true
		end
		BlizzShadows(nil, len, shadowDB)

		for i = 1, #blizzardFrameNames do
			local frame = _G[blizzardFrameNames[i]]
			if frame then
				AddShadow(frame.backdrop or frame, len, shadowDB)
			end
		end
		if _G.PlayerSpellsFrame and _G.PlayerSpellsFrame.TabSystem then
			ShadowChildren(len, shadowDB, false, _G.PlayerSpellsFrame.TabSystem:GetChildren())
		end
		ShadowBlizzardNestedFrames(len, shadowDB)

		if not timerMonitorRegistered then
			timermonitor = CreateFrame("FRAME")
			timermonitor:RegisterEvent("START_TIMER")
			timermonitor:SetScript("OnEvent", function()
				if _G.TimerTracker and _G.TimerTracker.timerList then
					local db = E.db.ElvUI_EltreumUI.skins.shadow
					local shadowLength = db.length
					for _, timer in pairs(_G.TimerTracker.timerList) do
						AddShadow(timer.bar, shadowLength, db)
					end
				end
			end)
			timerMonitorRegistered = true
		end

		if _G.AlertFrame and not _G.AlertFrame.AlertFrameShadowHooked then
			hooksecurefunc(_G.AlertFrame, "AddAlertFrame", function(_, frame)
				if frame then
					local db = E.db.ElvUI_EltreumUI.skins.shadow
					AddShadow(frame.backdrop, db.length, db)
				end
			end)
			_G.AlertFrame.AlertFrameShadowHooked = true
		end

		--mirror timer shadow
		if (E.Mists or E.TBC or E.Wrath) and _G.TimerTracker and not _G.TimerTracker.TimerTrackerShadowHooked then
			hooksecurefunc('TimerTracker_StartTimerOfType', function() --from elvui
				local db = E.db.ElvUI_EltreumUI.skins.shadow
				local shadowLength = db.length
				for _, frame in pairs(_G.TimerTracker.timerList) do
					if frame then
						AddShadow(frame.bar, shadowLength, db)
					end
				end
			end)
			_G.TimerTracker.TimerTrackerShadowHooked = true
		end

		if IsAddOnLoaded("Rarity") then --rarity loads these before
			for i = 1, 5 do
				local tab = _G["CollectionsJournalTab"..i]
				if tab then
					AddShadow(tab.backdrop, len, shadowDB)
				end
			end
		end
	end

	------------------------------------------------------------------------------------------------------minimap
	if E.private.general.minimap.enable and not (bordersDB.borders and bordersDB.minimapborder) and shadowDB.minimap then
		if not MinimapShadow then
			MinimapShadow = CreateFrame("Frame", "EltruismMiniMapShadowFrame")
		end
		MinimapShadow:SetParent(_G["Minimap"])
		if not MinimapShadow.minimapIsSkinned then
			local minimap = _G["Minimap"]
			local mmSizeX, mmSizeY = minimap:GetSize()
			MinimapShadow:SetSize(mmSizeX, mmSizeY)
			AddShadow(MinimapShadow, len, shadowDB)
			MinimapShadow:SetPoint("TOPRIGHT", minimap, "TOPRIGHT", 0, 0)
			if not E.db.datatexts.panels.MinimapPanel.backdrop or not E.db.datatexts.panels.MinimapPanel.enable then
				MinimapShadow:SetPoint("BOTTOMLEFT", minimap, "BOTTOMLEFT", 0, 0)
			else
				MinimapShadow:SetPoint("BOTTOMLEFT", _G["MinimapPanel"], "BOTTOMLEFT", 0, 0)
			end
			if eltreumDB.otherstuff.rectangleMinimap.enable or (IsAddOnLoaded("ElvUI_SLE") and E.private.sle.minimap.rectangle) then --Eltruism or Shadow and Light Rectangle Minimap
				MinimapShadow:ClearAllPoints()
				MinimapShadow:SetPoint("TOPRIGHT", minimap.backdrop, "TOPRIGHT", 0, 0)
				if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable then
					MinimapShadow:SetPoint("BOTTOMLEFT", _G["MinimapPanel"], "BOTTOMLEFT", 0, 0)
				else
					MinimapShadow:SetPoint("BOTTOMLEFT", minimap.backdrop, "BOTTOMLEFT", 0, 0)
				end
			elseif IsAddOnLoaded("ElvUI_WindTools") and E.db.WT.maps.rectangleMinimap.enable then --Windtools rectangle minimap
				MinimapShadow:SetAllPoints(minimap.backdrop)
				if E.db.datatexts.panels.MinimapPanel.backdrop and E.db.datatexts.panels.MinimapPanel.enable then
					AddShadow(_G["MinimapPanel"], len, shadowDB)
				end
			end
			if eltreumDB.otherstuff.minimapcardinaldirections.circle then
				MinimapShadow:Hide()
			else
				MinimapShadow:Show()
			end
			MinimapShadow.minimapIsSkinned = true
		end
	end

	------------------------------------------------------------------------------------------------------tooltip
	if shadowDB.tooltip then
		if E.private.tooltip.enable then
			AddShadow(_G.GameTooltip, len, shadowDB)
			AddShadow(_G.LibDBIconTooltip, len, shadowDB)

			--finally fix gametooltip shadow
			if _G.GameTooltipStatusBar and not _G.GameTooltipStatusBar.EltruismHookShadow then
				_G.GameTooltipStatusBar:HookScript("OnShow", function()
					local tooltip = _G.GameTooltip
					if tooltip.shadow then
						local db = E.db.ElvUI_EltreumUI.skins.shadow
						local shadowLength = db.length
						local position = E.db.tooltip.healthBar.statusPosition
						local height = E.db.tooltip.healthBar.height
						if position == "TOP" then
							AnchorShadow(tooltip.shadow, tooltip, tooltip, shadowLength, height + shadowLength, shadowLength, shadowLength)
						elseif position == "BOTTOM" then
							AnchorShadow(tooltip.shadow, tooltip, tooltip, shadowLength, shadowLength, shadowLength, height + shadowLength)
						end
						ElvUI_EltreumUI:ShadowColor(tooltip.shadow, db)
					end
				end)
				_G.GameTooltipStatusBar:HookScript("OnHide", function()
					local tooltip = _G.GameTooltip
					local db = E.db.ElvUI_EltreumUI.skins.shadow
					if tooltip.shadow then
						local shadowLength = db.length
						AnchorShadow(tooltip.shadow, tooltip, tooltip, shadowLength, shadowLength)
					end
					ElvUI_EltreumUI:ShadowColor(tooltip.shadow, db)
				end)
				_G.GameTooltipStatusBar.EltruismHookShadow = true
			end
		end

		--datatexts
		AddShadow(DT.tooltip, len, shadowDB)
	end

	------------------------------------------------------------------------------------------------------version specific
	if E.Retail and shadowDB.blizzard then --reputation detail got moved
		if _G.ReputationFrame then
			AddShadow(_G.ReputationFrame.ReputationDetailFrame, len, shadowDB)
		end
		if _G.DelvesCompanionConfigurationFrame and _G.DelvesCompanionConfigurationFrame.CompanionPortraitFrame then --fix shadow overlap
			_G.DelvesCompanionConfigurationFrame.CompanionPortraitFrame:SetFrameLevel(20)
		end
	end

	if not (E.Retail or E.Classic) and shadowDB.blizzard then
		--loss of control frame icon
		if _G.LossOfControlFrame and _G.LossOfControlFrame.Icon and _G.LossOfControlFrame.shadow then
			AnchorShadow(_G.LossOfControlFrame.shadow, _G.LossOfControlFrame.Icon, _G.LossOfControlFrame.Icon, len, len)
			ElvUI_EltreumUI:ShadowColor(_G.LossOfControlFrame.shadow, shadowDB)
		end

		--main minimize button easier here
		if E.Mists or E.TBC or E.Wrath then
			local tracker = _G.ObjectiveTrackerFrame
			if tracker then
				local minimizeButton = tracker.HeaderMenu and tracker.HeaderMenu.MinimizeButton
				if minimizeButton and not minimizeButton.shadow then
					AnchorShadow(AddShadow(minimizeButton, nil, shadowDB), minimizeButton.tex, minimizeButton.tex, 2, 2)
				end
				local headerButton = tracker.Header and tracker.Header.MinimizeButton
				if headerButton and not headerButton.shadow then
					AnchorShadow(AddShadow(headerButton, nil, shadowDB), headerButton.tex, headerButton.tex, 2, 2)
				end
			end

			if eltreumDB.skins.quests and E.private.skins.blizzard.objectiveTracker and E.private.skins.blizzard.enable then
				local profHdr = _G.ObjectiveTrackerBlocksFrame and _G.ObjectiveTrackerBlocksFrame.ProfessionHeader
				local minBtn = profHdr and profHdr.MinimizeButton
				if minBtn and not minBtn.shadow then
					AnchorShadow(AddShadow(minBtn, nil, shadowDB), minBtn.tex, minBtn.tex, 2, 2)
				end
			end
		end
	end

	------------------------------------------------------------------------------------------------------elvui frames
	if shadowDB.blizzard then --enable with blizzard due to the elvui skin
		for i = 1, #generalElvUIFrameNames do
			AddShadow(_G[generalElvUIFrameNames[i]], len, shadowDB)
		end
		AddShadow(E.ConfigTooltip, len, shadowDB)
		AddShadow(E.SpellBookTooltip, len, shadowDB)

		--elvui popup
		for i = 1, 5 do
			AddShadow(_G["ElvUI_StaticPopup"..i], len, shadowDB)
		end

		--elvui bag bar
		if _G["ElvUIBagBar"] then
			if _G["ElvUIBagBar"].backdrop and _G["ElvUIBagBar"].backdrop:IsShown() then
				AddShadow(_G["ElvUIBagBar"].backdrop, len, shadowDB)
			else
				AddShadow(_G["KeyRingButton"], len, shadowDB)
				AddShadow(_G["MainMenuBarBackpackButton"], len, shadowDB)
				for i = 0, 3 do
					AddShadow(_G["CharacterBag"..i.."Slot"], len, shadowDB)
				end
			end
		end

		--elvui config shadows
		if E.private.skins.blizzard.enable and not self.ElvUIConfigShadowHooked then
			hooksecurefunc(E, "ToggleOptions", function()
				local frame = E:Config_GetWindow()
				if frame then
					local db = E.db.ElvUI_EltreumUI.skins.shadow
					AddShadow(frame, db.length, db)
				end
			end)
			self.ElvUIConfigShadowHooked = true
		end

		--statusreport
		if not self.StatusReportShadowHooked then
			hooksecurefunc(E, "ShowStatusReport", function()
				local db = E.db.ElvUI_EltreumUI.skins.shadow
				local shadowLength = db.length
				AddShadow(_G["ElvUIStatusReport"], shadowLength, db)
				AddShadow(_G["ElvUIStatusPlugins"], shadowLength, db)
			end)
			self.StatusReportShadowHooked = true
		end
	end

	------------------------------------------------------------------------------------------------------action bars
	if shadowDB.actionbars then
		if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") and not IsAddOnLoaded("Masque") then
			--elvui action bars
			for i = 1, 15 do
				local barDB = E.db.actionbar["bar"..i]
				if barDB and barDB.backdrop then
					local bar = _G["ElvUI_Bar"..i]
					if bar then
						AddShadow(bar.backdrop, len, shadowDB)
					end
				elseif not (bordersDB.borders and bordersDB["bar"..i.."borders"]) then
					for k = 1, 12 do
						AddShadow(_G["ElvUI_Bar"..i..'Button'..k], len, shadowDB)
					end
				end
			end

			--pet bars
			if E.db.actionbar.barPet and E.db.actionbar.barPet.backdrop then
				if _G["ElvUI_BarPet"] then
					AddShadow(_G["ElvUI_BarPet"].backdrop, len, shadowDB)
				end
			elseif not (bordersDB.borders and bordersDB.petactionborders) then
				for i = 1, 12 do
					local button = _G["PetActionButton"..i]
					if not button then break end
					AddShadow(button, len, shadowDB)
				end
			end

			--stances
			if E.db.actionbar.stanceBar and E.db.actionbar.stanceBar.backdrop then
				if _G["ElvUI_StanceBar"] then
					AddShadow(_G["ElvUI_StanceBar"].backdrop, len, shadowDB)
				end
			elseif not _G["EltruismStanceBorder1"] and not (bordersDB.borders and bordersDB.stanceborders) then
				for i = 1, 12 do
					local button = _G["ElvUI_StanceBarButton"..i]
					if not button then break end
					AddShadow(button, len, shadowDB)
				end
			end

			--boss
			AddShadow(_G.BossButton, len, shadowDB)

			--flyouts
			for i = 1, 15 do
				local flyout = _G["LABFlyoutButton"..i]
				if flyout then
					AddShadow(flyout.backdrop or flyout, len, shadowDB)
				end
			end
		end

		--class totems
		for i = 1, _G.MAX_TOTEMS do
			AddShadow(_G['ElvUI_TotemTrackerTotem'..i], len, shadowDB)
		end

		--microbar shadow
		if E.db.actionbar.microbar.enabled then
			if E.db.actionbar.microbar.backdrop then
				if _G.ElvUI_MicroBar then
					AddShadow(_G.ElvUI_MicroBar.backdrop, len, shadowDB)
				end
			else
				for i = 1, #microbarButtonNames do
					AddShadow(_G[microbarButtonNames[i]], len, shadowDB)
				end
			end
		end
	end

	------------------------------------------------------------------------------------------------------unitframes
	if shadowDB.unitframes and E.private.unitframe.enable then
		if bordersDB.borders then
			for i = 1, #unitframeBorderShadowPairs do
				local pair = unitframeBorderShadowPairs[i]
				local frame = _G[pair[1]]
				if frame then
					if not bordersDB[pair[2]] then
						AddShadow(frame, len, shadowDB)
					elseif frame.shadow then
						frame.shadow:Hide()
					end
				end
			end
			for i = 1, 4 do
				local totem = _G["ElvUF_PlayerTotem"..i]
				local backdrop = totem and totem.backdrop
				if backdrop then
					if not bordersDB.totembar then
						AddShadow(backdrop, len, shadowDB)
					elseif backdrop.shadow then
						backdrop.shadow:Hide()
					end
				end
			end
		else
			for i = 1, #unitframeBorderShadowPairs do
				AddShadow(_G[unitframeBorderShadowPairs[i][1]], len, shadowDB)
			end
			for i = 1, #unitframeExtraShadowFrames do
				AddShadow(_G[unitframeExtraShadowFrames[i]], len, shadowDB)
			end
			for i = 1, 4 do
				local totem = _G["ElvUF_PlayerTotem"..i]
				if totem then
					AddShadow(totem.backdrop, len, shadowDB)
				end
			end
		end

		if not E.Classic then
			ApplyStandardUnitPowerShadow("focus", "ElvUF_Focus", false, benikDetached, len, shadowDB)
			ApplyUnitPortraitShadow("focus", "ElvUF_Focus", "focusborder", true, len, shadowDB, bordersDB)
			ApplyStandardUnitPowerShadow("focustarget", "ElvUF_FocusTarget", false, benikDetached, len, shadowDB)
			ApplyUnitPortraitShadow("focustarget", "ElvUF_FocusTarget", "focustargetborder", true, len, shadowDB, bordersDB)
		end

		ApplyUnitPortraitShadow("player", "ElvUF_Player", "playerborder", true, len, shadowDB, bordersDB)
		ApplyUnitPortraitShadow("target", "ElvUF_Target", "targetborder", false, len, shadowDB, bordersDB)
		ApplyUnitPortraitShadow("targettarget", "ElvUF_TargetTarget", "targettargetborder", false, len, shadowDB, bordersDB)

		--castbars
		ApplyCastbarShadow("player", "ElvUF_Player_CastBar", "playercastborder", len, shadowDB, bordersDB)
		ApplyCastbarShadow("target", "ElvUF_Target_CastBar", "targetcastborder", len, shadowDB, bordersDB)
		ApplyCastbarShadow("focus", "ElvUF_Focus_CastBar", "focuscastborder", len, shadowDB, bordersDB)

		local infoOnTopAll = eltreumDB.unitframes.infopanelontop and eltreumDB.unitframes.infopanelontopallframes

		--party
		ApplyPartyOrBossShadows("party", "ElvUF_PartyGroup1UnitButton", 5, "partyborders", infoOnTopAll, len, shadowDB, bordersDB)

		--party pets
		if E.db.unitframe.units.party.enable and E.db.unitframe.units.party.petsGroup.enable then
			for i = 1, 5 do
				AddShadow(_G["ElvUF_PartyGroup1UnitButton"..i.."Pet"], len, shadowDB)
			end
		end

		--raidpets
		if E.db.unitframe.units.raidpet.enable then
			for i = 1, 40 do
				AddShadow(_G["ElvUF_RaidpetGroup1UnitButton"..i], len, shadowDB)
			end
		end

		--boss
		if E.db.unitframe.units.boss.enable then
			ApplyPartyOrBossShadows("boss", "ElvUF_Boss", 8, "bossborder", infoOnTopAll, len, shadowDB, bordersDB)
		end

		--tank & assist targets
		if E.db.unitframe.units.tank.enable and E.db.unitframe.units.tank.targetsGroup.enable then
			ApplyGroupUnitShadows("ElvUF_TankUnitButton", 8, "Target", infoOnTopAll, len, shadowDB)
		end
		if E.db.unitframe.units.assist.enable and E.db.unitframe.units.assist.targetsGroup.enable then
			ApplyGroupUnitShadows("ElvUF_AssistUnitButton", 8, "Target", infoOnTopAll, len, shadowDB)
		end

		--player classbar
		local classDB = E.db.unitframe.units.player.classbar
		if classDB.enable and not (bordersDB.comboclassbar and bordersDB.borders) then
			local function CreateClassbarShadows(mode)
				if mode == "all" then
					AddShadow(_G["ElvUF_Player_Runes"], len, shadowDB)
					local classbar = _G["ElvUF_Player_ClassBar"]
					if classbar and not classbar.shadow then
						local shadow = AddShadow(classbar, len, shadowDB)
						if E.myclass == 'ROGUE' and classDB.detachFromFrame and classDB.spacing < 1 then --rogue combo point issue in retail
							local maxRoguePoints = tostring(classbar.__max)
							AnchorShadow(shadow, _G["ElvUF_PlayerClassIconButton1"], _G["ElvUF_PlayerClassIconButton"..maxRoguePoints], len, len)
						end
					end
					AddShadow(_G["ElvUF_Player_AdditionalPowerBar"], len, shadowDB)
					AddShadow(_G["ElvUF_Player_Stagger"], len, shadowDB)
				elseif mode == "extra" then
					AddShadow(_G["ElvUF_Player_AdditionalPowerBar"], len, shadowDB)
					AddShadow(_G["ElvUF_Player_Stagger"], len, shadowDB)
				elseif mode == "spaced" then
					if E.myclass == 'DEATHKNIGHT' then --runes
						if classDB.fill == "spaced" or classDB.detachFromFrame then
							for i = 1, 6 do
								local button = _G["ElvUF_PlayerRuneButton"..i]
								if not button then break end
								AddShadow(button, len, shadowDB)
							end
						end
					elseif E.myclass == 'ROGUE' and classDB.detachFromFrame and classDB.spacing < 1 then --rogue combo point issue in retail
						local classbar = _G["ElvUF_Player_ClassBar"]
						if classbar and not classbar.shadow then
							local shadow = AddShadow(classbar, len, shadowDB)
							local maxRoguePoints = tostring(classbar.__max)
							AnchorShadow(shadow, _G["ElvUF_PlayerClassIconButton1"], _G["ElvUF_PlayerClassIconButton"..maxRoguePoints], len, len)
						end
					else --other class bar
						for i = 1, 10 do
							local icon = _G["ElvUF_PlayerClassIconButton"..i]
							if not (icon and icon.backdrop) then break end
							AddShadow(icon.backdrop, len, shadowDB)
						end
					end
				end
			end
			if classDB.detachFromFrame then
				if classDB.spacing > 0 then
					CreateClassbarShadows("spaced")
				else
					CreateClassbarShadows("all")
				end
			else
				if classDB.fill ~= "spaced" then
					CreateClassbarShadows("all")
				else
					CreateClassbarShadows("extra")
					CreateClassbarShadows("spaced")
				end
			end
		end

		--unit power layouts
		ApplyPlayerPowerShadow(benikDetached, len, shadowDB)
		ApplyStandardUnitPowerShadow("target", "ElvUF_Target", true, benikDetached, len, shadowDB)
		ApplyStandardUnitPowerShadow("targettarget", "ElvUF_TargetTarget", true, benikDetached, len, shadowDB)

		--info panel on top vs bottom
		if eltreumDB.unitframes.infopanelontop then
			local player = _G["ElvUF_Player"]
			if (E.db.unitframe.units.player.infoPanel.enable and player.USE_INFO_PANEL) and not (bordersDB.playerborder and bordersDB.borders) then
				if _G["ElvUF_Player_HealthBar"].shadow then
					_G["ElvUF_Player_HealthBar"].shadow:Hide()
				end
				local shadow = AddShadow(player, len, shadowDB)
				if shadow then
					shadow:Show()
					local rightPad = E.db.unitframe.thinBorders and len or (len + 1)
					AnchorShadowCorners(shadow, _G["ElvUF_Player_InfoPanel"], _G["ElvUF_Player_HealthBar"], len, len, rightPad, len)
					if E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style ~= "3D" and not benikDetached and not player.USE_PORTRAIT_OVERLAY then
						shadow:SetPoint("BOTTOMLEFT", player.Portrait, "BOTTOMLEFT", -len, -len)
						shadow:SetPoint("TOPLEFT", player.Portrait, "TOPLEFT", -len, len)
					end
					if E.db.unitframe.units.player.power.enable and E.db.unitframe.units.player.power.width == "fill" then
						local bottomPad = E.db.unitframe.thinBorders and len or (len + 2)
						shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Player_PowerBar"], "BOTTOMLEFT", -len, -bottomPad)
						shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Player_PowerBar"], "BOTTOMRIGHT", len, -bottomPad)
					end
					if (classDB.detachFromFrame and classDB.enable) or (E.db.unitframe.units.player.power.detachFromFrame and E.db.unitframe.units.player.power.enable) then
						local bottomBar = (classDB.detachFromFrame and not E.db.unitframe.units.player.power.detachFromFrame) and _G["ElvUF_Player_PowerBar"] or _G["ElvUF_Player_HealthBar"]
						AnchorShadowCorners(shadow, _G["ElvUF_Player_InfoPanel"], bottomBar, len, len)
					end
				end
			end

			local target = _G["ElvUF_Target"]
			if (E.db.unitframe.units.target.infoPanel.enable and target.USE_INFO_PANEL) and not (bordersDB.targetborder and bordersDB.borders) then
				if _G["ElvUF_Target_HealthBar"].shadow then
					_G["ElvUF_Target_HealthBar"].shadow:Hide()
				end
				local shadow = AddShadow(target, len, shadowDB)
				if shadow then
					if E.db.unitframe.thinBorders then
						AnchorShadowCorners(shadow, _G["ElvUF_Target_InfoPanel"], _G["ElvUF_Target_HealthBar"], len, len)
					else
						AnchorShadowCorners(shadow, _G["ElvUF_Target_InfoPanel"], _G["ElvUF_Target_HealthBar"], len + 2, len + 2, len, len)
					end
					local benikDetachedTarget = IsAddOnLoaded("ElvUI_BenikUI") and E.db.benikui.unitframes.target.detachPortrait or false
					if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style ~= "3D" and not benikDetachedTarget and not target.USE_PORTRAIT_OVERLAY then
						shadow:SetPoint("BOTTOMRIGHT", target.Portrait, "BOTTOMRIGHT", len, -len)
						shadow:SetPoint("TOPRIGHT", target.Portrait, "TOPRIGHT", len, len)
					end
					if E.db.unitframe.units.target.power.enable and E.db.unitframe.units.target.power.width == "fill" then
						local bottomPad = E.db.unitframe.thinBorders and len or (len + 2)
						shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Target_PowerBar"], "BOTTOMRIGHT", len, -bottomPad)
						shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Target_PowerBar"], "BOTTOMLEFT", -len, -bottomPad)
					end
					if E.db.unitframe.units.target.power.detachFromFrame then
						AnchorShadowCorners(shadow, _G["ElvUF_Target_InfoPanel"], _G["ElvUF_Target_HealthBar"], len, len)
					end
				end
			end

			local targettarget = _G["ElvUF_TargetTarget"]
			if (E.db.unitframe.units.targettarget.infoPanel.enable and targettarget.USE_INFO_PANEL) and not (bordersDB.targettargetborder and bordersDB.borders) then
				if _G["ElvUF_TargetTarget_HealthBar"].shadow then
					_G["ElvUF_TargetTarget_HealthBar"].shadow:Hide()
				end
				local shadow = AddShadow(targettarget, len, shadowDB)
				if shadow then
					local bottomBar = (E.db.unitframe.units.targettarget.power.enable and E.db.unitframe.units.targettarget.power.width ~= "inset") and _G["ElvUF_TargetTarget_PowerBar"] or _G["ElvUF_TargetTarget_HealthBar"]
					AnchorShadowCorners(shadow, _G["ElvUF_TargetTarget_InfoPanel"], bottomBar, len, len)
					ElvUI_EltreumUI:ShadowColor(shadow, shadowDB)
				end
			end

			local pet = _G["ElvUF_Pet"]
			if (E.db.unitframe.units.pet.infoPanel.enable and pet.USE_INFO_PANEL) and not (bordersDB.petborder and bordersDB.borders) then
				if _G["ElvUF_Pet_HealthBar"].shadow then
					_G["ElvUF_Pet_HealthBar"].shadow:Hide()
				end
				local shadow = AddShadow(pet, len, shadowDB)
				if shadow then
					shadow:Show()
					AnchorShadowCorners(shadow, _G["ElvUF_Pet_InfoPanel"], _G["ElvUF_Pet_HealthBar"], len, len)
					if E.db.unitframe.units.pet.portrait.enable then
						shadow:SetPoint("BOTTOMLEFT", pet.Portrait, "BOTTOMLEFT", -len, -len)
						shadow:SetPoint("TOPLEFT", pet.Portrait, "TOPLEFT", -len, len)
					end
					if E.db.unitframe.units.pet.power.enable and E.db.unitframe.units.pet.power.width ~= "inset" then
						if not E.db.unitframe.units.pet.portrait.enable then
							shadow:SetPoint("BOTTOMLEFT", _G["ElvUF_Pet_PowerBar"], "BOTTOMLEFT", -len, -len)
						end
						shadow:SetPoint("BOTTOMRIGHT", _G["ElvUF_Pet_PowerBar"], "BOTTOMRIGHT", len, -len)
					end
					ElvUI_EltreumUI:ShadowColor(shadow, shadowDB)
				end
			end

			if bordersDB.playerborder and bordersDB.borders and player.shadow then
				player.shadow:Hide()
			end
			if bordersDB.targetborder and bordersDB.borders and target.shadow then
				target.shadow:Hide()
			end
		else
			ApplyBottomInfoPanelShadow("player", "ElvUF_Player", "LEFT", true, benikDetached, len, shadowDB)
			ApplyBottomInfoPanelShadow("target", "ElvUF_Target", "RIGHT", false, benikDetached, len, shadowDB)
			ApplyBottomInfoPanelShadow("targettarget", "ElvUF_TargetTarget", "RIGHT", false, benikDetached, len, shadowDB)
			ApplyBottomInfoPanelShadow("pet", "ElvUF_Pet", "RIGHT", false, benikDetached, len, shadowDB)
			if not E.Classic then
				ApplyBottomInfoPanelShadow("focus", "ElvUF_Focus", "LEFT", false, benikDetached, len, shadowDB)
			end
		end

		--detached power
		if E.db.unitframe.units.player.power.detachFromFrame and _G["ElvUF_Player_PowerBar"].shadow then
			_G["ElvUF_Player_PowerBar"].shadow:Show()
			ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Player_PowerBar"].shadow, shadowDB)
		end
		if E.db.unitframe.units.target.power.detachFromFrame and _G["ElvUF_Target_PowerBar"].shadow then
			_G["ElvUF_Target_PowerBar"].shadow:Show()
			ElvUI_EltreumUI:ShadowColor(_G["ElvUF_Target_PowerBar"].shadow, shadowDB)
		end
	end

	------------------------------------------------------------------------------------------------------bags
	if shadowDB.blizzard and E.private.bags.enable then
		AddShadow(_G.ElvUI_ContainerFrame, len, shadowDB)
		AddShadow(_G.ElvUI_BankContainerFrame, len, shadowDB)
		AddShadow(_G.ElvUI_BankContainerFrameWarbandHolder, len, shadowDB)
		AddShadow(_G.ElvUI_BankContainerFrameBankTabs, len, shadowDB)
	end

	------------------------------------------------------------------------------------------------------chat
	if shadowDB.chat and not (bordersDB.chatborder and bordersDB.borders) then
		local rightPanel = _G["RightChatPanel"]
		local leftPanel = _G["LeftChatPanel"]

		if E.db.datatexts.panels.EltruismDataText and E.db.datatexts.panels.EltruismDataText.enable then
			if rightPanel and rightPanel.backdrop and not rightPanel.backdrop.shadow then
				local shadow = AddShadow(rightPanel.backdrop, len, shadowDB)
				shadow.BottomEdge:Hide()
				shadow.BottomRightCorner:Hide()
				shadow.BottomLeftCorner:Hide()
			end
			if leftPanel and leftPanel.backdrop and not leftPanel.backdrop.shadow then
				local shadow = AddShadow(leftPanel.backdrop, len, shadowDB)
				shadow.BottomEdge:Hide()
				shadow.BottomRightCorner:Hide()
				shadow.BottomLeftCorner:Hide()
			end
		else
			if not RightChatShadow then
				RightChatShadow = CreateFrame("Frame", "EltruismRightChatShadowFrame")
			end
			if not LeftChatShadow then
				LeftChatShadow = CreateFrame("Frame", "EltruismLeftChatShadowFrame")
			end
			RightChatShadow:SetSize(_G["RightChatMover"]:GetSize())
			RightChatShadow:SetParent(rightPanel.backdrop)
			LeftChatShadow:SetSize(_G["LeftChatMover"]:GetSize())
			LeftChatShadow:SetParent(leftPanel.backdrop)

			if not rightPanel.RightChatIsSkinned then
				AddShadow(RightChatShadow, len, shadowDB)
				RightChatShadow:SetPoint("TOPRIGHT", rightPanel, "TOPRIGHT", 0, 0)
				RightChatShadow:SetPoint("BOTTOMLEFT", E.db.datatexts.panels.RightChatDataPanel.enable and _G["RightChatDataPanel"] or rightPanel, "BOTTOMLEFT", 0, 0)
				RightChatShadow:Show()
				rightPanel.RightChatIsSkinned = true
			end
			if not leftPanel.LeftChatIsSkinned then
				AddShadow(LeftChatShadow, len, shadowDB)
				LeftChatShadow:SetPoint("TOPLEFT", leftPanel, "TOPLEFT", 0, 0)
				LeftChatShadow:SetPoint("BOTTOMRIGHT", E.db.datatexts.panels.LeftChatDataPanel.enable and _G["LeftChatDataPanel"] or leftPanel, "BOTTOMRIGHT", 0, 0)
				LeftChatShadow:Show()
				leftPanel.LeftChatIsSkinned = true
			end
		end

		if E.db.chat.panelBackdrop == "LEFT" then
			if RightChatShadow then RightChatShadow:Hide() end
		elseif E.db.chat.panelBackdrop == "RIGHT" then
			if LeftChatShadow then LeftChatShadow:Hide() end
		elseif E.db.chat.panelBackdrop == "HIDEBOTH" then
			if LeftChatShadow then LeftChatShadow:Hide() end
			if RightChatShadow then RightChatShadow:Hide() end
		end
	end

	------------------------------------------------------------------------------------------------------other addons
	if IsAddOnLoaded("ElvUI_WindTools") then
		if _G["WTEventTracker"] then
			AddShadow(_G["WTEventTracker"].backdrop, len, shadowDB)
		end
		AddShadow(_G["WTContacts"], len, shadowDB)

		if E.db.WT.misc.gameBar.enable and E.db.WT.misc.gameBar.backdrop then
			AddShadow(_G["WTGameBarMiddlePanel"], len, shadowDB)
			AddShadow(_G["WTGameBarLeftPanel"], len, shadowDB)
			AddShadow(_G["WTGameBarRightPanel"], len, shadowDB)
		end

		for i = 1, 5 do
			local bar = _G["WTExtraItemsBar"..i]
			if bar then
				if bar.backdrop and bar.backdrop:IsShown() then
					AddShadow(bar.backdrop, len, shadowDB)
				else
					for k = 1, 12 do
						AddShadow(_G["WTExtraItemsBar"..i.."Button"..k], len, shadowDB)
					end
				end
			end
		end

		local WT = E.Libs.AceAddon:GetAddon("ElvUI_WindTools", true)
		local MB = WT:GetModule("MinimapButtons")
		if MB and MB.bar then
			if MB.bar.backdrop and MB.bar.backdrop:IsShown() then
				AddShadow(MB.bar, len, shadowDB)
			else
				if MB.SetButtonMouseOver and not MB.EltruismShadowHooked then
					hooksecurefunc(MB, "SetButtonMouseOver", function(_, button)
						if button then
							local db = E.db.ElvUI_EltreumUI.skins.shadow
							AddShadow(button.backdrop, db.length, db)
						end
					end)
					MB.EltruismShadowHooked = true
				end
				ShadowChildren(len, shadowDB, false, MB.bar:GetChildren())
			end
		end

		local LL = WT:GetModule("LFGList")
		if LL and LL.UpdateRightPanel and not LL.EltruismShadowHooked then
			hooksecurefunc(LL, "UpdateRightPanel", function()
				local db = E.db.ElvUI_EltreumUI.skins.shadow
				AddShadow(LL.rightPanel, db.length, db)
			end)
			LL.EltruismShadowHooked = true
		end

		AddShadow(_G["ParagonReputation_Toast"], len, shadowDB)

		if E.db.WT.item.inspect.player and _G["PaperDollFrame"] and not _G["PaperDollFrame"].EltruismShadowHooked then
			_G["PaperDollFrame"]:HookScript("OnShow", function()
				local paperDoll = _G["PaperDollFrame"]
				if paperDoll.inspectFrame then
					local db = E.db.ElvUI_EltreumUI.skins.shadow
					AddShadow(paperDoll.inspectFrame.backdrop, db.length, db)
				end
			end)
			_G["PaperDollFrame"].EltruismShadowHooked = true
		end

		local RM = WT:GetModule("RaidMarkers")
		if RM and RM.bar then
			if RM.bar.backdrop and RM.bar.backdrop:IsShown() then
				AddShadow(RM.bar.backdrop, len, shadowDB)
			else
				ShadowChildren(len, shadowDB, true, RM.bar:GetChildren())
			end
		end
	end

	if IsAddOnLoaded("Leatrix_Maps") then --leatrix map issues
		if _G.LeaMapsDB["NoMapBorder"] == "On" or not E.private.skins.blizzard.worldmap then
			if _G.WorldMapFrame and _G.WorldMapFrame.shadow then
				_G.WorldMapFrame.shadow:Hide()
			end
		end
	elseif not E.private.skins.blizzard.worldmap then
		if _G.WorldMapFrame and _G.WorldMapFrame.shadow then
			_G.WorldMapFrame.shadow:Hide()
		end
	end

	if not E.private.skins.blizzard.spellbook then
		for i = 1, #spellbookFrameNames do
			local frame = _G[spellbookFrameNames[i]]
			if frame then
				local target = frame.backdrop or frame
				if target.shadow then
					target.shadow:Hide()
				end
			end
		end
	end
end

function ElvUI_EltreumUI:RaidShadows()
	local eltreumDB = E.db.ElvUI_EltreumUI
	local shadowDB = eltreumDB.skins.shadow
	local bordersDB = eltreumDB.borders
	if not (E.private.unitframe.enable and shadowDB.enable and shadowDB.raid and not (bordersDB.borders and bordersDB.raidborders) and not bordersDB.universalborders and not shadowDB.universalshadows) then
		return
	end

	local len = shadowDB.length
	local infoOnTop = eltreumDB.unitframes.infopanelontop and eltreumDB.unitframes.infopanelontopallframes

	--raid
	for i = 1, 3 do
		if E.db.unitframe.units["raid"..i].enable then
			for k = 1, 8 do
				for l = 1, 5 do
					local button = _G["ElvUF_Raid"..i..'Group'..k..'UnitButton'..l]
					if button and not button.shadow and not (button.Health and button.Health.shadow) then
						local powerDB = button.db.power
						if powerDB.enable then
							if powerDB.width == "spaced" then
								AddShadow(button.Health, len, shadowDB):SetParent(button)
								AddShadow(button.Power, len, shadowDB):SetParent(button)
							elseif powerDB.width == "offset" then
								local shadow = AddShadow(button, len, shadowDB)
								shadow:SetParent(button)
								if powerDB.offset > 0 then
									AddShadow(button.Power, len, shadowDB):SetParent(button)
									AnchorShadowCorners(shadow, button.Health, button.Health, len, len)
								end
							else
								local shadow = AddShadow(button, len, shadowDB)
								if infoOnTop and button.db.infoPanel.enable and button.USE_INFO_PANEL then
									AnchorShadowCorners(shadow, button.InfoPanel, button.Health, len, len)
								end
								shadow:SetParent(button)
							end
						else
							local shadow = AddShadow(button, len, shadowDB)
							if infoOnTop and button.db.infoPanel.enable and button.USE_INFO_PANEL then
								AnchorShadowCorners(shadow, button.InfoPanel, button.Health, len, len)
							end
							shadow:SetParent(button)
						end
					end
				end
			end
		end
	end

	--tanks & assists
	if E.db.unitframe.units.tank.enable then
		ApplyGroupUnitShadows("ElvUF_TankUnitButton", 8, nil, infoOnTop, len, shadowDB)
	end
	if E.db.unitframe.units.assist.enable then
		ApplyGroupUnitShadows("ElvUF_AssistUnitButton", 8, nil, infoOnTop, len, shadowDB)
	end
end

--benik's version
local bordercolor = E.myClassColor
local npBorderBackdrop = { edgeFile = nil, edgeSize = nil }
local targetClassPowerNames = {
	"ElvNP_TargetClassPowerClassPower",
	"ElvNP_TargetClassPowerRunes",
	"ElvNP_TargetClassPowerStagger",
	"EltruismPowerBar",
}
local targetClassPowerShadowed = false

--apply cached nameplate border settings
local function ApplyNameplateBorderFrame(border, anchor, bordertexture, edgeSize, sizeX, sizeY, r, g, b, a)
	if not border.EltruismBackdropSet or border.EltruismTexture ~= bordertexture or border.EltruismEdgeSize ~= edgeSize then
		npBorderBackdrop.edgeFile = bordertexture
		npBorderBackdrop.edgeSize = edgeSize
		border:SetBackdrop(npBorderBackdrop)
		border.EltruismBackdropSet = true
		border.EltruismTexture = bordertexture
		border.EltruismEdgeSize = edgeSize
	end
	if border.EltruismR ~= r or border.EltruismG ~= g or border.EltruismB ~= b or border.EltruismA ~= a then
		border:SetBackdropBorderColor(r, g, b, a)
		border.EltruismR = r
		border.EltruismG = g
		border.EltruismB = b
		border.EltruismA = a
	end
	local level = anchor:GetFrameLevel() + 1
	if border.EltruismLevel ~= level then
		border:SetFrameLevel(level)
		border.EltruismLevel = level
	end
	local anchorStrata = anchor:GetFrameStrata()
	local strata = E:NotSecretValue(anchorStrata) and anchorStrata or "MEDIUM"
	if border.EltruismStrata ~= strata then
		border:SetFrameStrata(strata)
		border.EltruismStrata = strata
	end
	if not border.EltruismPositioned or border.EltruismSizeX ~= sizeX or border.EltruismSizeY ~= sizeY then
		border:ClearAllPoints()
		border:SetPoint("CENTER", anchor, "CENTER", 0, 0)
		border:SetOutside(anchor, sizeX, sizeY)
		border.EltruismPositioned = true
		border.EltruismSizeX = sizeX
		border.EltruismSizeY = sizeY
	end
end

function ElvUI_EltreumUI:NameplateShadowsAndBorders(nameplate)
	if not nameplate then return end
	if not E.private.nameplates.enable then return end

	local eltreumDB = E.db.ElvUI_EltreumUI
	if not eltreumDB then return end
	local bordersDB = eltreumDB.borders
	local shadowDB = eltreumDB.skins and eltreumDB.skins.shadow

	if bordersDB and bordersDB.borders and (bordersDB.nameplateborders or bordersDB.nameplatecastborders) then
		local bordertexture
		if bordersDB.classcolor and nameplate.__unit then
			local _, className = _G.UnitClass(nameplate.__unit)
			local isPlayer = _G.UnitIsPlayer(nameplate.__unit) or (E.Retail and _G.UnitInPartyIsAI(nameplate.__unit))
			if not E:NotSecretValue(className) then --secret class so do something else
				className = E.myclass
			end
			if isPlayer then
				bordercolor = ElvUI_EltreumUI:GetClassColorsRGB(className)
			else
				local targettype
				if ElvUI_EltreumUI.GetNameplateTargetType then
					targettype = ElvUI_EltreumUI:GetNameplateTargetType(nameplate, nameplate.__unit)
				else
					local reaction = _G.UnitReaction(nameplate.__unit, "player")
					if reaction and reaction >= 5 then
						targettype = "NPCFRIENDLY"
					elseif reaction and reaction == 4 then
						targettype = "NPCNEUTRAL"
					elseif reaction and reaction == 3 then
						targettype = "NPCUNFRIENDLY"
					elseif reaction and reaction <= 2 then
						targettype = "NPCHOSTILE"
					end
				end
				bordercolor = ElvUI_EltreumUI:GetClassColorsRGB(targettype)
			end
		end

		if bordersDB.texture then
			bordertexture = E.LSM:Fetch("border", bordersDB.texture)
			if bordertexture == nil then --the border was not found so apply the default
				bordertexture = E.LSM:Fetch("border", "Eltreum-Border-1")
				bordersDB.texture = "Eltreum-Border-1"
			end
		end

		local r, g, b
		if bordersDB.classcolor then
			if bordercolor.r then
				r, g, b = bordercolor.r, bordercolor.g, bordercolor.b
			else --fallback because color failed
				r, g, b = 1, 1, 1
			end
		else
			r, g, b = bordersDB.bordercolors.r, bordersDB.bordercolors.g, bordersDB.bordercolors.b
		end

		if bordersDB.nameplateborders and nameplate.Health then
			if not nameplate.Health.EltruismNameplateBorder then
				nameplate.Health.EltruismNameplateBorder = CreateFrame("Frame", nil, nameplate.Health, _G.BackdropTemplateMixin and "BackdropTemplate")
			end
			ApplyNameplateBorderFrame(nameplate.Health.EltruismNameplateBorder, nameplate.Health, bordertexture, bordersDB.nameplatesize, bordersDB.nameplatesizex, bordersDB.nameplatesizey, r, g, b, 1)

			if bordersDB.universalborders then
				if nameplate.backdrop and nameplate.backdrop.eltruismuniversalborders then
					nameplate.backdrop.eltruismuniversalborders:Kill()
					nameplate.backdrop.eltruismuniversalborders = nil
				end
				if nameplate.Health.backdrop and nameplate.Health.backdrop.eltruismuniversalborders then
					nameplate.Health.backdrop.eltruismuniversalborders:Kill()
					nameplate.Health.backdrop.eltruismuniversalborders = nil
				end
			end
		end
		if bordersDB.nameplatecastborders and nameplate.Castbar then
			if not nameplate.Castbar.EltruismNameplateBorder then
				nameplate.Castbar.EltruismNameplateBorder = CreateFrame("Frame", nil, nameplate.Castbar, _G.BackdropTemplateMixin and "BackdropTemplate")
			end
			ApplyNameplateBorderFrame(nameplate.Castbar.EltruismNameplateBorder, nameplate.Castbar, bordertexture, bordersDB.nameplatecastsize, bordersDB.nameplatecastsizex, bordersDB.nameplatecastsizey, r, g, b, 1)

			if bordersDB.universalborders then
				if nameplate.Castbar.backdrop and nameplate.Castbar.backdrop.eltruismuniversalborders then
					nameplate.Castbar.backdrop.eltruismuniversalborders:Kill()
					nameplate.Castbar.backdrop.eltruismuniversalborders = nil
				end
			end
		end
	elseif shadowDB and shadowDB.enable and not (bordersDB and bordersDB.universalborders) and not shadowDB.universalshadows then
		local len = shadowDB.length
		if shadowDB.nameplates and nameplate.Health then
			AddShadow(nameplate.Health.backdrop, len, shadowDB, true)
		end

		if shadowDB.nppower then
			if nameplate.Power then
				AddShadow(nameplate.Power.backdrop, len, shadowDB)
			end
			if not targetClassPowerShadowed then
				for i = 1, #targetClassPowerNames do
					AddShadow(_G[targetClassPowerNames[i]], len, shadowDB)
				end
				targetClassPowerShadowed = true
			end
		end

		if shadowDB.npcastbar and nameplate.Castbar then
			AddShadow(nameplate.Castbar.backdrop, len, shadowDB, true)
			AddShadow(nameplate.Castbar.Button, len, shadowDB, true)
		end

		if shadowDB.npportraits and nameplate.Portrait then
			AddShadow(nameplate.Portrait.backdrop, len, shadowDB, true)
		end
	end
end

--check whether shadows are enabled for this aura container
local function ResolveAuraShadowEnabled(container, target, shadowDB, bordersDB)
	local isBar = (container and container.isAuraBar) or target.isAuraBar
	local isNP = target.isNameplate or (container and (container.isNameplate or container.nameplateType or (container.parent and (container.parent.nameplateType or container.parent.unitframeType == "nameplate")) or (NP and NP.AuraContainersCreated and NP.AuraContainersCreated[container])))
	local isUF
	if not isNP then
		isUF = target.isUnitframe or (container and (container.isUnitframe or (container.parent and container.parent.unitframeType and container.parent.unitframeType ~= "nameplate") or (container.unitframeType and container.unitframeType ~= "nameplate")))
	end

	if isNP then
		return isBar, shadowDB.npauras and not (bordersDB and bordersDB.borders and bordersDB.aurabordernp)
	elseif isUF then
		return isBar, shadowDB.ufaura and not (bordersDB and bordersDB.borders and bordersDB.auraborderuf)
	else --minimap auras or aurabars
		return isBar, shadowDB.aura and not (bordersDB and bordersDB.borders and bordersDB.auraborder)
	end
end

function ElvUI_EltreumUI:Construct_AuraIcon(_, button)
	if not button or type(button) ~= "table" then return end
	if button.shadow or button.EltruismShadowChecked then return end
	if isMasqueLoaded then return end

	local eltreumDB = E.db.ElvUI_EltreumUI
	if not eltreumDB then return end
	local shadowDB = eltreumDB.skins and eltreumDB.skins.shadow
	if not shadowDB or not shadowDB.enable or not shadowDB.npauras or shadowDB.universalshadows then
		button.EltruismShadowChecked = true
		return
	end
	local bordersDB = eltreumDB.borders
	if bordersDB and (bordersDB.universalborders or (bordersDB.borders and bordersDB.aurabordernp)) then
		button.EltruismShadowChecked = true
		return
	end

	if not E:NotSecretValue(button) then return end

	AddShadow(button, shadowDB.length, shadowDB)
	button.EltruismShadowChecked = true
end
ElvUI_EltreumUI:SecureHook(NP, 'Construct_AuraIcon', 'Construct_AuraIcon') --nameplate buffs/debuffs shadows

local function ApplyAuraShadowInternal(button, button2)
	local target = button2 or button
	if not target or type(target) ~= "table" then return end

	local container = (button2 and button) or target.container or (target.GetParent and target:GetParent())
	if container and container.isHighlight then
		target.EltruismShadowChecked = true
		return
	end

	local eltreumDB = E.db.ElvUI_EltreumUI
	if not eltreumDB then return end
	local shadowDB = eltreumDB.skins and eltreumDB.skins.shadow
	if not shadowDB or not shadowDB.enable or shadowDB.universalshadows then
		target.EltruismShadowChecked = true
		return
	end

	local bordersDB = eltreumDB.borders
	if bordersDB and bordersDB.universalborders then
		target.EltruismShadowChecked = true
		return
	end

	local isBar, shadowEnabled = ResolveAuraShadowEnabled(container, target, shadowDB, bordersDB)
	if target.shadow and not isBar then
		target.EltruismShadowChecked = true
		return
	end

	if not shadowEnabled then
		if not isBar then
			target.EltruismShadowChecked = true
		end
		return
	end

	if not E:NotSecretValue(target) then return end

	if not target.shadow then
		AddShadow(target, shadowDB.length, shadowDB)
	end

	if not isBar then
		target.EltruismShadowChecked = true
	elseif target.shadow then
		local barContainer = (button2 and button) or container
		if barContainer and barContainer.isAuraBar then
			local len = shadowDB.length
			if eltreumDB.unitframes and eltreumDB.unitframes.thinmodeaurabars then
				if target.statusbar and (target.EltruismBarShadowMode ~= "thin" or target.EltruismBarShadowLen ~= len) then
					AnchorShadow(target.shadow, target.statusbar, target.statusbar, len, len)
				end
				if target.backdrop then
					if not target.iconShadow then
						target.iconShadow = AddShadow(target, len, shadowDB, nil, true)
					end
					if target.iconShadow then
						local level = target:GetFrameLevel()
						local iconLevel = level > 1 and (level - 1) or 1
						if target.EltruismIconShadowLevel ~= iconLevel then
							target.iconShadow:SetFrameLevel(iconLevel)
							target.EltruismIconShadowLevel = iconLevel
						end
						if target.EltruismBarShadowMode ~= "thin" or target.EltruismBarShadowLen ~= len then
							target.iconShadow:Show()
							AnchorShadow(target.iconShadow, target.backdrop, target.backdrop, len, len)
						end
					end
				end
				target.EltruismBarShadowMode = "thin"
				target.EltruismBarShadowLen = len
			else
				if target.iconShadow and target.EltruismBarShadowMode ~= "normal" then
					target.iconShadow:Hide()
				end
				if target.backdrop and target.statusbar and (target.EltruismBarShadowMode ~= "normal" or target.EltruismBarShadowLen ~= len) then
					AnchorShadow(target.shadow, target.backdrop, target.statusbar, len, len)
				end
				target.EltruismBarShadowMode = "normal"
				target.EltruismBarShadowLen = len
			end
		end
	end
end

function ElvUI_EltreumUI:AuraShadows(button, button2) --button can be container or the bar, so check for the second arg, which then will be the bar itself
	if isMasqueLoaded then return end
	if not button then return end
	ApplyAuraShadowInternal(button, button2)
end

if E.Modern then
	function ElvUI_EltreumUI:Auras_UpdateButton(_, container, button)
		if isMasqueLoaded then return end
		if not button and container and type(container) == "table" and container.GetParent then
			button = container
			container = button:GetParent()
		end
		if not button or type(button) ~= "table" then return end

		local isAuraBar = type(container) == "table" and container.isAuraBar
		if isAuraBar or (not button.shadow and not button.EltruismShadowChecked) then
			if container then
				ApplyAuraShadowInternal(container, button)
			end
		end

		local eltreumDB = E.db.ElvUI_EltreumUI
		local bordersDB = eltreumDB and eltreumDB.borders
		if (bordersDB and bordersDB.borders) or button.EltruismAuraBorder then
			ElvUI_EltreumUI:UpdateAuraBorder(container, button)
		end

		if isAuraBar and button.statusbar then
			ElvUI_EltreumUI:AuraBarRetail(container, button)
		end
	end
	ElvUI_EltreumUI:SecureHook(E, 'Auras_UpdateButton', 'Auras_UpdateButton')

	function ElvUI_EltreumUI:Auras_CreateButton(_, button)
		if isMasqueLoaded then return end
		if not button or type(button) ~= "table" then return end
		if button.shadow or button.EltruismShadowChecked then return end

		local container = button.container or (button.GetParent and button:GetParent())
		if not container then return end
		ApplyAuraShadowInternal(container, button)
	end
	ElvUI_EltreumUI:SecureHook(E, 'Auras_CreateButton', 'Auras_CreateButton')
else
	function ElvUI_EltreumUI:CreateIcon(_, button)
		if not button or type(button) ~= "table" or not button.GetParent then return end
		local parent = button:GetParent()
		ElvUI_EltreumUI:UpdateAuraBorder(parent, button)
		if not isMasqueLoaded then
			ApplyAuraShadowInternal(button)
		end
	end
	ElvUI_EltreumUI:SecureHook(A, 'CreateIcon', 'CreateIcon') --aura (minimap)
end

function ElvUI_EltreumUI:UFAuraShadows(_, button)
	if not button or type(button) ~= "table" then return end
	if button.shadow or button.EltruismShadowChecked then return end
	if isMasqueLoaded then return end

	local eltreumDB = E.db.ElvUI_EltreumUI
	if not eltreumDB then return end
	local shadowDB = eltreumDB.skins and eltreumDB.skins.shadow
	if not shadowDB or not shadowDB.enable or not shadowDB.ufaura or shadowDB.universalshadows then
		button.EltruismShadowChecked = true
		return
	end
	local bordersDB = eltreumDB.borders
	if bordersDB and (bordersDB.universalborders or (bordersDB.borders and bordersDB.auraborderuf)) then
		button.EltruismShadowChecked = true
		return
	end

	if not E:NotSecretValue(button) then return end

	AddShadow(button, shadowDB.length, shadowDB)
	button.EltruismShadowChecked = true
end
ElvUI_EltreumUI:SecureHook(UF, 'Construct_AuraIcon', 'UFAuraShadows') --uf aura shadows

--from elvui chat bubbles
function ElvUI_EltreumUI:ChatBubblesShadows(_, bubble, holder)
	local eltreumDB = E.db.ElvUI_EltreumUI
	local shadowDB = eltreumDB.skins.shadow
	if not shadowDB.enable or shadowDB.universalshadows or eltreumDB.borders.universalborders then return end
	if not holder or holder:IsForbidden() then return end

	local style = E.private.general.chatBubbles
	local len = shadowDB.length
	if style == "backdrop" then
		AddShadow(bubble, len, shadowDB)
	elseif style == "backdrop_noborder" then
		if not holder.shadow then
			local shadow = AddShadow(holder, len, shadowDB)
			if shadow and holder.Center then
				AnchorShadow(shadow, holder.Center, holder.Center, len, len)
			end
		end
	end
end
ElvUI_EltreumUI:SecureHook(M, "SkinBubble", "ChatBubblesShadows")

--datatexts
function ElvUI_EltreumUI:DataTextShadowsAndBorders(_, name)
	local eltreumDB = E.db.ElvUI_EltreumUI
	local shadowDB = eltreumDB.skins.shadow
	if eltreumDB.borders.universalborders or shadowDB.universalshadows then return end
	if not name or type(name) ~= "string" then return end
	local panel = DT:FetchFrame(name)
	if not panel then return end

	if shadowDB.enable and shadowDB.datatexts then
		E:Delay(0.5, function() --needs a delay to wait for the panel setup
			if not panel.template then return end
			if panel.template ~= 'NoBackdrop' then
				local db = E.db.ElvUI_EltreumUI.skins.shadow
				AddShadow(panel, db.length, db)
			end
		end)
	end
	if eltreumDB.borders.borders and eltreumDB.borders.datatexts then
		ElvUI_EltreumUI:DataTextBorders(panel)
	end
end
ElvUI_EltreumUI:SecureHook(DT, "BuildPanelFrame", "DataTextShadowsAndBorders")
