local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local CreateFrame = _G.CreateFrame
local IsPlayerSpell = _G.C_SpellBook and _G.C_SpellBook.IsSpellKnown or _G.IsPlayerSpell
local GetPlayerAuraBySpellID = _G.C_UnitAuras and _G.C_UnitAuras.GetPlayerAuraBySpellID
local UnitCastingInfo = _G.UnitCastingInfo or _G.CastingInfo
local GetSpellPowerCost = _G.C_Spell and _G.C_Spell.GetSpellPowerCost or _G.GetSpellPowerCost
local next = _G.next
local UnitPowerMax = _G.UnitPowerMax
local UnitPower = _G.UnitPower
local UnitPowerType = _G.UnitPowerType
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local C_NamePlate = _G.C_NamePlate
local CreateVector3D = _G.CreateVector3D
local UnitIsDead = _G.UnitIsDead
local Enum = _G.Enum

--Setup Power Bar, Prediction and Text
local EltreumPowerAnchor
local EltreumPowerBar = CreateFrame("StatusBar","EltruismPowerBar")
local powerbareffect = CreateFrame("PlayerModel", "EltruismPowerBarEffect")
powerbareffect:Hide()
powerbareffect.isShownStatus = false

EltreumPowerBar:SetValue(0)
EltreumPowerBar:Hide() --hide at the start before events
EltreumPowerBar.isShownStatus = false

EltreumPowerBar:SetValue(0)
EltreumPowerBar:Hide() --hide at the start before events

--Setup the text
local EltreumPowerBarText = CreateFrame("Frame", nil, EltreumPowerBar)
EltreumPowerBarText:SetWidth(150)
EltreumPowerBarText:SetHeight(6)
EltreumPowerBarText:SetFrameStrata('DIALOG')
EltreumPowerBar.Text = EltreumPowerBarText:CreateFontString(nil, "ARTWORK", "GameFontNormal")
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("MIDDLE")

--setup the prediction and incoming prediction
local EltreumPowerBarClipFrame = CreateFrame("Frame", "EltruismPowerBarClipFrame", EltreumPowerBar)
EltreumPowerBarClipFrame:SetClipsChildren(true)
EltreumPowerBarClipFrame:SetAllPoints(EltreumPowerBar)
EltreumPowerBarClipFrame:SetParent(EltreumPowerBar)
EltreumPowerBarClipFrame:EnableMouse(false)
EltreumPowerBar.ClipFrame = EltreumPowerBarClipFrame

local EltreumPowerPrediction = CreateFrame('StatusBar', "EltruismPowerBarPrediction", EltreumPowerBarClipFrame)
EltreumPowerPrediction:SetParent(EltreumPowerBar)
EltreumPowerPrediction:Hide()
EltreumPowerPrediction.isShownStatus = false
local EltreumPowerPredictionIncoming = CreateFrame('StatusBar', "EltruismPowerBarPredictionIncoming", EltreumPowerBarClipFrame)
EltreumPowerPrediction:SetValue(0)
EltreumPowerPredictionIncoming:SetParent(EltreumPowerBar)
EltreumPowerPredictionIncoming:Hide()
EltreumPowerPredictionIncoming.isShownStatus = false
EltreumPowerPredictionIncoming:SetValue(0)

local powerEffectTransformVec1 = CreateVector3D(-0.035, 0, 0)
local powerEffectTransformVec2 = CreateVector3D(4.7123889803847, 0, 0)
local maxpower = 0

local powerTypeSettings = {
	MANA = "mana",
	RAGE = "rage",
	ENERGY = "energy",
	LUNAR_POWER = "astral",
	RUNIC_POWER = "runic",
	INSANITY = "insanity",
	MAELSTROM = "maelstrom",
	FURY = "fury",
	FOCUS = "focus",
}

