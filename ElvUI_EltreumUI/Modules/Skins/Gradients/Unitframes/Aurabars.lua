local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateColor = _G.CreateColor
local strfind = _G.string.find
local UnitIsPlayer = _G.UnitIsPlayer
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local DebuffColors = (_G.DebuffTypeColor) or (E.Libs and E.Libs.Dispel and E.Libs.Dispel:GetDebuffTypeColor())
local type = _G.type
local aurabarMin = CreateColor(1, 1, 1, 1)
local aurabarMax = CreateColor(1, 1, 1, 1)

--Gradient Aurabars (not retail)
function ElvUI_EltreumUI:AuraBarGradient(_, unit, bar) --could use isStealable to add a glow or something
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not E.private.unitframe.enable then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end
	if not (unit and bar and type(bar) == "table") then return end

	local db = E.db.ElvUI_EltreumUI.unitframes
	local gm = db.gradientmode

	if gm.enableaurabars and not bar.EltruismHook then
		hooksecurefunc(bar, "SetStatusBarColor", function(_, r, g, b)
			local barUnit = bar.__unit or bar.unit or unit
			if barUnit and (barUnit == "player" or barUnit == "target") then
				local isTarget = barUnit == "target"
				local a = E.db.unitframe.colors.transparentAurabars and E.db.general.backdropfadecolor.a or 1
				if isTarget then
					aurabarMin:SetRGBA(E:Clamp(r, 0, 1), E:Clamp(g, 0, 1), E:Clamp(b, 0, 1), a)
					aurabarMax:SetRGBA(E:Clamp(r - 0.5, 0, 1), E:Clamp(g - 0.5, 0, 1), E:Clamp(b - 0.5, 0, 1), a)
				else
					aurabarMin:SetRGBA(E:Clamp(r - 0.5, 0, 1), E:Clamp(g - 0.5, 0, 1), E:Clamp(b - 0.5, 0, 1), a)
					aurabarMax:SetRGBA(E:Clamp(r, 0, 1), E:Clamp(g, 0, 1), E:Clamp(b, 0, 1), a)
				end
				local tex = bar:GetStatusBarTexture()
				if tex then
					tex:SetGradient(gm.orientation or "HORIZONTAL", aurabarMin, aurabarMax)
				end
			end
		end)
		bar.EltruismHook = true
	end

	local isTarget = unit == "target"
	local sparkKey = isTarget and "EltruismSparkTarget" or "EltruismSparkPlayer"
	if db.sparkcustomcolor.enableaurabars and not bar[sparkKey] then
		bar.spark:SetTexture(E.LSM:Fetch("statusbar", db.sparkcustomcolor.texture))
		local reverseFill = E.db.unitframe.units[unit] and E.db.unitframe.units[unit].aurabar and E.db.unitframe.units[unit].aurabar.reverseFill
		if db.sparkcustomcolor.texture == 'Eltreum-Fade' and not reverseFill then
			bar.spark:SetTexCoord(1, 0, 0, 1)
		end
		bar.spark:SetBlendMode('BLEND')
		--bar.spark:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
		bar.spark:SetWidth(db.sparkcustomcolor.width)
		bar[sparkKey] = true
	end

	if db.thinmodeaurabars then --thin mode aurabars?
		bar:SetHeight(5)
		bar.icon:SetSize(25, 15)
		bar.icon:ClearAllPoints()
		bar.icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", -7, 0)
		bar.nameText:ClearAllPoints()
		bar.nameText:SetPoint('LEFT', bar, 'LEFT', 4, 4)
		if bar.Cooldown and bar.Cooldown.Text then
			bar.Cooldown.Text:ClearAllPoints()
			bar.Cooldown.Text:SetPoint('RIGHT', bar, 'RIGHT', -2, 4)
		end
		if ElvUI_EltreumUI:IsThisASafeSecret(bar, true) then
			bar.icon:SetTexCoord(0.08, 0.92, 0.2799995956419, 0.7200004043581)
		end
	end
end

