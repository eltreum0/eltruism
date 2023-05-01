local E, L = unpack(ElvUI)
local _G = _G
local C_CVar = _G.C_CVar
local S = E:GetModule('Skins')
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local print = _G.print
local unpack = _G.unpack
local hooksecurefunc = _G.hooksecurefunc
local IsAddOnLoaded = _G.IsAddOnLoaded
local DisableAddOn = _G.DisableAddOn
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize
local SetCVar = _G.SetCVar
local UIParentLoadAddOn = _G.UIParentLoadAddOn
local GetCursorInfo = _G.GetCursorInfo
local GetItemInfo = _G.GetItemInfo
local string = _G.string
local DELETE_ITEM_CONFIRM_STRING = _G.DELETE_ITEM_CONFIRM_STRING
local InCombatLockdown = _G.InCombatLockdown
local HideUIPanel = _G.HideUIPanel
local LoadAddOn = _G.LoadAddOn
local GameMenuFrame = _G.GameMenuFrame
local UIErrorsFrame = _G.UIErrorsFrame
local RaidWarningFrame = _G.RaidWarningFrame
local tostring = _G.tostring
local tremove = _G.tremove
local math = _G.math
local PlaySound = _G.PlaySound
local W

-- Eltreum UI print
function ElvUI_EltreumUI:Print(msg)
	--print('|cff82B4ffEltruism|r: '..msg)
	print(E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1)..': '..msg)
end

--hide popups during install
function ElvUI_EltreumUI:HidePopups(delay)
	if E:IsAddOnEnabled("ElvUI_WindTools") then
		W = unpack(WindTools)
		local function WindtoolsCompatHideWhileInstall()
			_G["WTCompatibilityFrame"]:Kill()
		end
		hooksecurefunc(W, "ConstructCompatibilityFrame", WindtoolsCompatHideWhileInstall)
	end
	if IsAddOnLoaded("Details_Streamer") then
		DisableAddOn("Details_Streamer")
	end
	E:Delay(delay, function()
		if IsAddOnLoaded("Details") and _G['_detalhes'] then
			_G['_detalhes'].is_first_run = false
			_G['_detalhes']:DisablePlugin ("DETAILS_PLUGIN_STREAM_OVERLAY")
			_G['_detalhes']:DisablePlugin ("Details_Streamer")
			_G['_detalhes']:SetTutorialCVar ("STREAMER_PLUGIN_FIRSTRUN", true)
			if _G["DetailsWelcomeWindow"] then
				_G["DetailsWelcomeWindow"]:Hide()
			end
			if _G["DetailsNewsWindow"] then
				_G["DetailsNewsWindow"]:Hide()
			end
			if _G["StreamOverlayWelcomeWindow"] then
				_G["StreamOverlayWelcomeWindow"]:Hide()
			end
			if _G["DetailsBaseFrame1"] then
				_G["DetailsBaseFrame1"]:Hide()
			end
			if _G["DetailsProfilerProfileConfirmButton"] then
				local a = _G["DetailsProfilerProfileConfirmButton"]:GetParent()
				a:Hide()
			end
		end
		for i = 1, 4 do
			if _G["StaticPopup"..i] then
				_G["StaticPopup"..i]:Hide()
			end
			if _G["ElvUI_StaticPopup"..i] then
				_G["ElvUI_StaticPopup"..i]:Hide()
			end
		end
		if _G["CappingFrame"] then
			_G["CappingFrame"]:Hide()
		end
		if IsAddOnLoaded("GladiusEx") then
			GladiusEx:HideFrames()
		end
		if IsAddOnLoaded("Gladius") then
			if _G["GladiusButtonFramearena1"] then
				_G["GladiusButtonFramearena1"]:Hide()
			end
			if _G["GladiusButtonFramearena2"] then
				_G["GladiusButtonFramearena2"]:Hide()
			end
			if _G["GladiusButtonFramearena3"] then
				_G["GladiusButtonFramearena3"]:Hide()
			end
			if _G["GladiusButtonFramearena4"] then
				_G["GladiusButtonFramearena4"]:Hide()
			end
			if _G["GladiusButtonFramearena5"] then
				_G["GladiusButtonFramearena5"]:Hide()
			end
			if _G["GladiusButtonAnchor"] then
				_G["GladiusButtonAnchor"]:Hide()
			end
			if _G["GladiusButtonBackground"] then
				_G["GladiusButtonBackground"]:Hide()
			end
		end
	end)
end

