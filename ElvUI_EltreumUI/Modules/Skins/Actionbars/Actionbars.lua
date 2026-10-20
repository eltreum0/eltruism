local _G = _G
local unpack = _G.unpack
local E = unpack(ElvUI)
local AB = E:GetModule('ActionBars')
local LCG = _G.LibStub("LibEltreumCustomGlow")
local classcolor = E.myClassColor
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local IsUsableSpell = _G.C_Spell and _G.C_Spell.IsSpellUsable or _G.IsUsableSpell
local GetSpellCooldown = _G.C_Spell and _G.C_Spell.GetSpellCooldown or _G.GetSpellCooldown
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local UnitCreatureType = _G.UnitCreatureType
local InCombatLockdown = _G.InCombatLockdown
local GetPetActionInfo = _G.GetPetActionInfo
local CreateColor = _G.CreateColor
local glowMin = CreateColor(1, 1, 1, 1)
local glowMax = CreateColor(1, 1, 1, 1)

local function SetGlowGradient(texture, color)
	glowMin:SetRGBA(E:Clamp((color.r - 0.2), 0, 1), E:Clamp((color.g - 0.2), 0, 1), E:Clamp((color.b - 0.2), 0, 1), 1)
	glowMax:SetRGBA(E:Clamp((color.r + 0.2), 0, 1), E:Clamp((color.g + 0.2), 0, 1), E:Clamp((color.b + 0.2), 0, 1), 1)
	texture:SetGradient("HORIZONTAL", glowMin, glowMax)
end
--moving createframes out of the function for some reason breaks it

function ElvUI_EltreumUI:GetGlowGradientColors(baseColor)
	if not E.db.ElvUI_EltreumUI.glow.gradient then
		return nil
	end
	if E.db.ElvUI_EltreumUI.glow.gradientmode == "class" then
		local c
		if baseColor then
			c = { r = baseColor[1] or baseColor.r or 1, g = baseColor[2] or baseColor.g or 1, b = baseColor[3] or baseColor.b or 1 }
		else
			c = classcolor or E.myClassColor
		end
		return {
			{ E:Clamp(c.r - 0.2, 0, 1), E:Clamp(c.g - 0.2, 0, 1), E:Clamp(c.b - 0.2, 0, 1), 1 },
			{ c.r, c.g, c.b, 1 },
			{ E:Clamp(c.r + 0.2, 0, 1), E:Clamp(c.g + 0.2, 0, 1), E:Clamp(c.b + 0.2, 0, 1), 1 },
		}
	else
		local c1 = E.db.ElvUI_EltreumUI.glow.gradientcolor1 or { r = 1, g = 0.75, b = 0.75, a = 1 }
		local c2 = E.db.ElvUI_EltreumUI.glow.gradientcolor2 or { r = 0.75, g = 1, b = 0.75, a = 1 }
		local c3 = E.db.ElvUI_EltreumUI.glow.gradientcolor3 or { r = 0.75, g = 0.75, b = 1, a = 1 }
		return {
			{ c1.r, c1.g, c1.b, c1.a or 1 },
			{ c2.r, c2.g, c2.b, c2.a or 1 },
			{ c3.r, c3.g, c3.b, c3.a or 1 },
		}
	end
end