--Aurabar Texture same as Unitframe
function ElvUI_EltreumUI:AuraBarTexture(frame)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not E.private.unitframe.enable then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end
	if not (frame and frame.AuraBars) then return end

	local db = E.db.ElvUI_EltreumUI.unitframes
	local gm = db.gradientmode
	if not gm.enableaurabars then return end
	if frame.AuraBarHook then return end

	hooksecurefunc(frame.AuraBars, 'PostUpdateBar', function(_, _, bar)
		if not bar then return end
		local eltruismDB = E.db.ElvUI_EltreumUI
		local shadowDB = eltruismDB.skins.shadow
		local borderDB = eltruismDB.borders
		local unitColors = E.db.unitframe.colors

		bar:SetStatusBarTexture(E.LSM:Fetch('statusbar', UF.db.statusbar))
		local fadeAlpha = E.db.general.backdropfadecolor.a

		if shadowDB.enable and shadowDB.aura and not bar.shadow and not borderDB.universalborders then
			bar:CreateShadow(shadowDB.length)
			ElvUI_EltreumUI:ShadowColor(bar.shadow)
			if db.thinmodeaurabars then
				if bar.shadow then
					bar.shadow:ClearAllPoints()
					bar.shadow:SetPoint("TOPRIGHT", bar.backdrop, "TOPRIGHT", shadowDB.length, shadowDB.length)
					bar.shadow:SetPoint("BOTTOMLEFT", bar.backdrop, "BOTTOMLEFT", -shadowDB.length, -shadowDB.length)
					if bar.backdrop and not bar.backdrop.shadow then
						bar.backdrop:CreateShadow(shadowDB.length)
						ElvUI_EltreumUI:ShadowColor(bar.backdrop.shadow)
						if ElvUI_EltreumUI:IsThisASafeSecret(bar, true) and bar.icon and bar.icon.backdrop then
							bar.backdrop.shadow:ClearAllPoints()
							bar.backdrop.shadow:SetPoint("TOPRIGHT", bar.icon.backdrop, "TOPRIGHT", shadowDB.length, shadowDB.length)
							bar.backdrop.shadow:SetPoint("BOTTOMLEFT", bar.icon.backdrop, "BOTTOMLEFT", -shadowDB.length, -shadowDB.length)
						end
					end
				end
			elseif bar.shadow then
				bar.shadow:ClearAllPoints()
				bar.shadow:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -shadowDB.length, shadowDB.length)
				bar.shadow:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", shadowDB.length, -shadowDB.length)
			end
		end

		if borderDB.universalborders and bar.backdrop and bar.backdrop.eltruismuniversalborders then
			bar.backdrop.eltruismuniversalborders:SetFrameLevel(bar:GetFrameLevel() + 1)
		end

		if bar.bg then
			if unitColors.transparentAurabars then
				--bar.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
				if unitColors.customaurabarbackdrop then
					bar.bg:SetVertexColor(unitColors.aurabar_backdrop.r, unitColors.aurabar_backdrop.g, unitColors.aurabar_backdrop.b, fadeAlpha)
					if bar.backdropTex then
						bar.backdropTex:SetVertexColor(unitColors.aurabar_backdrop.r, unitColors.aurabar_backdrop.g, unitColors.aurabar_backdrop.b, fadeAlpha)
					end
				else
					bar.bg:SetVertexColor(0, 0, 0, fadeAlpha)
					if bar.backdropTex then
						bar.backdropTex:SetVertexColor(0, 0, 0, fadeAlpha)
					end
				end
			end
			local isReverse = (bar.unit == "target" and E.db.unitframe.units.target.aurabar.reverseFill) or (bar.unit == "player" and E.db.unitframe.units.player.aurabar.reverseFill)
			bar.backdrop:SetBackdropColor(0, 0, 0, isReverse and fadeAlpha or 0)
		end
	end)
	frame.AuraBarHook = true
end

