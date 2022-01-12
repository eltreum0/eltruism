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

--test memory things
--local memorystart = collectgarbage("count")
function ElvUI_EltreumUI:StopCombatMusic()
	--[[if not InCombatLockdown() then
		print("ready to collect")
		local aftercombat = collectgarbage("count")
		if aftercombat > (memorystart * 3) then
			collectgarbage("collect")
			print("Collected " .. (aftercombat-collectgarbage("count")) .. " kB of garbage");
		else
			print("Not enough memory usage to collect garbage yet")
		end
	end]]--
	if E.private.ElvUI_EltreumUI.combatmusic.enable then
		if dontstop == 1 then
			StopMusic()
		end
	end
end
