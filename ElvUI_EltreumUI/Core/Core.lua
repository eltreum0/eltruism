local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local print = _G.print
local GetCVar = _G.GetCVar
local SetCVar = _G.SetCVar
local IsAddOnLoaded = _G.IsAddOnLoaded

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	print('|cff82B4ffEltruism|r: '..msg)
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
	E.private["theme"] = "class"
	E.private["skins"]["parchmentRemoverEnable"] = true
	if ElvUI_EltreumUI.Retail then
		E.private["install_complete"] = "12.38"
		E.private["general"]["totemBar"] = true
		E.private["general"]["nameplateFont"] = "Kimberley"
		E.private["general"]["nameplateFontSize"] = 10
		E.private["general"]["nameplateLargeFont"] = "Kimberley"
		E.private["general"]["nameplateLargeFontSize"] = 10
	elseif ElvUI_EltreumUI.TBC then
		E.private["install_complete"] = "2.06"
		E.private["general"]["totemBar"] = true
	elseif ElvUI_EltreumUI.Classic then
		E.private["install_complete"] = "1.42"
	end
end

-- Global DB
function ElvUI_EltreumUI:SetupGlobal()
	-- ElvUI Global DB
	if ElvUI_EltreumUI.Retail then
		E.global["general"]["commandBarSetting"] = "ENABLED_RESIZEPARENT"
		E.global["general"]["smallerWorldMap"] = false
		E.global["general"]["smallerWorldMapScale"] = 1
		E.global["general"]["mapAlphaWhenMoving"] = 0.35
	end
	if ElvUI_EltreumUI.Classic then
		E.global["general"]["smallerWorldMapScale"] = 0.5
		E.global["general"]["mapAlphaWhenMoving"] = 0.5
		E.global["general"]["smallerWorldMap"] = true
	end
	if ElvUI_EltreumUI.TBC then
		E.global["general"]["smallerWorldMapScale"] = 0.5
		E.global["general"]["mapAlphaWhenMoving"] = 0.5
		E.global["general"]["smallerWorldMap"] = true
	end
	E.global["general"]["WorldMapCoordinates"]["position"] = "TOPLEFT"
	E.global["general"]["fadeMapDuration"] = 0.1
		-- Custom DataText
	E.global["datatexts"]["settings"]["Experience"]["textFormat"] = "PERCENT"
	E.global["datatexts"]["settings"]["Friends"]["hideAFK"] = true
	E.global["datatexts"]["settings"]["Friends"]["hideApp"] = true
	E.global["datatexts"]["settings"]["Gold"]["goldCoins"] = false
	if ElvUI_EltreumUI.Retail then
		E.global["datatexts"]["settings"]["MovementSpeed"]["NoLabel"] = true
	end
	E.global["datatexts"]["settings"]["Time"]["time24"] = true
end

--Resolution check for font outline
function ElvUI_EltreumUI:ResolutionOutline()
	if GetCVar('gxFullscreenResolution') == "3140x2160" or GetCVar('gxWindowedResolution') == "3140x2160" then
		ElvUI_EltreumUI:Print(L["4K resolution detected, setting fonts to default mode."])
	elseif GetCVar('gxFullscreenResolution') == '2560x1440' or GetCVar('gxWindowedResolution') == "2560x1440" then
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["1440p resolution detected, setting fonts to outline mode."])
	elseif GetCVar('gxFullscreenResolution') == "1920x1080" or GetCVar('gxWindowedResolution') == "1920x1080" then
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["1080p resolution detected, setting fonts to outline mode."])
	elseif GetCVar('gxFullscreenResolution') == "auto" or GetCVar('gxWindowedResolution') == "auto" then
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["Fonts were set to Outline due to your resolution."])
	else
		ElvUI_EltreumUI:SetupFontsOutlineOutline()
		ElvUI_EltreumUI:Print(L["Fonts were set to Outline due to your resolution."])
	end
end