--Some of this is from Asakawa's Universal Power Bar, but mostly has been revamped and updated to current values instead of BFA values
--In Classic Era, Forever, TBC, and Wrath, cast-time abilities use Mana/Rage/Energy/Runic Power costs read dynamically via GetSpellPowerCost.
local spellGenerators = {}
if E.Retail then
	spellGenerators = {
		-- Balance Druid
		[190984] = 6, -- Wrath
		[194153] = 8, -- Starfire
		[274281] = 10, -- New Moon
		[274282] = 20, -- Half Moon
		[274283] = 40, -- Full Moon
		[202347] = 12, -- Stellar Flare

		-- Shadow Priest (channels like Mind Flay / Void Torrent are excluded)
		[8092] = 6, -- Mind Blast
		[34914] = 4, -- Vampiric Touch
		[228260] = 10, -- Voidform
		[375901] = 10, -- Mindgames (PvP talent)
		[120644] = 5, -- Halo
		[450983] = 6, -- Void Blast

		-- Elemental Shaman
		[188196] = 6, -- Lightning Bolt
		[51505] = 8, -- Lava Burst
		[462818] = 10, -- Icefury
		[188443] = 2, -- Chain Lightning (per target hit)
		[191634] = 0, -- Stormkeeper (generates Maelstrom with Stormwell)
		[51514] = 0, -- Hex (can generate Maelstrom with Inundate)
		[210873] = 0, -- Hex (can generate Maelstrom with Inundate)
		[211004] = 0, -- Hex (can generate Maelstrom with Inundate)
		[211010] = 0, -- Hex (can generate Maelstrom with Inundate)
		[211015] = 0, -- Hex (can generate Maelstrom with Inundate)
		[269352] = 0, -- Hex (can generate Maelstrom with Inundate)
		[277778] = 0, -- Hex (can generate Maelstrom with Inundate)
		[277784] = 0, -- Hex (can generate Maelstrom with Inundate)
		[309328] = 0, -- Hex (can generate Maelstrom with Inundate)

		-- Marksmanship Hunter
		[56641] = 20, -- Steady Shot

		-- Devourer Demon Hunter
		[473662] = 8, -- Consume
	}
elseif E.Mists then
	spellGenerators = {
		-- Hunter
		[56641] = 14, -- Steady Shot
		[77767] = 14, -- Cobra Shot
	}
end

local hexSpells = {
	[51514] = true,
	[210873] = true,
	[211004] = true,
	[211010] = true,
	[211015] = true,
	[269352] = true,
	[277778] = true,
	[277784] = true,
	[309328] = true,
}

local function HasPlayerAura(spellID)
	if not GetPlayerAuraBySpellID then return false end
	local aura = GetPlayerAuraBySpellID(spellID)
	if E.IsSecretValue and E:IsSecretValue(aura) then return false end
	return aura ~= nil
end

--update talents
local function UpdatePowerTalents()
	if E.myclass == "DRUID" then
		local wildSurgesBonus = IsPlayerSpell(406890) and 2 or 0 -- Wild Surges
		spellGenerators[190984] = 6 + wildSurgesBonus -- Wrath
		spellGenerators[194153] = 8 + wildSurgesBonus + (IsPlayerSpell(429520) and 2 or 0) -- Starfire + Moon Guardian
		spellGenerators[274283] = IsPlayerSpell(424058) and 46 or 40 -- Full Moon + Boundless Moonlight
	elseif E.myclass == "PRIEST" then
		spellGenerators[450983] = IsPlayerSpell(450612) and 8 or 6 -- Void Blast + Void Infusion
	elseif E.myclass == "SHAMAN" then
		spellGenerators[191634] = IsPlayerSpell(1264762) and 10 or 0 -- Stormkeeper + Stormwell
		local hexValue = IsPlayerSpell(378776) and 8 or 0 -- Inundate
		for spellID in next, hexSpells do
			spellGenerators[spellID] = hexValue
		end
	elseif E.myclass == "HUNTER" then
		spellGenerators[56641] = IsPlayerSpell(450379) and 25 or 20 -- Steady Shot + Invigorating Pulse
	elseif E.myclass == "DEMONHUNTER" then
		spellGenerators[473662] = IsPlayerSpell(1253415) and 10 or 8 -- Consume + Celestial Echoes
	end
end
if E.Retail then
	local TalentUpdateFrame = CreateFrame("FRAME")
	TalentUpdateFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	TalentUpdateFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
	TalentUpdateFrame:RegisterEvent("SPELLS_CHANGED")
	TalentUpdateFrame:RegisterEvent("TRAIT_CONFIG_UPDATED")
	TalentUpdateFrame:SetScript("OnEvent", UpdatePowerTalents)
