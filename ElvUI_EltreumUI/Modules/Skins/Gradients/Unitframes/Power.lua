local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitPowerType = _G.UnitPowerType
local UnitExists = _G.UnitExists
local select = _G.select
local type = _G.type
local IsInGroup = _G.IsInGroup
local UnitInParty = _G.UnitInParty
local UnitInRaid = _G.UnitInRaid
local ipairs = _G.ipairs
local CreateColor = _G.CreateColor
local function clamp(val)
	if val < 0 then
		return 0
	elseif val > 1 then
		return 1
	end
	return val
end
local fallbackMin = CreateColor(1, 1, 1, 1)
local fallbackMax = CreateColor(1, 1, 1, 1)

local powerTypeNumToToken = {
	[0] = "MANA",
	[1] = "RAGE",
	[2] = "FOCUS",
	[3] = "ENERGY",
	[6] = "RUNIC_POWER",
	[8] = "LUNAR_POWER",
	[10] = "ALT_POWER",
	[11] = "MAELSTROM",
	[13] = "INSANITY",
	[17] = "FURY",
	[18] = "PAIN",
}

--powers there are gradients for since retail has like 100+ power types
local powertypes ={
	["MANA"] = true,
	["RAGE"] = true,
	["FOCUS"] = true,
	["ENERGY"] = true,
	["RUNIC_POWER"] = true,
	["LUNAR_POWER"] = true,
	["ALT_POWER"] = true,
	["MAELSTROM"] = true,
	["INSANITY"] = true,
	["FURY"] = true,
	["PAIN"] = true,
}

local function GetGradient(pType, inv, isTransparent, isBG, isCustom)
	if isCustom then
		--function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha, isBG, customalpha, isHealth)
		return ElvUI_EltreumUI:GradientColorsCustom(pType, inv, isTransparent, isBG)
	else
		return ElvUI_EltreumUI:GradientColors(pType, inv, isTransparent, isBG)
	end
end