function ElvUI_EltreumUI:CustomGlowStart(button, skillglowcolor, frameLevel, xOffset, yOffset)
	if not button then return end

	local glowDb = E.db.ElvUI_EltreumUI.glow
	if not skillglowcolor then
		if glowDb.colorclass then
			skillglowcolor = { classcolor.r, classcolor.g, classcolor.b, 1 }
		else
			skillglowcolor = { glowDb.glowcustomcolor.r, glowDb.glowcustomcolor.g, glowDb.glowcustomcolor.b, 1 }
		end
	end

	local gradientTable = ElvUI_EltreumUI:GetGlowGradientColors(skillglowcolor)

	if glowDb.pixel then
		if button.AutoCastShine then button.AutoCastShine:Hide() end
		if button._ButtonGlow then button._ButtonGlow:Hide() end
		if button._ProcGlow then button._ProcGlow:Hide() end
		if button._BorderPulse then button._BorderPulse:Hide() end
		if button._Bling then button._Bling:Hide() end

		local pixelOpts = {
			color = skillglowcolor,
			N = glowDb.numberpixel,
			frequency = glowDb.frequencypixel,
			length = glowDb.lengthpixel,
			th = glowDb.thicknesspixel,
			xOffset = xOffset or glowDb.pixelxOffset,
			yOffset = yOffset or glowDb.pixelyOffset,
			border = glowDb.borderpixel,
			frameLevel = frameLevel or 6,
			gradient = gradientTable,
			gradientFrequency = glowDb.gradientfrequency,
			startBling = glowDb.pixelstartBling,
			repeatBling = glowDb.pixelrepeatBling,
			annoy = glowDb.pixelannoy,
			annoyFrequency = glowDb.pixelannoyFrequency,
			fadeDuration = glowDb.pixelfadeDuration,
			forceStop = glowDb.pixelforceStop,
		}
		LCG.PixelGlow_Start(button, pixelOpts)
		if glowDb.gradient and not gradientTable and button._PixelGlow then
			ElvUI_EltreumUI:ApplyGlowGradient(button._PixelGlow, skillglowcolor[1], skillglowcolor[2], skillglowcolor[3])
		end
	elseif glowDb.autocast then
		if button._PixelGlow then button._PixelGlow:Hide() end
		if button._ButtonGlow then button._ButtonGlow:Hide() end
		if button._ProcGlow then button._ProcGlow:Hide() end
		if button._BorderPulse then button._BorderPulse:Hide() end
		if button._Bling then button._Bling:Hide() end

		LCG.AutoCastGlow_Start(button, skillglowcolor, glowDb.numberauto, glowDb.frequencyauto, glowDb.autoscale, xOffset or glowDb.autoxOffset, yOffset or glowDb.autoyOffset, nil, frameLevel)
		if glowDb.gradient and button._AutoCastGlow then
			ElvUI_EltreumUI:ApplyGlowGradient(button._AutoCastGlow, skillglowcolor[1], skillglowcolor[2], skillglowcolor[3])
		end
	elseif glowDb.blizzard then
		if button._PixelGlow then button._PixelGlow:Hide() end
		if button.AutoCastShine then button.AutoCastShine:Hide() end
		if button._ProcGlow then button._ProcGlow:Hide() end
		if button._BorderPulse then button._BorderPulse:Hide() end
		if button._Bling then button._Bling:Hide() end

		LCG.ButtonGlow_Start(button, skillglowcolor, glowDb.frequencyblizz, frameLevel)
		if button._ButtonGlow and button._ButtonGlow.outerGlow then
			button._ButtonGlow.outerGlow:SetScale(1.15)
			if glowDb.gradient then
				if glowDb.colorclass then
					button._ButtonGlow.outerGlow:SetGradient("HORIZONTAL", ElvUI_EltreumUI:GradientColors(E.myclass))
				else
					SetGlowGradient(button._ButtonGlow.outerGlow, glowDb.glowcustomcolor)
				end
			end
		end
	elseif glowDb.procglow and E.Modern then
		if button._PixelGlow then button._PixelGlow:Hide() end
		if button.AutoCastShine then button.AutoCastShine:Hide() end
		if button._ButtonGlow then button._ButtonGlow:Hide() end
		if button._BorderPulse then button._BorderPulse:Hide() end
		if button._Bling then button._Bling:Hide() end

		local procOpts = {
			color = skillglowcolor,
			duration = glowDb.proc.duration,
			startAnim = glowDb.proc.startAnimation,
			frameLevel = frameLevel or glowDb.proc.frameLevel,
			xOffset = xOffset or glowDb.proc.xOffset,
			yOffset = yOffset or glowDb.proc.yOffset,
		}
		LCG.ProcGlow_Start(button, procOpts)
	elseif glowDb.borderpulseglow then
		if button._PixelGlow then button._PixelGlow:Hide() end
		if button.AutoCastShine then button.AutoCastShine:Hide() end
		if button._ButtonGlow then button._ButtonGlow:Hide() end
		if button._ProcGlow then button._ProcGlow:Hide() end
		if button._Bling then button._Bling:Hide() end

		local bp = glowDb.borderpulse
		local bpOpts = {
			color = skillglowcolor,
			N = bp.number,
			startPoint = bp.startPoint,
			th = bp.thickness,
			frequency = bp.frequency,
			sine = bp.sine,
			clockwise = bp.clockwise,
			mirror = bp.mirror,
			startBling = bp.startBling,
			repeatBling = bp.repeatBling,
			annoy = bp.annoy,
			annoyFrequency = bp.annoyFrequency,
			forceStop = bp.forceStop,
			frameLevel = frameLevel or bp.frameLevel,
			xOffset = xOffset or bp.xOffset,
			yOffset = yOffset or bp.yOffset,
			gradient = gradientTable,
			gradientFrequency = glowDb.gradientfrequency,
		}
		LCG.BorderPulse_Start(button, bpOpts)
	elseif glowDb.blingglow then
		if button._PixelGlow then button._PixelGlow:Hide() end
		if button.AutoCastShine then button.AutoCastShine:Hide() end
		if button._ButtonGlow then button._ButtonGlow:Hide() end
		if button._ProcGlow then button._ProcGlow:Hide() end
		if button._BorderPulse then button._BorderPulse:Hide() end

		local bl = glowDb.bling
		local blOpts = {
			flash = bl.flash,
			startPoint = bl.startPoint,
			color = skillglowcolor,
			duration = bl.duration,
			sine = bl.sine,
			reverse = bl.reverse,
			noTails = bl.noTails,
			frameLevel = frameLevel or bl.frameLevel,
			xOffset = xOffset or bl.xOffset,
			yOffset = yOffset or bl.yOffset,
			gradient = gradientTable,
			gradientFrequency = glowDb.gradientfrequency,
			tails = {
				th = bl.thickness,
				N = bl.tailN,
				color = skillglowcolor,
				startPoint = bl.tailStartPoint,
				clockwise = bl.tailClockwise,
				mirror = bl.tailMirror,
			}
		}
		LCG.Bling(button, blOpts)
	end