--Resolution check for font outline
function ElvUI_EltreumUI:ResolutionOutline()
	local width = GetPhysicalScreenSize()
	if width == 3840 then
		ElvUI_EltreumUI:Print(L["4K resolution detected, setting fonts to default mode."])
		ElvUI_EltreumUI:SetupFontsOutlineDefault()
	elseif width == 2560 then
		ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE")
		ElvUI_EltreumUI:Print(L["1440p resolution detected, setting fonts to outline mode."])
	elseif width == 1920 then
		ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE")
		ElvUI_EltreumUI:Print(L["1080p resolution detected, setting fonts to outline mode."])
	else
		ElvUI_EltreumUI:SetupFontsOutlineCustom("OUTLINE")
		ElvUI_EltreumUI:Print(L["Fonts were set to Outline due to your resolution."])
	end
end

--turn and off blizzard combat text
function ElvUI_EltreumUI:BlizzCombatText()
	if not E.private.ElvUI_EltreumUI then
		return
	elseif not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.otherstuff then
		return
	end
	if not InCombatLockdown() then
		if tostring(C_CVar.GetCVar("enableFloatingCombatText")) == "1" then
			if E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext and not E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
				if IsAddOnLoaded('ElvUI_FCT') or IsAddOnLoaded('NameplateSCT') then
					SetCVar("enableFloatingCombatText", 0)
					SetCVar("floatingCombatTextCombatHealing", 0)
					SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0)
					SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)
					SetCVar("floatingCombatTextCombatDamage", 0)
				end
			end
		end
		if tostring(C_CVar.GetCVar("floatingCombatTextEnergyGains")) == "0" or tostring(C_CVar.GetCVar("enableFloatingCombatText")) == "0" then
			if E.db.ElvUI_EltreumUI.otherstuff.blizzcombatmana then
				SetCVar("floatingCombatTextEnergyGains", 1)
				SetCVar("enableFloatingCombatText", 1) ----this is damage taken without this the floating resource will not work
			end
		end
	end
end

--restore blizzard combat text
function ElvUI_EltreumUI:RestoreBlizzCombatText()
	if not InCombatLockdown() then
		SetCVar("enableFloatingCombatText", 1)
		SetCVar("floatingCombatTextCombatHealing", 1)
		SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 1)
		SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 1)
		SetCVar("floatingCombatTextCombatDamage", 1)
		SetCVar("floatingCombatTextEnergyGains", 1)
	end
end

-- Ghost frame for Automatic Weakauras Positioning
local EltreumWAAnchor = CreateFrame("Frame", "EltruismWA", UIParent)
EltreumWAAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, -380)
local EltreumWAAnchor2 = CreateFrame("Frame", "EltruismWA2", UIParent)
EltreumWAAnchor2:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 320)
local EltruismWAConsumablesAnchor = CreateFrame("Frame", "EltruismConsumablesWA", UIParent)
--postion the anchor right below the player unitframe
EltruismWAConsumablesAnchor:SetPoint("LEFT", _G["ElvUF_Player"], 0, -75)
--archeology mover
local EltreumArcheologyAnchor = CreateFrame("Frame", "EltruismArcheology", UIParent)
EltreumArcheologyAnchor:SetPoint("TOP", UIParent, "TOP", 0, -230)
EltreumArcheologyAnchor:SetSize(200, 50)