--Retail Aurabars
function ElvUI_EltreumUI:GetAuraBarColorRetail(unit, auraData, filter)
	local colors = E.db.unitframe.colors
	local isHarmful = auraData and E:NotSecretValue(auraData.isHarmful) and auraData.isHarmful
	local isDebuff = isHarmful or (filter and strfind(filter, "HARMFUL"))

	if isDebuff then
		local dispelName = auraData and E:NotSecretValue(auraData.dispelName) and auraData.dispelName
		if colors and colors.auraBarByType and dispelName and DebuffColors and DebuffColors[dispelName] then
			local dc = DebuffColors[dispelName]
			return dc.r, dc.g, dc.b
		end
		if colors and colors.auraBarDebuff then
			return colors.auraBarDebuff.r, colors.auraBarDebuff.g, colors.auraBarDebuff.b
		end
		return 0.8, 0, 0
	else
		if auraData and E:NotSecretValue(auraData.spellId) and auraData.spellId then
			local auraColor = E.global and E.global.unitframe and E.global.unitframe.AuraBarColors and E.global.unitframe.AuraBarColors[auraData.spellId]
			if auraColor and auraColor.enable and auraColor.color then
				return auraColor.color.r, auraColor.color.g, auraColor.color.b
			end
		end
		if colors and colors.auraBarBuff and (colors.auraBarBuff.r ~= 0.31 or colors.auraBarBuff.g ~= 0.31 or colors.auraBarBuff.b ~= 0.31) then
			return colors.auraBarBuff.r, colors.auraBarBuff.g, colors.auraBarBuff.b
		end
		if unit == "player" or unit == "pet" then
			local classColor = E:ClassColor(E.myclass, true)
			if classColor then
				return classColor.r, classColor.g, classColor.b
			end
		elseif unit == "target" or unit == "focus" then
			if UnitIsPlayer(unit) then
				local _, unitClass = UnitClass(unit)
				local classColor = unitClass and E:ClassColor(unitClass, true)
				if classColor then
					return classColor.r, classColor.g, classColor.b
				end
			else
				local reaction = UnitReaction(unit, "player")
				local rc = reaction and ElvUI[1].oUF and ElvUI[1].oUF.colors and ElvUI[1].oUF.colors.reaction and ElvUI[1].oUF.colors.reaction[reaction]
				if rc then
					return rc[1], rc[2], rc[3]
				end
			end
		end
		if colors and colors.auraBarBuff then
			return colors.auraBarBuff.r, colors.auraBarBuff.g, colors.auraBarBuff.b
		end
		return 0.2, 0.6, 1
	end
end

function ElvUI_EltreumUI:GetAuraBarBackdropColorRetail()
	local r, g, b, a
	local colors = E.db.unitframe.colors
	local fadeAlpha = E.db.general.backdropfadecolor.a

	if colors.customaurabarbackdrop then
		local custom = colors.aurabar_backdrop
		r = custom and custom.r or 0.2
		g = custom and custom.g or 0.2
		b = custom and custom.b or 0.2
		a = (colors.transparentAurabars and fadeAlpha) or (custom and custom.a) or 1
	else
		if colors.transparentAurabars then
			r = 0
			g = 0
			b = 0
			a = fadeAlpha or 0.8
		else
			local bg = E.db.general.backdropcolor or E.media.backdropcolor
			r = bg and bg.r or 0.1
			g = bg and bg.g or 0.1
			b = bg and bg.b or 0.1
			a = 1
		end
	end
	return r, g, b, a
end

function ElvUI_EltreumUI:ApplyAuraBarBackdropRetail(container, button)
	if not (button and button.statusbar) then return end
	local barTexture = button.statusbar:GetStatusBarTexture()
	if not barTexture or not ElvUI_EltreumUI:IsThisASafeSecret(barTexture, true) then return end

	local br, bg, bb, ba = ElvUI_EltreumUI:GetAuraBarBackdropColorRetail()
	local bgTexture = (container and container.statusbarTexture) or E.LSM:Fetch('statusbar', UF.db.statusbar) or E.media.normTex
	barTexture:SetTexture(bgTexture)

	button.statusbar.isSettingBackdrop = true
	button.statusbar:SetStatusBarColor(br, bg, bb, ba)
	barTexture:SetVertexColor(br, bg, bb, ba)
	barTexture:SetAlpha(ba)
	button.statusbar.isSettingBackdrop = false

	if button.statusbar.backdrop and button.statusbar.backdrop.Center then
		button.statusbar.backdrop.Center:Hide()
	end
	if button.backdrop and button.backdrop.Center then
		button.backdrop.Center:SetVertexColor(0, 0, 0, ba)
	end
