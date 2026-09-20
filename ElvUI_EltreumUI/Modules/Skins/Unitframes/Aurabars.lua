local E = unpack(ElvUI)
local _G = _G
local UF = E:GetModule('UnitFrames')
local hooksecurefunc = _G.hooksecurefunc
local CreateColor = _G.CreateColor
local strfind = _G.string.find
local UnitIsPlayer = _G.UnitIsPlayer
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local DebuffColors = (_G.DebuffTypeColor) or (E.Libs and E.Libs.Dispel and E.Libs.Dispel:GetDebuffTypeColor())
local function clamp(val)
	if val < 0 then
		return 0
	elseif val > 1 then
		return 1
	end
	return val
end
local aurabarMin = CreateColor(1, 1, 1, 1)
local aurabarMax = CreateColor(1, 1, 1, 1)

--Gradient Aurabars (not retail)
function ElvUI_EltreumUI:AuraBarGradient(unit, bar) --could use isStealable to add a glow or something
	if not unit and not bar then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and bar and unit then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
			if not bar.EltruismHook then
				hooksecurefunc(bar,"SetStatusBarColor", function(_,r,g,b)
					local barUnit = bar.unit or unit
					if barUnit and (barUnit == "player" or barUnit == "target") then
						local isTarget = barUnit == "target"
						local sparkKey = isTarget and "EltruismSparkTarget" or "EltruismSparkPlayer"
						if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars and not bar[sparkKey] then
							bar.spark:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
							local reverseFill = E.db.unitframe.units[barUnit] and E.db.unitframe.units[barUnit].aurabar and E.db.unitframe.units[barUnit].aurabar.reverseFill
							if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' and not reverseFill then
								bar.spark:SetTexCoord(1, 0, 0, 1)
							end
							bar.spark:SetBlendMode('BLEND')
							--bar.spark:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
							bar.spark:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
							bar[sparkKey] = true
						end
						local a = E.db.unitframe.colors.transparentAurabars and E.db.general.backdropfadecolor.a or 1
						if isTarget then
							aurabarMin:SetRGBA(clamp(r), clamp(g), clamp(b), a)
							aurabarMax:SetRGBA(clamp(r - 0.3), clamp(g - 0.3), clamp(b - 0.3), a)
						else
							aurabarMin:SetRGBA(clamp(r - 0.3), clamp(g - 0.3), clamp(b - 0.3), a)
							aurabarMax:SetRGBA(clamp(r), clamp(g), clamp(b), a)
						end
						bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, aurabarMin, aurabarMax)
					end
				end)
				bar.EltruismHook = true
			end
		end

		if E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then --thin mode aurabars?
			bar:SetHeight(5)
			bar.icon:SetSize(25,15)

			bar.icon:ClearAllPoints()
			bar.icon:SetPoint("BOTTOMRIGHT",bar,"BOTTOMLEFT",-7,0)

			bar.nameText:ClearAllPoints()
			bar.nameText:SetPoint('LEFT', bar, 'LEFT', 4, 4)
			if bar.Cooldown and bar.Cooldown.Text then
				bar.Cooldown.Text:ClearAllPoints()
				bar.Cooldown.Text:SetPoint('RIGHT', bar, 'RIGHT', -2, 4)
			end

			if ElvUI_EltreumUI:IsThisASafeSecret(bar,true) then
				bar.icon:SetTexCoord(0.08, 0.92, 0.2799995956419, 0.7200004043581)
			end
		end
	end
end

