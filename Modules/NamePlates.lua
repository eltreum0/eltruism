local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local _G = _G
local IsInInstance = _G.IsInInstance
local myclass = E.myclass
local C_NamePlate = _G.C_NamePlate
local UnitExists = _G.UnitExists
local WorldMapFrame = _G.WorldMapFrame
local string = _G.string
local GetNamePlates = C_NamePlate.GetNamePlates
local CreateFrame = _G.CreateFrame
local GetShapeshiftForm = _G.GetShapeshiftForm
local UnitPower = _G.UnitPower
local UnitReaction = _G.UnitReaction
local GetSpecialization = _G.GetSpecialization
local GetSpecializationInfo = _G.GetSpecializationInfo
local UnitPowerMax = _G.UnitPowerMax
local hooksecurefunc = _G.hooksecurefunc
local SetCVar = _G.SetCVar
--customize friendly nameplate health width inside instance
--/run C_NamePlate.SetNamePlateFriendlySize(21, 5)

--setup nameplate power frame
local EltreumPowerBar = CreateFrame("StatusBar")
EltreumPowerBar:SetValue(0)
EltreumPowerBar:SetSize(132, 6)
EltreumPowerBar:SetStatusBarTexture(E.media.normTex)
EltreumPowerBar:SetFillStyle("STANDARD")
EltreumPowerBar.Text = EltreumPowerBar:CreateFontString(nil, "MEDIUM", "GameFontNormal")
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, "OUTLINE")
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("CENTER")
EltreumPowerBar.bg = EltreumPowerBar:CreateTexture(nil, "BACKGROUND")
EltreumPowerBar.bg:SetTexture(E.media.normTex)
EltreumPowerBar.bg:SetSize(133, 7)
EltreumPowerBar.bg:SetVertexColor(0, 0, 0)
local powerMax = UnitPowerMax("player")
EltreumPowerBar:Hide() --hide at the start before events