--Apply Gradient Power Colors to Unit
function ElvUI_EltreumUI:ApplyUnitGradientPower(unit, name)
	if not unit then return end
	if E:NotSecretUnit(unit) and UnitExists(unit) then --can error now in 12.0.7?
	--if ElvUI_EltreumUI:IsThisASafeSecret(unit,true) and UnitExists(unit) then
		--print(powertype,unit)
		local pTypeNum, powertype = UnitPowerType(unit)
		if not powertype and pTypeNum then
			powertype = powerTypeNumToToken[pTypeNum]
		end

		local unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Power and powertype then
			local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture
			local orientation = gm.orientationpower or "HORIZONTAL"
			local alpha = ufCustom.backdropalpha or 1
			local transparent = E.db.unitframe.colors.transparentPower
			local isCustom = gm.enablepowercustom
			local isTarget = (unit == "target")
			local invert = isTarget and (orientation == "HORIZONTAL")

			--texture
			local textureToUse
			if ufCustom.enable then
				textureToUse = E.LSM:Fetch("statusbar", ufCustom.powertexture)
			elseif gm.useUFtexture then
				textureToUse = E.LSM:Fetch("statusbar", E.db.unitframe.statusbar)
			else
				textureToUse = E.LSM:Fetch("statusbar", gm.texture)
			end
			unitframe.Power:SetStatusBarTexture(textureToUse)
			if unitframe.Power.bg then
				unitframe.Power.bg:SetTexture(textureToUse)
				unitframe.Power.bg:SetVertexColor(E.db.unitframe.colors.power_backdrop.r,E.db.unitframe.colors.power_backdrop.g,E.db.unitframe.colors.power_backdrop.b,E.db.general.backdropfadecolor.a)
			end

			if transparent and E.db.unitframe.colors.custompowerbackdrop then --fix transparent power custom backdrop
				if unitframe.Power.backdrop and unitframe.Power.backdrop.Center then
					unitframe.Power.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
					unitframe.Power.backdrop.Center:SetVertexColor(E.db.unitframe.colors.power_backdrop.r, E.db.unitframe.colors.power_backdrop.g, E.db.unitframe.colors.power_backdrop.b, E.db.general.backdropfadecolor.a)
					local bgA = unitframe.Power.backdrop.Center:GetAlpha()
					if ElvUI_EltreumUI:IsThisASafeSecret(bgA, true) and bgA ~= alpha then
						unitframe.Power.backdrop.Center:SetAlpha(alpha)
					end
				end
			end

			--gradients
			if powertypes[powertype] then
				local minC, maxC = GetGradient(powertype, invert, transparent, false, isCustom)
				local tex = unitframe.Power:GetStatusBarTexture()
				if tex and minC and maxC then
					tex:SetVertexColor(1, 1, 1, E.db.general.backdropfadecolor.a)
					tex:SetGradient(orientation, minC, maxC)
				end
				if not E.db.unitframe.colors.custompowerbackdrop and gm.enablebackdrop and unitframe.Power.bg then
					local bgMin, bgMax = GetGradient(powertype, invert, false, true, isCustom)
					if bgMin and bgMax then
						unitframe.Power.bg:SetGradient(orientation, bgMin, bgMax)
					end
				end
			else
				local r, g, b = unitframe.Power:GetStatusBarColor()
				if r and ElvUI_EltreumUI:IsThisASafeSecret(r, true) then  --check for it not being a secret
					if r ~= 1 and g ~= 1 and b ~= 1 then
						if invert then
							fallbackMin:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
							fallbackMax:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
						else
							fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
							fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
						end

						local tex = unitframe.Power:GetStatusBarTexture()
						if tex then
							tex:SetGradient(orientation, fallbackMin, fallbackMax)
						end

						if transparent and gm.enablebackdrop and unitframe.Power.backdrop and unitframe.Power.backdrop.Center then
							unitframe.Power.backdrop.Center:SetGradient(orientation, fallbackMin, fallbackMax)
						end

						if not E.db.unitframe.colors.custompowerbackdrop and gm.enablebackdrop and unitframe.Power.bg then
							local bgfade = gm.bgfade or 0
							if invert then
								fallbackMin:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
								fallbackMax:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
							else
								fallbackMin:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
								fallbackMax:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
							end
							unitframe.Power.bg:SetGradient(orientation, fallbackMin, fallbackMax)
						end
					end
				end
			end
		end
	end
end

