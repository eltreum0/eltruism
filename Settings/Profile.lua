local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))


-- Eltreum UI Profile DB
P.ElvUI_EltreumUI = {

	nameplatepower = {
		autoadjustposition = true,
		sizex = 132,
		sizey = 6,
		posy = 16,
		texture = "Eltreum-Elvui-Norm",
	},

	chat = {
		enable = true,
		leftmouseover = true,
		rightmouseover = true,
		leftfader = true,
		rightfader = true,
		leftcombathide = true,
		rightcombathide = false,
		invertclick = false,
	},

	skins = {
		enable = true,
		widertransmog = true,
		expandedstable = true,
	},

	tbctalents = {
		enable = true,
	},

	dynamicdatatext = {
		enable = true,
	},

	nameplatelevel = {
		enable = true,
	},

	changelog = {
		version = "2.0.0",
	},

	cursor = {
		enable = true,
		ring = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga',
		size = '-1',
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
		ClassColorGlow = true,
		ClassBorderNameplate = true,
		nameplatetexture = true,
	},

	stealthOptions = {
		stealtheffect = true,
	},

	glow = {
		enable = true,
		blizzard = false,
		pixel = true,
		autocast = false,
		colorclass = true,
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

	partyraiddeath = {
		enable = true,
		bruh = true,
		robloxoof = false,
		shame = false,
		wow = false,
		mario = false,
		ion = false,
		--playerdeathsound = "None",
		--customenable = false,
	},

	friendlynameplatetoggle = {
		disablefriendly = false,
		friendlynames = true,
		hidefriendly = false,
	},

	afkmusic = {
		enable = true,
		racial = true,
		playerclass = false,
	},

	fonts = {
		playerfont = "Kimberley"
	},

	waypointetasetting = {
		enable = true,
	},

	waytext = {
		enable = true,
	},

	widenameplate = {
		enable = true,
	},

	questsettings = {
		enable = true,
		rogueopen = true,
	},

	loottext = {
		enable = true,
		honor = true,
		currency = true,
		pet = true,
		scale = 0.65,
		strata = "BACKGROUND",
		xOffset = 0,
		yOffset = 200,
		fontsetting = true,
	},

	otherstuff ={
		worldtextscale = 1,
		--floatingrep = false,
	},

	borders = {
		borders = false,
		texture = "RenaitreBeveled10x",

		playertargetsize = 20,

		playerborder = false,
		xplayer = 285,
		yplayer = 55,

		playercastborder = true,
		xplayercast = 250,
		yplayercast = 40,

		targetborder = false,
		xtarget = 285,
		ytarget = 55,

		targetcastborder = true,
		xcasttarget = 150,
		ycasttarget = 20,

		bar1borders = true,
		bar1xborder = 52,
		bar1yborder = 44,

		bar2borders = true,
		bar2xborder = 42,
		bar2yborder = 37,

		bar3borders = true,
		bar3xborder = 42,
		bar3yborder = 37,

		bar4borders = true,
		bar4xborder = 42,
		bar4yborder = 37,

		bar5borders = true,
		bar5xborder = 42,
		bar5yborder = 37,

		bar6borders = true,
		bar6xborder = 40,
		bar6yborder = 32,

		bar7borders = true,
		bar7xborder = 42,
		bar7yborder = 37,

		bar8borders = true,
		bar8xborder = 42,
		bar8yborder = 37,

		bar9borders = true,
		bar9xborder = 42,
		bar9yborder = 37,

		bar10borders = true,
		bar10xborder = 42,
		bar10yborder = 37,

		baredgesize = 15,
	},

}
