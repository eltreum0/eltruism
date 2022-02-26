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
		font =  "Kimberley",
		fontsize = 10,
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
		itemlevels = false,
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
		ilvlsinspect = true,
		sockets = false,
		ilvlanchor = "CENTER",
		ilvlfontsize = 16,
		ilvlfontweight = "THICKOUTLINE",
		expandarmorybg = false,
		expandarmorybgalpha = 0.3,
		expandarmorycrest = false,
		bossemote = false,
		quests = false,
		questswowhead = false,
		professions = false,
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
		fixlag = 1,
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
		acceptdaily = false,
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
		xpowerbar = 138.8,
		ypowerbar = 12,

		playerborder = false,
		xplayer = 302,
		yplayer = 75,

		playercastborder = false,
		xplayercast = 272,
		yplayercast = 58,

		targetborder = false,
		xtarget = 302.8,
		ytarget = 75,

		targetcastborder = false,
		xcasttarget = 272,
		ycasttarget = 58,

		targettargetborder = false,
		xtargettarget = 132.8,
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

	gradientmode = {
		enable = false,
		enableplayertarget = true,
		enablegroupunits = true,
		orientation = "HORIZONTAL",
		texture = "Eltreum-Blank",
		customcolor = false,

		druidcustomcolorR1 = 1,
		druidcustomcolorR2 = 1,
		druidcustomcolorG1 = 0.48627450980392,
		druidcustomcolorG2 = 0.37647058823529,
		druidcustomcolorB1 = 0.03921568627451,
		druidcustomcolorB2 = 0.18823529411765,

		huntercustomcolorR1 = 0.28235294117647,
		huntercustomcolorR2 = 0.80392156862745,
		huntercustomcolorG1 = 0.59607843137255,
		huntercustomcolorG2 = 1,
		huntercustomcolorB1 = 0.29411764705882,
		huntercustomcolorB2 = 0.54117647058824,

		paladincustomcolorR1 = 0.95686274509804,
		paladincustomcolorR2 = 1,
		paladincustomcolorG1 = 0.54901960784314,
		paladincustomcolorG2 = 0.76078431372549,
		paladincustomcolorB1 = 0.72941176470588,
		paladincustomcolorB2 = 0.86666666666667,

		magecustomcolorR1 = 0,
		magecustomcolorR2 = 0.49019607843137,
		magecustomcolorG1 = 0.33333333333333,
		magecustomcolorG2 = 0.87058823529412,
		magecustomcolorB1 = 0.53725490196078,
		magecustomcolorB2 = 1,

		roguecustomcolorR1 = 1,
		roguecustomcolorR2 = 1,
		roguecustomcolorG1 = 0.83137254901961,
		roguecustomcolorG2 = 0.95686274509804,
		roguecustomcolorB1 = 0.25490196078431,
		roguecustomcolorB2 = 0.4078431372549,

		priestcustomcolorR1 = 0.98823529411765,
		priestcustomcolorR2 = 0.3568627450980392,
		priestcustomcolorG1 = 0.98823529411765,
		priestcustomcolorG2 = 0.3568627450980392,
		priestcustomcolorB1 = 0.98823529411765,
		priestcustomcolorB2 = 0.3568627450980392,

		deathknightcustomcolorR1 = 0.76862745098039,
		deathknightcustomcolorR2 = 0.76862745098039,
		deathknightcustomcolorG1 = 0.11764705882353,
		deathknightcustomcolorG2 = 0.30588235294118,
		deathknightcustomcolorB1 = 0.22745098039216,
		deathknightcustomcolorB2 = 0.40392156862745,

		demonhuntercustomcolorR1 = 0.36470588235294,
		demonhuntercustomcolorR2 = 0.88235294117647,
		demonhuntercustomcolorG1 = 0.13725490196078,
		demonhuntercustomcolorG2 = 0.27058823529412,
		demonhuntercustomcolorB1 = 0.57254901960784,
		demonhuntercustomcolorB2 = 1,

		shamancustomcolorR1 = 0,
		shamancustomcolorR2 = 0,
		shamancustomcolorG1 = 0.25882352941176,
		shamancustomcolorG2 = 0.50588235294118,
		shamancustomcolorB1 = 0.50980392156863,
		shamancustomcolorB2 = 1,

		warlockcustomcolorR1 = 0.26274509803922,
		warlockcustomcolorR2 = 0.56862745098039,
		warlockcustomcolorG1 = 0.26666666666667,
		warlockcustomcolorG2 = 0.57254901960784,
		warlockcustomcolorB1 = 0.46666666666667,
		warlockcustomcolorB2 = 1,

		warriorcustomcolorR1 = 0.56470588235294,
		warriorcustomcolorR2 = 0.89019607843137,
		warriorcustomcolorG1 = 0.43137254901961,
		warriorcustomcolorG2 = 0.54509803921569,
		warriorcustomcolorB1 = 0.24705882352941,
		warriorcustomcolorB2 = 0.4,

		monkcustomcolorR1 = 0,
		monkcustomcolorR2 = 0.1921568627451,
		monkcustomcolorG1 = 0.77254901960784,
		monkcustomcolorG2 = 1,
		monkcustomcolorB1 = 0.45882352941176,
		monkcustomcolorB2 = 0.74901960784314,
	},

	ufcustomtexture = {
		enable = false,
		backdroptexture = "Eltreum-Blank",
		backdropalpha = 1,
		targettexture = "Eltreum-Blank",
		playertexture = "Eltreum-Blank",
		targettargettexture = "Eltreum-Blank",
		focustexture = "Eltreum-Blank",
		deathknighttexture = "Eltreum-Class-DeathKnight",
		demonhuntertexture = "Eltreum-Class-DemonHunter",
		druidtexture = "Eltreum-Class-Druid",
		huntertexture = "Eltreum-Class-Hunter",
		magetexture = "Eltreum-Class-Mage",
		monktexture = "Eltreum-Class-Monk",
		paladintexture = "Eltreum-Class-Paladin",
		priesttexture = "Eltreum-Class-Priest",
		roguetexture = "Eltreum-Class-Rogue",
		shamantexture = "Eltreum-Class-Shaman",
		warlocktexture = "Eltreum-Class-Warlock",
		warriortexture = "Eltreum-Class-Warrior",
	},

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

	blizzframes = {
		errorframe = true,
		errorframefontsize = 14,
		hideerrorframe = false,
		raidbossframe = true,
		raidbossframefontsize = 14,
	},

	otherstuff ={
		worldtextscale = 1,
		arenabuffs = false,
		bgunitframes = false,
		arenaunitframes = false,
		fastloot = false,
		fastlootfilter = false,
		fastlootquality = '0',
		lootwishlistwarning = false,
		lootwishlistfilter = false,
		lootwishlistscreenshot = false,
		lootautoclose = true,
		screenshot = false,
		hidetalkinghead = false,
		blizzcombattext = false,
		blizzcombatmana = false,
		mapcombathide = false,
		dynamicxpbar = false,
		delete = false,
		playerdeath = false,
		playerdeathgta = false,
		leadersize = 12,
		mpluskeys = false,
		--floatingrep = false,
	},

	instances = {
		enable = false,
		fontsize = 12,
		r = 0.90,
		g = 0.72,
		b = 0,
		DungeonNormal = "N.Dungeon",
		DungeonHeroic = "H.Dungeon",
		Raid = "Raid",
		MythicRaid = "Mythic.Raid",
		RaidHeroic = "Heroic.Raid",
		RaidLFR = "LFR",
		DungeonMythic = "Mythic 0",
		DungeonMythicPlus = "Mythic+",
		DungeonTimewalker = "TW.Dungeon",
		RaidTimewalker = "TW.Raid",
		guild = "Guild",
	}
}