--Apply Gradient Power Colors to Group Unit
function ElvUI_EltreumUI:ApplyGroupGradientPower(groupunitframe)
	if not groupunitframe then return end
	local unit = groupunitframe.__unit or groupunitframe.unit
	if not unit then return end
	if not (E:NotSecretUnit(unit) and (UnitExists(unit) or groupunitframe.isForced)) then return end

	local pTypeNum, powertype = UnitPowerType(unit)
	if not powertype and pTypeNum then
		powertype = powerTypeNumToToken[pTypeNum]
	end

	if groupunitframe.Power and powertype then
		local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
		local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture
		local orientation = gm.orientationpower or "HORIZONTAL"
		local alpha = ufCustom.backdropalpha or 1
		local transparent = E.db.unitframe.colors.transparentPower
		local isCustom = gm.enablepowercustom

		--texture
		local textureToUse
		if ufCustom.enable then
			textureToUse = E.LSM:Fetch("statusbar", ufCustom.powertexture)
		elseif gm.useUFtexture then
			textureToUse = E.LSM:Fetch("statusbar", E.db.unitframe.statusbar)
		else
			textureToUse = E.LSM:Fetch("statusbar", gm.texture)
		end
		groupunitframe.Power:SetStatusBarTexture(textureToUse)
		if groupunitframe.Power.bg then
			groupunitframe.Power.bg:SetTexture(textureToUse)
			groupunitframe.Power.bg:SetVertexColor(E.db.unitframe.colors.power_backdrop.r, E.db.unitframe.colors.power_backdrop.g, E.db.unitframe.colors.power_backdrop.b, E.db.general.backdropfadecolor.a)
		end

		if transparent and E.db.unitframe.colors.custompowerbackdrop then --fix transparent power custom backdrop
			if groupunitframe.Power.backdrop and groupunitframe.Power.backdrop.Center then
				groupunitframe.Power.backdrop.Center:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
				groupunitframe.Power.backdrop.Center:SetVertexColor(E.db.unitframe.colors.power_backdrop.r, E.db.unitframe.colors.power_backdrop.g, E.db.unitframe.colors.power_backdrop.b, E.db.general.backdropfadecolor.a)
				local bgA = groupunitframe.Power.backdrop.Center:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(bgA, true) and bgA ~= alpha then
					groupunitframe.Power.backdrop.Center:SetAlpha(alpha)
				end
			end
		end

		--gradients
		if powertypes[powertype] then
			local minC, maxC = GetGradient(powertype, false, transparent, false, isCustom)
			local tex = groupunitframe.Power:GetStatusBarTexture()
			if tex and minC and maxC then
				tex:SetVertexColor(1, 1, 1, E.db.general.backdropfadecolor.a)
				tex:SetGradient(orientation, minC, maxC)
			end
			if not E.db.unitframe.colors.custompowerbackdrop and gm.enablebackdrop and groupunitframe.Power.bg then
				local bgMin, bgMax = GetGradient(powertype, false, false, true, isCustom)
				if bgMin and bgMax then
					groupunitframe.Power.bg:SetGradient(orientation, bgMin, bgMax)
				end
			end
		else
			local r, g, b = groupunitframe.Power:GetStatusBarColor()
			if r and ElvUI_EltreumUI:IsThisASafeSecret(r, true) then --check for it not being a secret
				if r ~= 1 and g ~= 1 and b ~= 1 then
					fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
					fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)

					local tex = groupunitframe.Power:GetStatusBarTexture()
					if tex then
						tex:SetVertexColor(1, 1, 1, E.db.general.backdropfadecolor.a)
						tex:SetGradient(orientation, fallbackMin, fallbackMax)
					end

					if transparent and gm.enablebackdrop and groupunitframe.Power.backdrop and groupunitframe.Power.backdrop.Center then
						groupunitframe.Power.backdrop.Center:SetGradient(orientation, fallbackMin, fallbackMax)
					end

					if not E.db.unitframe.colors.custompowerbackdrop and gm.enablebackdrop and groupunitframe.Power.bg then
						local bgfade = gm.bgfade or 0
						fallbackMin:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
						fallbackMax:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
						groupunitframe.Power.bg:SetGradient(orientation, fallbackMin, fallbackMax)
					end
				end
			end
		end
	end
	if groupunitframe.AlternativePower then
		local r, g, b = groupunitframe.AlternativePower:GetStatusBarColor()
		if r and ElvUI_EltreumUI:IsThisASafeSecret(r, true) then --check for it not being a secret
			if r ~= 1 and g ~= 1 and b ~= 1 then
				local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
				local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture
				local orientation = gm.orientationpower or "HORIZONTAL"
				local alpha = ufCustom.backdropalpha or 1
				local textureToUse
				if ufCustom.enable then
					textureToUse = E.LSM:Fetch("statusbar", ufCustom.powertexture)
				elseif gm.useUFtexture then
					textureToUse = E.LSM:Fetch("statusbar", E.db.unitframe.statusbar)
				else
					textureToUse = E.LSM:Fetch("statusbar", gm.texture)
				end
				groupunitframe.AlternativePower:SetStatusBarTexture(textureToUse)
				fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), alpha)
				fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), alpha)
				local altTex = groupunitframe.AlternativePower:GetStatusBarTexture()
				if altTex then
					altTex:SetVertexColor(1, 1, 1, E.db.general.backdropfadecolor.a)
					altTex:SetGradient(orientation, fallbackMin, fallbackMax)
				end
				if not E.db.unitframe.colors.custompowerbackdrop and gm.enablebackdrop and groupunitframe.AlternativePower.bg then
					local bgfade = gm.bgfade or 0
					fallbackMin:SetRGBA(clamp((r - 0.4) - bgfade), clamp((g - 0.4) - bgfade), clamp((b - 0.4) - bgfade), 1)
					fallbackMax:SetRGBA(clamp((r + 0.2) - bgfade), clamp((g + 0.2) - bgfade), clamp((b + 0.2) - bgfade), 1)
					groupunitframe.AlternativePower.bg:SetGradient(orientation, fallbackMin, fallbackMax)
				end
			end
		end
	end
