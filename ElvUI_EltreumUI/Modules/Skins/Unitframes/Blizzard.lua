local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local UnitClass = _G.UnitClass
local IsAddOnLoaded = _G.IsAddOnLoaded
local EnhancedShadows
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--blizzard raid frames custom textures/gradient
function ElvUI_EltreumUI:BlizzardTexturesGradient()
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if _G["CompactRaidFrameContainer"] then
			if _G["CompactRaidGroup1Member1"] and _G["CompactRaidGroup1Member1"]:IsVisible() then
				for k = 1, 8 do
					for l = 1, 5 do
						if _G["CompactRaidGroup"..k.."Member"..l] then
							if _G["CompactRaidGroup"..k.."Member"..l].displayedUnit then
								local _ , unitclass = UnitClass(_G["CompactRaidGroup"..k.."Member"..l].displayedUnit)
								if unitclass and _G["CompactRaidGroup"..k.."Member"..l].healthBar then
									if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
										if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass))
										else
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTexture(unitclass))
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
												if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
													if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
														_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
													end
												end
											end
										else
											if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
												_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
											end
										end
									end
									if E.db.ElvUI_EltreumUI.skins.shadow.enable then
										if E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
											if not _G["CompactRaidGroup"..k.."Member"..l].healthBar.shadow then
												_G["CompactRaidGroup"..k.."Member"..l].healthBar:CreateShadow()
												if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["CompactRaidGroup"..k.."Member"..l].healthBar.shadow) end
											end
										end
									end
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
										else
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
										end
									end
								end
							end
						end
					end
				end
			elseif _G["CompactRaidFrame1"] and _G["CompactRaidFrame1"]:IsVisible() then
				for i = 1, 40 do
					if _G["CompactRaidFrame"..i] then
						if _G["CompactRaidFrame"..i].displayedUnit then
							local _ , unitclass = UnitClass(_G["CompactRaidFrame"..i].displayedUnit)
							if unitclass and _G["CompactRaidFrame"..i].healthBar then
								if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
									if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass))
									else
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTexture(unitclass))
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
											if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
												if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
													_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
												end
											end
										end
									else
										if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
											_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
										end
									end
								end
								if E.db.ElvUI_EltreumUI.skins.shadow.enable then
									if E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
										if not _G["CompactRaidFrame"..i].healthBar.shadow then
											_G["CompactRaidFrame"..i].healthBar:CreateShadow()
											if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["CompactRaidFrame"..i].healthBar.shadow) end
										end
									end
								end
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
									else
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
