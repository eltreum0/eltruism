local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded

local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	print('|c4682B4ffEltruism|r: '..msg)
end

-- general alliance walk (legion) maybe human music idk
--/script PlaySoundFile(1417250, "Dialog", true)

-- Attempt at non aspect ratio nameplate debuffs similar to plater
function ElvUI_EltreumUI:PostUpdateIcon(unit, button)
	if E.private.ElvUI_EltreumUI.widenameplate.enable then
		if button and button.spellID then
			if not string.find(unit, "nameplate") then
				return
			end
			local width =  25
			local height =  18
			-- this is the worst number of /reload of all time for me
			button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			button:SetWidth(25)
			button:SetHeight(18)
			button.count:Point('BOTTOMRIGHT', 0, -3)
		end
		UF:PostUpdateAura(unit, button)
	end
end

function ElvUI_EltreumUI:Construct_Auras(nameplate)
	nameplate.Buffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIcon
	nameplate.Debuffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIcon
end
hooksecurefunc(NP, "Construct_Auras", ElvUI_EltreumUI.Construct_Auras)

-- Role icons, ty a lot Darth Predator for the help!
local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)
SLE.rolePaths["Eltruism"] = {
	TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga",
	HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga",
	DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga"
}

-- Change classpower background, ty Benik for the great help
local function ClassPowerColor()
    NP.multiplier = 0
end
hooksecurefunc(NP, 'Initialize', ClassPowerColor)

--Conversion of Time to Arrive weakaura
--Create the frame to display the text
local WaypointTimeToArriveFrame = CreateFrame("Frame", "WaypointTimeToArriveText", UIParent)
WaypointTimeToArriveFrame.TimeText = WaypointTimeToArriveFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
WaypointTimeToArriveFrame.TimeText:SetJustifyV("TOP")
WaypointTimeToArriveFrame.TimeText:SetSize(0, 26)
WaypointTimeToArriveFrame.TimeText:SetPoint("TOP", "SuperTrackedFrame", "BOTTOM", 0, -40)
WaypointTimeToArriveFrame.TimeText:SetTextColor(1, 1, 1)
WaypointTimeToArriveFrame.TimeText:SetFont("Interface\\addons\\ElvUI_EltreumUI\\Media\\Fonts\\Kimberley.otf", 12)
WaypointTimeToArriveFrame.TimeText:SetParent("SuperTrackedFrame")
--Create the function which calculates the time
function ElvUI_EltreumUI:WaypointTimeToArrive()
	if E.private.ElvUI_EltreumUI.waypointetasetting.enable then
	local speed = GetUnitSpeed("player")
	local distance = C_Navigation.GetDistance()
	local seconds = 0
	local minutes = 0
		if speed > 0 then
			local eta= math.abs(distance / speed)
			if eta > 600 then
				minutes = string.format("%02.f", math.floor(eta/60 ));
				seconds = string.format("%02.f", math.floor(eta - minutes *60));
				else if eta < 600 and eta > 10 then
					minutes = string.format("%01.f", math.floor(eta/60));
					seconds = string.format("%02.f", math.floor(eta - minutes *60));
					else if eta < 10 then
						minutes = string.format("%01.f", math.floor(eta/60));
						seconds = string.format("%1.d", math.floor(eta - minutes *60));
						else
						minutes = string.format("%02.f", math.floor(eta/60));
						seconds = string.format("%02.f", math.floor(eta - minutes *60));
					end
				end
			end
		end
		if  minutes == 0 and seconds == 0 then
			WaypointTimeToArriveFrame.TimeText:SetText("***")
		else if minutes < "01" and seconds > "0" then
			WaypointTimeToArriveFrame.TimeText:SetText(seconds.."s")
			else
			WaypointTimeToArriveFrame.TimeText:SetText(minutes.."m"..":"..seconds.."s")
			end
		end
	end
end
-- Partial Function to update the frame from dekallo
local function OnUpdateTimer(self, elapsed)
		ElvUI_EltreumUI:WaypointTimeToArrive(self, elapsed)
end
WaypointTimeToArriveFrame:SetScript("OnUpdate", OnUpdateTimer)

--- Friendly Nameplate Control
function ElvUI_EltreumUI:FriendlyNameplates()
	if E.private.ElvUI_EltreumUI.friendlynameplatetoggle.enable then
		local inInstance, instanceType = IsInInstance()
		if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" then
		--E:SetupCVars(noDisplayMsg)
			SetCVar("nameplateShowFriends", 0)
		end
		if instanceType == "none" then
		--E:SetupCVars(noDisplayMsg)
			SetCVar("nameplateShowFriends", 1)
		end
	end
