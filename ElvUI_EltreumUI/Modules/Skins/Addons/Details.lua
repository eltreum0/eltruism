local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateColor = _G.CreateColor

local classes = {
	["WARRIOR"] = true,
	["PALADIN"] = true,
	["HUNTER"] = true,
	["MONK"] = true,
	["ROGUE"] = true,
	["PRIEST"] = true,
	["DEATHKNIGHT"] = true,
	["SHAMAN"] = true,
	["MAGE"] = true,
	["WARLOCK"] = true,
	["DRUID"] = true,
	["DEMONHUNTER"] = true,
	["EVOKER"] = true
}

--Details gradient, inspired by aftermathh's edit but had to delve deeper into it, too many things going on there
function ElvUI_EltreumUI:EltruismDetails()
	if E.db.ElvUI_EltreumUI.skins.details then
		local Details = _G.Details
		local unitclass
		hooksecurefunc(Details, "InstanceRefreshRows", function(instancia)
			if instancia.barras and instancia.barras[1] then
				for _, row in next, instancia.barras do
					if row and row.textura then
						hooksecurefunc(row.textura, "SetVertexColor", function(_, r, g, b) --managed to hook the global to set vertex color on this only, might be useful later
							if E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite then
								row.textura:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixelB")
							end
							if row.minha_tabela and row.minha_tabela.name then
								unitclass = row.minha_tabela:class() --from details api returns class of that row
								if unitclass ~='UNKNOW' and classes[unitclass] then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass))
									else
										row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(unitclass))
									end
								else
									if E.Retail then
										row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(r-0.5, g-0.5, b-0.5, 0.9), CreateColor(r+0.2, g+0.2, b+0.2, 0.9))
									else
										row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
									end
								end
							else
								if E.Retail then
									row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(r-0.5, g-0.5, b-0.5, 0.9), CreateColor(r+0.2, g+0.2, b+0.2, 0.9))
								else
									row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
								end
							end
						end)
					end
				end
			end
		end)
	end
end
S:AddCallbackForAddon('Details', "EltruismDetails", ElvUI_EltreumUI.EltruismDetails)
