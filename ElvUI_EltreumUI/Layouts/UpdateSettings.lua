local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Settings that would be true but became false by default per request,
--now a function that can be used to set them while importing the profiles
function ElvUI_EltreumUI:UpdateSettings()

	-- Chat
	E.db.ElvUI_EltreumUI.chat.enable = true
	E.db.ElvUI_EltreumUI.chat.colorsysmsg = true
	E.db.ElvUI_EltreumUI.chat.looticons = true
	E.db.ElvUI_EltreumUI.chat.itemlevels = true
	E.db.ElvUI_EltreumUI.chat.rollsound = true

	--CVars
	if E.Retail then
		E.db.ElvUI_EltreumUI.cvars.autohidenpcname = true
	end

	-- Nameplates
	E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
	E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
	E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = false
	E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
	E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
	E.db.ElvUI_EltreumUI.nameplatepower.texture = "ElvUI Norm1"
	E.db.ElvUI_EltreumUI.nameplatepower.modeleffect = true
	E.db.ElvUI_EltreumUI.darkpowercolor = true
	E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = false -- turns out blizzard fakes the nameplates and alphas the helthbar, causing huge performance costs
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false -- and this one is the same but with health so make this one off as well
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly = true --so hide it instead
	E.db.ElvUI_EltreumUI.widenameplate.enable = true
	E.db.ElvUI_EltreumUI.widenameplate.npglow = true
	E.db.ElvUI_EltreumUI.nptextureversion = "V2"
	E.db.ElvUI_EltreumUI.nameplateOptions.enableHealthHeight = true
	E.db.ElvUI_EltreumUI.nameplateOptions.useelvuinpheight = true
	E.db.ElvUI_EltreumUI.nameplateOptions.targetmodel = true

	-- Gradient/Unitframe stuff
	E.db.ElvUI_EltreumUI.gradientmode.texture = "Asphyxia-Norm"
	E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar = true
	E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarinterrupted = true
	E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarnoninterruptible = true
	E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar = true
	E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarinterrupted = true
	E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarnoninterruptible = true
	E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar = true
	E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar = true
	E.db.ElvUI_EltreumUI.gradientmode.nporientation = "VERTICAL"
	E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor = false
	E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture = "Asphyxia-Norm"
	E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha = 0.7
	E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = true
	E.db.ElvUI_EltreumUI.sparkcustomcolor.texture = 'Eltreum-Fade'
	E.db.ElvUI_EltreumUI.sparkcustomcolor.width = 20

	E.db.ElvUI_EltreumUI.uftextureversion = "V2"
	E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect = true
	E.db.unitframe.statusbar = "ElvUI Norm1"

	--databar
	E.db.ElvUI_EltreumUI.gradientmode.gradientXP = true
	E.db.databars.statusbar = "Asphyxia-Norm"

	-- Skins
	E.db.ElvUI_EltreumUI.skins.enable = true
	E.db.ElvUI_EltreumUI.skins.widertransmog = true
	E.db.ElvUI_EltreumUI.skins.expandedstable = true
	E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
	E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
	E.db.ElvUI_EltreumUI.skins.classiconsblizz = false
	E.db.ElvUI_EltreumUI.skins.classicarmory = true
	E.db.ElvUI_EltreumUI.skins.classicarmoryautostats = true
	E.db.ElvUI_EltreumUI.skins.ilvls = true
	E.db.ElvUI_EltreumUI.skins.sockets = true
	E.db.ElvUI_EltreumUI.skins.socketsinspect = true
	E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
	E.db.ElvUI_EltreumUI.skins.armorybgtype = "RACE"
	E.db.ElvUI_EltreumUI.skins.expandarmorybgalpha = 0.7
	E.db.ElvUI_EltreumUI.skins.itemquality = true
	E.db.ElvUI_EltreumUI.skins.statcolors = true
	E.db.ElvUI_EltreumUI.skins.bossemote = true
	E.db.ElvUI_EltreumUI.skins.quests = true
	E.db.ElvUI_EltreumUI.skins.questswowhead = true
	E.db.ElvUI_EltreumUI.skins.professions = true
	E.db.ElvUI_EltreumUI.skins.zones = true
	E.db.ElvUI_EltreumUI.skins.shadows = true
	E.db.ElvUI_EltreumUI.glow.enable = true
	E.db.ElvUI_EltreumUI.glow.pixel = true
	E.db.ElvUI_EltreumUI.glow.enablepet = true

	--borders
	E.db.ElvUI_EltreumUI.borders.minimapborder = true
	E.db.ElvUI_EltreumUI.borders.playerborder = true
	E.db.ElvUI_EltreumUI.borders.playercastborder = true
	E.db.ElvUI_EltreumUI.borders.targetborder = true
	E.db.ElvUI_EltreumUI.borders.targetcastborder = true
	E.db.ElvUI_EltreumUI.borders.targettargetborder = true
	E.db.ElvUI_EltreumUI.borders.petborder = true
	E.db.ElvUI_EltreumUI.borders.totembar = true
	E.db.ElvUI_EltreumUI.borders.chatborder = true
	E.db.ElvUI_EltreumUI.borders.auraborder = true
	E.db.ElvUI_EltreumUI.borders.stanceborders = true
	E.db.ElvUI_EltreumUI.borders.petactionborders = true
	E.db.ElvUI_EltreumUI.borders.totembar = true

	--shadows
	E.db.ElvUI_EltreumUI.shadows.aura = true
	E.db.ElvUI_EltreumUI.shadows.ufaura = true
	E.db.ElvUI_EltreumUI.shadows.actionbars = true
	E.db.ElvUI_EltreumUI.shadows.raid = true

	-- Misc
	E.db.ElvUI_EltreumUI.tbctalents.enable = true
	E.db.ElvUI_EltreumUI.dynamicdatatext.enable = true

	E.db.ElvUI_EltreumUI.cursor.enable = true
	E.db.ElvUI_EltreumUI.cursor.cooldown = true
	E.db.ElvUI_EltreumUI.cursor.combat = true
	E.db.ElvUI_EltreumUI.cursorcast.radius = 30
	E.db.ElvUI_EltreumUI.cursorgcd.radius = 25
	E.db.ElvUI_EltreumUI.cursorcursor.radius = 20
	E.db.ElvUI_EltreumUI.cursor.ring = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring2.tga'

	E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
	E.db.ElvUI_EltreumUI.partyraiddeath.enable = false

	E.db.ElvUI_EltreumUI.afkmusic.enable = true
	if E.Retail then
		E.db.ElvUI_EltreumUI.afkmusic.racial = false
		E.db.ElvUI_EltreumUI.afkmusic.playerclass = true
	else
		E.db.ElvUI_EltreumUI.afkmusic.racial = true
		E.db.ElvUI_EltreumUI.afkmusic.playerclass = false
	end

	E.db.ElvUI_EltreumUI.waypointetasetting.enable = true
	E.db.ElvUI_EltreumUI.waypointetasetting.autopin = true
	E.db.ElvUI_EltreumUI.waytext.enable = true
	if E.Retail then
		E.db.ElvUI_EltreumUI.questsettings.enable = true
		E.db.ElvUI_EltreumUI.questsettings.arena = true
	elseif E.Wrath or E.TBC or E.Classic then
		E.db.ElvUI_EltreumUI.questsettings.enable = false
		E.db.ElvUI_EltreumUI.questsettings.arena = false
		E.db.ElvUI_EltreumUI.glow.enabletotem = true
	end
	E.db.ElvUI_EltreumUI.questsettings.rogueopen = true
	if E.Retail then
		E.db.ElvUI_EltreumUI.questsettings.questitems = false
	else
		E.db.ElvUI_EltreumUI.questsettings.questitems = true
	end
	E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
	E.db.ElvUI_EltreumUI.questsettings.questitemsfade = false
	--E.db.ElvUI_EltreumUI.questsettings.autoaccept = true  --maybe in the future?

	--loot
	E.db.ElvUI_EltreumUI.loottext.enable = true
	E.db.ElvUI_EltreumUI.loottext.fontsetting = true
	E.db.ElvUI_EltreumUI.loottext.combatindicator = true
	E.db.ElvUI_EltreumUI.otherstuff.fastloot = true
	E.db.ElvUI_EltreumUI.otherstuff.fastlootfilter = false
	E.db.ElvUI_EltreumUI.otherstuff.lootwishlistfilter = false
	E.db.ElvUI_EltreumUI.otherstuff.lootautoclose = true

	-- misc
	E.db.ElvUI_EltreumUI.otherstuff.screenshot = true
	E.db.ElvUI_EltreumUI.instances.enable = true
	E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
	if IsAddOnLoaded('NameplateSCT') or IsAddOnLoaded('ElvUI_FCT') then
		E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
	end
	E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
	E.db.ElvUI_EltreumUI.otherstuff.playerdeath = true
	E.db.ElvUI_EltreumUI.otherstuff.playerdeathgta = false
	E.db.ElvUI_EltreumUI.otherstuff.playerdeathcustom = false
	E.db.ElvUI_EltreumUI.otherstuff.mpluskeys = true
	E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons = true
	E.db.ElvUI_EltreumUI.otherstuff.delete = true

	E.db.ElvUI_EltreumUI.otherstuff.gamemenu = true

	--private
	E.private.ElvUI_EltreumUI.nameplatepower.enable = true
	E.private.ElvUI_EltreumUI.nameplatepower.adjust = true

	-- primary and secondary media texture for elvui
	E.private.general.glossTex = "Asphyxia-Norm"
	E.private.general.normTex = "Asphyxia-Norm"

	ElvUI_EltreumUI:Print(L["Settings for Eltruism were applied."])
end