function ElvUI_EltreumUI:Anchors()
	if E.private.unitframe.enable then
		--Anchor for general weakauras, like those that replace actionbars
		EltreumWAAnchor:SetParent(_G["ElvUF_Player"])
		EltreumWAAnchor:SetFrameStrata("BACKGROUND")
		--position the anchor around the place where the action bars would be
		EltreumWAAnchor:Size(250, 70)
		--E:CreateMover(parent, name, textString, overlay, snapoffset, postdrag, types, shouldDisable, configString, ignoreSizeChanged)
		E:CreateMover(EltreumWAAnchor, "MoverEltruismWA", "EltruismWA", nil, nil, nil, "ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')
		--do it again
		EltreumWAAnchor2:SetParent(_G["ElvUF_Player"])
		EltreumWAAnchor2:SetFrameStrata("BACKGROUND")
		EltreumWAAnchor2:Size(250, 70)
		E:CreateMover(EltreumWAAnchor2, "MoverEltruismWA2", "EltruismWA2", nil, nil, nil, "ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')

		--consumable weakauras, usually placed near player unitframe
		EltruismWAConsumablesAnchor:SetParent(_G["ElvUF_Player"])
		EltruismWAConsumablesAnchor:SetFrameStrata("BACKGROUND")
		EltruismWAConsumablesAnchor:Size(270, 30)
		E:CreateMover(EltruismWAConsumablesAnchor, "MoverEltruismWAConsumables", L["EltruismConsumablesWA"], nil, nil, nil, "ELTREUMUI", nil, 'ElvUI_EltreumUI,weakauras')
	end

	E:CreateMover(RaidWarningFrame, "MoverRaidWarningFrame", "Raid Warning Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")

	if _G["GhostFrame"] then
		E:CreateMover(_G["GhostFrame"], "GhostFrameMover", "Ghost Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
	end

	--mover for UI errors frame
	if E.db.ElvUI_EltreumUI.skins.blizzframes.hideerrorframe then
		UIErrorsFrame:Clear()
		UIErrorsFrame:Hide()
	else
		E:CreateMover(UIErrorsFrame, "MoverUIERRORS", "UI Error Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		if E.db.ElvUI_EltreumUI.skins.blizzframes.errorframe then
			if E.db.ElvUI_EltreumUI.skins.blizzframes.errorframecustomfont then
				if (E.Retail or E.Wrath) and E.db.general.fontStyle == "NONE" then
					UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefont), E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize, "")
				else
					UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefont), E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize, E.db.general.fontStyle)
				end
			else
				if (E.Retail or E.Wrath) and E.db.general.fontStyle == "NONE" then
					UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize, "")
				else
					UIErrorsFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.blizzframes.errorframefontsize, E.db.general.fontStyle)
				end
			end
		end
	end

	--fix tutorial frames getting in the way
	if _G.TutorialMainFrame_Frame then
		_G.TutorialMainFrame_Frame:Kill()
	end
	if _G.TutorialSingleKey_Frame then
		_G.TutorialSingleKey_Frame:Kill()
	end
	if _G.TutorialWalk_Frame then
		_G.TutorialWalk_Frame:Kill()
	end
	if _G.TutorialFrame then
		_G.TutorialFrame:Kill()
	end
	if _G.TutorialKeyboardMouseFrame_Frame then
		_G.TutorialKeyboardMouseFrame_Frame:Kill()
	end

	if not E.private.auras.enable and not InCombatLockdown() then --in case elvui's buffs are disabled
		if _G.BuffFrame then
			E:CreateMover(BuffFrame, 'BlizzardBuffsMover', L["Blizzard Buff Frame"], nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		end
	end

	if E.db.ElvUI_EltreumUI.skins.blizzframes.hidealert then
		_G.AlertFrame:UnregisterAllEvents()
		E:DisableMover('AlertFrameMover')
	end

	if E.db.ElvUI_EltreumUI.skins.blizzframes.hidezone then
		_G.ZoneTextFrame:UnregisterAllEvents()
	end

	if E.Retail then
		E:CreateMover(_G.RaidBossEmoteFrame, "MoverRaidBossEmoteFrame", "Raid/Boss Emote Frame", nil, nil, nil, "ALL,SOLO,ELTREUMUI")
		E:CreateMover(EltreumArcheologyAnchor, "MoverEltreumArcheologyAnchor", "EltruismArcheology", nil, nil, nil, "ALL,SOLO,ELTREUMUI")

		if E.db.ElvUI_EltreumUI.skins.blizzframes.hideboss then
			_G.BossBanner:UnregisterAllEvents()
			E:DisableMover('BossBannerMover')
		end

		--based in elvui, attempt at preventing taints
		local editMode = _G.EditModeManagerFrame
		local registered = editMode.registeredSystemFrames
		if not InCombatLockdown() then
			for i = #registered, 1, -1 do
				local name = registered[i]:GetName()
				if name == "ObjectiveTrackerFrame" and E.db.ElvUI_EltreumUI.quests.anchor then
					if (not IsAddOnLoaded('!KalielsTracker')) and (not IsAddOnLoaded('SorhaQuestLog')) and (not IsAddOnLoaded('ClassicQuestLog')) and (not IsAddOnLoaded('Who Framed Watcher Wabbit?')) then
						tremove(editMode.registeredSystemFrames, i)
					end
				end
				if E.private.actionbar.enable then
					if name == "MainMenuBar" then
						tremove(editMode.registeredSystemFrames, i)
						_G.MainMenuBar.ApplySystemAnchor = nil
					end
					if name == "MultiBarBottomLeft" then
						tremove(editMode.registeredSystemFrames, i)
						--_G.MultiBarBottomLeft.SetPointBase = nil
					end
					if name == "MultiBarLeft" then
						tremove(editMode.registeredSystemFrames, i)
						--_G.MultiBarLeft.SetPointBase = nil
					end
					if name == "MultiBarBottomRight" then
						tremove(editMode.registeredSystemFrames, i)
						--_G.MultiBarBottomRight.SetPointBase = nil
					end
					if name == "MultiBarRight" then
						tremove(editMode.registeredSystemFrames, i)
						--_G.MultiBarRight.SetPointBase = nil
					end
					if name == "ExtraAbilityContainer" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "EncounterBar" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "StanceBar" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "PetActionBar" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "PossessActionBar" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "MainMenuBarVehicleLeaveButton" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "MultiBar5" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "MultiBar6" then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "MultiBar7" then
						tremove(editMode.registeredSystemFrames, i)
					end
				end
				if E.private.skins.blizzard.enable and E.private.skins.blizzard.loot then
					if name == "LootFrame" then
						tremove(editMode.registeredSystemFrames, i)
					end
				end
				if E.private.unitframe.enable then
					if name == "CompactRaidFrameContainer" and E.private.unitframe.disabledBlizzardFrames.raid then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "ArenaEnemyFramesContainer" and E.private.unitframe.disabledBlizzardFrames.arena then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "BossTargetFrameContainer" and E.private.unitframe.disabledBlizzardFrames.boss then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "PlayerFrame" and E.private.unitframe.disabledBlizzardFrames.player then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "TargetFrame" and E.private.unitframe.disabledBlizzardFrames.target then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "FocusFrame" and E.private.unitframe.disabledBlizzardFrames.focus then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "PartyFrame" and E.private.unitframe.disabledBlizzardFrames.party then
						tremove(editMode.registeredSystemFrames, i)
					end
					if name == "PlayerCastingBarFrame" and E.private.unitframe.disabledBlizzardFrames.castbar then
						tremove(editMode.registeredSystemFrames, i)
					end
				end

				--[[TalkingHeadFrame
				DurabilityFrame
				BagsBar
				ChatFrame1
				DebuffFrame
				BuffFrame
				MinimapCluster
				SecondaryStatusTrackingBarContainer
				MainStatusTrackingBarContainer
				MicroMenu
				GameTooltipDefaultContainer]]

			end
		end

		if (not IsAddOnLoaded('!KalielsTracker')) and (not IsAddOnLoaded('SorhaQuestLog')) and (not IsAddOnLoaded('ClassicQuestLog')) and (not IsAddOnLoaded('Who Framed Watcher Wabbit?')) then
			if E.db.ElvUI_EltreumUI.quests.anchor then
				E:Delay(0, function()
					if not _G["ObjectiveFrameHolder"] and not InCombatLockdown() then
						local holder = CreateFrame("FRAME", "ObjectiveFrameHolder", E.UIParent)
						holder:SetPoint("TOPRIGHT", E.UIParent, "TOPRIGHT", -135, -300)
						holder:SetSize(130, 22)

						Enum.EditModeObjectiveTrackerSetting.Height = E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight or 800
						ObjectiveTrackerFrame.editModeHeight = E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight or 800
						ObjectiveTracker_UpdateHeight()

						--test nil function to prevent it firing and causing taints
						--_G.ObjectiveTrackerFrame.ApplySystemAnchor = E.noop
						_G.ObjectiveTrackerFrame.ApplySystemAnchor = nil
						_G.ObjectiveTrackerFrame.AnchorSelectionFrame = nil
						_G.ObjectiveTrackerFrame.SetPointOverride = nil
						_G.ObjectiveTrackerFrame.isRightManagedFrame = false
						_G.ObjectiveTrackerFrame.breakSnappedFramesOnSave = false
						--[[_G.ObjectiveTrackerFrame.SnapToFrame = nil
						_G.ObjectiveTrackerFrame.ClearAllPointsOverride = nil
						--_G.ObjectiveTrackerFrame.SetPointBase = E.noop --causes issues for some people for some reason
						--_G.ObjectiveTrackerFrame.ClearAllPointsBase = nil
						local function returnfalse()
							return false
						end
						_G.ObjectiveTrackerFrame.CanBeMoved = returnfalse()]]

						_G.ObjectiveTrackerFrame:SetClampedToScreen(false)
						_G.ObjectiveTrackerFrame:SetMovable(true)
						_G.ObjectiveTrackerFrame:SetUserPlaced(true) -- UIParent.lua line 3090 stops it from being moved <
						_G.ObjectiveTrackerFrame:ClearAllPoints()
						_G.ObjectiveTrackerFrame:SetPoint("TOP", holder, "TOP")
						E:CreateMover(holder, "ObjectiveFrameMover", L["Objective Frame"], nil, nil, nil, "ALL,general,blizzUIImprovements", nil, 'ElvUI_EltreumUI,quests')
						ObjectiveTrackerFrame:UnregisterEvent("ADDON_ACTION_BLOCKED")

						local function SetObjectivePoint()
							E:Delay(0, function()
								if not InCombatLockdown() then
									_G.ObjectiveTrackerFrame.isRightManagedFrame = false
									_G.ObjectiveTrackerFrame.breakSnappedFramesOnSave = false
									_G.ObjectiveTrackerFrame:ClearAllPoints()
									_G.ObjectiveTrackerFrame:Point("TOP", holder, "TOP")
								end
							end)
							Enum.EditModeObjectiveTrackerSetting.Height = E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight or 800
							ObjectiveTrackerFrame.editModeHeight = E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight or 800
							ObjectiveTrackerFrame:SetHeight(E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight)
						end
						hooksecurefunc("ObjectiveTracker_UpdateHeight", SetObjectivePoint)

					end
				end)
			end
		end
	end
end

--World text Scale
function ElvUI_EltreumUI:WorldTextScale(value)
	E.db.ElvUI_EltreumUI.otherstuff.worldtextscale = value
	SetCVar('WorldTextScale', value)
end

--Set some CVars when entering world
function ElvUI_EltreumUI:EnteringWorldCVars()
	SetCVar('nameplateOtherBottomInset', E.db.ElvUI_EltreumUI.cvars.nameplateOtherBottomInset)
	SetCVar('nameplateOtherTopInset', E.db.ElvUI_EltreumUI.cvars.nameplateOtherTopInset)
	SetCVar('cameraDistanceMaxZoomFactor', E.db.ElvUI_EltreumUI.cvars.cameraDistanceMaxZoomFactor)
	SetCVar('nameplateTargetRadialPosition', E.db.ElvUI_EltreumUI.cvars.nameplateTargetRadialPosition)
	SetCVar('nameplateOccludedAlphaMult', E.db.ElvUI_EltreumUI.cvars.nameplateOccludedAlphaMult)
	SetCVar('DynamicRenderScaleMin', E.db.ElvUI_EltreumUI.cvars.dynamicrenderscalemin)
	if E.Retail and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable then
		SetCVar('showInGameNavigation', E.db.ElvUI_EltreumUI.cvars.showInGameNavigation)
	elseif E.Classic or E.Wrath then
		SetCVar('clampTargetNameplateToScreen', E.db.ElvUI_EltreumUI.cvars.clampTargetNameplateToScreen)
	end
end

function ElvUI_EltreumUI:AlternativeGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,199,-258"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,UIParent,TOPLEFT,4,-432"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,UIParent,TOPLEFT,104,-328"
		E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,7,-321"
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid1"]["height"] = 30
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_LEFT"
		--E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 10
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 2
		--E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 1
		--E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 25
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["width"] = 120
		E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 5
		E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid3"]["height"] = 30
		E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Alternative Group, Raid and Raid40 layout has been set"])

		E.db.ElvUI_EltreumUI.otherstuff.alternativegroups = true

		E:UpdateLayout()
		E:UpdateUnitFrames()
		E:UpdateMoverPositions()
	else
		ElvUI_EltreumUI:Print(L["The alternative layout was made for the Eltruism DPS/Tank profile, please switch to it to use it"])
	end
end

function ElvUI_EltreumUI:OriginalGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-247"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid1"]["height"] = 28
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 0
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid1"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["height"] = 28
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 6
		E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid3"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid3"]["height"] = 29
		E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["width"] = 120
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3

		ElvUI_EltreumUI:Print(L["Original Group, Raid and Raid40 layout has been set"])

		E.db.ElvUI_EltreumUI.otherstuff.alternativegroups = false

		E:UpdateLayout()
		E:UpdateUnitFrames()
		E:UpdateMoverPositions()
	else
		ElvUI_EltreumUI:Print(L["The original layout was made for the Eltruism DPS/Tank profile, please switch to it to use it"])
	end
