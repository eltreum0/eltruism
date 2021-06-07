local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local SetCVar = SetCVar
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local _G = _G
local IsInInstance = _G.IsInInstance

--[[
cant parent to UIParent, need to look into https://git.tukui.org/Nihilistzsche/ElvUI_NihilistUI/-/blob/development/ElvUI_NihilistUI/modules/warlockdemons/warlockdemons.lua
ty Nihilistzsche
local EltreumPowerBar = CreateFrame("Frame", "EltreumPower", UIParent)
EltreumPowerBar.Text = EltreumPowerBar:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
EltreumPowerBar.Text:SetJustifyV("TOP")
EltreumPowerBar.Text:SetSize(0, 26)
EltreumPowerBar.Text:SetPoint("TOP", "ElvUF_Target", "BOTTOM", 0, -40)
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
EltreumPowerBar.Text:SetParent("ElvUF_Target")
EltreumPowerBar.Text:SetText("test test test test test test test test test ")
customize friendly nameplate health width inside instance
/run C_NamePlate.SetNamePlateFriendlySize(21, 5)]]--

-- need to learn more about scopes before doing this
--local function NameplatePowerTexture()
--	local texture = 'Eltreum-Blank'
--end
--hooksecurefunc(NP, 'Construct_ClassPower', NameplatePowerTexture)


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
			end
			if E.private.ElvUI_EltreumUI.install_version > "2.0.0" then
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
		end
		if E.private.ElvUI_EltreumUI.install_version > "2.0.0" then
			E.global["nameplate"]["filters"]["EltreumRare"]["actions"]["texture"]["texture"] = (rareclass[E.myclass])
		end
	end
end
