local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local id, _, powertype
local _G = _G
local CreateFrame = _G.CreateFrame
local IsPlayerSpell = _G.IsPlayerSpell
local GetPlayerAuraBySpellID = _G.GetPlayerAuraBySpellID
local UnitCastingInfo = _G.UnitCastingInfo
local GetSpellPowerCost = _G.GetSpellPowerCost
local next = _G.next
local UnitPowerMax = _G.UnitPowerMax
local UnitPower = _G.UnitPower
local GetSpecialization = _G.GetSpecialization
local GetSpecializationInfo = _G.GetSpecializationInfo
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local C_NamePlate = _G.C_NamePlate
local GetShapeshiftForm = _G.GetShapeshiftForm
local stance

--Setup Power Bar, Prediction and Text
local EltreumPowerAnchor
local EltreumPowerBar = CreateFrame("StatusBar","EltruismPowerBar")
local powerbareffect = CreateFrame("PlayerModel", "EltruismPowerBarEffect")
powerbareffect:Hide()

EltreumPowerBar:SetValue(0)
EltreumPowerBar:Hide() --hide at the start before events

--Setup the text
local EltreumPowerBarText = CreateFrame("Frame", nil, EltreumPowerBar)
EltreumPowerBarText:SetWidth(1)
EltreumPowerBarText:SetHeight(1)
EltreumPowerBarText:SetFrameStrata('DIALOG')
EltreumPowerBar.Text = EltreumPowerBarText:CreateFontString(nil, "ARTWORK", "GameFontNormal")
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
--EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, E.db.general.fontStyle)
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("CENTER")

--Setup background
EltreumPowerBar.bg = EltreumPowerBar:CreateTexture(nil, "BACKGROUND")
EltreumPowerBar.bg:SetTexture(E.media.normTex)
EltreumPowerBar.bg:SetPoint("CENTER", EltreumPowerBar, "CENTER", 0, 0)

--setup the prediction and incoming prediction
local EltreumPowerPrediction = CreateFrame('StatusBar', "EltruismPowerBarPrediction", EltreumPowerBar)
EltreumPowerPrediction:Hide()

local EltreumPowerPredictionIncoming = CreateFrame('StatusBar', "EltruismPowerBarPredictionIncoming", EltreumPowerBar)
EltreumPowerPredictionIncoming:Hide()

local mainCost = 0
local incResource = 0
local startTime, endTime, spellID = 0, 0, 0
local spellGenerators
local druidwrath = 6
local mindblast = 8
local mindflay = 18
local druideclipse
local costTable
local ret, ret2
local predictioncolorr, predictioncolorg, predictioncolorb
local currentSpec
local cost
local placeValue = ("%%.%df"):format(1)
local power

