local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitIsTapDenied = _G.UnitIsTapDenied
local UnitPlayerControlled = _G.UnitPlayerControlled
local _, buttonclass, classunit, unitframe, reaction
local UnitIsCharmed = _G.UnitIsCharmed
local pairs = _G.pairs
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
local UnitIsConnected = _G.UnitIsConnected

--function to check if colormixin tables are equal, if they are return false since its used to do something after that
function ElvUI_EltreumUI:ColorMixinTableMatching(table1,table2)
	local r1,g1,b1,a1 = table1.r,table1.g,table1.b,table1.a
	local r2,g2,b2,a2 = table2.r,table2.g,table2.b,table2.a
	if r1 == r2 and g1 == g2 and b1 == b2 and a1 == a2 then
		return false
	else
		return true
	end
end

local invertframes = {
	["boss"] = true,
	--["target"] = true,
	["targettarget"] = true,
	["arena"] = true,
}

--set the backdrop gradient
function ElvUI_EltreumUI:ApplyGradientBackdrop(unit,frame,englishClass,reactionunit,isGroupFrame,name)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
		if E.db.unitframe.colors.transparentHealth then
			if frame.Health and frame.Health.backdrop then
				if E.db.unitframe.thinBorders then
					frame.Health.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				else
					frame.Health.backdrop.Center:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				end
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.bg then
						frame.Health.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetVertexColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
					end
				end
			end
		end
		if not frame.EltruismDebuffExists then
			if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
								if invertframes[name] then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, true, true, true))
								else
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, false, true, true))
								end
							else
								if invertframes[name] then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
								else
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
								if invertframes[name] then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, true, true, true))
								else
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, false, true, true))
								end
							else
								if invertframes[name] then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
								else
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
								end
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if frame.Health.backdrop.Center then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
								if invertframes[name] then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, true, true, true))
								else
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(englishClass, false, true, true))
								end
							else
								if invertframes[name] then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
								else
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
								if invertframes[name] then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, true, true, true))
								else
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(englishClass, false, true, true))
								end
							else
								if invertframes[name] then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
								else
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
								end
							end
						end
					end
				end
			else
				if isGroupFrame then
					if E.db.ElvUI_EltreumUI.unitframes.lightmode then
						if frame.Health.backdropTex then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true, true))
								else
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true, true))
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
								else
									frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
						if frame.Health.backdrop.Center then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true, true))
								else
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true, true))
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
								else
									frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
								end
							end
						end
					end
				else
					if not reaction then return end
					if E.db.ElvUI_EltreumUI.unitframes.lightmode then
						if frame.Health.backdropTex then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if invertframes[name] then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
										else
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
										end
									end
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
										else
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
										end
									end
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
										else
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
										end
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true, true))
											elseif reactionunit <= 2 then
												frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
										else
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if reactionunit >= 5 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true, true))
										elseif reactionunit == 4 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true, true))
										elseif reactionunit == 3 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true, true))
										elseif reactionunit <= 2 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true, true))
										end
									else
										if reactionunit >= 5 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true, true))
										elseif reactionunit == 4 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true, true))
										elseif reactionunit == 3 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true, true))
										elseif reactionunit <= 2 then
											frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true, true))
										end
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
									else
										frame.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
									end
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
						if frame.Health.backdrop.Center then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if invertframes[name] then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
										else
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
										end
									end
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
										else
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
										end
									end
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", true, true, true))
										else
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", true, true, true))
										end
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true, true))
											end
										else
											if reactionunit >= 5 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true, true))
											elseif reactionunit == 4 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true, true))
											elseif reactionunit == 3 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true, true))
											elseif reactionunit == 2 or reactionunit == 1 then
												frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
										else
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorbackdrop then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if reactionunit >= 5 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true, true))
										elseif reactionunit == 4 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true, true))
										elseif reactionunit == 3 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true, true))
										elseif reactionunit == 2 or reactionunit == 1 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true, true))
										end
									else
										if reactionunit >= 5 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true, true))
										elseif reactionunit == 4 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true, true))
										elseif reactionunit == 3 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true, true))
										elseif reactionunit == 2 or reactionunit == 1 then
											frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true, true))
										end
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("BACKDROP", false, true, true))
									else
										frame.Health.backdrop.Center:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("BACKDROP", false, true, true))
									end
								end
							end
						end
					end
				end
			end
		else
			if E.db.ElvUI_EltreumUI.unitframes.lightmode then
				if frame.Health.backdropTex then
					frame.Health.backdropTex:SetGradient("HORIZONTAL", {r = frame.EltruismDebuffr, g = frame.EltruismDebuffg, b = frame.EltruismDebuffb, a = frame.EltruismDebuffa}, {r = frame.EltruismDebuffr, g = frame.EltruismDebuffg, b = frame.EltruismDebuffb, a = frame.EltruismDebuffa})
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				if frame.Health.backdrop.Center then
					frame.Health.backdrop.Center:SetGradient("HORIZONTAL", {r = frame.EltruismDebuffr, g = frame.EltruismDebuffg, b = frame.EltruismDebuffb, a = frame.EltruismDebuffa}, {r = frame.EltruismDebuffr, g = frame.EltruismDebuffg, b = frame.EltruismDebuffb, a = frame.EltruismDebuffa})
				end
			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
			if UnitIsDeadOrGhost(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				end
			elseif UnitIsTapDenied(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.tapped.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.tapped.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.tapped.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.tapped.r, g = E.db.unitframe.colors.tapped.g, b = E.db.unitframe.colors.tapped.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.tapped.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.tapped.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.tapped.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.tapped.r, g = E.db.unitframe.colors.tapped.g, b = E.db.unitframe.colors.tapped.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				end
			elseif not UnitIsConnected(unit) then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if frame.Health.backdropTex then
						frame.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if frame.Health.backdrop.Center then
						frame.Health.backdrop.Center:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				end
			end
		end
	end
end

--set the textures or gradients for single units
function ElvUI_EltreumUI:ApplyUnitGradient(unit,name,unitDB,noOrientation)
	if UnitExists(unit) then
		_, classunit = UnitClass(unit)
		reaction = UnitReaction(unit, "player")
		unitframe = _G["ElvUF_"..name]

		local isPlayer = UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
		local isCharmed = UnitIsCharmed(unit)
		local isActualPlayer = false
		if unitframe and unitframe.Health then
			if unitframe.realUnit then
				if name == "Player" and unitframe.unit == "vehicle" then
					isPlayer = false
					isActualPlayer = false
				end
				if name == "Pet" and unitframe.unit == "player" then
					isPlayer = true
					isActualPlayer = true
					classunit = E.myclass
				end
			end
			if not noOrientation then
				unitframe.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
				ElvUI_EltreumUI:ApplyGradientBackdrop(unit,unitframe,classunit,reaction,false,unitDB)
			end
			if (isPlayer and not isCharmed) or isActualPlayer then
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if invertframes[unitDB] then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
								end
							else
								unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if invertframes[unitDB] then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
								end
							else
								unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
							if UnitIsDeadOrGhost(unit) then
								unitframe.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							elseif not UnitIsConnected(unit) then
								unitframe.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if invertframes[unitDB] then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
								end
							else
								unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
								if invertframes[unitDB] then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
								end
							else
								unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, E.db.unitframe.colors.transparentHealth, false, false, true))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
							if UnitIsDeadOrGhost(unit) then
								unitframe.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							elseif not UnitIsConnected(unit) then
								unitframe.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							end
						end
					end
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
							if invertframes[unitDB] then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction <= 2 then
											unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									if reaction and reaction >= 5 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 4 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 3 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction <= 2 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									end
								end
							else
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									if reaction and reaction >= 5 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 4 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 3 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction <= 2 then
										unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									end
								end
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
							if UnitIsDeadOrGhost(unit) then
								unitframe.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and unitframe.Health.backdropTex then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["enable"..unitDB] then
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
							else
								unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation == "HORIZONTAL" then
							if invertframes[unitDB] then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							elseif name == 'Target' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversetarget then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							elseif name == 'Focus' and E.db.ElvUI_EltreumUI.unitframes.gradientmode.reversefocus then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", true, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								else
									if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									else
										if reaction and reaction >= 5 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 4 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 3 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										elseif reaction and reaction == 2 or reaction == 1 then
											unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
										end
									end
								end
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									if reaction and reaction >= 5 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 4 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 3 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 2 or reaction == 1 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									end
								end
							else
								if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
									unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, E.db.unitframe.colors.transparentHealth, false, false, true))
								else
									if reaction and reaction >= 5 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 4 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 3 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									elseif reaction and reaction == 2 or reaction == 1 then
										unitframe.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, E.db.unitframe.colors.transparentHealth, false, false, true))
									end
								end
							end
						end
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
							if UnitIsDeadOrGhost(unit) then
								unitframe.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
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
function ElvUI_EltreumUI:ApplyGroupGradient(button,noOrientation)

	--due to raid pet, check if is player
	if UnitIsPlayer(button.unit) or (E.Retail and UnitInPartyIsAI(button.unit)) then --C_LFGInfo.IsInLFGFollowerDungeon() could be used
		_, buttonclass = UnitClass(button.unit)
	else
		buttonclass = "NPCFRIENDLY"
	end
	if buttonclass and button.Health then
		if not noOrientation then
			button.Health:SetOrientation(E.db.ElvUI_EltreumUI.unitframes.UForientation)
		end
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
			ElvUI_EltreumUI:ApplyGradientBackdrop(button.unit,button,buttonclass,nil,true)
		end
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					else
						button.Health:GetStatusBarTexture():SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				end
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, E.db.unitframe.colors.transparentHealth, false, false, true))
				else
					button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, E.db.unitframe.colors.transparentHealth, false, false, true))
				end
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
					if UnitIsDeadOrGhost(button.unit) then
						button.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					elseif not UnitIsConnected(button.unit) then
						button.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				end
			end
		elseif E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablegroupunits then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.useUFtexture then
						button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					else
						button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					end
				end
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					button.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(buttonclass, false, E.db.unitframe.colors.transparentHealth, false, false, true))
				else
					button.Health.backdropTex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(buttonclass, false, E.db.unitframe.colors.transparentHealth, false, false, true))
				end
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.usedeadbackdrop then
					if UnitIsDeadOrGhost(button.unit) then
						button.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.health_backdrop_dead.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.health_backdrop_dead.r, g = E.db.unitframe.colors.health_backdrop_dead.g, b = E.db.unitframe.colors.health_backdrop_dead.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					elseif not UnitIsConnected(button.unit) then
						button.Health.backdropTex:SetGradient("HORIZONTAL", {r = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.r - 0.3, 0, 1), g = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.g - 0.3, 0, 1), b = ElvUI_EltreumUI:Interval(E.db.unitframe.colors.disconnected.b - 0.3, 0, 1), a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r = E.db.unitframe.colors.disconnected.r, g = E.db.unitframe.colors.disconnected.g, b = E.db.unitframe.colors.disconnected.b, a = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
					end
				end
			end
		end
		if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
			if E.db.ElvUI_EltreumUI.unitframes.darkmode and button.Health.backdropTex then
				button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture))
			end
		end
	end