--Aurabar Texture same as Unitframe
function ElvUI_EltreumUI:AuraBarTexture(frame)
	if not frame then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
		if frame and frame.AuraBars and not frame.AuraBarHook then
			hooksecurefunc(frame.AuraBars, 'PostUpdateBar', function(_,_,bar)
				if bar then
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.aura and not bar.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
						bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(bar.shadow)
						if E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then
							if bar.shadow then
								bar.shadow:ClearAllPoints()
								bar.shadow:SetPoint("TOPRIGHT", bar.backdrop, "TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								bar.shadow:SetPoint("BOTTOMLEFT", bar.backdrop, "BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								if bar.backdrop and not bar.backdrop.shadow then
									bar.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									ElvUI_EltreumUI:ShadowColor(bar.backdrop.shadow)
									if ElvUI_EltreumUI:IsThisASafeSecret(bar,true) then
										if bar.icon and bar.icon.backdrop then
											bar.backdrop.shadow:ClearAllPoints()
											bar.backdrop.shadow:SetPoint("TOPRIGHT",bar.icon.backdrop, "TOPRIGHT",E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
											bar.backdrop.shadow:SetPoint("BOTTOMLEFT",bar.icon.backdrop, "BOTTOMLEFT",-E.db.ElvUI_EltreumUI.skins.shadow.length,-E.db.ElvUI_EltreumUI.skins.shadow.length)
										end
									end
								end
							end
						else
							if bar.shadow then
								bar.shadow:ClearAllPoints()
								bar.shadow:SetPoint("TOPLEFT", bar.icon, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length,E.db.ElvUI_EltreumUI.skins.shadow.length)
								bar.shadow:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
					end
					if E.db.ElvUI_EltreumUI.borders.universalborders then
						if bar.backdrop and bar.backdrop.eltruismuniversalborders then
							bar.backdrop.eltruismuniversalborders:SetFrameLevel(bar:GetFrameLevel()+1)
						end
					end
					if bar.bg then
						if E.db.unitframe.colors.transparentAurabars then
							--bar.bg:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
							if E.db.unitframe.colors.customaurabarbackdrop then
								bar.bg:SetVertexColor(E.db.unitframe.colors.aurabar_backdrop.r,E.db.unitframe.colors.aurabar_backdrop.g,E.db.unitframe.colors.aurabar_backdrop.b,E.db.general.backdropfadecolor.a)
								if bar.backdropTex then
									bar.backdropTex:SetVertexColor(E.db.unitframe.colors.aurabar_backdrop.r,E.db.unitframe.colors.aurabar_backdrop.g,E.db.unitframe.colors.aurabar_backdrop.b,E.db.general.backdropfadecolor.a)
								end
							else
								bar.bg:SetVertexColor(0,0,0,E.db.general.backdropfadecolor.a)
								if bar.backdropTex then
									bar.backdropTex:SetVertexColor(0,0,0,E.db.general.backdropfadecolor.a)
								end
							end
						end
						if bar.unit == "target" and E.db.unitframe.units.target.aurabar.reverseFill then
							bar.backdrop:SetBackdropColor(0,0,0,E.db.general.backdropfadecolor.a)
						elseif bar.unit == "player" and E.db.unitframe.units.player.aurabar.reverseFill then
							bar.backdrop:SetBackdropColor(0,0,0,E.db.general.backdropfadecolor.a)
						else
							bar.backdrop:SetBackdropColor(0,0,0,0)
						end
					end
				end
			end)
			frame.AuraBarHook = true
		end
	end
end
if not E.Retail then
	hooksecurefunc(UF, "Construct_PlayerFrame", ElvUI_EltreumUI.AuraBarTexture)
	hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.AuraBarTexture)
end

--Retail Aurabars
local function GetAuraBarColorRetail(unit, auraData, filter)
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

local function GetAuraBarBackdropColorRetail()
	local r, g, b, a
	if E.db.unitframe.colors.customaurabarbackdrop then
		local custom = E.db.unitframe.colors.aurabar_backdrop
		r = custom and custom.r or 0.2
		g = custom and custom.g or 0.2
		b = custom and custom.b or 0.2
		a = (E.db.unitframe.colors.transparentAurabars and E.db.general.backdropfadecolor.a) or (custom and custom.a) or 1
	else
		if E.db.unitframe.colors.transparentAurabars then
			r = 0
			g = 0
			b = 0
			a = E.db.general.backdropfadecolor.a or 0.8
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

local function ApplyAuraBarBackdropRetail(container, button)
	if not (button and button.statusbar) then return end
	local barTexture = button.statusbar:GetStatusBarTexture()
	if not barTexture or not ElvUI_EltreumUI:IsThisASafeSecret(barTexture, true) then return end

	local br, bg, bb, ba = GetAuraBarBackdropColorRetail()
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
end

local function ApplyAuraBarColorRetail(container, button, auraData)
	if not (button and button.border and button.statusbar) then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret(button.border, true) then return end

	local unit = (container and container.unit) or (button.container and button.container.unit) or "player"
	local r, g, b = GetAuraBarColorRetail(unit, auraData, button.filter)
	local a = (E.db.unitframe.colors.transparentAurabars and E.db.general.backdropfadecolor.a) or 1

	button.border.isSettingGradient = true
	button.border:SetTexture(container.statusbarTexture or E.media.normTex)

	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars then
		if unit == "target" then
			aurabarMin:SetRGBA(clamp(r), clamp(g), clamp(b), a)
			aurabarMax:SetRGBA(clamp(r - 0.3), clamp(g - 0.3), clamp(b - 0.3), a)
		else
			aurabarMin:SetRGBA(clamp(r - 0.3), clamp(g - 0.3), clamp(b - 0.3), a)
			aurabarMax:SetRGBA(clamp(r), clamp(g), clamp(b), a)
		end
		button.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, aurabarMin, aurabarMax)
	else
		button.border:SetVertexColor(r, g, b, a)
	end

	button.border:SetAlpha(a)
	button.border.isSettingGradient = false
	button.border:Show()