--turn and off blizzard combat text
function ElvUI_EltreumUI:BlizzCombatText()
	if not E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext then
		if ElvUI_EltreumUI.Retail then
			SetCVar("floatingCombatTextCombatDamage", 1)
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			SetCVar("floatingCombatTextCombatDamage", 1)
		end
	elseif E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext then
		if ElvUI_EltreumUI.Retail then
			SetCVar("floatingCombatTextCombatDamage", 0)
		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			SetCVar("floatingCombatTextCombatDamage", 0)
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
		SetCVar("floatingCombatTextEnergyGains", 1)
		SetCVar("enableFloatingCombatText", 1) ----this is damage taken without this the floating resource will not work
	else
		SetCVar("floatingCombatTextEnergyGains", 0)
		SetCVar("enableFloatingCombatText", 0)
	end
end

-- Ghost frame for Automatic Weakauras Positioning
local EltreumWAAnchor = CreateFrame("Frame", "EltruismWA", E.UIParent)
local EltruismWAConsumablesAnchor = CreateFrame("Frame", "EltruismConsumables", E.UIParent)
function ElvUI_EltreumUI:WAAnchor()
	if E.private.unitframe.enable then
		--Anchor for general weakauras, like those that replace actionbars
		EltreumWAAnchor:SetParent("ElvUF_Player")
		EltreumWAAnchor:SetFrameStrata("BACKGROUND")
		--position the anchor around the place where the action bars would be
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
			EltreumWAAnchor:Point("CENTER", E.UIParent, "CENTER", 0, -380)
		elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			EltreumWAAnchor:Point("CENTER", E.UIParent, "CENTER", 0, -250)
		else
			EltreumWAAnchor:Point("CENTER", E.UIParent, "CENTER", 0, -380)
		end
		--EltreumWAAnchor:Hide()
		EltreumWAAnchor:Size(250, 70)
		--E:CreateMover(parent, name, textString, overlay, snapoffset, postdrag, types, shouldDisable, configString, ignoreSizeChanged)
		E:CreateMover(EltreumWAAnchor, "MoverEltruismWA", "EltruismWA", nil, nil, nil, "ALL")

		--consumable weakauras, usually placed near player unitframe
		EltruismWAConsumablesAnchor:SetParent("ElvUF_Player")
		EltruismWAConsumablesAnchor:SetFrameStrata("BACKGROUND")
		--postion the anchor right below the player unitframe
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
			EltruismWAConsumablesAnchor:Point("LEFT", ElvUF_Player, 0, -75)
		elseif ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			EltruismWAConsumablesAnchor:Point("LEFT", ElvUF_Player, 0, -42)
		else
			EltruismWAConsumablesAnchor:Point("LEFT", ElvUF_Player, 0, -75)
		end
		EltruismWAConsumablesAnchor:Size(270, 30)
		--EltruismWAConsumablesAnchor:Hide()
		E:CreateMover(EltruismWAConsumablesAnchor, "MoverEltruismWAConsumables", L["EltruismConsumables"], nil, nil, nil, "ALL")
	end
end

-- UI Scale
function ElvUI_EltreumUI:SetupScale()
	E.global["general"]["UIScale"] = 0.7
	if (not IsAddOnLoaded("ElvUI_SLE")) then
		SetCVar('uiScale', 0.7)
	end
end

--World text Scale
function ElvUI_EltreumUI:WorldTextScale(value)
	E.db.ElvUI_EltreumUI.otherstuff.worldtextscale = value
	SetCVar('WorldTextScale', value)
end