end

--Calculate the Power Cost and draw on the Bar
function ElvUI_EltreumUI:PowerPrediction()
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	if not UnitExists("target") or not EltreumPowerBar:IsShown() then
		EltreumPowerPrediction:SetValue(0)
		if EltreumPowerPrediction.isShownStatus then
			EltreumPowerPrediction:Hide() --hide at the start before events
			EltreumPowerPrediction.isShownStatus = false
		end
		EltreumPowerPredictionIncoming:SetValue(0)
		if EltreumPowerPredictionIncoming.isShownStatus then
			EltreumPowerPredictionIncoming:Hide() --hide at the start before events
			EltreumPowerPredictionIncoming.isShownStatus = false
		end
		return
	end

	local nameplatePowerDB = E.db.ElvUI_EltreumUI.nameplates.nameplatepower
	if not EltreumPowerBar.isSetupprediction then
		local barTexture = E.LSM:Fetch("statusbar", nameplatePowerDB.texture)
		--make them behave nicely since i had to split them
		EltreumPowerPrediction:SetStatusBarTexture(barTexture)
		EltreumPowerPredictionIncoming:SetStatusBarTexture(barTexture)
		EltreumPowerPrediction:SetWidth(nameplatePowerDB.sizex)
		EltreumPowerPrediction:ClearAllPoints()
		EltreumPowerPrediction:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
		EltreumPowerPrediction:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
		EltreumPowerPrediction:SetPoint("RIGHT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
		EltreumPowerPrediction:SetReverseFill(true)
		EltreumPowerPrediction:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 2)

		EltreumPowerPredictionIncoming:SetWidth(nameplatePowerDB.sizex)
		EltreumPowerPredictionIncoming:ClearAllPoints()
		EltreumPowerPredictionIncoming:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
		EltreumPowerPredictionIncoming:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
		EltreumPowerPredictionIncoming:SetPoint("LEFT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
		EltreumPowerPredictionIncoming:SetReverseFill(false)
		EltreumPowerPredictionIncoming:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 1)
		EltreumPowerBar.isSetupprediction = true
	end

	local predictioncolorr, predictioncolorg, predictioncolorb = EltreumPowerBar:GetStatusBarColor()
	EltreumPowerPrediction:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)
	EltreumPowerPredictionIncoming:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)

	local mainCost = 0 --reset
	local incResource = 0 --reset

	local _, _, _, startTime, endTime, _, _, _, spellID = UnitCastingInfo("player")
	local isSecretStart = E:IsSecretValue(startTime)
	local isSecretSpell = E:IsSecretValue(spellID)
	local isCasting = startTime and endTime and (isSecretStart or startTime ~= endTime)

	if isCasting then
		local powerType = UnitPowerType("player") or 0
		local playerPowerMax = UnitPowerMax("player", powerType)
		local costTable = not isSecretSpell and spellID and GetSpellPowerCost(spellID)
		if costTable then --if nil then cost = 0
			local checkRequiredAura = #costTable > 1
			for _, costInfo in next, costTable do
				--costPercent, costPerSec, hasRequiredAura, type, name, cost, minCost, requiredAuraID
				local cost, ctype, cperc = costInfo.cost, costInfo.type, costInfo.costPercent
				local checkSpec = not checkRequiredAura or costInfo.hasRequiredAura
				if checkSpec and (ctype == powerType) then  --sanity check for being the same type
					if cost and cost > 0 then
						mainCost = cost
					elseif cperc and cperc > 0 and not (E.IsSecretValue and E:IsSecretValue(playerPowerMax)) and playerPowerMax and playerPowerMax > 0 then
						mainCost = (playerPowerMax * cperc) * 0.01
					end
					break
				end
			end
		end

		--because priest/shaman/druid/hunter/dh have a secondary power or generator casts they need to be checked against
		if (E.Retail or E.Mists) and not isSecretSpell and spellID and spellGenerators[spellID] then
			local isGeneratorForPowerType = false
			if E.Retail then
				if E.myclass == "DRUID" and powerType == (Enum.PowerType.LunarPower or 8) then
					isGeneratorForPowerType = true
				elseif E.myclass == "PRIEST" and powerType == (Enum.PowerType.Insanity or 13) then
					isGeneratorForPowerType = true
				elseif E.myclass == "SHAMAN" and powerType == (Enum.PowerType.Maelstrom or 11) then
					isGeneratorForPowerType = true
				elseif E.myclass == "HUNTER" and powerType == (Enum.PowerType.Focus or 2) then
					isGeneratorForPowerType = true
				elseif E.myclass == "DEMONHUNTER" and powerType == (Enum.PowerType.Fury or 17) then
					isGeneratorForPowerType = true
				end
			elseif E.Mists then
				if E.myclass == "HUNTER" and powerType == (Enum.PowerType.Focus or 2) then
					isGeneratorForPowerType = true
				end
			end

			if isGeneratorForPowerType then
				incResource = spellGenerators[spellID] or 0
				if E.Retail then
					if spellID == 190984 and IsPlayerSpell(114107) and HasPlayerAura(48517) then -- Balance Druid: Soul of the Forest + Solar Eclipse
						incResource = incResource * 1.4
					elseif spellID == 194153 and IsPlayerSpell(114107) and HasPlayerAura(48518) then -- Balance Druid: Soul of the Forest + Lunar Eclipse
						incResource = incResource * 1.4
					elseif spellID == 56641 and HasPlayerAura(288613) then -- Marksmanship Hunter: Trueshot
						incResource = incResource * 1.5
					elseif incResource > 0 and hexSpells[spellID] and not _G.InCombatLockdown() then -- Elemental Shaman: Inundate requires combat
						incResource = 0
					end
				end
			end
		end

		EltreumPowerPrediction:SetMinMaxValues(0, playerPowerMax or 1)
		EltreumPowerPredictionIncoming:SetMinMaxValues(0, playerPowerMax or 1)

		if mainCost and mainCost > 0 then
			EltreumPowerPrediction:SetValue(mainCost)
			if not EltreumPowerPrediction.isShownStatus then
				EltreumPowerPrediction:Show()
				EltreumPowerPrediction.isShownStatus = true
			end
		else
			EltreumPowerPrediction:SetValue(0)
			if EltreumPowerPrediction.isShownStatus then
				EltreumPowerPrediction:Hide()
				EltreumPowerPrediction.isShownStatus = false
			end
		end

		if incResource and incResource > 0 then
			EltreumPowerPredictionIncoming:SetValue(incResource)
			if not EltreumPowerPredictionIncoming.isShownStatus then
				EltreumPowerPredictionIncoming:Show()
				EltreumPowerPredictionIncoming.isShownStatus = true
			end
		else
			EltreumPowerPredictionIncoming:SetValue(0)
			if EltreumPowerPredictionIncoming.isShownStatus then
				EltreumPowerPredictionIncoming:Hide()
				EltreumPowerPredictionIncoming.isShownStatus = false
			end
		end
	else
		EltreumPowerPrediction:SetValue(0)
		if EltreumPowerPrediction.isShownStatus then
			EltreumPowerPrediction:Hide()
			EltreumPowerPrediction.isShownStatus = false
		end
		EltreumPowerPredictionIncoming:SetValue(0)
		if EltreumPowerPredictionIncoming.isShownStatus then
			EltreumPowerPredictionIncoming:Hide()
			EltreumPowerPredictionIncoming.isShownStatus = false
		end
	end