function ElvUI_EltreumUI:NameplatePower(nameplate, unit)
	if E.private.ElvUI_EltreumUI.nameplatepower.enable then
		if not nameplate then
			--ElvUI_EltreumUI:Print('not nameplate')
			return
		elseif not unit == 'player' then
			--ElvUI_EltreumUI:Print(' not player')
			return
		end
		if unit == 'player' then
			ElvUI_EltreumUI:RegisterEvent('UNIT_TARGET', 'NameplatePower')
			EltreumPowerBar:RegisterEvent("UNIT_POWER_FREQUENT")
			EltreumPowerBar:RegisterEvent("PLAYER_TARGET_CHANGED")
			EltreumPowerBar:RegisterEvent("UNIT_DISPLAYPOWER")
			--ElvUI_EltreumUI:Print('register UNIT_TARGET')
		end
		local reaction = UnitReaction("player", 'target')
		if reaction == nil then
			EltreumPowerBar:Hide()
		end
		if reaction == 1 or reaction == 2 or reaction == 3 or reaction == 4 then
			EltreumPowerBar:SetMinMaxValues(0, powerMax)
			local stance = GetShapeshiftForm()
			local startpower = UnitPower("player")
			local EltreumPowerAnchor = C_NamePlate.GetNamePlateForUnit("target")
			EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
			EltreumPowerBar:SetValue(startpower) --try to make it not be full always at the start
			EltreumPowerBar:SetParent(EltreumPowerAnchor)
			EltreumPowerBar.Text:SetText(startpower)
			EltreumPowerBar.bg:SetPoint("CENTER", EltreumPowerBar, "CENTER", 0, 0)
			if myclass == 'PALADIN' or myclass == 'MAGE'  then
				if E.private.ElvUI_EltreumUI.nameplatepower.mana then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
				end
			elseif myclass == 'DRUID' then
				if stance == 0 then --humanoid
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
					end
				elseif stance == 1 then --bear
					if E.private.ElvUI_EltreumUI.nameplatepower.rage then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(1, 0.32156862745098, 0.32156862745098) --its rage so color it like rage
					end
				elseif stance == 2 then --cat
					if E.private.ElvUI_EltreumUI.nameplatepower.energy then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(1, 0.96862745098039, 0.53725490196078) --its energy so color it like energy
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
					end
				elseif stance == 3 then --travel
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
					end
				elseif stance == 4 or stance == 5 or stance == 6 then --moonkin maybe
					if E.private.ElvUI_EltreumUI.nameplatepower.astral then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.30196078431373, 0.52156862745098, 0.90196078431373) --its astral power maybe so astral power color
					end
				end
			elseif myclass == 'WARRIOR' then
				if E.private.ElvUI_EltreumUI.nameplatepower.rage then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(1, 0.32156862745098, 0.32156862745098) --its rage so color it like rage
				end
			elseif myclass == 'ROGUE' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					EltreumPowerBar:SetStatusBarColor(1, 0.96862745098039, 0.53725490196078) --its energy so color it like energy
				end
			elseif myclass == 'DEATHKNIGHT' then
				if E.private.ElvUI_EltreumUI.nameplatepower.runic then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(0, 0.81960784313725, 1) --its runic power
				end
			elseif myclass == 'HUNTER' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
					end
				elseif ElvUI_EltreumUI.Retail then
					if E.private.ElvUI_EltreumUI.nameplatepower.focus then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(1, 0.6078431372549, 0.38039215686275) --its focus so color it like focus
					end
				end
			elseif myclass == 'DEMONHUNTER' then
				if E.private.ElvUI_EltreumUI.nameplatepower.fury then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(1, 0.55686274509804, 0.17254901960784) --its fury
				end
			elseif myclass == 'PRIEST' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
					end
				elseif ElvUI_EltreumUI.Retail then
					local currentSpec = GetSpecialization()
					local _, currentSpecName
					if currentSpec then
						_, currentSpecName = GetSpecializationInfo(currentSpec)
						if currentSpecName == 'Shadow' then
							if E.private.ElvUI_EltreumUI.nameplatepower.insanity then
								EltreumPowerBar:Show()
								EltreumPowerBar:SetStatusBarColor(0.79607843137255, 0.20392156862745, 1) --its insanity
							end
						end
					else
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
						end
					end
				end
			elseif myclass == 'SHAMAN' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
					end
				elseif ElvUI_EltreumUI.Retail then
					local currentSpec = GetSpecialization()
					local _, currentSpecName
					if currentSpec then
						_, currentSpecName = GetSpecializationInfo(currentSpec)
						if currentSpecName == 'Enhancement' or currentSpecName == 'Elemental' then
						   	if E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
								EltreumPowerBar:Show()
								EltreumPowerBar:SetStatusBarColor(0, 0.50196078431373, 1) --its maelstrom
							end
						end
					else
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) --its mana so color like mana
						end
					end
				end
			end
			local power
			EltreumPowerBar:SetScript("OnEvent", function(self, event, ...)
				if event == "UNIT_POWER_FREQUENT" or event == "UNIT_DISPLAYPOWER" then -- Fired when power changes
					power = UnitPower("player")
					--ElvUI_EltreumUI:Print('power frequent')
					EltreumPowerBar:SetValue(power)
					EltreumPowerBar.Text:SetText(power)
				end
			end)
		end
	end
end
hooksecurefunc(NP, 'Style', ElvUI_EltreumUI.NameplatePower)
hooksecurefunc(NP, 'UpdatePlate', ElvUI_EltreumUI.NameplatePower)
hooksecurefunc(NP, 'NamePlateCallBack', ElvUI_EltreumUI.NameplatePower)

function ElvUI_EltreumUI:UpdateNPwithoutBar(addon)
	if addon == 'ElvUI' then
		if E.private.ElvUI_EltreumUI.nameplatepower.enable then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17

		else
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
			E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
		end
	end
end

-- Non aspect ratio nameplate debuffs similar to plater
function ElvUI_EltreumUI:PostUpdateIcon(unit, button)
	if E.db.ElvUI_EltreumUI.widenameplate.enable then
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
		if button and button.spellID then
			if not string.find(unit, "nameplate") then
				return
			end
			-- this is the worst number of /reload of all time for me
			button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			button:SetWidth(25)
			button:SetHeight(18)
			button.count:Point('BOTTOMRIGHT', 2, -3)
		end
		UF:PostUpdateAura(unit, button)
	else
		E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 43
		E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 43
	end
end

function ElvUI_EltreumUI:Construct_Auras(nameplate)
	nameplate.Buffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIcon
	nameplate.Debuffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIcon
end
hooksecurefunc(NP, "Construct_Auras", ElvUI_EltreumUI.Construct_Auras)

