local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded

--locals used
local IsInInstance = _G.IsInInstance
--local inLockdown = InCombatLockdown()
local dontplay = 0
local dontstop = 0

--play music during combat
function ElvUI_EltreumUI:CombatMusic(event)
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		local inInstance, instanceType = IsInInstance()
		-- get the file input by user
		local soundfile = E.private.ElvUI_EltreumUI.combatmusic.musicfile
		if E.private.ElvUI_EltreumUI.combatmusic.disableinstance == false then
				PlayMusic(soundfile)
				--change variable so stopmusic knows it can stop music
				dontstop = 1
				--print('|cff82B4ffEltruism|r: '..'tried to play music!')
		elseif E.private.ElvUI_EltreumUI.combatmusic.disableinstance == true then
			if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" or instanceType == "pvp" or instanceType == "arena" then
				--do something useless when music is not supposed to play
				dontplay = 1
			else
				PlayMusic(soundfile)
				--change variable so stopmusic knows it can stop music
				dontstop = 1
				--print('|cff82B4ffEltruism|r: '..'tried to play music!')
			end
		end
	end
end

function ElvUI_EltreumUI:StopCombatMusic()
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		 	--check if music was playing, then stop
			if dontstop == 1 then
   				StopMusic()
            --print('|cff82B4ffEltruism|r: '..'tried to stop music!')
        	end
	end
end