end

--Better EventTrace CLEU logging thanks to ;Meorawr.wtf.lua;
function ElvUI_EltreumUI:DevTools()
	if E.db.ElvUI_EltreumUI.dev then
		--addon specific cpu/memory usage
		--/run UpdateAddOnCPUUsage() UpdateAddOnMemoryUsage() print("cpu: "..((math.floor(GetAddOnCPUUsage("ElvUI_EltreumUI")))).."ms | memory: "..((math.floor(GetAddOnMemoryUsage("ElvUI_EltreumUI")/10))/100).."mb")

		local function LogEvent(frame, event, ...)
			if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then
				frame:LogEvent_Original(event, CombatLogGetCurrentEventInfo())
			elseif event == "COMBAT_TEXT_UPDATE" then
				frame:LogEvent_Original(event, (...), GetCurrentCombatTextEventInfo())
			else
				frame:LogEvent_Original(event, ...)
			end
		end

		local function OnEventTraceLoaded()
			EventTrace.LogEvent_Original = EventTrace.LogEvent
			EventTrace.LogEvent = LogEvent
		end

		if EventTrace then
			OnEventTraceLoaded()
		else
			local frame = CreateFrame("Frame")
			frame:RegisterEvent("ADDON_LOADED")
			frame:SetScript("OnEvent", function(_, event, ...)
				if event == "ADDON_LOADED" and (...) == "Blizzard_EventTrace" then
					OnEventTraceLoaded()
					if not IsAddOnLoaded("Blizzard_DebugTools") then
						UIParentLoadAddOn("Blizzard_DebugTools")
					end
					TableAttributeDisplay:SetWidth(800)
					TableAttributeDisplay.LinesScrollFrame:SetWidth(700)
					TableAttributeDisplay.TitleButton.Text:SetWidth(600)
					frame:UnregisterAllEvents()
				end
			end)
		end
	end