-- CVars General
function ElvUI_EltreumUI:SetupCVars()
	-- ElvUI CVars
	SetCVar('removeChatDelay', 1)
	SetCVar('cameraDistanceMaxZoomFactor', 2.6)
	SetCVar('autoLootDefault', 1)
	SetCVar('autoQuestWatch', 1)
	SetCVar('UnitNameEnemyGuardianName', 0)
	SetCVar('UnitNameEnemyMinionName', 0)
	SetCVar('UnitNameEnemyPetName', 0)
	SetCVar('UnitNameFriendlyPetName', 0)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyTotemName', 1)
	SetCVar('UnitNameNPC', 1)
	SetCVar("ShowClassColorInFriendlyNameplate", 1)
	SetCVar('statusTextDisplay', 'BOTH')
	SetCVar('screenshotQuality', 10)
	SetCVar('chatMouseScroll', 1)
	SetCVar('wholeChatWindowClickable', 0)
	SetCVar('showTutorials', 0)
	SetCVar('UberTooltips', 1)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('lockActionBars', 1)
	SetCVar('spamFilter', 0)
	SetCVar('Sound_EnableErrorSpeech', 1)

	-- fast loot
	SetCVar("autoLootRate", 1)

	--Chat CVars
	SetCVar('chatStyle', 'classic')
	SetCVar('whisperMode', 'inline')
	SetCVar('colorChatNamesByClass', 1)
	SetCVar('chatClassColorOverride', 0)

	_G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:SetValue('SHIFT')
	_G.InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:RefreshValue()

	if ElvUI_EltreumUI.Retail then
		SetCVar('showNPETutorials', 0)
		SetCVar('threatWarning', 3)
		SetCVar('showQuestTrackingTooltips', 1)
		SetCVar('fstack_preferParentKeys', 0) --Add back the frame names via fstack!
	elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		SetCVar("lootUnderMouse", 1)
		SetCVar("chatBubbles", 1)
		SetCVar("chatBubblesParty", 1)
	end
	ElvUI_EltreumUI:Print(L["General CVars have been set."])
end

-- CVars NamePlates
function ElvUI_EltreumUI:NameplateCVars()
	SetCVar('nameplateOtherBottomInset', 0.02)
	SetCVar('nameplateOtherTopInset', 0.1)
	SetCVar('nameplateTargetRadialPosition', 1)
	SetCVar('nameplateLargerScale', 1.2)
	SetCVar('nameplateMinScale', 1)
	SetCVar('nameplateMinAlpha',1)
	SetCVar('nameplateMaxDistance', 60)
	SetCVar('nameplateMotion', 1)
	SetCVar('nameplateOccludedAlphaMult', 0)
	SetCVar("nameplateOverlapH", 0.8)
	SetCVar("nameplateOverlapV", 1.1)
	SetCVar('nameplateSelectedScale', 1)
	SetCVar('nameplateSelfAlpha', 1)
	SetCVar('nameplateShowFriendlyMinions', 0)
	SetCVar('nameplateTargetBehindMaxDistance', 40)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar("nameplateShowFriends", 1)
	ElvUI_EltreumUI:Print(L["NamePlate CVars have been set."])
end

-- AddOnSkins Profile
function ElvUI_EltreumUI:AddonSetupAS()
	if IsAddOnLoaded('AddOnSkins') then
		ElvUI_EltreumUI:GetASProfile()
		ElvUI_EltreumUI:Print(L["AddOnSkins profile has been set."])
	else
		ElvUI_EltreumUI:Print("AddOnSkins is not loaded")
	end
end

-- Immersion Profile
function ElvUI_EltreumUI:AddonSetupImmersion()
	if IsAddOnLoaded('Immersion') then
		ElvUI_EltreumUI:GetImmersionProfile()
		ElvUI_EltreumUI:Print(L["Immersion profile has been set."])
	else
		ElvUI_EltreumUI:Print("Immersion is not loaded")
	end
end

-- BigWigs Profile
function ElvUI_EltreumUI:AddonSetupBW()
	if IsAddOnLoaded('BigWigs') then
		ElvUI_EltreumUI:GetBigWigsProfile()
		ElvUI_EltreumUI:Print(L["BigWigs profile has been set."])
	else
		ElvUI_EltreumUI:Print("BigWigs is not loaded")
	end
end

-- DBM Profile
function ElvUI_EltreumUI:AddonSetupDBM()
	if IsAddOnLoaded('DBM-Core') then
		ElvUI_EltreumUI:GetDBMProfile()
		ElvUI_EltreumUI:Print(L["DBM profile has been set."])
	else
		ElvUI_EltreumUI:Print("DBM is not loaded")
	end
end

-- Details Profile
function ElvUI_EltreumUI:AddonSetupDT()
	if IsAddOnLoaded('Details') then
		ElvUI_EltreumUI:GetDetailsProfile()
		ElvUI_EltreumUI:Print(L["Details profile has been set."])
	else
		ElvUI_EltreumUI:Print("Details is not loaded")
	end
