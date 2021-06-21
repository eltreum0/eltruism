local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local _G = _G
local GetShapeshiftForm = _G.GetShapeshiftForm
local UnitPower = _G.UnitPower
local GetSpecialization = _G.GetSpecialization
local GetSpecializationInfo = _G.GetSpecializationInfo
local C_NamePlate = _G.C_NamePlate
local UnitExists = _G.UnitExists
local string = _G.string
local GetNamePlates = C_NamePlate.GetNamePlates
local CreateFrame = _G.CreateFrame
local UnitPowerMax = _G.UnitPowerMax
local hooksecurefunc = _G.hooksecurefunc
local myclass = E.myclass
local id, _

--setup nameplate power frame
local EltreumPowerBar = CreateFrame("StatusBar")
EltreumPowerBar:SetValue(0)
EltreumPowerBar:SetSize(132, 6)
EltreumPowerBar:SetStatusBarTexture(E.media.normTex)
EltreumPowerBar:SetFillStyle("STANDARD")
EltreumPowerBar.Text = EltreumPowerBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, "OUTLINE")
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("CENTER")
EltreumPowerBar.bg = EltreumPowerBar:CreateTexture(nil, "BACKGROUND")
EltreumPowerBar.bg:SetTexture(E.media.normTex)
EltreumPowerBar.bg:SetSize(133, 7)
EltreumPowerBar.bg:SetVertexColor(0, 0, 0)
EltreumPowerBar:Hide() --hide at the start before events

function ElvUI_EltreumUI:GetSpec() --so that the power updates when spec changes
	if ElvUI_EltreumUI.Retail then
		local currentSpec = GetSpecialization()
		if currentSpec then
			id, _ = GetSpecializationInfo(currentSpec)
		end
	end
end

local form
function ElvUI_EltreumUI:GetDruidForm() --classic druid things ofc it can't use GetShapeshiftForm :(
	if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		for i = 1, 40 do
			local _, _, _, _, _, _, _, _, _, spellId, _, _, _, _, _ = UnitBuff("player", i)
			if spellId == 768 or spellId == 9634 or spellId == 24907 or spellId == 33891 or spellId == 783 or spellId == 1066 then
				form = spellId
			end
		end
	end
end

