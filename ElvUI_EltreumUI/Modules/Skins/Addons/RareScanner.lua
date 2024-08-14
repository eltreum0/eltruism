local E, L = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G

--skin RareScanner
function ElvUI_EltreumUI:EltruismRareScanner()
	if E.db.ElvUI_EltreumUI.skins.rarescanner then
		if _G["RARESCANNER_BUTTON"] and not _G["RARESCANNER_BUTTON"].IsSkinned then
			S:HandleFrame(_G["RARESCANNER_BUTTON"], "Transparent")

			--button is too small sometimes, resize
			_G["RARESCANNER_BUTTON"].CloseButton:SetSize(25,25)

			-- the minus button
			if _G["RARESCANNER_BUTTON"].FilterEntityButton then
				S:HandleButton(_G["RARESCANNER_BUTTON"].FilterEntityButton)
				_G["RARESCANNER_BUTTON"].FilterEntityButton:SetNormalTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\minus")
				_G["RARESCANNER_BUTTON"].FilterEntityButton:SetPushedTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\minus")
			end

			--the skull
			if _G["RARESCANNER_BUTTON"].UnfilterEnabledButton then
				S:HandleButton(_G["RARESCANNER_BUTTON"].UnfilterEnabledButton)
				_G["RARESCANNER_BUTTON"].UnfilterEnabledButton:SetNormalTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull5")
				_G["RARESCANNER_BUTTON"].UnfilterEnabledButton:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
				_G["RARESCANNER_BUTTON"].UnfilterEnabledButton:SetPushedTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull5")
				_G["RARESCANNER_BUTTON"].UnfilterEnabledButton:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
			end

			if E.db.ElvUI_EltreumUI.skins.shadow.enable then
				if not E.Classic then
					if _G["RARESCANNER_BUTTON"] and not _G["RARESCANNER_BUTTON"].shadow then
						_G["RARESCANNER_BUTTON"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["RARESCANNER_BUTTON"].shadow)
					end
				else
					if _G["RARESCANNER_BUTTON"] and _G["RARESCANNER_BUTTON"].backdrop and not _G["RARESCANNER_BUTTON"].backdrop.shadow then
						_G["RARESCANNER_BUTTON"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["RARESCANNER_BUTTON"].backdrop.shadow)
					end
				end
			end

			_G["RARESCANNER_BUTTON"].IsSkinned = true
		end

		-- the search box is not named, use get children
		for _, v in pairs({_G["WorldMapFrame"]:GetChildren()}) do
			if v and v:GetObjectType() == "Frame" and v.EditBox and v.relativeFrame then
				S:HandleEditBox(v)

				--add shadows too
				if not v.shadow then
					v:CreateShadow()
					ElvUI_EltreumUI:ShadowColor(v.shadow)
				end

				--elvui didnt get rid of the blizzard texture
				for _, j in pairs({v.EditBox:GetRegions()}) do
					if j:GetObjectType() == "Texture" and j:GetTexture() then
						j:SetTexture(nil)
					end
				end

				--move because map should be clean
				v:ClearAllPoints()
				v:SetPoint("BOTTOM", _G["WorldMapFrame"].ScrollContainer, "TOP", -30, 37)

				--adjust size so its not too big
				local width,height = v:GetSize()
				v:SetSize(width*1.25,height/1.25)

				--add a description so people dont wonder what it is
				local Desc = v:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				Desc:SetFont(E.media.normFont, 10, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				Desc:SetTextColor(1, 1, 1)
				Desc:SetText(L["MAP_SEARCHER_TOOLTIP_TITLE"])
				Desc:SetPoint("RIGHT", v, "LEFT", 0, 0)
				break
			end
		end

		--hooksecurefunc(scanner_button,"ShowButton",function()
		hooksecurefunc(_G["RARESCANNER_BUTTON"].LootBar.itemFramesPool,"ShowIfReady",function() --item delay so hook later function
			E:Delay(0, function()
				if _G["LootBar"] and _G["LootBar"]:IsVisible() then
					for _, v in pairs{_G["LootBar"]:GetChildren()} do
						if v and v.Icon and not v.IsSkinned then
							v.Icon:SetTexCoord(unpack(E.TexCoords))
							--S:HandleFrame(v) --can end up erasing icon
							v:CreateBackdrop()
							if E.db.ElvUI_EltreumUI.skins.shadow.enable and not v.shadow then
								v:CreateShadow(2)
								ElvUI_EltreumUI:ShadowColor(v.shadow)
							end
							v.IsSkinned = true
						end
					end
				end
			end)
		end)

	end
end
S:AddCallbackForAddon('RareScanner', "EltruismRareScanner", ElvUI_EltreumUI.EltruismRareScanner)
