local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G

--skin RareScanner
function ElvUI_EltreumUI:EltruismRareScanner()
	if E.db.ElvUI_EltreumUI.skins.rarescanner then
		if _G["scanner_button"] and not _G["scanner_button"].IsSkinned then
			S:HandleFrame(_G["scanner_button"], "Transparent")

			--button is too small sometimes, resize
			_G["scanner_button"].CloseButton:SetSize(25,25)

			-- the minus button
			if _G["scanner_button"].FilterEntityButton then
				S:HandleButton(_G["scanner_button"].FilterEntityButton)
				_G["scanner_button"].FilterEntityButton:SetNormalTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\minus")
				_G["scanner_button"].FilterEntityButton:SetPushedTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\minus")
			end

			--the skull
			if _G["scanner_button"].UnfilterEnabledButton then
				S:HandleButton(_G["scanner_button"].UnfilterEnabledButton)
				_G["scanner_button"].UnfilterEnabledButton:SetNormalTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull5")
				_G["scanner_button"].UnfilterEnabledButton:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
				_G["scanner_button"].UnfilterEnabledButton:SetPushedTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull5")
				_G["scanner_button"].UnfilterEnabledButton:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
			end

			if E.db.ElvUI_EltreumUI.skins.shadow.enable then
				if not E.Classic then
					if _G["scanner_button"] and not _G["scanner_button"].shadow then
						_G["scanner_button"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["scanner_button"].shadow) end
					end
				else
					if _G["scanner_button"] and _G["scanner_button"].backdrop and not _G["scanner_button"].backdrop.shadow then
						_G["scanner_button"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["scanner_button"].backdrop.shadow) end
					end
				end
			end

			_G["scanner_button"].IsSkinned = true
		end

		--hooksecurefunc(scanner_button,"ShowButton",function()
		hooksecurefunc(scanner_button.LootBar.itemFramesPool,"ShowIfReady",function() --item delay so hook later function
			E:Delay(0, function()
				if _G["LootBar"] and _G["LootBar"]:IsVisible() then
					for _, v in pairs{_G["LootBar"]:GetChildren()} do
						if v and v.Icon and not v.IsSkinned then
							v.Icon:SetTexCoord(unpack(E.TexCoords))
							--S:HandleFrame(v) --can end up erasing icon
							v:CreateBackdrop()
							if E.db.ElvUI_EltreumUI.skins.shadow.enable and not v.shadow then
								v:CreateShadow(2)
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