end

-- AFK racial music
local soundHandle
function ElvUI_EltreumUI:RacialAFKmusic()
	if E.private.ElvUI_EltreumUI.afkmusic.enable then
		local _ , race, _ = UnitRace("player")
		if UnitIsAFK("player") then
			if race == "Human" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(53210, "Dialog")
			end
			if race == "Gnome" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(369055, "Dialog")
			end
			if race == "NightElf" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(441709, "Dialog")
			end
			if race == "KulTiran" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(1781897, "Dialog")
			end
			if race == "Dwarf" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(298910, "Dialog")
			end
			if race == "Draenei" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(53284, "Dialog")
			end
			if race == "Worgen" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(441525, "Dialog")
			end
			if race == "VoidElf" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(1864282, "Dialog")
			end
			if race == "LightforgedDraenei" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(1864285, "Dialog")
			end
			if race == "DarkIronDwarf" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(441566, "Dialog")
			end
			if race == "Mechagnome" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(3028751, "Dialog")
			end
			if race == "Orc" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(441713, "Dialog")
			end
			if race == "Undead" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(53217, "Dialog")
			end
			if race == "Tauren" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(441788, "Dialog")
			end
			if race == "Troll" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(371378, "Dialog")
			end
			if race == "Goblin" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(441627, "Dialog")
			end
			if race == "BloodElf" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(53473, "Dialog")
			end
			if race == "Pandaren" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(642246, "Dialog")
			end
			if race == "Nightborne" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(1477339, "Dialog")
			end
			if race == "HighmountainTauren" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(1417319, "Dialog")
			end
			if race == "ZandalariTroll" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(2844635, "Dialog")
			end
			if race == "Vulpera" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(3260632, "Dialog")
			end
			if race == "MagharOrc" then
					SetCVar("Sound_EnableMusic", 0)
					_, soundHandle = PlaySoundFile(2146630, "Dialog")
			end
		end
		--stop music when not afk
		if not UnitIsAFK("player") then
			if soundHandle then
			StopSound(soundHandle, 500)
			SetCVar("Sound_EnableMusic", 1)
			end
		end
	end
end

--Simpy:
--it would be far more efficient if you managed the group list table outside
--of the combat calling function (using GROUP_ROSTER_UPDATE),
--emptied it when you aren't in a group,
--and only looked for names on that list when the combat event fires

-- Conversion of the party/raid death weakaura into an addon option
function ElvUI_EltreumUI:RaidDeath()
	if E.private.ElvUI_EltreumUI.partyraiddeath.enable then
		local _, eventType, _, _, _, _, _, _, destName, _, _ = CombatLogGetCurrentEventInfo()
		local name = name
		if eventType == "UNIT_DIED" then
			if IsInGroup() then
				for ii=1, GetNumGroupMembers() do
					name = GetRaidRosterInfo(ii)
				end
				if destName == name then
					if E.private.ElvUI_EltreumUI.partyraiddeath.bruh then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\bruh.mp3", "Master");
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.mp3", "Master");
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.shame then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\shame.mp3", "Master");
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.wow then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wow.mp3", "Master");
					end
				end
			end
		end
	end
end

-- Create Stealth Overlay Frame
local StealthOptionsFrame = CreateFrame("Frame", "StealthOverlay", E.UIParent)
StealthOptionsFrame:Point("TOPLEFT")
StealthOptionsFrame:Point("BOTTOMRIGHT")
StealthOptionsFrame:SetFrameLevel(0)
StealthOptionsFrame:SetFrameStrata("BACKGROUND")
-- Texture from Shadowmeld, public domain
StealthOptionsFrame.tex = StealthOptionsFrame:CreateTexture()
StealthOptionsFrame.tex:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\StealthOverlay.tga")
StealthOptionsFrame.tex:SetAllPoints(frame)
-- set to hide so it doesnt show on characters that dont have stealth
StealthOptionsFrame:Hide()
-- Stealth Overlay Options
function ElvUI_EltreumUI:StealthOptions()
	if E.private.ElvUI_EltreumUI.stealthOptions.stealtheffect then
		--Script the frame, ty wowpedia for examples
		StealthOptionsFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
		StealthOptionsFrame:RegisterEvent("UPDATE_STEALTH");
		StealthOptionsFrame:HookScript("OnEvent", function(__, event)
		  if (event == "PLAYER_ENTERING_WORLD") then
			if IsStealthed() then
				StealthOptionsFrame:Show();
			end
		  elseif (event == "UPDATE_STEALTH") then
			if IsStealthed() then
				UIFrameFadeIn(StealthOptionsFrame, 0.125, 0, 1);
			else
				UIFrameFadeOut(StealthOptionsFrame, 0.1, 1, 0);
			end
		  end
		end);
	end