end

--Main function
function ElvUI_EltreumUI:NameplatePower(nameplate)
	--print("nameplate power spam "..math.random(1,99))
	if not nameplate then
		if EltreumPowerBar.isShownStatus then
			EltreumPowerBar:Hide()
			EltreumPowerBar.isShownStatus = false
		end
		if powerbareffect.isShownStatus then
			powerbareffect:Hide()
			powerbareffect.isShownStatus = false
		end
		EltreumPowerAnchor = nil
	end
	if not E.private.ElvUI_EltreumUI then return end
	if not E.private.ElvUI_EltreumUI.install_version then return end
	if not E.private.ElvUI_EltreumUI.nameplatepower then return end
	local nameplatePowerPrivateDB = E.private.ElvUI_EltreumUI.nameplatepower
	if not E.db.ElvUI_EltreumUI then return end
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		if UnitExists("target") and UnitCanAttack("player", "target") and C_NamePlate.GetNamePlateForUnit("target") ~= nil and not UnitIsDead("target") then
			EltreumPowerAnchor = C_NamePlate.GetNamePlateForUnit("target")
			EltreumPowerBar:SetParent(EltreumPowerAnchor)

			local targetClassPower = _G.ElvNP_TargetClassPowerClassPower
			local targetStagger = _G.ElvNP_TargetClassPowerStagger
			local targetRunes = _G.ElvNP_TargetClassPowerRunes
			local targetClassPowerShown = targetClassPower and targetClassPower:IsShown()
			local targetStaggerShown = targetStagger and targetStagger:IsShown()
			local targetRunesShown = targetRunes and targetRunes:IsShown()
			local nameplatePowerDB = E.db.ElvUI_EltreumUI.nameplates.nameplatepower
			local npGradient = nameplatePowerDB.gradient
			local gradientDB = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			local PowerColorDB = E.db.unitframe.colors.power
			local playerPower = UnitPower("player")
			local playerPowerMax = UnitPowerMax("player")

			if not EltreumPowerBar.isSetup then
				EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", nameplatePowerDB.font), nameplatePowerDB.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				EltreumPowerBar:SetSize(nameplatePowerDB.sizex, nameplatePowerDB.sizey)
				EltreumPowerBarClipFrame:SetSize(nameplatePowerDB.sizex, nameplatePowerDB.sizey)
				S:HandleStatusBar(EltreumPowerBar)
				EltreumPowerPrediction:SetValue(0)
				EltreumPowerPredictionIncoming:SetValue(0)

				--hide double border if the other way didn't hide it
				if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.powerbarborder and E.db.ElvUI_EltreumUI.borders.universalborders then
					if _G.EltruismPowerBar.eltruismuniversalborders then
						_G.EltruismPowerBar.eltruismuniversalborders:Kill()
						_G.EltruismPowerBar.eltruismuniversalborders = nil
					end
					if _G.EltruismPowerBar.backdrop and _G.EltruismPowerBar.backdrop.eltruismuniversalborders then
						_G.EltruismPowerBar.backdrop.eltruismuniversalborders:Kill()
						_G.EltruismPowerBar.backdrop.eltruismuniversalborders = nil
					end
				end

				EltreumPowerBar.backdrop:SetBackdropColor(nameplatePowerDB.r, nameplatePowerDB.g, nameplatePowerDB.b)
				EltreumPowerBar.backdrop:SetAlpha(nameplatePowerDB.a)
				EltreumPowerBar:SetFrameStrata("MEDIUM")

				EltreumPowerPrediction:SetWidth(nameplatePowerDB.sizex)
				EltreumPowerPrediction:ClearAllPoints()
				EltreumPowerPrediction:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
				EltreumPowerPrediction:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
				EltreumPowerPrediction:SetPoint("RIGHT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				EltreumPowerPrediction:SetReverseFill(true)
				EltreumPowerPrediction:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 2)

				EltreumPowerPredictionIncoming:SetWidth(nameplatePowerDB.sizex)
				EltreumPowerPredictionIncoming:ClearAllPoints()
				EltreumPowerPredictionIncoming:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
				EltreumPowerPredictionIncoming:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
				EltreumPowerPredictionIncoming:SetPoint("LEFT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				EltreumPowerPredictionIncoming:SetReverseFill(false)
				EltreumPowerPredictionIncoming:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 1)

				if not E.private.nameplates.enable then -- no elvui np then the position needs to be manual
					nameplatePowerDB.autoadjustposition = false
				end

				EltreumPowerBarText:SetPoint("Center", EltreumPowerBar, "Center", 0, 0)
				EltreumPowerBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", nameplatePowerDB.texture))
				EltreumPowerBar.isSetup = true
			end

			--check if max power has changed, update then
			local isSecretMax = E.IsSecretValue and E:IsSecretValue(playerPowerMax)
			if isSecretMax or (playerPowerMax ~= maxpower) then
				if not isSecretMax then maxpower = playerPowerMax end
				--update power prediction
				EltreumPowerPrediction:SetMinMaxValues(0, playerPowerMax or 1)

				--update power prediction incoming
				EltreumPowerPredictionIncoming:SetMinMaxValues(0, playerPowerMax or 1)

				--update power bar itself
				EltreumPowerBar:SetMinMaxValues(0, playerPowerMax or 1)
			end

			local _, powertype = UnitPowerType("player")

			--set gradient if enabled
			if powertype and npGradient then
				local orient = gradientDB.orientationpower or "HORIZONTAL"
				local custom = gradientDB.enablepowercustom
				local gradKey = powertype .. orient .. (custom and "1" or "0")
				if EltreumPowerBar.EltruismLastPowerGradKey ~= gradKey then
					EltreumPowerBar.EltruismLastPowerGradKey = gradKey
					if custom then
						EltreumPowerBar:GetStatusBarTexture():SetGradient(orient, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
					else
						EltreumPowerBar:GetStatusBarTexture():SetGradient(orient, ElvUI_EltreumUI:GradientColors(powertype, false, false))
					end
				end
			end

			EltreumPowerBar:SetValue(playerPower) --try to make it not be full always at the start
			if E.Modern then
				EltreumPowerBar.Text:SetText(E:AbbreviateNumbers(playerPower, E.Abbreviate["short"]))
			else
				EltreumPowerBar.Text:SetText(E:ShortValue(playerPower))
			end

			--update position based on class bar (or not)
			local targetPosY
			if nameplatePowerDB.autoadjustposition then
				if targetClassPowerShown or targetRunesShown or targetStaggerShown then
					targetPosY = 23
				else
					targetPosY = 14
				end
			else
				targetPosY = nameplatePowerDB.posy
			end

			if EltreumPowerBar.EltruismLastAnchor ~= EltreumPowerAnchor or EltreumPowerBar.EltruismLastPosY ~= targetPosY then
				EltreumPowerBar:ClearAllPoints()
				EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, targetPosY)
				EltreumPowerBar.EltruismLastAnchor = EltreumPowerAnchor
				EltreumPowerBar.EltruismLastPosY = targetPosY
			end

			--adjust position, show/hide, show colors depending on powertype if not gradient
			local powerSettingKey = powertype and powerTypeSettings[powertype]
			if powerSettingKey and nameplatePowerPrivateDB[powerSettingKey] then
				EltreumPowerBar:Show()
				if not npGradient then
					local powerColor = PowerColorDB[powertype]
					if powerColor then
						EltreumPowerBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
					end
				end
			else
				EltreumPowerBar:Hide()
				powerbareffect:Hide()
			end

			--add effect to bar
			if nameplatePowerDB.modeleffect and EltreumPowerBar:IsShown() then
				powerbareffect:Show()
				powerbareffect:SetSize(nameplatePowerDB.sizex or 150, nameplatePowerDB.sizey or 6)
				powerbareffect:SetAllPoints(EltreumPowerBar:GetStatusBarTexture())
				if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
					if E.Modern then
						powerbareffect:SetModel(1715069) --better for retail, inspired by asakawa's bar model
						powerbareffect:MakeCurrentCameraCustom()
						powerbareffect:SetTransform(powerEffectTransformVec1, powerEffectTransformVec2, 0.785) --was rad(270) but that started breaking in 10.2.5
						powerbareffect:SetPortraitZoom(1)
						powerbareffect:SetAlpha(0.4) --might do this
					else
						powerbareffect:SetModel("spells/arcanepower_state_chest.m2")
						powerbareffect:SetPosition(1.2, 0, -0.5)
						powerbareffect:SetAlpha(0.6) --might do this
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
					if E.Modern then
						powerbareffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
					else
						powerbareffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
					end
				end
				powerbareffect:SetInside(EltreumPowerBar:GetStatusBarTexture(), 0, 0)
				powerbareffect:SetParent(EltreumPowerBar)
			end
			ElvUI_EltreumUI:PowerPrediction()
		else
			powerbareffect:Hide()
			EltreumPowerBar:Hide()
			EltreumPowerAnchor = nil
			ElvUI_EltreumUI:PowerPrediction()
		end
	end
