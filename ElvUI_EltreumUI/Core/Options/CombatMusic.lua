local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G

-- Eltruism combat music options
function ElvUI_EltreumUI:CombatMusicOptions()
	ElvUI_EltreumUI.Options.args.combatmusic = E.Libs.ACH:Group(E:TextGradient(L["Combat Music"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Play custom music during fights and boss fights"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.combatmusic.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\music'
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat = E.Libs.ACH:Group(L["Combat Music"], nil, 1)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.enable = E.Libs.ACH:Toggle(L["Enable Combat Music"], L["Enable music during combat"], 4, nil, false,"full",function() return E.private.ElvUI_EltreumUI.combatmusic.enable end,function(_, value) E.private.ElvUI_EltreumUI.combatmusic.enable = value E:StaticPopup_Show('PRIVATE_RL') end)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.disableinstance = E.Libs.ACH:Toggle(L["Disable Combat Music in Instances"], L["Disable music during combat in instances"], 5, nil, false,"full",function() return E.private.ElvUI_EltreumUI.combatmusic.disableinstance end,function(_, value) E.private.ElvUI_EltreumUI.combatmusic.disableinstance = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.description1 = E.Libs.ACH:Description(L["Normal Combat Music"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.filepath = E.Libs.ACH:Group(L["Name of file inside Interface\\Addons"], nil, 7)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.filepath.inline = true
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.filepath.args.description1 = E.Libs.ACH:Description(L["Example: "].."mymusic.mp3", 1)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.filepath.args.shuffle = E.Libs.ACH:Toggle(L["Shuffle"], L["Randomize Music Order"], 2, nil, false,"full",function() return E.db.ElvUI_EltreumUI.otherstuff.musicshuffle end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.musicshuffle = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.filepath.args.input = E.Libs.ACH:Input("", "", 3, false, "full", function() return E.private.ElvUI_EltreumUI.combatmusic.musicfile end, function(_, value) E.private.ElvUI_EltreumUI.combatmusic.musicfile = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end, E.db.ElvUI_EltreumUI.otherstuff.musicshuffle)
	ElvUI_EltreumUI.Options.args.combatmusic.args.combat.args.filepath.args.inputshuffle = E.Libs.ACH:Input(L["Shuffle List"], L["Split files with a comma, such as: file1.mp3,file2.mp3"], 3, false, "full", function() return E.private.ElvUI_EltreumUI.combatmusic.shufflelist end, function(_, value) E.private.ElvUI_EltreumUI.combatmusic.shufflelist = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.enable end, not E.db.ElvUI_EltreumUI.otherstuff.musicshuffle)
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss = E.Libs.ACH:Group(L["Boss Music"], nil, 2)
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss.args.enable = E.Libs.ACH:Toggle(L["Enable Boss Music"], L["Enable music during combat"], 4, nil, false,"full",function() return E.private.ElvUI_EltreumUI.combatmusic.bossmusic end,function(_, value) E.private.ElvUI_EltreumUI.combatmusic.bossmusic = value E:StaticPopup_Show('PRIVATE_RL') end)
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss.args.description1 = E.Libs.ACH:Description(L["Boss Combat Music"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss.args.filepath = E.Libs.ACH:Group(L["Name of file inside Interface\\Addons"], nil, 7)
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss.args.filepath.inline = true
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss.args.filepath.args.description1 = E.Libs.ACH:Description(L["Example: "].."mymusic.mp3", 1)
	ElvUI_EltreumUI.Options.args.combatmusic.args.boss.args.filepath.args.input = E.Libs.ACH:Input("", "", 3, false, "full", function() return E.private.ElvUI_EltreumUI.combatmusic.bossfile end, function(_, value) E.private.ElvUI_EltreumUI.combatmusic.bossfile = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.private.ElvUI_EltreumUI.combatmusic.bossmusic end)
end