end

--fix the toggles hiding when chat panels hide
function ElvUI_EltreumUI:FixChatToggles()
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then

		if E.db.ElvUI_EltreumUI.chat.chattoggles then
			_G.LeftChatToggleButton:SetAlpha(1)
			_G.LeftChatToggleButton:Show()
			_G.RightChatToggleButton:SetAlpha(1)
			_G.RightChatToggleButton:Show()
		end

		--fix if the value changed since install
		local buttonwidth = _G.RightChatToggleButton:GetWidth()
		--local width = GetPhysicalScreenSize()
		local width = ceil(E.screenWidth)
		if E.global["datatexts"]["customPanels"]["EltruismDataText"] then
			if E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] >= width then
				if E.db.ElvUI_EltreumUI.chat.chattoggles then
					E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = 2 + math.ceil(width - (buttonwidth * 2))
				else
					E.global["datatexts"]["customPanels"]["EltruismDataText"]["width"] = math.ceil(width)
				end
				E:UpdateDataTexts()
			end
		end
	end
end

do
	local throttle = 0
	local function ClearThrottle()
		throttle = 0
	end

	local function TypeDelete()
		local _, _, itemLink = GetCursorInfo()
		if not itemLink then return end

		local lootName, _, _, _, _, _, _, _, _, lootTexture = GetItemInfo(itemLink)
		if itemLink:match("|Hbattlepet:") then
			lootName, _, _, _, _, _, _, _, _, lootTexture = GetItemInfo(82800)
		end
		if not (lootName and lootTexture) then return end

		local text = _G.StaticPopup1Text:GetText()
		if not text:match("|T") then
			local deletetext = string.gsub(text, lootName, "|T"..lootTexture..":".. 14 .."|t"..itemLink.."")
			_G.StaticPopup1Text:SetText(deletetext)
		end

		_G.StaticPopup1.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) --from line 2028

		if throttle == 0 then
			throttle = 1
			ElvUI_EltreumUI:Print("DELETE automatically typed")
			E:Delay(1, ClearThrottle)
		end
	end

	local isDeleteHooked = false
	local petdetect = CreateFrame("FRAME")
	function ElvUI_EltreumUI:DeleteItem()
		if not isDeleteHooked and E.db.ElvUI_EltreumUI.otherstuff.delete and not IsAddOnLoaded("ConsolePort") then
			hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_ITEM,"OnShow",TypeDelete) --Interface/FrameXML/StaticPopup.lua line 1965/2074
			hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_QUEST_ITEM,"OnShow",TypeDelete) --Interface/FrameXML/StaticPopup.lua line 2125

			if E.Retail then
				petdetect:RegisterEvent("DELETE_ITEM_CONFIRM")
				petdetect:SetScript("OnEvent", function(_,_,deletetype)
					if deletetype == "Pet Cage" then
						TypeDelete()
					end
				end)
			end

			isDeleteHooked = true
		end
	end
