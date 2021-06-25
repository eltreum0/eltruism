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
		texture = "better-blizzard-border-small-alternate",

		playertargetsize = 20,

		playerborder = true,
		xplayer = 200,
		yplayer = 50,

		playercastborder = true,
		xplayercast = 200,
		yplayercast = 50,

		targetborder = true,
		xtarget = 200,
		ytarget = 50,

		targetcastborder = true,
		xcasttarget = 150,
		ycasttarget = 20,

		bar1borders = true,
		bar1xborder = 65,
		bar1yborder = 56,

		bar2borders = true,
		bar2xborder = 54,
		bar2yborder = 47,

		bar3borders = true,
		bar3xborder = 54,
		bar3yborder = 47,

		bar4borders = true,
		bar4xborder = 54,
		bar4yborder = 47,

		bar5borders = true,
		bar5xborder = 54,
		bar5yborder = 47,

		bar6borders = true,
		bar6xborder = 54,
		bar6yborder = 47,

		bar7borders = true,
		bar7xborder = 54,
		bar7yborder = 47,

		bar8borders = true,
		bar8xborder = 54,
		bar8yborder = 47,

		bar9borders = true,
		bar9xborder = 54,
		bar9yborder = 47,

		bar10borders = true,
		bar10xborder = 54,
		bar10yborder = 47,

		baredgesize = 13,
	},

}
