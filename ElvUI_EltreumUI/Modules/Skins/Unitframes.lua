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
local truer = 0
local trueg = 0
local trueb = 0
local trueclass
local _, unit1class
local r,g,b
local unitframe
local _, classunit
local namebar
local reaction
local headergroup = nil
local headertank = nil
local headerassist = nil
local group
local groupbutton
local rgroup,ggroup,bgroup
local tankbutton
local rtank,gtank,btank
local assistbutton
local rassist,gassist,bassist
local orientation
local barTexture
local texture

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
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, false))
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

			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if E. Retail then
					if unit1class == 'WARRIOR' then
						truer = 0.77646887302399
						trueg = 0.60784178972244
						trueb = 0.4274500310421
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.95686066150665
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.66666519641876
						trueg = 0.82744914293289
						trueb = 0.44705784320831
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.99999779462814
						trueg = 0.95686066150665
						trueb = 0.40784224867821
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then --priest ruins everything gradient
						trueclass = "PRIEST"
						return
					elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						truer = 0.99999779462814
						trueg = 0.99999779462814
						trueb = 0.99999779462814
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.11764679849148
						trueb = 0.2274504750967
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' then
						truer = 0
						trueg = 0.4392147064209
						trueb = 0.86666476726532
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.24705828726292
						trueg = 0.78039044141769
						trueb = 0.92156660556793
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.52941060066223
						trueg = 0.53333216905594
						trueb = 0.93333131074905
						trueclass = "WARLOCK"
					elseif unit1class == 'MONK' then
						truer = 0
						trueg = 0.99999779462814
						trueb = 0.59607714414597
						trueclass = "MONK"
					elseif unit1class == 'DRUID' then
						truer = 0.99999779462814
						trueg = 0.48627343773842
						trueb = 0.039215601980686
						trueclass = "DRUID"
					elseif unit1class == 'DEMONHUNTER' then
						truer = 0.63921427726746
						trueg = 0.1882348805666
						trueb = 0.78823357820511
						trueclass = "DEMONHUNTER"
					end
				elseif E.Wrath or E.TBC or E.Classic then
					if unit1class == 'WARRIOR' then
						truer = 0.78039044141769
						trueg = 0.61176335811615
						trueb = 0.43137159943581
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.96078222990036
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.67058676481247
						trueg = 0.8313707113266
						trueb = 0.45097941160202
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.99999779462814
						trueg = 0.96078222990036
						trueb = 0.41176378726959
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then --priest ruins everything gradient
						trueclass = "PRIEST"
						return
					elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						truer = 0.99999779462814
						trueg = 0.99999779462814
						trueb = 0.99999779462814
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.1215683594346
						trueb = 0.23137204349041
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
						truer = 0
						trueg = 0.4392147064209
						trueb = 0.87058633565903
						trueclass = "SHAMAN"
					elseif unit1class == 'SHAMAN' and E.Classic then
						truer = 0.96078222990036
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.25097984075546
						trueg = 0.78039044141769
						trueb = 0.92156660556793
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.52941060066223
						trueg = 0.52941060066223
						trueb = 0.92940974235535
						trueclass = "WARLOCK"
					elseif unit1class == 'DRUID' then
						truer = 0.99999779462814
						trueg = 0.49019500613213
						trueb = 0.039215601980686
						trueclass = "DRUID"
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if E. Retail then
					if unit1class == 'WARRIOR' then
						truer = 0.58039087057114
						trueg = 0.45490095019341
						trueb = 0.32156792283058
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.71764546632767
						trueg = 0.41176378726959
						trueb = 0.54509681463242
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.49803811311722
						trueg = 0.61960649490356
						trueb = 0.33333259820938
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.74901795387268
						trueg = 0.71764546632767
						trueb = 0.30588167905807
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' then
						truer = 0.74901795387268
						trueg = 0.74901795387268
						trueb = 0.74901795387268
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.086274318397045
						trueb = 0.16862708330154
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' then
						truer = 0
						trueg = 0.32941102981567
						trueb = 0.65097898244858
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.18431332707405
						trueg = 0.58431243896484
						trueb = 0.69019454717636
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.39607757329941
						trueg = 0.39999911189079
						trueb = 0.69803768396378
						trueclass = "WARLOCK"
					elseif unit1class == 'MONK' then
						truer = 0
						trueg = 0.74901795387268
						trueb = 0.44705784320831
						trueclass = "MONK"
					elseif unit1class == 'DRUID' then
						truer = 0.74901795387268
						trueg = 0.36470508575439
						trueb = 0.027450919151306
						trueclass = "DRUID"
					elseif unit1class == 'DEMONHUNTER' then
						truer = 0.47843033075333
						trueg = 0.14117616415024
						trueb = 0.59215557575226
						trueclass = "DEMONHUNTER"
					end
				elseif E.Wrath or E.TBC or E.Classic then
					if unit1class == 'WARRIOR' then
						truer = 0.58431243896484
						trueg = 0.45882251858711
						trueb = 0.32156792283058
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.72156703472137
						trueg = 0.41176378726959
						trueb = 0.54901838302612
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.50195968151093
						trueg = 0.62352806329727
						trueb = 0.33725416660309
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.74901795387268
						trueg = 0.72156703472137
						trueb = 0.30588167905807
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' then
						truer = 0.74901795387268
						trueg = 0.74901795387268
						trueb = 0.74901795387268
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.090195879340172
						trueb = 0.17254863679409
						trueclass = "DEMONHUNTER"
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
						truer = 0
						trueg = 0.32941102981567
						trueb = 0.65097898244858
						trueclass = "SHAMAN"
					elseif unit1class == 'SHAMAN' and E.Classic then
						truer = 0.72156703472137
						trueg = 0.41176378726959
						trueb = 0.54901838302612
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.1882348805666
						trueg = 0.58431243896484
						trueb = 0.69019454717636
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.39607757329941
						trueg = 0.39607757329941
						trueb = 0.69803768396378
						trueclass = "WARLOCK"
					elseif unit1class == 'DRUID' then
						truer = 0.74901795387268
						trueg = 0.3686266541481
						trueb = 0.031372480094433
						trueclass = "DRUID"
					end
				end
			end

			local function ApplyGroupGradientTexture(r, g, b, button)
				button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
				if tostring(r) == tostring(truer) and tostring(g) == tostring(trueg) and tostring(b) == tostring(trueb) then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass, false, false))
							else
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass, false, false))
							end
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass, false, true))
							else
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass, false, true))
							end
						end
					elseif not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
								button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(trueclass))
							else
								button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture(trueclass))
							end
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable and button.Health.backdropTex then
								button.Health.backdropTex:SetTexture(ElvUI_EltreumUI:UnitframeClassTextureCustom(trueclass))
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
							if E.db.ElvUI_EltreumUI.unitframes.lightmode then
								rgroup,ggroup,bgroup = groupbutton.Health:GetStatusBarColor()
							elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and groupbutton.Health.backdropTex then
								rgroup,ggroup,bgroup = groupbutton.Health.backdropTex:GetVertexColor()
							end
							ApplyGroupGradientTexture(rgroup, ggroup, bgroup, groupbutton)
						end
					end
				end
			end

			if headertank ~= nil then
				for i = 1, headertank:GetNumChildren() do
					tankbutton = select(i, headertank:GetChildren())
					if tankbutton and tankbutton.Health then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							rtank,gtank,btank = tankbutton.Health:GetStatusBarColor()
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and tankbutton.Health.backdropTex then
							rtank,gtank,btank = tankbutton.Health.backdropTex:GetVertexColor()
						end
						ApplyGroupGradientTexture(rtank, gtank, btank, tankbutton)
					end
				end
			end

			if headerassist ~= nil then
				for i = 1, headerassist:GetNumChildren() do
					assistbutton = select(i, headerassist:GetChildren())
					if assistbutton and assistbutton.Health then
						if E.db.ElvUI_EltreumUI.unitframes.lightmode then
							rassist,gassist,bassist = assistbutton.Health:GetStatusBarColor()
						elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and assistbutton.Health.backdropTex then
							rassist,gassist,bassist = assistbutton.Health.backdropTex:GetVertexColor()
						end
						ApplyGroupGradientTexture(rassist, gassist, bassist, assistbutton)
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
			if statusBar and statusBar.backdrop and E.db.ElvUI_EltreumUI.unitframes.lightmode then
				--statusBar.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				statusBar.backdrop:Hide()
			end
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