--for general nameplates
local playerclass = {
    ['WARRIOR'] = "Eltreum-Class-Warrior",
    ['PALADIN'] = "Eltreum-Class-Paladin",
    ['HUNTER'] = "Eltreum-Class-Hunter",
    ['ROGUE'] = "Eltreum-Class-Rogue",
    ['PRIEST'] = "Eltreum-Class-Priest",
    ['DEATHKNIGHT'] = "Eltreum-Class-DeathKnight",
    ['SHAMAN'] = "Eltreum-Class-Druid",     -- issues becoming green due to color mixing so color changed to druid from "Eltreum-Class-Shaman"
    ['MAGE'] = "Eltreum-Class-Druid",         --  issues becoming green due to color mixing so color changed to druid from "Eltreum-Class-Mage"
    ['WARLOCK'] = "Eltreum-Class-Warlock",
    ['MONK'] = "Eltreum-Class-Monk",
    ['DRUID'] = "Eltreum-Class-Druid",
    ['DEMONHUNTER'] = "Eltreum-Class-DemonHunter",
}
-- for rare nameplates
local rareclass = {
    ['WARRIOR'] = "Eltreum-Class-Warrior",
    ['PALADIN'] = "Eltreum-Class-Paladin",
    ['HUNTER'] = "Eltreum-Class-Hunter",
    ['ROGUE'] = "Eltreum-Class-Rogue",
    ['PRIEST'] = "Eltreum-Class-Priest",
    ['DEATHKNIGHT'] = "Eltreum-Class-DeathKnight",
    ['SHAMAN'] = "Eltreum-Class-Shaman",
    ['MAGE'] = "Eltreum-Class-Mage",
    ['WARLOCK'] = "Eltreum-Class-Warlock",
    ['MONK'] = "Eltreum-Class-Monk",
    ['DRUID'] = "Eltreum-Class-Druid",
    ['DEMONHUNTER'] = "Eltreum-Class-DemonHunter",
}

-- Nameplate options for Border and Glow and Texture
function ElvUI_EltreumUI:NamePlateOptions()
	local nameplateclasscolors
	nameplateclasscolors = E:ClassColor(E.myclass, true)
	if E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow then
		E.db["nameplates"]["colors"]["glowColor"]["b"] = nameplateclasscolors.b
		E.db["nameplates"]["colors"]["glowColor"]["r"] = nameplateclasscolors.r
		E.db["nameplates"]["colors"]["glowColor"]["g"] = nameplateclasscolors.g
	end
	if E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate then
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = true
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			if E.private.ElvUI_EltreumUI.install_version == nil then
				return
			elseif E.private.ElvUI_EltreumUI.install_version > "2.0.0" then
				E.global["nameplate"]["filters"]["EltreumRare"]["actions"]["color"]["border"] = true
				E.global["nameplate"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
				E.global["nameplate"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
				E.global["nameplate"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			end
	end
	if E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture then
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = (playerclass[E.myclass])
		if E.private.ElvUI_EltreumUI.install_version == nil then
			return
		elseif E.private.ElvUI_EltreumUI.install_version > "2.0.0" then
			E.global["nameplate"]["filters"]["EltreumRare"]["actions"]["texture"]["texture"] = (rareclass[E.myclass])
		end
	end
end

function ElvUI_EltreumUI:ClassicThreatNP()
	if E.private["nameplates"]["enable"] == true then
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Kimberley"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontOutline"] = "OUTLINE"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["enable"] = true
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["parent"] = "Health"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontSize"] = 10
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["format"] = "[threat:percent]"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["position"] = "CENTER"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["yOffset"] = 0
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["xOffset"] = -55
		end
	end
end

--- Friendly Nameplate Control
function ElvUI_EltreumUI:FriendlyNameplates()
	local _, instanceType = IsInInstance()
	local mapID = WorldMapFrame:GetMapID()
	if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames then
		if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" then
			--SetCVar("nameplateShowFriends", 1);
			SetCVar("nameplateShowOnlyNames", 1)
		end
		if instanceType == "none" or mapID == 1662 then
			--SetCVar("nameplateShowFriends", 1);
			SetCVar("nameplateShowOnlyNames", 1)
		end
		if mapID == 582 then
			SetCVar("nameplateShowFriends", 1)
		end
	end
	if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly then
		if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" then
			SetCVar("nameplateShowFriends", 0)
		end
		if instanceType == "none" or mapID == 1662 then
			SetCVar("nameplateShowFriends", 1)
		end
	end
	if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly then
		SetCVar("nameplateShowFriends", 0)
	end
end

-- Change classpower background, ty Benik for the great help
local function ClassPowerColor()
    NP.multiplier = 0
end
hooksecurefunc(NP, 'Initialize', ClassPowerColor)

if ElvUI_EltreumUI.Retail then
	local function RuneBackground()
		NP.multiplier = 0
	end
	hooksecurefunc(NP, 'Construct_Runes', RuneBackground)
end
