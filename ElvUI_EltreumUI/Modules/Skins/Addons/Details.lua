local E, L = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local unpack = _G.unpack
local next = _G.next
local InCombatLockdown = _G.InCombatLockdown
local embedpanel
local DetailsHooked = false
local RightChatDetailsHook = false
local GetAddOnMetadata = _G.C_AddOns and _G.C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

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

		--check for correct details version, add a print if using wrong one
		local checkdetails = GetAddOnMetadata("Details","Version")
		if not checkdetails then
			ElvUI_EltreumUI:Print("Details Classic Version is not recommended, use the regular Version which is better supported.")
			return
		end

		if E.db.ElvUI_EltreumUI.skins.details then
			if not DetailsHooked then
				local Details = _G.Details

				if E.db.ElvUI_EltreumUI.skins.detailsgradientname then
					--gradient name (damage)
					hooksecurefunc(Details.atributo_damage,"RefreshLine", function(_,_, lineContainer, whichRowLine)
						local thisLine = lineContainer[whichRowLine]
						if not thisLine then return end
						if thisLine.lineText1 then
							--local name = E:StripString(thisLine.minha_tabela:GetDisplayName())
							--print(thisLine.minha_tabela:GetDisplayName(),name,ElvUI_EltreumUI:ShortenString(name, 10, true))
							local name = E:StripString(thisLine.lineText1:GetText())
							--local name = thisLine.lineText1:GetText()
							--if not name:match("|cff") then
								thisLine.lineText1:SetText(ElvUI_EltreumUI:GradientName(ElvUI_EltreumUI:ShortenString(name, 11, true), thisLine.minha_tabela:class()))
							--end
							if E.db.ElvUI_EltreumUI.skins.detailsgradientnameshadow then
								thisLine.lineText1:SetShadowOffset(2, -2)
							end
						end
					end)
					--gradient name (heal)
					hooksecurefunc(Details.atributo_heal,"RefreshLine", function(_,instancia, _, whichRowLine)
						local thisLine = instancia.barras[whichRowLine]
						if not thisLine then return end
						if thisLine.lineText1 then
							--local name = E:StripString(thisLine.minha_tabela:GetDisplayName())
							local name = E:StripString(thisLine.lineText1:GetText())
							--thisLine.lineText1:SetText(ElvUI_EltreumUI:GradientName(thisLine.colocacao .. ". " .. ElvUI_EltreumUI:ShortenString(name, 10, true), thisLine.minha_tabela:class()))
							--local name = thisLine.lineText1:GetText()
							--if not name:match("|cff") then
								thisLine.lineText1:SetText(ElvUI_EltreumUI:GradientName(ElvUI_EltreumUI:ShortenString(name, 11, true), thisLine.minha_tabela:class()))
							--end
							if E.db.ElvUI_EltreumUI.skins.detailsgradientnameshadow then
								thisLine.lineText1:SetShadowOffset(2, -2)
							end
						end
					end)
				end

				--gradient texture
				hooksecurefunc(Details, "InstanceRefreshRows", function(instancia)
					if instancia.barras and instancia.barras[1] then
						for _, row in next, instancia.barras do
							if not row then return end
							if E.db.ElvUI_EltreumUI.skins.detailsmode == "LIGHT" then
								if row.textura and not row.textura.EltruismHook then
									hooksecurefunc(row.textura, "SetVertexColor", function(_, r, g, b) --managed to hook the global to set vertex color on this only, might be useful later
										if E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite then
											--row.textura:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixelB")
											if not row.textura.EltruismMask then
												row.EltruismMask = row:CreateMaskTexture()
												row.EltruismMask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
												row.EltruismMask:SetAllPoints(row.textura)
												row.textura:AddMaskTexture(row.EltruismMask)
												row.textura.EltruismMask = true
											end
											if not row.statusbar.shadow then
												row.statusbar:CreateShadow()
												row.statusbar.shadow:ClearAllPoints()
												row.statusbar.shadow:SetPoint("BOTTOMLEFT", row.textura,"BOTTOMLEFT", -2.5, -2.5)
												row.statusbar.shadow:SetPoint("TOPRIGHT", row.textura,"TOPRIGHT", 2.5, -14)
											end
											row:SetHeight(21)
										end
										if row.minha_tabela and row.minha_tabela.name then
											local unitclass = row.minha_tabela:class() --from details api returns class of that row
											if classes[unitclass] then
												if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
													row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass))
												else
													row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(unitclass))
												end
											else
												row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.5,g= g-0.5,b= b-0.5,a= 0.9}, {r=r+0.2,g= g+0.2,b= b+0.2,a= 0.9})
											end
										else
											row.textura:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.5,g= g-0.5,b= b-0.5,a= 0.9}, {r=r+0.2,g= g+0.2,b= b+0.2,a= 0.9})
										end
									end)
									row.textura.EltruismHook = true
								end
							else
								if row.background and not row.background.EltruismHook then
									hooksecurefunc(row.background, "SetVertexColor", function(_, r, g, b) --managed to hook the global to set vertex color on this only, might be useful later
										if E.db.ElvUI_EltreumUI.skins.detailstextureoverwrite then
											--row.textura:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixelB")
											if not row.background.EltruismMask then
												row.EltruismMask = row:CreateMaskTexture()
												row.EltruismMask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
												row.EltruismMask:SetAllPoints(row.background)
												row.background:AddMaskTexture(row.EltruismMask)
												row.background.EltruismMask = true
											end
											if not row.textura.EltruismMask2 then
												row.EltruismMask2 = row:CreateMaskTexture()
												row.EltruismMask2:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum7pixel", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
												row.EltruismMask2:SetAllPoints(row.textura)
												row.textura:AddMaskTexture(row.EltruismMask2)
												row.textura.EltruismMask2 = true
											end
											row.background:ClearAllPoints()
											row.background:SetPoint("BOTTOMLEFT", row.textura,"BOTTOMRIGHT", -1, 0)
											row.background:SetPoint("TOPRIGHT", row,"TOPRIGHT", 0, 0)
											if not row.statusbar.shadow then
												row.statusbar:CreateShadow()
												row.statusbar.shadow:ClearAllPoints()
												row.statusbar.shadow:SetPoint("BOTTOMLEFT", row.textura,"BOTTOMLEFT", -2.5, -2.5)
												row.statusbar.shadow:SetPoint("TOPRIGHT", row.background,"TOPRIGHT", 2.5, -14)
											end
											row.background:SetTexture(row.textura:GetTexture())
											if row.lineBorder then
												row.lineBorder:SetAlpha(0)
											end
											row:SetHeight(21)
										else
											row.background:SetTexture(row.textura:GetTexture())
										end
										if row.minha_tabela and row.minha_tabela.name then
											local unitclass = row.minha_tabela:class() --from details api returns class of that row
											if classes[unitclass] then
												if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
													row.background:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass))
												else
													row.background:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(unitclass))
												end
											else
												row.background:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r = r-0.5,g = g-0.5,b = b-0.5,a = 0.9}, {r= r+0.2,g = g+0.2,b = b+0.2,a = 0.9})
											end
										else
											row.background:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r = r-0.5,g = g-0.5,b = b-0.5,a = 0.9}, {r = r+0.2,g = g+0.2,b = b+0.2,a = 0.9})
										end
									end)
									row.background.EltruismHook = true
								end
							end

						end
					end
				end)
				DetailsHooked = true
			end
		end

		--add a basic embed if addonskins is not loaded
		if E.db.ElvUI_EltreumUI.skins.detailsembed and E.private.chat.enable then
			local checkembed = true
			if IsAddOnLoaded("AddOnSkins") or IsAddOnLoaded("ElvUI_MerathilisUI") then
				if IsAddOnLoaded("AddOnSkins") then
					local AS = unpack(AddOnSkins)
					if (AS.db["EmbedSystemDual"] or AS.db["EmbedSystem"]) then
						checkembed = false
					end
				end
				if IsAddOnLoaded("ElvUI_MerathilisUI") then
					if E.private.mui.skins.embed and E.private.mui.skins.embed.enable then
						checkembed = false
					end
				end
			end

			if checkembed then
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

					for i = 1, 5 do
						if _G["DetailsBaseFrame"..i] then
							_G["DetailsBaseFrame"..i]:SetParent(embedpanel)
							_G["DetailsRowFrame"..i]:SetParent(embedpanel)
							_G["Details_SwitchButtonFrame"..i]:SetParent(embedpanel)
						end
					end
					if _G["DetailsBaseFrame1"] then
						_G["DetailsBaseFrame1"]:ClearAllPoints()
						_G["DetailsBaseFrame1"]:SetPoint("TOPLEFT", embedpanel, "TOPLEFT",0,-20)
					end
				end

				if E.db.ElvUI_EltreumUI.skins.detailsembedooc then
					embedpanel:RegisterEvent("PLAYER_REGEN_ENABLED")
					embedpanel:RegisterEvent("PLAYER_REGEN_DISABLED")
				end
				embedpanel:RegisterEvent("PLAYER_ENTERING_WORLD")

				--[[if not _G.RightChatToggleButton:IsShown() then --fix when no chat toggle exists
					E.db.ElvUI_EltreumUI.skins.detailsembedhidden = false
				end]]

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