--Calculate the Power Cost and draw on the Bar
function ElvUI_EltreumUI:PowerPrediction()
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		EltreumPowerPrediction:Hide() --hide at the start before events
		EltreumPowerPredictionIncoming:Hide() --hide at the start before events
		predictioncolorr, predictioncolorg, predictioncolorb = EltreumPowerBar:GetStatusBarColor()

		EltreumPowerPrediction:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture))
		EltreumPowerPredictionIncoming:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture))
		--[[if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight then
			EltreumPowerPrediction:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex*E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"], E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
			EltreumPowerPredictionIncoming:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex*E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"], E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
		else
			EltreumPowerPrediction:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
			EltreumPowerPredictionIncoming:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
		end]]
		EltreumPowerPrediction:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
		EltreumPowerPredictionIncoming:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
		EltreumPowerPrediction:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)
		EltreumPowerPredictionIncoming:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)

		--make them behave nicely since i had to split them
		EltreumPowerPrediction:SetReverseFill(true)
		EltreumPowerPredictionIncoming:SetReverseFill(false)


		if IsPlayerSpell(193195) then
			mindblast = 9
			mindflay = 22
		end
		if E.Retail then
			druideclipse = GetPlayerAuraBySpellID(48517) --might be removed in dragonflight
			if IsPlayerSpell(114107) and druideclipse ~= nil then
				druidwrath = 9
			end
		end

		--Some of this is from Asakawa's Universal Power Bar, but mostly has been revamped and updated to current values instead of BFA values
		spellGenerators = {
			-- Balance Druid
			[190984] = druidwrath, --wrath
			[194153] = 8, -- StarFire
			[214281] = 10, -- New Moon
			[274281] = 10, -- New Moon
			[214282] = 20, -- Half Moon
			[274282] = 20, -- Half Moon
			[274283] = 40, -- Full Moon
			[202347] = 8, -- Stellar Flare
			-- Shadow Priest
			[8092] = mindblast, -- mind blast
			[34914] = 5, -- vampiric touch
			[15407] = mindflay, -- mind flay, but is a channel so idc
			[48045] = 6, -- per target, but is a channel so idc
			[263165] = 60, -- void torrent, but is a channel so idc
			-- Elemental Shaman
			[188196] = 8, --lightning bolt
			[51505] = 10, --lava burst
			[117014] = 30, --elemental blast
			[114074] = 4, --lava beam
			[210714] = 25, --icefury
			[188443] = 4, --chain lightning (per target hit)
			--Hunter
			[56641] = 10, --steady shot
		}


		_, _, _, startTime, endTime, _, _, _, spellID = UnitCastingInfo("player")
		if startTime ~= endTime then
			costTable = GetSpellPowerCost(spellID)
			if costTable ~= nil then
				for _, v in next, costTable do
					cost = v.cost
					mainCost = cost
				end
			end
			if spellGenerators[spellID] ~= nil then
				incResource = spellGenerators[spellID]
				--readjust if the incoming would go over max
				if (incResource + EltreumPowerBar:GetValue()) >= UnitPowerMax("player") then
					incResource = (UnitPowerMax("player") - EltreumPowerBar:GetValue())
				end
			end

			if UnitPower("player") == 0 then
				EltreumPowerPrediction:SetValue(0)
			elseif UnitPower("player") ~= 0 then
				if mainCost >= UnitPowerMax("player") or mainCost >= UnitPower("player") then
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("Couldn't Calculate your power properly, please report in Discord")
					end
					EltreumPowerPrediction:SetValue(0)
				else
					EltreumPowerPrediction:SetValue(mainCost)
				end
			end
			EltreumPowerPrediction:Show()
			EltreumPowerPredictionIncoming:SetValue(incResource)
			EltreumPowerPredictionIncoming:Show()
		else
			EltreumPowerPrediction:SetValue(0)
			EltreumPowerPrediction:Hide()
			EltreumPowerPredictionIncoming:SetValue(0)
			EltreumPowerPredictionIncoming:Hide()
		end
	end
end

--so that the power updates when spec changes
function ElvUI_EltreumUI:GetSpec()
	--print("getspec spam "..math.random(1,99))
	if E.Retail then
		currentSpec = GetSpecialization()
		if currentSpec then
			id, _ = GetSpecializationInfo(currentSpec)
		end
	end
end