end

function ElvUI_EltreumUI:ApplyAuraBarColorRetail(container, button, auraData)
	if not (button and button.border and button.statusbar) then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret(button.border, true) then return end

	local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	local unit = (container and container.unit) or (button.container and button.container.unit) or "player"
	local r, g, b = ElvUI_EltreumUI:GetAuraBarColorRetail(unit, auraData, button.filter)
	local a = (E.db.unitframe.colors.transparentAurabars and E.db.general.backdropfadecolor.a) or 1

	button.border.isSettingGradient = true
	button.border:SetTexture(container.statusbarTexture or E.media.normTex)

	if gm.enableaurabars then
		local orientation = gm.orientation or "HORIZONTAL"
		if unit == "target" then
			aurabarMin:SetRGBA(E:Clamp(r, 0, 1), E:Clamp(g, 0, 1), E:Clamp(b, 0, 1), a)
			aurabarMax:SetRGBA(E:Clamp(r - 0.3, 0, 1), E:Clamp(g - 0.3, 0, 1), E:Clamp(b - 0.3, 0, 1), a)
		else
			aurabarMin:SetRGBA(E:Clamp(r - 0.3, 0, 1), E:Clamp(g - 0.3, 0, 1), E:Clamp(b - 0.3, 0, 1), a)
			aurabarMax:SetRGBA(E:Clamp(r, 0, 1), E:Clamp(g, 0, 1), E:Clamp(b, 0, 1), a)
		end
		button.border:SetGradient(orientation, aurabarMin, aurabarMax)
	else
		button.border:SetVertexColor(r, g, b, a)
	end

	button.border:SetAlpha(a)
	button.border.isSettingGradient = false
	button.border:Show()
end

function ElvUI_EltreumUI:ApplyAuraBarSparkRetail(container, button)
	local sparkDB = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
	if not sparkDB.enableaurabars then return end

	local spark = button.spark or (button.statusbar and button.statusbar.spark)
	if not spark then return end

	spark:Show()
	local reverseFill = container and container.reverseFill
	spark:SetTexture(E.LSM:Fetch("statusbar", sparkDB.texture))
	if sparkDB.texture == 'Eltreum-Fade' and not reverseFill then
		spark:SetTexCoord(1, 0, 0, 1)
	else
		spark:SetTexCoord(0, 1, 0, 1)
	end
	spark:SetBlendMode('BLEND')
	spark:SetWidth(sparkDB.width)
	spark:SetDrawLayer("OVERLAY", 7)
end

