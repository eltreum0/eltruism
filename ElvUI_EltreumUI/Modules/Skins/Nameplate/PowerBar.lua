local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _, powertype,powernumber,tablepowernumber
local _G = _G
local CreateFrame = _G.CreateFrame
local IsPlayerSpell = _G.IsPlayerSpell
local C_UnitAuras = _G.C_UnitAuras
local UnitCastingInfo = _G.UnitCastingInfo
local GetSpellPowerCost = _G.C_Spell and _G.C_Spell.GetSpellPowerCost or _G.GetSpellPowerCost
local next = _G.next
local UnitPowerMax = _G.UnitPowerMax
local UnitPower = _G.UnitPower
local UnitPowerType = _G.UnitPowerType
local UnitExists = _G.UnitExists
local UnitCanAttack = _G.UnitCanAttack
local C_NamePlate = _G.C_NamePlate
local GetShapeshiftForm = _G.GetShapeshiftForm
local stance
local CreateVector3D = _G.CreateVector3D
local UnitIsDead = _G.UnitIsDead

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
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("MIDDLE")

--setup the prediction and incoming prediction
local EltreumPowerPrediction = CreateFrame('StatusBar', "EltruismPowerBarPrediction", EltreumPowerBar)
EltreumPowerPrediction:Hide()
local EltreumPowerPredictionIncoming = CreateFrame('StatusBar', "EltruismPowerBarPredictionIncoming", EltreumPowerBar)
EltreumPowerPrediction:SetValue(0)
EltreumPowerPredictionIncoming:Hide()
EltreumPowerPredictionIncoming:SetValue(0)
local mainCost = 0
local incResource = 0
local startTime, endTime, spellID = 0, 0, 0
local spellGenerators
local druidwrath = 6
local druidstarfire = 8
local shamanhex = 0
local shamanbolt = 6
local shamanlavaburst = 8
local huntersteadyshot = 10 --now baseline
local druideclipse,costTable
local predictioncolorr, predictioncolorg, predictioncolorb
local isSetup, isSetupprediction = false, false
local maxpower = 0

