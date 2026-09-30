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
local GetShapeshiftForm = _G.GetShapeshiftForm
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
EltreumPowerBar.currentPoint = nil
EltreumPowerBar.currentAnchor = nil
EltreumPowerBar.currentY = nil

EltreumPowerBar:SetValue(0)
EltreumPowerBar:Hide() --hide at the start before events

--Setup the text
local EltreumPowerBarText = CreateFrame("Frame", nil, EltreumPowerBar)
EltreumPowerBarText:SetWidth(1)
EltreumPowerBarText:SetHeight(1)
EltreumPowerBarText:SetFrameStrata('DIALOG')
EltreumPowerBar.Text = EltreumPowerBarText:CreateFontString(nil, "ARTWORK", "GameFontNormal")
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("MIDDLE")

--setup the prediction and incoming prediction
local EltreumPowerBarClipFrame = CreateFrame("Frame", "EltruismPowerBarClipFrame", EltreumPowerBar)
EltreumPowerBarClipFrame:SetClipsChildren(true)
EltreumPowerBarClipFrame:SetAllPoints()
EltreumPowerBarClipFrame:EnableMouse(false)
EltreumPowerBar.ClipFrame = EltreumPowerBarClipFrame

local EltreumPowerPrediction = CreateFrame('StatusBar', "EltruismPowerBarPrediction", EltreumPowerBarClipFrame)
EltreumPowerPrediction:Hide()
EltreumPowerPrediction.isShownStatus = false
local EltreumPowerPredictionIncoming = CreateFrame('StatusBar', "EltruismPowerBarPredictionIncoming", EltreumPowerBarClipFrame)
EltreumPowerPrediction:SetValue(0)
EltreumPowerPredictionIncoming:Hide()
EltreumPowerPredictionIncoming.isShownStatus = false
EltreumPowerPredictionIncoming:SetValue(0)
local druidwrath = 6
local druidstarfire = 8
local shamanhex = 0
local shamanbolt = 6
local shamanlavaburst = 8
local huntersteadyshot = 10 --now baseline
local maxpower = 0
local mainCost = 0 --reset
local incResource = 0 -- reset

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
		EltreumPowerPrediction:ClearAllPoints()
		EltreumPowerPrediction:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
		EltreumPowerPrediction:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
		EltreumPowerPrediction:SetPoint("RIGHT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
		EltreumPowerPrediction:SetReverseFill(true)
		EltreumPowerPrediction:SetWidth(nameplatePowerDB.sizex)
		EltreumPowerPrediction:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 2)

		EltreumPowerPredictionIncoming:ClearAllPoints()
		EltreumPowerPredictionIncoming:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
		EltreumPowerPredictionIncoming:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
		EltreumPowerPredictionIncoming:SetPoint("LEFT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
		EltreumPowerPredictionIncoming:SetReverseFill(false)
		EltreumPowerPredictionIncoming:SetWidth(nameplatePowerDB.sizex)
		EltreumPowerPredictionIncoming:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 1)
		EltreumPowerBar.isSetupprediction = true
	end

	local predictioncolorr, predictioncolorg, predictioncolorb = EltreumPowerBar:GetStatusBarColor()
	EltreumPowerPrediction:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)
	EltreumPowerPredictionIncoming:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)

	if E.Modern then
		local druideclipse = GetPlayerAuraBySpellID(48517)
		if IsPlayerSpell(114107) and druideclipse ~= nil then
			druidwrath = 10
			druidstarfire = 10
		else
			druidwrath = 6
			druidstarfire = 8
		end
		if IsPlayerSpell(321018) then --improved steady shot
			huntersteadyshot = 20
		else
			huntersteadyshot = 10
		end
		if IsPlayerSpell(385923) then --shaman flow of power
			shamanbolt = 8
			shamanlavaburst = 10
		else
			shamanbolt = 6
			shamanlavaburst = 8
		end
		if IsPlayerSpell(378776) and _G.InCombatLockdown() then --shaman inundate
			shamanhex = 8
		else
			shamanhex = 0
		end
	end

	--Some of this is from Asakawa's Universal Power Bar, but mostly has been revamped and updated to current values instead of BFA values
	local spellGenerators = {

		-- Balance Druid
		[190984] = druidwrath, --wrath
		[194153] = druidstarfire, -- StarFire
		--[214281] = 10, -- New Moon --might finally have become 1
		[274281] = 10, -- New Moon
		--[214282] = 20, -- Half Moon --might finally have become 1
		[274282] = 20, -- Half Moon
		[274283] = 40, -- Full Moon
		[202347] = 12, -- Stellar Flare

		-- Shadow Priest
		[8092] = 6, -- mind blast
		[34914] = 4, -- vampiric touch
		--[15407] = 12, -- mind flay, but is a channel so idc
		--[48045] = 6, -- per target, but is a channel so idc
		--[263165] = 60, -- void torrent, but is a channel so idc
		[263346] = 15, --dark void
		[73510] = 4, --mind spike
		[391109] = 30, --dark ascension
		[407466] = 12, --mind spike: insanity
		--[391403] = 12, --mind flay: insanity, but its a channel so idc
		[375901] = 10, --mindgames
		[120644] = 10, -- halo
		--[263165] = 24, --void torrent, but its a channel so idc
		[450983] = 6, --void blast

		-- Elemental Shaman
		[188196] = shamanbolt, --lightning bolt
		[51505] = shamanlavaburst, --lava burst
		[114074] = 2, --lava beam
		[210714] = 25, --icefury
		[188443] = 4, --chain lightning (per target hit)
		[51514] = shamanhex, --hex can have maelstrom if they have inundate
		[210873] = shamanhex, --hex can have maelstrom if they have inundate
		[211004] = shamanhex, --hex can have maelstrom if they have inundate
		[211010] = shamanhex, --hex can have maelstrom if they have inundate
		[211015] = shamanhex, --hex can have maelstrom if they have inundate
		[269352] = shamanhex, --hex can have maelstrom if they have inundate
		[277778] = shamanhex, --hex can have maelstrom if they have inundate
		[277784] = shamanhex, --hex can have maelstrom if they have inundate
		[309328] = shamanhex, --hex can have maelstrom if they have inundate

		--Hunter
		[56641] = huntersteadyshot, --steady shot gives bonus focus with a talent
	}

	mainCost = 0 --reset
	incResource = 0 --reset

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
						mainCost = (playerPowerMax * cperc) / 100
					end
					break
				end
			end
		end

		--because priest/shaman/druid have a secondary power AND mana they need to be checked against
		if not isSecretSpell and spellID and spellGenerators[spellID] then
			local isGeneratorForPowerType = false
			if E.myclass == "DRUID" and powerType == (Enum.PowerType.LunarPower or 8) then
				isGeneratorForPowerType = true
			elseif E.myclass == "PRIEST" and powerType == (Enum.PowerType.Insanity or 13) then
				isGeneratorForPowerType = true
			elseif E.myclass == "SHAMAN" and powerType == (Enum.PowerType.Maelstrom or 11) then
				isGeneratorForPowerType = true
			elseif E.myclass == "HUNTER" and powerType == (Enum.PowerType.Focus or 2) then
				isGeneratorForPowerType = true
			end

			if isGeneratorForPowerType then
				incResource = spellGenerators[spellID] or 0
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
				EltreumPowerPrediction:ClearAllPoints()
				EltreumPowerPrediction:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
				EltreumPowerPrediction:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
				EltreumPowerPrediction:SetPoint("RIGHT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				EltreumPowerPrediction:SetReverseFill(true)
				EltreumPowerPrediction:SetWidth(nameplatePowerDB.sizex)
				EltreumPowerPrediction:SetFrameLevel(EltreumPowerBar:GetFrameLevel() + 2)

				EltreumPowerPredictionIncoming:ClearAllPoints()
				EltreumPowerPredictionIncoming:SetPoint("TOP", EltreumPowerBarClipFrame, "TOP")
				EltreumPowerPredictionIncoming:SetPoint("BOTTOM", EltreumPowerBarClipFrame, "BOTTOM")
				EltreumPowerPredictionIncoming:SetPoint("LEFT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				EltreumPowerPredictionIncoming:SetReverseFill(false)
				EltreumPowerPredictionIncoming:SetWidth(nameplatePowerDB.sizex)
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
			if powertype then
				if npGradient then
					if not gradientDB.orientationpower then --the error on reload is because the db unloads before this apparently, so value returns as nil
						gradientDB.orientationpower = "HORIZONTAL"
					end
					if gradientDB.enablepowercustom then
						EltreumPowerBar:GetStatusBarTexture():SetGradient(gradientDB.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
					else
						EltreumPowerBar:GetStatusBarTexture():SetGradient(gradientDB.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
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
			if nameplatePowerDB.autoadjustposition then
				if targetClassPower and targetClassPowerShown then
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
				elseif targetRunes and targetRunesShown then
					EltreumPowerBar:SetPoint("TOP", targetRunes, "TOP", 0, 23)
				elseif targetStagger and targetStaggerShown then
					EltreumPowerBar:SetPoint("TOP", targetStagger, "TOP", 0, 23)
				else
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 14)
				end
			else
				EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, nameplatePowerDB.posy)
			end

			--adjust position, show/hide, show colors depending on powertype if not gradient
			if E.myclass == 'PALADIN' or E.myclass == 'MAGE' or E.myclass == 'WARLOCK' or E.myclass == 'EVOKER' then
				if nameplatePowerPrivateDB.mana then
					EltreumPowerBar:Show()
					if not npGradient then
						EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
					end
				end
			elseif E.myclass == 'DRUID' then
				local stance = GetShapeshiftForm()
				--[[
					-- FOR BALANCE
					--retail
					-- 0 is human
					-- 1 is bear
					-- 2 is cat
					-- 3 is bird
					-- 4 is moonkin
					-- 5 is tree (if known)
					-- 6 is mount form (if known)

					--for resto
					-- 0 is human
					-- 1 is bear
					-- 2 is cat
					-- 3 is bird
					-- 4 is moonkin (if known)
					-- 4 is tree (if known and moonkin not known)
					--5 = tree of life (talent)
				]]--
				--tree = IsSpellKnown(114282)
				--moonkin = IsSpellKnown(197625)
				--stag = IsSpellKnown(210053)
				if stance == 0 then --humanoid
					if nameplatePowerPrivateDB.mana then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
						end
					end
				elseif stance == 1 then --bear
					if nameplatePowerPrivateDB.rage then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.RAGE.r, PowerColorDB.RAGE.g, PowerColorDB.RAGE.b) --its rage so color it like rage
						end
					end
				elseif stance == 2 then --cat for retail, aquatic for classic
					if nameplatePowerPrivateDB.energy then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.ENERGY.r, PowerColorDB.ENERGY.g, PowerColorDB.ENERGY.b) --its energy so color it like energy
						end
					end
				elseif stance == 3 then --travel for retail, cat for classic
					if E.Modern then
						if nameplatePowerPrivateDB.mana then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
							end
						end
					else
						if nameplatePowerPrivateDB.energy then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.ENERGY.r, PowerColorDB.ENERGY.g, PowerColorDB.ENERGY.b) --its energy so color it like energy
							end
						end
					end
				elseif stance == 4 then
					if E.Retail then --this is where it gets tricky due to talents and specs 4 is either moonkin OR tree of life if resto and not talented into moonkin affinity
						if ElvUI_EltreumUI.Spec == 103 then --moonkin
							if nameplatePowerPrivateDB.astral then
								EltreumPowerBar:Show()
								if not npGradient then
									EltreumPowerBar:SetStatusBarColor(PowerColorDB.LUNAR_POWER.r, PowerColorDB.LUNAR_POWER.g, PowerColorDB.LUNAR_POWER.b) --its astral/lunar power
								end
							end
						else --resto druid or other druid
							if nameplatePowerPrivateDB.mana then
								EltreumPowerBar:Show()
								if not npGradient then
									EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
								end
							end
						end
					else --and in classic, 4 is travel and 5 is moonkin/resto tree
						if nameplatePowerPrivateDB.mana then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
							end
						end
					end
				elseif stance == 5 or stance == 6 then
					if nameplatePowerPrivateDB.mana then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
						end
					end
				end
			elseif E.myclass == 'WARRIOR' then
				if nameplatePowerPrivateDB.rage then
					EltreumPowerBar:Show()
					if not npGradient then
						EltreumPowerBar:SetStatusBarColor(PowerColorDB.RAGE.r, PowerColorDB.RAGE.g, PowerColorDB.RAGE.b) --its rage so color it like rage
					end
				end
			elseif E.myclass == 'ROGUE' then
				if nameplatePowerPrivateDB.energy then
					EltreumPowerBar:Show()
					if not npGradient then
						EltreumPowerBar:SetStatusBarColor(PowerColorDB.ENERGY.r, PowerColorDB.ENERGY.g, PowerColorDB.ENERGY.b) --its energy so color it like energy
					end
				end
			elseif E.myclass == 'MONK' then
				if nameplatePowerPrivateDB.energy then
					EltreumPowerBar:Show()
					if not npGradient then
						EltreumPowerBar:SetStatusBarColor(PowerColorDB.ENERGY.r, PowerColorDB.ENERGY.g, PowerColorDB.ENERGY.b) --its energy so color it like energy
					end
				end
			elseif E.myclass == 'DEATHKNIGHT' then
				if nameplatePowerPrivateDB.runic then
					EltreumPowerBar:Show()
					if not npGradient then
						EltreumPowerBar:SetStatusBarColor(PowerColorDB.RUNIC_POWER.r, PowerColorDB.RUNIC_POWER.g, PowerColorDB.RUNIC_POWER.b) --its runic power
					end
				end
			elseif E.myclass == 'HUNTER' then
				if E.Retail then
					if nameplatePowerPrivateDB.focus then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.FOCUS.r, PowerColorDB.FOCUS.g, PowerColorDB.FOCUS.b) --its focus so color it like focus
						end
					end
				else
					if nameplatePowerPrivateDB.mana then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
						end
					end
				end
			elseif E.myclass == 'DEMONHUNTER' then
				if nameplatePowerPrivateDB.fury then
					EltreumPowerBar:Show()
					if not npGradient then
						EltreumPowerBar:SetStatusBarColor(PowerColorDB.FURY.r, PowerColorDB.FURY.g, PowerColorDB.FURY.b) --its fury
					end
				end
			elseif E.myclass == 'PRIEST' then
				if E.Retail then
					if ElvUI_EltreumUI.Spec == 258 then
						if nameplatePowerPrivateDB.insanity then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.INSANITY.r, PowerColorDB.INSANITY.g, PowerColorDB.INSANITY.b) --its insanity
							end
						end
					elseif ElvUI_EltreumUI.Spec == 256 or ElvUI_EltreumUI.Spec == 257 then
						if nameplatePowerPrivateDB.mana then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
							end
						end
					else --its a low level priest
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
						end
					end
				else
					if nameplatePowerPrivateDB.mana then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
						end
					end
				end
			elseif E.myclass == 'SHAMAN' then
				if E.Retail then
					if ElvUI_EltreumUI.Spec == 262 or ElvUI_EltreumUI.Spec == 263 then
						if nameplatePowerPrivateDB.maelstrom then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.MAELSTROM.r, PowerColorDB.MAELSTROM.g, PowerColorDB.MAELSTROM.b) --its maelstrom
							end
						end
					elseif ElvUI_EltreumUI.Spec == 264 then
						if nameplatePowerPrivateDB.mana then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
							end
						end
					else --its a low level shaman
						if nameplatePowerPrivateDB.mana then
							EltreumPowerBar:Show()
							if not npGradient then
								EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
							end
						end
					end
				else
					if nameplatePowerPrivateDB.mana then
						EltreumPowerBar:Show()
						if not npGradient then
							EltreumPowerBar:SetStatusBarColor(PowerColorDB.MANA.r, PowerColorDB.MANA.g, PowerColorDB.MANA.b) --its mana so color like mana
						end
					end
				end
			end

			--add effect to bar
			if nameplatePowerDB.modeleffect then
				powerbareffect:Show()
				powerbareffect:SetSize(nameplatePowerDB.sizex or 133.5, nameplatePowerDB.sizey or 6)
				powerbareffect:SetAllPoints(EltreumPowerBar:GetStatusBarTexture())
				if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
					if E.Modern then
						powerbareffect:SetModel(1715069) --better for retail, inspired by asakawa's bar model
						powerbareffect:MakeCurrentCameraCustom()
						powerbareffect:SetTransform( CreateVector3D(-0.035, 0, 0), CreateVector3D(4.7123889803847, 0, 0), 0.785) --was rad(270) but that started breaking in 10.2.5
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
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		local playerPower = UnitPower("player")
		EltreumPowerBar:SetValue(playerPower)
		if E.Modern then
			EltreumPowerBar.Text:SetText(E:AbbreviateNumbers(playerPower, E.Abbreviate.short))
		else
			EltreumPowerBar.Text:SetText(E:ShortValue(playerPower))
		end
	end
