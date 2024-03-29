local E = unpack(ElvUI)
local AB = E:GetModule('ActionBars')
local LCG = E.Libs.CustomGlow
--local LCG = LibStub('LibCustomGlow-1.0')
local classcolor = E:ClassColor(E.myclass, true)
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local IsUsableSpell = _G.IsUsableSpell
local GetSpellCooldown = _G.GetSpellCooldown
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local UnitCreatureType = _G.UnitCreatureType
local InCombatLockdown = _G.InCombatLockdown
local GetPetActionInfo = _G.GetPetActionInfo
local pairs = _G.pairs
--moving createframes out of the function for some reason breaks it

-- Skill Glow
function ElvUI_EltreumUI:SkillGlow()
	if not E.private.ElvUI_EltreumUI then
		return
	end
	local skillglowcolor
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
	else
		skillglowcolor = {E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b, 1}
	end

	if E.db.ElvUI_EltreumUI.glow.enable and E.private.actionbar.enable then
		if not IsAddOnLoaded("ElvUI_ActionBarMasks") then
			local proc = {}
			hooksecurefunc(LCG, "ShowOverlayGlow", function(button)
				if button:GetAttribute("type") == "action" then
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
						if E.db.ElvUI_EltreumUI.glow.gradient then
							for k,v in pairs({button._PixelGlow:GetRegions()}) do
								local r,g,b = v:GetVertexColor()
								v:SetVertexColor((r-(k/20)),(g-(k/20)),(b-(k/20)),1)
							end
						end
						if button.AutoCastShine then
							button.AutoCastShine:Hide()
						end
						if button._ButtonGlow then
							button._ButtonGlow:Hide()
						end
						if button._ProcGlow then
							button._ProcGlow:Hide()
						end
					elseif E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
						if button._PixelGlow then
							button._PixelGlow:Hide()
						end
						if button._ButtonGlow then
							button._ButtonGlow:Hide()
						end
						if button._ProcGlow then
							button._ProcGlow:Hide()
						end
						if E.db.ElvUI_EltreumUI.glow.gradient then
							for k,v in pairs({button._AutoCastGlow:GetRegions()}) do
								local r,g,b = v:GetVertexColor()
								v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
							end
						end
					elseif E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
						if button._PixelGlow then
							button._PixelGlow:Hide()
						end
						if button.AutoCastShine then
							button.AutoCastShine:Hide()
						end
						if button._ProcGlow then
							button._ProcGlow:Hide()
						end
						button._ButtonGlow.outerGlow:SetScale(1.15)
						if E.db.ElvUI_EltreumUI.glow.gradient then
							if E.db.ElvUI_EltreumUI.glow.colorclass then
								button._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
							else
								button._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b + 0.2, a = 1})
							end
						end
					elseif E.db.ElvUI_EltreumUI.glow.procglow then
						proc.color = skillglowcolor
						proc.duration = E.db.ElvUI_EltreumUI.glow.proc.duration
						proc.startAnim = E.db.ElvUI_EltreumUI.glow.proc.startAnimation
						proc.frameLevel = E.db.ElvUI_EltreumUI.glow.proc.frameLevel
						proc.xOffset = E.db.ElvUI_EltreumUI.glow.proc.xOffset
						proc.yOffset = E.db.ElvUI_EltreumUI.glow.proc.yOffset
						if button._PixelGlow then
							button._PixelGlow:Hide()
						end
						if button.AutoCastShine then
							button.AutoCastShine:Hide()
						end
						if button._ButtonGlow then
							button._ButtonGlow:Hide()
						end
						LCG.ProcGlow_Start(button, proc)

						--proc uses an atlas so gradient is not a thing
					end
				end
			end)
			hooksecurefunc(LCG, "HideOverlayGlow", function(button)
				if E.db.ElvUI_EltreumUI.glow.pixel then
					LCG.PixelGlow_Stop(button)
				elseif E.db.ElvUI_EltreumUI.glow.autocast then
					LCG.AutoCastGlow_Stop(button)
				elseif E.db.ElvUI_EltreumUI.glow.blizzard then
					LCG.ButtonGlow_Stop(button)
				elseif E.db.ElvUI_EltreumUI.glow.procglow then
					LCG.ProcGlow_Stop(button)
				end
			end)
		end
		if not E.Retail then
			--classic shaman totem bar glow when totems are not active in combat
			if E.myclass == 'SHAMAN' and E.db.ElvUI_EltreumUI.glow.enabletotem and E.db.unitframe.units.player.classbar.enable then
				local totemglowholder = CreateFrame("FRAME")
				local totemglowcombatdetect = CreateFrame("FRAME")
				totemglowcombatdetect:RegisterEvent('PLAYER_REGEN_DISABLED')
				totemglowcombatdetect:RegisterEvent('PLAYER_REGEN_ENABLED')
				local totem1glowcolor = {0.58, 0.23, 0.10, 1}
				local totem2glowcolor = {0.23,0.45,0.13, 1}
				local totem3glowcolor = {0.19,0.48,0.60, 1}
				local totem4glowcolor = {0.42,0.18,0.74, 1}

				local totemglow1 = CreateFrame("FRAME","EltruismTotemGlow2")
				totemglow1:SetParent(_G["ElvUF_Player"])
				local totemglow2 = CreateFrame("FRAME","EltruismTotemGlow1")
				totemglow2:SetParent(_G["ElvUF_Player"])
				local totemglow3 = CreateFrame("FRAME","EltruismTotemGlow3")
				totemglow3:SetParent(_G["ElvUF_Player"])
				local totemglow4 = CreateFrame("FRAME","EltruismTotemGlow4")
				totemglow4:SetParent(_G["ElvUF_Player"])
				--set the sizes differently depending on type because blizz glow is not nice
				if E.db.ElvUI_EltreumUI.glow.pixel or E.db.ElvUI_EltreumUI.glow.autocast then
					totemglow1:SetAllPoints(_G["ElvUF_PlayerTotem2"])
					totemglow2:SetAllPoints(_G["ElvUF_PlayerTotem1"]) --earth and fire got inverted
					totemglow3:SetAllPoints(_G["ElvUF_PlayerTotem3"])
					totemglow4:SetAllPoints(_G["ElvUF_PlayerTotem4"])
				elseif E.db.ElvUI_EltreumUI.glow.blizzard then
					local t1x, t1y = _G["ElvUF_PlayerTotem2"]:GetSize()
					totemglow1:SetSize(t1x+12, t1y+4)
					totemglow1:SetPoint("Center", _G["ElvUF_PlayerTotem2"])
					local t2x, t2y = _G["ElvUF_PlayerTotem1"]:GetSize()
					totemglow2:SetSize(t2x+12, t2y+4)
					totemglow2:SetPoint("Center", _G["ElvUF_PlayerTotem1"])
					local t3x, t3y = _G["ElvUF_PlayerTotem3"]:GetSize()
					totemglow3:SetSize(t3x+12, t3y+4)
					totemglow3:SetPoint("Center", _G["ElvUF_PlayerTotem3"])
					local t4x, t4y = _G["ElvUF_PlayerTotem4"]:GetSize()
					totemglow4:SetSize(t4x+12, t4y+4)
					totemglow4:SetPoint("Center", _G["ElvUF_PlayerTotem4"])
				end

				if not E.db.ElvUI_EltreumUI.glow.totemtypecolor then
					totem1glowcolor = {E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.r, E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.g, E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.b, 1}
					totem2glowcolor = {E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.r, E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.g, E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.b, 1}
					totem3glowcolor = {E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.r, E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.g, E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.b, 1}
					totem4glowcolor = {E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.r, E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.g, E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.b, 1}
				end

				totemglowcombatdetect:SetScript("OnEvent", function(_, event)
					if event == 'PLAYER_REGEN_DISABLED' then
						local ONUPDATE_INTERVAL = 1
						local TimeSinceLastUpdate = 0
						totemglowholder:SetScript("OnUpdate", function(_, elapsed)
							TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
							if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
								TimeSinceLastUpdate = 0
								if E.db.ElvUI_EltreumUI.glow.totem1 then
									if not _G["ElvUF_PlayerTotem2"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Start(totemglow1, totem1glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 8)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow1._PixelGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/30),g-(k/30),b-(k/30),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Start(totemglow1, totem1glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow1._AutoCastGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Start(totemglow1, totem1glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
											totemglow1._ButtonGlow.outerGlow:SetScale(1.15)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												if E.db.ElvUI_EltreumUI.glow.totemtypecolor then
													--local totem1glowcolor = {0.58, 0.23, 0.10, 1}
													totemglow1._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = 0.38, g = 0.03, b = 0, a = 1}, {r = 0.78, g = 0.43, b = 0.3, a = 1})
												else
													totemglow1._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor.b + 0.2, a = 1})
												end
											end
										end
									elseif _G["ElvUF_PlayerTotem2"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Stop(totemglow1)
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Stop(totemglow1)
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Stop(totemglow1)
										end
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem2 then
									if not _G["ElvUF_PlayerTotem1"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Start(totemglow2, totem2glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 8)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow2._PixelGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/30),g-(k/30),b-(k/30),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Start(totemglow2, totem2glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow2._AutoCastGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Start(totemglow2, totem2glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
											totemglow2._ButtonGlow.outerGlow:SetScale(1.15)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												if E.db.ElvUI_EltreumUI.glow.totemtypecolor then
													--local totem2glowcolor = {0.23,0.45,0.13, 1}
													totemglow2._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = 0.03, g = 0.25, b = 0, a = 1}, {r = 0.43, g = 0.65, b = 0.33, a = 1})
												else
													totemglow2._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor.b + 0.2, a = 1})
												end
											end
										end
									elseif _G["ElvUF_PlayerTotem1"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Stop(totemglow2)
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Stop(totemglow2)
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Stop(totemglow2)
										end
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem3 then
									if not _G["ElvUF_PlayerTotem3"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Start(totemglow3, totem3glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 8)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow3._PixelGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/30),g-(k/30),b-(k/30),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Start(totemglow3, totem3glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow3._AutoCastGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Start(totemglow3, totem3glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
											totemglow3._ButtonGlow.outerGlow:SetScale(1.15)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												if E.db.ElvUI_EltreumUI.glow.totemtypecolor then
													--local totem3glowcolor = {0.19,0.48,0.60, 1}
													totemglow3._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = 0, g = 0.28, b = 0.40, a = 1}, {r = 0.39, g = 0.68, b = 0.80, a = 1})
												else
													totemglow3._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor.b + 0.2, a = 1})
												end
											end
										end
									elseif _G["ElvUF_PlayerTotem3"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Stop(totemglow3)
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Stop(totemglow3)
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Stop(totemglow3)
										end
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem4 then
									if not _G["ElvUF_PlayerTotem4"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Start(totemglow4, totem4glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 8)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow4._PixelGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/30),g-(k/30),b-(k/30),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Start(totemglow4, totem4glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({totemglow4._AutoCastGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Start(totemglow4, totem4glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
											totemglow4._ButtonGlow.outerGlow:SetScale(1.15)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												if E.db.ElvUI_EltreumUI.glow.totemtypecolor then
													--local totem4glowcolor = {0.42,0.18,0.74, 1}
													totemglow4._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = 0.22, g = 0, b = 0.54, a = 1}, {r = 0.62, g = 0.38, b = 0.94, a = 1})
												else
													totemglow4._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor.b + 0.2, a = 1})
												end
											end
										end
									elseif _G["ElvUF_PlayerTotem4"]:IsShown() then
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Stop(totemglow4)
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Stop(totemglow4)
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Stop(totemglow4)
										end
									end
								end
							end
						end)
					elseif event == 'PLAYER_REGEN_ENABLED' then
						totemglowholder:SetScript("OnUpdate", nil)
						if E.db.ElvUI_EltreumUI.glow.pixel then
							LCG.PixelGlow_Stop(totemglow1)
							LCG.PixelGlow_Stop(totemglow2)
							LCG.PixelGlow_Stop(totemglow3)
							LCG.PixelGlow_Stop(totemglow4)
						elseif E.db.ElvUI_EltreumUI.glow.autocast then
							LCG.AutoCastGlow_Stop(totemglow1)
							LCG.AutoCastGlow_Stop(totemglow2)
							LCG.AutoCastGlow_Stop(totemglow3)
							LCG.AutoCastGlow_Stop(totemglow4)
						elseif E.db.ElvUI_EltreumUI.glow.blizzard then
							LCG.ButtonGlow_Stop(totemglow1)
							LCG.ButtonGlow_Stop(totemglow2)
							LCG.ButtonGlow_Stop(totemglow3)
							LCG.ButtonGlow_Stop(totemglow4)
						end
					end
				end)
			end

			if (E.myclass == 'PALADIN' or E.myclass == 'WARRIOR' or E.myclass == 'HUNTER' or E.myclass == 'ROGUE' or E.myclass == 'DEATHKNIGHT') and not IsAddOnLoaded("SpellActivationOverlay") then
				--classic glow proc list
				local SPELL_ID = {

					--victory rush
					[34428] = true,
					--kill command
					[34026] = E.Classic and true or false,
					--riposte
					[14251] = true,

					--execute
					[25236]	= true,
					[25234]	= true,
					[20662]	= true,
					[20661]	= true,
					[20660]	= true,
					[20658]	= true,
					[5308] = true,

					--overpower
					[11585] = true,
					[11584] = true,
					[7887] = true,
					[7384] = true,

					--regenge
					[30327] = true,
					[25288] = true,
					[25269] = true,
					[11601] = true,
					[11600] = true,
					[7379] = true,
					[6574] = true,
					[6572] = true,

					--kill shot
					[53351] = true,
					[61005] = true,
					[61006] = true,

					--rune strike
					[56815] = true,

					--mongoose bite (always works on wotlk)
					[36916] = E.Classic and true or false,
					[14271] = E.Classic and true or false,
					[14270] = E.Classic and true or false,
					[14269] = E.Classic and true or false,
					[1495] = E.Classic and true or false,

					--counterattack
					[27067] = true,
					[20910] = true,
					[20909] = true,
					[19306] = true,

					--exorcism --different in wrath
					[27138] = E.Classic and true or false,
					[10314] = E.Classic and true or false,
					[10313] = E.Classic and true or false,
					[10312] = E.Classic and true or false,
					[5615] = E.Classic and true or false,
					[5614] = E.Classic and true or false,
					[879] = E.Classic and true or false,

					--hammer of wrath
					[27180] = true,
					[24275] = true,
					[24274] = true,
					[24239] = true,

					--shadow bolt
					--[[[27209] = true,
					[25307] = true,
					[11661] = true,
					[11660] = true,
					[11659] = true,
					[7641] = true,
					[1106] = true,
					[1088] = true,
					[705] = true,
					[695] = true,
					[686] = true,]]
				}

				local exorcism = {
					[27138] = true,
					[10314] = true,
					[10313] = true,
					[10312] = true,
					[5615] = true,
					[5614] = true,
					[879] = true,
				}

				function ElvUI_EltreumUI:ClassicGlow(barName)
					local bar = AB["handledBars"][barName]
					if not bar then return end
					local procFrame = CreateFrame('frame')
					procFrame:RegisterEvent('ACTIONBAR_UPDATE_USABLE')
					procFrame:RegisterEvent('ACTIONBAR_UPDATE_STATE')
					procFrame:RegisterEvent('SPELL_UPDATE_USABLE')
					procFrame:RegisterEvent('PLAYER_TARGET_CHANGED')
					procFrame:SetScript('OnEvent', function()
						for i=1, NUM_ACTIONBAR_BUTTONS do
							local button = bar.buttons[i]
							local buttonname = button:GetName()
							local proc = _G[buttonname].abilityID
							--[[if _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() then
								proc = _G[buttonname]:GetSpellId()
							end]]
							if SPELL_ID[proc] then
								local USABLE, NO_MANA = IsUsableSpell(proc)
								local cd = GetSpellCooldown(proc)
								--if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) and _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() == proc then
								if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) then
									if E.myclass == 'PALADIN' then
										if exorcism[proc] then
											local unittype = UnitCreatureType("target")
											--if unittype == "Demon" or unittype == "Dämon" or unittype == "Demonio" or unittype == "Démon" or unittype == "Demone" or unittype == "Demônio" or unittype == "Демон" or unittype == "악마" or unittype == "恶魔" or unittype == "惡魔" or unittype == "Undead" or unittype == "Untoter" or unittype == "No-muerto" or unittype == "Mort-vivant" or unittype == "Non Morto" or unittype == "Renegado" or unittype == "Нежить" or unittype == "언데드" or unittype == "亡灵" or unittype == "不死族" then
											if unittype == _G.PET_TYPE_DEMON or unittype == _G.BATTLE_PET_DAMAGE_NAME_4 then
												if E.db.ElvUI_EltreumUI.glow.pixel then
													LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
													if E.db.ElvUI_EltreumUI.glow.gradient then
														for k,v in pairs({_G[buttonname]._PixelGlow:GetRegions()}) do
															local r,g,b = v:GetVertexColor()
															v:SetVertexColor(r-(k/20),g-(k/20),b-(k/20),1)
														end
													end
												elseif E.db.ElvUI_EltreumUI.glow.autocast then
													LCG.AutoCastGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
													if E.db.ElvUI_EltreumUI.glow.gradient then
														for k,v in pairs({_G[buttonname]._AutoCastGlow:GetRegions()}) do
															local r,g,b = v:GetVertexColor()
															v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
														end
													end
												elseif E.db.ElvUI_EltreumUI.glow.blizzard then
													LCG.ButtonGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
													_G[buttonname]._ButtonGlow.outerGlow:SetScale(1.15)
													if E.db.ElvUI_EltreumUI.glow.gradient then
														if E.db.ElvUI_EltreumUI.glow.colorclass then
															_G[buttonname]._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
														else
															_G[buttonname]._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b + 0.2, a = 1})
														end
													end
												end
											else
												if E.db.ElvUI_EltreumUI.glow.pixel then
													LCG.PixelGlow_Stop(_G[buttonname])
												elseif E.db.ElvUI_EltreumUI.glow.autocast then
													LCG.AutoCastGlow_Stop(_G[buttonname])
												elseif E.db.ElvUI_EltreumUI.glow.blizzard then
													LCG.ButtonGlow_Stop(_G[buttonname])
												end
											end
										else
											if E.db.ElvUI_EltreumUI.glow.pixel then
												LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
												if E.db.ElvUI_EltreumUI.glow.gradient then
														for k,v in pairs({_G[buttonname]._PixelGlow:GetRegions()}) do
															local r,g,b = v:GetVertexColor()
															v:SetVertexColor(r-(k/20),g-(k/20),b-(k/20),1)
														end
													end
											elseif E.db.ElvUI_EltreumUI.glow.autocast then
												LCG.AutoCastGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
												if E.db.ElvUI_EltreumUI.glow.gradient then
													for k,v in pairs({_G[buttonname]._AutoCastGlow:GetRegions()}) do
														local r,g,b = v:GetVertexColor()
														v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
													end
												end
											elseif E.db.ElvUI_EltreumUI.glow.blizzard then
												LCG.ButtonGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
												_G[buttonname]._ButtonGlow.outerGlow:SetScale(1.15)
												if E.db.ElvUI_EltreumUI.glow.gradient then
													if E.db.ElvUI_EltreumUI.glow.colorclass then
														_G[buttonname]._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
													else
														_G[buttonname]._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b + 0.2, a = 1})
													end
												end
											end
										end
									--[[elseif E.myclass == 'WARLOCK' then
										procFrame:RegisterUnitEvent('UNIT_AURA', "player")
										for i = 1, 30 do
											--auraid = select(10, UnitAura("player", i)) --unitaura is deprecated
											--print(auraid)
											if auraid == 34936 or auraid == 17941 then --backlash and shadow trance
												if E.db.ElvUI_EltreumUI.glow.pixel and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
													LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
												elseif E.db.ElvUI_EltreumUI.glow.autocast and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
													LCG.AutoCastGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
												elseif E.db.ElvUI_EltreumUI.glow.blizzard and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
													LCG.ButtonGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
												end
											elseif not auraid or auraid ~= 34936 or auraid ~= 17941 then
												if E.db.ElvUI_EltreumUI.glow.pixel and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
													LCG.PixelGlow_Stop(_G[buttonname])
												elseif E.db.ElvUI_EltreumUI.glow.autocast and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
													LCG.AutoCastGlow_Stop(_G[buttonname])
												elseif E.db.ElvUI_EltreumUI.glow.blizzard and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
													LCG.ButtonGlow_Stop(_G[buttonname])
												end
											end
										end]]
									else
										if E.db.ElvUI_EltreumUI.glow.pixel then
											LCG.PixelGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({_G[buttonname]._PixelGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/20),g-(k/20),b-(k/20),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.autocast then
											LCG.AutoCastGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												for k,v in pairs({_G[buttonname]._AutoCastGlow:GetRegions()}) do
													local r,g,b = v:GetVertexColor()
													v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
												end
											end
										elseif E.db.ElvUI_EltreumUI.glow.blizzard then
											LCG.ButtonGlow_Start(_G[buttonname], skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
											_G[buttonname]._ButtonGlow.outerGlow:SetScale(1.15)
											if E.db.ElvUI_EltreumUI.glow.gradient then
												if E.db.ElvUI_EltreumUI.glow.colorclass then
													_G[buttonname]._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
												else
													_G[buttonname]._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b + 0.2, a = 1})
												end
											end
										end
									end
								else
									if E.db.ElvUI_EltreumUI.glow.pixel then
										LCG.PixelGlow_Stop(_G[buttonname])
									elseif E.db.ElvUI_EltreumUI.glow.autocast then
										LCG.AutoCastGlow_Stop(_G[buttonname])
									elseif E.db.ElvUI_EltreumUI.glow.blizzard then
										LCG.ButtonGlow_Stop(_G[buttonname])
									end
								end
							else
								if E.db.ElvUI_EltreumUI.glow.pixel then
									LCG.PixelGlow_Stop(_G[buttonname])
								elseif E.db.ElvUI_EltreumUI.glow.autocast then
									LCG.AutoCastGlow_Stop(_G[buttonname])
								elseif E.db.ElvUI_EltreumUI.glow.blizzard then
									LCG.ButtonGlow_Stop(_G[buttonname])
								end
							end
						end
					end)
				end

				local classicglowframe = CreateFrame("FRAME")
				classicglowframe:RegisterEvent("PLAYER_STARTED_MOVING")
				classicglowframe:RegisterEvent("PLAYER_LOGIN")
				classicglowframe:RegisterEvent("FIRST_FRAME_RENDERED")
				--classicglowframe:RegisterEvent('ACTIONBAR_UPDATE_USABLE')
				classicglowframe:SetScript("OnEvent", function()
					classicglowframe:UnregisterAllEvents()
					if not InCombatLockdown() then
						hooksecurefunc(AB, 'PositionAndSizeBar', ElvUI_EltreumUI.ClassicGlow)
						for i = 1, 10 do
							AB:PositionAndSizeBar('bar'..i)
						end
					end
				end)
			end
		end
	end
