local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local tostring = _G.tostring
local select = _G.select
local CreateFrame = _G.CreateFrame

--set the variables
local classtable = {
	["PALADIN"] = {r = "0.95686066150665", g = "0.54901838302612", b = "0.72941017150879"},
	["WARRIOR"] = {r = "0.77646887302399", g = "0.60784178972244", b = "0.4274500310421"},
	["SHAMAN"] = {r = "0", g = "0.4392147064209", b = "0.86666476726532"},
	["DRUID"] = {r = "0.99999779462814", g = "0.48627343773842", b = "0.039215601980686"},
	["DEATHKNIGHT"] = {r = "0.76862573623657", g = "0.11764679849148", b = "0.2274504750967"},
	["DEMONHUNTER"] = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"},
	["MONK"] = {r = "0", g = "0.99999779462814", b = "0.59607714414597"},
	["ROGUE"] = {r = "0.99999779462814", g = "0.95686066150665", b = "0.40784224867821"},
	["PRIEST"] = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"},
	["MAGE"] = {r = "0.24705828726292", g = "0.78039044141769", b = "0.92156660556793"},
	["HUNTER"] = {r = "0.66666519641876", g = "0.82744914293289", b = "0.44705784320831"},
	["WARLOCK"] = {r = "0.52941060066223", g = "0.53333216905594", b = "0.93333131074905"},
	["NPCFRIENDLY"] = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"},
	["NPCNEUTRAL"] = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"},
	["NPCUNFRIENDLY"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
	["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
	--["GOODTHREAT"] = {r = "0.1999995559454", g = "0.7098023891449", b = "0"},
	--["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
	--["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
	--["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
	--["OFFTANK"] = {r = "0.95686066150665", g1 = "0.54901838302612", b = "0.72941017150879"},
	--bar colors for party/raid/raid40
	--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
	--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
}
local unitframegradients = {
	["WARRIOR"] = {r1 = 0.42745098039216, g1 = 0.13725490196078, b1 = 0.090196078431373, r2 = 0.56470588235294, g2 = 0.43137254901961, b2 = 0.24705882352941},
	["PALADIN"] = {r1 = 1, g1 = 0.26666666666667, b1 = 0.53725490196078, r2 = 0.95686274509804, g2 = 0.54901960784314, b2 = 0.72941176470588},
	["HUNTER"] = {r1 = 0.28235294117647, g1 = 0.59607843137255, b1 = 0.29411764705882, r2 = 0.78823529411765, g2 = 1, b2 = 0.38823529411765},
	["ROGUE"] = {r1 = 1, g1 = 0.68627450980392, b1 = 0, r2 = 1, g2 = 0.83137254901961, b2 = 0.25490196078431},
	["PRIEST"] = {r1 = 0.3568627450980392, g1 = 0.3568627450980392, b1 = 0.3568627450980392, r2 = 0.98823529411765, g2 = 0.98823529411765, b2 = 0.98823529411765},
	["DEATHKNIGHT"] = {r1 = 0.49803921568627, g1 = 0.074509803921569, b1 = 0.14901960784314, r2 = 1, g2 = 0.1843137254902, b2 = 0.23921568627451},
	["SHAMAN"] = {r1 = 0, g1 = 0.25882352941176, b1 = 0.50980392156863, r2 = 0.3921568627451, g2 = 0.44313725490196, b2 = 1},
	["MAGE"] = {r1 = 0, g1 = 0.33333333333333, b1 = 0.53725490196078, r2 = 0.49019607843137, g2 = 0.87058823529412, b2 = 1},
	["WARLOCK"] = {r1 = 0.26274509803922, g1 = 0.26666666666667, b1 = 0.46666666666667, r2 = 0.66274509803922, g2= 0.3921568627451, b2 = 0.7843137254902},
	["MONK"] = {r1 = 0, g1 = 0.77254901960784, b1 = 0.45882352941176, r2 = 0.42352941176471, g2 = 0.90980392156863, b2 = 1},
	["DRUID"] = {r1 = 1, g1 = 0.23921568627451, b1 = 0.007843137254902, r2 = 1, g2 = 0.48627450980392, b2 = 0.03921568627451},
	["DEMONHUNTER"] = {r1 = 0.36470588235294, g1 = 0.13725490196078, b1 = 0.57254901960784, r2 = 0.74509803921569, g2 = 0.1921568627451, b2 = 1},
	["NPCFRIENDLY"] = {r1 = 0.30980392156863, g1 = 0.85098039215686, b1 = 0.2, r2 = 0.34117647058824, g2 = 0.62745098039216, b2 = 0.4078431372549},
	--["NPCNEUTRAL"] = {r1 = 0.712358744169101, g1 = 0.63137254901961, b1 = 0.15490196078431, r2 = 1, g2 = 0.85686274509804, b2 = 0.2078431372549},
	["NPCNEUTRAL"] = {r1 = 0.8156862745098, g1 = 1, b1 = 0, r2 = 1, g2 = 0.85882352941176, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	--["NPCHOSTILE"] = {r1 = 0.31764705882353, g1 = 0.066666666666667, b1 = 0.07843137254902, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
	["NPCHOSTILE"] = {r1 = 1, g1 = 0.090196078431373, b1 = 0, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
	-- ["GOODTHREAT"] = {r1 = 0.27843075990677, g1 = 0.99999779462814, b1 = 0, r2 = 1, g2 = 0, b2 = 0}, ????
	--["GOODTHREAT"] = {r1 = 0.1999995559454, g1 = 0.7098023891449, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	--["BADTHREAT"] = {r1 = 0.99999779462814, g1 = 0.1764702051878, b1 = 0.1764702051878, r2 = 1, g2 = 0, b2 = 0},
	--["GOODTHREATTRANSITION"] = {r1 = 0.99999779462814, g1 = 0.85097849369049, b1 = 0.1999995559454, r2 = 1, g2 = 0, b2 = 0},
	--["BADTHREATTRANSITION"] = {r1 = 0.99999779462814, g1 = 0.50980281829834, b1 = 0.1999995559454, r2 = 1, g2 = 0, b2 = 0},
	--["OFFTANK"] = {r1 = 0.95686066150665, g1 = 0.54901838302612, b1 = 0.72941017150879, r2 = 1, g2 = 0, b2 = 0},
	--["OFFTANKBADTHREATTRANSITION"] = {r1 = 0.77646887302399, g1 = 0.60784178972244, b1 = 0.4274500310421, r2 = 1, g2 = 0, b2 = 0},
	--0.1999995559454 0.7098023891449 0
	--0.95686066150665 0.54901838302612 0.72941017150879
}
local unitframecustomgradients = {
	["WARRIOR"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["PALADIN"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["HUNTER"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["ROGUE"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["PRIEST"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["DEATHKNIGHT"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["SHAMAN"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["MAGE"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["WARLOCK"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["MONK"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["DRUID"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["DEMONHUNTER"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["NPCFRIENDLY"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["NPCNEUTRAL"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["NPCUNFRIENDLY"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["NPCHOSTILE"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	--["GOODTHREAT"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	--["BADTHREAT"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	--["GOODTHREATTRANSITION"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	--["BADTHREATTRANSITION"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	--["OFFTANK"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
}
local unitframeclass = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga",
	["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga",
	["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga",
	["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga",
	["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga",
}
local unitframeclasscustom = {
	["WARRIOR"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture)),
	["PALADIN"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture)),
	["HUNTER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture)),
	["ROGUE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture)),
	["PRIEST"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture)),
	["DEATHKNIGHT"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture)),
	["SHAMAN"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture)),
	["MAGE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture)),
	["WARLOCK"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture)),
	["MONK"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture)),
	["DRUID"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture)),
	["DEMONHUNTER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture)),
	["NPCFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcfriendly)),
	["NPCNEUTRAL"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcneutral)),
	["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly)),
	["NPCHOSTILE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npchostile)),
}
function ElvUI_EltreumUI:GradientColorTableUpdate()
	unitframeclasscustom = {
		["WARRIOR"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture)),
		["PALADIN"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture)),
		["HUNTER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture)),
		["ROGUE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture)),
		["PRIEST"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture)),
		["DEATHKNIGHT"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture)),
		["SHAMAN"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture)),
		["MAGE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture)),
		["WARLOCK"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture)),
		["MONK"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture)),
		["DRUID"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture)),
		["DEMONHUNTER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture)),
		["NPCFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcfriendly)),
		["NPCNEUTRAL"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcneutral)),
		["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly)),
		["NPCHOSTILE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npchostile)),
	}

	if E.Wrath or E.TBC or E.Classic then
		classtable = {
			["PALADIN"] = {r = "0.96078222990036", g = "0.54901838302612", b = "0.72941017150879"},
			["WARRIOR"] = {r = "0.78039044141769", g = "0.61176335811615", b = "0.43137159943581"},
			["SHAMAN"] = {r = "0", g = "0.4392147064209", b = "0.87058633565903"},
			["DRUID"] = {r = "0.99999779462814", g = "0.49019500613213", b = "0.039215601980686"},
			["DEATHKNIGHT"] = {r = "0.76862573623657", g = "0.1215683594346", b = "0.23137204349041"},
			["DEMONHUNTER"] = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"},
			["MONK"] = {r = "0", g = "0.99999779462814", b = "0.59607714414597"},
			["ROGUE"] = {r = "0.99999779462814", g = "0.96078222990036", b = "0.41176378726959"},
			["PRIEST"] = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"},
			["MAGE"] = {r = "0.25097984075546", g = "0.78039044141769", b = "0.92156660556793"},
			["HUNTER"] = {r = "0.67058676481247", g = "0.8313707113266", b = "0.45097941160202"},
			["WARLOCK"] = {r = "0.52941060066223", g = "0.52941060066223", b = "0.92940974235535"},
			["NPCFRIENDLY"] = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"},
			["NPCNEUTRAL"] = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"},
			["NPCUNFRIENDLY"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
			["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
			--["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
			--["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
			--["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
			--["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
			--bar colors for party/raid/raid40
			--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
			--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
		}
	end
	unitframecustomgradients = {
		["WARRIOR"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB2},
		["PALADIN"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB2},
		["HUNTER"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB2},
		["ROGUE"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB2},
		["PRIEST"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB2},
		["DEATHKNIGHT"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB2},
		["SHAMAN"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB2},
		["MAGE"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB2},
		["WARLOCK"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB2},
		["MONK"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorB2},
		["DRUID"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB2},
		["DEMONHUNTER"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorB2},
		["NPCFRIENDLY"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.npcfriendlyB2},
		["NPCNEUTRAL"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.npcneutralR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.npcneutralG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.npcneutralB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.npcneutralR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.npcneutralG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.npcneutralB2},
		["NPCUNFRIENDLY"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.npcunfriendlyB2},
		["NPCHOSTILE"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.npchostileR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.npchostileG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.npchostileB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.npchostileR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.npchostileG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.npchostileB2},
		--["GOODTHREAT"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatB2},
		--["BADTHREAT"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.badthreatR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.badthreatG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.badthreatB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.badthreatR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.badthreatG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.badthreatB2},
		--["GOODTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionB2},
		--["BADTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionB2},
		--["OFFTANK"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.offtankR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.offtankG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.offtankB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.offtankR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.offtankG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.offtankB2},
	}
	if E.db.ElvUI_EltreumUI.darkmode then
		if E.Retail then
			classtable = {
				["PALADIN"] = {r = "0.71764546632767", g = "0.41176378726959", b = "0.54509681463242"},
				["WARRIOR"] = {r = "0.58039087057114", g = "0.45490095019341", b = "0.32156792283058"},
				["SHAMAN"] = {r = "0", g = "0.32941102981567", b = "0.65097898244858"},
				["DRUID"] = {r = "0.74901795387268", g = "0.36470508575439", b = "0.027450919151306"},
				["DEATHKNIGHT"] = {r = "0.57646930217743", g = "0.086274318397045", b = "0.16862708330154"},
				["DEMONHUNTER"] = {r = "0.47843033075333", g = "0.14117616415024", b = "0.59215557575226"},
				["MONK"] = {r = "0", g = "0.74901795387268", b = "0.44705784320831"},
				["ROGUE"] = {r = "0.74901795387268", g = "0.71764546632767", b = "0.30588167905807"},
				["PRIEST"] = {r = "0.74901795387268", g = "0.74901795387268", b = "0.74901795387268"},
				["MAGE"] = {r = "0.18431332707405", g = "0.58431243896484", b = "0.69019454717636"},
				["HUNTER"] = {r = "0.49803811311722", g = "0.61960649490356", b = "0.33333259820938"},
				["WARLOCK"] = {r = "0.39607757329941", g = "0.39999911189079", b = "0.69803768396378"},
				["NPCFRIENDLY"] = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"},
				["NPCNEUTRAL"] = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"},
				["NPCUNFRIENDLY"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
				["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
				--["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
				--["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
				--["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
				--["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
				--bar colors for party/raid/raid40
				--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
				--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
			}
		elseif E.Wrath or E.TBC or E.Classic then
			classtable = {
				["PALADIN"] = {r = "0.72156703472137", g = "0.41176378726959", b = "0.54901838302612"},
				["WARRIOR"] = {r = "0.58431243896484", g = "0.45882251858711", b = "0.32156792283058"},
				["SHAMAN"] = {r = "0", g = "0.32941102981567", b = "0.65097898244858"},
				["DRUID"] = {r = "0.74901795387268", g = "0.3686266541481", b = "0.031372480094433"},
				["DEATHKNIGHT"] = {r = "0.57646930217743", g = "0.090195879340172", b = "0.17254863679409"},
				["DEMONHUNTER"] = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"},
				["MONK"] = {r = "0", g = "0.99999779462814", b = "0.59607714414597"},
				["ROGUE"] = {r = "0.74901795387268", g = "0.72156703472137", b = "0.30588167905807"},
				["PRIEST"] = {r = "0.74901795387268", g = "0.74901795387268", b = "0.74901795387268"},
				["MAGE"] = {r = "0.1882348805666", g = "0.58431243896484", b = "0.69019454717636"},
				["HUNTER"] = {r = "0.50195968151093", g = "0.62352806329727", b = "0.33725416660309"},
				["WARLOCK"] = {r = "0.39607757329941", g = "0.39607757329941", b = "0.69803768396378"},
				["NPCFRIENDLY"] = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"},
				["NPCNEUTRAL"] = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"},
				["NPCUNFRIENDLY"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
				["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
				--["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
				--["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
				--["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
				--["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
				--bar colors for party/raid/raid40
				--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
				--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
			}
		end
	end
	if E.db.ElvUI_EltreumUI.uftextureversion == "V2" then
		unitframeclass = {
			["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WAv2.tga",
			["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PLv2.tga",
			["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HTv2.tga",
			["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DRv2.tga",
			["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PRv2.tga",
			["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PLv2.tga",
			["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SHv2.tga",
			["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SHv2.tga",
			["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WLv2.tga",
			["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MKv2.tga",
			["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DKv2.tga",
			["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DHv2.tga",
			["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HTv2.tga",
			["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RGv2.tga",
			["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DRv2.tga",
			["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DKv2.tga",
		}
	elseif E.db.ElvUI_EltreumUI.uftextureversion == "V3" then
		unitframeclass = {
			["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WAv3.tga",
			["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PLv3.tga",
			["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HTv3.tga",
			["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DRv3.tga",
			["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PRv3.tga",
			["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PLv3.tga",
			["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SHv3.tga",
			["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SHv3.tga",
			["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WLv3.tga",
			["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MKv3.tga",
			["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DKv3.tga",
			["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DHv3.tga",
			["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HTv3.tga",
			["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RGv3.tga",
			["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DRv3.tga",
			["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DKv3.tga",
		}
	end
end
local colorupdateframe = CreateFrame("FRAME")
colorupdateframe:RegisterEvent("PLAYER_ENTERING_WORLD")
colorupdateframe:RegisterEvent("PLAYER_STARTED_MOVING")
colorupdateframe:SetScript("OnEvent", function()
	colorupdateframe:UnregisterAllEvents()
	ElvUI_EltreumUI:GradientColorTableUpdate()
end)

--get the texture
function ElvUI_EltreumUI:UnitframeClassTexture(unitclass)
	return unitframeclass[unitclass]
end

--get the custom texture
function ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass)
	return unitframeclasscustom[unitclass]
end

--get the colors for class detection
function ElvUI_EltreumUI:UnitframeClassColor(unitclass)
	return classtable[unitclass].r, classtable[unitclass].g, classtable[unitclass].b
end

--get the gradient colors
function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha)
	if invert then
		if alpha then
			return unitframegradients[unitclass].r2, unitframegradients[unitclass].g2, unitframegradients[unitclass].b2, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[unitclass].r1, unitframegradients[unitclass].g1, unitframegradients[unitclass].b1, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha
		else
			return unitframegradients[unitclass].r2, unitframegradients[unitclass].g2, unitframegradients[unitclass].b2, unitframegradients[unitclass].r1, unitframegradients[unitclass].g1, unitframegradients[unitclass].b1
		end
	else
		if alpha then
			return unitframegradients[unitclass].r1, unitframegradients[unitclass].g1, unitframegradients[unitclass].b1, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[unitclass].r2, unitframegradients[unitclass].g2, unitframegradients[unitclass].b2, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha
		else
			return unitframegradients[unitclass].r1, unitframegradients[unitclass].g1, unitframegradients[unitclass].b1, unitframegradients[unitclass].r2, unitframegradients[unitclass].g2, unitframegradients[unitclass].b2
		end
	end
end

--get the custom gradient colors
function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha)
	if invert then
		if alpha then
			return unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha
		else
			return unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2, unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1
		end
	else
		if alpha then
			return unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha
		else
			return unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2
		end
	end
end

--set the textures or gradients
function ElvUI_EltreumUI:GradientCustomTexture(unit)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then

		--player
		local playertexture = ElvUI_EltreumUI:UnitframeClassTexture(E.myclass)
		if UF.units.player then
			local unitframe = _G["ElvUF_Player"]
			if unitframe and unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						playertexture = ElvUI_EltreumUI:UnitframeClassTextureCustom(E.myclass)
					else
						playertexture = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.playertexture)
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableplayer then
					if E.db.ElvUI_EltreumUI.lightmode then
						unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
						else
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, true))
						else
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, true))
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						unitframe.Health:SetStatusBarTexture(playertexture)
					end
				end
			end
		end

		--target
		local targetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		local _, targetclass = UnitClass("target")
		local reactiontarget = UnitReaction("target", "player")
		if UnitExists("target") then
			if UnitIsPlayer("target") then
				if targetclass then
					targetbar = ElvUI_EltreumUI:UnitframeClassTexture(targetclass)
				end
			elseif not UnitIsPlayer("target") then
				if reactiontarget >= 5 then
					targetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
				elseif reactiontarget == 4 then
					targetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
				elseif reactiontarget == 3 then
					targetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
				elseif reactiontarget == 2 or reactiontarget == 1 then
					targetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
				end
			end
		end
		if UF.units.target and UnitExists("target") then
			local targetunitframe = _G["ElvUF_Target"]
			if targetunitframe and targetunitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if UnitIsPlayer("target") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							targetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom(targetclass)
						else
							targetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettexture)
						end
					elseif not UnitIsPlayer("target") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							if reactiontarget >= 5 then
								targetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY")
							elseif reactiontarget == 4 then
								targetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL")
							elseif reactiontarget == 3 then
								targetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY")
							elseif reactiontarget == 2 or reactiontarget == 1 then
								targetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE")
							end
						else
							targetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettexture)
						end
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("target") and E.db.ElvUI_EltreumUI.gradientmode.enabletarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true))
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true))
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true, true))
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true, true))
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, false, true))
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("target")) and E.db.ElvUI_EltreumUI.gradientmode.enabletarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(targetbar)
					end
				end
			end
		end

		--target of target
		local _, targettargetclass = UnitClass("targettarget")
		local reactiontargettarget = UnitReaction("targettarget", "player")
		local targettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if UnitExists("targettarget") then
			if UnitIsPlayer("targettarget") then
				if targettargetclass then
					targettargetbar = ElvUI_EltreumUI:UnitframeClassTexture(targettargetclass)
				end
			elseif not UnitIsPlayer("targettarget") then
				if reactiontargettarget >= 5 then
					targettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
				elseif reactiontargettarget == 4 then
					targettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
				elseif reactiontargettarget == 3 then
					targettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
				elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
					targettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
				end
			end
		end
		if UF.units.targettarget and UnitExists("targettarget") then
			local targettargetunitframe = _G["ElvUF_TargetTarget"]
			if targettargetunitframe and targettargetunitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if UnitIsPlayer("targettarget") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							targettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom(targettargetclass)
						else
							targettargetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettexture)
						end
					elseif not UnitIsPlayer("targettarget") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							if reactiontargettarget >= 5 then
								targettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY")
							elseif reactiontargettarget == 4 then
								targettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL")
							elseif reactiontargettarget == 3 then
								targettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY")
							elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
								targettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE")
							end
						else
							targettargetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettexture)
						end
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("targettarget") and E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargetclass))
						else
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargetclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargetclass, false, true))
						else
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargetclass, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("targettarget")) and E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAl", true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAl"))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(targettargetbar)
					end
				end
			end
		end

		--target of target of target
		local _, targettargettargetclass = UnitClass("targettargettarget")
		local reactiontargettargettarget = UnitReaction("targettargettarget", "player")
		local targettargettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if UnitExists("targettargettarget") then
			if UnitIsPlayer("targettargettarget") then
				if targettargettargetclass then
					targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTexture(targettargettargetclass)
				end
			elseif not UnitIsPlayer("targettargettarget") then
				if reactiontargettargettarget >= 5 then
					targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
				elseif reactiontargettargettarget == 4 then
					targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
				elseif reactiontargettargettarget == 3 then
					targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
				elseif reactiontargettargettarget == 2 or reactiontargettargettarget == 1 then
					targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
				end
			end
		end
		if UF.units.targettargettarget and UnitExists("targettargettarget") then
			local targettargettargetunitframe = _G["ElvUF_TargetTargetTarget"]
			if targettargettargetunitframe and targettargettargetunitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if UnitIsPlayer("targettargettarget") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom(targettargettargetclass)
						else
							targettargettargetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettargettexture)
						end
					elseif not UnitIsPlayer("targettargettarget") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							if reactiontargettargettarget >= 5 then
								targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY")
							elseif reactiontargettargettarget == 4 then
								targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL")
							elseif reactiontargettargettarget == 3 then
								targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY")
							elseif reactiontargettargettarget == 2 or reactiontargettargettarget == 1 then
								targettargettargetbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE")
							end
						else
							targettargettargetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettargettexture)
						end
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("targettargettarget") and E.db.ElvUI_EltreumUI.gradientmode.enabletargettargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargettargetclass))
						else
							targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors(targettargettargetclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargettargetclass, false, true))
						else
							targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargettargetclass, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("targettargettarget")) and E.db.ElvUI_EltreumUI.gradientmode.enabletargettargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))--unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"])
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))--unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))--unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"])
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAl", true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargettargetunitframe.Health:SetStatusBarTexture(targettargettargetbar)
					end
				end
			end
		end

		--focus
		local _, focusclass = UnitClass("focus")
		local reactionfocus = UnitReaction("focus", "player")
		local focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if focusclass and UnitIsPlayer("focus") then
			focusbar = ElvUI_EltreumUI:UnitframeClassTexture(focusclass)
		elseif not UnitIsPlayer("focus") and UnitExists("focus") then
			if reactionfocus >= 5 then
				focusbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
			elseif reactionfocus == 4 then
				focusbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
			elseif reactionfocus == 3 then
				focusbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
			elseif reactionfocus == 2 or reactionfocus == 1 then
				focusbar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
			end
		end
		if UF.units.focus and UnitExists("focus") then
			local focusframe = _G["ElvUF_Focus"]
			if focusframe and focusframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if UnitIsPlayer("focus") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							focusbar = ElvUI_EltreumUI:UnitframeClassTextureCustom(focusclass)
						else
							focusbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture)
						end
					elseif not UnitIsPlayer("focus") then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
							if reactionfocus >= 5 then
								focusbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY")
							elseif reactionfocus == 4 then
								focusbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL")
							elseif reactionfocus == 3 then
								focusbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY")
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusbar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE")
							end
						else
							focusbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture)
						end
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("focus") and E.db.ElvUI_EltreumUI.gradientmode.enablefocus then
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass))
						else
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, false, true))
						else
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("focus")) and E.db.ElvUI_EltreumUI.gradientmode.enablefocus then
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(focusbar)
					end
				end
			end
		end

		--pet
		--local petbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga"
		local petbar = ElvUI_EltreumUI:UnitframeClassTexture("HUNTER")
		if UF.units.pet then
			local petframe = _G["ElvUF_Pet"]
			if petframe and petframe.Health then
				if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableplayer then
					if E.db.ElvUI_EltreumUI.lightmode then
						petframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
						else
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						petframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
						else
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						petframe.Health:SetStatusBarTexture(petbar)
					end
				end
			end
		end

		--arena1
		local arena1bar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		local _, arena1class = UnitClass("arena1")
		if UnitExists("arena1") then
			if arena1class then
				arena1bar = ElvUI_EltreumUI:UnitframeClassTexture(arena1class)
			end
			local arena1unitframe = _G["ElvUF_Arena1"]
			if arena1unitframe and arena1unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						arena1bar = ElvUI_EltreumUI:UnitframeClassTextureCustom(arena1class)
					else
						arena1bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena1texture)
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena1") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena1unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, true))
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, true))
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena1unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, true, true))
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, true, true))
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, false, true))
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						arena1unitframe.Health:SetStatusBarTexture(arena1bar)
					end
				end
			end
		end

		--arena2
		local arena2bar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		local _, arena2class = UnitClass("arena2")
		if UnitExists("arena2") then
			if arena2class then
				arena2bar = ElvUI_EltreumUI:UnitframeClassTexture(arena2class)
			end
			local arena2unitframe = _G["ElvUF_Arena2"]
			if arena2unitframe and arena2unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						arena2bar = ElvUI_EltreumUI:UnitframeClassTextureCustom(arena2class)
					else
						arena2bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena2texture)
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena2") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena2unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, true))
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, true))
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena2unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, true, true))
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, true, true))
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, false, true))
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						arena2unitframe.Health:SetStatusBarTexture(arena2bar)
					end
				end
			end
		end

		--arena3
		local arena3bar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		local _, arena3class = UnitClass("arena3")
		if UnitExists("arena3") then
			if arena3class then
				arena3bar = ElvUI_EltreumUI:UnitframeClassTexture(arena3class)
			end
			local arena3unitframe = _G["ElvUF_Arena3"]
			if arena3unitframe and arena3unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						arena3bar = ElvUI_EltreumUI:UnitframeClassTextureCustom(arena3class)
					else
						arena3bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena3texture)
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena3") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena3unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, true))
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, true))
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena3unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, true, true))
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, true, true))
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, false, true))
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						arena3unitframe.Health:SetStatusBarTexture(arena3bar)
					end
				end
			end
		end

		--arena4
		local arena4bar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		local _, arena4class = UnitClass("arena4")
		if UnitExists("arena4") then
			if arena4class then
				arena4bar = ElvUI_EltreumUI:UnitframeClassTexture(arena4class)
			end
			local arena4unitframe = _G["ElvUF_Arena4"]
			if arena4unitframe and arena4unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						arena4bar = ElvUI_EltreumUI:UnitframeClassTextureCustom(arena4class)
					else
						arena4bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena4texture)
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena4") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena4unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class, true))
							else
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class, true))
							else
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena4unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class, true, true))
							else
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class, true, true))
							else
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class, false, true))
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						arena4unitframe.Health:SetStatusBarTexture(arena4bar)
					end
				end
			end
		end

		--arena5
		local arena5bar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		local _, arena5class = UnitClass("arena5")
		if UnitExists("arena5") then
			if arena5class then
				arena5bar = ElvUI_EltreumUI:UnitframeClassTexture(arena5class)
			end
			local arena5unitframe = _G["ElvUF_Arena5"]
			if arena5unitframe and arena5unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						arena5bar = ElvUI_EltreumUI:UnitframeClassTextureCustom(arena5class)
					else
						arena5bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena5texture)
					end
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena5") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena5unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class, true))
							else
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class, true))
							else
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena5unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class, true, true))
							else
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class, true, true))
							else
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class, false, true))
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.lightmode then
						arena5unitframe.Health:SetStatusBarTexture(arena5bar)
					end
				end
			end
		end

		if E.Retail then
			--boss1
			--local bossbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga"
			local bossbar = ElvUI_EltreumUI:UnitframeClassTexture("DEATHKNIGHT")
			local bossframe1 = _G["ElvUF_Boss1"]
			local reactionboss1 = UnitReaction("boss1", "player")
			if bossframe1 and reactionboss1 ~= nil then
				if bossframe1 and bossframe1.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe1.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss1 >= 5 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss1 == 4 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss1 == 3 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss1 >= 5 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss1 == 4 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss1 == 3 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe1.Health.backdropTex then
							bossframe1.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss1 >= 5 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss1 == 4 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss1 == 3 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss1 >= 5 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss1 == 4 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss1 == 3 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe1.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss2
			local bossframe2 = _G["ElvUF_Boss2"]
			local reactionboss2 = UnitReaction("boss2", "player")
			if bossframe2 and reactionboss2 ~= nil then
				if bossframe2 and bossframe2.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe2.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss2 >= 5 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss2 == 4 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss2 == 3 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss2 >= 5 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss2 == 4 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss2 == 3 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe2.Health.backdropTex then
							bossframe2.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss2 >= 5 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss2 == 4 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss2 == 3 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss2 >= 5 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss2 == 4 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss2 == 3 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe2.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss3
			local bossframe3 = _G["ElvUF_Boss3"]
			local reactionboss3 = UnitReaction("boss3", "player")
			if bossframe3 and reactionboss3 ~= nil then
				if bossframe3 and bossframe3.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe3.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss3 >= 5 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss3 == 4 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss3 == 3 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss3 >= 5 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss3 == 4 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss3 == 3 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe3.Health.backdropTex then
							bossframe3.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss3 >= 5 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss3 == 4 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss3 == 3 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss3 >= 5 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss3 == 4 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss3 == 3 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe3.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss4
			local bossframe4 = _G["ElvUF_Boss4"]
			local reactionboss4 = UnitReaction("boss4", "player")
			if bossframe4 and reactionboss4 ~= nil then
				if bossframe4 and bossframe4.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe4.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss4 >= 5 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss4 == 4 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss4 == 3 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss4 >= 5 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss4 == 4 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss4 == 3 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe4.Health.backdropTex then
							bossframe4.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss4 >= 5 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss4 == 4 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss4 == 3 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss4 >= 5 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss4 == 4 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss4 == 3 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe4.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss5
			local bossframe5 = _G["ElvUF_Boss5"]
			local reactionboss5 = UnitReaction("boss5", "player")
			if bossframe5 and reactionboss5 ~= nil then
				if bossframe5 and bossframe5.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe5.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss5 >= 5 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss5 == 4 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss5 == 3 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss5 >= 5 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss5 == 4 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss5 == 3 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe5.Health.backdropTex then
							bossframe5.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss5 >= 5 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss5 == 4 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss5 == 3 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss5 >= 5 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss5 == 4 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss5 == 3 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe5.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss6
			local bossframe6 = _G["ElvUF_Boss6"]
			local reactionboss6 = UnitReaction("boss6", "player")
			if bossframe6 and reactionboss6 ~= nil then
				if bossframe6 and bossframe6.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe6.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss6 >= 5 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss6 == 4 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss6 == 3 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss6 >= 5 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss6 == 4 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss6 == 3 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe6.Health.backdropTex then
							bossframe6.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss6 >= 5 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss6 == 4 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss6 == 3 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss6 >= 5 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss6 == 4 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss6 == 3 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe6.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss7
			local bossframe7 = _G["ElvUF_Boss7"]
			local reactionboss7 = UnitReaction("boss7", "player")
			if bossframe7 and reactionboss7 ~= nil then
				if bossframe7 and bossframe7.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe7.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss7 >= 5 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss7 == 4 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss7 == 3 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss7 >= 5 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss7 == 4 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss7 == 3 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe7.Health.backdropTex then
							bossframe7.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss7 >= 5 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss7 == 4 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss7 == 3 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss7 >= 5 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss7 == 4 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss7 == 3 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe7.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end

			--boss8
			local bossframe8 = _G["ElvUF_Boss8"]
			local reactionboss8 = UnitReaction("boss8", "player")
			if bossframe8 and reactionboss8 ~= nil then
				if bossframe8 and bossframe8.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe8.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss8 >= 5 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss8 == 4 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss8 == 3 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss8 >= 5 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss8 == 4 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss8 == 3 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe8.Health.backdropTex then
							bossframe8.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss8 >= 5 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss8 == 4 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss8 == 3 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss8 >= 5 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss8 == 4 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss8 == 3 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe8.Health:SetStatusBarTexture(bossbar)
						end
					end
				end
			end
		end

		--group/raid unitframes
		if UnitExists(unit) and (E.db.ElvUI_EltreumUI.lightmode or E.db.ElvUI_EltreumUI.darkmode) then

			local headergroup = nil
			if _G["ElvUF_Raid"] and _G["ElvUF_Raid"]:IsShown() then
				headergroup = _G["ElvUF_Raid"]
			elseif _G["ElvUF_Raid40"] and _G["ElvUF_Raid40"]:IsShown() then
				headergroup = _G["ElvUF_Raid40"]
			elseif _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsShown() then
				headergroup = _G["ElvUF_Party"]
			end

			local headertank = nil
			if _G["ElvUF_Tank"] and _G["ElvUF_Tank"]:IsShown() then
				headertank = _G["ElvUF_Tank"]
			end

			local headerassist = nil
			if _G["ElvUF_Assist"] and _G["ElvUF_Assist"]:IsShown() then
				headerassist = _G["ElvUF_Assist"]
			end

			local _, unit1class = UnitClass(unit)
			if not unit1class then
				return
			end
			local truer = 0
			local trueg = 0
			local trueb = 0
			local trueclass
			if E.db.ElvUI_EltreumUI.lightmode then
				if E. Retail then
					if unit1class == 'WARRIOR' then
						truer = 0.77646887302399
						trueg = 0.60784178972244
						trueb = 0.4274500310421
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.95686066150665
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.66666519641876
						trueg = 0.82744914293289
						trueb = 0.44705784320831
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.99999779462814
						trueg = 0.95686066150665
						trueb = 0.40784224867821
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.gradientmode.enable then --priest ruins everything gradient
						trueclass = "PRIEST"
						return
					elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.gradientmode.enable then
						truer = 0.99999779462814
						trueg = 0.99999779462814
						trueb = 0.99999779462814
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.11764679849148
						trueb = 0.2274504750967
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' then
						truer = 0
						trueg = 0.4392147064209
						trueb = 0.86666476726532
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.24705828726292
						trueg = 0.78039044141769
						trueb = 0.92156660556793
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.52941060066223
						trueg = 0.53333216905594
						trueb = 0.93333131074905
						trueclass = "WARLOCK"
					elseif unit1class == 'MONK' then
						truer = 0
						trueg = 0.99999779462814
						trueb = 0.59607714414597
						trueclass = "MONK"
					elseif unit1class == 'DRUID' then
						truer = 0.99999779462814
						trueg = 0.48627343773842
						trueb = 0.039215601980686
						trueclass = "DRUID"
					elseif unit1class == 'DEMONHUNTER' then
						truer = 0.63921427726746
						trueg = 0.1882348805666
						trueb = 0.78823357820511
						trueclass = "DEMONHUNTER"
					end
				elseif E.Wrath or E.TBC or E.Classic then
					if unit1class == 'WARRIOR' then
						truer = 0.78039044141769
						trueg = 0.61176335811615
						trueb = 0.43137159943581
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.96078222990036
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.67058676481247
						trueg = 0.8313707113266
						trueb = 0.45097941160202
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.99999779462814
						trueg = 0.96078222990036
						trueb = 0.41176378726959
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.gradientmode.enable then --priest ruins everything gradient
						trueclass = "PRIEST"
						return
					elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.gradientmode.enable then
						truer = 0.99999779462814
						trueg = 0.99999779462814
						trueb = 0.99999779462814
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.1215683594346
						trueb = 0.23137204349041
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
						truer = 0
						trueg = 0.4392147064209
						trueb = 0.87058633565903
						trueclass = "SHAMAN"
					elseif unit1class == 'SHAMAN' and E.Classic then
						truer = 0.96078222990036
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.25097984075546
						trueg = 0.78039044141769
						trueb = 0.92156660556793
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.52941060066223
						trueg = 0.52941060066223
						trueb = 0.92940974235535
						trueclass = "WARLOCK"
					elseif unit1class == 'DRUID' then
						truer = 0.99999779462814
						trueg = 0.49019500613213
						trueb = 0.039215601980686
						trueclass = "DRUID"
					end
				end
			elseif E.db.ElvUI_EltreumUI.darkmode then
				if E. Retail then
					if unit1class == 'WARRIOR' then
						truer = 0.58039087057114
						trueg = 0.45490095019341
						trueb = 0.32156792283058
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.71764546632767
						trueg = 0.41176378726959
						trueb = 0.54509681463242
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.49803811311722
						trueg = 0.61960649490356
						trueb = 0.33333259820938
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.74901795387268
						trueg = 0.71764546632767
						trueb = 0.30588167905807
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' then
						truer = 0.74901795387268
						trueg = 0.74901795387268
						trueb = 0.74901795387268
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.086274318397045
						trueb = 0.16862708330154
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' then
						truer = 0
						trueg = 0.32941102981567
						trueb = 0.65097898244858
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.18431332707405
						trueg = 0.58431243896484
						trueb = 0.69019454717636
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.39607757329941
						trueg = 0.39999911189079
						trueb = 0.69803768396378
						trueclass = "WARLOCK"
					elseif unit1class == 'MONK' then
						truer = 0
						trueg = 0.74901795387268
						trueb = 0.44705784320831
						trueclass = "MONK"
					elseif unit1class == 'DRUID' then
						truer = 0.74901795387268
						trueg = 0.36470508575439
						trueb = 0.027450919151306
						trueclass = "DRUID"
					elseif unit1class == 'DEMONHUNTER' then
						truer = 0.47843033075333
						trueg = 0.14117616415024
						trueb = 0.59215557575226
						trueclass = "DEMONHUNTER"
					end
				elseif E.Wrath or E.TBC or E.Classic then
					if unit1class == 'WARRIOR' then
						truer = 0.58431243896484
						trueg = 0.45882251858711
						trueb = 0.32156792283058
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.72156703472137
						trueg = 0.41176378726959
						trueb = 0.54901838302612
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.50195968151093
						trueg = 0.62352806329727
						trueb = 0.33725416660309
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.74901795387268
						trueg = 0.72156703472137
						trueb = 0.30588167905807
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' then
						truer = 0.74901795387268
						trueg = 0.74901795387268
						trueb = 0.74901795387268
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.090195879340172
						trueb = 0.17254863679409
						trueclass = "DEMONHUNTER"
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
						truer = 0
						trueg = 0.32941102981567
						trueb = 0.65097898244858
						trueclass = "SHAMAN"
					elseif unit1class == 'SHAMAN' and E.Classic then
						truer = 0.72156703472137
						trueg = 0.41176378726959
						trueb = 0.54901838302612
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.1882348805666
						trueg = 0.58431243896484
						trueb = 0.69019454717636
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.39607757329941
						trueg = 0.39607757329941
						trueb = 0.69803768396378
						trueclass = "WARLOCK"
					elseif unit1class == 'DRUID' then
						truer = 0.74901795387268
						trueg = 0.3686266541481
						trueb = 0.031372480094433
						trueclass = "DRUID"
					end
				end
			end

			local function ApplyGradientTexture(g1,b1,r1,r,g,b,button)
				if tostring(g1) == tostring(trueg) and tostring(r1) == tostring(truer) and tostring(b1) == tostring(trueb) then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
						if E.db.ElvUI_EltreumUI.lightmode then
							button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass))
							else
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass))
							end
						elseif E.db.ElvUI_EltreumUI.darkmode then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass, false, true))
							else
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass, false, true))
							end
						end
					elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.lightmode then
							if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
							else
								--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
								button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture(trueclass))
							end
						elseif E.db.ElvUI_EltreumUI.darkmode then
							if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
							end
						end
					end
				end
			end

			if headergroup ~= nil then
				for i = 1, headergroup:GetNumChildren() do
					local group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						local groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Health then
							local r1,g1,b1
							if E.db.ElvUI_EltreumUI.lightmode then
								r1,g1,b1 = groupbutton.Health:GetStatusBarColor()
							elseif E.db.ElvUI_EltreumUI.darkmode and groupbutton.Health.backdropTex then
								r1,g1,b1 = groupbutton.Health.backdropTex:GetVertexColor()
							end
							local r = tostring(r1)
							local g = tostring(g1)
							local b = tostring(b1)
							ApplyGradientTexture(g1,b1,r1, r,g,b, groupbutton)
						end
					end
				end
			end

			if headertank ~= nil then
				for i = 1, headertank:GetNumChildren() do
					local tankbutton = select(i, headertank:GetChildren())
					if tankbutton and tankbutton.Health then
						local r1,g1,b1
						if E.db.ElvUI_EltreumUI.lightmode then
							r1,g1,b1 = tankbutton.Health:GetStatusBarColor()
						elseif E.db.ElvUI_EltreumUI.darkmode and tankbutton.Health.backdropTex then
							r1,g1,b1 = tankbutton.Health.backdropTex:GetVertexColor()
						end
						local r = tostring(r1)
						local g = tostring(g1)
						local b = tostring(b1)
						ApplyGradientTexture(g1,b1,r1, r,g,b, tankbutton)
					end
				end
			end

			if headerassist ~= nil then
				for i = 1, headerassist:GetNumChildren() do
					local assistbutton = select(i, headerassist:GetChildren())
					if assistbutton and assistbutton.Health then
						local r1,g1,b1
						if E.db.ElvUI_EltreumUI.lightmode then
							r1,g1,b1 = assistbutton.Health:GetStatusBarColor()
						elseif E.db.ElvUI_EltreumUI.darkmode and assistbutton.Health.backdropTex then
							r1,g1,b1 = assistbutton.Health.backdropTex:GetVertexColor()
						end
						local r = tostring(r1)
						local g = tostring(g1)
						local b = tostring(b1)
						ApplyGradientTexture(g1,b1,r1, r,g,b, assistbutton)
					end
				end
			end
		end

	end
end
hooksecurefunc(UF, "Style", ElvUI_EltreumUI.GradientCustomTexture) --if not hooking into this then when the target of target changes it doesnt update
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientCustomTexture)

--Unitframe Backdrop Texture
function ElvUI_EltreumUI:BackdropTexture(_, _, backdropTex)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then --and (not E.db.ElvUI_EltreumUI.lightmode) then
		--if not E.db.ElvUI_EltreumUI.gradientmode.enable then
			backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
			backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
		--end
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)