end

local forced = false
function ElvUI_EltreumUI:GradientUF(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and (E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.darkmode) then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		ElvUI_EltreumUI:ApplyUnitGradient("player", "Player", "player")
		if UnitExists("target") then
			ElvUI_EltreumUI:ApplyUnitGradient("target", "Target", "target")
		end
		if UnitExists("targettarget") then
			ElvUI_EltreumUI:ApplyUnitGradient("targettarget", "TargetTarget", "targettarget")
		end
		if UnitExists("targettargettarget") then
			ElvUI_EltreumUI:ApplyUnitGradient("targettargettarget", "TargetTargetTarget", "targettargettarget")
		end
		if UnitExists("pet") then
			ElvUI_EltreumUI:ApplyUnitGradient("pet", "Pet", "pet")
		end

		if not E.Classic then
			if UnitExists("boss1") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss1", "Boss1", "boss", true)
			end
			if UnitExists("boss2") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss2", "Boss2", "boss", true)
			end
			if UnitExists("boss3") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss3", "Boss3", "boss", true)
			end
			if UnitExists("boss4") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss4", "Boss4", "boss", true)
			end
			if UnitExists("boss5") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss5", "Boss5", "boss", true)
			end
			if UnitExists("boss6") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss6", "Boss6", "boss", true)
			end
			if UnitExists("boss7") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss7", "Boss7", "boss", true)
			end
			if UnitExists("boss8") then
				ElvUI_EltreumUI:ApplyUnitGradient("boss8", "Boss8", "boss", true)
			end
			if UnitExists("focus") then
				ElvUI_EltreumUI:ApplyUnitGradient("focus", "Focus", "focus")
			end
			if UnitExists("focustarget") then
				ElvUI_EltreumUI:ApplyUnitGradient("focustarget", "FocusTarget", "focustarget")
			end
			if UnitExists("arena1") then
				ElvUI_EltreumUI:ApplyUnitGradient("arena1", "Arena1", "arena", true)
			end
			if UnitExists("arena2") then
				ElvUI_EltreumUI:ApplyUnitGradient("arena2", "Arena2", "arena", true)
			end
			if UnitExists("arena3") then
				ElvUI_EltreumUI:ApplyUnitGradient("arena3", "Arena3", "arena", true)
			end
			if UnitExists("arena4") then
				ElvUI_EltreumUI:ApplyUnitGradient("arena4", "Arena4", "arena", true)
			end
			if UnitExists("arena5") then
				ElvUI_EltreumUI:ApplyUnitGradient("arena5", "Arena5", "arena", true)
			end
		end

		if unit == "testunit" then
			forced = true
			unit = "player"
		else
			forced = false
		end

		if forced then
			if E.Retail or E.Cata then
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss1", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss2", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss3", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss4", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss5", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss6", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss7", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Boss8", "boss", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Arena1", "arena", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Arena2", "arena", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Arena3", "arena", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Arena4", "arena", true)
				ElvUI_EltreumUI:ApplyUnitGradient("player", "Arena5", "arena", true)
			end
		end

		--group/raid unitframes
		if (UnitExists(unit) or forced) then
			--party/raid
			if _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsVisible() then
				--print("party gradient firing",math.random(1,99))
				local partymembers = {_G["ElvUF_PartyGroup1"]:GetChildren()}
				for _, frame in pairs(partymembers) do
					if frame and frame.Health then
						ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
					end
				end
				if E.db.unitframe.units.party.petsGroup.enable then
					if _G["ElvUF_PartyGroup1UnitButton1Pet"] and _G["ElvUF_PartyGroup1UnitButton1Pet"]:IsVisible() then
						for i = 1, 5 do
							local partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
							if partypetbutton and partypetbutton.Health then
								ElvUI_EltreumUI:ApplyGroupGradient(partypetbutton)
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsVisible() then
				--print("raid1 gradient firing",math.random(1,99))
				for i = 1, 8 do
					if _G["ElvUF_Raid1Group"..i] then
						local raidmembers = {_G["ElvUF_Raid1Group"..i]:GetChildren()}
						for _, frame in pairs(raidmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsVisible() then
				--print("raid2 gradient firing",math.random(1,99))
				for i = 1, 8 do
					if _G["ElvUF_Raid2Group"..i] then
						local raidmembers = {_G["ElvUF_Raid2Group"..i]:GetChildren()}
						for _, frame in pairs(raidmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
							end
						end
					end
				end
			end

			if _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsVisible() then
				--print("raid3 gradient firing",math.random(1,99))
				for i = 1, 8 do
					if _G["ElvUF_Raid3Group"..i] then
						local raidmembers = {_G["ElvUF_Raid3Group"..i]:GetChildren()}
						for _, frame in pairs(raidmembers) do
							if frame and frame.Health then
								ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
							end
						end
					end
				end
			end

			--tanks
			if _G["ElvUF_TankUnitButton1"] and _G["ElvUF_TankUnitButton1"]:IsVisible() then
				--print("tank gradient firing",math.random(1,99))
				for i = 1, 8 do
					local tankmembers = {_G["ElvUF_TankUnitButton"..i]}
					for _, frame in pairs(tankmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
						end
					end
				end
			end

			--tank targets
			if _G["ElvUF_TankUnitButton1Target"] and _G["ElvUF_TankUnitButton1Target"]:IsVisible() then
				--print("tank target gradient firing",math.random(1,99))
				for i = 1, 8 do
					local tanktargetmembers = {_G["ElvUF_TankUnitButton"..i.."Target"]}
					for _, frame in pairs(tanktargetmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(frame)
						end
					end
				end
			end

			--raid assist
			if _G["ElvUF_AssistUnitButton1"] and _G["ElvUF_AssistUnitButton1"]:IsVisible() then
				--print("assist gradient firing",math.random(1,99))
				for i = 1, 8 do
					local assistmembers = {_G["ElvUF_AssistUnitButton"..i]}
					for _, frame in pairs(assistmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
						end
					end
				end
			end

			--raid assist targets
			if _G["ElvUF_AssistUnitButton1Target"] and _G["ElvUF_AssistUnitButton1Target"]:IsVisible() then
				--print("assist target gradient firing",math.random(1,99))
				for i = 1, 8 do
					local assisttargetmembers = {_G["ElvUF_AssistUnitButton"..i.."Target"]}
					for _, frame in pairs(assisttargetmembers) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(frame)
						end
					end
				end
			end

			--raid pets
			if _G["ElvUF_RaidpetGroup1UnitButton1"] and _G["ElvUF_RaidpetGroup1UnitButton1"]:IsVisible() and E.db.unitframe.units.raidpet.enable then
				--print("raid pet gradient firing",math.random(1,99))
				for i = 1, 40 do
					local raidpetbutton = {_G["ElvUF_RaidpetGroup1UnitButton"..i]}
					for _, frame in pairs(raidpetbutton) do
						if frame and frame.Health then
							ElvUI_EltreumUI:ApplyGroupGradient(frame,true)
						end
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientUF)

--allows previews to show custom textures and gradients
hooksecurefunc(UF, "ToggleForceShowGroupFrames", function()
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	ElvUI_EltreumUI:GradientPower("testunit")
end)
--omnicd fix
hooksecurefunc(UF, "HeaderConfig", function()
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	ElvUI_EltreumUI:GradientPower("testunit")
end)