end

function ElvUI_EltreumUI:AddonSetupDTReleaf()
	if IsAddOnLoaded('Details') then
		ElvUI_EltreumUI:GetDetailsProfileReleaf()
		ElvUI_EltreumUI:Print("Details profile using Releaf icons has been set.")
	else
		ElvUI_EltreumUI:Print("Details is not loaded")
	end
end

-- DynamicCam Profile
function ElvUI_EltreumUI:AddonSetupDynamicCam()
	if IsAddOnLoaded('DynamicCam') then
		ElvUI_EltreumUI:GetDynamicCamProfile()
		ElvUI_EltreumUI:Print(L["Dynamic Cam profile has been set."])
	else
		ElvUI_EltreumUI:Print("Dynamic Cam is not loaded")
	end
end

-- GladiusEx Profile
function ElvUI_EltreumUI:AddonSetupGladiusEx()
	if IsAddOnLoaded('GladiusEx') then
		ElvUI_EltreumUI:GetGladiusExProfile()
		ElvUI_EltreumUI:Print(L["GladiusEx profile has been set."])
	else
		ElvUI_EltreumUI:Print("GladiusEx is not loaded")
	end
end

-- MRT Profile
function ElvUI_EltreumUI:AddonSetupMRT()
	if IsAddOnLoaded('MRT') then
		ElvUI_EltreumUI:GetMRTProfile()
		ElvUI_EltreumUI:Print(L["Method Raid Tools profile has been set."])
	else
		ElvUI_EltreumUI:Print("Method Raid Tools is not loaded")
	end
end

-- ProjectAzilroka Profile
function ElvUI_EltreumUI:AddonSetupPA()
	if IsAddOnLoaded('ProjectAzilroka') then
		ElvUI_EltreumUI:GetPAProfile()
		ElvUI_EltreumUI:Print(L["ProjectAzilroka profile has been set."])
	else
		ElvUI_EltreumUI:Print("ProjectAzilroka is not loaded")
	end
end

-- Questie Profile
function ElvUI_EltreumUI:AddonSetupQuestie()
	if IsAddOnLoaded('Questie') then
		ElvUI_EltreumUI:GetQuestieProfile()
		ElvUI_EltreumUI:Print(L["Questie profile has been set."])
	else
		ElvUI_EltreumUI:Print("Questie is not loaded")
	end
end

-- NameplateSCT Profile
function ElvUI_EltreumUI:AddonSetupNameplateSCT()
	if IsAddOnLoaded('NameplateSCT') then
		ElvUI_EltreumUI:GetNameplateSCTProfile()
		SetCVar("enableFloatingCombatText", 0)
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			SetCVar("floatingCombatTextCombatDamage", 0)
		end
		ElvUI_EltreumUI:Print(L["NameplateSCT profile has been set."])
	else
		ElvUI_EltreumUI:Print("NameplateSCT is not loaded")
	end
end

-- FCT Profile
function ElvUI_EltreumUI:AddonSetupFCT()
	if IsAddOnLoaded('ElvUI_FCT') then
		ElvUI_EltreumUI:GetFCTProfile()
		SetCVar("enableFloatingCombatText", 0)
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			SetCVar("floatingCombatTextCombatDamage", 0)
		end
		ElvUI_EltreumUI:Print(L["Floating Combat Text profile has been set."])
	else
		ElvUI_EltreumUI:Print("Floating Combat Text is not loaded")
	end
end

-- Gladius Profile
function ElvUI_EltreumUI:SetupGladius()
	if IsAddOnLoaded('Gladius') then
		ElvUI_EltreumUI:GetGladiusProfile()
		ElvUI_EltreumUI:Print(L["Gladius profile has been set."])
	else
		ElvUI_EltreumUI:Print("Gladius is not loaded")
	end
end

-- Gladdy Profile
function ElvUI_EltreumUI:SetupGladdy()
	if IsAddOnLoaded('Gladdy') then
		ElvUI_EltreumUI:GetGladdyProfile()
		ElvUI_EltreumUI:Print(L["Gladdy profile has been set."])
	else
		ElvUI_EltreumUI:Print("Gladdy is not loaded")
	end
end