end

--update the values of nameplate power bar
function ElvUI_EltreumUI:NameplatePowerTextUpdate()
	if E.private.ElvUI_EltreumUI.nameplatepower.enable and EltreumPowerBar:IsShown() then
		local playerPower = UnitPower("player")
		EltreumPowerBar:SetValue(playerPower)
		if E.Modern then
			EltreumPowerBar.Text:SetText(E:AbbreviateNumbers(playerPower, E.Abbreviate.short))
		else
			EltreumPowerBar.Text:SetText(E:ShortValue(playerPower))
		end
	end
end

--update power text only
local EltruismPowerBarTextFrame = CreateFrame("FRAME")
EltruismPowerBarTextFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
EltruismPowerBarTextFrame:SetScript("OnEvent", function()
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	if UnitExists("target") and EltreumPowerBar:IsShown() then
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
	end
end)

--update power itself
local EltruismPowerBarEventsFrame = CreateFrame("FRAME")
EltruismPowerBarEventsFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EltruismPowerBarEventsFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
EltruismPowerBarEventsFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
EltruismPowerBarEventsFrame:SetScript("OnEvent", function(_, event, unit)
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	if (event == "NAME_PLATE_UNIT_ADDED" or event == "NAME_PLATE_UNIT_REMOVED") and not E:UnitIsUnit(unit, "target") then return end
	if UnitExists("target") and UnitCanAttack("player", "target") and C_NamePlate.GetNamePlateForUnit("target") ~= nil and not UnitIsDead("target") then
		ElvUI_EltreumUI:NameplatePower()
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
	else
		EltreumPowerBar:Hide()
		if powerbareffect then
			powerbareffect:Hide()
		end
	end
end)