end

--from elvui api
local EltruismMenuButton = CreateFrame('Button', nil, GameMenuFrame, 'GameMenuButtonTemplate')
local isMenuExpanded = false
local EltruismGameMenu = CreateFrame("Frame")
EltruismGameMenu:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismGameMenu:SetScript("OnEvent", function()

	--use elvui moveui instead of blizzard edit mode
	if _G.GameMenuButtonEditMode and E.db.ElvUI_EltreumUI.otherstuff.gamemenu then
		_G.GameMenuButtonEditMode:RegisterForClicks("AnyUp")
		_G.GameMenuButtonEditMode:SetScript("OnClick", function(_, button)
			if not InCombatLockdown() then
				if button == "LeftButton" then
					E:ToggleMoveMode()
					HideUIPanel(_G["GameMenuFrame"])
				else
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION);
					ShowUIPanel(EditModeManagerFrame);
				end
			end
		end)
	end

	if E.db.ElvUI_EltreumUI.otherstuff.gamemenu and isMenuExpanded == false then
		EltruismMenuButton:SetText("|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:12:12:0:0:64:64|t".. ElvUI_EltreumUI.Name) --new 64x64 icon
		S:HandleButton(EltruismMenuButton)
		local x, y = _G["GameMenuButtonLogout"]:GetSize()
		EltruismMenuButton:SetSize(x,y)
		EltruismMenuButton:SetScript("OnClick", function()
			if not InCombatLockdown() then
				E:ToggleOptions()
				E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
				HideUIPanel(_G["GameMenuFrame"])
			end
		end)

		hooksecurefunc('GameMenuFrame_UpdateVisibleButtons', function ()
			EltruismMenuButton:Point("TOP", GameMenuFrame.ElvUI, "BOTTOM", 0, -1)
			if _G["GameMenu_SLEConfig"] and not _G["GameMenuReloadUI"] and not _G.TXUI_GAME_BUTTON then
				EltruismMenuButton:Point("TOP", _G["GameMenu_SLEConfig"], "BOTTOM", 0, -1)
			elseif _G["GameMenuReloadUI"] and not _G.TXUI_GAME_BUTTON then
				EltruismMenuButton:Point("TOP", _G["GameMenuReloadUI"], "BOTTOM", 0, -1)
			elseif _G.TXUI_GAME_BUTTON then
				EltruismMenuButton:Point("TOP", _G.TXUI_GAME_BUTTON, "BOTTOM", 0, -1)
			elseif _G["GameMenuFrame"].GameMenu_TXUI then
				EltruismMenuButton:Point("TOP", _G["GameMenuFrame"].GameMenu_TXUI, "BOTTOM", 0, -1)
			end
		end)

		_G["GameMenuFrame"]:HookScript("OnShow", function()
			_G["GameMenuButtonLogout"]:ClearAllPoints()
			_G["GameMenuButtonLogout"]:SetPoint("TOP", EltruismMenuButton, "BOTTOM", 0, -y)
			_G["GameMenuFrame"]:SetHeight(_G["GameMenuFrame"]:GetHeight() + _G["GameMenuButtonLogout"]:GetHeight() + 4)
		end)
		isMenuExpanded = true
	end
