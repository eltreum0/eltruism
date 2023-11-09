local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

--main function to hook/set gradient/textures/shadows
local function hookCell(frame,region,solo)
	--gradient/custom texture
	if region then
		if solo then
			if not region.EltruismHook then
				if frame and frame.SetVertexColor then
					hooksecurefunc(frame,"SetVertexColor", function()
						--gradient
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								frame:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, false))
							else
								frame:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(E.myclass, false, false))
							end
						end
						--custom texture
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
								frame:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(E.myclass))
							else
								frame:SetTexture(ElvUI_EltreumUI:UnitframeClassTexture(E.myclass))
							end
						end
					end)
				end
				--shadows
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if E.db.ElvUI_EltreumUI.skins.shadow.raid then
						if not region.shadow then
							region:CreateShadow()
							ElvUI_EltreumUI:ShadowColor(region.shadow)
						end
					end
				end
				region.EltruismHook = true
			end
		else
			if region.unitid and not region.EltruismHook then
				if frame and frame.SetVertexColor then
					hooksecurefunc(frame,"SetVertexColor", function()
						local _, englishClass = UnitClass(region.unitid)
						--gradient
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								frame:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(englishClass, false, false))
							else
								frame:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(englishClass, false, false))
							end
						end
						--custom texture
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
								frame:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(englishClass))
							else
								frame:SetTexture(ElvUI_EltreumUI:UnitframeClassTexture(englishClass))
							end
						end
					end)
				end
				--shadows
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if E.db.ElvUI_EltreumUI.skins.shadow.raid then
						if not region.shadow then
							region:CreateShadow()
							ElvUI_EltreumUI:ShadowColor(region.shadow)
						end
					end
				end
				region.EltruismHook = true
			end
		end
	else
		if frame and frame.SetStatusBarColor and not frame.EltruismHook then
			hooksecurefunc(frame,"SetStatusBarColor", function()
				if frame:GetParent().__unitGuid then
					local _, englishClass = GetPlayerInfoByGUID(frame:GetParent().__unitGuid)
					--gradient
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							frame:GetStatusBarTexture():SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColorsCustom(englishClass, false, false))
						else
							frame:GetStatusBarTexture():SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(englishClass, false, false))
						end
					end
					--custom texture
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
							frame:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(englishClass))
						else
							frame:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTexture(englishClass))
						end
					end
				end
			end)

			--shadows
			if E.db.ElvUI_EltreumUI.skins.shadow.enable then
				if E.db.ElvUI_EltreumUI.skins.shadow.raid then
					if not frame:GetParent().shadow then
						frame:GetParent():CreateShadow()
						ElvUI_EltreumUI:ShadowColor(frame:GetParent().shadow)
					end
				end
			end
			frame.EltruismHook = true
		end
	end
end

--cell gradient/textures
function ElvUI_EltreumUI:EltruismCell()
	if not IsAddOnLoaded("Cell") then return end
	if E.db.ElvUI_EltreumUI.skins.cell then
		--solo
		if _G["CellSoloFramePlayer"] then
			if E.db.ElvUI_EltreumUI.skins.cellhealthloss then
				for _,k in pairs({_G["CellSoloFramePlayer"]:GetRegions()}) do
					if k:GetName() and k:GetName() == ("CellSoloFramePlayerHealthBarLoss") then
						hookCell(k,_G["CellSoloFramePlayer"],true)
					end
				end
			else
				hookCell(_G["CellSoloFramePlayerHealthBar"])
			end
		end

		--raid
		if _G["CellRaidFrame"] and IsInGroup() then
			for i = 1, 8 do
				if _G["CellRaidFrameHeader"..i] then
					for v = 1, 5 do
						if _G["CellRaidFrameHeader"..i.."UnitButton"..v] and _G["CellRaidFrameHeader"..i.."UnitButton"..v.."HealthBar"] then
							if E.db.ElvUI_EltreumUI.skins.cellhealthloss then
								for _,k in pairs({_G["CellRaidFrameHeader"..i.."UnitButton"..v]:GetRegions()}) do
									if k:GetName() and k:GetName():match("HealthBarLoss") then
										hookCell(k,_G["CellRaidFrameHeader"..i.."UnitButton"..v])
									end
								end
							else
								hookCell(_G["CellRaidFrameHeader"..i.."UnitButton"..v.."HealthBar"])
							end
						end
					end
				end
			end
		end

		--party
		if _G["CellPartyFrame"] and IsInGroup() then
			if _G["CellPartyFrameHeader"] then
				for i = 1, 5 do
					if _G["CellPartyFrameHeaderUnitButton"..i] and _G["CellPartyFrameHeaderUnitButton"..i.."HealthBar"] then
						for _,v in pairs({_G["CellPartyFrameHeaderUnitButton"..i.."HealthBar"]:GetRegions()}) do
							if E.db.ElvUI_EltreumUI.skins.cellhealthloss then
								if v:GetName() and v:GetName():match("HealthBarLoss") then
									hookCell(v,_G["CellPartyFrameHeaderUnitButton"..i.."HealthBar"])
								end
							else
								hookCell(_G["CellPartyFrameHeaderUnitButton"..i.."HealthBar"])
							end
						end
					end
				end
			end
		end
	end
end
S:AddCallbackForAddon('Cell', "EltruismCell", ElvUI_EltreumUI.EltruismCell)
