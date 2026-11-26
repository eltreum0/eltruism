local E, L = unpack(ElvUI)
local valuecolors = E.myClassColor
local _G = _G
local CreateFrame = _G.CreateFrame
local CreateColor = _G.CreateColor
local IsPlayerMoving = _G.IsPlayerMoving
local gsub = _G.gsub
local Enum = _G.Enum
local InCombatLockdown = _G.InCombatLockdown
local hooksecurefunc = _G.hooksecurefunc
local MAP_PIN = _G.MAP_PIN
local math = _G.math
local mathabs = math.abs
local mathfloor = math.floor
local string = _G.string

--Conversion of Time to Arrive weakaura (new version)
local C_Map = _G.C_Map
local C_SuperTrack = _G.C_SuperTrack
local GetUnitSpeed = _G.GetUnitSpeed
local C_Navigation = _G.C_Navigation
local GetCVar = _G.C_CVar and _G.C_CVar.GetCVar or _G.GetCVar
local GetTime = _G.GetTime
local GetCursorPosition = _G.GetCursorPosition
local GetScreenWidth = _G.GetScreenWidth
local GetScreenHeight = _G.GetScreenHeight
local UIParent = _G.UIParent
local ClampedPercentageBetween = _G.ClampedPercentageBetween
local FrameDeltaLerp = _G.FrameDeltaLerp
local Mixin = _G.Mixin
local mathmin = math.min
local stringlen = string.len
local stringformat = string.format
local stringmatch = string.match
local tonumber = _G.tonumber
local table = _G.table
local tinsert = table.insert
local tconcat = table.concat
local wipe = _G.wipe
local UiMapPoint = _G.UiMapPoint
local C_QuestLog = _G.C_QuestLog
local GetQuestLogCompletionText = _G.GetQuestLogCompletionText
local GetQuestProgressBarPercent = _G.GetQuestProgressBarPercent
local QUEST_WATCH_QUEST_READY = _G.QUEST_WATCH_QUEST_READY
local QUEST_WATCH_QUEST_COMPLETE = _G.QUEST_WATCH_QUEST_COMPLETE
local FAILED = _G.FAILED

