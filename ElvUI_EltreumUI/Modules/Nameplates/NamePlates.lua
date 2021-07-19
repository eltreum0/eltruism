local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local _G = _G
local IsInInstance = _G.IsInInstance
local WorldMapFrame = _G.WorldMapFrame
local string = _G.string
local hooksecurefunc = _G.hooksecurefunc
local SetCVar = _G.SetCVar
local LCG = LibStub('LibCustomGlow-1.0')

--customize friendly nameplate health width inside instance
--/run C_NamePlate.SetNamePlateFriendlySize(21, 5)

-- Different Debuffs/Buffs on nameplates
local ONUPDATE_INTERVAL = 0.1
function ElvUI_EltreumUI:PostUpdateIconDebuff(unit, button)
	if E.db.ElvUI_EltreumUI.widenameplate.enable then
		local glowcolor
		if not E.db.ElvUI_EltreumUI.glow.colorclass then
			local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolornp
			local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
			glowcolor = {r, g, b, 1}
		end
		if E.db.ElvUI_EltreumUI.glow.colorclass then
			local r, g, b = unpack(E.media.rgbvaluecolor)
			glowcolor = {r, g, b, 1}
		end
		if button and button.spellID then
			if not string.find(unit, "nameplate") then
				return
			end
			button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			button.cd:SetFrameStrata('DIALOG')
			--button.cd:SetDrawSwipe(false)  --works to erase it
			local TimeSinceLastUpdate = 0
			button.cd:SetScript('OnUpdate', function(self, elapsed)
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0
					if button.cd.timer then
						button.cd.timer.text:ClearAllPoints()
						button.cd.timer.text:Point("TOP", button.icon, "TOP", 0, 5)
						local _, g, b, _ = button.cd.timer.text:GetTextColor()
						--local r = math.random(1,10)
						--print(r)
						--print(g.." green and "..b.." blue")
						if E.db.ElvUI_EltreumUI.widenameplate.npglow then
							if g == 0 or b == 0 then
								LCG.PixelGlow_Start(button, glowcolor, 6, 0.8, 4, 2, 1, 1, false, nil)
							else
								LCG.PixelGlow_Stop(button)
							end
						end
					end
				end
			end)
			button:SetWidth(25)
			button:SetHeight(18)
			button.count:SetParent(button.cd)
			button.count:Point('BOTTOMRIGHT', 2, -3)
		end
		UF.PostUpdateAura(self, unit, button)
	end
end

function ElvUI_EltreumUI:PostUpdateIconBuff(unit, button)
	if E.db.ElvUI_EltreumUI.widenameplate.enable then
		if not E.private.ElvUI_EltreumUI.nameplatepower.adjust then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
			E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
		end
		if button and button.spellID then
			if not string.find(unit, "nameplate") then
				return
			end
			button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			local TimeSinceLastUpdate = 0
			button.cd:SetScript('OnUpdate', function(self, elapsed)
			TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0
					if button.cd.timer then
						button.cd.timer.text:ClearAllPoints()
						button.cd.timer.text:SetDrawLayer('OVERLAY',1)
						button.cd.timer.text:Point("TOP", button.icon, "TOP", 0, 5)
					end
				end
			end)
			button:SetWidth(25)
			button:SetHeight(18)
			button.count:SetParent(button.cd)
			button.count:Point('BOTTOMRIGHT', 2, -3)
		end
		UF.PostUpdateAura(self, unit, button)
	end
end

function ElvUI_EltreumUI:Construct_Auras(nameplate)
	nameplate.Buffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIconBuff
	nameplate.Debuffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIconDebuff
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
	['SHAMAN'] = "Eltreum-Class-Paladin",	 -- issues becoming green due to color mixing so color changed to paladin from "Eltreum-Class-Shaman"
	['MAGE'] = "Eltreum-Class-Paladin",		 --  issues becoming green due to color mixing so color changed to paladin from "Eltreum-Class-Mage"
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
			--SetCVar("nameplateShowFriends", 1)
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
