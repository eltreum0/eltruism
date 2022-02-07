local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Old settings ettings that would be true but became false per request, now a function that can be used
function ElvUI_EltreumUI:UpdateSettings()
	E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
	E.db.ElvUI_EltreumUI.chat.enable = true
	--E.db.ElvUI_EltreumUI.chat.leftcombathide = true
	E.db.ElvUI_EltreumUI.chat.colorsysmsg = true
	E.db.ElvUI_EltreumUI.chat.looticons = true
	if ElvUI_EltreumUI.Retail then
		E.db.ElvUI_EltreumUI.cvars.autohidenpcname = true
	end
	E.db.ElvUI_EltreumUI.skins.enable = true
	E.db.ElvUI_EltreumUI.skins.widertransmog = true
	E.db.ElvUI_EltreumUI.skins.expandedstable = true
	E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
	E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
	E.db.ElvUI_EltreumUI.skins.classicarmory = true
	E.db.ElvUI_EltreumUI.skins.classicarmoryautostats = true
	E.db.ElvUI_EltreumUI.skins.ilvls = true
	E.db.ElvUI_EltreumUI.skins.sockets = true
	E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
	E.db.ElvUI_EltreumUI.skins.bossemote = true
	E.db.ElvUI_EltreumUI.skins.quests = true
	E.db.ElvUI_EltreumUI.skins.zones = true
	E.db.ElvUI_EltreumUI.skins.shadows = true
	E.db.ElvUI_EltreumUI.shadows.aura = true
	E.db.ElvUI_EltreumUI.shadows.ufaura = true
	E.db.ElvUI_EltreumUI.shadows.actionbars = true
	E.db.ElvUI_EltreumUI.tbctalents.enable = true
	E.db.ElvUI_EltreumUI.dynamicdatatext.enable = true
	E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
	E.db.ElvUI_EltreumUI.cursor.enable = true
	E.db.ElvUI_EltreumUI.cursor.cooldown = true
	E.db.ElvUI_EltreumUI.cursor.combat = true
	E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
	E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
	E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
	E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
	E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
	E.db.ElvUI_EltreumUI.glow.enable = true
	E.db.ElvUI_EltreumUI.glow.pixel = true
	E.db.ElvUI_EltreumUI.glow.enablepet = true
	E.db.ElvUI_EltreumUI.partyraiddeath.enable = true
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = false -- turns out blizzard fakes the nameplates and alphas the helthbar, causing huge performance costs
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly = true --so hide it instead
	E.db.ElvUI_EltreumUI.afkmusic.enable = true
	E.db.ElvUI_EltreumUI.afkmusic.racial = true
	E.db.ElvUI_EltreumUI.waypointetasetting.enable = true
	E.db.ElvUI_EltreumUI.waypointetasetting.autopin = true
	E.db.ElvUI_EltreumUI.waytext.enable = true
	E.db.ElvUI_EltreumUI.widenameplate.enable = true
	E.db.ElvUI_EltreumUI.widenameplate.npglow = true
	if ElvUI_EltreumUI.Retail then
		E.db.ElvUI_EltreumUI.questsettings.enable = true
		E.db.ElvUI_EltreumUI.questsettings.arena = true
	elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
		E.db.ElvUI_EltreumUI.questsettings.enable = false
		E.db.ElvUI_EltreumUI.questsettings.arena = false
		E.db.ElvUI_EltreumUI.glow.enabletotem = true
	end
	E.db.ElvUI_EltreumUI.questsettings.rogueopen = true
	E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
	E.db.ElvUI_EltreumUI.loottext.enable = true
	E.db.ElvUI_EltreumUI.loottext.fontsetting = true
	E.db.ElvUI_EltreumUI.loottext.combatindicator = true
	E.db.ElvUI_EltreumUI.modetexture = true
	E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = true
	E.db.ElvUI_EltreumUI.otherstuff.fastloot = true
	E.db.ElvUI_EltreumUI.otherstuff.screenshot = true
	E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
	E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
	E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
	--private
	E.private.ElvUI_EltreumUI.nameplatepower.enable = true
	E.private.ElvUI_EltreumUI.nameplatepower.adjust = true
	E.private.ElvUI_EltreumUI.combatmusic.enable = true
	E.private.ElvUI_EltreumUI.combatmusic.bossmusic = true
	E.private.ElvUI_EltreumUI.combatmusic.disableinstance = true

	ElvUI_EltreumUI:Print(L["Settings for Eltruism were applied."])
end
