local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local SetCVar = _G.SetCVar
local UnitIsAFK = _G.UnitIsAFK
local PlayMusic = _G.PlayMusic
local StopMusic = _G.StopMusic
local PlaySound = _G.PlaySound
local StopSound = _G.StopSound
local GetCVar = _G.GetCVar

-- general alliance walk (legion) maybe human music idk
--/script PlaySoundFile(1417250, "Dialog", true)

-- AFK music (modified with the help of Repooc!)
local racialMusic = {
	['Human'] = 53210,
	['Gnome'] = 369055,
	['NightElf'] = 441709,
	['KulTiran'] = 1781897,
	['Dwarf'] = 298910,
	['Draenei'] = 53284,
	['Worgen'] = 441525,
	['VoidElf'] = 1864282,
	['LightforgedDraenei'] = 1864285,
	['DarkIronDwarf'] = 441566,
	['Mechagnome'] = 3028751,
	['Orc'] = 441713,
	['Scourge'] = 53217,
	['Tauren'] = 441788,
	['Troll'] = 371378,
	['Goblin'] = 441627,
	['BloodElf'] = 53473,
	['Pandaren'] = 642246,
	['Nightborne'] = 1477339,
	['HighmountainTauren'] = 1417319,
	['ZandalariTroll'] = 2844635,
	['Vulpera'] = 3260632,
	['MagharOrc'] = 2146630,
}
local classMusic = {
	['WARRIOR'] = 1417334,
	['PALADIN'] = 1417342, --443289
	['HUNTER'] = 1417326,
	['ROGUE'] = 1417273,
	['PRIEST'] = 1417367,
	['DEATHKNIGHT'] = 229831,
	['SHAMAN'] = 528163,
	['MAGE'] = 1417264,
	['WARLOCK'] = 1417356,
	['MONK'] = 642138,
	['DRUID'] = 1417312,
	['DEMONHUNTER'] = 1417290,
}

local tbcMusic = {
	['Human'] = 53202,
	['Gnome'] = 53190,
	['NightElf'] = 53187,
	['Dwarf'] = 53193,
	['Orc'] = 53201,
	['Scourge'] = 53217,
	['Tauren'] = 53215,
	['Troll'] = 53825,
	['Draenei'] = 53284,
	['BloodElf'] = 53473,
}

local classicMusic = {
	['Human'] = 6794,
	['Gnome'] = 7341,
	['NightElf'] = 3920,
	['Dwarf'] = 7319,
	['Orc'] = 2902,
	['Scourge'] = 5074,
	['Tauren'] = 7077,
	['Troll'] = 8452,
}

-- with the help of Repooc, Simpy, Nihilistzsche and Acidweb (not in order :D)
local musicSetting = GetCVar('Sound_EnableMusic')
local classicmusicstopper = nil
local willplay = nil
function ElvUI_EltreumUI:AFKmusic()
	if E.db.ElvUI_EltreumUI.afkmusic.enable then
		if ElvUI_EltreumUI.Retail then
			if UnitIsAFK("player") then
				if musicSetting == '0' then SetCVar("Sound_EnableMusic", 1) end
				if E.db.ElvUI_EltreumUI.afkmusic.racial then
					if ElvUI_EltreumUI.Retail then
						PlayMusic(racialMusic[E.myrace])
					end
				end
				if E.db.ElvUI_EltreumUI.afkmusic.playerclass then
					PlayMusic(classMusic[E.myclass])
				end
			else
				StopMusic()
				SetCVar("Sound_EnableMusic", musicSetting)
			end
		end
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			if UnitIsAFK("player") then
				if musicSetting == '0' then SetCVar("Sound_EnableMusic", 1) end
				if ElvUI_EltreumUI.TBC then
					PlayMusic(tbcMusic[E.myrace])
				elseif ElvUI_EltreumUI.Classic then
					willplay, classicmusicstopper = PlaySound(classicMusic[E.myrace])
				end
			else
				if ElvUI_EltreumUI.TBC then
					StopMusic()
					SetCVar("Sound_EnableMusic", musicSetting)
				end
				if ElvUI_EltreumUI.Classic then
					if willplay then
						StopSound(classicmusicstopper,3000)
					end
					SetCVar("Sound_EnableMusic", musicSetting)
				end
			end
		end
	end
end