function ElvUI_EltreumUI:NameplatePower(nameplate, unit)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
    elseif not E.private.ElvUI_EltreumUI.nameplatepower then
    	return
    end
    if E.private.ElvUI_EltreumUI.nameplatepower.enable then
        if not nameplate then
			EltreumPowerBar:Hide()
		elseif not unit == 'player' then
			return
		end
		if unit == 'player' then
			EltreumPowerBar:RegisterEvent("UNIT_POWER_FREQUENT", "player")
			EltreumPowerBar:RegisterEvent("UNIT_DISPLAYPOWER", "player")
			EltreumPowerBar:RegisterEvent("PLAYER_TARGET_CHANGED")
			EltreumPowerBar:RegisterEvent('UPDATE_SHAPESHIFT_FORM')
		end
		local canattack = UnitCanAttack("player", "target")
		if UnitExists("target") and canattack then
			local powerMax = UnitPowerMax("player")
			EltreumPowerBar:SetMinMaxValues(0, powerMax)
			local stance = GetShapeshiftForm()
			local startpower = UnitPower("player")
			local EltreumPowerAnchor = C_NamePlate.GetNamePlateForUnit("target")
			EltreumPowerBar:SetValue(startpower) --try to make it not be full always at the start
			EltreumPowerBar:SetParent(EltreumPowerAnchor)
			EltreumPowerBar.Text:SetText(startpower)
			EltreumPowerBar.bg:SetPoint("CENTER", EltreumPowerBar, "CENTER", 0, 0)

			if myclass == 'PALADIN' or myclass == 'MAGE' or myclass == 'WARLOCK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.mana then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
					if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
					end
					if ElvUI_EltreumUI.Retail  then
						if myclass == 'PALADIN' or myclass == 'WARLOCK' then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
						elseif myclass == 'MAGE' then
							if id == 62 then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
							end
						end
					end
				end
			elseif myclass == 'WARRIOR' then
				if E.private.ElvUI_EltreumUI.nameplatepower.rage then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(0.8, 0, 0) --its rage so color it like rage
					if ElvUI_EltreumUI.Retail then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
					end
				end
			elseif myclass == 'ROGUE' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(1, 0.96862745098039, 0.53725490196078) --its energy so color it like energy
					if ElvUI_EltreumUI.Retail then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
					elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					end
				end
			elseif myclass == 'MONK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
					EltreumPowerBar:SetStatusBarColor(1, 0.96862745098039, 0.53725490196078) --its energy so color it like energy
				end
			elseif myclass == 'DEATHKNIGHT' then
				if E.private.ElvUI_EltreumUI.nameplatepower.runic then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
					EltreumPowerBar:SetStatusBarColor(0, 0.81960784313725, 1) --its runic power
				end
			elseif myclass == 'HUNTER' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
					end
				elseif ElvUI_EltreumUI.Retail then
					if E.private.ElvUI_EltreumUI.nameplatepower.focus then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(1, 0.5019607, 0.25098039) --its focus so color it like focus
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					end
				end
			elseif myclass == 'DEMONHUNTER' then
				if E.private.ElvUI_EltreumUI.nameplatepower.fury then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(0.78823529, 0.254901960784, 0.99215686) --its fury
				end
			elseif myclass == 'PRIEST' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
					end
				elseif ElvUI_EltreumUI.Retail then
					if id == 258 then
						if E.private.ElvUI_EltreumUI.nameplatepower.insanity then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(0.4, 0, 0.8) --its insanity
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						end
					elseif id == 256 or id == 257 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						end
					end
				end
			elseif myclass == 'SHAMAN' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					--ElvUI_EltreumUI:Print('Class detected classic')
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
					end
				elseif ElvUI_EltreumUI.Retail then
					--ElvUI_EltreumUI:Print('class detected retail')
					if id == 262 or id == 263 then
						--ElvUI_EltreumUI:Print('before spec setting detected')
					   	if E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
					   		--ElvUI_EltreumUI:Print('after spec setting detected')
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(0, 0.50196078431373, 1) --its maelstrom
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						end
					elseif id == 264 then
						--ElvUI_EltreumUI:Print('before spec setting detected')
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							--ElvUI_EltreumUI:Print('after spec setting detected')
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						end
					end
				end
			elseif myclass == 'DRUID' then
				if stance == 0 then --humanoid
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
					end
				elseif stance == 1 or form == 9634 then --bear
					if E.private.ElvUI_EltreumUI.nameplatepower.rage then
						EltreumPowerBar:Show()
					end
				elseif stance == 2 or form == 768 then --cat
					if E.private.ElvUI_EltreumUI.nameplatepower.energy then
						EltreumPowerBar:Show()
					end
				elseif stance == 3 or form == 24858 or form == 33891 or form == 783 or form == 1066 then --travel or for classic its moonkin and tree also
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
					end
				elseif stance == 4 or stance == 5 or stance == 6 then --moonkin maybe
					if E.private.ElvUI_EltreumUI.nameplatepower.astral then
						EltreumPowerBar:Show()
					end
				end
			end

			local power
			EltreumPowerBar:SetScript("OnEvent", function(self, event, ...)
				if event == "UNIT_POWER_FREQUENT" or event == "UNIT_DISPLAYPOWER" or event == "PLAYER_TARGET_CHANGED" or event == "UPDATE_SHAPESHIFT_FORM" then -- Fired when power changes
					power = UnitPower("player")
					--ElvUI_EltreumUI:Print('power frequent')
					EltreumPowerBar:SetValue(power)
					EltreumPowerBar.Text:SetText(power)
					if myclass == 'DRUID' then
						if stance == 0 then --humanoid
							if E.private.ElvUI_EltreumUI.nameplatepower.mana then
								EltreumPowerBar:Show()
								EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
								if ElvUI_EltreumUI.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
								end
							end
						elseif stance == 1 or form == 9634 then --bear
							if E.private.ElvUI_EltreumUI.nameplatepower.rage then
								EltreumPowerBar:SetStatusBarColor(0.8, 0, 0) --its rage so color it like rage
								if ElvUI_EltreumUI.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
								end
							end
						elseif stance == 2 or form == 768 then --cat
							if E.private.ElvUI_EltreumUI.nameplatepower.energy then
								EltreumPowerBar:SetStatusBarColor(1, 0.96862745098039, 0.53725490196078) --its energy so color it like energy
								if ElvUI_EltreumUI.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
								elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								end
							end
						elseif stance == 3 or form == 24858 or form == 33891 or form == 783 or form == 1066 then --travel or for classic its moonkin and tree also
							if E.private.ElvUI_EltreumUI.nameplatepower.mana then
								EltreumPowerBar:SetStatusBarColor(0.309803921, 0.450980392, 0.631372549) --its mana so color like mana
								if ElvUI_EltreumUI.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
								end
							end
						elseif stance == 4 or stance == 5 or stance == 6 then --moonkin maybe
							if E.private.ElvUI_EltreumUI.nameplatepower.astral then
								EltreumPowerBar:SetStatusBarColor(0.30196078431373, 0.52156862745098, 0.90196078431373) --its astral power
								if ElvUI_EltreumUI.Retail then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
								end
							end
						end
					end
				end
			end)
		else
			EltreumPowerBar:Hide()
		end
	end