end)

--make the video options movable because its annoying when adjusting settings
local VideoOptionsFrame = _G.VideoOptionsFrame --Classic/Wrath
if VideoOptionsFrame then
	VideoOptionsFrame:SetMovable(true)
	VideoOptionsFrame:EnableMouse(true)
	VideoOptionsFrame:RegisterForDrag("LeftButton")
	VideoOptionsFrame:SetScript("OnDragStart", VideoOptionsFrame.StartMoving)
	VideoOptionsFrame:SetScript("OnDragStop", VideoOptionsFrame.StopMovingOrSizing)
	VideoOptionsFrame:SetClampedToScreen(true)
end
local SettingsPanel = _G.SettingsPanel --Dragonflight
if SettingsPanel then
	SettingsPanel:SetMovable(true)
	SettingsPanel:EnableMouse(true)
	SettingsPanel:RegisterForDrag("LeftButton")
	SettingsPanel:SetScript("OnDragStart", SettingsPanel.StartMoving)
	SettingsPanel:SetScript("OnDragStop", SettingsPanel.StopMovingOrSizing)
	SettingsPanel:SetClampedToScreen(true)
end

--click casting button toggle
if E.Retail then
	local clickbindopenbutton = CreateFrame("Button", "EltruismClickCastingToggle")
	clickbindopenbutton:SetWidth(32)
	clickbindopenbutton:SetHeight(32)
	clickbindopenbutton:SetParent(_G["SpellBookSpellIconsFrame"])
	clickbindopenbutton:SetPoint("LEFT", _G["SpellBookFrame"], "RIGHT", 0, -105)
	if _G["CliqueSpellTab"] then
		clickbindopenbutton:SetPoint("BOTTOM", _G["CliqueSpellTab"], 0, -50)
	end

	S:HandleButton(clickbindopenbutton)
	local bindexture = clickbindopenbutton:CreateTexture()
	--bindexture:SetTexture(4238928)
	bindexture:SetTexture("interface\\cursor\\crosshair\\cast")
	bindexture:SetTexCoord(0.08,0.92,0.08,0.92)
	bindexture:SetAllPoints(clickbindopenbutton)
	clickbindopenbutton:RegisterForClicks("AnyUp")

	clickbindopenbutton:SetScript("OnEnter", function()
		_G["GameTooltip"]:SetOwner(clickbindopenbutton, 'ANCHOR_RIGHT')
		_G["GameTooltip"]:AddLine(L["Toggle the Click Casting Menu"])
		_G["GameTooltip"]:Show()
	end)
	clickbindopenbutton:SetScript("OnLeave", function()
		_G["GameTooltip"]:Hide()
	end)

	clickbindopenbutton:SetScript('OnClick', function()
		if not IsAddOnLoaded("Blizzard_ClickBindingUI") then
			LoadAddOn("Blizzard_ClickBindingUI")
			if not _G["ClickBindingFrame"].shadow then
				_G["ClickBindingFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["ClickBindingFrame"].shadow)
			end
		end
		if not _G["ClickBindingFrame"]:IsShown() then
			_G["ClickBindingFrame"]:Show()
		elseif _G["ClickBindingFrame"]:IsShown() then
			_G["ClickBindingFrame"]:Hide()
			_G["SpellBookFrame"]:Show()
		end
		_G["ClickBindingFrame"]:ClearAllPoints()
		_G["ClickBindingFrame"]:SetParent(_G["SpellBookFrame"])
		_G["ClickBindingFrame"]:SetPoint("LEFT", _G["SpellBookFrame"], "RIGHT", 50, -37)
	end)
end

--shadow and light compatibility check
function ElvUI_EltreumUI:SLCheck(setting)
	if not IsAddOnLoaded("ElvUI_SLE") or not setting then return false end
	if setting == 'char' and E.db.sle.armory.character.enable then
		return true
	end
	if setting == 'stats' and E.private.sle.armory.stats.enable then
		return true
	end
	if setting == 'inspect' and E.db.sle.armory.inspect.enable then
		return true
	end
	if setting == 'media' and E.private.sle.media.enable then
		return true
	end
	if setting == 'quest' and E.private.sle.skins.objectiveTracker.enable then
		return true
	end

	return false
end

--check for blinkii's kick on cd function
function ElvUI_EltreumUI:CheckmMediaTagInterrupt()
	if IsAddOnLoaded("ElvUI_mMediaTag") then
		if (E.db.mMT and E.db.mMT.interruptoncd and E.db.mMT.interruptoncd.enable) then
			local mMT = E:GetModule("ElvUI_mMediaTag")
			return mMT:mMediaTag_interruptOnCD() or false
		else
			return false
		end
	else
		return false
	end
end

--10.1 addon compartment
function ElvUI_EltreumUI_OnAddonCompartmentClick()
	E:ToggleOptions()
	E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
end

--for fps testing
--[[
local framerate = CreateFrame("Frame", nil, UIParent)
framerate.TimeText = framerate:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
framerate.TimeText:SetJustifyV("TOP")
framerate.TimeText:SetSize(0, 26)
framerate.TimeText:SetPoint("CENTER", UIParent, "CENTER",0, 400)
framerate.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), 36, E.db.general.fontStyle)
framerate.TimeText:SetTextColor(1,1,1)
UIParent.ClearAllPoints(FramerateText)
_G.FramerateText:SetPoint("RIGHT",UIParent,"CENTER",0, 2035)
_G.FramerateLabel:SetText("")
ToggleFramerate()

framerate:SetScript("OnUpdate", function()
	_G.FRAMERATE_FREQUENCY = 0.1
	if _G.FramerateText:GetText() ~= nil then
		if tonumber(_G.FramerateText:GetText()) < 60 then
			framerate.TimeText:SetTextColor(1,0,0)
			framerate.TimeText:SetText(_G.FramerateText:GetText())
		elseif tonumber(_G.FramerateText:GetText()) > 60 then
			framerate.TimeText:SetTextColor(1,1,1)
			framerate.TimeText:SetText(_G.FramerateText:GetText())
		end
	end
end)
]]