end

--additional power gradient/combo/runes as well
local function gradientclassbar(powerbar,powerType)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		for index, bar in ipairs(powerbar) do
			local isRunes = powerType == 'RUNES'
			local colors, powers, fallback = UF:ClassPower_GetColor(UF.db.colors, powerType)
			local color = UF:ClassPower_BarColor(bar, index, colors, powers, isRunes)
			if not color or not color.r then
				if powerbar.GetVertexColor then
					color.r,color.g,color.b = powerbar:GetVertexColor()
				else
					color = fallback
				end
			end
			fallbackMin:SetRGBA(clamp(color.r - 0.3), clamp(color.g - 0.3), clamp(color.b - 0.3), 1)
			fallbackMax:SetRGBA(clamp(color.r), clamp(color.g), clamp(color.b), 1)
			bar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
			if E.db.unitframe.units.player.classbar.fill == "spaced" then
				local bgA = bar.bg:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(bgA, true) and bgA ~= 0 then
					bar.bg:SetAlpha(0)
				end
				if E.db.unitframe.colors.customclasspowerbackdrop then
					bar.backdrop.Center:SetVertexColor(E.db.unitframe.colors.classpower_backdrop.r, E.db.unitframe.colors.classpower_backdrop.g, E.db.unitframe.colors.classpower_backdrop.b)
				end
			else
				local bgA = bar.bg:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(bgA, true) and bgA ~= E.db.general.backdropfadecolor.a then
					bar.bg:SetAlpha(E.db.general.backdropfadecolor.a)
				end
			end
		end
	end
end
function ElvUI_EltreumUI:UFClassPower_SetBarColor(frame)
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if frame and not frame.EltruismHookedGradientClassPower then
			if frame.ClassPower then
				hooksecurefunc(frame.ClassPower,"UpdateColor", function(powerbar,powerType)
					gradientclassbar(powerbar,powerType)
				end)
			end
			--[[if frame.Runes then
				hooksecurefunc(frame.Runes,"UpdateColor", function(powerbar,powerType)
					gradientclassbar(powerbar,powerType)
				end)
			end]]
			frame.EltruismHookedGradientClassPower = true
		end
	end
end
hooksecurefunc(UF, "Configure_ClassBar", ElvUI_EltreumUI.UFClassPower_SetBarColor)

local individualPowerUnits = {
	player = "Player",
	target = "Target",
	pet = "Pet",
	targettarget = "TargetTarget",
	targettargettarget = "TargetTargetTarget",
	focus = "Focus",
	focustarget = "FocusTarget",
}

local function PowerBar_PostUpdatePowerColor(powerBar, unit)
	if not powerBar then return end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not (E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications) then return end

	local parent = powerBar.origParent or (powerBar.GetParent and powerBar:GetParent())
	if not parent then return end

	local frameType = parent.unitframeType
	if not frameType then
		local fUnit = unit or parent.__unit or parent.unit
		if fUnit then
			parent.__unit = fUnit
			ElvUI_EltreumUI:ApplyGroupGradientPower(parent)
		end
		return
	end

	local name = individualPowerUnits[frameType]
	if name then
		ElvUI_EltreumUI:ApplyUnitGradientPower(unit or frameType, name)
	elseif frameType == "boss" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradientPower(unit or parent.unit or parent.__unit, frameName:sub(7))
		end
	elseif frameType == "arena" then
		local frameName = parent:GetName()
		if frameName then
			ElvUI_EltreumUI:ApplyUnitGradientPower(unit or parent.unit or parent.__unit, frameName:sub(7))
		end
	else
		if unit then
			parent.__unit = unit
		elseif not parent.__unit and parent.unit then
			parent.__unit = parent.unit
		end
		ElvUI_EltreumUI:ApplyGroupGradientPower(parent)
	end