--Calculate the Power Cost and draw on the Bar
function ElvUI_EltreumUI:PowerPrediction()
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		EltreumPowerPrediction:Hide() --hide at the start before events
		EltreumPowerPredictionIncoming:SetValue(0)
		EltreumPowerPredictionIncoming:Hide() --hide at the start before events
		predictioncolorr, predictioncolorg, predictioncolorb = EltreumPowerBar:GetStatusBarColor()

		if not isSetupprediction then
			EltreumPowerPrediction:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture))
			EltreumPowerPredictionIncoming:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture))
			--make them behave nicely since i had to split them
			EltreumPowerPrediction:SetReverseFill(true)
			EltreumPowerPredictionIncoming:SetReverseFill(false)
			EltreumPowerPrediction:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
			EltreumPowerPredictionIncoming:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
			isSetupprediction = true
		end

		EltreumPowerPrediction:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)
		EltreumPowerPredictionIncoming:SetStatusBarColor(predictioncolorr * 4, predictioncolorg * 4, predictioncolorb * 4, 0.7)

		if E.Retail then
			druideclipse = C_UnitAuras.GetPlayerAuraBySpellID(48517) --might be removed in dragonflight
			if IsPlayerSpell(114107) and druideclipse ~= nil then
				druidwrath = 10
				druidstarfire = 10
			end
			if IsPlayerSpell(321018) then --improved steady shot
				huntersteadyshot = 20
			end
			if IsPlayerSpell(385923) then --shaman flow of power
				shamanbolt = 8
				shamanlavaburst = 10
			end
			if IsPlayerSpell(378776) and InCombatLockdown() then --shaman inundate
				shamanhex = 8
			end
		end

		--Some of this is from Asakawa's Universal Power Bar, but mostly has been revamped and updated to current values instead of BFA values
		spellGenerators = {

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
		tablepowernumber = powernumber

		_, _, _, startTime, endTime, _, _, _, spellID = UnitCastingInfo("player")
		if startTime ~= endTime then
			costTable = GetSpellPowerCost(spellID)
			if costTable then --if nil then cost = 0
				for _, v in next, costTable do
					--costPercent, costPerSec, hasRequiredAura, type, name, cost, minCost, requiredAuraID, costPercent, costPerSec
					if v.type == powernumber then
						mainCost = v.cost
					else
						mainCost = 0
						if E.myclass == "HUNTER" then
							tablepowernumber = 123123 --random value so it doesnt match
						end
					end
				end
			else
				mainCost = 0
			end

			--because priest/shaman/druid have a secondary power AND mana they need to be checked against
			if spellGenerators[spellID] and (E.myclass == "HUNTER" and tablepowernumber == powernumber or E.myclass ~= "HUNTER") then
				incResource = spellGenerators[spellID]
				--readjust if the incoming would go over max
				if (incResource + EltreumPowerBar:GetValue()) >= UnitPowerMax("player") then
					incResource = (UnitPowerMax("player") - EltreumPowerBar:GetValue())
				elseif EltreumPowerBar:GetValue() == UnitPowerMax("player") then
					incResource = 0
				end
			else
				incResource = 0
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

--Main function
function ElvUI_EltreumUI:NameplatePower(nameplate)
	--print("nameplate power spam "..math.random(1,99))
	if not nameplate then
		EltreumPowerBar:Hide()
		powerbareffect:Hide()
		EltreumPowerAnchor = nil
	end
	if not E.private.ElvUI_EltreumUI then return end
	if not E.private.ElvUI_EltreumUI.install_version then return end
	if not E.private.ElvUI_EltreumUI.nameplatepower then return end
	if not E.db.ElvUI_EltreumUI then return end
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		if UnitExists("target") and UnitCanAttack("player", "target") and C_NamePlate.GetNamePlateForUnit("target") ~= nil and not UnitIsDead("target") then
			EltreumPowerAnchor = C_NamePlate.GetNamePlateForUnit("target")
			EltreumPowerBar:SetParent(EltreumPowerAnchor)

			if not isSetup then
				EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.font), E.db.ElvUI_EltreumUI.nameplates.nameplatepower.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				EltreumPowerBar:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey)
				S:HandleStatusBar(EltreumPowerBar)
				EltreumPowerBar.backdrop:SetBackdropColor(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.r, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.g, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.b)
				EltreumPowerBar.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.a)
				EltreumPowerBar:SetFrameStrata("MEDIUM")
				EltreumPowerPrediction:SetFrameStrata("HIGH")
				EltreumPowerPredictionIncoming:SetFrameStrata("HIGH")
				EltreumPowerPrediction:SetPoint("RIGHT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				EltreumPowerPredictionIncoming:SetPoint("LEFT", EltreumPowerBar:GetStatusBarTexture(), "RIGHT", 0, 0)
				if not E.private.nameplates.enable then -- no elvui np then the position needs to be manual
					E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition = false
				end
				if E.Retail then
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				else
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
				EltreumPowerBarText:SetPoint("Center", EltreumPowerBar, "Center", 0, 0)

				EltreumPowerBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplates.nameplatepower.texture))


				isSetup = true
			end

			--check if max power has changed, update then
			if UnitPowerMax("player") ~= maxpower then
				maxpower = UnitPowerMax("player")
				--update power prediction
				EltreumPowerPrediction:SetMinMaxValues(0, UnitPowerMax("player"))

				--update power prediction incoming
				EltreumPowerPredictionIncoming:SetMinMaxValues(0, UnitPowerMax("player"))

				--update power bar itself
				EltreumPowerBar:SetMinMaxValues(0, UnitPowerMax("player"))
			end

			powernumber, powertype = UnitPowerType("player")

			--set gradient if enabled
			if powertype then
				if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
					if not E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower then --the error on reload is because the db unloads before this apparently, so value returns as nil
						E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower = "HORIZONTAL"
					end
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepowercustom then
						EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColorsCustom(powertype, false, false))
					else
						EltreumPowerBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientationpower, ElvUI_EltreumUI:GradientColors(powertype, false, false))
					end
				end
			end

			EltreumPowerBar:SetValue(UnitPower("player")) --try to make it not be full always at the start
			EltreumPowerBar.Text:SetText(E:ShortValue(UnitPower("player")))

			--adjust position, show/hide, show colors depending on powertype if not gradient
			if E.myclass == 'PALADIN' or E.myclass == 'MAGE' or E.myclass == 'WARLOCK' or E.myclass == 'EVOKER' then
				if E.private.ElvUI_EltreumUI.nameplatepower.mana then
					EltreumPowerBar:Show()
					if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
					end
					if E.Retail then
						if E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' or E.myclass == 'EVOKER' or (E.myclass == 'MAGE' and ElvUI_EltreumUI.Spec == 62) then
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 24)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
									end
								else
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
									end
								end
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					else
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'DRUID' then
				stance = GetShapeshiftForm()
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
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							if E.Retail then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							end
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				elseif stance == 1 then --bear
					if E.private.ElvUI_EltreumUI.nameplatepower.rage then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RAGE.r, E.db.unitframe.colors.power.RAGE.g, E.db.unitframe.colors.power.RAGE.b) --its rage so color it like rage
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							if E.Retail then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							end
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				elseif stance == 2 then --cat for retail, aquatic for classic
					if E.private.ElvUI_EltreumUI.nameplatepower.energy then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							if E.Retail then
								if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
									end
								else
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
									end
								end
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							end
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				elseif stance == 3 then --travel for retail, cat for classic
					if E.Retail then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					else
						if E.private.ElvUI_EltreumUI.nameplatepower.energy then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
									end
								else
									if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 18)
									elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
										EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 19)
									end
								end
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					end
				elseif stance == 4 then
					if E.Retail then --this is where it gets tricky due to talents and specs 4 is either moonkin OR tree of life if resto and not talented into moonkin affinity
						if ElvUI_EltreumUI.Spec == 103 then --moonkin
							if E.private.ElvUI_EltreumUI.nameplatepower.astral then
								EltreumPowerBar:Show()
								if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
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
								if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
									EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
								end
								if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
								end
							end
						end
					else --and in classic, 4 is travel and 5 is moonkin/resto tree
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					end
				elseif stance == 5 or stance == 6 then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'WARRIOR' then
				if E.private.ElvUI_EltreumUI.nameplatepower.rage then
					EltreumPowerBar:Show()
					if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RAGE.r, E.db.unitframe.colors.power.RAGE.g, E.db.unitframe.colors.power.RAGE.b) --its rage so color it like rage
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						if E.Retail then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						end
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'ROGUE' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
							if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								if E.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 24)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 18)
								end
							elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								if E.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 11)
								end
							end
						else
							if _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								if E.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
								end
							elseif _G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
								if E.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
								end
							end
						end
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'MONK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.ENERGY.r, E.db.unitframe.colors.power.ENERGY.g, E.db.unitframe.colors.power.ENERGY.b) --its energy so color it like energy
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
							if (_G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown()) or (_G["ElvNP_TargetClassPowerStagger"] and _G["ElvNP_TargetClassPowerStagger"]:IsShown()) then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 24)
							elseif (_G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown()) or ((_G["ElvNP_TargetClassPowerStagger"] and not _G["ElvNP_TargetClassPowerStagger"]:IsShown())) then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
							end
						else
							if (_G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown()) or (_G["ElvNP_TargetClassPowerStagger"] and _G["ElvNP_TargetClassPowerStagger"]:IsShown()) then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
							elseif (_G["ElvNP_TargetClassPowerClassPower"] and not _G["ElvNP_TargetClassPowerClassPower"]:IsShown()) or ((_G["ElvNP_TargetClassPowerStagger"] and not _G["ElvNP_TargetClassPowerStagger"]:IsShown())) then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							end
						end
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'DEATHKNIGHT' then
				if E.private.ElvUI_EltreumUI.nameplatepower.runic then
					EltreumPowerBar:Show()
					if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.RUNIC_POWER.r, E.db.unitframe.colors.power.RUNIC_POWER.g, E.db.unitframe.colors.power.RUNIC_POWER.b) --its runic power
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
							if _G["ElvNP_TargetClassPowerRunes"] and _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 28)
							elseif _G["ElvNP_TargetClassPowerRunes"] and not _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 17)
							end
						else
							if _G["ElvNP_TargetClassPowerRunes"] and _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 27)
							elseif _G["ElvNP_TargetClassPowerRunes"] and not _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
								EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 16)
							end
						end
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'HUNTER' then
				if E.Retail then
					if E.private.ElvUI_EltreumUI.nameplatepower.focus then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.FOCUS.r, E.db.unitframe.colors.power.FOCUS.g, E.db.unitframe.colors.power.FOCUS.b) --its focus so color it like focus
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				else
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'DEMONHUNTER' then
				if E.private.ElvUI_EltreumUI.nameplatepower.fury then
					EltreumPowerBar:Show()
					if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
						EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.FURY.r, E.db.unitframe.colors.power.FURY.g, E.db.unitframe.colors.power.FURY.b) --its fury
					end
					if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
					end
				end
			elseif E.myclass == 'PRIEST' then
				if E.Retail then
					if ElvUI_EltreumUI.Spec == 258 then
						if E.private.ElvUI_EltreumUI.nameplatepower.insanity then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.INSANITY.r, E.db.unitframe.colors.power.INSANITY.g, E.db.unitframe.colors.power.INSANITY.b) --its insanity
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif ElvUI_EltreumUI.Spec == 256 or ElvUI_EltreumUI.Spec == 257 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
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
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				else
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
							EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
						end
						if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
						end
					end
				end
			elseif E.myclass == 'SHAMAN' then
				if E.Retail then
					if ElvUI_EltreumUI.Spec == 262 or ElvUI_EltreumUI.Spec == 263 then
						if E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MAELSTROM.r, E.db.unitframe.colors.power.MAELSTROM.g, E.db.unitframe.colors.power.MAELSTROM.b) --its maelstrom
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					elseif ElvUI_EltreumUI.Spec == 264 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
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
							if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
								EltreumPowerBar:SetStatusBarColor(E.db.unitframe.colors.power.MANA.r, E.db.unitframe.colors.power.MANA.g, E.db.unitframe.colors.power.MANA.b) --its mana so color like mana
							end
							if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.posy)
							end
						end
					end
				else
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						if not E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient then
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

			if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition then
				if E.db.ElvUI_EltreumUI.skins.shadow.nppower then
					if _G["ElvNP_TargetClassPowerRunes"] and _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
						EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 8)
					elseif _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
						EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerClassPower"], "TOP", 0, 8)
					elseif _G["ElvNP_TargetClassPowerStagger"] and _G["ElvNP_TargetClassPowerStagger"]:IsShown() then
						EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerStagger"], "TOP", 0, 8)
					end
				else
					if _G["ElvNP_TargetClassPowerRunes"] and _G["ElvNP_TargetClassPowerRunes"]:IsShown() then
						EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerRunes"], "TOP", 0, 7)
					elseif _G["ElvNP_TargetClassPowerClassPower"] and _G["ElvNP_TargetClassPowerClassPower"]:IsShown() then
						EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerClassPower"], "TOP", 0, 7)
					elseif _G["ElvNP_TargetClassPowerStagger"] and _G["ElvNP_TargetClassPowerStagger"]:IsShown() then
						EltreumPowerBar:SetPoint("TOP", _G["ElvNP_TargetClassPowerStagger"], "TOP", 0, 7)
					end
				end
			end

			--add effect to bar
			if E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect then
				powerbareffect:Show()
				powerbareffect:SetSize(E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizex or 133.5, E.db.ElvUI_EltreumUI.nameplates.nameplatepower.sizey or 6)
				powerbareffect:SetAllPoints(EltreumPowerBar:GetStatusBarTexture())
				if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
					if E.Retail then
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
		EltreumPowerBar:SetValue(UnitPower("player"))
		EltreumPowerBar.Text:SetText(E:ShortValue(UnitPower("player")))

		--fix if incoming would be higher than the max
		if UnitPower("player") >= UnitPowerMax("player") then
			EltreumPowerPredictionIncoming:SetValue(0)
		elseif (UnitPower("player") + EltreumPowerPredictionIncoming:GetValue()) >= UnitPowerMax("player") then
			EltreumPowerPredictionIncoming:SetValue(UnitPowerMax("player") - UnitPower("player"))
		end
	end
