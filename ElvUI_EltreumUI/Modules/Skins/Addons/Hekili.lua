local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G

--basic hekili shadows
function ElvUI_EltreumUI:EltruismHekili()
	if E.db.ElvUI_EltreumUI.skins.hekili then
		E:Delay(0, function()
			for i = 1, 10 do
				if _G["Hekili_Primary_B"..i] then
					S:HandleButton(_G["Hekili_Primary_B"..i])
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_Primary_B"..i].shadow then
						_G["Hekili_Primary_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_Primary_B"..i].shadow)
					end
					if _G["Hekili_Primary_B"..i].Highlight then
						_G["Hekili_Primary_B"..i].Highlight:SetAlpha(0)
					end
				end
				if _G["Hekili_Defensives_B"..i] then
					S:HandleButton(_G["Hekili_Defensives_B"..i])
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_Defensives_B"..i].shadow then
						_G["Hekili_Defensives_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_Defensives_B"..i].shadow)
					end
					if _G["Hekili_Defensives_B"..i].Highlight then
						_G["Hekili_Defensives_B"..i].Highlight:SetAlpha(0)
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('Hekili', "EltruismHekili", ElvUI_EltreumUI.EltruismHekili)