function ElvUI_EltreumUI:ApplyThinModeRetail(container, button)
	if not (button and button.statusbar) then return end
	local eltruismDB = E.db.ElvUI_EltreumUI
	local db = eltruismDB.unitframes
	if not db.thinmodeaurabars then return end

	local reverseFill = container and container.reverseFill

	button.statusbar:ClearAllPoints()
	button.statusbar:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 0, 0)
	button.statusbar:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
	button.statusbar:SetHeight(5)

	if button.border then
		button.border:ClearAllPoints()
		button.border:SetPoint("TOP", button.statusbar, "TOP")
		button.border:SetPoint("BOTTOM", button.statusbar, "BOTTOM")
		local barTexture = button.statusbar:GetStatusBarTexture()
		if barTexture then
			if not reverseFill then
				button.border:SetPoint("LEFT", button.statusbar, "LEFT")
				button.border:SetPoint("RIGHT", barTexture, "LEFT")
			else
				button.border:SetPoint("RIGHT", button.statusbar, "RIGHT")
				button.border:SetPoint("LEFT", barTexture, "RIGHT")
			end
		else
			button.border:SetAllPoints(button.statusbar)
		end
	end

	--icon backdrop
	if button.backdrop then
		button.backdrop:ClearAllPoints()
		if not reverseFill then
			button.backdrop:SetPoint("BOTTOMRIGHT", button.statusbar, "BOTTOMLEFT", -7, 0)
		else
			button.backdrop:SetPoint("BOTTOMLEFT", button.statusbar, "BOTTOMRIGHT", 7, 0)
		end
		button.backdrop:SetSize(25, 15)
	end

	if button.dispelBorder and button.backdrop then
		button.dispelBorder:ClearAllPoints()
		button.dispelBorder:SetAllPoints(button.backdrop)
	end

	--icon texture
	if button.texture and ElvUI_EltreumUI:IsThisASafeSecret(button.texture, true) then
		button.texture:ClearAllPoints()
		button.texture:SetInside(button.backdrop)
		button.texture:SetTexCoord(0.08, 0.92, 0.2799995956419, 0.7200004043581)
	end

	--spell name text
	if button.textFrame and button.textFrame.nameText then
		button.textFrame.nameText:ClearAllPoints()
		if not reverseFill then
			button.textFrame.nameText:SetPoint("BOTTOMLEFT", button.statusbar, "TOPLEFT", 4, 2)
		else
			button.textFrame.nameText:SetPoint("BOTTOMRIGHT", button.statusbar, "TOPRIGHT", -4, 2)
		end
	end

	--cooldown/time text
	if button.textFrame and button.textFrame.time then
		button.textFrame.time:ClearAllPoints()
		if not reverseFill then
			button.textFrame.time:SetPoint("BOTTOMRIGHT", button.statusbar, "TOPRIGHT", -2, 2)
		else
			button.textFrame.time:SetPoint("BOTTOMLEFT", button.statusbar, "TOPLEFT", 2, 2)
		end
	end
	local cdText = button.cooldown and (button.cooldown.Text or (button.cooldown.timer and button.cooldown.timer.text))
	if cdText then
		cdText:ClearAllPoints()
		if not reverseFill then
			cdText:SetPoint("BOTTOMRIGHT", button.statusbar, "TOPRIGHT", -2, 2)
		else
			cdText:SetPoint("BOTTOMLEFT", button.statusbar, "TOPLEFT", 2, 2)
		end
	end

	--shadows
	local shadowDB = eltruismDB.skins.shadow
	local borderDB = eltruismDB.borders
	if shadowDB.enable and shadowDB.aura and not (borderDB.borders and borderDB.auraborder) and not (IsAddOnLoaded and IsAddOnLoaded("Masque")) and not borderDB.universalborders and not shadowDB.universalshadows then
		if button.backdrop then
			if not button.iconShadow then
				button.iconShadow = button:CreateShadow(shadowDB.length, true)
				ElvUI_EltreumUI:ShadowColor(button.iconShadow)
			end
			if button.iconShadow then
				local level = button:GetFrameLevel()
				button.iconShadow:SetFrameLevel(level > 1 and (level - 1) or 1)
				button.iconShadow:Show()
				button.iconShadow:ClearAllPoints()
				button.iconShadow:SetPoint("TOPLEFT", button.backdrop, "TOPLEFT", -shadowDB.length, shadowDB.length)
				button.iconShadow:SetPoint("BOTTOMRIGHT", button.backdrop, "BOTTOMRIGHT", shadowDB.length, -shadowDB.length)
			end
		end
		if button.shadow and button.statusbar then
			button.shadow:ClearAllPoints()
			button.shadow:SetPoint("TOPLEFT", button.statusbar, "TOPLEFT", -shadowDB.length, shadowDB.length)
			button.shadow:SetPoint("BOTTOMRIGHT", button.statusbar, "BOTTOMRIGHT", shadowDB.length, -shadowDB.length)
		end
	end
end

function ElvUI_EltreumUI:UpdateRetailAuraBar(container, button, auraData)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not E.private.unitframe.enable then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end
	if not (button and button.statusbar) then return end

	local db = E.db.ElvUI_EltreumUI.unitframes
	if not (db and db.gradientmode and db.gradientmode.enableaurabars) then return end

	if auraData then
		button.eltruismAuraData = auraData
	else
		auraData = button.eltruismAuraData
	end

	if db.thinmodeaurabars then
		ElvUI_EltreumUI:ApplyThinModeRetail(container, button)
	end
	if db.sparkcustomcolor.enableaurabars then
		ElvUI_EltreumUI:ApplyAuraBarSparkRetail(container, button)
	end
	ElvUI_EltreumUI:ApplyAuraBarBackdropRetail(container, button)
	ElvUI_EltreumUI:ApplyAuraBarColorRetail(container, button, auraData)
