local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--main function to hook/set gradient/textures/shadows
local function hookCell(frame)
	--gradient/custom texture
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

--cell gradient/textures
function ElvUI_EltreumUI:EltruismCell()
	if E.db.ElvUI_EltreumUI.skins.cell then
		--solo
		if _G["CellSoloFramePlayer"] then
			hookCell(_G["CellSoloFramePlayerHealthBar"])
		end

		--raid
		if _G["CellRaidFrame"] and IsInGroup() then
			for i = 1, 8 do
				if _G["CellRaidFrameHeader"..i] then
					for v = 1, 5 do
						if _G["CellRaidFrameHeader"..i.."UnitButton"..v] and _G["CellRaidFrameHeader"..i.."UnitButton"..v.."HealthBar"] then
							hookCell(_G["CellRaidFrameHeader"..i.."UnitButton"..v])
						end
					end
				end
			end
		end

		--party
		if _G["CellPartyFrame"] and IsInGroup() then
			print("3")
			if _G["CellPartyFrameHeader"] then
				for i = 1, 5 do
					if _G["CellPartyFrameHeaderUnitButton"..i] and _G["CellPartyFrameHeaderUnitButton"..i.."HealthBar"]then
						hookCell(_G["CellPartyFrameHeaderUnitButton"..i.."HealthBar"])
					end
				end
			end
		end
	end
end
S:AddCallbackForAddon('Cell', "EltruismCell", ElvUI_EltreumUI.EltruismCell)
