local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local UnitClass = _G.UnitClass

--blizzard raid frames custom textures/gradient
function ElvUI_EltreumUI:BlizzardTexturesGradient()
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if _G["CompactRaidFrameContainer"] then

			if not _G["CompactRaidFrameContainer"].EltruismHook then
				hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				hooksecurefunc("CompactUnitFrame_UpdateAll", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				hooksecurefunc("CompactUnitFrame_UpdateRoleIcon", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				_G["CompactRaidFrameContainer"].EltruismHook = true
			end

			if _G["CompactRaidGroup1Member1"] and _G["CompactRaidGroup1Member1"]:IsVisible() then
				for k = 1, 8 do
					for l = 1, 5 do
						if _G["CompactRaidGroup"..k.."Member"..l] then
							if _G["CompactRaidGroup"..k.."Member"..l].displayedUnit then
								local _ , unitclass = UnitClass(_G["CompactRaidGroup"..k.."Member"..l].displayedUnit)
								if unitclass and _G["CompactRaidGroup"..k.."Member"..l].healthBar then

									--textures
									_G["CompactRaidGroup"..k.."Member"..l].background:SetColorTexture(0,0,0,E.db.general.backdropfadecolor.a)
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

									--shadows
									if E.db.ElvUI_EltreumUI.skins.shadow.enable then
										if E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
											if not _G["CompactRaidGroup"..k.."Member"..l].healthBar.shadow then
												_G["CompactRaidGroup"..k.."Member"..l].healthBar:CreateShadow()
												ElvUI_EltreumUI:ShadowColor(_G["CompactRaidGroup"..k.."Member"..l].healthBar.shadow)
											end
										end
									end

									--gradient
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
										else
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
										end
									end

									--font
									_G["CompactRaidGroup"..k.."Member"..l].name:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, E.db.general.fontStyle)

									--role icons
									local role = UnitGroupRolesAssigned(_G["CompactRaidGroup"..k.."Member"..l].displayedUnit)
									_G["CompactRaidGroup"..k.."Member"..l].roleIcon:SetTexCoord(0,1,0,1)
									_G["CompactRaidGroup"..k.."Member"..l].roleIcon:SetTexture(ElvUI_EltreumUI:GetRoleIcon(role))
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

								--textures
								_G["CompactRaidFrame"..i].background:SetColorTexture(0,0,0,E.db.general.backdropfadecolor.a)
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

								--shadows
								if E.db.ElvUI_EltreumUI.skins.shadow.enable then
									if E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
										if not _G["CompactRaidFrame"..i].healthBar.shadow then
											_G["CompactRaidFrame"..i].healthBar:CreateShadow()
											ElvUI_EltreumUI:ShadowColor(_G["CompactRaidFrame"..i].healthBar.shadow)
										end
									end
								end

								--gradient
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
									else
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
									end
								end

								--font
								_G["CompactRaidFrame"..i].name:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, E.db.general.fontStyle)

								--role icons
								local role = UnitGroupRolesAssigned(_G["CompactRaidFrame"..i].displayedUnit)
								_G["CompactRaidFrame"..i].roleIcon:SetTexCoord(0,1,0,1)
								_G["CompactRaidFrame"..i].roleIcon:SetTexture(ElvUI_EltreumUI:GetRoleIcon(role))
							end
						end
					end
				end
			end
		end
	end
end