--update prediction
local EltruismPowerBarPredictionEventsFrame = CreateFrame("FRAME")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
--check events further
--EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
--EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
--EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
--EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player")
EltruismPowerBarPredictionEventsFrame:SetScript("OnEvent", function()
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	ElvUI_EltreumUI:PowerPrediction()
end)

--nameplate events for classic since nameplate range is so small
if E.Classic then
	local EltruismPowerBarNameplateEventsFrame = CreateFrame("FRAME")
	EltruismPowerBarNameplateEventsFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	EltruismPowerBarNameplateEventsFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
	EltruismPowerBarNameplateEventsFrame:SetScript("OnEvent", function()
		if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
		if UnitExists("target") and UnitCanAttack("player", "target") and C_NamePlate.GetNamePlateForUnit("target") ~= nil and not UnitIsDead("target") then
			ElvUI_EltreumUI:NameplatePower()
		else
			EltreumPowerBar:Hide()
		end
	end)
end

--update when model or power type changes (for druids/monks mostly)
local EltruismPowerBarModelCheck = CreateFrame("FRAME")
EltruismPowerBarModelCheck:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismPowerBarModelCheck:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player")
EltruismPowerBarModelCheck:SetScript("OnEvent", function()
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	if UnitExists("target") then
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
		ElvUI_EltreumUI:PowerPrediction()
	end
end)

