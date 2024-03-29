local E = unpack(ElvUI)
local _G = _G
local UnitClass = _G.UnitClass

local Hooked = false

--blizzard raid frames custom textures/gradient
function ElvUI_EltreumUI:BlizzardTexturesGradient()
	if not E.db.ElvUI_EltreumUI then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.blizzardraidframes then
		if _G["CompactRaidFrameContainer"] and _G["CompactRaidFrameContainer"]:IsVisible() then

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
										if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
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
										if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
											if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
												_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
											end
										end
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
										else
											_G["CompactRaidGroup"..k.."Member"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
										end
									end

									--font
									_G["CompactRaidGroup"..k.."Member"..l].name:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

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
									if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
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
									if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
										if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
											_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
										end
									end
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
									else
										_G["CompactRaidFrame"..i].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
									end
								end

								--font
								_G["CompactRaidFrame"..i].name:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

								--role icons
								local role = UnitGroupRolesAssigned(_G["CompactRaidFrame"..i].displayedUnit)
								_G["CompactRaidFrame"..i].roleIcon:SetTexCoord(0,1,0,1)
								_G["CompactRaidFrame"..i].roleIcon:SetTexture(ElvUI_EltreumUI:GetRoleIcon(role))
							end
						end
					end
				end
			end
		elseif _G["CompactPartyFrame"] and _G["CompactPartyFrame"]:IsVisible() then
			if not _G["CompactPartyFrame"].EltruismHook then
				hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				hooksecurefunc("CompactUnitFrame_UpdateAll", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				hooksecurefunc("CompactUnitFrame_UpdateRoleIcon", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				_G["CompactPartyFrame"].EltruismHook = true
			end

			if _G["CompactPartyFrameMember1"] and _G["CompactPartyFrameMember1"]:IsVisible() then
				for l = 1, 5 do
					if _G["CompactPartyFrameMember"..l] then
						--[[if not _G["CompactPartyFrameMember"..l].templateset then
							_G["CompactPartyFrameMember"..l]:SetTemplate("Transparent")
							_G["CompactPartyFrameMember"..l].templateset = true
						end]] --not sure yet about setting a template since maybe it will break some stuff
						if _G["CompactPartyFrameMember"..l].displayedUnit then
							local _ , unitclass = UnitClass(_G["CompactPartyFrameMember"..l].displayedUnit)
							if unitclass and _G["CompactPartyFrameMember"..l].healthBar then

								--textures
								_G["CompactPartyFrameMember"..l].background:SetColorTexture(0,0,0,E.db.general.backdropfadecolor.a)
								if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
									if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
										_G["CompactPartyFrameMember"..l].healthBar:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass))
									else
										_G["CompactPartyFrameMember"..l].healthBar:GetStatusBarTexture():SetTexture(ElvUI_EltreumUI:UnitframeClassTexture(unitclass))
									end
								else
									if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
										if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
											_G["CompactPartyFrameMember"..l].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
										end
									end
								end

								--shadows
								if E.db.ElvUI_EltreumUI.skins.shadow.enable then
									if E.db.ElvUI_EltreumUI.skins.shadow.raid and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.raidborders) then
										if not _G["CompactPartyFrameMember"..l].healthBar.shadow then
											_G["CompactPartyFrameMember"..l].healthBar:CreateShadow()
											ElvUI_EltreumUI:ShadowColor(_G["CompactPartyFrameMember"..l].healthBar.shadow)
										end
									end
								end

								--gradient
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
									if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
										if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
											_G["CompactPartyFrameMember"..l].healthBar:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
										end
									end
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										_G["CompactPartyFrameMember"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(unitclass, false, false))
									else
										_G["CompactPartyFrameMember"..l].healthBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(unitclass, false, false))
									end
								end

								--font
								_G["CompactPartyFrameMember"..l].name:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

								--role icons
								local role = UnitGroupRolesAssigned(_G["CompactPartyFrameMember"..l].displayedUnit)
								_G["CompactPartyFrameMember"..l].roleIcon:SetTexCoord(0,1,0,1)
								_G["CompactPartyFrameMember"..l].roleIcon:SetTexture(ElvUI_EltreumUI:GetRoleIcon(role))
							end
						end
					end
				end
			end
		else
			if not Hooked then
				hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				hooksecurefunc("CompactUnitFrame_UpdateAll", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				hooksecurefunc("CompactUnitFrame_UpdateRoleIcon", function()
					ElvUI_EltreumUI:BlizzardTexturesGradient()
				end)

				Hooked = true
			end
		end
	end
end