--Main function
function ElvUI_EltreumUI:NameplatePower(nameplate)
	--print("nameplate power spam "..math.random(1,99))
	if not nameplate then
		EltreumPowerBar:Hide()
		powerbareffect:Hide()
		EltreumPowerAnchor = nil
	end

	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		if UnitExists("target") and UnitCanAttack("player", "target") and C_NamePlate.GetNamePlateForUnit("target") ~= nil then
			EltreumPowerAnchor = C_NamePlate.GetNamePlateForUnit("target")
			EltreumPowerBar:SetParent(EltreumPowerAnchor)

			EltreumPowerBar:SetMinMaxValues(0, UnitPowerMax("player"))

			EltreumPowerBar:SetValue(UnitPower("player")) --try to make it not be full always at the start

			if not UnitPower("player") then
				return 0
			elseif UnitPower("player") >= 1000000000000 then
				ret = placeValue:format(UnitPower("player") * 0.000000000001) .. " T" -- trillion
			elseif UnitPower("player") >= 1000000000 then
				ret = placeValue:format(UnitPower("player") * 0.000000001) .. " B" -- billion
			elseif UnitPower("player") >= 1000000 then
				ret = placeValue:format(UnitPower("player") * 0.000001) .. " M" -- million
			elseif UnitPower("player") >= 1000 then
				ret = placeValue:format(UnitPower("player") * 0.001) .. "k" -- thousand
			else
				ret = UnitPower("player") -- hundreds
			end
			EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.font), E.db.ElvUI_EltreumUI.nameplates.nameplatepower.fontsize, E.db.general.fontStyle)
			EltreumPowerBar.Text:SetText(ret)	--this is an actual number not string
			--[[if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight then
				EltreumPowerBar:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex*E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"], E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
				--EltreumPowerBar:SetSize(E.db.nameplates.plateSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey) --testwidth
			else
				EltreumPowerBar:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
			end]]
			EltreumPowerBar:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
			EltreumPowerBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture))
			EltreumPowerBar:SetFrameStrata("MEDIUM")
			--[[if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight then
				EltreumPowerBar.bg:SetSize((E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex + 1)*E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"] , E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey + 1 )
			else
				EltreumPowerBar.bg:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex + 1 , E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey + 1 )
			end]]
			EltreumPowerBar.bg:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex + 1 , E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey + 1 )
			EltreumPowerBar.bg:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.r, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.g, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.b, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.a) -- background color

			--update power prediction
			EltreumPowerPrediction:SetMinMaxValues(0, UnitPowerMax("player"))
			EltreumPowerPrediction:SetPoint("RIGHT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
			EltreumPowerPrediction:SetFrameStrata("HIGH")

			--update power prediction incoming
			EltreumPowerPredictionIncoming:SetMinMaxValues(0, UnitPowerMax("player"))
			EltreumPowerPredictionIncoming:SetPoint("LEFT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
			EltreumPowerPredictionIncoming:SetFrameStrata("HIGH")

			if E.Retail then
				if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
				else
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
				end
			elseif E.Classic or E.Wrath or E.TBC then
				if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
				else
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
				end
			end
			_, powertype = UnitPowerType("player")
			if E.myclass == 'PALADIN' or E.myclass == 'MAGE' or E.myclass == 'WARLOCK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.mana then
					EltreumPowerBar:Show()
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						else
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
					end
					if E.Classic or E.Wrath or E.TBC then
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
					if E.Retail then
						if E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' then
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
								elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								end
								--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						elseif E.myclass == 'MAGE' then
							if id == 62 then
								if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
									end
									--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
								end
							end
						end
					end
				end
			elseif E.myclass == 'DRUID' then
				stance = GetShapeshiftForm()
				--print(stance)
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
				if E.Retail then
					--tree = IsSpellKnown(114282)
					--moonkin = IsSpellKnown(197625)
					--stag = IsSpellKnown(210053)
					if stance == 0 then --humanoid
						--EltreumPowerBar:SetValue(UnitPower('player', 0)) -- get mana for druid humanoid
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif stance == 1 then --bear
						if E.private.ElvUI_EltreumUI.nameplatepower.rage then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RAGE.r, E.db.unitframe.colors.power.RAGE.g, E.db.unitframe.colors.power.RAGE.b) --its rage so color it like rage
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif stance == 2 then --cat
						if E.private.ElvUI_EltreumUI.nameplatepower.energy then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
								elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								end
								--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif stance == 3 then --3 is travel
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					--this is where it gets tricky due to talents and specs 4 is either moonkin OR tree of life if resto and not talented into moonkin affinity
					elseif stance == 4 then
						if id == 103 then --moonkin
							if E.private.ElvUI_EltreumUI.nameplatepower.astral then
								EltreumPowerBar:Show()
								if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
										EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
									else
										EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
									end
								else
									EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.LUNAR_POWER.r, E.db.unitframe.colors.power.LUNAR_POWER.g, E.db.unitframe.colors.power.LUNAR_POWER.b) --its astral/lunar power
								end
								if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
								end
							end
						else --resto druid or other druid
							if E.private.ElvUI_EltreumUI.nameplatepower.mana then
								EltreumPowerBar:Show()
								if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
										EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
									else
										EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
									end
								else
									EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
								end
								if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
								end
							end
						end
					elseif stance == 5 or stance == 6 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					end
				end
				if E.Classic or E.Wrath or E.TBC then
					if stance == 0 then --humanoid
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif stance == 1 then --bear
						if E.private.ElvUI_EltreumUI.nameplatepower.rage then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RAGE.r, E.db.unitframe.colors.power.RAGE.g, E.db.unitframe.colors.power.RAGE.b) --its rage so color it like rage
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end

						end
					elseif stance == 2 then --aquatic
						if E.private.ElvUI_EltreumUI.nameplatepower.energy then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif stance == 3 then --3 cat in classic
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
								elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
								end


								--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif stance == 4 or stance == 5 then --4 is travel in classic and 5 is moonkin/resto tree in classic
						if E.private.ElvUI_EltreumUI.nameplatepower.astral then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					end
				end
			elseif E.myclass == 'WARRIOR' then
				if E.private.ElvUI_EltreumUI.nameplatepower.rage then
					EltreumPowerBar:Show()
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						else
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RAGE.r, E.db.unitframe.colors.power.RAGE.g, E.db.unitframe.colors.power.RAGE.b) --its rage so color it like rage
					end
					if E.Retail then
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					elseif E.Classic or E.Wrath or E.TBC then
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'ROGUE' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						else
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
					end
					if E.Retail then
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
							elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							end
							--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					elseif E.Wrath or E.TBC or E.Classic then
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
							elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							end
							--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'MONK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						else
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						if (_G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown()) or (_G["ElvNP_TargetClassPowerStagger"] and _G["ElvNP_TargetClassPowerStagger"]:IsShown()) then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
						elseif (_G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown()) or ((_G["ElvNP_TargetClassPowerStagger"] and not _G["ElvNP_TargetClassPowerStagger"]:IsShown())) then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						end
						--EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'DEATHKNIGHT' then
				if E.private.ElvUI_EltreumUI.nameplatepower.runic then
					EltreumPowerBar:Show()
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						else
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RUNIC_POWER.r, E.db.unitframe.colors.power.RUNIC_POWER.g, E.db.unitframe.colors.power.RUNIC_POWER.b) --its runic power
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						if _G["ElvNP_TargetClassPowerRunes"] and _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
							EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 27)
						elseif _G["ElvNP_TargetClassPowerRunes"] and not _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
							EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 16)
						end
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'HUNTER' then
				if E.Classic or E.Wrath or E.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							else
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
						else
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				elseif E.Retail then
					if E.private.ElvUI_EltreumUI.nameplatepower.focus then
						EltreumPowerBar:Show()
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							else
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
						else
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.FOCUS.r, E.db.unitframe.colors.power.FOCUS.g, E.db.unitframe.colors.power.FOCUS.b) --its focus so color it like focus
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'DEMONHUNTER' then
				if E.private.ElvUI_EltreumUI.nameplatepower.fury then
					EltreumPowerBar:Show()
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
						else
							EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
						end
					else
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.FURY.r, E.db.unitframe.colors.power.FURY.g, E.db.unitframe.colors.power.FURY.b) --its fury
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'PRIEST' then
				if E.Classic or E.Wrath or E.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							else
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
						else
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				elseif E.Retail then
					if id == 258 then
						if E.private.ElvUI_EltreumUI.nameplatepower.insanity then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.INSANITY.r, E.db.unitframe.colors.power.INSANITY.g, E.db.unitframe.colors.power.INSANITY.b) --its insanity
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif id == 256 or id == 257 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					else --its a low level priest
						EltreumPowerBar:Show()
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							else
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
						else
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'SHAMAN' then
				if E.Classic or E.Wrath or E.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
							else
								EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
							end
						else
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				elseif E.Retail then
					if id == 262 or id == 263 then
						if E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MAELSTROM.r, E.db.unitframe.colors.power.MAELSTROM.g, E.db.unitframe.colors.power.MAELSTROM.b) --its maelstrom
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif id == 264 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					else --its a low level shaman
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
								else
									EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
								end
							else
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					end
				end
			end

			if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
				if _G["ElvNP_TargetClassPowerRunes"] and _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
					EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 7)
				elseif _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
					EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerClassPower"], "TOP", 0, 7)
				elseif _G["ElvNP_TargetClassPowerStagger"] and _G["ElvNP_TargetClassPowerStagger"]:IsShown() then
					EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerStagger"], "TOP", 0, 7)
				end
			end
			--update text position late so that it is in the correct position due to different clases/specs/forms
			EltreumPowerBarText:SetPoint("Center", EltreumPowerBar, "Center", 0, 0)

			--add effect to bar
			if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect then
				powerbareffect:Show()
				powerbareffect:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
				--powerbareffect:SetPoint("CENTER",EltreumPowerBar, "CENTER")
				powerbareffect:SetAllPoints(EltreumPowerBar:GetStatusBarTexture())
				if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
					if E.Retail then
						powerbareffect:SetModel(1715069) --better for retail, inspired by asakawa's bar model
						--powerbareffect:SetModel(1630153)
						powerbareffect:MakeCurrentCameraCustom()
						powerbareffect:SetTransform(-0.035, 0, 0, rad(270), 0, 0, 0.585)
						powerbareffect:SetPortraitZoom(1)
						powerbareffect:SetAlpha(0.4) --might do this
					else
						powerbareffect:SetModel("spells/arcanepower_state_chest.m2")
						--powerbareffect:SetModel("spells/cfx_priest_holyprecast_precastarm.m2") --sadly not on classic
						powerbareffect:SetPosition(1.2, 0, 0)
						powerbareffect:SetAlpha(0.4) --might do this
					end
				elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
					if E.Retail then
						powerbareffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
					else
						powerbareffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
					end
				end
				powerbareffect:SetInside(EltreumPowerBar:GetStatusBarTexture(), 0, 0)
				powerbareffect:SetParent(EltreumPowerBar)
			end
		else
			powerbareffect:Hide()
			EltreumPowerBar:Hide()
			EltreumPowerAnchor = nil
		end
	end
