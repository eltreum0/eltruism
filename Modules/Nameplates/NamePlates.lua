local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local _G = _G
local IsInInstance = _G.IsInInstance
local WorldMapFrame = _G.WorldMapFrame
local string = _G.string
local hooksecurefunc = _G.hooksecurefunc
local SetCVar = _G.SetCVar

--customize friendly nameplate health width inside instance
--/run C_NamePlate.SetNamePlateFriendlySize(21, 5)

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
			if not E.private.ElvUI_EltreumUI.install_version then
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
		if not E.private.ElvUI_EltreumUI.install_version then
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
		if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" or instanceType == "none" or mapID == 1662 or mapID == 582 then
			--SetCVar("nameplateShowFriends", 1);
			SetCVar("nameplateShowOnlyNames", 1)
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

--Change classpower background, ty Benik for the great help
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
