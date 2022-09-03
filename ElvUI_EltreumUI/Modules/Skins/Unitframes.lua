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
local _, unit1class, buttonclass, classunit, unitframe, namebar, reaction
local headergroup = nil
local headertank = nil
local headerassist = nil
local group, groupbutton, tankbutton, assistbutton
local orientation, barTexture, texture

--set the textures or gradients
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
				if reaction and reaction >= 5 then
					namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
				elseif reaction and reaction == 4 then
					namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
				elseif reaction and reaction == 3 then
					namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
				elseif reaction and reaction <= 2 then
					namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
				end
			end
		end
	end
	--if UF["units"][uf] and UnitExists(unit) then
	--E.db["unitframe"]["units"][uf] fails for target of target of target
	if UnitExists(unit) then
		unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Health then
			unitframe.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then ---TODO confirm this is fine for dark mode
				--unitframe.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				unitframe.Health:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				unitframe.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unit] then
					if UnitIsPlayer(unit) then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
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
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
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
					else
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
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
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
							unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
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
			else
				if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if UnitIsPlayer(unit) then
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit))
						else
							unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unit.."texture"]))
						end
					else
						if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect then
							if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
								unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("TAPPED"))
							else
								if reaction and reaction >= 5 then
									unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY"))
								elseif reaction and reaction == 4 then
									unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL"))
								elseif reaction and reaction == 3 then
									unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY"))
								elseif reaction and reaction <= 2 then
									unitframe.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE"))
								end
							end
						else
							unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"][unit.."texture"]))
						end
					end
				else
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
end

function ElvUI_EltreumUI:GradientCustomTexture(unit)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		ElvUI_EltreumUI:ApplyUnitGradientTexture("player", "Player", "player")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("target", "Target", "target")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("targettarget", "TargetTarget", "targettarget")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("targettargettarget", "TargetTargetTarget"," targetargettarget")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("pet", "Pet", "pet")
		if E.Retail then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss1", "Boss1", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss2", "Boss2", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss3", "Boss3", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss4", "Boss4", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss5", "Boss5", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss6", "Boss6", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss7", "Boss7", "boss")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss8", "Boss8", "boss")
		end
		if E.Retail or E.TBC or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("focus", "Focus", "focus")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena1", "Arena1", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena2", "Arena2", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena3", "Arena3", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena4", "Arena4", "arena")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("arena5", "Arena5", "arena")
		end

		--group/raid unitframes
		if UnitExists(unit) and (E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.darkmode) then

			headergroup = nil
			if _G["ElvUF_Raid"] and _G["ElvUF_Raid"]:IsShown() then
				headergroup = _G["ElvUF_Raid"]
			elseif _G["ElvUF_Raid40"] and _G["ElvUF_Raid40"]:IsShown() then
				headergroup = _G["ElvUF_Raid40"]
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

			local function ApplyGroupGradientTexture(button)
				button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then ---TODO confirm this is fine for dark mode
					--button.Health.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					unitframe.Health:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					unitframe.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				_, buttonclass = UnitClass(button.unit)
				if buttonclass then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, false))
							else
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, false))
							end
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, true))
							else
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, true))
							end
						end
					elseif not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
								button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
							else
								button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture(buttonclass))
							end
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable and button.Health.backdropTex then
								button.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(buttonclass))
							end
						end
					end
				end
			end

			if headergroup ~= nil then
				for i = 1, headergroup:GetNumChildren() do
					group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Health then
							ApplyGroupGradientTexture(groupbutton)
						end
					end
				end
			end

			if headertank ~= nil then
				for i = 1, headertank:GetNumChildren() do
					tankbutton = select(i, headertank:GetChildren())
					if tankbutton and tankbutton.Health then
						ApplyGroupGradientTexture(tankbutton)
					end
				end
			end

			if headerassist ~= nil then
				for i = 1, headerassist:GetNumChildren() do
					assistbutton = select(i, headerassist:GetChildren())
					if assistbutton and assistbutton.Health then
						ApplyGroupGradientTexture(assistbutton)
					end
				end
			end
		end

	end
end
hooksecurefunc(UF, "Style", ElvUI_EltreumUI.GradientCustomTexture) --if not hooking into this then when the target of target changes it doesnt update
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientCustomTexture)

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
		local texture = E.LSM:Fetch('statusbar', self.db.statusbar)
		statusBar:SetStatusBarTexture(texture)
		UF:Update_StatusBar(statusBar.bg or statusBar.BG, texture)

		if adjustBackdropPoints then
			UF:SetStatusBarBackdropPoints(statusBar, barTexture, backdropTex, orientation, reverseFill)
		end
	end
end

--modify the position of the information panel
function UF:Configure_InfoPanel(frame)
	local db = frame.db

	if frame.USE_INFO_PANEL then
		frame.InfoPanel:Show()
		frame.InfoPanel:ClearAllPoints()

		if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.infopanelontop then
			frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
			frame.InfoPanel:Point('BOTTOMLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
			frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
			frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
			frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
		else
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