end

--Gradient Power Colors
function ElvUI_EltreumUI:GradientPower(unit)--(unit,r,g,b)
	if self and type(self) == "table" and self ~= ElvUI_EltreumUI and self.GetParent and self.GetObjectType and self:GetObjectType() == "StatusBar" then
		PowerBar_PostUpdatePowerColor(self, unit)
		return
	end
	if ElvUI_EltreumUI:EncounterCheck() then return end
	local forced = false
	local transparent = E.db.unitframe.colors.transparentPower

	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Player")
		ElvUI_EltreumUI:ApplyUnitGradientPower("target", "Target")
		ElvUI_EltreumUI:ApplyUnitGradientPower("pet", "Pet")
		if ElvUI_EltreumUI:IsThisASafeSecret(nil,nil,true) then
			ElvUI_EltreumUI:ApplyUnitGradientPower("targettarget", "TargetTarget")
			ElvUI_EltreumUI:ApplyUnitGradientPower("targettargettarget", "TargetTargetTarget")
		end
		if E.Retail or E.Mists or E.TBC or E.Wrath then
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss1", "Boss1")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss2", "Boss2")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss3", "Boss3")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss4", "Boss4")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss5", "Boss5")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss6", "Boss6")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss7", "Boss7")
			ElvUI_EltreumUI:ApplyUnitGradientPower("boss8", "Boss8")
			ElvUI_EltreumUI:ApplyUnitGradientPower("focus", "Focus")
			if ElvUI_EltreumUI:IsThisASafeSecret(nil,nil,true) then
				ElvUI_EltreumUI:ApplyUnitGradientPower("focustarget", "FocusTarget")
			end
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena1", "Arena1")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena2", "Arena2")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena3", "Arena3")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena4", "Arena4")
			ElvUI_EltreumUI:ApplyUnitGradientPower("arena5", "Arena5")
		end

		if unit == "testunit" then
			forced = true
		end

		if forced then
			if E.Retail or E.Mists or E.TBC or E.Wrath then
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss1")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss2")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss3")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss4")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss5")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss6")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss7")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Boss8")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Focus")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "FocusTarget")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena1")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena2")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena3")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena4")
				ElvUI_EltreumUI:ApplyUnitGradientPower("player", "Arena5")
			end
		end

		--group/raid unitframes
		if IsInGroup() or UnitInParty("player") or UnitInRaid("player") or forced then
			if _G["ElvUF_Party"] and (_G["ElvUF_Party"]:IsVisible() or _G["ElvUF_Party"]:IsShown()) and E.db.unitframe.units.party.power and E.db.unitframe.units.party.power.enable then
				local party = _G["ElvUF_PartyGroup1"]
				if party then
					for i = 1, select("#", party:GetChildren()) do
						local frame = select(i, party:GetChildren())
						if frame and frame.Power and (frame.__unit or frame.unit) and (frame:IsShown() or frame.Power:IsShown() or forced) then
							ElvUI_EltreumUI:ApplyGroupGradientPower(frame)
						end
					end
				end
				if E.db.unitframe.units.party.petsGroup and E.db.unitframe.units.party.petsGroup.enable then
					if _G["ElvUF_PartyGroup1UnitButton1Pet"] and (_G["ElvUF_PartyGroup1UnitButton1Pet"]:IsVisible() or _G["ElvUF_PartyGroup1UnitButton1Pet"]:IsShown()) then
						for i = 1, 5 do
							local partypetbutton = _G["ElvUF_PartyGroup1UnitButton"..i.."Pet"]
							if partypetbutton and partypetbutton.Power and (partypetbutton.__unit or partypetbutton.unit) and (partypetbutton:IsShown() or partypetbutton.Power:IsShown() or forced) then
								ElvUI_EltreumUI:ApplyGroupGradientPower(partypetbutton)
							end
						end
					end
				end
			end
			for raidNum = 1, 3 do
				local raid = _G["ElvUF_Raid"..raidNum]
				if raid and (raid:IsVisible() or raid:IsShown()) and E.db.unitframe.units["raid"..raidNum].power and E.db.unitframe.units["raid"..raidNum].power.enable then
					for i = 1, 8 do
						local group = _G["ElvUF_Raid"..raidNum.."Group"..i]
						if group then
							for j = 1, select("#", group:GetChildren()) do
								local frame = select(j, group:GetChildren())
								if frame and frame.Power and (frame.__unit or frame.unit) and (frame:IsShown() or frame.Power:IsShown() or forced) then
									ElvUI_EltreumUI:ApplyGroupGradientPower(frame)
								end
							end
						end
					end
				end
			end
		end

		--gradient additional power, transparent other frames if power tranparency is enabled
		if _G["ElvUF_Player_ClassBar"] then
			local bA = _G["ElvUF_Player_ClassBar"]:GetAlpha()
			if transparent and ElvUI_EltreumUI:IsThisASafeSecret(bA, true) and bA ~= E.db.general.backdropfadecolor.a then
				_G["ElvUF_Player_ClassBar"]:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player_Runes"] then
			local bA = _G["ElvUF_Player_Runes"]:GetAlpha()
			if transparent and ElvUI_EltreumUI:IsThisASafeSecret(bA, true) and bA ~= E.db.general.backdropfadecolor.a then
				_G["ElvUF_Player_Runes"]:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player_Stagger"] then
			local bA = _G["ElvUF_Player_Stagger"]:GetAlpha()
			if transparent and ElvUI_EltreumUI:IsThisASafeSecret(bA, true) and bA ~= E.db.general.backdropfadecolor.a then
				_G["ElvUF_Player_Stagger"]:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player"] and _G["ElvUF_Player"].Totems then
			local bA = _G["ElvUF_Player"].Totems:GetAlpha()
			if transparent and ElvUI_EltreumUI:IsThisASafeSecret(bA, true) and bA ~= E.db.general.backdropfadecolor.a then
				_G["ElvUF_Player"].Totems:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end
		if _G["ElvUF_Player_AdditionalPowerBar"] then
			if transparent then --make additional power follow power transparency
				local bA1 = _G["ElvUF_Player_AdditionalPowerBar"]:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(bA1, true) and bA1 ~= E.db.general.backdropfadecolor.a then
					_G["ElvUF_Player_AdditionalPowerBar"]:SetAlpha(E.db.general.backdropfadecolor.a)
				end
				local bA2 = _G["ElvUF_Player_AdditionalPowerBar"].ClipFrame:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(bA2, true) and bA2 ~= E.db.general.backdropfadecolor.a then
					_G["ElvUF_Player_AdditionalPowerBar"].ClipFrame:SetAlpha(E.db.general.backdropfadecolor.a)
				end
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and not _G["ElvUF_Player_AdditionalPowerBar"].isHooked then
					hooksecurefunc(_G["ElvUF_Player_AdditionalPowerBar"], "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
						fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), 1)
						fallbackMax:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
						_G["ElvUF_Player_AdditionalPowerBar"]:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
						if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
							local bgA = _G["ElvUF_Player_AdditionalPowerBar"].bg:GetAlpha()
							if ElvUI_EltreumUI:IsThisASafeSecret(bgA, true) and bgA ~= E.db.general.backdropfadecolor.a then
								_G["ElvUF_Player_AdditionalPowerBar"].bg:SetAlpha(E.db.general.backdropfadecolor.a)
							end
						end
					end)
				_G["ElvUF_Player_AdditionalPowerBar"].isHooked = true
			end
		end
	end
