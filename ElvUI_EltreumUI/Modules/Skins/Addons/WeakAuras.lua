local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G

function ElvUI_EltreumUI:EltruismWeakAurasOptions()
	if E.db.ElvUI_EltreumUI.skins.weakaurasoptions then
		E:Delay(0, function()
			if _G.WeakAurasOptions then
				S:HandleFrame(_G.WeakAurasOptions)
				S:HandleEditBox(_G.WeakAurasFilterInput)
				S:HandleMaxMinFrame(_G.WeakAurasOptions.MaxMinButtonFrame)
				S:HandleCloseButton(_G.WeakAurasOptionsCloseButton)
				if E.db.ElvUI_EltreumUI.skins.shadow.blizzard then
					if not _G.WeakAurasOptions.shadow then
						_G.WeakAurasOptions:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(_G.WeakAurasOptions.shadow)
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('WeakAurasOptions', "EltruismWeakAurasOptions", ElvUI_EltreumUI.EltruismWeakAurasOptions)