end

local function ApplyAuraBarSparkRetail(container, button)
	if not (button and button.spark) then return end
	if not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars then return end

	button.spark:Show()
	local reverseFill = container and container.reverseFill
	button.spark:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
	if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' and not reverseFill then
		button.spark:SetTexCoord(1, 0, 0, 1)
	else
		button.spark:SetTexCoord(0, 1, 0, 1)
	end
	button.spark:SetBlendMode('BLEND')
	button.spark:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
end

local function ApplyThinModeRetail(container, button)
	if not (button and button.statusbar) then return end
	if not E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then return end

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
	if E.db.ElvUI_EltreumUI.skins.shadow.enable and E.db.ElvUI_EltreumUI.skins.shadow.aura and not (E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.auraborder) and not (IsAddOnLoaded and IsAddOnLoaded("Masque")) and not E.db.ElvUI_EltreumUI.borders.universalborders and not E.db.ElvUI_EltreumUI.skins.shadow.universalshadows then
		if button.backdrop then
			if not button.iconShadow then
				button.iconShadow = button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length, true)
				ElvUI_EltreumUI:ShadowColor(button.iconShadow)
			end
			if button.iconShadow then
				local level = button:GetFrameLevel()
				button.iconShadow:SetFrameLevel(level > 1 and (level - 1) or 1)
				button.iconShadow:Show()
				button.iconShadow:ClearAllPoints()
				button.iconShadow:SetPoint("TOPLEFT", button.backdrop, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
				button.iconShadow:SetPoint("BOTTOMRIGHT", button.backdrop, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
			end
		end
		if button.shadow and button.statusbar then
			button.shadow:ClearAllPoints()
			button.shadow:SetPoint("TOPLEFT", button.statusbar, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
			button.shadow:SetPoint("BOTTOMRIGHT", button.statusbar, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
		end
	end
end

function ElvUI_EltreumUI:UpdateRetailAuraBar(container, button, auraData)
	if not (button and button.statusbar) then return end
	if auraData then
		button.eltruismAuraData = auraData
	else
		auraData = button.eltruismAuraData
	end

	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars then
			ApplyThinModeRetail(container, button)
		end

		if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars then
			ApplyAuraBarSparkRetail(container, button)
		end

		ApplyAuraBarBackdropRetail(container, button)
		ApplyAuraBarColorRetail(container, button, auraData)
	end
end

function ElvUI_EltreumUI:AuraBarRetail(container, button)
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
				ApplyAuraBarBackdropRetail(cont, btn)
				ApplyAuraBarColorRetail(cont, btn, btn.eltruismAuraData)
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
					ApplyAuraBarColorRetail(cont, btn, btn.eltruismAuraData)
				end
			end)
		end

		button.EltruismHooked = true
	end

	ElvUI_EltreumUI:UpdateRetailAuraBar(container, button, button.eltruismAuraData)
end

if not E.Retail then
	hooksecurefunc(UF, "PostUpdateBar_AuraBars", ElvUI_EltreumUI.AuraBarGradient)
else
	hooksecurefunc(E, 'Auras_UpdateButton', function(_, container, button)
		if container and container.isAuraBar and button and button.statusbar then
			ElvUI_EltreumUI:AuraBarRetail(container, button)
		end
	end)

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
