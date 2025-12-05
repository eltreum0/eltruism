local E = unpack(ElvUI)
local _G = _G
--local ObjectiveTracker_Collapse = _G.ObjectiveTracker_Collapse
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local IsInInstance = _G.IsInInstance
--local ObjectiveTracker_Expand = _G.ObjectiveTracker_Expand
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
local tonumber = _G.tonumber
local string = _G.string
local C_GossipInfo = _G.C_GossipInfo
local IsShiftKeyDown = _G.IsShiftKeyDown
local IsControlKeyDown = _G.IsControlKeyDown
local IsAltKeyDown = _G.IsAltKeyDown
local otherBossEncounter = false
local UIParent = _G.UIParent

--Hide Quests during events
function ElvUI_EltreumUI:QuestCombat(event)
	if event == "PLAYER_REGEN_ENABLED" then --out of combat
		if E.db.ElvUI_EltreumUI.quests.combatenable or otherBossEncounter then
			if E.Retail then
				--[[if _G.ObjectiveTrackerFrame:IsCollapsed() then
					_G.ObjectiveTrackerFrame:ToggleCollapsed() --seems like this causes taints
				end]]
				--_G.ObjectiveTrackerFrame:SetCollapsed(false)
				--ObjectiveTrackerFrame:SetAlpha(1)
				if _G["ObjectiveFrameHolder"] then
					ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
				else
					ObjectiveTrackerFrame:SetParent(UIParent)
				end
				--ObjectiveTracker_Expand()
			elseif E.Classic or E.TBC or E.Wrath then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Show()
					else
						_G.QuestWatchFrame:Show()
					end
				else
					_G.QuestWatchFrame:Show()
				end
			elseif E.Mists then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Show()
					else
						_G.WatchFrame:Show()
					end
				else
					_G.WatchFrame:Show()
				end
			end
		end
	elseif event == "PLAYER_REGEN_DISABLED" then --entered combat
		if E.db.ElvUI_EltreumUI.quests.combatenable or (E.db.ElvUI_EltreumUI.quests.enable and _G.UnitExists("boss1")) then
			if E.Retail then
				--[[if _G.ObjectiveTrackerFrame:IsCollapsed() == false then
					_G.ObjectiveTrackerFrame:ToggleCollapsed() --seems like this causes taints
				end]]
				--_G.ObjectiveTrackerFrame:SetCollapsed(true)
				--ObjectiveTrackerFrame:SetAlpha(0)
				ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
				--ObjectiveTracker_Collapse()
			elseif E.Classic or E.TBC or E.Wrath then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.QuestWatchFrame:Hide()
					end
				else
					_G.QuestWatchFrame:Hide()
				end
			elseif E.Mists then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.WatchFrame:Hide()
					end
				else
					_G.WatchFrame:Hide()
				end
			end
			if E.db.ElvUI_EltreumUI.quests.enable then
				otherBossEncounter = true
			else
				otherBossEncounter = false
			end
		end
	elseif event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT" then --started boss fight
		if E.db.ElvUI_EltreumUI.quests.enable and _G.UnitExists("boss1") then
			local _, instanceType = IsInInstance()
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
				if E.Retail then
					--ObjectiveTracker_Collapse()
					--ObjectiveTrackerFrame:Hide()
					ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
					--ObjectiveTrackerFrame:SetAlpha(0)
					--_G.ObjectiveTrackerFrame:SetCollapsed(true)
				elseif E.Classic or E.TBC or E.Wrath then
					if IsAddOnLoaded("Questie") then
						if _G["Questie_BaseFrame"] then
							_G["Questie_BaseFrame"]:Hide()
						else
							_G.QuestWatchFrame:Hide()
						end
					else
						_G.QuestWatchFrame:Hide()
					end
				elseif E.Mists then
					if IsAddOnLoaded("Questie") then
						if _G["Questie_BaseFrame"] then
							_G["Questie_BaseFrame"]:Hide()
						else
							_G.WatchFrame:Hide()
						end
					else
						_G.WatchFrame:Hide()
					end
				end
				otherBossEncounter = true
			end
		end
	elseif event == "ENCOUNTER_START" then --started boss fight
		if E.db.ElvUI_EltreumUI.quests.enable then
			local _, instanceType = IsInInstance()
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --and event == "PLAYER_REGEN_DISABLED"
				if E.Retail then
					--ObjectiveTracker_Collapse()
					--ObjectiveTrackerFrame:Hide()
					ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
					--ObjectiveTrackerFrame:SetAlpha(0)
					--_G.ObjectiveTrackerFrame:SetCollapsed(true)
				elseif E.Classic or E.TBC or E.Wrath then
					if IsAddOnLoaded("Questie") then
						if _G["Questie_BaseFrame"] then
							_G["Questie_BaseFrame"]:Hide()
						else
							_G.QuestWatchFrame:Hide()
						end
					else
						_G.QuestWatchFrame:Hide()
					end
				elseif E.Mists then
					if IsAddOnLoaded("Questie") then
						if _G["Questie_BaseFrame"] then
							_G["Questie_BaseFrame"]:Hide()
						else
							_G.WatchFrame:Hide()
						end
					else
						_G.WatchFrame:Hide()
					end
				end
			end
		end
	elseif event == "ENCOUNTER_END" then --finished boss fight
		if E.db.ElvUI_EltreumUI.quests.enable then
			if _G.InCombatLockdown() then
				E:Delay(3,ElvUI_EltreumUI.QuestEncounterEnd) --retry soon
			else
				local _, instanceType = IsInInstance()
				if (instanceType == "raid" or instanceType == "party" or instanceType == "scenario") then --and event == "PLAYER_REGEN_DISABLED"
					if E.Retail then
						if _G["ObjectiveFrameHolder"] then
							ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
						else
							ObjectiveTrackerFrame:SetParent(UIParent)
						end
						--ObjectiveTrackerFrame:SetAlpha(1)
						--_G.ObjectiveTrackerFrame:SetCollapsed(false)
					elseif E.Classic or E.TBC or E.Wrath then
						if IsAddOnLoaded("Questie") then
							if _G["Questie_BaseFrame"] then
								_G["Questie_BaseFrame"]:Show()
							else
								_G.QuestWatchFrame:Show()
							end
						else
							_G.QuestWatchFrame:Show()
						end
					elseif E.Mists then
						if IsAddOnLoaded("Questie") then
							if _G["Questie_BaseFrame"] then
								_G["Questie_BaseFrame"]:Show()
							else
								_G.WatchFrame:Show()
							end
						else
							_G.WatchFrame:Show()
						end
					end
				end
			end
		end
	elseif event == "CHALLENGE_MODE_RESET" then
		if E.db.ElvUI_EltreumUI.quests.mythicplus then
			if _G["ObjectiveFrameHolder"] then
				ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
			else
				ObjectiveTrackerFrame:SetParent(UIParent)
			end
		end
	elseif event == "CHALLENGE_MODE_START" then
		if E.db.ElvUI_EltreumUI.quests.mythicplus then
			ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
		end
	elseif event == "CHALLENGE_MODE_COMPLETED" then
		if E.db.ElvUI_EltreumUI.quests.mythicplus then
			if _G["ObjectiveFrameHolder"] then
				ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
			else
				ObjectiveTrackerFrame:SetParent(UIParent)
			end
		end
	end