local useFallbackNavFrame = (E.Forever or (GetCVar and GetCVar("showInGameNavigation") == nil)) and _G.SuperTrackedFrameMixin ~= nil
local EltruismSuperTrackedFrame
if useFallbackNavFrame then --clone blizzard's SuperTrackedFrame
	EltruismSuperTrackedFrame = CreateFrame("Frame", "EltruismSuperTrackedFrame", E.UIParent)
	EltruismSuperTrackedFrame:SetFrameStrata("BACKGROUND")
	EltruismSuperTrackedFrame:SetSize(100, 100)
	EltruismSuperTrackedFrame:Hide()

	EltruismSuperTrackedFrame.Icon = EltruismSuperTrackedFrame:CreateTexture(nil, "BACKGROUND")
	EltruismSuperTrackedFrame.Icon:SetAtlas("Navigation-Tracked-Icon", true)
	EltruismSuperTrackedFrame.Icon:SetPoint("CENTER")

	EltruismSuperTrackedFrame.Arrow = EltruismSuperTrackedFrame:CreateTexture(nil, "BACKGROUND")
	EltruismSuperTrackedFrame.Arrow:SetAtlas("Navigation-Tracked-Arrow", true)
	EltruismSuperTrackedFrame.Arrow:SetPoint("CENTER", 0, 60)
	EltruismSuperTrackedFrame.Arrow:Hide()

	EltruismSuperTrackedFrame.DistanceText = EltruismSuperTrackedFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	EltruismSuperTrackedFrame.DistanceText:SetJustifyV("TOP")
	EltruismSuperTrackedFrame.DistanceText:SetSize(0, 20)
	EltruismSuperTrackedFrame.DistanceText:SetPoint("TOP", EltruismSuperTrackedFrame.Icon, "BOTTOM", 0, -8)

	EltruismSuperTrackedFrame.IconBorder = EltruismSuperTrackedFrame:CreateTexture(nil, "OVERLAY")
	EltruismSuperTrackedFrame.IconBorder:SetPoint("TOPLEFT", EltruismSuperTrackedFrame.Icon, "TOPLEFT", -12, 12)
	EltruismSuperTrackedFrame.IconBorder:SetPoint("BOTTOMRIGHT", EltruismSuperTrackedFrame.Icon, "BOTTOMRIGHT", 12, -12)
	EltruismSuperTrackedFrame.IconBorder:Hide()

	Mixin(EltruismSuperTrackedFrame, _G.SuperTrackedFrameMixin)

	function EltruismSuperTrackedFrame:UpdateClampedState()
		local clamped = false
		if self.navFrame then
			local frameX, frameY = self.navFrame:GetCenter()
			if frameX and frameY then
				local screenWidth, screenHeight = GetScreenWidth(), GetScreenHeight()
				clamped = mathmin(frameX / screenWidth, (screenWidth - frameX) / screenWidth, (screenHeight - frameY) / screenHeight, frameY / screenHeight) < 0.05
			end
		end
		self.clampedChanged = clamped ~= self.isClamped
		self.isClamped = clamped
	end

	function EltruismSuperTrackedFrame:GetTargetAlphaBaseValue()
		if not C_SuperTrack.IsSuperTrackingAnything() then return 0 end

		local instanceType = ElvUI_EltreumUI:IsInInstance(nil, nil, nil, true)
		if instanceType ~= "none" and instanceType ~= "neighborhood" then return 0 end

		local d = C_Navigation.GetDistance()
		if not d or d <= 0 then return 0 end

		if d < 10 then
			if C_SuperTrack.IsSuperTrackingUserWaypoint() and not InCombatLockdown() then
				C_Map.ClearUserWaypoint()
			end
			return 0
		end

		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.limitmaxdistance and d > E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance then
			return 0
		end

		if C_Navigation.GetTargetState() == Enum.NavigationState.Occluded and not self.isClamped then
			return 0.6
		end

		return 1.0
	end

	function EltruismSuperTrackedFrame:GetTargetAlpha()
		if not self.navFrame or not self.navFrame:GetCenter() then return 0 end

		if self.transparentUntil and self.transparentUntil > GetTime() then
			return 0
		end
		self.transparentUntil = nil

		local additionalFade = 1.0
		if self:IsMouseOver() then
			local mouseX, mouseY = GetCursorPosition()
			local scale = UIParent:GetEffectiveScale()
			mouseX = mouseX / scale
			mouseY = mouseY / scale
			local centerX, centerY = self:GetCenter()
			self.mouseToNavVec:SetXY(mouseX - centerX, mouseY - centerY)
			local mouseToNavDistanceSq = self.mouseToNavVec:GetLengthSquared()
			additionalFade = ClampedPercentageBetween(mouseToNavDistanceSq, 0, self.navFrameRadiusSq * 2)
		end

		return FrameDeltaLerp(self:GetAlpha(), self:GetTargetAlphaBaseValue() * additionalFade, 0.1)
	end

	function EltruismSuperTrackedFrame:UpdateOnUpdateState()
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil, nil, nil, true)
		if self.navFrame and (instanceType == "none" or instanceType == "neighborhood") then
			self:SetScript("OnUpdate", self.OnUpdate)
		else
			self:SetScript("OnUpdate", nil)
			self:SetAlpha(0)
		end
	end

	function EltruismSuperTrackedFrame:InitializeNavigationFrame()
		self.navFrame = C_Navigation.GetFrame()
		self.isClamped = false
		self.clampedChanged = false

		if self.navFrame then
			self:ClearAllPoints()
			self:SetPoint("CENTER", self.navFrame)
			self:UpdateIcon()
			self:SetEllipticalRadii(500, 200)
		end

		self:UpdateOnUpdateState()
	end

	function EltruismSuperTrackedFrame:ShutdownNavigationFrame()
		self:ClearAllPoints()
		self.navFrame = nil
		self:SetScript("OnUpdate", nil)
		self:SetAlpha(0)
	end

	function EltruismSuperTrackedFrame:OnEvent(event)
		if event == "NAVIGATION_FRAME_CREATED" then
			self:InitializeNavigationFrame()
		elseif event == "NAVIGATION_FRAME_DESTROYED" then
			self:ShutdownNavigationFrame()
		elseif event == "SUPER_TRACKING_CHANGED" then
			self:CheckInitializeNavigationFrame()
			self:UpdateIcon()
			self:ForceTransparentUntil(GetTime() + 0.2)
			self:UpdateOnUpdateState()
		elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then
			self:CheckInitializeNavigationFrame()
			self:UpdateOnUpdateState()
		end
	end

	function EltruismSuperTrackedFrame:EnableFallback()
		if self.fallbackEnabled then return end
		self.fallbackEnabled = true

		self:OnLoad()
		self:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self:SetScript("OnEvent", self.OnEvent)
		self:SetAlpha(0)
		self:Show()
		self:CheckInitializeNavigationFrame()
		self:UpdateOnUpdateState()
	end