end

--update power itself
local EltruismPowerBarEventsFrame = CreateFrame("FRAME")
EltruismPowerBarEventsFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
EltruismPowerBarEventsFrame:SetScript("OnEvent", function()
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	if UnitExists("target") then
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
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

--update when model changes (for druids mostly)
local EltruismPowerBarModelCheck = CreateFrame("FRAME")
EltruismPowerBarModelCheck:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismPowerBarModelCheck:SetScript("OnEvent", function()
	if not (E.private.ElvUI_EltreumUI and E.private.ElvUI_EltreumUI.nameplatepower and E.private.ElvUI_EltreumUI.nameplatepower.enable) then return end
	if UnitExists("target") then
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
		ElvUI_EltreumUI:PowerPrediction()
	end
end)


--update buff/debuff position automatically
function ElvUI_EltreumUI:UpdateNPwithoutBar()
	local nameplatePowerPrivateDB = E.private.ElvUI_EltreumUI.nameplatepower
	if nameplatePowerPrivateDB.enable then
		if nameplatePowerPrivateDB.adjust then
			local hasCOMBO = {
				["DEATHKNIGHT"]	= true,
				["DEMONHUNTER"]	= false,
				["DRUID"] = true, --(_G.GetShapeshiftForm() == 2) and true or false,
				["HUNTER"] = false,
				["MAGE"] = ((ElvUI_EltreumUI.Spec == 1) or (ElvUI_EltreumUI.Spec == 62)) and true or false,
				["MONK"] = ((ElvUI_EltreumUI.Spec == 1) or (ElvUI_EltreumUI.Spec == 269) or (ElvUI_EltreumUI.Spec == 268)) and true or false,
				["PALADIN"]	= (E.Retail or E.Mists) and true or false,
				["PRIEST"] = false,
				["ROGUE"] = true,
				["SHAMAN"] = (E.Retail or E.Mists) and true or false,
				["WARLOCK"] = (E.Retail or E.Mists) and true or false,
				["WARRIOR"] = false,
				["EVOKER"] = true,
			}

			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 5
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 5
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