end

--hide quests in arena/bg matches
function ElvUI_EltreumUI:ArenaQuest()
	if E.db.ElvUI_EltreumUI.quests.arena then
		local _, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then
			if E.Retail then
				--ObjectiveTrackerFrame:Hide()
				ObjectiveTrackerFrame:SetParent(E.HiddenFrame)
				--ObjectiveTrackerFrame:SetAlpha(0)
				--_G.ObjectiveTrackerFrame:SetCollapsed(true)
			elseif E.Classic or E.TBC or E.Wrath then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.QuestWatchFrame:Hide()
					end
				else
					_G.QuestWatchFrame:Hide()
				end
			elseif E.Mists then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Hide()
					else
						_G.WatchFrame:Hide()
					end
				else
					_G.WatchFrame:Hide()
				end
			end
		elseif instanceType == "none" then
			if E.Retail then
				if _G["ObjectiveFrameHolder"] then
					ObjectiveTrackerFrame:SetParent(_G["ObjectiveFrameHolder"])
				else
					ObjectiveTrackerFrame:SetParent(UIParent)
				end
				--ObjectiveTrackerFrame:SetAlpha(1)
			elseif E.Classic or E.TBC or E.Wrath then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Show()
					else
						_G.QuestWatchFrame:Show()
					end
				else
					_G.QuestWatchFrame:Show()
				end
			elseif E.Mists then
				if IsAddOnLoaded("Questie") then
					if _G["Questie_BaseFrame"] then
						_G["Questie_BaseFrame"]:Show()
					else
						_G.WatchFrame:Show()
					end
				else
					_G.WatchFrame:Show()
				end
			end
		end
	end
end

--based on Rogue Door Opener by Burzolog
function ElvUI_EltreumUI:RogueAutoOpen()
	if E.db.ElvUI_EltreumUI.quests.rogueopen then

		--get guid
		local guid = _G.UnitGUID("target")
		if not guid then
			return
		end

		--to NPC_ID
		local NPC_ID = tonumber(string.match(guid, "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))

		--get gossip options
		local gossipInfoTable = C_GossipInfo.GetOptions()

		--only run on correct npcs
		if NPC_ID == 97004 or NPC_ID == 96782 or NPC_ID == 93188 then
			if IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() then
				return
			else
				C_GossipInfo.SelectOption(gossipInfoTable[1].gossipOptionID)
			end
		end
	end
end
