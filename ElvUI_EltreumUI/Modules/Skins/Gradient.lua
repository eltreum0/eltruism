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
	["NPCNEUTRAL"] = {r1 = 0.8156862745098, g1 = 1, b1 = 0, r2 = 1, g2 = 0.85882352941176, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	["NPCHOSTILE"] = {r1 = 1, g1 = 0.090196078431373, b1 = 0, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
	["TAPPED"] = {r1 = 0.6, g1 = 0.6, b1 = 0.60, r2 = 0, g2 = 0, b2 = 0},
	["GOODTHREAT"] = {r1 = 0.1999995559454, g1 = 0.7098023891449, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["BADTHREAT"] = {r1 = 0.99999779462814, g1 = 0.1764702051878, b1 = 0.1764702051878, r2 = 1, g2 = 0, b2 = 0},
	["GOODTHREATTRANSITION"] = {r1 = 0.99999779462814, g1 = 0.85097849369049, b1 = 0.1999995559454, r2 = 1, g2 = 0, b2 = 0},
	["BADTHREATTRANSITION"] = {r1 = 0.99999779462814, g1 = 0.50980281829834, b1 = 0.1999995559454, r2 = 1, g2 = 0, b2 = 0},
	["OFFTANK"] = {r1 = 0.95686066150665, g1 = 0.54901838302612, b1 = 0.72941017150879, r2 = 1, g2 = 0, b2 = 0},
	["OFFTANKBADTHREATTRANSITION"]  = {r1 = 0.77646887302399, g1 = 0.60784178972244, b1 = 0.4274500310421, r2 = 1, g2 = 0, b2 = 0},
	["OFFTANKGOODTHREATTRANSITION"]  = {r1 = 0.37646887302399, g1 = 0.90784178972244, b1 = 0.9274500310421, r2 = 1, g2 = 0, b2 = 0},
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
	["TAPPED"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["GOODTHREAT"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["BADTHREAT"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["GOODTHREATTRANSITION"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["BADTHREATTRANSITION"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["OFFTANK"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["OFFTANKBADTHREATTRANSITION"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
	["OFFTANKGOODTHREATTRANSITION"] = {r1 = 0, g1 = 0, b1 = 0, r2 = 1, g2 = 0, b2 = 0},
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
	["TAPPED"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Tapped.tga",
}
local unitframeclasscustom = {
	["WARRIOR"] = "",
	["PALADIN"] = "",
	["HUNTER"] = "",
	["ROGUE"] = "",
	["PRIEST"] = "",
	["DEATHKNIGHT"] = "",
	["SHAMAN"] = "",
	["MAGE"] = "",
	["WARLOCK"] = "",
	["MONK"] = "",
	["DRUID"] = "",
	["DEMONHUNTER"] = "",
	["NPCFRIENDLY"] = "",
	["NPCNEUTRAL"] = "",
	["NPCUNFRIENDLY"] = "",
	["NPCHOSTILE"] = "",
	["TAPPED"] = "",
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
		["TAPPED"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.tappedtexture)),
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
		["TAPPED"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.tappedR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.tappedG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.tappedB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.tappedR2, g2= E.db.ElvUI_EltreumUI.gradientmode.tappedG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.tappedB2},
		["GOODTHREAT"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreatB2},
		["BADTHREAT"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.badthreatR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.badthreatG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.badthreatB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.badthreatR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.badthreatG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.badthreatB2},
		["GOODTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionB2},
		["BADTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionB2},
		["OFFTANK"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.offtankR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.offtankG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.offtankB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.offtankR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.offtankG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.offtankB2},
		["OFFTANKBADTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionofftankR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionofftankG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionofftankB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionofftankR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionofftankG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.badthreattransitionofftankB2},
		["OFFTANKGOODTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionofftankR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionofftankG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionofftankB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionofftankR2, g2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionofftankG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.goodthreattransitionofftankB2},
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
			["TAPPED"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Tappedv2.tga",
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
			["TAPPED"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Tappedv3.tga",
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
	if unitclass ~= nil then
		return unitframeclass[unitclass]
	end
end

--get the custom texture
function ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass)
	if unitclass ~= nil then
		return unitframeclasscustom[unitclass]
	end
end

--get the colors for class detection
function ElvUI_EltreumUI:UnitframeClassColor(unitclass)
	if unitclass ~= nil then
		return classtable[unitclass].r, classtable[unitclass].g, classtable[unitclass].b
	end
end

--get the gradient colors
function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha)
	if unitclass ~= nil then
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
end

--get the custom gradient colors
function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha)
	if unitclass ~= nil then
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
end
