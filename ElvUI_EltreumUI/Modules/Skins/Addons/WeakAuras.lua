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
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.blizzard and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not _G.WeakAurasOptions.shadow then
						ElvUI_EltreumUI:CreateFastShadow(_G.WeakAurasOptions, E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('WeakAurasOptions', "EltruismWeakAurasOptions", ElvUI_EltreumUI.EltruismWeakAurasOptions)