end

function ElvUI_EltreumUI:AuraBarRetail(container, button)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not E.private.unitframe.enable then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end

	if not button and container and container.statusbar then
		button = container
		container = button.container or button:GetParent()
	end
	if not (container and button and button.statusbar) then return end

	if not button.EltruismHooked then
		hooksecurefunc(button.statusbar, "SetStatusBarColor", function(bar)
			if bar.isSettingBackdrop then return end
			local btn = bar:GetParent()
			local cont = btn and (btn.container or btn:GetParent())
			if cont and cont.isAuraBar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
				ElvUI_EltreumUI:ApplyAuraBarBackdropRetail(cont, btn)
				ElvUI_EltreumUI:ApplyAuraBarColorRetail(cont, btn, btn.eltruismAuraData)
			end
		end)

		if button.texture then
			hooksecurefunc(button.texture, "SetTexture", function(tex)
				local btn = tex:GetParent()
				if not btn then return end
				local cont = btn.container or btn:GetParent()
				if cont and cont.isAuraBar then
					if E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars and ElvUI_EltreumUI:IsThisASafeSecret(tex, true) then
						tex:SetTexCoord(0.08, 0.92, 0.2799995956419, 0.7200004043581)
					end
					ElvUI_EltreumUI:UpdateRetailAuraBar(cont, btn)
				end
			end)
		end

		if button.textFrame and button.textFrame.nameText then
			hooksecurefunc(button.textFrame.nameText, "SetText", function(fs)
				local tf = fs:GetParent()
				local btn = tf and tf:GetParent()
				if not btn then return end
				local cont = btn.container or btn:GetParent()
				if cont and cont.isAuraBar then
					ElvUI_EltreumUI:UpdateRetailAuraBar(cont, btn)
				end
			end)
		end

		if button.border then
			hooksecurefunc(button.border, "SetVertexColor", function(border)
				if border.isSettingGradient then return end
				local btn = border:GetParent()
				if not btn then return end
				local cont = btn.container or btn:GetParent()
				if cont and cont.isAuraBar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
					ElvUI_EltreumUI:ApplyAuraBarColorRetail(cont, btn, btn.eltruismAuraData)
				end
			end)
		end

		button.EltruismHooked = true
	end

	ElvUI_EltreumUI:UpdateRetailAuraBar(container, button, button.eltruismAuraData)
end

if not E.Modern then
	ElvUI_EltreumUI:SecureHook(UF, "PostUpdateBar_AuraBars", "AuraBarGradient")
else
	local function HookAuraContainerUtil() --use blizzard's util, but it might work for other things
		if _G.AuraContainerUtil and not ElvUI_EltreumUI.AuraContainerUtilHooked then
			if _G.AuraContainerUtil.SetSpellNameForAura then
				hooksecurefunc(_G.AuraContainerUtil, "SetSpellNameForAura", function(auraButton, _, auraData)
					if auraButton and auraButton.statusbar then
						local container = auraButton.container or auraButton:GetParent()
						if container and container.isAuraBar then
							ElvUI_EltreumUI:UpdateRetailAuraBar(container, auraButton, auraData)
						end
					end
				end)
			end
			if _G.AuraContainerUtil.SetIconTextureForAura then
				hooksecurefunc(_G.AuraContainerUtil, "SetIconTextureForAura", function(auraButton, texture)
					if auraButton and auraButton.statusbar and E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then
						local container = auraButton.container or auraButton:GetParent()
						if container and container.isAuraBar and texture and ElvUI_EltreumUI:IsThisASafeSecret(texture, true) then
							texture:SetTexCoord(0.08, 0.92, 0.2799995956419, 0.7200004043581)
						end
					end
				end)
			end
			ElvUI_EltreumUI.AuraContainerUtilHooked = true
		end
	end
	HookAuraContainerUtil()

	local retailAuraEventFrame = _G.CreateFrame("Frame")
	retailAuraEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	retailAuraEventFrame:SetScript("OnEvent", function(self, event)
		HookAuraContainerUtil()
		self:UnregisterEvent(event)
	end)
end