end

--update the values of nameplate power bar
function ElvUI_EltreumUI:NameplatePowerTextUpdate()
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		power = UnitPower("player")
		--ElvUI_EltreumUI:Print('power frequent')
		EltreumPowerBar:SetValue(power)
		if not power then
			return 0
		elseif power >= 1000000000000 then
			ret2 = placeValue:format(power * 0.000000000001) .. " T" -- trillion
		elseif power >= 1000000000 then
			ret2 = placeValue:format(power * 0.000000001) .. " B" -- billion
		elseif power >= 1000000 then
			ret2 = placeValue:format(power * 0.000001) .. " M" -- million
		elseif power >= 1000 then
			ret2 = placeValue:format(power * 0.001) .. "K" -- thousand
		else
			ret2 = power -- hundreds
		end

		EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.font), E.db.ElvUI_EltreumUI.nameplates.nameplatepower.fontsize, E.db.general.fontStyle)
		EltreumPowerBar.Text:SetText(ret)
		--EltreumPowerBar.Text:SetText(BreakUpLargeNumbers(power))
	end
end

--these two frames update the others
local EltruismPowerBarEventsFrame = CreateFrame("FRAME")
EltruismPowerBarEventsFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
EltruismPowerBarEventsFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismPowerBarEventsFrame:SetScript("OnEvent", function()
	ElvUI_EltreumUI:NameplatePowerTextUpdate()
	ElvUI_EltreumUI:NameplatePower()
end)

