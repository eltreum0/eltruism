local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsInInstance = _G.IsInInstance
local PlayMusic = _G.PlayMusic
local StopMusic = _G.StopMusic

--play music during combat
local dontstop = 0
function ElvUI_EltreumUI:CombatMusic()
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		local _, instanceType = IsInInstance()
		local soundfile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.musicfile
		if E.private.ElvUI_EltreumUI.combatmusic.disableinstance == false then
				PlayMusic(soundfile)
				dontstop = 1
		elseif E.private.ElvUI_EltreumUI.combatmusic.disableinstance == true then
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" or instanceType == "pvp" or instanceType == "arena" then
				return
			else
				PlayMusic(soundfile)
				dontstop = 1
			end
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		Minimap:Hide()
	end
end

function ElvUI_EltreumUI:StopCombatMusic()
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		if dontstop == 1 then
			StopMusic()
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.mapcombathide then
		Minimap:Show()
	end
end



--play music during boss fights
local dontstopboss = 0
function ElvUI_EltreumUI:BossMusic()
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
		local _, instanceType = IsInInstance()
		local soundfile = [[Interface\AddOns\]]..E.private.ElvUI_EltreumUI.combatmusic.bossfile
		PlayMusic(soundfile)
		dontstopboss = 1
	end
end

function ElvUI_EltreumUI:StopBossMusic()
	if E.private.ElvUI_EltreumUI.combatmusic.bossmusic then
		if dontstopboss == 1 then
			StopMusic()
		end
	end
end