end

--Skill Glow Pet
local skillglowcolorpet = {classcolor.r, classcolor.g, classcolor.b, 1}
function ElvUI_EltreumUI:SkillGlowPet()
	if IsAddOnLoaded("ElvUI_ActionBarMasks") then return end
	if not UnitExists("pet") then return end
	if not IsAddOnLoaded("ElvUI_EltreumUI") then return end
	if not E.private.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI.glow then return end
	if E.db.ElvUI_EltreumUI.glow.enablepet and E.private.actionbar.enable then
		if not self.petglowcolorsetup and E.db.ElvUI_EltreumUI.glow.colorclasspet ~= nil then
			if E.db.ElvUI_EltreumUI.glow.colorclasspet then
				skillglowcolorpet = {classcolor.r, classcolor.g, classcolor.b, 1}
			else
				skillglowcolorpet = {E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet.r, E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet.g, E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet.b, 1}
			end
			self.petglowcolorsetup = true
		end
		local procpet = {}
		for i = 1, NUM_PET_ACTION_SLOTS, 1 do
			local _, _, _, _, _, autoCastEnabled = GetPetActionInfo(i)
			local button = _G['PetActionButton'..i]
			if autoCastEnabled then
				AutoCastShine_AutoCastStop(button.AutoCastShine)
				button.AutoCastShine:Hide()
				if E.db.ElvUI_EltreumUI.glow.pixel then
					--PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
					LCG.PixelGlow_Start(button, skillglowcolorpet, 10, 0.25, 5, 2, 0, 0, false, nil, 6)
					if E.db.ElvUI_EltreumUI.glow.gradient then
						for k,v in pairs({button._PixelGlow:GetRegions()}) do
							local r,g,b = v:GetVertexColor()
							v:SetVertexColor(r-(k/20),g-(k/20),b-(k/20),1)
						end
					end
				elseif E.db.ElvUI_EltreumUI.glow.autocast then
					--AutoCastGlow_Start(frame[, color[, N[, frequency[, scale[, xOffset[, yOffset[, key]]]]]]])
					LCG.AutoCastGlow_Start(button, skillglowcolorpet, 16, 0.25, 0.7, 0, 0)
					if E.db.ElvUI_EltreumUI.glow.gradient then
						for k,v in pairs({button._AutoCastGlow:GetRegions()}) do
							local r,g,b = v:GetVertexColor()
							v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
						end
					end
				elseif E.db.ElvUI_EltreumUI.glow.blizzard then
					--ButtonGlow_Start(frame[, color[, frequency]]])
					LCG.ButtonGlow_Start(button, skillglowcolorpet, 0.125)
					button._ButtonGlow.outerGlow:SetScale(1.15)
					if E.db.ElvUI_EltreumUI.glow.gradient then
						if E.db.ElvUI_EltreumUI.glow.colorclass then
							button._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
						else
							button._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b + 0.2, a = 1})
						end
					end
				elseif E.db.ElvUI_EltreumUI.glow.procglow then
					procpet.color = skillglowcolorpet
					procpet.duration = E.db.ElvUI_EltreumUI.glow.proc.duration
					procpet.startAnim = E.db.ElvUI_EltreumUI.glow.proc.startAnimation
					procpet.frameLevel = E.db.ElvUI_EltreumUI.glow.proc.frameLevel
					procpet.xOffset = E.db.ElvUI_EltreumUI.glow.proc.xOffset
					procpet.yOffset = E.db.ElvUI_EltreumUI.glow.proc.yOffset
					LCG.ProcGlow_Start(button, procpet)
				end
			else
				AutoCastShine_AutoCastStop(button.AutoCastShine)
				if E.db.ElvUI_EltreumUI.glow.pixel then
					LCG.PixelGlow_Stop(button)
				elseif E.db.ElvUI_EltreumUI.glow.autocast then
					LCG.AutoCastGlow_Stop(button)
				elseif E.db.ElvUI_EltreumUI.glow.blizzard then
					LCG.ButtonGlow_Stop(button)
				elseif E.db.ElvUI_EltreumUI.glow.procglow then
					LCG.ProcGlow_Stop(button)
				end
			end
		end
	end
