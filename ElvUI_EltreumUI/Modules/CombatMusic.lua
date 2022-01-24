local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsInInstance = _G.IsInInstance
local PlayMusic = _G.PlayMusic
local StopMusic = _G.StopMusic

--play music during combat
local dontstop = 0
function ElvUI_EltreumUI:CombatMusic(event, event2)
	--print(event2.." "..event)
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		local _, instanceType = IsInInstance()
		local soundfile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.musicfile
		if E.private.ElvUI_EltreumUI.combatmusic.disableinstance == false then
			if event == 'PLAYER_REGEN_DISABLED' and event2 == nil then
				PlayMusic(soundfile)
				dontstop = 1
			end
		elseif E.private.ElvUI_EltreumUI.combatmusic.disableinstance == true then
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" or instanceType == "pvp" or instanceType == "arena" then
				return
			else
				if event == 'PLAYER_REGEN_DISABLED' and event2 == nil then
					PlayMusic(soundfile)
					dontstop = 1
				end
			end
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		Minimap:Hide()
	end
end

function ElvUI_EltreumUI:StopCombatMusic(event, event2)
	--print(event2.." "..event)
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		if dontstop == 1 then
			if event == 'PLAYER_REGEN_ENABLED' and event2 == nil then
				StopMusic()
			end
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		Minimap:Show()
	end
end

--play music during boss fights
local dontstopboss = 0
function ElvUI_EltreumUI:BossMusic(event)
	--print(event)
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
		local soundfile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.bossfile
		if event == 'ENCOUNTER_START' then
			PlayMusic(soundfile)
			dontstopboss = 1
		end
	end
end

function ElvUI_EltreumUI:StopBossMusic(event)
	--print(event)
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
		if dontstopboss == 1 then
			if event == 'ENCOUNTER_END' then
				StopMusic()
			end
		end
	end
end
