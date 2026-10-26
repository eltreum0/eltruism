local _G = _G
local unpack = _G.unpack
local E = unpack(ElvUI)
local AB = E:GetModule('ActionBars')
local LCG = _G.LibStub("LibEltreumGlow")
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

local defaultSkillGlowColor = { 1, 1, 1, 1 }
local customGradientTable = {
	{ 1, 0.75, 0.75, 1, h = 0, s = 0, v = 1 },
	{ 0.75, 1, 0.75, 1, h = 0, s = 0, v = 1 },
	{ 0.75, 0.75, 1, 1, h = 0, s = 0, v = 1 },
}
local fallbackClassGradientTable = {
	{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
	{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
	{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
}
local pixelOpts = {}
local procOpts = {}
local bpOpts = {}
local blOpts = { tails = {} }
local petActionButtons = {}

local function SetGradientEntry(entry, r, g, b, a)
	if entry[1] ~= r or entry[2] ~= g or entry[3] ~= b then
		entry[1], entry[2], entry[3] = r, g, b
		entry.h = nil
	end
	entry[4] = a
end

local function SetGlowGradient(texture, color)
	glowMin:SetRGBA(E:Clamp((color.r - 0.2), 0, 1), E:Clamp((color.g - 0.2), 0, 1), E:Clamp((color.b - 0.2), 0, 1), 1)
	glowMax:SetRGBA(E:Clamp((color.r + 0.2), 0, 1), E:Clamp((color.g + 0.2), 0, 1), E:Clamp((color.b + 0.2), 0, 1), 1)
	texture:SetGradient("HORIZONTAL", glowMin, glowMax)
end
--moving createframes out of the function for some reason breaks it

function ElvUI_EltreumUI:GetGlowGradientColors(baseColor, button)
	local glowDb = E.db.ElvUI_EltreumUI.glow
	if not glowDb.gradient then
		return nil
	end
	if glowDb.gradientmode == "class" then
		local r, g, b
		if baseColor then
			r = baseColor[1] or baseColor.r or 1
			g = baseColor[2] or baseColor.g or 1
			b = baseColor[3] or baseColor.b or 1
		else
			local c = classcolor or E.myClassColor
			r, g, b = c.r, c.g, c.b
		end
		local grad
		if button then
			grad = button._EltruismGrad
			if not grad then
				grad = {
					{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
					{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
					{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
				}
				button._EltruismGrad = grad
			end
		else
			grad = fallbackClassGradientTable
		end
		if grad._r ~= r or grad._g ~= g or grad._b ~= b then
			grad._r, grad._g, grad._b = r, g, b
			SetGradientEntry(grad[1], E:Clamp(r - 0.2, 0, 1), E:Clamp(g - 0.2, 0, 1), E:Clamp(b - 0.2, 0, 1), 1)
			SetGradientEntry(grad[2], r, g, b, 1)
			SetGradientEntry(grad[3], E:Clamp(r + 0.2, 0, 1), E:Clamp(g + 0.2, 0, 1), E:Clamp(b + 0.2, 0, 1), 1)
		end
		return grad
	else
		local c1 = glowDb.gradientcolor1
		local c2 = glowDb.gradientcolor2
		local c3 = glowDb.gradientcolor3
		SetGradientEntry(customGradientTable[1], c1 and c1.r or 1, c1 and c1.g or 0.75, c1 and c1.b or 0.75, c1 and c1.a or 1)
		SetGradientEntry(customGradientTable[2], c2 and c2.r or 0.75, c2 and c2.g or 1, c2 and c2.b or 0.75, c2 and c2.a or 1)
		SetGradientEntry(customGradientTable[3], c3 and c3.r or 0.75, c3 and c3.g or 0.75, c3 and c3.b or 1, c3 and c3.a or 1)
		return customGradientTable
	end
end

local function StopOtherGlows(button, keepType, keepBling)
	if button.AutoCastShine then button.AutoCastShine:Hide() end
	if keepType ~= "pixel" and button._PixelGlow then
		LCG.PixelGlow_Stop(button, nil, true)
	end
	if keepType ~= "autocast" and button._AutoCastGlow then
		LCG.AutoCastGlow_Stop(button)
	end
	if keepType ~= "blizzard" and button._ButtonGlow then
		LCG.ButtonGlow_Stop(button, true)
	end
	if keepType ~= "proc" and button._ProcGlow then
		LCG.ProcGlow_Stop(button)
	end
	if keepType ~= "borderpulse" and button._BorderPulse then
		LCG.BorderPulse_Stop(button, nil, true)
	end
	if not keepBling and button._Bling then
		if LCG.Bling_Stop then
			LCG.Bling_Stop(button)
		else
			button._Bling:Hide()
			button._Bling = nil
		end
	end
end

function ElvUI_EltreumUI:CustomGlowStart(button, skillglowcolor, frameLevel, xOffset, yOffset)
	if not button then return end

	local glowDb = E.db.ElvUI_EltreumUI.glow
	if not skillglowcolor then
		if glowDb.colorclass then
			defaultSkillGlowColor[1], defaultSkillGlowColor[2], defaultSkillGlowColor[3], defaultSkillGlowColor[4] = classcolor.r, classcolor.g, classcolor.b, 1
		else
			local custom = glowDb.glowcustomcolor
			defaultSkillGlowColor[1], defaultSkillGlowColor[2], defaultSkillGlowColor[3], defaultSkillGlowColor[4] = custom.r, custom.g, custom.b, 1
		end
		skillglowcolor = defaultSkillGlowColor
	end

	button._EltruismGlowing = true
	if button.__LBGoverlay then button.__LBGoverlay:Hide() end
	if button.overlay then button.overlay:Hide() end
	if button.SpellActivationAlert then button.SpellActivationAlert:Hide() end

	if glowDb.pixel then
		StopOtherGlows(button, "pixel", glowDb.pixelstartBling or glowDb.pixelrepeatBling or glowDb.pixelannoy)

		local gradientTable = ElvUI_EltreumUI:GetGlowGradientColors(skillglowcolor, button)

		pixelOpts.key = nil
		pixelOpts.template = nil
		pixelOpts.blingOptions = nil
		pixelOpts.color = skillglowcolor
		pixelOpts.N = glowDb.numberpixel
		pixelOpts.frequency = glowDb.frequencypixel
		pixelOpts.length = glowDb.lengthpixel
		pixelOpts.th = glowDb.thicknesspixel
		pixelOpts.xOffset = xOffset or glowDb.pixelxOffset
		pixelOpts.yOffset = yOffset or glowDb.pixelyOffset
		pixelOpts.border = glowDb.borderpixel
		pixelOpts.frameLevel = frameLevel or 6
		pixelOpts.gradient = gradientTable
		pixelOpts.gradientFrequency = glowDb.gradientfrequency
		pixelOpts.startBling = glowDb.pixelstartBling
		pixelOpts.repeatBling = glowDb.pixelrepeatBling
		pixelOpts.annoy = glowDb.pixelannoy
		pixelOpts.annoyFrequency = glowDb.pixelannoyFrequency
		pixelOpts.fadeDuration = glowDb.pixelfadeDuration
		pixelOpts.forceStop = glowDb.pixelforceStop

		LCG.PixelGlow_Start(button, pixelOpts)
		if glowDb.gradient and not gradientTable and button._PixelGlow then
			ElvUI_EltreumUI:ApplyGlowGradient(button._PixelGlow, skillglowcolor[1], skillglowcolor[2], skillglowcolor[3])
		end
	elseif glowDb.autocast then
		StopOtherGlows(button, "autocast", false)

		LCG.AutoCastGlow_Start(button, skillglowcolor, glowDb.numberauto, glowDb.frequencyauto, glowDb.autoscale, xOffset or glowDb.autoxOffset, yOffset or glowDb.autoyOffset, nil, frameLevel)
		if glowDb.gradient and button._AutoCastGlow then
			ElvUI_EltreumUI:ApplyGlowGradient(button._AutoCastGlow, skillglowcolor[1], skillglowcolor[2], skillglowcolor[3])
		end
	elseif glowDb.blizzard then
		StopOtherGlows(button, "blizzard", false)

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
		StopOtherGlows(button, "proc", false)

		local proc = glowDb.proc
		procOpts.key = nil
		procOpts.color = skillglowcolor
		procOpts.duration = proc.duration
		procOpts.startAnim = proc.startAnim
		procOpts.frameLevel = frameLevel or proc.frameLevel
		procOpts.xOffset = xOffset or proc.xOffset
		procOpts.yOffset = yOffset or proc.yOffset

		LCG.ProcGlow_Start(button, procOpts)
	elseif glowDb.borderpulseglow then
		local bp = glowDb.borderpulse
		StopOtherGlows(button, "borderpulse", bp.startBling or bp.repeatBling or bp.annoy)

		local gradientTable = ElvUI_EltreumUI:GetGlowGradientColors(skillglowcolor, button)

		bpOpts.key = nil
		bpOpts.template = nil
		bpOpts.blingOptions = nil
		bpOpts.color = skillglowcolor
		bpOpts.N = bp.number
		bpOpts.startPoint = bp.startPoint
		bpOpts.th = bp.thickness
		bpOpts.frequency = bp.frequency
		bpOpts.sine = bp.sine
		bpOpts.clockwise = bp.clockwise
		bpOpts.mirror = bp.mirror
		bpOpts.startBling = bp.startBling
		bpOpts.repeatBling = bp.repeatBling
		bpOpts.annoy = bp.annoy
		bpOpts.annoyFrequency = bp.annoyFrequency
		bpOpts.forceStop = bp.forceStop
		bpOpts.frameLevel = frameLevel or bp.frameLevel
		bpOpts.xOffset = xOffset or bp.xOffset
		bpOpts.yOffset = yOffset or bp.yOffset
		bpOpts.gradient = gradientTable
		bpOpts.gradientFrequency = glowDb.gradientfrequency

		LCG.BorderPulse_Start(button, bpOpts)
	elseif glowDb.blingglow then
		StopOtherGlows(button, "bling", true)

		local gradientTable = ElvUI_EltreumUI:GetGlowGradientColors(skillglowcolor, button)

		local bl = glowDb.bling
		blOpts.key = nil
		blOpts.template = nil
		blOpts.flash = bl.flash
		blOpts.startPoint = bl.startPoint
		blOpts.color = skillglowcolor
		blOpts.duration = bl.duration
		blOpts.sine = bl.sine
		blOpts.reverse = bl.reverse
		blOpts.noTails = bl.noTails
		blOpts.frameLevel = frameLevel or bl.frameLevel
		blOpts.xOffset = xOffset or bl.xOffset
		blOpts.yOffset = yOffset or bl.yOffset
		blOpts.gradient = gradientTable
		blOpts.gradientFrequency = glowDb.gradientfrequency

		local tails = blOpts.tails
		tails.th = bl.thickness
		tails.N = bl.tailN
		tails.color = skillglowcolor
		tails.startPoint = bl.tailStartPoint
		tails.clockwise = bl.tailClockwise
		tails.mirror = bl.tailMirror

		LCG.Bling(button, blOpts)
	end
end

function ElvUI_EltreumUI:CustomGlowStop(button)
	if not button then return end
	button._EltruismGlowing = nil
	local glowDb = E.db.ElvUI_EltreumUI.glow
	if button._PixelGlow then LCG.PixelGlow_Stop(button, nil, glowDb.pixelforceStop) end
	if button._AutoCastGlow or button.AutoCastShine then LCG.AutoCastGlow_Stop(button) end
	if button._ButtonGlow then LCG.ButtonGlow_Stop(button) end
	if button._ProcGlow then LCG.ProcGlow_Stop(button) end
	if button._BorderPulse then LCG.BorderPulse_Stop(button, nil, glowDb.borderpulse and glowDb.borderpulse.forceStop) end
	if button._Bling then
		if LCG.Bling_Stop then
			LCG.Bling_Stop(button)
		else
			button._Bling:Hide()
			button._Bling = nil
		end
	end
end

local function IsButtonGlowing(btn)
	if not btn then return false end
	if btn._EltruismGlowing then return true end
	if btn._PixelGlow and btn._PixelGlow:IsShown() then return true end
	if btn._BorderPulse and btn._BorderPulse:IsShown() then return true end
	if btn._Bling and btn._Bling:IsShown() then return true end
	if btn._AutoCastGlow and btn._AutoCastGlow:IsShown() then return true end
	if btn.AutoCastShine and btn.AutoCastShine:IsShown() then return true end
	if btn._ButtonGlow and btn._ButtonGlow:IsShown() then return true end
	if btn._ProcGlow and btn._ProcGlow:IsShown() then return true end
	if btn.__LBGoverlay and btn.__LBGoverlay:IsShown() then return true end
	if btn.overlay and btn.overlay:IsShown() then return true end
	if btn.SpellActivationAlert and btn.SpellActivationAlert:IsShown() then return true end
	if btn.EltruismIsGlowing then return true end
	return false
end

--Skill Glow Pet
local skillglowcolorpet = {classcolor.r, classcolor.g, classcolor.b, 1}
local function UpdatePetGlowColor()
	local glowDb = E.db.ElvUI_EltreumUI.glow
	if glowDb.colorclasspet then
		skillglowcolorpet[1], skillglowcolorpet[2], skillglowcolorpet[3], skillglowcolorpet[4] = classcolor.r, classcolor.g, classcolor.b, 1
	else
		local c = glowDb.glowcustomcolorpet
		skillglowcolorpet[1], skillglowcolorpet[2], skillglowcolorpet[3], skillglowcolorpet[4] = c.r, c.g, c.b, 1
	end
	return skillglowcolorpet
end

function ElvUI_EltreumUI:UpdateActiveGlows()
	if LCG and LCG.SyncGlowDefaults then
		LCG.SyncGlowDefaults()
	end

	if _G.EltruismGlowPreview and _G.EltruismGlowPreview:IsShown() then
		ElvUI_EltreumUI:CustomGlowStart(_G.EltruismGlowPreview)
	end

	-- ElvUI ActionBars (Bars 1 to 10, Buttons 1 to 12)
	for i = 1, 10 do
		for k = 1, 12 do
			local btn = _G["ElvUI_Bar"..i..'Button'..k]
			if IsButtonGlowing(btn) then
				ElvUI_EltreumUI:CustomGlowStart(btn)
			end
		end
	end

	-- LibActionButton active buttons
	local LAB = E.Libs.LAB or (_G.LibStub and (_G.LibStub("LibActionButton-1.0-ElvUI", true) or _G.LibStub("LibActionButton-1.0", true)))
	if LAB and LAB.activeButtons then
		for btn in next, LAB.activeButtons do
			if IsButtonGlowing(btn) then
				ElvUI_EltreumUI:CustomGlowStart(btn)
			end
		end
	end

	-- Pet Action Buttons
	local petcolor
	for k = 1, 10 do
		local btn = _G["PetActionButton"..k] or _G["ElvUI_PetBarButton"..k]
		if IsButtonGlowing(btn) then
			if not petcolor then
				petcolor = UpdatePetGlowColor()
			end
			ElvUI_EltreumUI:CustomGlowStart(btn, petcolor, 6)
		end
	end

	-- Stance Bar Buttons
	for k = 1, 10 do
		local btn = _G["ElvUI_StanceBarButton"..k]
		if IsButtonGlowing(btn) then
			ElvUI_EltreumUI:CustomGlowStart(btn)
		end
	end

	-- Standard ActionButtons (fallback)
	for k = 1, 12 do
		local btn = _G["ActionButton"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBarBottomLeftButton"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBarBottomRightButton"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBarRightButton"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBarLeftButton"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBar5Button"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBar6Button"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
		btn = _G["MultiBar7Button"..k]
		if btn and IsButtonGlowing(btn) then ElvUI_EltreumUI:CustomGlowStart(btn) end
	end
end

-- Skill Glow
function ElvUI_EltreumUI:SkillGlow()
	if not E.private.ElvUI_EltreumUI then
		return
	end

	if E.db.ElvUI_EltreumUI.glow.enable and E.private.actionbar.enable then
		if LCG and LCG.SyncGlowDefaults then
			LCG.SyncGlowDefaults()
		end

		if not IsAddOnLoaded("ElvUI_ActionBarMasks") then
			local function OnGlowStart(button)
				if not button or button == _G.EltruismGlowPreview then return end
				ElvUI_EltreumUI:CustomGlowStart(button)
			end

			local function OnGlowStop(button)
				if not button or button == _G.EltruismGlowPreview then return end
				ElvUI_EltreumUI:CustomGlowStop(button)
			end

			local hookedLibraries = {}
			local function HookLCG(targetLCG)
				if not targetLCG or hookedLibraries[targetLCG] or targetLCG == LCG then return end
				hookedLibraries[targetLCG] = true

				if LCG and LCG.ProtectLCG then
					LCG.ProtectLCG(targetLCG)
				end

				if targetLCG.PixelGlow_Start and LCG.PixelGlow_Start then
					targetLCG.PixelGlow_Start = LCG.PixelGlow_Start
				end
				if targetLCG.PixelGlow_Stop and LCG.PixelGlow_Stop then
					targetLCG.PixelGlow_Stop = LCG.PixelGlow_Stop
				end
				if targetLCG.ButtonGlow_Start and LCG.ButtonGlow_Start then
					targetLCG.ButtonGlow_Start = LCG.ButtonGlow_Start
				end
				if targetLCG.ButtonGlow_Stop and LCG.ButtonGlow_Stop then
					targetLCG.ButtonGlow_Stop = LCG.ButtonGlow_Stop
				end
				if targetLCG.AutoCastGlow_Start and LCG.AutoCastGlow_Start then
					targetLCG.AutoCastGlow_Start = LCG.AutoCastGlow_Start
				end
				if targetLCG.AutoCastGlow_Stop and LCG.AutoCastGlow_Stop then
					targetLCG.AutoCastGlow_Stop = LCG.AutoCastGlow_Stop
				end
				if targetLCG.ProcGlow_Start and LCG.ProcGlow_Start then
					targetLCG.ProcGlow_Start = LCG.ProcGlow_Start
				end
				if targetLCG.ProcGlow_Stop and LCG.ProcGlow_Stop then
					targetLCG.ProcGlow_Stop = LCG.ProcGlow_Stop
				end

				if targetLCG.startList then
					if LCG.PixelGlow_Start then targetLCG.startList["Pixel Glow"] = LCG.PixelGlow_Start end
					if LCG.AutoCastGlow_Start then targetLCG.startList["Autocast Shine"] = LCG.AutoCastGlow_Start end
					if LCG.ButtonGlow_Start then targetLCG.startList["Action Button Glow"] = LCG.ButtonGlow_Start end
					if LCG.ProcGlow_Start then targetLCG.startList["Proc Glow"] = LCG.ProcGlow_Start end
				end
				if targetLCG.stopList then
					if LCG.PixelGlow_Stop then targetLCG.stopList["Pixel Glow"] = LCG.PixelGlow_Stop end
					if LCG.AutoCastGlow_Stop then targetLCG.stopList["Autocast Shine"] = LCG.AutoCastGlow_Stop end
					if LCG.ButtonGlow_Stop then targetLCG.stopList["Action Button Glow"] = LCG.ButtonGlow_Stop end
					if LCG.ProcGlow_Stop then targetLCG.stopList["Proc Glow"] = LCG.ProcGlow_Stop end
				end

				if targetLCG.ShowOverlayGlow then
					hooksecurefunc(targetLCG, "ShowOverlayGlow", OnGlowStart)
				end
				if targetLCG.HideOverlayGlow then
					hooksecurefunc(targetLCG, "HideOverlayGlow", OnGlowStop)
				end
			end

			local LBG = _G.LibStub and _G.LibStub("LibButtonGlow-1.0", true)
			if LBG then
				if LBG.ShowOverlayGlow then
					hooksecurefunc(LBG, "ShowOverlayGlow", OnGlowStart)
				end
				if LBG.HideOverlayGlow then
					hooksecurefunc(LBG, "HideOverlayGlow", OnGlowStop)
				end
			end

			local ElvUI_LCG = E.Libs.CustomGlow or (_G.LibStub and _G.LibStub("LibCustomGlow-1.0", true))
			if ElvUI_LCG then
				HookLCG(ElvUI_LCG)
			end
			local stubLCG = _G.LibStub and _G.LibStub("LibCustomGlow-1.0", true)
			if stubLCG and stubLCG ~= ElvUI_LCG then
				HookLCG(stubLCG)
			end
			if hooksecurefunc and _G.LibStub and _G.LibStub.NewLibrary then
				hooksecurefunc(_G.LibStub, "NewLibrary", function(_, major)
					if major == "LibCustomGlow-1.0" then
						local libInst = _G.LibStub("LibCustomGlow-1.0", true)
						if libInst then
							HookLCG(libInst)
						end
					end
				end)
			end

			if _G.ActionButton_ShowOverlayGlow then
				hooksecurefunc("ActionButton_ShowOverlayGlow", OnGlowStart)
			end
			if _G.ActionButton_HideOverlayGlow then
				hooksecurefunc("ActionButton_HideOverlayGlow", OnGlowStop)
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
								if not totemglow1._EltruismGlowing then
									ElvUI_EltreumUI:CustomGlowStart(totemglow1, totem1glowcolor, 8)
								end
							elseif totemglow1._EltruismGlowing then
								ElvUI_EltreumUI:CustomGlowStop(totemglow1)
							end
						end
						if E.db.ElvUI_EltreumUI.glow.totem2 then
							if not _G["ElvUF_PlayerTotem1"]:IsShown() then
								if not totemglow2._EltruismGlowing then
									ElvUI_EltreumUI:CustomGlowStart(totemglow2, totem2glowcolor, 8)
								end
							elseif totemglow2._EltruismGlowing then
								ElvUI_EltreumUI:CustomGlowStop(totemglow2)
							end
						end
						if E.db.ElvUI_EltreumUI.glow.totem3 then
							if not _G["ElvUF_PlayerTotem3"]:IsShown() then
								if not totemglow3._EltruismGlowing then
									ElvUI_EltreumUI:CustomGlowStart(totemglow3, totem3glowcolor, 8)
								end
							elseif totemglow3._EltruismGlowing then
								ElvUI_EltreumUI:CustomGlowStop(totemglow3)
							end
						end
						if E.db.ElvUI_EltreumUI.glow.totem4 then
							if not _G["ElvUF_PlayerTotem4"]:IsShown() then
								if not totemglow4._EltruismGlowing then
									ElvUI_EltreumUI:CustomGlowStart(totemglow4, totem4glowcolor, 8)
								end
							elseif totemglow4._EltruismGlowing then
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
								local btn = button
								local proc = btn.abilityID
								--[[if btn.GetSpellId and btn:GetSpellId() then
									proc = btn:GetSpellId()
								end]]
								if SPELL_ID[proc] then
									local USABLE, NO_MANA = IsUsableSpell(proc)
									local cooldowntable = GetSpellCooldown(proc)
									local cd = cooldowntable.duration
									--if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) and btn.GetSpellId and btn:GetSpellId() == proc then
									if (UnitExists("target") and UnitCanAttack("player", "target") and cd == 0 and USABLE and not NO_MANA) then
										if E.myclass == 'PALADIN' then
											if exorcism[proc] then
												local unittype = UnitCreatureType("target")
												if unittype == _G.PET_TYPE_DEMON or unittype == _G.BATTLE_PET_DAMAGE_NAME_4 then
													if not btn._EltruismGlowing then
														ElvUI_EltreumUI:CustomGlowStart(btn, nil, 6)
													end
												elseif btn._EltruismGlowing then
													ElvUI_EltreumUI:CustomGlowStop(btn)
												end
											elseif not btn._EltruismGlowing then
												ElvUI_EltreumUI:CustomGlowStart(btn, nil, 6)
											end
										elseif not btn._EltruismGlowing then
											ElvUI_EltreumUI:CustomGlowStart(btn, nil, 6)
										end
									elseif btn._EltruismGlowing then
										ElvUI_EltreumUI:CustomGlowStop(btn)
									end
								elseif btn._EltruismGlowing then
									ElvUI_EltreumUI:CustomGlowStop(btn)
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

function ElvUI_EltreumUI:SkillGlowPet()
	if IsAddOnLoaded("ElvUI_ActionBarMasks") then return end
	if not UnitExists("pet") then return end
	if not IsAddOnLoaded("ElvUI_EltreumUI") then return end
	if not E.private.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI.glow then return end
	if E.db.ElvUI_EltreumUI.glow.enablepet and E.private.actionbar.enable then
		if not self.petglowcolorsetup and E.db.ElvUI_EltreumUI.glow.colorclasspet ~= nil then
			UpdatePetGlowColor()
			self.petglowcolorsetup = true
		end

		for i = 1, _G.NUM_PET_ACTION_SLOTS, 1 do
			local _, _, _, _, _, autoCastEnabled = GetPetActionInfo(i)
			local button = petActionButtons[i]
			if not button then
				button = _G['PetActionButton'..i]
				petActionButtons[i] = button
			end

			if button then
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

	if not EltruismGlowPreview.shadow then
		EltruismGlowPreview:CreateShadow()
		ElvUI_EltreumUI:ShadowColor(EltruismGlowPreview.shadow)
	end

	if EltruismGlowPreview:IsShown() then
		ElvUI_EltreumUI:CustomGlowStop(EltruismGlowPreview)
		EltruismGlowPreview:Hide()
	else
		EltruismGlowPreview:Show()
		ElvUI_EltreumUI:CustomGlowStart(EltruismGlowPreview)
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
