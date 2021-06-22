local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local IsInInstance = _G.IsInInstance
local dontstop = 0

--play music during combat
function ElvUI_EltreumUI:CombatMusic(event)
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		local _, instanceType = IsInInstance()
		local soundfile = E.private.ElvUI_EltreumUI.combatmusic.musicfile
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
end

function ElvUI_EltreumUI:StopCombatMusic()
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		if dontstop == 1 then
			StopMusic()
		end
	end
end
