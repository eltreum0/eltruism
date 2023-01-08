local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local C_CVar = _G.C_CVar
local IsInInstance = _G.IsInInstance
local PlayMusic = _G.PlayMusic
local tostring = _G.tostring
local StopMusic = _G.StopMusic
local Minimap = _G.Minimap
local dontstop = 0
local dontstopboss = 0
local soundfileboss
local _, instanceType
local soundfile
local list = {}

--play music during combat
function ElvUI_EltreumUI:CombatMusic(event, event2)
	if E.private.ElvUI_EltreumUI.combatmusic.enable and tostring(C_CVar.GetCVar('Sound_EnableMusic')) == '1' then
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
	if E.private.ElvUI_EltreumUI.combatmusic.enable and tostring(C_CVar.GetCVar('Sound_EnableMusic')) == '1' then
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
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic and tostring(C_CVar.GetCVar('Sound_EnableMusic')) == '1' then
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
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic and tostring(C_CVar.GetCVar('Sound_EnableMusic')) == '1' then
		if dontstopboss == 1 then
			if event == 'ENCOUNTER_END' then
				StopMusic()
				dontstopboss = 0
			end
		end
	end
end

function ElvUI_EltreumUI:MinimapHide(event)
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		if event == 'PLAYER_REGEN_DISABLED' then
			if not E.Retail then
				Minimap:Hide()
			else
				_G.MinimapCluster:Hide()
			end
			if E.db.ElvUI_EltreumUI.otherstuff.mapcombathideadjustaura then
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
			end
			if E.db.ElvUI_EltreumUI.otherstuff.mapcombathideadjustaura then
				E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-213,-4"
				E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-213,-101"
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
