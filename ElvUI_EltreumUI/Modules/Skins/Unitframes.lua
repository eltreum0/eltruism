local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local tostring = _G.tostring
local select = _G.select
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local _, unit1class, buttonclass, classunit, unitframe, namebar, reaction,groupbar
local headergroup = nil
local headertank = nil
local headerassist = nil
local group, groupbutton, tankbutton, assistbutton
local orientation, barTexture, texture
local LCG = E.Libs.CustomGlow
local classcolor = E:ClassColor(E.myclass, true)
local skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--set the textures or gradients for single units
function ElvUI_EltreumUI:ApplyUnitGradientTexture(unit,name,uf)
	_, classunit = UnitClass(unit)
	namebar = E.LSM:Fetch("statusbar", "Eltreum-Blank")
	reaction = UnitReaction(unit, "player")
	if UnitExists(unit) then
		if UnitIsPlayer(unit) then
			if classunit then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture(classunit)
			end
		else
			if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("TAPPED")
			else
				if reaction then
					if reaction >= 5 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
					elseif reaction == 4 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
					elseif reaction == 3 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
					elseif reaction <= 2 then
						namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
					end
				end
			end
		end
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Health then
			unitframe.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then ---TODO confirm this is fine for dark mode
				--unitframe.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				unitframe.Health:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				unitframe.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			end
			if UnitIsPlayer(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
						else
							unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unit.."texture"]))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if unit == "target" then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, false))
								else
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, false))
								end
							else
								unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, false))
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if unit == "target" then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, false))
								else
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, false))
								end
							else
								unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, false))
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
						else
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unit.."texture"]))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if unit == "target" then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, true))
								else
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
								end
							else
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if unit == "target" then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, true))
								else
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
								end
							else
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
							end
						end
					end
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
								unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
							else
								if reaction then
									if reaction >= 5 then
										unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY"))
									elseif reaction == 4 then
										unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL"))
									elseif reaction == 3 then
										unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY"))
									elseif reaction <= 2 then
										unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE"))
									end
								end
							end
						else
							unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unit.."texture"]))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, false))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, false))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, false))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, false))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, false))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, false))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, false))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, false))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, false))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, false))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, false))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, false))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
										end
									end
								end
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
								else
									if reaction and reaction >= 5 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
									elseif reaction and reaction == 4 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
									elseif reaction and reaction == 3 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, false))
									elseif reaction and reaction <= 2 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
									end
								end
							else
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
								else
									if reaction and reaction >= 5 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
									elseif reaction and reaction == 4 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
									elseif reaction and reaction == 3 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, false))
									elseif reaction and reaction <= 2 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
									end
								end
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
								unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
							else
								if reaction then
									if reaction >= 5 then
										unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY"))
									elseif reaction == 4 then
										unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL"))
									elseif reaction == 3 then
										unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY"))
									elseif reaction <= 2 then
										unitframe.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE"))
									end
								end
							end
						else
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unit.."texture"]))
						end
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
										end
									end
								end
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, true))
								else
									if reaction and reaction >= 5 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
									elseif reaction and reaction == 4 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
									elseif reaction and reaction == 3 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
									elseif reaction and reaction == 2 or reaction == 1 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
									end
								end
							else
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, true))
								else
									if reaction and reaction >= 5 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
									elseif reaction and reaction == 4 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
									elseif reaction and reaction == 3 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
									elseif reaction and reaction == 2 or reaction == 1 then
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
									end
								end
							end
						end
					end
				end
			end
			if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					unitframe.Health:SetStatusBarTexture(namebar)
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					unitframe.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
			end
		end
	end
end

--set the textures or gradients for group units
function ElvUI_EltreumUI:ApplyGroupGradientTexture(button)
	if E.db.ElvUI_EltreumUI.unitframes.lightmode then ---TODO confirm this is fine for dark mode
		--button.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
		button.Health:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
		button.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
	end
	_, buttonclass = UnitClass(button.unit)
	if buttonclass and button.Health then
		button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
		groupbar = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					else
						button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				end
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, false))
				else
					button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, false))
				end
			end
		elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
			if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				button.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					else
						button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				end
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, true))
				else
					button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, true))
				end
			end
		end
		if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				button.Health:SetStatusBarTexture(groupbar)
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
				button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
				button.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			end
		end
	end
end

