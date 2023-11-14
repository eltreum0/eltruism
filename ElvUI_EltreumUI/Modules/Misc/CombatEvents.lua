local E = unpack(ElvUI)
local _G = _G
local GetCVar = _G.C_CVar and _G.C_CVar.GetCVar or _G.GetCVar
local IsInInstance = _G.IsInInstance
local PlayMusic = _G.PlayMusic
local tostring = _G.tostring
local StopMusic = _G.StopMusic
local Minimap = _G.Minimap
local wipe = _G.wipe
local math = _G.math
local strsplit = _G.strsplit
local dontstop = 0
local dontstopboss = 0
local soundfileboss
local _, instanceType
local soundfile
local list = {}

--play music during combat
function ElvUI_EltreumUI:CombatMusic(event, event2)
	if E.private.ElvUI_EltreumUI.combatmusic.enable and tostring(GetCVar('Sound_EnableMusic')) == '1' then
		_, instanceType = IsInInstance()
		soundfile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.musicfile
		if E.db.ElvUI_EltreumUI.otherstuff.musicshuffle then
			wipe(list)
			list = {strsplit("," ,E.private.ElvUI_EltreumUI.combatmusic.shufflelist)}
			soundfile = [[Interface\AddOns\]]..list[math.random(1,#list)]
		end
		if not E.private.ElvUI_EltreumUI.combatmusic.disableinstance then
			if event == 'PLAYER_REGEN_DISABLED' and event2 == nil and dontstopboss == 0 then
				PlayMusic(soundfile)
				dontstop = 1
			end
		elseif E.private.ElvUI_EltreumUI.combatmusic.disableinstance then
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" or instanceType == "pvp" or instanceType == "arena" then
				return
			elseif instanceType == "none" then
				if event == 'PLAYER_REGEN_DISABLED' and event2 == nil and dontstopboss == 0 then
					PlayMusic(soundfile)
					dontstop = 1
				end
			end
		end
	end
end

function ElvUI_EltreumUI:StopCombatMusic(event, event2)
	if E.private.ElvUI_EltreumUI.combatmusic.enable and tostring(GetCVar('Sound_EnableMusic')) == '1' then
		if dontstop == 1 then
			if event == 'PLAYER_REGEN_ENABLED' and event2 == nil and dontstopboss == 0 then
				StopMusic()
				dontstop = 0
			end
		end
	end
end

--play music during boss fights
function ElvUI_EltreumUI:BossMusic(event)
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic and tostring(GetCVar('Sound_EnableMusic')) == '1' then
		soundfileboss = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.bossfile
		if event == 'ENCOUNTER_START' then
			if dontstop == 1 then
				StopMusic()
			end
			PlayMusic(soundfileboss)
			dontstopboss = 1
		end
	end
end

function ElvUI_EltreumUI:StopBossMusic(event)
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic and tostring(GetCVar('Sound_EnableMusic')) == '1' then
		if dontstopboss == 1 then
			if event == 'ENCOUNTER_END' then
				StopMusic()
				dontstopboss = 0
			end
		end
	end
end

local BuffsMover
local DebuffsMover
local eyecheck
function ElvUI_EltreumUI:MinimapHide(event)
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		if event == 'PLAYER_REGEN_DISABLED' then
			if not E.Retail then
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
			if not E.Retail then
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
