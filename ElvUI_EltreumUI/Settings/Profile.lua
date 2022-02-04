local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Eltreum UI Profile DB
P.ElvUI_EltreumUI = {

	dev = false,

	nameplatepower = {
		autoadjustposition = false,
		sizex = 132,
		sizey = 6,
		posy = 16,
		texture = "Eltreum-Elvui-Norm",
		r = 0,
		g = 0,
		b = 0,
	},

	chat = {
		enable = false,
		leftmouseover = false,
		rightmouseover = false,
		leftfader = false,
		rightfader = false,
		leftcombathide = false,
		rightcombathide = false,
		invertclick = false,
		colorsysmsg = false,
		rollsound = false,
		looticons = false,
	},

	cvars = {
		nameplateOtherBottomInset = 0.02,
		nameplateOtherTopInset = 0.1,
		cameraDistanceMaxZoomFactor = 2.6,
		nameplateTargetRadialPosition = 1,
		--for retail
		showInGameNavigation = 1,
		--for tbc/classic
		clampTargetNameplateToScreen = 1,
		autohidenpcname = false,
	},

	skins = {
		enable = false,
		widertransmog = false,
		expandedstable = false,
		classiconsoncharacterpanel = false,
		classiconsblizz = false,
		classiconsreleaf = false,
		classicarmory = false,
		classicarmoryautostats = false,
		ilvls = false,
		sockets = false,
		ilvlanchor = "CENTER",
		ilvlfontsize = 16,
		ilvlfontweight = "THICKOUTLINE",
		expandarmorybg = false,
		expandarmorybgalpha = 0.3,
		bossemote = false,
		quests = false,
		zones = false,
		shadows = false,
	},

	shadows = {
		aura = false,
		ufaura = false,
		actionbars = false,
		nameplates = false, --healthbars
		npauras = false,
		npportraits = false,
		nppower = false,
		npcastbar = false,
	},

	tbctalents = {
		enable = false,
	},

	dynamicdatatext = {
		enable = false,
	},

	nameplatelevel = {
		enable = false,
	},

	cursor = {
		enable = false,
		ring = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga',
		size = '-1',
		cooldown = false,
		fixlag = false,
		combat = true,
	},

	cursorcast = {
		radius = 25,
		sublayer = 1,
		thickness = 5,
		classcolor = true,
		r = 0.27,
		g = 0.50,
		b = 0.70,
		a = 1,
	},

	cursorgcd = {
		radius = 20,
		sublayer = 0,
		thickness = 5,
		classcolor = false,
		r = 1,
		g = 1,
		b = 1,
		a = 1,
	},

	cursorcursor = {
		radius = 15,
		sublayer = 0,
		thickness = 5,
		combat = true,
		classcolor = false,
		r = 0.5,
		g = 0.5,
		b = 0.5,
		a = 1,
	},

	nameplateOptions = {
		ClassColorGlow = false,
		ClassBorderNameplate = false,
		nameplatetexture = false,
		classbarautohide = false,
		targetclasstexture = false,
	},

	stealthOptions = {
		stealtheffect = false,
	},

	glow = {
		enable = false,
		enablepet = false,
		enabletotem = false,
		blizzard = false,
		pixel = false,
		autocast = false,

		totemtypecolor = true,
		totem1 = true,
		totem2 = true,
		totem3 = true,
		totem4 = true,
		colorclass = true,
		colorclasspet = true,
		colorclassnp = true,
		numberpixel = 9,
		frequencypixel = 1,
		lengthpixel = 3,
		thicknesspixel = 5,
		pixelxOffset = 5,
		pixelyOffset = 5,
		borderpixel = false,
		numberauto = 8,
		frequencyauto = 0.8,
		autoscale = 2,
		autoxOffset = 5,
		autoyOffset = 5,
		frequencyblizz = 0.5,
	},

	glowcustomcolor = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	glowcustomcolorpet = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	glowcustomcolornp = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	glowtotem1customcolor = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	glowtotem2customcolor = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	glowtotem3customcolor = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	glowtotem4customcolor = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
	},

	partyraiddeath = {
		enable = false,
		bgdisable = false,
		playerdeathsound = "bruh",
	},

	friendlynameplatetoggle = {
		disablefriendly = false,
		friendlynames = false,
		hidefriendly = false,
	},

	afkmusic = {
		enable = false,
		racial = true,
		playerclass = false,
	},

	fonts = {
		playerfont = "Kimberley"
	},

	waypointetasetting = {
		enable = false,
		autopin = false,
	},

	waytext = {
		enable = false,
	},

	widenameplate = {
		enable = false,
		npglow = false,
	},

	questsettings = {
		enable = false,
		rogueopen = false,
		arena = false,
		combatenable = false,
		autoaccept = false,
		autoacceptinvert = false,
		questitems = false,
		questitemsbar1 = false,
		questitemsize = 36,
		questitemsfade = false,
	},

	loottext = {
		enable = false,
		honor = true,
		currency = true,
		pet = true,
		scale = 0.65,
		strata = "BACKGROUND",
		xOffset = 0,
		yOffset = 200,
		fontsetting = true,
		combatindicator = false,
	},

	borders = {
		borders = false,
		texture = "better-blizzard-border-small-alternate",

		classcolor = true,

		playertargetsize = 20,
		baredgesize = 13,

		powerbarborder = false,
		powerbarsize = 4,
		xpowerbar = 138,
		ypowerbar = 12,

		playerborder = false,
		xplayer = 303,
		yplayer = 75,

		playercastborder = false,
		xplayercast = 272,
		yplayercast = 58,

		targetborder = false,
		xtarget = 303,
		ytarget = 75,

		targetcastborder = false,
		xcasttarget = 272,
		ycasttarget = 58,

		targettargetborder = false,
		xtargettarget = 134,
		ytargettarget = 75,

		bar1borders = true,
		bar1xborder = 65,
		bar1yborder = 56,

		bar2borders = true,
		bar2xborder = 56,
		bar2yborder = 50,

		bar3borders = true,
		bar3xborder = 56,
		bar3yborder = 50,

		bar4borders = true,
		bar4xborder = 56,
		bar4yborder = 50,

		bar5borders = true,
		bar5xborder = 56,
		bar5yborder = 50,

		bar6borders = false,
		bar6xborder = 52,
		bar6yborder = 44,

		bar7borders = false,
		bar7xborder = 52,
		bar7yborder = 44,

		bar8borders = false,
		bar8xborder = 52,
		bar8yborder = 44,

		bar9borders = false,
		bar9xborder = 52,
		bar9yborder = 44,

		bar10borders = false,
		bar10xborder = 52,
		bar10yborder = 44,
	},

	bordercolors = {
		r = 0.27,
		g = 0.50,
		b = 0.70,
		a = 1,
	},

	lightmode = false,
	modetexture = false,
	greybackground = false,

	sparkcustomcolor ={
		enable = false,
		texture = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga',
		r = 0.80,
		g = 0.80,
		b = 0.10,
		a = 1,
		width = 3,
	},

	media = {
		font = false,
		border = false,
		statusbar = false,
		texture = false,
		sound = false,
	},

	otherstuff ={
		worldtextscale = 1,
		arenabuffs = false,
		bgunitframes = false,
		arenaunitframes = false,
		fastloot = false,
		screenshot = false,
		hidetalkinghead = false,
		blizzcombattext = false,
		blizzcombatmana = false,
		mapcombathide = false,
		dynamicxpbar = false,
		delete = false,
		--floatingrep = false,
	},
}