function ElvUI_EltreumUI:GradientCustomTexture(unit)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		ElvUI_EltreumUI:ApplyUnitGradientTexture("player", "Player", "player")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("target", "Target", "target")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("targettarget", "TargetTarget", "targettarget")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("targettargettarget", "TargetTargetTarget","targettargettarget")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("pet", "Pet", "pet")
		if E.Retail or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss1", "Boss1", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss2", "Boss2", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss3", "Boss3", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss4", "Boss4", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss5", "Boss5", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss6", "Boss6", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss7", "Boss7", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss8", "Boss8", "boss")
		end
		if not E.Classic then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("focus", "Focus", "focus")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("focustarget", "FocusTarget", "focustarget")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena1", "Arena1", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena2", "Arena2", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena3", "Arena3", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena4", "Arena4", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena5", "Arena5", "arena")
		end

		--group/raid unitframes
		if UnitExists(unit) and (E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.darkmode) then
			headergroup = nil
			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsShown() then
				headergroup = _G["ElvUF_Raid1"]
			elseif _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsShown() then
				headergroup = _G["ElvUF_Raid2"]
			elseif _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsShown() then
				headergroup = _G["ElvUF_Raid3"]
			elseif _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsShown() then
				headergroup = _G["ElvUF_Party"]
			end

			headertank = nil
			if _G["ElvUF_Tank"] and _G["ElvUF_Tank"]:IsShown() then
				headertank = _G["ElvUF_Tank"]
			end

			headerassist = nil
			if _G["ElvUF_Assist"] and _G["ElvUF_Assist"]:IsShown() then
				headerassist = _G["ElvUF_Assist"]
			end

			_, unit1class = UnitClass(unit)
			if not unit1class then
				return
			end

			if headergroup ~= nil then
				for i = 1, headergroup:GetNumChildren() do
					group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Health then
							ElvUI_EltreumUI:ApplyGroupGradientTexture(groupbutton)
						end
					end
				end
			end

			if headertank ~= nil then
				for i = 1, headertank:GetNumChildren() do
					tankbutton = select(i, headertank:GetChildren())
					if tankbutton and tankbutton.Health then
						ElvUI_EltreumUI:ApplyGroupGradientTexture(tankbutton)
					end
				end
			end

			if headerassist ~= nil then
				for i = 1, headerassist:GetNumChildren() do
					assistbutton = select(i, headerassist:GetChildren())
					if assistbutton and assistbutton.Health then
						ElvUI_EltreumUI:ApplyGroupGradientTexture(assistbutton)
					end
				end
			end
		end

	end
end
--hooksecurefunc(UF, "Style", ElvUI_EltreumUI.GradientCustomTexture) --if not hooking into this then when the target of target changes it doesnt update
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientCustomTexture)

--glow dispellable debuffs
--local filtercheck = E:GetModule('NamePlates')
function ElvUI_EltreumUI:UFGlow(object, debuffType, _, wasFiltered)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.glow.enableUFs then
			local name = object:GetName()
			if (name ~= "ElvUF_Player" and name ~= "ElvUF_Target") then
				if debuffType then
					if not wasFiltered then
						--local canDispel = filtercheck:StyleFilterDispelCheck(object, debuffType)
						local color = UF.db.colors.debuffHighlight[debuffType]
						if E.db.ElvUI_EltreumUI.glow.pixel then
							LCG.PixelGlow_Start(object, {color.r, color.g, color.b, 1}, 7, 0.25, 14, 4, 3, 3, false, nil, 6)
						elseif E.db.ElvUI_EltreumUI.glow.autocast then
							LCG.AutoCastGlow_Start(object, {color.r, color.g, color.b, 1}, 8, 0.4, 2, 3, 3)
						elseif E.db.ElvUI_EltreumUI.glow.blizzard then
							LCG.ButtonGlow_Start(object, {color.r, color.g, color.b, 1}, 0.5)
						end
					end
				else
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Stop(object)
					elseif E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Stop(object)
					elseif E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Stop(object)
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdate_AuraHighlight", ElvUI_EltreumUI.UFGlow)

--for Unitframe Backdrop Texture/Alpha/Fill Direction
function UF:ToggleTransparentStatusBar(isTransparent, statusBar, backdropTex, adjustBackdropPoints, invertColors, reverseFill)
	statusBar.isTransparent = isTransparent
	statusBar.invertColors = invertColors
	statusBar.backdropTex = backdropTex

	if not statusBar.hookedColor then
		hooksecurefunc(statusBar, 'SetStatusBarColor', UF.UpdateBackdropTextureColor)
		statusBar.hookedColor = true
	end

	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and statusBar:GetName():match("HealthBar") then
		if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
			backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
			backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			--if statusBar and statusBar.backdrop and E.db.ElvUI_EltreumUI.unitframes.lightmode then
				--statusBar.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				--statusBar.backdrop:Hide()
				--backdropTex:Hide()
			--end
		elseif E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden then
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if backdropTex then
					backdropTex:SetAlpha(0)
				end
			end
			if statusBar and statusBar.backdrop and statusBar:GetName():match("HealthBar") then
				statusBar.backdrop:Hide()
			end
		end
	end

	local orientation = statusBar:GetOrientation()
	if E.db.ElvUI_EltreumUI.unitframes.UForientation == "VERTICAL" and statusBar:GetName():match("HealthBar") and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		orientation = "VERTICAL"
	end
	local barTexture = statusBar:GetStatusBarTexture() -- This fixes Center Pixel offset problem (normally this has > 2 points)
	barTexture:SetInside(nil, 0, 0) -- This also unsnaps the texture

	UF:HandleStatusBarTemplate(statusBar, statusBar:GetParent(), isTransparent)

	if isTransparent then
		statusBar:SetStatusBarTexture(0, 0, 0, 0)
		UF:Update_StatusBar(statusBar.bg or statusBar.BG, E.media.blankTex)

		UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
	else
		local texture = E.LSM:Fetch('statusbar', UF.db.statusbar)
		statusBar:SetStatusBarTexture(texture)
		UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)

		if adjustBackdropPoints then
			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		end
	end
