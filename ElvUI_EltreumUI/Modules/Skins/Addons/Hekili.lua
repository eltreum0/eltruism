local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G

--basic hekili shadows
function ElvUI_EltreumUI:EltruismHekili()
	if E.db.ElvUI_EltreumUI.skins.hekili then
		E:Delay(0, function()
			for i = 1, 10 do
				if _G["Hekili_Primary_B"..i] then
					local texture = _G["Hekili_Primary_B"..i].Texture
					S:HandleButton(_G["Hekili_Primary_B"..i])
					_G["Hekili_Primary_B"..i].Texture = texture
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_Primary_B"..i].shadow then
						_G["Hekili_Primary_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_Primary_B"..i].shadow)
					end
					if _G["Hekili_Primary_B"..i].Highlight then
						_G["Hekili_Primary_B"..i].Highlight:SetAlpha(0)
					end
					if _G["Hekili_Primary_B"..i].Empowerment then
						_G["Hekili_Primary_B"..i].Empowerment:SetAlpha(0)
					end
				end
				if _G["Hekili_Defensives_B"..i] then
					local texture2 = _G["Hekili_Defensives_B"..i].Texture
					S:HandleButton(_G["Hekili_Defensives_B"..i])
					_G["Hekili_Defensives_B"..i].Texture = texture2
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_Defensives_B"..i].shadow then
						_G["Hekili_Defensives_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_Defensives_B"..i].shadow)
					end
					if _G["Hekili_Defensives_B"..i].Highlight then
						_G["Hekili_Defensives_B"..i].Highlight:SetAlpha(0)
					end
					if _G["Hekili_Defensives_B"..i].Empowerment then
						_G["Hekili_Defensives_B"..i].Empowerment:SetAlpha(0)
					end
				end
				if _G["Hekili_Cooldowns_B"..i] then
					local texture3 = _G["Hekili_Cooldowns_B"..i].Texture
					S:HandleButton(_G["Hekili_Cooldowns_B"..i])
					_G["Hekili_Cooldowns_B"..i].Texture = texture3
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_Cooldowns_B"..i].shadow then
						_G["Hekili_Cooldowns_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_Cooldowns_B"..i].shadow)
					end
					if _G["Hekili_Cooldowns_B"..i].Highlight then
						_G["Hekili_Cooldowns_B"..i].Highlight:SetAlpha(0)
					end
					if _G["Hekili_Cooldowns_B"..i].Empowerment then
						_G["Hekili_Cooldowns_B"..i].Empowerment:SetAlpha(0)
					end
				end
				if _G["Hekili_AOE_B"..i] then
					local texture4 = _G["Hekili_AOE_B"..i].Texture
					S:HandleButton(_G["Hekili_AOE_B"..i])
					_G["Hekili_AOE_B"..i].Texture = texture4
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_AOE_B"..i].shadow then
						_G["Hekili_AOE_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_AOE_B"..i].shadow)
					end
					if _G["Hekili_AOE_B"..i].Highlight then
						_G["Hekili_AOE_B"..i].Highlight:SetAlpha(0)
					end
					if _G["Hekili_AOE_B"..i].Empowerment then
						_G["Hekili_AOE_B"..i].Empowerment:SetAlpha(0)
					end
				end
				if _G["Hekili_Interrupts_B"..i] then
					local texture5 = _G["Hekili_Interrupts_B"..i].Texture
					S:HandleButton(_G["Hekili_Interrupts_B"..i])
					_G["Hekili_Interrupts_B"..i] = texture5
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["Hekili_Interrupts_B"..i].shadow then
						_G["Hekili_Interrupts_B"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G["Hekili_Interrupts_B"..i].shadow)
					end
					if _G["Hekili_Interrupts_B"..i].Highlight then
						_G["Hekili_Interrupts_B"..i].Highlight:SetAlpha(0)
					end
					if _G["Hekili_Interrupts_B"..i].Empowerment then
						_G["Hekili_Interrupts_B"..i].Empowerment:SetAlpha(0)
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('Hekili', "EltruismHekili", ElvUI_EltreumUI.EltruismHekili)
