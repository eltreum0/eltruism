local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local select = _G.select
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local _, unit1class, buttonclass, classunit, unitframe, namebar, reaction,groupbar
local headergroup = nil
local headertank = nil
local headerassist = nil
local headerraidpet = nil
local group, groupbutton, tankbutton, assistbutton, raidpetbutton,partypetbutton
local IsInGroup = _G.IsInGroup
local IsAddOnLoaded = _G.IsAddOnLoaded
local classcolor = E:ClassColor(E.myclass, true)
local skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end
local UnitIsCharmed = _G.UnitIsCharmed

do

	--set the textures or gradients for single units
	function ElvUI_EltreumUI:ApplyUnitGradient(unit,name)
		_, classunit = UnitClass(unit)
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
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					--unitframe.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					unitframe.Health:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					unitframe.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				if UnitIsPlayer(unit) and not UnitIsCharmed(unit) then
					if E.db.ElvUI_EltreumUI.unitframes.lightmode then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
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
										if E.Retail or E.Wrath then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, true))
										else
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, true))
										end
									else
										if E.Retail or E.Wrath then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
										else
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
										end
									end
								else
									if E.Retail or E.Wrath then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
									else
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
									if unit == "target" then
										if E.Retail or E.Wrath then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, true))
										else
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, true))
										end
									else
										if E.Retail or E.Wrath then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
										else
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
										end
									end
								else
									if E.Retail or E.Wrath then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
									else
										unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
									end
								end
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.lightmode then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
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
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, true))
											end
										else
											if reaction and reaction >= 5 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
												end
											elseif reaction and reaction == 4 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
												end
											elseif reaction and reaction == 3 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
												end
											elseif reaction and reaction == 2 or reaction == 1 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
												end
											end
										end
									else
										if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, true))
											end
										else
											if reaction and reaction >= 5 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
												end
											elseif reaction and reaction == 4 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
												end
											elseif reaction and reaction == 3 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
												end
											elseif reaction and reaction == 2 or reaction == 1 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
												end
											end
										end
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, true))
											end
										else
											if reaction and reaction >= 5 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
												end
											elseif reaction and reaction == 4 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
												end
											elseif reaction and reaction == 3 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
												end
											elseif reaction and reaction == 2 or reaction == 1 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
												end
											end
										end
									else
										if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, true))
											end
										else
											if reaction and reaction >= 5 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
												end
											elseif reaction and reaction == 4 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
												end
											elseif reaction and reaction == 3 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
												end
											elseif reaction and reaction == 2 or reaction == 1 then
												if E.Retail or E.Wrath then
													unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
												else
													unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
												end
											end
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										if E.Retail or E.Wrath then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, true))
										else
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, true))
										end
									else
										if reaction and reaction >= 5 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
											end
										elseif reaction and reaction == 4 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
											end
										elseif reaction and reaction == 3 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
											end
										elseif reaction and reaction == 2 or reaction == 1 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
											end
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										if E.Retail or E.Wrath then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, true))
										else
											unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, true))
										end
									else
										if reaction and reaction >= 5 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
											end
										elseif reaction and reaction == 4 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
											end
										elseif reaction and reaction == 3 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
											end
										elseif reaction and reaction == 2 or reaction == 1 then
											if E.Retail or E.Wrath then
												unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
											else
												unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
											end
										end
									end
								end
							end
						end
					end
				end
				if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
						unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
						unitframe.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
				end
			end
		end
	end

	--set the textures or gradients for group units
	function ElvUI_EltreumUI:ApplyGroupGradient(button)
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			--button.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			button.Health:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			button.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
		end

		--due to raid pet, check if is player
		if UnitIsPlayer(button.unit) then
			_, buttonclass = UnitClass(button.unit)
		else
			buttonclass = "NPCFRIENDLY"
		end

		if buttonclass and button.Health then
			button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
			groupbar = ElvUI_EltreumUI:UnitframeClassTexture(buttonclass)
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
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
						if E.Retail or E.Wrath then
							button.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, true))
						else
							button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, true))
						end
					else
						if E.Retail or E.Wrath then
							button.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, true))
						else
							button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, true))
						end
					end
				end
			end
			if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
				if E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
					button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
					button.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
			end
		end
	end

	function ElvUI_EltreumUI:GradientUF(unit)
		if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then

			--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
			ElvUI_EltreumUI:ApplyUnitGradient("player", "Player")
			ElvUI_EltreumUI:ApplyUnitGradient("target", "Target")
			ElvUI_EltreumUI:ApplyUnitGradient("targettarget", "TargetTarget")
			ElvUI_EltreumUI:ApplyUnitGradient("targettargettarget", "TargetTargetTarget")
			ElvUI_EltreumUI:ApplyUnitGradient("pet", "Pet")

			if E.Retail or E.Wrath then
				ElvUI_EltreumUI:ApplyUnitGradient("boss1", "Boss1", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss2", "Boss2", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss3", "Boss3", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss4", "Boss4", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss5", "Boss5", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss6", "Boss6", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss7", "Boss7", "boss")
				ElvUI_EltreumUI:ApplyUnitGradient("boss8", "Boss8", "boss")
			end
			if not E.Classic then
				ElvUI_EltreumUI:ApplyUnitGradient("focus", "Focus", "focus")
				ElvUI_EltreumUI:ApplyUnitGradient("focustarget", "FocusTarget", "focustarget")
				ElvUI_EltreumUI:ApplyUnitGradient("arena1", "Arena1", "arena")
				ElvUI_EltreumUI:ApplyUnitGradient("arena2", "Arena2", "arena")
				ElvUI_EltreumUI:ApplyUnitGradient("arena3", "Arena3", "arena")
				ElvUI_EltreumUI:ApplyUnitGradient("arena4", "Arena4", "arena")
				ElvUI_EltreumUI:ApplyUnitGradient("arena5", "Arena5", "arena")
			end

			--group/raid unitframes
			if IsInGroup() and UnitExists(unit) and (E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.darkmode) then
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

				headerraidpet = nil
				if _G["ElvUF_RaidpetGroup1"] and _G["ElvUF_RaidpetGroup1"]:IsShown() and E.db.unitframe.units.raidpet.enable then
					headerraidpet = _G["ElvUF_RaidpetGroup1"]
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
								ElvUI_EltreumUI:ApplyGroupGradient(groupbutton)
							end
						end
					end
				end

				if headergroup == _G["ElvUF_Party"] and E.db.unitframe.units.party.petsGroup.enable then
					for i = 1, 5 do
						partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
						if partypetbutton and partypetbutton.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(partypetbutton)
						end
					end
				end

				if headertank ~= nil then
					for i = 1, headertank:GetNumChildren() do
						tankbutton = select(i, headertank:GetChildren())
						if tankbutton and tankbutton.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(tankbutton)
						end
					end
				end

				--tank targets
				if _G["ElvUF_TankUnitButton1Target"] and _G["ElvUF_TankUnitButton1Target"]:IsShown() then
					for i = 1, 8 do
						local tanktargetmembers = {_G["ElvUF_TankUnitButton"..i.."Target"]}
						for _, frame in pairs(tanktargetmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupGradient(frame)
							end
						end
					end
				end

				if headerassist ~= nil then
					for i = 1, headerassist:GetNumChildren() do
						assistbutton = select(i, headerassist:GetChildren())
						if assistbutton and assistbutton.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(assistbutton)
						end
					end
				end

				if headerraidpet ~= nil then
					for i = 1, headerraidpet:GetNumChildren() do
						raidpetbutton = select(i, headerraidpet:GetChildren())
						if raidpetbutton and raidpetbutton.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(raidpetbutton)
						end
					end
				end
			end
		end
	end
	hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientUF)

end