end

--modify the position of the information panel
local allowedunits = {
	['ElvUF_Player'] = true,
	['ElvUF_Target'] = true,
	['ElvUF_TargetTarget'] = true,
	['ElvUF_Focus'] = true,
	['ElvUF_FocusTarget'] = true,
	['ElvUF_Pet'] = true,
	['ElvUF_TargetTargetTarget'] = true,
}
function UF:Configure_InfoPanel(frame)
	local db = frame.db

	if frame.USE_INFO_PANEL then
		frame.InfoPanel:Show()
		frame.InfoPanel:ClearAllPoints()

		local allowed = false

		if E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes then
			allowed = true
		else
			if allowedunits[tostring(frame:GetName())] then
				allowed = true
			end
		end

		--print(E.private["general"]["pixelPerfect"],E.db["unitframe"]["thinBorders"])
		if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.infopanelontop and allowed then
			local portrait = (db.portrait.style == '3D' and frame.Portrait3D) or frame.Portrait2D
			portrait.db = db.portrait
			frame.InfoPanel:ClearAllPoints()
			frame.InfoPanelOnTop = true
			if E.db.unitframe.thinBorders then
				if frame.USE_PORTRAIT and portrait.db.style ~= '3D' then
					if frame.ORIENTATION == 'LEFT' then
						--[[frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, db.infoPanel.height)
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)]]

						frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT',  -UF.BORDER - UF.SPACING, db.infoPanel.height - (UF.BORDER/2))
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, db.infoPanel.height - (UF.BORDER/2))
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
					elseif frame.ORIENTATION == 'RIGHT' then
						frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
					end
				else
					frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
					--frame.InfoPanel:Point('BOTTOMLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
					frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					--[[if db.orientation == 'LEFT' then
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					else
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					end]]
					frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
				end
			else
				if frame.USE_PORTRAIT and portrait.db.style ~= '3D' then
					if frame.ORIENTATION == 'LEFT' then
						--[[frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, db.infoPanel.height)
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)]]

						frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', (UF.BORDER*1.5)+portrait.db.width, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT',  -UF.BORDER - UF.SPACING, db.infoPanel.height - (UF.BORDER/2))
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', (UF.BORDER*1.5)+portrait.db.width, db.infoPanel.height - (UF.BORDER/2))
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
					elseif frame.ORIENTATION == 'RIGHT' then
						frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER*1.3, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER*1.3, db.infoPanel.height)
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
					end
				else
					frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
					--frame.InfoPanel:Point('BOTTOMLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
					frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					--[[if db.orientation == 'LEFT' then
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					else
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					end]]
					frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
				end
			end
		else --this is the original
			if frame.ORIENTATION == 'RIGHT' and not (frame.unitframeType == 'arena') then
				frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
				if frame.USE_POWERBAR and not frame.USE_INSET_POWERBAR and not frame.POWERBAR_DETACHED then
					frame.InfoPanel:Point('TOPLEFT', frame.Power.backdrop, 'BOTTOMLEFT', UF.BORDER, -(UF.SPACING*3))
				else
					frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'BOTTOMLEFT', UF.BORDER, -(UF.SPACING*3))
				end
			else
				frame.InfoPanel:Point('BOTTOMLEFT', frame, 'BOTTOMLEFT', UF.BORDER + UF.SPACING, UF.BORDER + UF.SPACING)
				if frame.USE_POWERBAR and not frame.USE_INSET_POWERBAR and not frame.POWERBAR_DETACHED then
					frame.InfoPanel:Point('TOPRIGHT', frame.Power.backdrop, 'BOTTOMRIGHT', -UF.BORDER, -(UF.SPACING*3))
				else
					frame.InfoPanel:Point('TOPRIGHT', frame.Health.backdrop, 'BOTTOMRIGHT', -UF.BORDER, -(UF.SPACING*3))
				end
			end
		end

		if db.infoPanel.transparent then
			frame.InfoPanel.backdrop:SetTemplate('Transparent', nil, nil, nil, true)
		else
			frame.InfoPanel.backdrop:SetTemplate(nil, true, nil, nil, true)
		end
	else
		frame.InfoPanel:Hide()
	end
