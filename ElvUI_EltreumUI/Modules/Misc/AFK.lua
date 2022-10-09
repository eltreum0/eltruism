local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local C_CVar = _G.C_CVar
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local UnitIsAFK = _G.UnitIsAFK
local SetCVar = _G.SetCVar
local PlayMusic = _G.PlayMusic
local PlaySound = _G.PlaySound
local StopMusic = _G.StopMusic
local StopSound = _G.StopSound

-- general alliance walk (legion) maybe human music idk
--/script PlaySoundFile(1417250, "Dialog", true)

-- AFK music (modified with the help of Repooc!)
local racialMusic = {
	["Human"] = 53210,
	["Gnome"] = 369055,
	["NightElf"] = 441709,
	["KulTiran"] = 1781897,
	["Dwarf"] = 298910,
	["Draenei"] = 53284,
	["Worgen"] = 441525,
	["VoidElf"] = 1864282,
	["LightforgedDraenei"] = 1864285,
	["DarkIronDwarf"] = 441566,
	["Mechagnome"] = 3028751,
	["Orc"] = 441713,
	["Scourge"] = 53217,
	["Tauren"] = 441788,
	["Troll"] = 371378,
	["Goblin"] = 441627,
	["BloodElf"] = 53473,
	["Pandaren"] = 642246,
	["Nightborne"] = 1477339,
	["HighmountainTauren"] = 1417319,
	["ZandalariTroll"] = 2844635,
	["Vulpera"] = 3260632,
	["MagharOrc"] = 2146630,
}
local classMusic = {
	["WARRIOR"] = 1417334,
	["PALADIN"] = 1417342, --443289
	["HUNTER"] = 1417326,
	["ROGUE"] = 1417273,
	["PRIEST"] = 1417367,
	["DEATHKNIGHT"] = 229831,
	["SHAMAN"] = 528163,
	["MAGE"] = 1417264,
	["WARLOCK"] = 1417356,
	["MONK"] = 642138,
	["DRUID"] = 1417312,
	["DEMONHUNTER"] = 1417290,
}

local tbcMusic = {
	["Human"] = 53202,
	["Gnome"] = 53190,
	["NightElf"] = 53187,
	["Dwarf"] = 53193,
	["Orc"] = 53201,
	["Scourge"] = 53217,
	["Tauren"] = 53215,
	["Troll"] = 53825,
	["Draenei"] = 53284,
	["BloodElf"] = 53473,
}

local wrathMusic ={
	["Human"] = 53210,
	["Gnome"] = 369055,
	["NightElf"] = 53187,
	["Dwarf"] = 298910,
	["Draenei"] = 53284,
	["Orc"] = 53201,
	["Scourge"] = 53217,
	["Tauren"] = 53215,
	["Troll"] = 371378,
	["BloodElf"] = 53473,
}

local classicMusic = {
	["Human"] = 6794,
	["Gnome"] = 7341,
	["NightElf"] = 3920,
	["Dwarf"] = 7319,
	["Orc"] = 2902,
	["Scourge"] = 5074,
	["Tauren"] = 7077,
	["Troll"] = 8452,
}

-- with the help of Repooc, Simpy, Nihilistzsche and Acidweb (not in order :D)
local musicSettingLoadingIn = C_CVar.GetCVar('Sound_EnableMusic')
local musicSetting = musicSettingLoadingIn
local classicmusicstopper = nil
local willplay = nil
function ElvUI_EltreumUI:AFKmusic()
	if E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable then
		if UnitIsAFK("player") then
			musicSetting = tonumber(C_CVar.GetCVar('Sound_EnableMusic'))
			SetCVar("Sound_EnableMusic", 1)
			if E.Retail then
				if E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial then
					PlayMusic(racialMusic[E.myrace])
				elseif E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass then
					PlayMusic(classMusic[E.myclass])
				end
			elseif E.Classic then
				willplay, classicmusicstopper = PlaySound(classicMusic[E.myrace])
			elseif E.TBC then
				PlayMusic(tbcMusic[E.myrace])
			elseif E.Wrath then
				PlayMusic(wrathMusic[E.myrace])
			end
		else
			if not E.Classic then
				StopMusic()
				if musicSettingLoadingIn ~= musicSetting then
					SetCVar("Sound_EnableMusic", musicSetting)
				end
			else
				if willplay then
					StopSound(classicmusicstopper,3000)
				end
				if musicSettingLoadingIn ~= musicSetting then
					SetCVar("Sound_EnableMusic", musicSetting)
				end
			end
		end
	end
end

--add Eltruism logo to elvui afk screen
local EltruismAFKLogo = CreateFrame("Frame", "EltruismAFKLogo", UIParent)
local EltruismAFKLogoTexture = EltruismAFKLogo:CreateTexture()
local EltruismAFKTop = CreateFrame('Frame', nil, EltruismAFKLogo)
EltruismAFKLogo:Hide()
function ElvUI_EltreumUI:AFKLogo()
	if E.db.general.afk then
		EltruismAFKLogo:SetSize(320, 80)
		EltruismAFKLogo:ClearAllPoints()
		EltruismAFKLogo:SetPoint("TOP", UIParent, "TOP", 0, -10)
		EltruismAFKLogo:SetFrameStrata("DIALOG")
		EltruismAFKLogoTexture:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq")
		EltruismAFKLogoTexture:SetAllPoints(EltruismAFKLogo)

		EltruismAFKTop:SetFrameLevel(0)
		EltruismAFKTop:SetTemplate('Transparent')
		EltruismAFKTop:SetPoint('TOP', UIParent, 'TOP', 0, 0)
		--EltruismAFKTop:SetWidth(E.screenWidth + (E.Border*2))
		EltruismAFKTop:SetWidth(E.screenWidth*2)
		EltruismAFKTop:SetHeight(E.screenHeight * 0.1)

		if E.db.ElvUI_EltreumUI.otherstuff.afklogo then
			EltruismAFKLogo:SetParent(_G.ElvUIAFKFrame.bottom)
			if UnitIsAFK("player") then
				EltruismAFKLogo:Show()
			else
				EltruismAFKLogo:Hide()
			end
		end
	end
end