end
hooksecurefunc(UF, "Construct_PowerBar", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "PostUpdatePowerColor", PowerBar_PostUpdatePowerColor)
hooksecurefunc(UF, "Update_StatusBars", ElvUI_EltreumUI.GradientPower)
hooksecurefunc(UF, "Configure_Power", function(_, frame)
	if frame and frame.Power then
		PowerBar_PostUpdatePowerColor(frame.Power, frame.__unit or frame.unit)
	end
end)

--gradient stagger because its special
function ElvUI_EltreumUI:GradientStagger()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if _G["ElvUF_Player_Stagger"] and not _G["ElvUF_Player_Stagger"].EltruismHook then
			hooksecurefunc(_G["ElvUF_Player_Stagger"], "SetStatusBarColor", function(stagger,r,g,b)
				fallbackMin:SetRGBA(clamp(r - 0.5), clamp(g - 0.5), clamp(b - 0.5), 1)
				fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), 1)
				stagger:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
			end)
			_G["ElvUF_Player_Stagger"].EltruismHook = true
		end
		if _G["ElvNP_TargetClassPowerStagger"] and not _G["ElvNP_TargetClassPowerStagger"].EltruismHook then
			hooksecurefunc(_G["ElvNP_TargetClassPowerStagger"], "SetStatusBarColor", function(npstagger,r,g,b)
				fallbackMin:SetRGBA(clamp(r - 0.5), clamp(g - 0.5), clamp(b - 0.5), 1)
				fallbackMax:SetRGBA(clamp(r + 0.2), clamp(g + 0.2), clamp(b + 0.2), 1)
				npstagger:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
			end)
			_G["ElvNP_TargetClassPowerStagger"].EltruismHook = true
		end
	end
