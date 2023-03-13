local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

do

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
										if E.Retail or E.Wrath then
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
												row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass))
											else
												row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(unitclass))
											end
										else
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
												row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass))
											else
												row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(unitclass))
											end
										end
									else
										if E.Retail or E.Wrath then
											row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.5,g= g-0.5,b= b-0.5,a= 0.9}, {r=r+0.2,g= g+0.2,b= b+0.2,a= 0.9})
										else
											row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
										end
									end
								else
									if E.Retail or E.Wrath then
										row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.5,g= g-0.5,b= b-0.5,a= 0.9}, {r=r+0.2,g= g+0.2,b= b+0.2,a= 0.9})
									else
										row.textura:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
									end
								end
							end)
						end
					end
				end
			end)

			--add a basic embed if addonskins is not loaded
			local checkembed
			if IsAddOnLoaded("AddOnSkins") or IsAddOnLoaded("ElvUI_MerathilisUI") then
				if IsAddOnLoaded("AddOnSkins") then
					local AS = unpack(AddOnSkins)
					if not (AS.db["EmbedSystemDual"] or AS.db["EmbedSystem"]) then
						checkembed = true
					else
						checkembed = false
					end
				else
					checkembed = true
				end
				if IsAddOnLoaded("ElvUI_MerathilisUI") then
					if not (E.private.mui.skins.embed or E.private.mui.skins.embed.enable) then
						checkembed = true
					else
						checkembed = false
					end
				end
			else
				checkembed = true
			end

			if checkembed == true and E.db.ElvUI_EltreumUI.skins.detailsembed then
				local embedpanel = CreateFrame("FRAME","EltruismDetailsEmbedPanel")
				embedpanel:SetAllPoints(_G["RightChatPanel"])
				embedpanel:SetParent(UIParent)
				embedpanel:SetFrameStrata("BACKGROUND")

				if E.db["chat"]["panelBackdrop"] == "RIGHT" or E.db["chat"]["panelBackdrop"] == "SHOWBOTH" then
					S:HandleFrame(embedpanel)
					if E.db.ElvUI_EltreumUI.skins.shadow.enable then
						if embedpanel and not embedpanel.shadow then
							embedpanel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(embedpanel.shadow) end
						end
					end
				end

				for i = 1, 3 do
					if _G["DetailsBaseFrame"..i] then
						_G["DetailsBaseFrame"..i]:SetParent(embedpanel)
						_G["DetailsRowFrame"..i]:SetParent(embedpanel)
					end
				end
				if _G["DetailsBaseFrame1"] then
					_G["DetailsBaseFrame1"]:ClearAllPoints()
					_G["DetailsBaseFrame1"]:SetPoint("LEFT", embedpanel, "LEFT",0,-10)
				end

				if E.db.ElvUI_EltreumUI.skins.detailsembedooc then
					embedpanel:RegisterEvent("PLAYER_REGEN_ENABLED")
					embedpanel:RegisterEvent("PLAYER_REGEN_DISABLED")
				end
				embedpanel:RegisterEvent("PLAYER_ENTERING_WORLD")

				embedpanel:SetScript("OnEvent", function(_,event)
					if event == "PLAYER_REGEN_DISABLED" then
						if E.db.ElvUI_EltreumUI.skins.detailsembedooc then
								embedpanel:Show()
								_G["RightChatPanel"]:Hide()
						end
					elseif event == "PLAYER_REGEN_ENABLED" then
						if E.db.ElvUI_EltreumUI.skins.detailsembedooc then
							E:Delay(E.db.ElvUI_EltreumUI.skins.detailsdelay, function()
								embedpanel:Hide()
								_G["RightChatPanel"]:Show()
							end)
						end
					elseif event == "PLAYER_ENTERING_WORLD" then
						embedpanel:Hide()
						_G["RightChatPanel"]:Show()
					end
				end)

				_G.RightChatToggleButton:HookScript("OnClick" ,function(_,button)
					if button == 'RightButton' then
						if embedpanel:IsShown() then
							embedpanel:Hide()
							_G["RightChatPanel"]:Show()
						else
							embedpanel:Show()
							_G["RightChatPanel"]:Hide()
						end
					end
				end)

				_G.RightChatToggleButton:HookScript('OnEnter', function()
					_G.GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Details"], 1, 1, 1)
					_G.GameTooltip:Show()
				end)
			end

		end
	end
	S:AddCallbackForAddon('Details', "EltruismDetails", ElvUI_EltreumUI.EltruismDetails)

end
