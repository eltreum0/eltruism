local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--skin RareScanner
function ElvUI_EltreumUI:EltruismRareScanner()
	if E.db.ElvUI_EltreumUI.skins.rarescanner then
		if _G["scanner_button"] and not _G["scanner_button"].IsSkinned then
			S:HandleFrame(_G["scanner_button"], "Transparent")

			--button is too small sometimes, resize
			_G["scanner_button"].CloseButton:SetSize(25,25)

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

		hooksecurefunc(scanner_button,"ShowButton",function()
			if _G["LootBar"] then
				for _, v in pairs{_G["LootBar"]:GetChildren()} do
					if v and v.Icon and not v.EltruismSkin then
						--v.Icon:SetTexCoord(unpack(E.TexCoords))
						S:HandleFrame(v)
						if not v.shadow then
							v:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(v.shadow) end
						end
						v.EltruismSkin = true
					end
				end
			end
		end)

	end
end
S:AddCallbackForAddon('RareScanner', "EltruismRareScanner", ElvUI_EltreumUI.EltruismRareScanner)