end
hooksecurefunc(UF, "Construct_Stagger", ElvUI_EltreumUI.GradientStagger)

--gradient eclipse, also special
function ElvUI_EltreumUI:GradientEclipse()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if _G["ElvUF_Player_EclipsePowerBar"] then
			if E.db.unitframe.colors.transparentPower then --make eclipse follow power transparency
				local lA = _G["ElvUF_Player_EclipsePowerBar"].LunarBar:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(lA, true) and lA ~= E.db.general.backdropfadecolor.a then
					_G["ElvUF_Player_EclipsePowerBar"].LunarBar:SetAlpha(E.db.general.backdropfadecolor.a)
				end
				local sA = _G["ElvUF_Player_EclipsePowerBar"].SolarBar:GetAlpha()
				if ElvUI_EltreumUI:IsThisASafeSecret(sA, true) and sA ~= E.db.general.backdropfadecolor.a then
					_G["ElvUF_Player_EclipsePowerBar"].SolarBar:SetAlpha(E.db.general.backdropfadecolor.a)
				end
			end
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar and not _G["ElvUF_Player_EclipsePowerBar"].isHooked then
				hooksecurefunc(_G["ElvUF_Player_EclipsePowerBar"].LunarBar, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					fallbackMin:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), 1)
					fallbackMax:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
					_G["ElvUF_Player_EclipsePowerBar"].LunarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
				end)
				hooksecurefunc(_G["ElvUF_Player_EclipsePowerBar"].SolarBar, "SetStatusBarColor", function(_,r,g,b) --i knew the vertex thing from details could be useful
					fallbackMin:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
					fallbackMax:SetRGBA(clamp(r - 0.4), clamp(g - 0.4), clamp(b - 0.4), 1)
					_G["ElvUF_Player_EclipsePowerBar"].SolarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, fallbackMin, fallbackMax)
				end)
				_G["ElvUF_Player_EclipsePowerBar"].isHooked = true
			end
			_G["ElvUF_Player_EclipsePowerBar"].Arrow:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ArrowEltruismEclipse.tga")
		end
	end
end
if E.Mists then --this is only cata onwards
	hooksecurefunc(UF, "Construct_DruidEclipseBar", ElvUI_EltreumUI.GradientEclipse)
end

--make power pred use the same texture too
function ElvUI_EltreumUI:Configure_PowerPrediction(frame)
	local pred = frame and frame.PowerPrediction
	if not pred then return end
	if pred.mainBar then
		pred.mainBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	end
	local altBar = pred.altBar
	if altBar then
		altBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	end
end
hooksecurefunc(UF, "Configure_PowerPrediction", ElvUI_EltreumUI.Configure_PowerPrediction)