--split because text would error on removed/added
local nameplateeventframe = CreateFrame("FRAME")
nameplateeventframe:RegisterUnitEvent("NAME_PLATE_UNIT_ADDED")
nameplateeventframe:RegisterUnitEvent("NAME_PLATE_UNIT_REMOVED")
nameplateeventframe:SetScript("OnEvent", function()
	ElvUI_EltreumUI:NameplatePower()
end)

local EltruismPowerBarPredictionEventsFrame = CreateFrame("FRAME")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismPowerBarPredictionEventsFrame:SetScript("OnEvent", function()
	ElvUI_EltreumUI:PowerPrediction()
end)

--update buff/debuff position automatically
function ElvUI_EltreumUI:UpdateNPwithoutBar()
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		if E.private.ElvUI_EltreumUI.nameplatepower.adjust then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 5
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 5
			E.db["nameplates"]["units"]["ENEMY_NPC"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
			if E.Retail then
				if E.myclass == 'MONK' or E.myclass == 'ROGUE' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' or E.myclass == 'DRUID' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
				elseif E.myclass == "MAGE" and id == 62 then --62 is arcane --E.myclass== 'MAGE' or
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
				else
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				end
			elseif E.TBC or E.Classic then
				if E.myclass == 'ROGUE' or E.myclass == 'DRUID' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
				else
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				end
			elseif E.Wrath then
				if E.myclass == 'ROGUE' or E.myclass == 'DRUID' or E.myclass == 'DEATHKNIGHT' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 25
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 25
				else
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 20
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 20
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.energy then
				if E.myclass == 'MONK' or E.myclass == 'ROGUE' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.runic then
				if E.myclass == 'DEATHKNIGHT' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.mana then
				if E.Classic or E.Wrath or E.TBC then
					if E.myclass == 'MAGE' or E.myclass == 'HUNTER' or E.myclass == 'PRIEST' or E.myclass == 'SHAMAN' or E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				elseif E.Retail then
					if id == 64 or id == 63 or id == 270 or id == 256 or id == 257 or id == 264 then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					elseif id == 65 or id == 66 or id == 70 or id == 265 or id == 266 or id == 267 then --paladin specs bc of holy power and warlocks bc of soul shards
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
					end
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.focus then
				if E.Retail then
					if E.myclass == 'HUNTER' then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.fury then
				if E.myclass == 'DEMONHUNTER' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.rage then
				if E.myclass == 'WARRIOR' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.insanity then
				if E.Retail then
					if id == 258 then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
				if E.Retail then
					if id == 262 or id == 263 then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
			end
		end
	end
end
