local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local valuecolors = E:ClassColor(E.myclass, true)

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
			local header = Search.frame
			for i = 1, header:GetNumChildren() do
				local group = select(i, header:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

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
			local header2 = adv.frame
			for i = 1, header2:GetNumChildren() do
				local group = select(i, header2:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local Currency = f:GetModule("Currency")
			S:HandleFrame(Currency.frame)
			S:HandleCloseButton(Currency.frame.closeBtn)
			local header3 = Currency.frame
			for i = 1, header3:GetNumChildren() do
				local group = select(i, header3:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local Professions = f:GetModule("Professions")
			S:HandleFrame(Professions.frame)
			S:HandleCloseButton(Professions.frame.closeBtn)
			local header4 = Professions.frame
			for i = 1, header4:GetNumChildren() do
				local group = select(i, header4:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local Recipes = f:GetModule("Recipes")
			S:HandleFrame(Recipes.frame)
			S:HandleCloseButton(Recipes.frame.closeBtn)
			local header5 = Recipes.frame
			for i = 1, header5:GetNumChildren() do
				local group = select(i, header5:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local Blacklist = f:GetModule("Blacklist")
			S:HandleFrame(Blacklist.frame)
			S:HandleCloseButton(Blacklist.frame.closeBtn)
			S:HandleDropDownBox(Blacklist.frame.guildDD)
			S:HandleButton(Blacklist.frame.addGuildBtn)
			S:HandleButton(Blacklist.frame.addItemIDBtn)
			S:HandleEditBox(Blacklist.frame.itemIDBox)
			local header6 = Blacklist.frame
			for i = 1, header6:GetNumChildren() do
				local group = select(i, header6:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local Whitelist = f:GetModule("Whitelist")
			S:HandleFrame(Whitelist.frame)
			S:HandleCloseButton(Whitelist.frame.closeBtn)
			S:HandleButton(Whitelist.frame.addItemIDBtn)
			S:HandleEditBox(Whitelist.frame.itemIDBox)
			local header7 = Whitelist.frame
			for i = 1, header7:GetNumChildren() do
				local group = select(i, header7:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end
			S:HandleFrame(Whitelist.warningFrame)
			S:HandleCloseButton(Whitelist.warningFrame.CloseButton)

			local Gold = f:GetModule("Gold")
			S:HandleFrame(Gold.frame)
			S:HandleCloseButton(Gold.frame.closeBtn)
			local header8 = Gold.frame
			for i = 1, header8:GetNumChildren() do
				local group = select(i, header8:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local Profiles = f:GetModule("Profiles")
			S:HandleFrame(Profiles.frame)
			S:HandleCloseButton(Profiles.frame.closeBtn)
			local header9 = Profiles.frame
			for i = 1, header9:GetNumChildren() do
				local group = select(i, header9:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			local SortOrder = f:GetModule("SortOrder")
			S:HandleFrame(SortOrder.frame)
			S:HandleCloseButton(SortOrder.frame.closeBtn)
			local header10 = SortOrder.frame
			for i = 1, header10:GetNumChildren() do
				local group = select(i, header10:GetChildren())
				if group then
					if group.scrollChild then
						for itemnumber = 1, group.scrollChild:GetNumChildren() do
							local frame = select(itemnumber, group.scrollChild:GetChildren())
							if frame.SortBox then
								S:HandleEditBox(frame.SortBox)
							end
						end
					end
					if group.scrollBar then
						S:HandleScrollBar(group.scrollBar)
						group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
						group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
					end
				end
			end
			S:HandleFrame(SortOrder.warningFrame)
			S:HandleCloseButton(SortOrder.warningFrame.CloseButton)

			local Details = f:GetModule("Details")
			S:HandleFrame(Details.frame)
			S:HandleCloseButton(Details.frame.closeBtn)
			local header11 = Details.frame
			for i = 1, header11:GetNumChildren() do
				local group = select(i, header11:GetChildren())
				if group and group.scrollBar then
					S:HandleScrollBar(group.scrollBar)
					S:HandleFrame(group)
					group.scrollBar.thumbTexture:SetTexture(E.Media.Textures.Melli)
					group.scrollBar.thumbTexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
				end
			end

			--shadows
			if E.db.ElvUI_EltreumUI.skins.shadow.enable then
				if not Search.frame.shadow then
					Search.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Search.frame.shadow)
				end
				if not Search.helpFrame.shadow then
					Search.helpFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Search.helpFrame.shadow)
				end
				if not Search.savedSearch.shadow then
					Search.savedSearch:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Search.savedSearch.shadow)
				end
				if not adv.frame.shadow then
					adv.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(adv.frame.shadow)
				end
				if not Currency.frame.shadow then
					Currency.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Currency.frame.shadow)
				end
				if not Professions.frame.shadow then
					Professions.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Professions.frame.shadow)
				end
				if not Recipes.frame.shadow then
					Recipes.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Recipes.frame.shadow)
				end
				if not Blacklist.frame.shadow then
					Blacklist.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Blacklist.frame.shadow)
				end
				if not Whitelist.frame.shadow then
					Whitelist.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Whitelist.frame.shadow)
				end
				if not Whitelist.warningFrame.shadow then
					Whitelist.warningFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Whitelist.warningFrame.shadow)
				end
				if not Gold.frame.shadow then
					Gold.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Gold.frame.shadow)
				end
				if not Profiles.frame.shadow then
					Profiles.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Profiles.frame.shadow)
				end
				if not SortOrder.frame.shadow then
					SortOrder.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(SortOrder.frame.shadow)
				end
				if not SortOrder.warningFrame.shadow then
					SortOrder.warningFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(SortOrder.warningFrame.shadow)
				end
				if not Details.frame.shadow then
					Details.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					ElvUI_EltreumUI:ShadowColor(Details.frame.shadow)
				end
			end
		end)
	end
end
S:AddCallbackForAddon('BagSync', "EltruismBagSync", ElvUI_EltreumUI.EltruismBagSync)