end

local SuperTrackedFrame = useFallbackNavFrame and EltruismSuperTrackedFrame or _G.SuperTrackedFrame
if SuperTrackedFrame then --if not the main one and not the fallback dont do anything
	local EltruismAutopin
	local EltruismTimeToArriveParent
	local EltruismTimeToArrive
	local waypointArrow = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\ArrowEltruism.tga"
	local waypointIcons = {
		[Enum.SuperTrackingType.Quest] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\Quest.tga",
		[Enum.SuperTrackingType.UserWaypoint] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\UserWaypoint.tga",
		[Enum.SuperTrackingType.Corpse] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\Corpse.tga",
		[Enum.SuperTrackingType.Scenario] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\Scenario.tga",
		[Enum.SuperTrackingType.Content] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\Content.tga",
		[Enum.SuperTrackingType.MapPin] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\MapPin.tga",
		[Enum.SuperTrackingType.Vignette] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Waypoints\\Vignette.tga",
	}
	local eltruismGradBottom = CreateColor(0.219, 0.594, 0.991, 1)
	local eltruismGradTop = CreateColor(0.784, 0.965, 1, 1)

	local function IsPartyMemberPortrait()
		return C_SuperTrack.GetHighestPrioritySuperTrackingType() == Enum.SuperTrackingType.PartyMember and C_Navigation.GetNearestPartyMemberToken() ~= nil
	end

	local function ApplySuperTrackedIcon()
		if not (E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.customicons) then
			return
		end

		SuperTrackedFrame.Arrow:SetTexture(waypointArrow)
		SuperTrackedFrame.Arrow:SetTexCoord(0, 1, 0, 1)
		SuperTrackedFrame.Arrow:SetSize(24, 24)

		if not IsPartyMemberPortrait() then
			local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType() or Enum.SuperTrackingType.Quest
			SuperTrackedFrame.Icon:SetTexture(waypointIcons[superTrackingType] or waypointIcons[Enum.SuperTrackingType.Quest])
			SuperTrackedFrame.Icon:SetTexCoord(0, 1, 0, 1)
			SuperTrackedFrame.Icon:SetSize(32, 32)
			SuperTrackedFrame:UpdateIconSize()
		end

		ElvUI_EltreumUI:UpdateSuperTrackedColor()
	end

	SuperTrackedFrame.DistanceText:SetTextColor(1,1,1)
	SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

	local function CreateWaypointFrames()
		EltruismAutopin = CreateFrame("Frame", "EltruismAutoPin")
		EltruismTimeToArriveParent = CreateFrame("Frame", "EltruismTimeToArriveParent")
		EltruismTimeToArriveParent:RegisterEvent("PLAYER_ENTERING_WORLD")
		EltruismTimeToArrive = CreateFrame("Frame", "EltruismTimeToArrive", E.UIParent)
		EltruismTimeToArrive.TimeText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
		EltruismTimeToArrive.TimeText:SetJustifyV("TOP")
		EltruismTimeToArrive.TimeText:SetSize(0, 26)
		EltruismTimeToArrive.TimeText:SetPoint("TOP", SuperTrackedFrame, "BOTTOM", 0, 7)
		EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		EltruismTimeToArrive.TimeText:SetParent(SuperTrackedFrame)
		EltruismTimeToArrive.WaypointText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
		EltruismTimeToArrive.WaypointText:SetJustifyV("TOP")
		EltruismTimeToArrive.WaypointText:SetSize(0, 26)
		EltruismTimeToArrive.WaypointText:SetPoint("TOP", SuperTrackedFrame, "BOTTOM", 0, -9)
		EltruismTimeToArrive.WaypointText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		EltruismTimeToArrive.WaypointText:SetParent(SuperTrackedFrame)
		EltruismTimeToArrive.QuestText = EltruismTimeToArrive:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
		EltruismTimeToArrive.QuestText:SetJustifyV("TOP")
		EltruismTimeToArrive.QuestText:SetWidth(300)
		EltruismTimeToArrive.QuestText:SetSpacing(2)
		EltruismTimeToArrive.QuestText:SetPoint("TOP", EltruismTimeToArrive.WaypointText, "TOP", 0, -(E.db.general.fontSize + 4))
		EltruismTimeToArrive.QuestText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		EltruismTimeToArrive.QuestText:SetTextColor(1, 1, 1)
		EltruismTimeToArrive.QuestText:SetParent(SuperTrackedFrame)
		EltruismTimeToArrive:SetParent(SuperTrackedFrame)
	end

	--set the throttle
	local ONUPDATE_INTERVAL = 1
	local TimeSinceLastUpdate = 0

	function ElvUI_EltreumUI:SpeedCheckDelayed()
		local previousdistance = C_Navigation.GetDistance()
		local speed = mathabs(EltruismTimeToArrive.SavedDistance - previousdistance)
		local seconds = 0
		local minutes = 0
		if speed and speed > 0 then
			local eta= mathabs(EltruismTimeToArrive.SavedDistance / speed)
			if eta > 600 then
				minutes = stringformat("%02.f", mathfloor(eta/60 ))
				seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
			elseif eta < 600 and eta > 10 then
				minutes = stringformat("%01.f", mathfloor(eta/60))
				seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
			elseif eta < 10 then
				minutes = stringformat("%01.f", mathfloor(eta/60))
				seconds = stringformat("%1.d", mathfloor(eta - minutes *60))
			else
				minutes = stringformat("%02.f", mathfloor(eta/60))
				seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
			end
		end
		--set the time to arrive to the frame's text
		if minutes == 0 and seconds == 0 then
			EltruismTimeToArrive.TimeText:SetText("***")
		elseif minutes < "01" and seconds > "0" then
			EltruismTimeToArrive.TimeText:SetText(seconds.."s")
		else
			EltruismTimeToArrive.TimeText:SetText(minutes.."m"..":"..seconds.."s")
		end
	end

	local questSteps = {}
	local completeHex = E:RGBToHex(0.12, 1, 0.12)
	local failedHex = E:RGBToHex(1, 0, 0)

	local function GetSuperTrackedQuestSteps()
		if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= Enum.SuperTrackingType.Quest then
			return ""
		end

		local questID = C_SuperTrack.GetSuperTrackedQuestID()
		if not questID or questID <= 0 then
			return ""
		end

		wipe(questSteps)

		if C_QuestLog.IsFailed(questID) then
			tinsert(questSteps, stringformat("%s%s|r", failedHex, FAILED))
		elseif C_QuestLog.IsComplete(questID) then
			local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
			local questInfo = questLogIndex and C_QuestLog.GetInfo(questLogIndex)
			if questInfo and questInfo.isAutoComplete then
				tinsert(questSteps, stringformat("%s%s|r", completeHex, QUEST_WATCH_QUEST_COMPLETE))
			else
				local waypointText = C_QuestLog.GetNextWaypointText(questID)
				local completionText = questLogIndex and GetQuestLogCompletionText(questLogIndex)
				if waypointText and waypointText ~= "" then
					tinsert(questSteps, waypointText)
				end
				if completionText and completionText ~= "" and completionText ~= waypointText then
					tinsert(questSteps, stringformat("%s%s|r", completeHex, completionText))
				end
				if #questSteps == 0 then
					tinsert(questSteps, stringformat("%s%s|r", completeHex, QUEST_WATCH_QUEST_READY))
				end
			end
		else
			local waypointText = C_QuestLog.GetNextWaypointText(questID)
			if waypointText and waypointText ~= "" then
				tinsert(questSteps, waypointText)
			end

			local objectives = C_QuestLog.GetQuestObjectives(questID)
			if objectives then
				for i = 1, #objectives do
					local objective = objectives[i]
					if not objective.finished and objective.text and objective.text ~= "" then
						local text = objective.text
						if objective.type == "progressbar" and not stringmatch(text, "%%") then
							text = stringformat("%s (%d%%)", text, mathfloor(GetQuestProgressBarPercent(questID)))
						end
						local coloredText = ElvUI_EltreumUI:ColorQuestStep(text)
						tinsert(questSteps, coloredText or text)
					end
				end
			end
		end

		return #questSteps > 0 and tconcat(questSteps, "\n") or ""
	end

	local function UpdateSuperTrackedText()
		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.waypointname then
			local name = C_SuperTrack.GetSuperTrackedItemName()
			if not name or name == MAP_PIN then
				if EltruismTimeToArrive.WaypointText:GetText() ~= "" then
					EltruismTimeToArrive.WaypointText:SetText("")
				end
			elseif name ~= EltruismTimeToArrive.WaypointText:GetText() then
				EltruismTimeToArrive.WaypointText:SetText(name)
			end

			local questText = GetSuperTrackedQuestSteps()
			if questText ~= EltruismTimeToArrive.QuestText:GetText() then
				EltruismTimeToArrive.QuestText:SetText(questText)
			end
		end
	end

	--use throttled onupdate to udpate the text (once per second)
	function ElvUI_EltreumUI:TimeToArriveOnUpdate(elapsed)
		TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
		if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
			TimeSinceLastUpdate = 0

			local notsafe
			local speed = 0

			--player speed can be secret, so protect in case there is a waypoint when it is
			local currentSpeed, _, flyspeed = GetUnitSpeed("player")
			if ElvUI_EltreumUI:IsThisASafeSecret(currentSpeed,true) then
				notsafe = false
				speed = currentSpeed or GetUnitSpeed("vehicle")
				if not speed or speed == 0 then
					speed = flyspeed
				end
			else
				notsafe = true
			end

			--add objective text
			UpdateSuperTrackedText()

			--calculate time to arrive
			local distance = C_Navigation.GetDistance()
			EltruismTimeToArrive.SavedDistance = distance
			local seconds = 0
			local minutes = 0
			if IsPlayerMoving() or _G.UnitOnTaxi("player") then
				if (not speed or speed == 0) or notsafe then --might be dragonflying or secret, calculate based on delta distance
					E:Delay(1, ElvUI_EltreumUI.SpeedCheckDelayed)
				else
					if speed and speed > 0 then
						local eta= mathabs(distance / speed)
						if eta > 600 then
							minutes = stringformat("%02.f", mathfloor(eta/60 ))
							seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
						elseif eta < 600 and eta > 10 then
							minutes = stringformat("%01.f", mathfloor(eta/60))
							seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
						elseif eta < 10 then
							minutes = stringformat("%01.f", mathfloor(eta/60))
							seconds = stringformat("%1.d", mathfloor(eta - minutes *60))
						else
							minutes = stringformat("%02.f", mathfloor(eta/60))
							seconds = stringformat("%02.f", mathfloor(eta - minutes *60))
						end
					end
					--set the time to arrive to the frame's text
					if minutes == 0 and seconds == 0 then
						EltruismTimeToArrive.TimeText:SetText("***")
					elseif minutes < "01" and seconds > "0" then
						EltruismTimeToArrive.TimeText:SetText(seconds.."s")
					else
						EltruismTimeToArrive.TimeText:SetText(minutes.."m"..":"..seconds.."s")
					end
				end
			else --not moving at all
				EltruismTimeToArrive.TimeText:SetText("***")
			end
		end
	end

	function ElvUI_EltreumUI:WaypointTimeToArrive()
		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable then
			if not EltruismTimeToArrive then CreateWaypointFrames() end
			if not EltruismAutopin.AutopinRegistered and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.autopin then
				EltruismAutopin:RegisterEvent("USER_WAYPOINT_UPDATED")
				EltruismAutopin:RegisterEvent("PLAYER_ENTERING_WORLD") --doesnt seem to fire
				EltruismAutopin:RegisterEvent("PLAYER_STARTED_MOVING")
				EltruismAutopin:RegisterEvent("ZONE_CHANGED")
				--EltruismAutopin:SetScript("OnEvent", function(_, event)
				EltruismAutopin:SetScript("OnEvent", function()
					EltruismAutopin:UnregisterEvent("PLAYER_STARTED_MOVING")
					if InCombatLockdown() then return end --check for combat due to taint
					local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
					--print(instanceType,event,"autopin")
					if instanceType ~= "none" then --clears waypoints inside instances
						C_Map.ClearUserWaypoint()
					elseif instanceType == "none" then --is in the open world
						--if event == "USER_WAYPOINT_UPDATED" and C_Map.HasUserWaypoint() then
						if C_Map.HasUserWaypoint()then
							E:Delay(0, function()
								if not InCombatLockdown() then --check for combat again due to taint
									C_SuperTrack.SetSuperTrackedUserWaypoint(true)
								end
							end)
						end
					end
				end)
				EltruismAutopin.AutopinRegistered = true
			end

			--try to fix issue where the MapCanvasPinMixin:SetPassThroughButtons() will throw a taint

			--[[WorldMapMixin.SetPassThroughButtons = E.noop
			WorldMapMixin.CheckMouseButtonPassthrough = E.noop
			WorldMapMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.WorldMapFrame.SetPassThroughButtons = E.noop
			_G.WorldMapFrame.CheckMouseButtonPassthrough = E.noop
			_G.WorldMapFrame.ShouldMouseButtonBePassthrough = E.noop]]

			_G.SuperTrackablePinMixin.SetPropagateMouseClicks = E.noop --this is new [TOGGLEWORLDMAP]:1: in function <[string "TOGGLEWORLDMAP"]:1>
			_G.SuperTrackablePinMixin.UpdateMousePropagation = E.noop --this is new [TOGGLEWORLDMAP]:1: in function <[string "TOGGLEWORLDMAP"]:1>
			_G.SuperTrackablePinMixin.SetPassThroughButtons = E.noop --this is new [TOGGLEWORLDMAP]:1: in function <[string "TOGGLEWORLDMAP"]:1>
			_G.SuperTrackablePinMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.WorldQuestPinMixin.SetPassThroughButtons = E.noop
			_G.WorldQuestPinMixin.CheckMouseButtonPassthrough = E.noop
			_G.WorldQuestPinMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.MapCanvasPinMixin.SetPassThroughButtons = E.noop
			_G.MapCanvasPinMixin.CheckMouseButtonPassthrough = E.noop
			_G.MapCanvasPinMixin.ShouldMouseButtonBePassthrough = E.noop
			_G.WaypointLocationPinMixin.SetPassThroughButtons = E.noop
			_G.WaypointLocationPinMixin.CheckMouseButtonPassthrough = E.noop
			_G.WaypointLocationPinMixin.ShouldMouseButtonBePassthrough = E.noop

			if not SuperTrackedFrame.EltruismIconHook then
				hooksecurefunc(SuperTrackedFrame, "UpdateIcon", ApplySuperTrackedIcon)
				SuperTrackedFrame.EltruismIconHook = true
			end

			--remove max distance
			if useFallbackNavFrame then
				SuperTrackedFrame:EnableFallback()
			elseif not SuperTrackedFrame.EltruismHook then

				--blizzard restricts waypoints, unrestrict them again
				hooksecurefunc(_G.C_Navigation, "HasValidScreenPosition", function()
					return true
				end)

				--swap to hook instead of global replace
				hooksecurefunc(SuperTrackedFrame, "GetTargetAlphaBaseValue", function()
					local d = C_Navigation.GetDistance()
					if (d >= 10 ) then
						if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.limitmaxdistance then
							if d <= E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance then
								return 1
							elseif d > E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.distance then
								return 0
							end
						else
							return 1
						end
					else
						C_Map.ClearUserWaypoint()
						return 0
					end
				end)

				SuperTrackedFrame.EltruismHook = true
			end

			SuperTrackedFrame.DistanceText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.WaypointText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.QuestText:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			EltruismTimeToArrive.QuestText:ClearAllPoints()
			EltruismTimeToArrive.QuestText:SetPoint("TOP", EltruismTimeToArrive.WaypointText, "TOP", 0, -(E.db.general.fontSize + 4))
			EltruismTimeToArrive.QuestText:SetTextColor(1, 1, 1)
			if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.classcolortext then
				SuperTrackedFrame.DistanceText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				EltruismTimeToArrive.TimeText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
				EltruismTimeToArrive.WaypointText:SetTextColor(valuecolors.r,valuecolors.g,valuecolors.b)
			else
				SuperTrackedFrame.DistanceText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
				EltruismTimeToArrive.TimeText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
				EltruismTimeToArrive.WaypointText:SetTextColor(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorR, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorG, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.textcolorB)
			end

			--update icon and color
			ElvUI_EltreumUI:UpdateSuperTrackedIcon()

			if not self.TimeToArriveRegistered then
				EltruismTimeToArriveParent:RegisterEvent("USER_WAYPOINT_UPDATED")
				EltruismTimeToArriveParent:RegisterEvent("WAYPOINT_UPDATE")
				EltruismTimeToArriveParent:RegisterEvent("SUPER_TRACKING_CHANGED")
				--EltruismTimeToArriveParent:SetScript("OnEvent", function(_, event)
				EltruismTimeToArriveParent:SetScript("OnEvent", function()
					local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
					--print(instanceType,event,"waypoint")
					if (C_Map.HasUserWaypoint() or C_SuperTrack.IsSuperTrackingAnything()) and (instanceType == "none" or instanceType == "neighborhood") then
						UpdateSuperTrackedText()
						EltruismTimeToArrive:SetScript("OnUpdate", ElvUI_EltreumUI.TimeToArriveOnUpdate)
					else
						EltruismTimeToArrive:SetScript("OnUpdate", nil)
						EltruismTimeToArrive.WaypointText:SetText("")
						EltruismTimeToArrive.QuestText:SetText("")
					end
				end)
				self.TimeToArriveRegistered = true
			end
		end
	end

	local coords = {}

	-- translate text to coordinates that are then put into the Waypoint system, inspired by the Wayfinder weakaura by Khanibrawl
	function ElvUI_EltreumUI:WaypointTexttoCoordinate(message)
		-- most of this was done with the help of posts on stack overflow and lua-users.org
		if E.Modern then
			if E.db.ElvUI_EltreumUI.waypoints.waytext.enable then
				-- translate the message into numbers
				local translatemsg = message:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub("(%d)"..(tonumber("1.1") and "," or ".").."(%d)", "%1"..(tonumber("1.1") and "." or ",").."%2")

				--wipe table just in case
				wipe(coords)

				--put the numbers into the table
				for pattern in translatemsg:gmatch("%S+") do
					if pattern:gmatch("#") then --add support for setting waypoints on other maps, plus compatibility with tomtom commands since its just the map and coordinates
						pattern = gsub(pattern,"#","") --just remove the #
					end
					tinsert(coords, pattern)
				end
				local canSet = C_Map.CanSetUserWaypointOnMap(C_Map.GetBestMapForUnit("player"))

				--neighborhoods dont let you set waypoints
				local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
				if instanceType == "neighborhood" then
					canSet = false
				end

				if not canSet then
					ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
					wipe(coords)
				else
					--core of the function
					if #coords < 2 then
						ElvUI_EltreumUI:Print(L["Unsupported format"])
						wipe(coords)
					end
					if #coords >=2 then
						local x, y = 0,0

						if coords[3] then --coord[3] then its likely a tomtom command
							if tonumber(coords[1]) then
								local info = C_Map.GetMapInfo(coords[1]) --check for map info
								if info then --if there is one, then its all good
									-- setup x coordinate
									if coords[2] and stringmatch(coords[2], "%d+") then
										if stringlen(coords[2]) == 3 then
											x = (tonumber(coords[2])*0.001)
										elseif stringlen(coords[2]) == 2 then
											x = (tonumber(coords[2])*0.01)
										elseif stringlen(coords[2]) == 4 then
											x = (tonumber(coords[2])*0.01)
										elseif stringlen(coords[2]) == 5 then
											x = (tonumber(coords[2])*0.01)
										elseif stringlen(coords[2]) > 5 then
											coords[2] = "a"
										end
									end
									-- setup y coordinate
									if coords[3] and stringmatch(coords[3], "%d+") then
										if stringlen(coords[3]) == 3 then
											y = (tonumber(coords[3])*0.001)
										elseif stringlen(coords[3]) == 2 then
											y = (tonumber(coords[3])*0.01)
										elseif stringlen(coords[3]) == 4 then
											y = (tonumber(coords[3])*0.01)
										elseif stringlen(coords[3]) == 5 then
											y = (tonumber(coords[3])*0.01)
										elseif stringlen(coords[3]) > 5 then
											coords[1] = "a"
										end
									end
									-- check if its numbers set the waypoint and print it otherwise error message
									if (coords[2] and stringmatch(coords[2], "%a+")) or (coords[3] and stringmatch(coords[3], "%a+")) then
										ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
										wipe(coords)
									elseif x == nil or y == nil then
										ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
										wipe(coords)
									else
										--print ("X: "..x.." and Y: "..y)
										local xlength, ylength
										if x > 0 and x < 1 then
											xlength = true
										else
											xlength = false
										end
										if y > 0 and y < 1 then
											ylength = true
										else
											ylength = false
										end
										if not xlength or not ylength then
											ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
											wipe(coords)
										else
											C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(coords[1],x,y)) --use the map since it exists
											if C_Map.GetBestMapForUnit('player') == nil then
												ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
												wipe(coords)
											else
												ElvUI_EltreumUI:Print(C_Map.GetUserWaypointHyperlink())
											end
										end
									end
								else
									ElvUI_EltreumUI:Print(L["Map not found"])
								end
							else
								ElvUI_EltreumUI:Print(L["Map not found"])
							end
						else
							-- setup x coordinate
							if coords[1] and stringmatch(coords[1], "%d+") then
								if stringlen(coords[1]) == 3 then
									x = (tonumber(coords[1])*0.001)
								elseif stringlen(coords[1]) == 2 then
									x = (tonumber(coords[1])*0.01)
								elseif stringlen(coords[1]) == 4 then
									x = (tonumber(coords[1])*0.01)
								elseif stringlen(coords[1]) == 5 then
									x = (tonumber(coords[1])*0.01)
								elseif stringlen(coords[1]) > 5 then
									coords[1] = "a"
								end
							end
							-- setup y coordinate
							if coords[2] and stringmatch(coords[2], "%d+") then
								if stringlen(coords[2]) == 3 then
									y = (tonumber(coords[2])*0.001)
								elseif stringlen(coords[2]) == 2 then
									y = (tonumber(coords[2])*0.01)
								elseif stringlen(coords[2]) == 4 then
									y = (tonumber(coords[2])*0.01)
								elseif stringlen(coords[2]) == 5 then
									y = (tonumber(coords[2])*0.01)
								elseif stringlen(coords[2]) > 5 then
									coords[1] = "a"
								end
							end
							-- check if its numbers set the waypoint and print it otherwise error message
							if (coords[1] and stringmatch(coords[1], "%a+")) or (coords[2] and stringmatch(coords[2], "%a+")) then
								ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
								wipe(coords)
							elseif x == nil or y == nil then
								ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
								wipe(coords)
							else
								--print ("X: "..x.." and Y: "..y)
								local xlength, ylength
								if x > 0 and x < 1 then
									xlength = true
								else
									xlength = false
								end
								if y > 0 and y < 1 then
									ylength = true
								else
									ylength = false
								end
								if not xlength or not ylength then
									ElvUI_EltreumUI:Print(L["Unsupported format or Area does not support waypoints"])
									wipe(coords)
								else
									C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(C_Map.GetBestMapForUnit('player'),x,y))
									if C_Map.GetBestMapForUnit('player') == nil then
										ElvUI_EltreumUI:Print(L["Area does not support waypoints"])
										wipe(coords)
									else
										ElvUI_EltreumUI:Print(C_Map.GetUserWaypointHyperlink())
									end
								end
							end
						end
					end
				end
			end
		end
	end

	--update custom icon or restore blizzard atlas
	function ElvUI_EltreumUI:UpdateSuperTrackedIcon()
		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.customicons then
			ApplySuperTrackedIcon()
		else
			SuperTrackedFrame:UpdateIcon()
			SuperTrackedFrame.Arrow:SetAtlas("Navigation-Tracked-Arrow", true)
			ElvUI_EltreumUI:UpdateSuperTrackedColor()
		end
	end

	--update color for options
	function ElvUI_EltreumUI:UpdateSuperTrackedColor()
		local customIcons = E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable and E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.customicons
		local isPortrait = customIcons and IsPartyMemberPortrait()
		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.enable then
			SuperTrackedFrame.Icon:SetDesaturated(not customIcons and not isPortrait)
			SuperTrackedFrame.Arrow:SetDesaturated(not customIcons)
			local r, g, b
			if not E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.classcolor then
				r, g, b = E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.r, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.g, E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.color.b
			else
				r, g, b = valuecolors.r, valuecolors.g, valuecolors.b
			end
			SuperTrackedFrame.Arrow:SetVertexColor(r, g, b)
			if isPortrait then
				SuperTrackedFrame.Icon:SetVertexColor(1, 1, 1)
			else
				SuperTrackedFrame.Icon:SetVertexColor(r, g, b)
			end
		else
			SuperTrackedFrame.Icon:SetDesaturated(false)
			SuperTrackedFrame.Arrow:SetDesaturated(false)
			if customIcons then
				SuperTrackedFrame.Arrow:SetGradient("VERTICAL", eltruismGradBottom, eltruismGradTop)
				if isPortrait then
					SuperTrackedFrame.Icon:SetVertexColor(1, 1, 1)
				else
					SuperTrackedFrame.Icon:SetGradient("VERTICAL", eltruismGradBottom, eltruismGradTop)
				end
			else
				SuperTrackedFrame.Arrow:SetVertexColor(1, 1, 1)
				SuperTrackedFrame.Icon:SetVertexColor(1, 1, 1)
			end
		end
	end
else --avoid errors when SuperTrackedFrame is nil bc it will error since these functions are not declared
	ElvUI_EltreumUI.WaypointTimeToArrive = E.noop
	ElvUI_EltreumUI.UpdateSuperTrackedIcon = E.noop
	ElvUI_EltreumUI.UpdateSuperTrackedColor = E.noop
end
