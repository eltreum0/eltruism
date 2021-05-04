local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded


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
    ['Undead'] = 53217,
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

-- with the help of Repooc, Simpy, Nihilistzsche and Acidweb (not in order :P)
local music = 1
function ElvUI_EltreumUI:RacialAFKmusic()
	if E.private.ElvUI_EltreumUI.afkmusic.enable then
		if UnitIsAFK("player") then
            music = GetCVar('Sound_EnableMusic')
            if music == '0' then SetCVar("Sound_EnableMusic", 1) end

            if E.private.ElvUI_EltreumUI.afkmusic.racial then
                PlayMusic(racialMusic[E.myrace])
            end
            if E.private.ElvUI_EltreumUI.afkmusic.playerclass then
                PlayMusic(classMusic[E.myclass])
            end
		else
			StopMusic()
            SetCVar("Sound_EnableMusic", music)
		end
	end
end
