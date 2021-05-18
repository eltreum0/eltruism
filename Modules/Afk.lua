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

local vanillaMusic = {
    ['Human'] = 6794,
    ['Gnome'] = 7341,
    ['NightElf'] = 3920,
    ['Dwarf'] = 7319,
    ['Orc'] = 2902,
    ['Undead'] = 5074,
    ['Tauren'] = 7077,
    ['Troll'] = 8452,
}

-- with the help of Repooc, Simpy, Nihilistzsche and Acidweb (not in order :D)
local musicSetting = GetCVar('Sound_EnableMusic')
function ElvUI_EltreumUI:AFKmusic()
    if E.private.ElvUI_EltreumUI.afkmusic.enable then
        if ElvUI_EltreumUI.Retail then
            if UnitIsAFK("player") then
                if musicSetting == '0' then SetCVar("Sound_EnableMusic", 1) end
                if E.private.ElvUI_EltreumUI.afkmusic.racial then
                    if ElvUI_EltreumUI.Retail then
                        PlayMusic(racialMusic[E.myrace])
                    end
                end
                if E.private.ElvUI_EltreumUI.afkmusic.playerclass then
                    PlayMusic(classMusic[E.myclass])
                end
            else
                StopMusic()
                SetCVar("Sound_EnableMusic", musicSetting)
            end
        end

        --[[if ElvUI_EltreumUI.TBC then
            if UnitIsAFK("player") then
                if musicSetting == '0' then
                    SetCVar("Sound_EnableMusic", 1)
                end
                if ElvUI_EltreumUI.Retail then
                    PlayMusic(vanillaMusic[E.myrace])
                end
            else
                StopMusic()
                SetCVar("Sound_EnableMusic", musicSetting)
            end
        end]]--


        --[[if ElvUI_EltreumUI.Classic then
            local _ , race, _ = UnitRace("player")
            if UnitIsAFK("player") then
                if race == "Human" then
                    PlayMusic(6794)
                end
                if race == "Gnome" then
                    PlayMusic(7341)
                end
                if race == "NightElf" then
                    PlayMusic(3920)
                end
                if race == "Dwarf" then
                    PlayMusic(7319)
                end
                if race == "Draenei" then
                    PlayMusic(53284)
                end
                if race == "Orc" then
                    PlayMusic(2902)
                end
                if race == "Undead" then
                    PlayMusic(5074)
                end
                if race == "Tauren" then
                    PlayMusic(7077)
                end
                if race == "Troll" then
                    PlaySoundFile(8452)
                end
                if race == "BloodElf" then
                    PlaySoundFile(53473)
                end
            end
            --stop music when not afk
            if not UnitIsAFK("player") then
                StopMusic()
            end
        end]]--
    end
end
