end
hooksecurefunc(NP, 'Style', ElvUI_EltreumUI.NameplatePower)
hooksecurefunc(NP, 'UpdatePlate', ElvUI_EltreumUI.NameplatePower)
hooksecurefunc(NP, 'NamePlateCallBack', ElvUI_EltreumUI.NameplatePower)

function ElvUI_EltreumUI:UpdateNPwithoutBar(addon)
	if addon == 'ElvUI' then
		if E.private.ElvUI_EltreumUI.nameplatepower.adjust then
			if ElvUI_EltreumUI.Retail then
				local currentSpec = GetSpecialization()
				if currentSpec then
					id, _ = GetSpecializationInfo(currentSpec)
				end
			end
			if E.private.ElvUI_EltreumUI.nameplatepower.enable then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				if ElvUI_EltreumUI.Retail then
					if myclass == 'MONK' or myclass == 'ROGUE' or myclass == 'DEATHKNIGHT' or myclass == 'PALADIN' or id == 103 or myclass == 'WARLOCK' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
					end
				elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
					if myclass == 'ROGUE'  or myclass == 'DRUID' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.energy then
					if myclass == 'MONK' or myclass == 'ROGUE' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
					end
					if ElvUI_EltreumUI.Retail then
						if id == 103 then -- feral
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
						end
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.runic then
					if myclass == 'DEATHKNIGHT' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.mana then
					if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
						if myclass == 'MAGE' or myclass == 'HUNTER' or myclass == 'PRIEST' or myclass == 'SHAMAN' or myclass == 'PALADIN' or myclass == 'WARLOCK' then
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
					if ElvUI_EltreumUI.Retail then
						if id == 64 or id == 105 or id == 63 or id == 270 or id == 256 or id == 257 or id == 264 then
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						elseif id == 65 or id == 66 or id == 70 or id == 265 or id == 266 or id == 267 then --paladin specs bc of holy power and warlocks bc of soul shards
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
						end
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.focus then
					if myclass == 'HUNTER' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.astral then
					if id == 102 then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.fury then
					if myclass == 'DEMONHUNTER' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.rage then
					if myclass == 'WARRIOR' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
					if ElvUI_EltreumUI.Retail then
						if id == 104 then  --guardian
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.insanity then
					if ElvUI_EltreumUI.Retail then
						if id == 258 then
						   	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
					if ElvUI_EltreumUI.Retail then
						if id == 262 or id == 263 then
						   	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
				end
			else
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
			end
		end
	end
end
