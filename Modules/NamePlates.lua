local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local SetCVar = SetCVar
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local _G = _G
local IsInInstance = _G.IsInInstance

--customize friendly nameplate health width inside instance
--/run C_NamePlate.SetNamePlateFriendlySize(21, 5)

--[[
local myclass = E.myclass
--https://us.forums.blizzard.com/en/wow/t/custom-health-resource-bar/236455

function ElvUI_EltreumUI:NameplatePower(nameplate)
	if not nameplate then return end

	local EltreumPower = _G[nameplate:GetDebugName()..'Health']

	local f = CreateFrame("StatusBar")
	f:SetSize(150, 7)
	f:SetPoint("TOP", EltreumPower, "TOP", 0, 22)
	f:SetStatusBarTexture(E.media.normTex)
	f:SetValue(0) --try to make it not be full always at the start
	f:SetParent(EltreumPower)
	--f:Hide()   ---hide in the start
	f:SetFillStyle("STANDARD")
	--f:SetFrameLevel("MEDIUM")
	f.Text = f:CreateFontString()
	f.Text:SetTextColor(1, 1, 1)
	f.Text:SetFontObject(GameFontNormal)
	f.Text:SetPoint("CENTER")
	f.Text:SetJustifyH("CENTER")
	f.Text:SetJustifyV("CENTER")
	f.Text:Show()
	f.bg = f:CreateTexture(nil, "BACKGROUND")
	f.bg:SetTexture(E.media.normTex)
	f.bg:SetAllPoints()
	f.bg:SetVertexColor(0, 0, 0)



	function ElvUI_EltreumUI:HookElvUINameplateTarget(nameplate)
		f:Show()
		f:SetValue(0)
	end
	hooksecurefunc(NP, "SetupTarget", ElvUI_EltreumUI.HookElvUINameplateTarget)

	function ElvUI_EltreumUI:HookElvUINameplateTarget(nameplate)
		f:Show()
		f:SetValue(0)
	end
	hooksecurefunc(NP, "StyleTargetPlate", ElvUI_EltreumUI.HookElvUINameplateTarget)

	function ElvUI_EltreumUI:HookElvUINameplateTarget(nameplate)
		f:Show()
		f:SetValue(0)
	end
	hooksecurefunc(NP, "UpdateTargetPlate", ElvUI_EltreumUI.HookElvUINameplateTarget)

	function ElvUI_EltreumUI:HookElvUINameplateTarget(nameplate)
		f:Hide()
		f:SetValue(0)
	end
	hooksecurefunc(NP, "PlateFade", ElvUI_EltreumUI.HookElvUINameplateTarget)

	if myclass == 'PALADIN' or myclass == 'MAGE' or myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'SHAMAN' then
		f:SetStatusBarColor(0.49019607843137, 0.71372549019608, 1) -- COLOR THE BAR
	elseif myclass == 'WARRIOR' then
		f:SetStatusBarColor(1, 0.32156862745098, 0.32156862745098) -- COLOR THE BAR
	elseif myclass == 'HUNTER' then
		f:SetStatusBarColor(1, 0.6078431372549, 0.38039215686275) -- COLOR THE BAR
	end
	local power, powerMax
	f:RegisterEvent("UNIT_POWER_FREQUENT")
	f:RegisterEvent("UNIT_MAXPOWER")
	f:SetScript("OnEvent", function(self, event, ...)
		if event == "UNIT_POWER_FREQUENT" then -- Fired when power changes
			power = UnitPower("player")
			powerMax = UnitPowerMax("player")
			f:SetMinMaxValues(0, powerMax)
			if power == 0 then
				f:SetValue(0)
			else
				f:SetValue(power)
			end
			f.Text:SetText(power)
		elseif event == "UNIT_MAXPOWER" then -- Fired when max. power changes
			powerMax = UnitPowerMax("player")
			f:SetMinMaxValues(0, powerMax)
			f.Text:SetText(powerMax)

			power = UnitPower("player")
			if power == 0 then
				f:SetValue(0)
			else
				f:SetValue(powerMax)
			end
			f:SetMinMaxValues(0, powerMax)
		end
	end)
end
hooksecurefunc(NP, "Construct_Health", ElvUI_EltreumUI.NameplatePower)
]]--



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