--update buff/debuff position automatically
local hasCOMBO = {
	["DEATHKNIGHT"]	= true,
	["DEMONHUNTER"]	= false,
	["DRUID"] = true, --(_G.GetShapeshiftForm() == 2) and true or false,
	["HUNTER"] = false,
	["MAGE"] = false,
	["MONK"] = false,
	["PALADIN"]	= (E.Retail or E.Mists) and true or false,
	["PRIEST"] = false,
	["ROGUE"] = true,
	["SHAMAN"] = (E.Retail or E.Mists) and true or false,
	["WARLOCK"] = (E.Retail or E.Mists) and true or false,
	["WARRIOR"] = false,
	["EVOKER"] = true,
}
function ElvUI_EltreumUI:UpdateNPwithoutBar()
	local nameplatePowerPrivateDB = E.private.ElvUI_EltreumUI.nameplatepower
	if nameplatePowerPrivateDB.enable then
		if nameplatePowerPrivateDB.adjust then
			hasCOMBO["MAGE"] = (E.Retail and ElvUI_EltreumUI.Spec == 62) and true or false
			hasCOMBO["MONK"] = ((E.Retail or E.Mists) and ((ElvUI_EltreumUI.Spec == 269) or (ElvUI_EltreumUI.Spec == 268))) and true or false

			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 15
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 15
			E.db["nameplates"]["units"]["ENEMY_NPC"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"

			if hasCOMBO[E.myclass] then
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 36
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 36
			else
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
			end
		end
	end
end
