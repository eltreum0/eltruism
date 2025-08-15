local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local GetCVar = _G.C_CVar and _G.C_CVar.GetCVar or _G.GetCVar
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local LOW_LATENCY_MODE = _G.LOW_LATENCY_MODE or "Low Latency Mode"
local OPTION_TOOLTIP_LOW_LATENCY_MODE = _G.OPTION_TOOLTIP_LOW_LATENCY_MODE or "Allows the game to use various techniques to reduce input latency"
local VIDEO_OPTIONS_DISABLED = _G.VIDEO_OPTIONS_DISABLED or "Disabled"
local VIDEO_OPTIONS_BUILTIN = _G.VIDEO_OPTIONS_BUILTIN or "Built-in"
local VIDEO_OPTIONS_NVIDIA_REFLEX = _G.VIDEO_OPTIONS_NVIDIA_REFLEX or "NVIDIA Reflex"
local SHOW_IN_GAME_NAVIGATION = _G.SHOW_IN_GAME_NAVIGATION or " "

-- Eltruism CVar options
function ElvUI_EltreumUI:CVarOptions()
	ElvUI_EltreumUI.Options.args.cvars = E.Libs.ACH:Group(E:TextGradient(L["CVars"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Customize Blizzard's Hidden Settings"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.cvars.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cvar'
	ElvUI_EltreumUI.Options.args.cvars.args.general = E.Libs.ACH:Group(L["General"], nil, 1)
	ElvUI_EltreumUI.Options.args.cvars.args.general.args.description1 = E.Libs.ACH:Description(L["Setup CVars"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.general.args.generalVars = E.Libs.ACH:Execute(L["General CVars"], nil, 2, function() ElvUI_EltreumUI:SetupCVars() ElvUI_EltreumUI:NameplateCVars() end,nil,true, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.general.args.description2 = E.Libs.ACH:Description(L["It will set these CVars:"], 3, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.general.args.cvarlist = E.Libs.ACH:Description([[

ActionButtonUseKeyDown 1
allowCompareWithToggle 1
alwaysCompareItems 0
alwaysShowActionBars 1
autoLootDefault 1
autoLootRate 1
autoQuestWatch 1
cameraDistanceMaxZoomFactor 2.6
cameraIndirectOffset 15
cameraIndirectVisibility 1
chatBubbles 1
chatBubblesParty 1
chatClassColorOverride 0
chatMouseScroll 1
chatStyle 'classic'
colorChatNamesByClass 1
displaySpellActivationOverlays 1
enableMouseoverCast 1
findYourselfAnywhere 1
findYourselfAnywhereOnlyInCombat 1
findYourselfMode 2
findYourselfModeCircle 0
findYourselfModeOutline 1
fstack_preferParentKeys 0
instantQuestText 1
lockActionBars 1
lootUnderMouse 1
maxFPSLoading 30
minimapTrackingShowAll 1
missingTransmogSourceInItemTooltips 1
nameplateGlobalScale 1
nameplateLargeBottomInset 0.02
nameplateLargerScale 1.2
nameplateLargeTopInset 0.1
nameplateMaxDistance 60
nameplateMinAlpha1
nameplateMinScale 1
nameplateMotion 1
nameplateOccludedAlphaMult 0
nameplateOtherBottomInset 0.02
nameplateOtherTopInset 0.1
nameplateOverlapH 0.8
nameplateOverlapV 1.1
nameplateSelectedScale 1
nameplateSelfAlpha 1
nameplateShowEnemies 1
nameplateShowFriendlyMinions 0
nameplateShowFriends 1
nameplateTargetBehindMaxDistance 40
nameplateTargetRadialPosition 1
occludedSilhouettePlayer 1
PushToTalkSound 0
removeChatDelay 1
screenshotQuality 10
ShowClassColorInFriendlyNameplate 1
showNPETutorials 0
showQuestTrackingTooltips 1
showTutorials 0
SoftTargetIconEnemy 0
SoftTargetIconFriend 0
SoftTargetIconGameObject 1
SoftTargetIconInteract 1
SoftTargetInteract 3
SoftTargetInteractArc 2
SoftTargetInteractRange 5
SoftTargetLowPriorityIcons 1
SoftTargetNameplateInteract 1
spellActivationOverlayOpacity 0.5
statusTextDisplay 'BOTH'
threatWarning 3
UberTooltips 1
UnitNameEnemyGuardianName 0
UnitNameEnemyMinionName 0
UnitNameEnemyPetName 0
UnitNameEnemyPlayerName 1
UnitNameEnemyTotemName 1
UnitNameFriendlyPetName 0
UnitNameHostleNPC 0
UnitNameInteractiveNPC 0
UnitNameNonCombatCreatureName 0
UnitNameNPC 0
UnitNameNPC 1
UnitNameOwn 0
whisperMode 'inline'
wholeChatWindowClickable 0
WorldTextMinSize 6
]], 4, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars = E.Libs.ACH:Group(L["Other CVars"], nil, 2)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext = E.Libs.ACH:Group(L["Combat Text"], nil, 2, "tab")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext.args.description1 = E.Libs.ACH:Description(L["Blizzard Floating Combat Text"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext.args.blizzcombatexttoggle = E.Libs.ACH:Toggle(L["Disable Combat Text"], L["Enable or disable Blizzard's default Floating Combat Text"], 2, nil, false,'full',function() return E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext.args.blizzcombatextmana = E.Libs.ACH:Toggle(L["Enable Resource Gains"], L["Enable or disable Blizzard's default Floating Combat Text for Mana/Rage/Energy and other resouces"], 3, nil, false,'full',function() return E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext.args.restorecvars = E.Libs.ACH:Execute(L["Restore All Blizzard Combat Text"], nil, 4, function() ElvUI_EltreumUI:RestoreBlizzCombatText() E:StaticPopup_Show('CONFIG_RL') end,nil,true, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext.args.description2 = E.Libs.ACH:Description(L["Change the Scale of the World Text"], 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.combattext.args.worldtextscale = E.Libs.ACH:Range(L["Select the size of the World Text"], nil, 6, { min = 0.2, max = 2, step = 0.1 }, 'full', function() return E.db.ElvUI_EltreumUI.otherstuff.worldtextscale end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.worldtextscale = value ElvUI_EltreumUI:WorldTextScale(value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.camera = E.Libs.ACH:Group(L["Camera"], nil, 2, "tab")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.camera.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.camera.args.cameraFOV = E.Libs.ACH:Range(L["Camera Field of View"], L["This allows you to zoom out further with the camera to increase the field of view."], 2, { min = 50, max = 90, step = 1 }, 'full', function() return E.db.ElvUI_EltreumUI.cvars.cameraFOV end, function(_, value) E.db.ElvUI_EltreumUI.cvars.cameraFOV = value SetCVar('camerafov', value) end, nil)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.camera.args.cameraDistanceMaxZoomFactor = E.Libs.ACH:Range(L["Camera Distance Max Zoom Factor"], L["Maximum Camera Zoom Out"], 2, { min = 1, max = function() if not (E.Mists or E.Classic) then return 2.6 else return 4 end end, step = 0.1 }, 'full', function() return E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor end, function(_, value) E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor = value SetCVar('cameraDistanceMaxZoomFactor', value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates = E.Libs.ACH:Group(L["Nameplates"], nil, 2, "tab")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.SoftTargetInteract = E.Libs.ACH:Toggle(L["Soft Target Interact"], L["Enable Soft Target Interactions"], 2, nil, false,'full',
		function()
			if GetCVar('SoftTargetInteract') == '0' then
				return false
			elseif GetCVar('SoftTargetInteract') == '3' then
				return true
			end
		end, function(_, value)
			if value == true then
				SetCVar('SoftTargetInteract', 3)
				SetCVar('SoftTargetIconInteract', 1)
				SetCVar('SoftTargetIconGameObject', 1)
				SetCVar('SoftTargetNameplateInteract', 1)
				SetCVar('SoftTargetLowPriorityIcons', 1)
				SetCVar('SoftTargetIconEnemy', 0)
				SetCVar('SoftTargetIconFriend', 0)
			else
				SetCVar('SoftTargetInteract', 0)
				SetCVar('SoftTargetIconInteract', 0)
				SetCVar('SoftTargetIconGameObject', 0)
				SetCVar('SoftTargetNameplateInteract', 0)
				SetCVar('SoftTargetLowPriorityIcons', 0)
				SetCVar('SoftTargetIconEnemy', 0)
				SetCVar('SoftTargetIconFriend', 0)
			end
		end, nil)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.nameplateTargetRadialPosition = E.Libs.ACH:Select(L["Nameplate Target Radial Position"], L["When target is off screen, position its nameplate radially around sides and bottom."], 4, {
		["1"] = L["Target Only"],
		["2"] = L["All in Combat"],
	}, false, nil, function() return GetCVar('nameplateTargetRadialPosition') end, function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateTargetRadialPosition = value SetCVar('nameplateTargetRadialPosition', value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.nameplateTargetRadialPosition.style = "radio"
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.description3 = E.Libs.ACH:Description(" ", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.nameplateOtherBottomInset = E.Libs.ACH:Range(L["Nameplate Other Bottom Inset"], L["In screen % the inset from the Bottom"], 6, { min = 0.01, max = 1, step = 0.01 }, 'full', function() return E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset end, function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset = value SetCVar('nameplateOtherBottomInset', value) SetCVar('nameplateLargeBottomInset', value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.nameplateOtherTopInset = E.Libs.ACH:Range(L["Nameplate Other Top Inset"], L["In screen % the inset from the Top"], 6, { min = 0.01, max = 1, step = 0.01 }, 'full', function() return E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset end, function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset = value SetCVar('nameplateOtherTopInset', value) SetCVar('nameplateLargeTopInset', value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.nameplateOccludedAlphaMult = E.Libs.ACH:Range(L["Nameplate Occluded Alpha"], L["Alpha of Nameplates out of Sight"], 7, { min = 0, max = 1, step = 0.01 }, 'full', function() return E.db.ElvUI_EltreumUI.cvars.nameplateOccludedAlphaMult end, function(_, value) E.db.ElvUI_EltreumUI.cvars.nameplateOccludedAlphaMult = value SetCVar('nameplateOccludedAlphaMult', value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.nameplateGlobalScale = E.Libs.ACH:Range(L["Nameplate Global Scale"], L["Global Scaling of nameplates after selected, min, and max scale"], 7, { min = 0.1, max = 10, step = 0.01 }, 'full', function() return _G.tonumber(GetCVar('nameplateGlobalScale')) end, function(_, value) SetCVar('nameplateGlobalScale', value) end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.description4 = E.Libs.ACH:Description(" ", 8, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Retail)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.nameplates.args.clampTargetNameplateToScreen = E.Libs.ACH:Toggle(L["Clamp Nameplates"], nil, 9, nil, false,'full',
		function()
			if GetCVar('clampTargetNameplateToScreen') == '0' then
				return false
			elseif GetCVar('clampTargetNameplateToScreen') == '1' then
				return true
			end
		end, function(_, value)
			if value == true then
				SetCVar('clampTargetNameplateToScreen', 1)
				E.db.ElvUI_EltreumUI.cvars.clampTargetNameplateToScreen = 1
			else
				SetCVar('clampTargetNameplateToScreen', 0)
				E.db.ElvUI_EltreumUI.cvars.clampTargetNameplateToScreen = 0
			end
		end, nil, E.Retail)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics = E.Libs.ACH:Group(L["Graphics"], nil, 2, "tab")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.description1 = E.Libs.ACH:Description(L["AMD FSR"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.forceFSRon = E.Libs.ACH:Toggle(L["Enable AMD FSR even if not scaling"], L["Forces AMD's FSR to sharpen image even if you aren't running a lower resolution"], 2, nil, false,'full',
		function()
			if GetCVar('ResampleAlwaysSharpen') == '0' then
				return false
			elseif GetCVar('ResampleAlwaysSharpen') == '1' then
				return true
			end
		end, function(_, value)
			if value == true then
				SetCVar('ResampleAlwaysSharpen', 1)
			else
				SetCVar('ResampleAlwaysSharpen', 0)
			end
		end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.forceFSRsharpness = E.Libs.ACH:Range(_G.RESAMPLE_QUALITY_FSR, nil, 3, { min = 0, max = 2, step = 0.1 }, 'full', function() return _G.tonumber(GetCVar('ResampleSharpness')) end, function(_, value) SetCVar('ResampleSharpness', value) end, function() if GetCVar('ResampleAlwaysSharpen') == '1' then return false elseif GetCVar('ResampleAlwaysSharpen') == '0' then return true end end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.description2 = E.Libs.ACH:Description(LOW_LATENCY_MODE, 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.lowlatencycvar = E.Libs.ACH:Select(" ",OPTION_TOOLTIP_LOW_LATENCY_MODE, 5, {
		["0"] = VIDEO_OPTIONS_DISABLED,
		["1"] = VIDEO_OPTIONS_BUILTIN,
		["2"] = VIDEO_OPTIONS_NVIDIA_REFLEX,
		--["3"] = VIDEO_OPTIONS_NVIDIA_REFLEX_BOOST,
	}, false, nil, function() return GetCVar('LowLatencyMode') end, function(_, value) local number = _G.tonumber(value) SetCVar('LowLatencyMode', number) end, nil)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.lowlatencycvar.style = "radio"
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.description3 = E.Libs.ACH:Description(L["Dynamic Render Scale"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.dynamicrenderscaleenable = E.Libs.ACH:Toggle(L["Lowers render scale if GPU bound to hit Target FPS."], L["Note this feature is in BETA.\nKnown issues:\n - May cause hitching.\n - May behave poorly with vsync on."], 7, nil, false,'full',
		function()
			if GetCVar('DynamicRenderScale') == '0' then
				return false
			elseif GetCVar('DynamicRenderScale') == '1' then
				return true
			end
		end, function(_, value)
			if value == true then
				SetCVar('DynamicRenderScale', 1)
			else
				SetCVar('DynamicRenderScale', 0)
			end
		end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.dynamicrenderscaleenable.descStyle = "inline"
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.dynamicrenderscalepercentage = E.Libs.ACH:Range(L["Dynamic Render Scale Minimum"], L["Lowest Render Scale used"], 8, { min = 0.1, max = 1, step = 0.01 }, 'full', function() return _G.tonumber(GetCVar('DynamicRenderScaleMin')) end, function(_, value) SetCVar('DynamicRenderScaleMin', _G.tonumber(value)) E.db.ElvUI_EltreumUI.cvars.dynamicrenderscalemin = _G.tonumber(value) end, function() if GetCVar('DynamicRenderScale') == '1' then return false elseif GetCVar('DynamicRenderScale') == '0' then return true end end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.description4 = E.Libs.ACH:Description("", 19, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.graphics.args.preloadNonCritical = E.Libs.ACH:Toggle(_G.DISABLE.." ".."worldPreloadNonCritical", L["Disable the worldPreloadNonCritical CVar, doing so can improve loading times."], 20, nil, false,'full',
		function()
			if GetCVar('worldPreloadNonCritical') == '2' then
				return false
			elseif GetCVar('worldPreloadNonCritical') == '0' then
				return true
			else
				return false
			end
		end, function(_, value)
			if value == true then
				SetCVar('worldPreloadNonCritical', 0)
			else
				SetCVar('worldPreloadNonCritical', 2)
			end
		end)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.misc = E.Libs.ACH:Group(L["Misc"], nil, 2, "tab", nil,nil,nil,not E.Retail)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.misc.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.misc.args.showInGameNavigation = E.Libs.ACH:Toggle(SHOW_IN_GAME_NAVIGATION, nil, 2, nil, false,"full",
		function()
			if GetCVar('showInGameNavigation') == '0' then
				return false
			elseif GetCVar('showInGameNavigation') == '1' then
				return true
			end
		end, function(_, value)
			if value == true then
				SetCVar('showInGameNavigation', 1)
				E.db.ElvUI_EltreumUI.cvars.showInGameNavigation = 1
			else
				SetCVar('showInGameNavigation', 0)
				E.db.ElvUI_EltreumUI.cvars.showInGameNavigation = 0
			end
		end, nil, not E.Retail)

	--the set default for these settings work, so not sure this is needed
	--[[ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.misc.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.cvars.args.othercvars.args.misc.args.resetitemquality = E.Libs.ACH:Execute(COLORS_ITEM_QUALITY.." "..COLORS.." "..RESET, nil, 7, function()
		_G.ITEM_QUALITY_COLORS[0]["r"] = 157/255 --poor
		_G.ITEM_QUALITY_COLORS[0]["g"] = 157/255 --poor
		_G.ITEM_QUALITY_COLORS[0]["b"] = 157/255 --poor
		_G.ITEM_QUALITY_COLORS[1]["r"] = 240/255 --common
		_G.ITEM_QUALITY_COLORS[1]["g"] = 1 --common
		_G.ITEM_QUALITY_COLORS[1]["b"] = 251/255 --common
		_G.ITEM_QUALITY_COLORS[2]["r"] = 30/255 --uncommon
		_G.ITEM_QUALITY_COLORS[2]["g"] = 1 --uncommon
		_G.ITEM_QUALITY_COLORS[2]["b"] = 0 --uncommon
		_G.ITEM_QUALITY_COLORS[3]["r"] = 0 --rare
		_G.ITEM_QUALITY_COLORS[3]["g"] = 112/255 --rare
		_G.ITEM_QUALITY_COLORS[3]["b"] = 221/255 --rare
		_G.ITEM_QUALITY_COLORS[4]["r"] = 163/255 --epic
		_G.ITEM_QUALITY_COLORS[4]["g"] = 53/255 --epic
		_G.ITEM_QUALITY_COLORS[4]["b"] = 238/255 --epic
		_G.ITEM_QUALITY_COLORS[5]["r"] = 1 --legendary
		_G.ITEM_QUALITY_COLORS[5]["g"] = 128/255 --legendary
		_G.ITEM_QUALITY_COLORS[5]["b"] = 0 --legendary
		_G.ITEM_QUALITY_COLORS[6]["r"] = 230/255 --artifact
		_G.ITEM_QUALITY_COLORS[6]["g"] = 204/255 --artifact
		_G.ITEM_QUALITY_COLORS[6]["b"] = 128/255 --artifact
		_G.ITEM_QUALITY_COLORS[7]["r"] = 0 --heirloom
		_G.ITEM_QUALITY_COLORS[7]["g"] = 204/255 --heirloom
		_G.ITEM_QUALITY_COLORS[7]["b"] = 1 --heirloom
	end, nil, true,'full',nil,nil,nil,not E.Retail)]]
end
