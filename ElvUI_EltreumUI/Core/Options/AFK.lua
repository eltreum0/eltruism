local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G

-- Eltruism afk options
function ElvUI_EltreumUI:AFKOptions()
	ElvUI_EltreumUI.Options.args.afk = E.Libs.ACH:Group(E:TextGradient(L["A.F.K"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Enhance the AFK screen"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.afk.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\afk'
	ElvUI_EltreumUI.Options.args.afk.args.description1 = E.Libs.ACH:Description(L["Play music while you are AFK"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.afk.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 3, nil, false,"full",function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable = value end)
	ElvUI_EltreumUI.Options.args.afk.args.description2 = E.Libs.ACH:Description(L["Select a type of music"], 4, nil, nil, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.afk.args.racialmusic = E.Libs.ACH:Toggle(L["Racial Music"], nil, 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end, not E.Retail)
	ElvUI_EltreumUI.Options.args.afk.args.classmusic = E.Libs.ACH:Toggle(L["Class Music"], nil, 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end, not E.Retail)
	ElvUI_EltreumUI.Options.args.afk.args.description3 = E.Libs.ACH:Description(L["Skin"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.afk.args.afkskin = E.Libs.ACH:Toggle(L["Enable"], nil, 7, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.afklogo end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afklogo = value end)
	ElvUI_EltreumUI.Options.args.afk.args.eltruismlogo = E.Libs.ACH:Toggle(L["Eltruism Logo"], nil, 8, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.afklogoeltruism end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afklogoeltruism = value end)
end