end

--update power itself
local EltruismPowerBarEventsFrame = CreateFrame("FRAME")
EltruismPowerBarEventsFrame:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player")
EltruismPowerBarEventsFrame:SetScript("OnEvent", function()
	if UnitExists("target") then
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
	end
end)

--update prediction
local EltruismPowerBarPredictionEventsFrame = CreateFrame("FRAME")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
EltruismPowerBarPredictionEventsFrame:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
EltruismPowerBarPredictionEventsFrame:SetScript("OnEvent", function()
	if UnitExists("target") then
		ElvUI_EltreumUI:PowerPrediction()
	end
end)

--nameplate events for classic since nameplate range is so small
if E.Classic then
	local EltruismPowerBarNameplateEventsFrame = CreateFrame("FRAME")
	EltruismPowerBarNameplateEventsFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	EltruismPowerBarNameplateEventsFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
	EltruismPowerBarNameplateEventsFrame:SetScript("OnEvent", function()
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
	if UnitExists("target") then
		ElvUI_EltreumUI:NameplatePowerTextUpdate()
		ElvUI_EltreumUI:NameplatePower()
		ElvUI_EltreumUI:PowerPrediction()
	end
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
				if E.myclass == 'MONK' or E.myclass == 'ROGUE' or E.myclass == 'DEATHKNIGHT' or E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' or E.myclass == 'DRUID' or E.myclass == 'EVOKER' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
				elseif E.myclass == "MAGE" and ElvUI_EltreumUI.Spec == 62 then --62 is arcane --E.myclass== 'MAGE' or
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
				else
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				end
			elseif E.Classic then
				if E.myclass == 'ROGUE' or E.myclass == 'DRUID' then
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
				else
					E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
					E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				end
			elseif E.Cata then
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
				if E.Classic or E.Cata then
					if E.myclass == 'MAGE' or E.myclass == 'HUNTER' or E.myclass == 'PRIEST' or E.myclass == 'SHAMAN' or E.myclass == 'PALADIN' or E.myclass == 'WARLOCK' then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				elseif E.Retail then
					if ElvUI_EltreumUI.Spec == 64 or ElvUI_EltreumUI.Spec == 63 or ElvUI_EltreumUI.Spec == 270 or ElvUI_EltreumUI.Spec == 256 or ElvUI_EltreumUI.Spec == 257 or ElvUI_EltreumUI.Spec == 264 then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					elseif ElvUI_EltreumUI.Spec == 65 or ElvUI_EltreumUI.Spec == 66 or ElvUI_EltreumUI.Spec == 70 or ElvUI_EltreumUI.Spec == 265 or ElvUI_EltreumUI.Spec == 266 or ElvUI_EltreumUI.Spec == 267 or E.myclass == 'EVOKER' then --paladin specs bc of holy power and warlocks bc of soul shards
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
					if ElvUI_EltreumUI.Spec == 258 then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
			end
			if not E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
				if E.Retail then
					if ElvUI_EltreumUI.Spec == 262 or ElvUI_EltreumUI.Spec == 263 then
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
			end
		end
	end
end
