local E, L = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded
local unpack = _G.unpack
local next = _G.next
local InCombatLockdown = _G.InCombatLockdown
local embedpanel
local DetailsHooked = false
local RightChatDetailsHook = false

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
			if not DetailsHooked then
				local Details = _G.Details
				if not E.Classic then
					--gradient name (damage)
					hooksecurefunc(Details.atributo_damage,"RefreshLine", function(_,_, lineContainer, whichRowLine)
						local thisLine = lineContainer[whichRowLine]
						if not thisLine then return end
						if thisLine.lineText1 then
							thisLine.lineText1:SetText(thisLine.colocacao .. ". " .. ElvUI_EltreumUI:GradientName(thisLine.minha_tabela:GetDisplayName(), thisLine.minha_tabela:class()))
						end
					end)
					--gradient name (heal)
					hooksecurefunc(Details.atributo_heal,"RefreshLine", function(_,instancia, _, whichRowLine)
						local thisLine = instancia.barras[whichRowLine]
						if not thisLine then return end
						if thisLine.lineText1 then
							thisLine.lineText1:SetText(thisLine.colocacao .. ". " .. ElvUI_EltreumUI:GradientName(thisLine.minha_tabela:GetDisplayName(), thisLine.minha_tabela:class()))
						end
					end)
				else
					local _detalhes = _G._detalhes
					--gradient name (damage)
					hooksecurefunc(_detalhes.atributo_damage,"AtualizaBarra", function(_,instancia, _, qual_barra)
						local esta_barra = instancia.barras[qual_barra]
						if not esta_barra then return end
						if esta_barra.texto_esquerdo then
							esta_barra.texto_esquerdo:SetText(esta_barra.colocacao .. ". " .. ElvUI_EltreumUI:GradientName(esta_barra.minha_tabela:GetDisplayName(), esta_barra.minha_tabela:class()))
						end
					end)
					--gradient name (heal)
					hooksecurefunc(_detalhes.atributo_heal,"AtualizaBarra", function(_,instancia, _, qual_barra)
						local esta_barra = instancia.barras[qual_barra]
						if not esta_barra then return end
						if esta_barra.texto_esquerdo then
							esta_barra.texto_esquerdo:SetText(esta_barra.colocacao .. ". " .. ElvUI_EltreumUI:GradientName(esta_barra.minha_tabela:GetDisplayName(), esta_barra.minha_tabela:class()))
						end
					end)
				end
				--gradient texture
				hooksecurefunc(Details, "InstanceRefreshRows", function(instancia)
					if instancia.barras and instancia.barras[1] then
						for _, row in next, instancia.barras do
							if row and row.textura and not row.textura.EltruismHook then
								hooksecurefunc(row.textura, "SetVertexColor", function(_, r, g, b) --managed to hook the global to set vertex color on this only, might be useful later
									if E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite then
										row.textura:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixelB")
									end
									if row.minha_tabela and row.minha_tabela.name then
										local unitclass = row.minha_tabela:class() --from details api returns class of that row
										if classes[unitclass] then
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
								row.textura.EltruismHook = true
							end
						end
					end
				end)
				DetailsHooked = true
			end
		end

		--add a basic embed if addonskins is not loaded`
		if E.db.ElvUI_EltreumUI.skins.detailsembed then
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
					if E.private.mui.skins.embed.enable then
						checkembed = false
					else
						checkembed = true
					end
				end
			else
				checkembed = true
			end

			if checkembed == true then
				if not _G["EltruismDetailsEmbedPanel"] then
					embedpanel = CreateFrame("FRAME","EltruismDetailsEmbedPanel")
				else
					embedpanel = _G["EltruismDetailsEmbedPanel"]
				end

				if not InCombatLockdown() then
					embedpanel:SetAllPoints(_G["RightChatPanel"])
					embedpanel:SetParent(UIParent)
					embedpanel:SetFrameStrata("BACKGROUND")

					if E.db["chat"]["panelBackdrop"] == "RIGHT" or E.db["chat"]["panelBackdrop"] == "SHOWBOTH" then
						S:HandleFrame(embedpanel)
						if E.db.ElvUI_EltreumUI.skins.shadow.enable then
							if embedpanel and not embedpanel.shadow then
								embedpanel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(embedpanel.shadow)
							end
						end
					end

					for i = 1, 3 do
						if _G["DetailsBaseFrame"..i] then
							_G["DetailsBaseFrame"..i]:SetParent(embedpanel)
							_G["DetailsRowFrame"..i]:SetParent(embedpanel)
							_G["Details_SwitchButtonFrame"..i]:SetParent(embedpanel)
						end
					end
					if _G["DetailsBaseFrame1"] then
						_G["DetailsBaseFrame1"]:ClearAllPoints()
						_G["DetailsBaseFrame1"]:SetPoint("LEFT", embedpanel, "LEFT",0,-10)
					end
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
								E.db.ElvUI_EltreumUI.skins.detailsembedhidden = false
						end
					elseif event == "PLAYER_REGEN_ENABLED" then
						if E.db.ElvUI_EltreumUI.skins.detailsembedooc then
							E:Delay(E.db.ElvUI_EltreumUI.skins.detailsdelay, function()
								embedpanel:Hide()
								_G["RightChatPanel"]:Show()
								E.db.ElvUI_EltreumUI.skins.detailsembedhidden = true
							end)
						end
					elseif event == "PLAYER_ENTERING_WORLD" then
						if E.db.ElvUI_EltreumUI.skins.detailsembedhidden then
							embedpanel:Hide()
							_G["RightChatPanel"]:Show()
						else
							embedpanel:Show()
							_G["RightChatPanel"]:Hide()
						end
					end
					if not E.db.ElvUI_EltreumUI.skins.detailsembedooc then
						embedpanel:UnregisterEvent("PLAYER_REGEN_ENABLED")
						embedpanel:UnregisterEvent("PLAYER_REGEN_DISABLED")
					end
				end)

				if not RightChatDetailsHook then
					_G.RightChatToggleButton:HookScript("OnClick" ,function(_,button)
						if button == 'RightButton' then
							if embedpanel:IsShown() then
								embedpanel:Hide()
								_G["RightChatPanel"]:Show()
								E.db.ElvUI_EltreumUI.skins.detailsembedhidden = true
							else
								embedpanel:Show()
								_G["RightChatPanel"]:Hide()
								E.db.ElvUI_EltreumUI.skins.detailsembedhidden = false
							end
						end
					end)

					_G.RightChatToggleButton:HookScript('OnEnter', function()
						_G.GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Details"], 1, 1, 1)
						_G.GameTooltip:Show()
					end)

					RightChatDetailsHook = true
				end
			end
		end
	end
	S:AddCallbackForAddon('Details', "EltruismDetails", ElvUI_EltreumUI.EltruismDetails)

end
