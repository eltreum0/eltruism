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
	E.db.ElvUI_EltreumUI.darkpowercolor = true
	E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = false -- turns out blizzard fakes the nameplates and alphas the helthbar, causing huge performance costs
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false -- and this one is the same but with health so make this one off as well
	E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly = true --so hide it instead
	E.db.ElvUI_EltreumUI.widenameplate.enable = true
	E.db.ElvUI_EltreumUI.widenameplate.npglow = true
	E.db.ElvUI_EltreumUI.nptextureversion = "V2"

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
	E.db.ElvUI_EltreumUI.gradientmode.npenable = true
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
	E.db.ElvUI_EltreumUI.questsettings.questitems = false
	if not E.Retail then
		E.db.ElvUI_EltreumUI.questsettings.questitems = true
	end
	E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
	E.db.ElvUI_EltreumUI.questsettings.questitemsfade = false

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


	--fix some colors for gradient np
	E.db["nameplates"]["colors"]["reactions"]["bad"]["b"] = 0.25
	E.db["nameplates"]["colors"]["reactions"]["bad"]["g"] = 0.25
	E.db["nameplates"]["colors"]["reactions"]["bad"]["r"] = 0.78
	E.db["nameplates"]["colors"]["reactions"]["good"]["b"] = 0.30
	E.db["nameplates"]["colors"]["reactions"]["good"]["g"] = 0.68
	E.db["nameplates"]["colors"]["reactions"]["good"]["r"] = 0.29
	E.db["nameplates"]["colors"]["reactions"]["neutral"]["b"] = 0.36
	E.db["nameplates"]["colors"]["reactions"]["neutral"]["g"] = 0.77
	E.db["nameplates"]["colors"]["reactions"]["neutral"]["r"] = 0.85
	E.db["nameplates"]["colors"]["tapped"]["r"] = 0.6
	E.db["nameplates"]["colors"]["tapped"]["g"] = 0.6
	E.db["nameplates"]["colors"]["tapped"]["b"] = 0.6
	E.db["nameplates"]["colors"]["selection"][0]["r"] = 1.00
	E.db["nameplates"]["colors"]["selection"][0]["g"] = 0.18
	E.db["nameplates"]["colors"]["selection"][0]["b"] = 0.18 -- HOSTILE
	E.db["nameplates"]["colors"]["selection"][1]["r"] = 1.00
	E.db["nameplates"]["colors"]["selection"][1]["g"] = 0.51
	E.db["nameplates"]["colors"]["selection"][1]["b"] = 0.20 -- UNFRIENDLY
	E.db["nameplates"]["colors"]["selection"][2]["r"] = 1.00
	E.db["nameplates"]["colors"]["selection"][2]["g"] = 0.85
	E.db["nameplates"]["colors"]["selection"][2]["b"] = 0.20 -- NEUTRAL
	E.db["nameplates"]["colors"]["selection"][3]["r"] = 0.20
	E.db["nameplates"]["colors"]["selection"][3]["g"] = 0.71
	E.db["nameplates"]["colors"]["selection"][3]["b"] = 0.00 -- FRIENDLY
	E.db["nameplates"]["colors"]["selection"][5]["r"] = 0.40
	E.db["nameplates"]["colors"]["selection"][5]["g"] = 0.53
	E.db["nameplates"]["colors"]["selection"][5]["b"] = 1.00 -- PLAYER_EXTENDED
	E.db["nameplates"]["colors"]["selection"][6]["r"] = 0.40
	E.db["nameplates"]["colors"]["selection"][6]["g"] = 0.20
	E.db["nameplates"]["colors"]["selection"][6]["b"] = 1.00 -- PARTY
	E.db["nameplates"]["colors"]["selection"][7]["r"] = 0.73
	E.db["nameplates"]["colors"]["selection"][7]["g"] = 0.20
	E.db["nameplates"]["colors"]["selection"][7]["b"] = 1.00 -- PARTY_PVP
	E.db["nameplates"]["colors"]["selection"][7]["r"] = 0.73
	E.db["nameplates"]["colors"]["selection"][7]["g"] = 0.20
	E.db["nameplates"]["colors"]["selection"][7]["b"] = 1.00 -- PARTY_PVP
	E.db["nameplates"]["colors"]["selection"][8]["r"] = 0.20
	E.db["nameplates"]["colors"]["selection"][8]["g"] = 1.00
	E.db["nameplates"]["colors"]["selection"][8]["b"] = 0.42 -- FRIEND
	E.db["nameplates"]["colors"]["selection"][9]["r"] = 0.60
	E.db["nameplates"]["colors"]["selection"][9]["g"] = 0.60
	E.db["nameplates"]["colors"]["selection"][9]["b"] = 0.60 -- DEAD
	E.db["nameplates"]["colors"]["selection"][13]["r"] = 0.10
	E.db["nameplates"]["colors"]["selection"][13]["g"] = 0.58
	E.db["nameplates"]["colors"]["selection"][13]["b"] = 0.28 -- BATTLEGROUND_FRIENDLY_PVP

	--update to current hp method
	if E.db["unitframe"]["units"]["player"]["customTexts"]then
		E.db["unitframe"]["units"]["focus"]["health"]["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]"
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"]["text_format"] = "[eltruism:hpstatus{5,3}]"
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetHealth"]["text_format"] = "[eltruism:hpstatus{5,3}]"
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["text_format"] = "[eltruism:hpstatusnopc{5,3}]"
		end
		if not E.Classic then
			E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumArenaHealth"]["text_format"] = "[eltruism:hpstatusnopc{5,3}]"
		end
		if E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"] then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumRaidHealth"]["text_format"] = "[eltruism:hpstatusnopc{5,3}]"
		end
		if E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"] then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumRaid40Health"]["text_format"] = "[eltruism:hpstatusnopc{5,3}]"
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyHealth"]["text_format"] = "[eltruism:hpstatusnopc{5,3}]"
		end
		if E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"]["enable"] = false
		end
		if E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"]["enable"] = false
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"]["enable"] = true
		end
		if E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"]["enable"] = false
		end
		if E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetHealth"]["enable"] = false
		end
		if E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumStatus"]["enable"] = false
		end
		if E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumStatus"] then
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumStatus"]["enable"] = false
		end
		if not E.Classic then
			if E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"] then
				E.db["unitframe"]["units"]["arena"]["customTexts"]["EltreumStatus"]["enable"] = false
			end
		end
	end

	ElvUI_EltreumUI:Print(L["Settings for Eltruism were applied."])
end