end

function ElvUI_EltreumUI:SkinPortrait(frame)
	local db = frame.db
	local portrait = (db.portrait.style == '3D' and frame.Portrait3D) or frame.Portrait2D
	portrait.db = db.portrait
	frame.Portrait = portrait

	if frame.USE_PORTRAIT and portrait.db.style ~= '3D' then
		if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.infopanelontop and allowedunits[tostring(frame:GetName())] then
			if frame.ORIENTATION == 'LEFT' then
				if portrait.db.style == '2D' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height)
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height)
					else
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, -(1/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, -(1/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER/1.5))
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height+(UF.BORDER/1.5))
					end
				elseif portrait.db.style == 'Class' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 0, db.infoPanel.height-(UF.BORDER/2))
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0+portrait.db.width, db.infoPanel.height-(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", frame, "TOPLEFT", 0, db.infoPanel.height)
						portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", 0+portrait.db.width, db.infoPanel.height)
					else
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", UF.BORDER, db.infoPanel.height+(UF.BORDER/4)+1)
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", UF.BORDER+portrait.db.width, db.infoPanel.height+(UF.BORDER/4)+1)
						portrait:SetPoint("TOPRIGHT", frame, "TOPLEFT", UF.BORDER, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", UF.BORDER+portrait.db.width, db.infoPanel.height+(UF.BORDER/2))
					end
					portrait.backdrop:ClearAllPoints()
					portrait.backdrop:SetAllPoints(portrait)
				end
			elseif frame.ORIENTATION == 'RIGHT' then
				if portrait.db.style == '2D' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height+(UF.BORDER/2))
					else
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, -(1/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, -(1/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER*1.2))
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height+(UF.BORDER*1.2))
					end
				elseif portrait.db.style == 'Class' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, db.infoPanel.height)--+(UF.BORDER/2))
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0-portrait.db.width, db.infoPanel.height)--+(UF.BORDER/2))
						portrait:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0-portrait.db.width, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER/2))
					else
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -UF.BORDER, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", -UF.BORDER-portrait.db.width, db.infoPanel.height+(UF.BORDER/2))

						portrait:SetPoint("TOPLEFT", frame, "TOPRIGHT", -UF.BORDER-portrait.db.width, db.infoPanel.height+UF.BORDER)
						portrait:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -UF.BORDER, db.infoPanel.height+UF.BORDER)
					end
					portrait.backdrop:ClearAllPoints()
					portrait.backdrop:SetAllPoints(portrait)
				end
			end
		end
		--from actionbar trim
		--[[local left, right, top, bottom = unpack(E.TexCoords)

		local width, height = portrait.db.width, 15+12+55--?
		local ratio = width / height

		print(portrait.db.width,portrait.db.height,ratio)
		if ratio > 1 then
			local trimAmount = (1 - (1 / ratio)) * 0.5
			top = top + trimAmount
			bottom = bottom - trimAmount
		else
			local trimAmount = (1 - ratio) * 0.5
			left = left + trimAmount
			right = right - trimAmount
		end
		portrait:SetTexCoord(left, right, top, bottom)]]
	end
end
hooksecurefunc(UF, "Configure_Portrait", ElvUI_EltreumUI.SkinPortrait)

--Gradient Aurabars
function ElvUI_EltreumUI:AuraBarTexture(unit, bar, _, _, _, _, debuffType, isStealable) --could use isStealable to add a glow or something
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.aura and not bar.shadow then
			bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if EnhancedShadows then EnhancedShadows:RegisterShadow(bar.shadow) end
			bar.shadow:ClearAllPoints()
			bar.shadow:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -3,3)
			bar.shadow:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT",3,-3)
		end
		if bar.bg then
			bar.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			bar.backdrop:SetBackdropColor(0,0,0,0)
		end
		--[[if isStealable then --maybe later
			LCG.PixelGlow_Start(bar, skillglowcolor, 7, 0.25, 14, 4, 3, 3, false, nil, 6)
		end]]
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
			local r,g,b = bar:GetStatusBarColor()
			if unit == "player" then
				bar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.3, g-0.3, b-0.3, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha,r, g, b, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			elseif unit == "target" then
				bar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r, g, b, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, r-0.3, g-0.3, b-0.3, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdateBar_AuraBars", ElvUI_EltreumUI.AuraBarTexture)
