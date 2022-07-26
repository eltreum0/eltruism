local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))


-- Eltruism ingame options TBC
function ElvUI_EltreumUI:Configtable()
	-- Add Eltruism version on top of the ElvUI config
	E.Options.name = E.Options.name .. " + " .. ElvUI_EltreumUI.Name .. format(" |cffffffff%s|r", ElvUI_EltreumUI.Version)
	E.Options.args.ElvUI_EltreumUI = {
		order = 6,
		type = 'group',
		name = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:18:18:0:0|t" .. ElvUI_EltreumUI.Name,
		args = {
			logo = {
				type = 'description',
				name = "",
				order = 6,
				image = function() return 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\logohq', 320, 80 end,
			},
			installer = ElvUI_EltreumUI:InstallerOptions(),
			afk = ElvUI_EltreumUI:AFKOptions(),
			cursor = ElvUI_EltreumUI:CursorOptions(),
			quests = ElvUI_EltreumUI:QuestOptions(),
			aurafilters = ElvUI_EltreumUI:AuraOptions(),
			misc = ElvUI_EltreumUI:MiscOptions(),
			skins = ElvUI_EltreumUI:SkinsOptions(),
			profiles = ElvUI_EltreumUI:ProfileOptions(),
			combatmusic = ElvUI_EltreumUI:CombatMusicOptions(),
			customglow = ElvUI_EltreumUI:CustomGlowOptions(),
			borders = ElvUI_EltreumUI:BorderOptions(),
			cvars = ElvUI_EltreumUI:CvarOptions(),
			partyraidsettings = ElvUI_EltreumUI:PartyOptions(),
			maps = ElvUI_EltreumUI:MapOptions(),
			media = ElvUI_EltreumUI:MediaOptions(),
			unitframes = ElvUI_EltreumUI:UnitframesOptions(),
			nameplates = ElvUI_EltreumUI:NameplateOptions(),
			loottext = ElvUI_EltreumUI:LootOptions(),
			chat = ElvUI_EltreumUI:ChatOptions(),
			weakauras = ElvUI_EltreumUI:OptionsWeakAuras(),
			discord = ElvUI_EltreumUI:OptionsDiscord(),
			credits = ElvUI_EltreumUI:CreditsOptions(),
			support = ElvUI_EltreumUI:SupportOptions(),
		},
	}
	for _, func in pairs(ElvUI_EltreumUI.Config) do
		func()
	end
end