end
--elvui function can be spammy so use event instead
local petcdcheck = CreateFrame("FRAME")
petcdcheck:RegisterEvent("PET_BAR_UPDATE")
petcdcheck:RegisterEvent("PLAYER_STARTED_MOVING")
petcdcheck:RegisterEvent("FIRST_FRAME_RENDERED")
petcdcheck:RegisterEvent("PLAYER_LOGIN")
petcdcheck:RegisterUnitEvent("UNIT_PET","player")
petcdcheck:SetScript("OnEvent", function()
	petcdcheck:UnregisterEvent("PLAYER_STARTED_MOVING")
	ElvUI_EltreumUI:SkillGlowPet()
end)
--hooksecurefunc(AB, "UpdatePet", ElvUI_EltreumUI.SkillGlowPet)

--Preview the Glow as asked by Releaf
local EltruismGlowPreview = CreateFrame("Frame", "EltruismGlowPreview")
EltruismGlowPreview:SetSize(40, 40)
EltruismGlowPreview:ClearAllPoints()
EltruismGlowPreview:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 50)
EltruismGlowPreview:SetFrameStrata("DIALOG")
local EltruismGlowTexture = EltruismGlowPreview:CreateTexture()
EltruismGlowPreview:Hide()
function ElvUI_EltreumUI:PreviewGlow()
	if not E.private.ElvUI_EltreumUI then
		return
	end
	local procpreview = {}
	EltruismGlowTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\GlowPreview")
	EltruismGlowTexture:SetAllPoints(EltruismGlowPreview)
	EltruismGlowPreview:SetMovable(true)
	EltruismGlowPreview:EnableMouse(true)
	EltruismGlowPreview:RegisterForDrag("LeftButton")
	EltruismGlowPreview:SetScript("OnDragStart", EltruismGlowPreview.StartMoving)
	EltruismGlowPreview:SetScript("OnDragStop",EltruismGlowPreview.StopMovingOrSizing)

	local skillglowcolor = {E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b, 1}
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
	end

	if not EltruismGlowPreview.shadow then
		EltruismGlowPreview:CreateShadow()
		ElvUI_EltreumUI:ShadowColor(EltruismGlowPreview.shadow)
	end

	if EltruismGlowPreview:IsShown() then
		LCG.PixelGlow_Stop(EltruismGlowPreview)
		LCG.AutoCastGlow_Stop(EltruismGlowPreview)
		LCG.ButtonGlow_Stop(EltruismGlowPreview)
		if E.Retail then
			LCG.ProcGlow_Stop(EltruismGlowPreview)
		end
		EltruismGlowPreview:Hide()
	else
		EltruismGlowPreview:Show()
		if E.db.ElvUI_EltreumUI.glow.pixel then
			LCG.PixelGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, 6)
			if E.db.ElvUI_EltreumUI.glow.gradient then
				for k,v in pairs({EltruismGlowPreview._PixelGlow:GetRegions()}) do
					local r,g,b = v:GetVertexColor()
					v:SetVertexColor(r-(k/20),g-(k/20),b-(k/20),1)
				end
			end
		elseif E.db.ElvUI_EltreumUI.glow.autocast then
			LCG.AutoCastGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
			if E.db.ElvUI_EltreumUI.glow.gradient then
				for k,v in pairs({EltruismGlowPreview._AutoCastGlow:GetRegions()}) do
					local r,g,b = v:GetVertexColor()
					v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
				end
			end
		elseif E.db.ElvUI_EltreumUI.glow.blizzard then
			LCG.ButtonGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
			EltruismGlowPreview._ButtonGlow.outerGlow:SetScale(1.15)
			if E.db.ElvUI_EltreumUI.glow.gradient then
				if E.db.ElvUI_EltreumUI.glow.colorclass then
					EltruismGlowPreview._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
				else
					EltruismGlowPreview._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r - 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g - 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b - 0.2, a = 1}, {r = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r + 0.2, g = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g + 0.2, b = E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b + 0.2, a = 1})
				end
			end
		elseif E.db.ElvUI_EltreumUI.glow.procglow then
			procpreview.color = skillglowcolor
			procpreview.duration = E.db.ElvUI_EltreumUI.glow.proc.duration
			procpreview.startAnim = E.db.ElvUI_EltreumUI.glow.proc.startAnimation
			procpreview.frameLevel = E.db.ElvUI_EltreumUI.glow.proc.frameLevel
			procpreview.xOffset = E.db.ElvUI_EltreumUI.glow.proc.xOffset
			procpreview.yOffset = E.db.ElvUI_EltreumUI.glow.proc.yOffset
			LCG.ProcGlow_Start(EltruismGlowPreview, procpreview)
		end
	end
end

--hide keypress on actionbars
function ElvUI_EltreumUI:HideABKeyPress()
	if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
		if E.db.ElvUI_EltreumUI.skins.hideABkeypress then
			for i = 1, 10 do
				for k = 1, 12 do
					local slots = {_G["ElvUI_Bar"..i..'Button'..k]}
					for _, button in pairs(slots) do
						if E.db.ElvUI_EltreumUI.skins.hideABkeypress then
							if button.checked then
								button.checked:SetAlpha(0)
							end
							if button.pushed then
								button.pushed:ClearAllPoints()
							end
							if button.SpellHighlightTexture then
								button.SpellHighlightTexture:ClearAllPoints()
							end
						end
					end
				end
			end
		end
	end
end
