local E = unpack(ElvUI)
local _G = _G
local GetCVar = _G.C_CVar and _G.C_CVar.GetCVar or _G.GetCVar
local PlayMusic = _G.PlayMusic
local tostring = _G.tostring
local StopMusic = _G.StopMusic
local Minimap = _G.Minimap
local wipe = _G.wipe
local math = _G.math
local mathrandom = math.random
local strsplit = _G.strsplit
local UnitExists = _G.UnitExists
local tonumber = _G.tonumber
local dontstop = 0
local dontstopboss = 0
local dontstopduel = 0
local pendingDuel = false
local duelCountdownPattern
local list = {}

local function GetDuelCountdownPattern()
	if not duelCountdownPattern and _G.DUEL_COUNTDOWN then
		duelCountdownPattern = _G.DUEL_COUNTDOWN:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1"):gsub("%%%%d", "(%%d+)")
	end
	return duelCountdownPattern
end

local function StartDuelMusic()
	if dontstopduel == 1 then return end
	if not pendingDuel then return end
	if tostring(GetCVar('Sound_EnableMusic')) ~= '1' then return end
	if not (E.private.ElvUI_EltreumUI.combatmusic and E.private.ElvUI_EltreumUI.combatmusic.duelmusic) then return end
	local duelfile = E.private.ElvUI_EltreumUI.combatmusic.duelfile
	if not duelfile or duelfile == "" or duelfile == "None" then return end

	pendingDuel = false
	dontstopduel = 1
	StopMusic()
	PlayMusic([[Interface\AddOns\]] .. duelfile)
end

local function StopDuelMusic()
	pendingDuel = false
	if dontstopduel == 1 then
		StopMusic()
		dontstopduel = 0
	end
end

local function HandleDuelCountdown(count)
	pendingDuel = true
	if count == 1 then
		E:Delay(1, StartDuelMusic)
	end
end

--play music during combat
function ElvUI_EltreumUI:CombatMusic(event, ...)
	if tostring(GetCVar('Sound_EnableMusic')) ~= '1' then return end
	if event == 'DUEL_REQUESTED' or event == 'DUEL_TO_THE_DEATH_REQUESTED' then
		if E.private.ElvUI_EltreumUI.combatmusic and E.private.ElvUI_EltreumUI.combatmusic.duelmusic then
			pendingDuel = true
		end
	elseif event == 'CHAT_MSG_SYSTEM' then
		if E.private.ElvUI_EltreumUI.combatmusic and E.private.ElvUI_EltreumUI.combatmusic.duelmusic then
			local text = ...
			if text then
				if text == _G.ERR_DUEL_CANCELLED then
					StopDuelMusic()
				else
					local pattern = GetDuelCountdownPattern()
					if pattern then
						local count = tonumber(text:match(pattern))
						if count then
							HandleDuelCountdown(count)
						end
					end
				end
			end
		end
	elseif event == 'DUEL_FINISHED' or event == 'PLAYER_DEAD' or event == 'PLAYER_ENTERING_WORLD' then
		StopDuelMusic()
	elseif event == 'ENCOUNTER_START' then --boss start
		if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
			local soundfileboss = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.bossfile
			if dontstopboss == 0 then
				StopMusic()
				PlayMusic(soundfileboss)
				dontstopboss = 1
			end
		end
	elseif event == 'INSTANCE_ENCOUNTER_ENGAGE_UNIT' then --boss (delve) start
		if UnitExists("boss1") then
			if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
				local soundfileboss = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.bossfile
				if dontstopboss == 0 then
					StopMusic()
					PlayMusic(soundfileboss)
					dontstopboss = 1
				end
			end
		end
	elseif event == 'ENCOUNTER_END' then --boss ends
		if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
			if dontstopboss == 1 then
				StopMusic()
				dontstopboss = 0
			end
		end
	elseif event == 'PLAYER_REGEN_DISABLED' then --combat starts
		if pendingDuel and dontstopduel == 0 then
			StartDuelMusic()
		end
		if dontstopduel == 1 or dontstopboss == 1 then
			return
		end
		if E.private.ElvUI_EltreumUI.combatmusic.enable then
			local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
			local soundfile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.musicfile
			if E.db.ElvUI_EltreumUI.otherstuff.musicshuffle then
				wipe(list)
				list = {strsplit("," ,E.private.ElvUI_EltreumUI.combatmusic.shufflelist)}
				soundfile = [[Interface\AddOns\]]..list[mathrandom(1,#list)]
			end
			if not E.private.ElvUI_EltreumUI.combatmusic.disableinstance then
				if dontstop == 0 then
					PlayMusic(soundfile)
					dontstop = 1
				end
			elseif E.private.ElvUI_EltreumUI.combatmusic.disableinstance then
				if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" or instanceType == "pvp" or instanceType == "arena" then
					return
				elseif instanceType == "none" then
					if dontstop == 0 then
						PlayMusic(soundfile)
						dontstop = 1
					end
				end
			end
		end
	elseif event == 'PLAYER_REGEN_ENABLED' then --combat ends
		if dontstopduel == 1 then
			return
		end
		if E.private.ElvUI_EltreumUI.combatmusic.enable or E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
			StopMusic()
			dontstopboss = 0
			dontstop = 0
		end
	end
end

local BuffsMover
local DebuffsMover
local eyecheck
function ElvUI_EltreumUI:MinimapHide(event)
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		if event == 'PLAYER_REGEN_DISABLED' then
			if not E.Modern then
				Minimap:Hide()
			else
				_G.MinimapCluster:Hide()
				if _G.AddonCompartmentFrame then
					_G.AddonCompartmentFrame:Hide()
				end
				if _G.QueueStatusButton:IsShown() then
					eyecheck = true
					_G.QueueStatusButton:Hide()
				end
			end
			if E.db.ElvUI_EltreumUI.otherstuff.mapcombathideadjustaura then
				BuffsMover = E.db["movers"]["BuffsMover"]
				DebuffsMover = E.db["movers"]["DebuffsMover"]
				E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-4"
				E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-3,-101"
				E:SetMoverPoints("BuffsMover")
				E:SetMoverPoints("DebuffsMover")
			end
		elseif event == 'PLAYER_REGEN_ENABLED' then
			if not E.Modern then
				Minimap:Show()
			else
				_G.MinimapCluster:Show()
				if _G.AddonCompartmentFrame then
					_G.AddonCompartmentFrame:Show()
				end
				if _G.QueueStatusButton and eyecheck then
					eyecheck = false
					_G.QueueStatusButton:Show()
				end
			end
			if E.db.ElvUI_EltreumUI.otherstuff.mapcombathideadjustaura then
				E.db["movers"]["BuffsMover"] = BuffsMover or E.db["movers"]["BuffsMover"]
				E.db["movers"]["DebuffsMover"] = DebuffsMover or E.db["movers"]["DebuffsMover"]
				E:SetMoverPoints("BuffsMover")
				E:SetMoverPoints("DebuffsMover")
			end
		end
	end
end

function ElvUI_EltreumUI:DatatextHide(event)
	if E.db.ElvUI_EltreumUI.otherstuff.rightdatatextcombatshow then
		if event == 'PLAYER_REGEN_DISABLED' then
			_G.RightChatDataPanel:Show()
		elseif event == 'PLAYER_REGEN_ENABLED' then
			_G.RightChatDataPanel:Hide()
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.leftdatatextcombatshow then
		if event == 'PLAYER_REGEN_DISABLED' then
			_G.LeftChatDataPanel:Show()
		elseif event == 'PLAYER_REGEN_ENABLED' then
			_G.LeftChatDataPanel:Hide()
		end
	end
end
