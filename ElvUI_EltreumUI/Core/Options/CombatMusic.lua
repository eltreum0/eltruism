local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G

-- Eltruism combat music options
local isPlayingMusic = false
function ElvUI_EltreumUI:CombatMusicOptions()
	ElvUI_EltreumUI.Options.args.combat = E.Libs.ACH:Group(E:TextGradient(L["Combat"], 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 5, 'tab')
	ElvUI_EltreumUI.Options.args.combat.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\combat'

	ElvUI_EltreumUI.Options.args.combat.args.combat = E.Libs.ACH:Group(L["Combat"], nil, 1)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.descriptiondeathsound = E.Libs.ACH:Description(L["Play a sound when someone dies in Party or Raid"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.deathssound = E.Libs.ACH:Toggle(L["Enable"], nil, 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable = value end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.deathssoundbg= E.Libs.ACH:Toggle(L["Disable in Battlegrounds/Arenas"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.bgdisable end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.bgdisable = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.deathssoundLSM = E.Libs.ACH:SharedMediaSound(L["Select a Sound"], L["Choose a Sound from SharedMedia files"], 4, "double", function() return E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.playerdeathsound end, function(_,key) E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.playerdeathsound = key end, function() return not E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable end)
	--ElvUI_EltreumUI.Options.args.combat.args.combat.args.descriptionauratoggle = E.Libs.ACH:Description(" ", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.description1 = E.Libs.ACH:Description(L["Show Buffs in Arena and hide them outside (will overwrite Eltruism default settings)"], 11, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.arenabuffs = E.Libs.ACH:Toggle(L["Enable"], nil, 12, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.arenabuffs end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.arenabuffs = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.description2 = E.Libs.ACH:Description(L["Hide Arena Frames in Arena due to Gladdy or another addon"], 13, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Classic)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.arenaUF = E.Libs.ACH:Toggle(L["Enable"], nil, 14, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.arenaunitframes end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.arenaunitframes = value E:StaticPopup_Show('CONFIG_RL') end, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.description3 = E.Libs.ACH:Description(L["Hide Raid Unitframes in battlegrounds due to addons like Battleground Enemies"], 15, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.battlegroundUF = E.Libs.ACH:Toggle(L["Enable"], nil, 16, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.bgunitframes end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.bgunitframes = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.description4 = E.Libs.ACH:Description(" ", 17, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.combattextindicator = E.Libs.ACH:Toggle(L["Enable Entering/Leaving Combat Indicator Texts"], L["Adds a +Combat and -Combat for when entering and leaving combat"], 18, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicator end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicator = value E:StaticPopup_Show('CONFIG_RL') end, nil)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.combattextindicatorcustom = E.Libs.ACH:Toggle(L["Custom Texts"], L["Adds a +Combat and -Combat for when entering and leaving combat"], 19, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.combattextenter = E.Libs.ACH:Input(_G.ENTERING_COMBAT or "", nil, 20, false, "double", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enter end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enter = _G.tostring(value) end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.combattextentercolor = E.Libs.ACH:Color(L["COLOR"], nil, 21, false, nil, function()
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor
		local d = P.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor
		return color.r, color.g, color.b, 1, d.r, d.g, d.b,1
	end, function(_, r, g, b)
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor
		color.r, color.g, color.b = r, g, b
	end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.combattextleave = E.Libs.ACH:Input(_G.LEAVING_COMBAT or "", nil, 22, false, "double", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leave end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leave = _G.tostring(value) end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.combattextleavecolor = E.Libs.ACH:Color(L["COLOR"], nil, 23, false, nil, function()
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor
		local d = P.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor
		return color.r, color.g, color.b, 1, d.r, d.g, d.b, 1
	end, function(_, r, g, b)
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor
		color.r, color.g, color.b = r, g, b
	end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.description5 = E.Libs.ACH:Description(" ", 24, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.darksouls = E.Libs.ACH:Toggle(L["Enable a Dark Souls death animation"], L["Plays an animation when you die"], 25, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeath end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeath = value end, function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeathcustom end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.gta = E.Libs.ACH:Toggle(L["Enable a GTA death animation"], L["Plays an animation when you die"], 25, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathgta = value end, function() return E.db.ElvUI_EltreumUI.skins.playerdeath or E.db.ElvUI_EltreumUI.skins.playerdeathcustom end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.customdeath = E.Libs.ACH:Toggle(L["Enable a Custom death animation"], L["Plays an animation when you die"], 26, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeathcustom end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathcustom = value end, function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeath end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.customdeathtext = E.Libs.ACH:Input(L["Custom Death Text"], L["The text displayed when you die using the custom text option"], 27, false, nil, function() return E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext = _G.tostring(value) E:StaticPopup_Show('PRIVATE_RL') end, function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeath or (not E.db.ElvUI_EltreumUI.skins.playerdeathcustom) end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.previewdeath = E.Libs.ACH:Execute(_G.PREVIEW or "", nil, 28, function() ElvUI_EltreumUI:PlayerDeathAnimation(true) end, nil, false, "full", nil, nil, function() return not (E.db.ElvUI_EltreumUI.skins.playerdeath or E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeathcustom) end)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.description6 = E.Libs.ACH:Description(" ", 29, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.ClassicHC)
	ElvUI_EltreumUI.Options.args.combat.args.combat.args.playerdeathhardcore = E.Libs.ACH:Toggle(L["Play a sound when you Die in Hardcore"], nil, 30, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeathhardcore end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathhardcore = value end, nil, not E.ClassicHC)
	--ElvUI_EltreumUI.Options.args.combat.args.combat.args.guildmemberdeathhardcore = E.Libs.ACH:Toggle(L["Enable Animation and Sound when Guild Member Dies"], nil, 20, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore end, function(_, value) E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore = value end, nil, not E.ClassicHC)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic = E.Libs.ACH:Group(L["Combat Music"], L["Play custom music during fights and boss fights"], 2)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.enable = E.Libs.ACH:Toggle(L["Enable Combat Music"], L["Enable music during combat"], 4, nil, false,"full",function() return E.private.ElvUI_EltreumUI.combatmusic.enable end,function(_, value) E.private.ElvUI_EltreumUI.combatmusic.enable = value E:StaticPopup_Show('PRIVATE_RL') end)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.disableinstance = E.Libs.ACH:Toggle(L["Disable Combat Music in Instances"], L["Disable music during combat in instances"], 5, nil, false,"full",function() return E.private.ElvUI_EltreumUI.combatmusic.disableinstance end,function(_, value) E.private.ElvUI_EltreumUI.combatmusic.disableinstance = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.description1 = E.Libs.ACH:Description(L["Normal Combat Music"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath = E.Libs.ACH:Group(L["Name of file inside Interface\\Addons"], nil, 7)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath.inline = true
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath.args.description1 = E.Libs.ACH:Description(L["Example: "].."mymusic.mp3", 1)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath.args.shuffle = E.Libs.ACH:Toggle(L["Shuffle"], L["Randomize Music Order"], 2, nil, false,"full",function() return E.db.ElvUI_EltreumUI.otherstuff.musicshuffle end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.musicshuffle = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath.args.input = E.Libs.ACH:Input("", "", 3, false, "full", function() return E.private.ElvUI_EltreumUI.combatmusic.musicfile end, function(_, value) E.private.ElvUI_EltreumUI.combatmusic.musicfile = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end, E.db.ElvUI_EltreumUI.otherstuff.musicshuffle)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath.args.inputshuffle = E.Libs.ACH:Input(L["Shuffle List"], L["Split files with a comma, such as: file1.mp3,file2.mp3"], 3, false, "full", function() return E.private.ElvUI_EltreumUI.combatmusic.shufflelist end, function(_, value) E.private.ElvUI_EltreumUI.combatmusic.shufflelist = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end, not E.db.ElvUI_EltreumUI.otherstuff.musicshuffle)
	ElvUI_EltreumUI.Options.args.combat.args.combatmusic.args.filepath.args.playpreview = E.Libs.ACH:Execute(_G.PREVIEW or "", nil, 4, function()
		if not isPlayingMusic then
			if E.private.ElvUI_EltreumUI.combatmusic.musicfile and E.private.ElvUI_EltreumUI.combatmusic.musicfile ~= "" then
				_G.PlayMusic("Interface\\AddOns\\" .. E.private.ElvUI_EltreumUI.combatmusic.musicfile)
				isPlayingMusic = true
			end
		else
			_G.StopMusic()
			isPlayingMusic = false
		end
	end, nil, false, nil, nil, nil, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable or not E.private.ElvUI_EltreumUI.combatmusic.musicfile or E.private.ElvUI_EltreumUI.combatmusic.musicfile == "" end)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic = E.Libs.ACH:Group(L["Boss Music"], L["Play custom music during fights and boss fights"], 3)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.enable = E.Libs.ACH:Toggle(L["Enable Boss Music"], L["Enable music during combat"], 4, nil, false,"full",function() return E.private.ElvUI_EltreumUI.combatmusic.bossmusic end,function(_, value) E.private.ElvUI_EltreumUI.combatmusic.bossmusic = value E:StaticPopup_Show('PRIVATE_RL') end)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.description1 = E.Libs.ACH:Description(L["Boss Combat Music"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.filepath = E.Libs.ACH:Group(L["Name of file inside Interface\\Addons"], nil, 7)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.filepath.inline = true
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.filepath.args.description1 = E.Libs.ACH:Description(L["Example: "].."mymusic.mp3", 1)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.filepath.args.input = E.Libs.ACH:Input("", "", 3, false, "full", function() return E.private.ElvUI_EltreumUI.combatmusic.bossfile end, function(_, value) E.private.ElvUI_EltreumUI.combatmusic.bossfile = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.bossmusic end)
	ElvUI_EltreumUI.Options.args.combat.args.bossmusic.args.filepath.args.playpreview = E.Libs.ACH:Execute(_G.PREVIEW or "", nil, 4, function()
		if not isPlayingMusic then
			if E.private.ElvUI_EltreumUI.combatmusic.bossfile and E.private.ElvUI_EltreumUI.combatmusic.bossfile ~= "" then
				_G.PlayMusic("Interface\\AddOns\\" .. E.private.ElvUI_EltreumUI.combatmusic.bossfile)
				isPlayingMusic = true
			end
		else
			_G.StopMusic()
			isPlayingMusic = false
		end
	end, nil, false, nil, nil, nil, function() return not E.private.ElvUI_EltreumUI.combatmusic.bossmusic or not E.private.ElvUI_EltreumUI.combatmusic.bossfile or E.private.ElvUI_EltreumUI.combatmusic.bossfile == "" end)
end