end

-- Nameplate options for Border and Glow
function ElvUI_EltreumUI:NamePlateOptions()
	local nameplateclasscolors
	nameplateclasscolors = E:ClassColor(E.myclass, true)
	if E.private.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow then
		E.db["nameplates"]["colors"]["glowColor"]["b"] = nameplateclasscolors.b
		E.db["nameplates"]["colors"]["glowColor"]["r"] = nameplateclasscolors.r
		E.db["nameplates"]["colors"]["glowColor"]["g"] = nameplateclasscolors.g
	end
	if E.private.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate then
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
		E.global["nameplate"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = true
	end
end

-- Skill Glow
local LCG = LibStub('LibCustomGlow-1.0')
function ElvUI_EltreumUI:SkillGlow()
	local r, g, b = unpack(E.media.rgbvaluecolor)
	local skillglowcolor = {r, g, b, 1}
	local customglow = LibStub("LibButtonGlow-1.0")
	if E.private.ElvUI_EltreumUI.glow.enable then
		if E.private.ElvUI_EltreumUI.glow.pixel then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
					----PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
					LCG.PixelGlow_Start(button, skillglowcolor, 9, 1, 3, 5, 5, 5, false, nil, high)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.PixelGlow_Stop(button)
			end
		end
		if E.private.ElvUI_EltreumUI.glow.autocast then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
					----AutoCastGlow_Start(frame[, color[, N[, frequency[, scale[, xOffset[, yOffset[, key]]]]]]])
					----N - number of particle groups. Each group contains 4 particles. Defaul value is 4;
					LCG.AutoCastGlow_Start(button, skillglowcolor, 8, 0.8, 2, 5, 5)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.AutoCastGlow_Stop(button)
			end
		end
		if E.private.ElvUI_EltreumUI.glow.blizzard then
			function customglow.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					local actionType, actionID = GetActionInfo(button:GetAttribute("action"))
					----ButtonGlow_Start(frame[, color[, frequency]]])
					LCG.ButtonGlow_Start(button, skillglowcolor, 0.5)
				end
			end
			function customglow.HideOverlayGlow(button)
				LCG.ButtonGlow_Stop(button)
			end
		end
	end
end

-- AddOnSkins Profile
function ElvUI_EltreumUI:AddonSetupAS()
	if IsAddOnLoaded('AddOnSkins') then
		ElvUI_EltreumUI:GetASProfile()
		ElvUI_EltreumUI:Print('AddOnSkins profile has been set.')
	end
end
-- Immersion Profile
function ElvUI_EltreumUI:AddonSetupImmersion()
	if IsAddOnLoaded('Immersion') then
		ElvUI_EltreumUI:GetImmersionProfile()
		ElvUI_EltreumUI:Print('Immersion profile has been set.')
	end
end
-- BigWigs Profile
function ElvUI_EltreumUI:AddonSetupBW()
	if IsAddOnLoaded('BigWigs') then
		ElvUI_EltreumUI:GetBigWigsProfile()
		ElvUI_EltreumUI:Print('BigWigs profile has been set.')
	end
end
-- DBM Profile
function ElvUI_EltreumUI:AddonSetupDBM()
	if IsAddOnLoaded('DBM-Core') then
		ElvUI_EltreumUI:GetDBMProfile()
		ElvUI_EltreumUI:Print('DBM profile has been set.')
	end
end
-- Details Profile
function ElvUI_EltreumUI:AddonSetupDT()
	if IsAddOnLoaded('Details') then
		ElvUI_EltreumUI:GetDetailsProfile()
		ElvUI_EltreumUI:Print('Details profile has been set.')
	end
end
-- DynamicCam Profile
function ElvUI_EltreumUI:AddonSetupDynamicCam()
	if IsAddOnLoaded('DynamicCam') then
		ElvUI_EltreumUI:GetDynamicCamProfile()
		ElvUI_EltreumUI:Print('Dynamic Cam profile has been set.')
	end
end
-- GladiusEx Profile
function ElvUI_EltreumUI:AddonSetupGladiusEx()
	if IsAddOnLoaded('GladiusEx') then
		ElvUI_EltreumUI:GetGladiusExProfile()
		ElvUI_EltreumUI:Print('GladiusEx profile has been set.')
	end
end
-- EXRT Profile
function ElvUI_EltreumUI:AddonSetupExRT()
	if IsAddOnLoaded('ExRT') then
		ElvUI_EltreumUI:GetExRTProfile()
		ElvUI_EltreumUI:Print('Exorsus Raid Tools profile has been set.')
	end