end

function ElvUI_EltreumUI:CustomGlowStop(button)
	if not button then return end
	local glowDb = E.db.ElvUI_EltreumUI.glow
	if LCG.PixelGlow_Stop then LCG.PixelGlow_Stop(button, nil, glowDb.pixelforceStop) end
	if LCG.AutoCastGlow_Stop then LCG.AutoCastGlow_Stop(button) end
	if LCG.ButtonGlow_Stop then LCG.ButtonGlow_Stop(button) end
	if LCG.ProcGlow_Stop then LCG.ProcGlow_Stop(button) end
	if LCG.BorderPulse_Stop then LCG.BorderPulse_Stop(button, nil, glowDb.borderpulse and glowDb.borderpulse.forceStop) end
	if button._Bling then
		button._Bling:Hide()
		button._Bling = nil
	end
end


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
			local ElvUI_LCG = E.Libs.CustomGlow or _G.LibStub("LibCustomGlow-1.0", true)
			if ElvUI_LCG and ElvUI_LCG.ShowOverlayGlow then
				hooksecurefunc(ElvUI_LCG, "ShowOverlayGlow", function(button)
					if button:GetAttribute("type") == "action" then
						ElvUI_EltreumUI:CustomGlowStart(button, skillglowcolor)
					end
				end)
				hooksecurefunc(ElvUI_LCG, "HideOverlayGlow", function(button)
					ElvUI_EltreumUI:CustomGlowStop(button)
				end)
			end
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

				local ONUPDATE_INTERVAL = 1
				local TimeSinceLastUpdate = 0
				local function EltruismTotemGlowOnUpdate(_, elapsed)
					TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
					if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
						TimeSinceLastUpdate = 0
						if E.db.ElvUI_EltreumUI.glow.totem1 then
							if not _G["ElvUF_PlayerTotem2"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStart(totemglow1, totem1glowcolor, 8)
							elseif _G["ElvUF_PlayerTotem2"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStop(totemglow1)
							end
						end
						if E.db.ElvUI_EltreumUI.glow.totem2 then
							if not _G["ElvUF_PlayerTotem1"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStart(totemglow2, totem2glowcolor, 8)
							elseif _G["ElvUF_PlayerTotem1"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStop(totemglow2)
							end
						end
						if E.db.ElvUI_EltreumUI.glow.totem3 then
							if not _G["ElvUF_PlayerTotem3"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStart(totemglow3, totem3glowcolor, 8)
							elseif _G["ElvUF_PlayerTotem3"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStop(totemglow3)
							end
						end
						if E.db.ElvUI_EltreumUI.glow.totem4 then
							if not _G["ElvUF_PlayerTotem4"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStart(totemglow4, totem4glowcolor, 8)
							elseif _G["ElvUF_PlayerTotem4"]:IsShown() then
								ElvUI_EltreumUI:CustomGlowStop(totemglow4)
							end
						end
					end
				end

				totemglowcombatdetect:SetScript("OnEvent", function(_, event)
					if event == 'PLAYER_REGEN_DISABLED' then
						totemglowholder:SetScript("OnUpdate", EltruismTotemGlowOnUpdate)
					elseif event == 'PLAYER_REGEN_ENABLED' then
						totemglowholder:SetScript("OnUpdate", nil)
						ElvUI_EltreumUI:CustomGlowStop(totemglow1)
						ElvUI_EltreumUI:CustomGlowStop(totemglow2)
						ElvUI_EltreumUI:CustomGlowStop(totemglow3)
						ElvUI_EltreumUI:CustomGlowStop(totemglow4)
					end
				end)
			end

			if E.Classic or E.TBC or E.Wrath then --cata has glows
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
							for i=1, _G.NUM_ACTIONBAR_BUTTONS do
								local button = bar.buttons[i]
								local buttonname = button:GetName()
								local proc = _G[buttonname].abilityID
								--[[if _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() then
									proc = _G[buttonname]:GetSpellId()
								end]]
								if SPELL_ID[proc] then
									local USABLE, NO_MANA = IsUsableSpell(proc)
									local cooldowntable = GetSpellCooldown(proc)
									local cd = cooldowntable.duration
									--if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) and _G[buttonname].GetSpellId and _G[buttonname]:GetSpellId() == proc then
									if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) then
										if E.myclass == 'PALADIN' then
											if exorcism[proc] then
												local unittype = UnitCreatureType("target")
												if unittype == _G.PET_TYPE_DEMON or unittype == _G.BATTLE_PET_DAMAGE_NAME_4 then
													ElvUI_EltreumUI:CustomGlowStart(_G[buttonname], skillglowcolor, 6)
												else
													ElvUI_EltreumUI:CustomGlowStop(_G[buttonname])
												end
											else
												ElvUI_EltreumUI:CustomGlowStart(_G[buttonname], skillglowcolor, 6)
											end
										else
											ElvUI_EltreumUI:CustomGlowStart(_G[buttonname], skillglowcolor, 6)
										end
									else
										ElvUI_EltreumUI:CustomGlowStop(_G[buttonname])
									end
								else
									ElvUI_EltreumUI:CustomGlowStop(_G[buttonname])
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

		for i = 1, _G.NUM_PET_ACTION_SLOTS, 1 do
			local _, _, _, _, _, autoCastEnabled = GetPetActionInfo(i)
			local button = _G['PetActionButton'..i]

			if button.AutoCastOverlay then
				button.AutoCastOverlay:Hide()
				button.AutoCastOverlay:SetAlpha(0)
			elseif button.AutoCastShine then
				button.AutoCastShine:Hide()
			end
			if autoCastEnabled then --11.0 replaces this
				--AutoCastShine_AutoCastStop(button.AutoCastShine)
				if not button.EltruismIsGlowing then
					button.EltruismIsGlowing = true
					ElvUI_EltreumUI:CustomGlowStart(button, skillglowcolorpet, 6)
				end
			else
				--AutoCastShine_AutoCastStop(button.AutoCastShine)
				if button.EltruismIsGlowing then
					button.EltruismIsGlowing = false
					ElvUI_EltreumUI:CustomGlowStop(button)
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
EltruismGlowPreview:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 50)
EltruismGlowPreview:SetFrameStrata("DIALOG")
local EltruismGlowTexture = EltruismGlowPreview:CreateTexture()
EltruismGlowPreview:Hide()
function ElvUI_EltreumUI:PreviewGlow()
	if not E.private.ElvUI_EltreumUI then
		return
	end
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
		ElvUI_EltreumUI:CustomGlowStop(EltruismGlowPreview)
		EltruismGlowPreview:Hide()
	else
		EltruismGlowPreview:Show()
		ElvUI_EltreumUI:CustomGlowStart(EltruismGlowPreview, skillglowcolor)
	end
end

--hide keypress on actionbars
function ElvUI_EltreumUI:HideABKeyPress()
	if E.private.actionbar.enable and not IsAddOnLoaded("ElvUI_ActionBarMasks") then
		if E.db.ElvUI_EltreumUI.skins.hideABkeypress then
			for i = 1, 10 do
				for k = 1, 12 do
					local button = _G["ElvUI_Bar"..i..'Button'..k]
					if button then
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
