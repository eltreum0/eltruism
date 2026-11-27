local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local valuecolors = E.myClassColor
local select = _G.select

local function SkinScrollBars(useHandleFrame, ...)
	for i = 1, select("#", ...) do
		local group = select(i, ...)
		if group.scrollBar then
			S:HandleScrollBar(group.scrollBar)
			if useHandleFrame then
				S:HandleFrame(group)
			end
			group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
			group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
		end
	end
end

local function SkinSortBoxChildren(...)
	for itemnumber = 1, select("#", ...) do
		local frame = select(itemnumber, ...)
		if frame.SortBox then
			S:HandleEditBox(frame.SortBox)
		end
	end
end

local function SkinSortOrderChildren(...)
	for i = 1, select("#", ...) do
		local group = select(i, ...)
		if group.scrollChild then
			SkinSortBoxChildren(group.scrollChild:GetChildren())
		end
		if group.scrollBar then
			S:HandleScrollBar(group.scrollBar)
			group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
			group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 1)
		end
	end
end

--based on meeting horn skin
function ElvUI_EltreumUI:EltruismBagSync()
	if E.db.ElvUI_EltreumUI.skins.bagsync then

		local f = E.Libs.AceAddon:GetAddon("BagSync")

		--so addonskins breaks this since frame apparently doesnt exist yet (guess because it loads before), a delay fixes the issue
		E:Delay(0, function()
			local Search = f:GetModule("Search")
			S:HandleFrame(Search.frame)
			S:HandleEditBox(Search.frame.SearchBox)
			S:HandleButton(Search.frame.PlusButton)
			S:HandleButton(Search.frame.RefreshButton)
			S:HandleCloseButton(Search.frame.closeBtn)
			S:HandleButton(Search.frame.HelpButton)
			S:HandleButton(Search.frame.advSearchBtn)
			S:HandleButton(Search.frame.resetButton)
			SkinScrollBars(false, Search.frame:GetChildren())

			S:HandleFrame(Search.helpFrame)
			S:HandleCloseButton(Search.helpFrame.CloseButton)
			S:HandleScrollBar(Search.helpFrame.ScrollFrame.ScrollBar)

			S:HandleFrame(Search.savedSearch)
			S:HandleCloseButton(Search.savedSearch.CloseButton)
			S:HandleButton(Search.savedSearch.addSavedBtn)
			S:HandleScrollBar(Search.savedSearch.scrollFrame.scrollBar)
			S:HandleFrame(Search.savedSearch.scrollFrame.scrollChild)
			Search.savedSearch.scrollFrame.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
			Search.savedSearch.scrollFrame.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)

			local adv = f:GetModule("AdvancedSearch")
			S:HandleFrame(adv.frame)
			S:HandleEditBox(adv.frame.SearchBox)
			S:HandleButton(adv.frame.PlusButton)
			S:HandleButton(adv.frame.RefreshButton)
			S:HandleCloseButton(adv.frame.closeBtn)
			S:HandleButton(adv.frame.selectAllButton)
			S:HandleButton(adv.frame.resetButton)
			SkinScrollBars(false, adv.frame:GetChildren())

			local Currency = f:GetModule("Currency")
			S:HandleFrame(Currency.frame)
			S:HandleCloseButton(Currency.frame.closeBtn)
			SkinScrollBars(false, Currency.frame:GetChildren())

			local Professions = f:GetModule("Professions")
			S:HandleFrame(Professions.frame)
			S:HandleCloseButton(Professions.frame.closeBtn)
			SkinScrollBars(false, Professions.frame:GetChildren())

			local Recipes = f:GetModule("Recipes")
			S:HandleFrame(Recipes.frame)
			S:HandleCloseButton(Recipes.frame.closeBtn)
			SkinScrollBars(false, Recipes.frame:GetChildren())

			local Blacklist = f:GetModule("Blacklist")
			S:HandleFrame(Blacklist.frame)
			S:HandleCloseButton(Blacklist.frame.closeBtn)
			S:HandleDropDownBox(Blacklist.frame.guildDD)
			S:HandleButton(Blacklist.frame.addGuildBtn)
			S:HandleButton(Blacklist.frame.addItemIDBtn)
			S:HandleEditBox(Blacklist.frame.itemIDBox)
			SkinScrollBars(false, Blacklist.frame:GetChildren())

			local Whitelist = f:GetModule("Whitelist")
			S:HandleFrame(Whitelist.frame)
			S:HandleCloseButton(Whitelist.frame.closeBtn)
			S:HandleButton(Whitelist.frame.addItemIDBtn)
			S:HandleEditBox(Whitelist.frame.itemIDBox)
			SkinScrollBars(false, Whitelist.frame:GetChildren())
			S:HandleFrame(Whitelist.warningFrame)
			S:HandleCloseButton(Whitelist.warningFrame.CloseButton)

			local Gold = f:GetModule("Gold")
			S:HandleFrame(Gold.frame)
			S:HandleCloseButton(Gold.frame.closeBtn)
			SkinScrollBars(false, Gold.frame:GetChildren())

			local Profiles = f:GetModule("Profiles")
			S:HandleFrame(Profiles.frame)
			S:HandleCloseButton(Profiles.frame.closeBtn)
			SkinScrollBars(false, Profiles.frame:GetChildren())

			local SortOrder = f:GetModule("SortOrder")
			S:HandleFrame(SortOrder.frame)
			S:HandleCloseButton(SortOrder.frame.closeBtn)
			SkinSortOrderChildren(SortOrder.frame:GetChildren())
			S:HandleFrame(SortOrder.warningFrame)
			S:HandleCloseButton(SortOrder.warningFrame.CloseButton)

			local Details = f:GetModule("Details")
			S:HandleFrame(Details.frame)
			S:HandleCloseButton(Details.frame.closeBtn)
			SkinScrollBars(true, Details.frame:GetChildren())

			--shadows
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
				if not Search.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Search.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Search.helpFrame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Search.helpFrame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Search.savedSearch.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Search.savedSearch, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not adv.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(adv.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Currency.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Currency.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Professions.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Professions.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Recipes.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Recipes.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Blacklist.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Blacklist.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Whitelist.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Whitelist.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Whitelist.warningFrame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Whitelist.warningFrame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Gold.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Gold.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Profiles.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Profiles.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not SortOrder.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(SortOrder.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not SortOrder.warningFrame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(SortOrder.warningFrame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
				if not Details.frame.shadow then
					ElvUI_EltreumUI:CreateFastShadow(Details.frame, E.db.ElvUI_EltreumUI.skins.shadow.length)
				end
			end
		end)
	end
end
--S:AddCallbackForAddon('BagSync', "EltruismBagSync", ElvUI_EltreumUI.EltruismBagSync)