end
-- ProjectAzilroka Profile
function ElvUI_EltreumUI:AddonSetupPA()
	if IsAddOnLoaded('ProjectAzilroka') then
		ElvUI_EltreumUI:GetPAProfile()
		ElvUI_EltreumUI:Print('ProjectAzilroka profile has been set.')
	end
end
-- NameplateSCT Profile
function ElvUI_EltreumUI:AddonSetupNameplateSCT()
	if IsAddOnLoaded('NameplateSCT') then
		ElvUI_EltreumUI:GetNameplateSCTProfile()
		ElvUI_EltreumUI:Print('NameplateSCT profile has been set.')
	end
end
-- FCT Profile
function ElvUI_EltreumUI:AddonSetupFCT()
	if IsAddOnLoaded('ElvUI_FCT') then
		ElvUI_EltreumUI:GetFCTProfile()
		ElvUI_EltreumUI:Print('Floating Combat Text profile has been set.')
	end
end
-- CVars General
function ElvUI_EltreumUI:SetupCVars()
	-- ElvUI CVars
	E:SetupCVars(noDisplayMsg)
	SetCVar('nameplateOccludedAlphaMult', 0)
	SetCVar('cameraDistanceMaxZoomFactor', 2.6)
	SetCVar('autoLootDefault', true)
	SetCVar('autoQuestWatch', 1)
	SetCVar('nameplateShowFriendlyMinions', 0)
	SetCVar('removeChatDelay', 1)
	SetCVar('nameplateMinAlpha',1)
	SetCVar('nameplateLargerScale', 1.2)
	SetCVar('nameplateMaxDistance', 60)
	SetCVar('nameplateMinScale', 1)
	SetCVar('nameplateMotion', 1)
	SetCVar('nameplateOccludedAlphaMult', 0)
	SetCVar('nameplateOverlapH', 0.8)
	SetCVar('nameplateOverlapV', 1.1)
	SetCVar('nameplateSelectedScale', 1)
	SetCVar('nameplateSelfAlpha', 1)
	SetCVar('nameplateOtherBottomInset', 0.01)
	SetCVar('UnitNameEnemyGuardianName', 0)
	SetCVar('UnitNameEnemyMinionName', 0)
	SetCVar('UnitNameEnemyPetName', 0)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyTotem', 1)

	ElvUI_EltreumUI:Print('CVars have been set.')
end
-- CVars NamePlates
function ElvUI_EltreumUI:NameplateCVars()
	SetCVar('UnitNameEnemyPlayerName', 1)
	ElvUI_EltreumUI:Print('NamePlate CVars have been set.')
end
-- Private DB
function ElvUI_EltreumUI:SetupPrivate()
	-- ElvUI Private DB
	E.private["general"]["chatBubbleFont"] = "Kimberley"
	E.private["general"]["chatBubbleFontOutline"] = "OUTLINE"
	E.private["general"]["chatBubbleFontSize"] = 10
	E.private["general"]["chatBubbleName"] = true
	E.private["general"]["dmgfont"] = "Kimberley"
	E.private["general"]["glossTex"] = "Eltreum-Blank"
	E.private["general"]["namefont"] = "Kimberley"
	E.private["general"]["normTex"] = "Eltreum-Blank"
	E.private["install_complete"] = "12.24"
	E.private["skins"]["parchmentRemoverEnable"] = true
end
-- Global DB
function ElvUI_EltreumUI:SetupGlobal()
	-- ElvUI Global DB
	E.global["general"]["WorldMapCoordinates"]["position"] = "TOPLEFT"
	E.global["general"]["commandBarSetting"] = "DISABLED"
	E.global["general"]["fadeMapDuration"] = 0.1
	E.global["general"]["mapAlphaWhenMoving"] = 0.35
	E.global["general"]["smallerWorldMap"] = false
	E.global["general"]["smallerWorldMapScale"] = 1
		-- Custom DataText
	E.global["datatexts"]["settings"]["Experience"]["textFormat"] = "PERCENT"
	E.global["datatexts"]["settings"]["Friends"]["hideAFK"] = true
	E.global["datatexts"]["settings"]["Friends"]["hideApp"] = true
	E.global["datatexts"]["settings"]["Gold"]["goldCoins"] = false
	E.global["datatexts"]["settings"]["MovementSpeed"]["NoLabel"] = true
	E.global["datatexts"]["settings"]["Time"]["time24"] = true
end
-- UI Scale
function ElvUI_EltreumUI:SetupScale()
	E.global["general"]["UIScale"] = 0.7
	SetCVar('uiScale', 0.7)
end
