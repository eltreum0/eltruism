local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local tostring = _G.tostring
local CreateFrame = _G.CreateFrame

--set the variables
local unitframegradients = {
	["WARRIOR"] = {r1 = 0.42745098039216, g1 = 0.13725490196078, b1 = 0.090196078431373, r2 = 0.56470588235294, g2 = 0.43137254901961, b2 = 0.24705882352941},
	["PALADIN"] = {r1 = 1, g1 = 0.26666666666667, b1 = 0.53725490196078, r2 = 0.95686274509804, g2 = 0.54901960784314, b2 = 0.72941176470588},
	--["HUNTER"] = {r1 = 0.45490196078431, g1 = 0.59607843137255, b1 = 0.25490196078431, r2 = 0.43921568627451, g2 = 0.87843137254902, b2 = 0},
	--["MONK"] = {r1 = 0, g1 = 0.77254901960784, b1 = 0.45882352941176, r2 = 0, g2 = 0.76078431372549, b2 = 0.24313725490196},
	["HUNTER"] = {r1 = 0.40392156862745, g1 = 0.53725490196078, b1 = 0.22352941176471, r2 = 0.67058823529412, g2 = 0.92941176470588, b2 = 0.30980392156863},
	["MONK"] = {r1 = 0.015686274509804, g1 = 0.6078431372549, b1 = 0.36862745098039, r2 = 0, g2 = 1, b2 = 0.58823529411765},
	["ROGUE"] = {r1 = 1, g1 = 0.68627450980392, b1 = 0, r2 = 1, g2 = 0.83137254901961, b2 = 0.25490196078431},
	["PRIEST"] = {r1 = 0.3568627450980392, g1 = 0.3568627450980392, b1 = 0.3568627450980392, r2 = 0.98823529411765, g2 = 0.98823529411765, b2 = 0.98823529411765},
	["DEATHKNIGHT"] = {r1 = 0.49803921568627, g1 = 0.074509803921569, b1 = 0.14901960784314, r2 = 1, g2 = 0.1843137254902, b2 = 0.23921568627451},
	["SHAMAN"] = {r1 = 0, g1 = 0.25882352941176, b1 = 0.50980392156863, r2 = 0.3921568627451, g2 = 0.44313725490196, b2 = 1},
	["MAGE"] = {r1 = 0, g1 = 0.33333333333333, b1 = 0.53725490196078, r2 = 0.49019607843137, g2 = 0.87058823529412, b2 = 1},
	["WARLOCK"] = {r1 = 0.26274509803922, g1 = 0.26666666666667, b1 = 0.46666666666667, r2 = 0.66274509803922, g2= 0.3921568627451, b2 = 0.7843137254902},
	["DRUID"] = {r1 = 1, g1 = 0.23921568627451, b1 = 0.007843137254902, r2 = 1, g2 = 0.48627450980392, b2 = 0.03921568627451},
	["DEMONHUNTER"] = {r1 = 0.36470588235294, g1 = 0.13725490196078, b1 = 0.57254901960784, r2 = 0.74509803921569, g2 = 0.1921568627451, b2 = 1},
	["NPCFRIENDLY"] = {r1 = 0.30980392156863, g1 = 0.85098039215686, b1 = 0.2, r2 = 0.34117647058824, g2 = 0.62745098039216, b2 = 0.4078431372549},
	["NPCNEUTRAL"] = {r1 = 0.8156862745098, g1 = 1, b1 = 0, r2 = 1, g2 = 0.85882352941176, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	["NPCHOSTILE"] = {r1 = 1, g1 = 0.090196078431373, b1 = 0, r2 = 1, g2 = 0, b2 = 0.54901960784314},
	["TAPPED"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2 = 0, b2 = 0},
	["GOODTHREAT"] = {r1 = 0.27843075990677, g1 = 1, b1 = 0, r2 = 0.95294117647059, g2 = 0.99999779462814, b2 = 0},
	["BADTHREAT"] = {r1 = 1, g1 = 0.17647058823529, b1 = 0.1764702051878, r2 = 0.82352941176471, g2 = 0, b2 = 0.34901960784314},
	["GOODTHREATTRANSITION"] = {r1 = 1, g1 = 0.99607843137255, b1 = 0.2, r2 = 1, g2 = 0.73333333333333, b2 = 0},
	["BADTHREATTRANSITION"] = {r1 = 1, g1 = 0.3921568627451, b1 = 0.2, r2 = 1, g2 = 0.9843137254902, b2 = 0},
	["OFFTANK"] = {r1 = 0.72941176470588, g1 = 0.2, b1 = 1, r2 = 0.34117647058824, g2 = 0, b2 = 1},
	["OFFTANKBADTHREATTRANSITION"] = {r1 = 0.70980392156863, g1 = 0.43137254901961, b1 = 0.27058823529412, r2 = 0.90196078431373, g2 = 0.15294117647059, b2 = 0},
	["OFFTANKGOODTHREATTRANSITION"] = {r1 = 0.30980392156863, g1 = 0.45098039215686, b1 = 0.63137254901961, r2 = 0, g2 = 1, b2 = 0.70980392156863},
	["MANA"] = {r1 = 0.49, g1 = 0.71, b1 = 1, r2 = 0.29, g2 = 0.26, b2 = 1}, --MANA
	["RAGE"] = {r1 = 1, g1 = 0.32, b1 = 0.32, r2 = 1, g2 = 0, b2 = 0.13}, --RAGE
	["FOCUS"] = {r1 = 1, g1 = 0.50, b1 = 0.25, r2 = 0.71, g2 = 0.22, b2 = 0.07}, --FOCUS
	["ENERGY"] = {r1 = 1, g1 = 0.97, b1 = 0.54, r2 = 1, g2 = 0.70, b2 = 0.07}, --ENERGY
	["RUNIC_POWER"] = {r1 = 0, g1 = 0.82, b1 = 1, r2 = 0, g2 = 0.40, b2 = 1}, --RUNIC POWER
	["LUNAR_POWER"] = {r1 = 0.30, g1 = 0.52, b1 = 0.90, r2 = 0.12, g2 = 0.36, b2 = 0.90}, --LUNAR POWER
	["ALT_POWER"] = {r1 = 0.2, g1 = 0.4, b1 = 0.8, r2 = 0.25, g2 = 0.51, b2 = 1}, --ALTERNATE POWER
	["MAELSTROM"] = {r1 = 0, g1 = 0.50, b1 = 1, r2 = 0, g2 = 0.11, b2 = 1}, --MAELSTROM
	["INSANITY"] = {r1 = 0.50, g1 = 0.25, b1 = 1, r2 = 0.70, g2 = 0, b2 = 1}, --INSANITY
	["FURY"] = {r1 = 0.79, g1 = 0.26, b1 = 1, r2 = 0.71, g2 = 0, b2 = 1}, --FURY
	["PAIN"] = {r1 = 1, g1 = 0.61, b1 = 0, r2 = 1, g2 = 0.30, b2 = 0}, --PAIN
}

local unitframecustomgradients = {
	["WARRIOR"] = {r1 = 0.42745098039216, g1 = 0.13725490196078, b1 = 0.090196078431373, r2 = 0.56470588235294, g2 = 0.43137254901961, b2 = 0.24705882352941},
	["PALADIN"] = {r1 = 1, g1 = 0.26666666666667, b1 = 0.53725490196078, r2 = 0.95686274509804, g2 = 0.54901960784314, b2 = 0.72941176470588},
	--["HUNTER"] = {r1 = 0.45490196078431, g1 = 0.59607843137255, b1 = 0.25490196078431, r2 = 0.43921568627451, g2 = 0.87843137254902, b2 = 0},
	--["MONK"] = {r1 = 0, g1 = 0.77254901960784, b1 = 0.45882352941176, r2 = 0, g2 = 0.76078431372549, b2 = 0.24313725490196},
	["HUNTER"] = {r1 = 0.40392156862745, g1 = 0.53725490196078, b1 = 0.22352941176471, r2 = 0.67058823529412, g2 = 0.92941176470588, b2 = 0.30980392156863},
	["MONK"] = {r1 = 0.015686274509804, g1 = 0.6078431372549, b1 = 0.36862745098039, r2 = 0, g2 = 1, b2 = 0.58823529411765},
	["ROGUE"] = {r1 = 1, g1 = 0.68627450980392, b1 = 0, r2 = 1, g2 = 0.83137254901961, b2 = 0.25490196078431},
	["PRIEST"] = {r1 = 0.3568627450980392, g1 = 0.3568627450980392, b1 = 0.3568627450980392, r2 = 0.98823529411765, g2 = 0.98823529411765, b2 = 0.98823529411765},
	["DEATHKNIGHT"] = {r1 = 0.49803921568627, g1 = 0.074509803921569, b1 = 0.14901960784314, r2 = 1, g2 = 0.1843137254902, b2 = 0.23921568627451},
	["SHAMAN"] = {r1 = 0, g1 = 0.25882352941176, b1 = 0.50980392156863, r2 = 0.3921568627451, g2 = 0.44313725490196, b2 = 1},
	["MAGE"] = {r1 = 0, g1 = 0.33333333333333, b1 = 0.53725490196078, r2 = 0.49019607843137, g2 = 0.87058823529412, b2 = 1},
	["WARLOCK"] = {r1 = 0.26274509803922, g1 = 0.26666666666667, b1 = 0.46666666666667, r2 = 0.66274509803922, g2= 0.3921568627451, b2 = 0.7843137254902},
	["DRUID"] = {r1 = 1, g1 = 0.23921568627451, b1 = 0.007843137254902, r2 = 1, g2 = 0.48627450980392, b2 = 0.03921568627451},
	["DEMONHUNTER"] = {r1 = 0.36470588235294, g1 = 0.13725490196078, b1 = 0.57254901960784, r2 = 0.74509803921569, g2 = 0.1921568627451, b2 = 1},
	["NPCFRIENDLY"] = {r1 = 0.30980392156863, g1 = 0.85098039215686, b1 = 0.2, r2 = 0.34117647058824, g2 = 0.62745098039216, b2 = 0.4078431372549},
	["NPCNEUTRAL"] = {r1 = 0.8156862745098, g1 = 1, b1 = 0, r2 = 1, g2 = 0.85882352941176, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	["NPCHOSTILE"] = {r1 = 1, g1 = 0.090196078431373, b1 = 0, r2 = 1, g2 = 0, b2 = 0.54901960784314},
	["TAPPED"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2 = 0, b2 = 0},
	["GOODTHREAT"] = {r1 = 0.27843075990677, g1 = 1, b1 = 0, r2 = 0.95294117647059, g2 = 0.99999779462814, b2 = 0},
	["BADTHREAT"] = {r1 = 1, g1 = 0.17647058823529, b1 = 0.1764702051878, r2 = 0.82352941176471, g2 = 0, b2 = 0.34901960784314},
	["GOODTHREATTRANSITION"] = {r1 = 1, g1 = 0.99607843137255, b1 = 0.2, r2 = 1, g2 = 0.73333333333333, b2 = 0},
	["BADTHREATTRANSITION"] = {r1 = 1, g1 = 0.3921568627451, b1 = 0.2, r2 = 1, g2 = 0.9843137254902, b2 = 0},
	["OFFTANK"] = {r1 = 0.72941176470588, g1 = 0.2, b1 = 1, r2 = 0.34117647058824, g2 = 0, b2 = 1},
	["OFFTANKBADTHREATTRANSITION"] = {r1 = 0.70980392156863, g1 = 0.43137254901961, b1 = 0.27058823529412, r2 = 0.90196078431373, g2 = 0.15294117647059, b2 = 0},
	["OFFTANKGOODTHREATTRANSITION"] = {r1 = 0.30980392156863, g1 = 0.45098039215686, b1 = 0.63137254901961, r2 = 0, g2 = 1, b2 = 0.70980392156863},
	["MANA"] = {r1 = 0.49, g1 = 0.71, b1 = 1, r2 = 0.29, g2 = 0.26, b2 = 1}, --MANA
	["RAGE"] = {r1 = 1, g1 = 0.32, b1 = 0.32, r2 = 1, g2 = 0, b2 = 0.13}, --RAGE
	["FOCUS"] = {r1 = 1, g1 = 0.50, b1 = 0.25, r2 = 0.71, g2 = 0.22, b2 = 0.07}, --FOCUS
	["ENERGY"] = {r1 = 1, g1 = 0.97, b1 = 0.54, r2 = 1, g2 = 0.70, b2 = 0.07}, --ENERGY
	["RUNIC_POWER"] = {r1 = 0, g1 = 0.82, b1 = 1, r2 = 0, g2 = 0.40, b2 = 1}, --RUNIC POWER
	["LUNAR_POWER"] = {r1 = 0.30, g1 = 0.52, b1 = 0.90, r2 = 0.12, g2 = 0.36, b2 = 0.90}, --LUNAR POWER
	["ALT_POWER"] = {r1 = 0.2, g1 = 0.4, b1 = 0.8, r2 = 0.25, g2 = 0.51, b2 = 1}, --ALTERNATE POWER
	["MAELSTROM"] = {r1 = 0, g1 = 0.50, b1 = 1, r2 = 0, g2 = 0.11, b2 = 1}, --MAELSTROM
	["INSANITY"] = {r1 = 0.50, g1 = 0.25, b1 = 1, r2 = 0.70, g2 = 0, b2 = 1}, --INSANITY
	["FURY"] = {r1 = 0.79, g1 = 0.26, b1 = 1, r2 = 0.71, g2 = 0, b2 = 1}, --FURY
	["PAIN"] = {r1 = 1, g1 = 0.61, b1 = 0, r2 = 1, g2 = 0.30, b2 = 0}, --PAIN
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
		["WARRIOR"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture)),
		["PALADIN"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture)),
		["HUNTER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture)),
		["ROGUE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture)),
		["PRIEST"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture)),
		["DEATHKNIGHT"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture)),
		["SHAMAN"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture)),
		["MAGE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture)),
		["WARLOCK"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture)),
		["MONK"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture)),
		["DRUID"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture)),
		["DEMONHUNTER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture)),
		["NPCFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly)),
		["NPCNEUTRAL"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral)),
		["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly)),
		["NPCHOSTILE"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile)),
		["TAPPED"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture)),
	}
	unitframecustomgradients = {
		["WARRIOR"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warriorcustomcolorB2},
		["PALADIN"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.paladincustomcolorB2},
		["HUNTER"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.huntercustomcolorB2},
		["ROGUE"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.roguecustomcolorB2},
		["PRIEST"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB2},
		["DEATHKNIGHT"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorR2, g2= E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.deathknightcustomcolorB2},
		["SHAMAN"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.shamancustomcolorB2},
		["MAGE"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.magecustomcolorB2},
		["WARLOCK"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.warlockcustomcolorB2},
		["MONK"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.monkcustomcolorB2},
		["DRUID"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.druidcustomcolorB2},
		["DEMONHUNTER"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorR2, g2= E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.demonhuntercustomcolorB2},
		["NPCFRIENDLY"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcfriendlyB2},
		["NPCNEUTRAL"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcneutralB2},
		["NPCUNFRIENDLY"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcunfriendlyB2},
		["NPCHOSTILE"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.npchostileB2},
		["TAPPED"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedR2, g2= E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.tappedB2},
		["GOODTHREAT"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreatB2},
		["BADTHREAT"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreatB2},
		["GOODTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionB2},
		["BADTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionB2},
		["OFFTANK"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.offtankB2},
		["OFFTANKBADTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.badthreattransitionofftankB2},
		["OFFTANKGOODTHREATTRANSITION"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.goodthreattransitionofftankB2},
		["MANA"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.manaB2}, --MANA
		["RAGE"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.rageB2}, --RAGE
		["FOCUS"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.focusB2}, --FOCUS
		["ENERGY"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.energyB2}, --ENERGY
		["RUNIC_POWER"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.runicpowerB2}, --RUNIC POWER
		["LUNAR_POWER"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.lunarpowerB2}, --LUNAR POWER
		["ALT_POWER"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.altpowerB2}, --ALTERNATE POWER
		["MAELSTROM"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.maelstromB2}, --MAELSTROM
		["INSANITY"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.insanityB2}, --INSANITY
		["FURY"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.furyB2}, --FURY
		["PAIN"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.painR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.painG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.painB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.painR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.painG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.painB2}, --PAIN
	}
	if E.db.ElvUI_EltreumUI.unitframes.uftextureversion == "V2" then
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
	elseif E.db.ElvUI_EltreumUI.unitframes.uftextureversion == "V3" then
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


	--just testing here bc of how it loads
	--[[if E.db.ElvUI_EltreumUI.chat.classcolorchatcustom then
		RAID_CLASS_COLORS["PRIEST"].r = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR1
		RAID_CLASS_COLORS["PRIEST"].g = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG1
		RAID_CLASS_COLORS["PRIEST"].b = E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB1
		RAID_CLASS_COLORS["PRIEST"].colorSrt = E:RGBToHex(E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorR1,E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorG1,E.db.ElvUI_EltreumUI.unitframes.gradientmode.priestcustomcolorB1, "ff")

		RAID_CLASS_COLORS["MAGE"].r = unitframecustomgradients["MAGE"].r1
		RAID_CLASS_COLORS["MAGE"].g = unitframecustomgradients["MAGE"].g1
		RAID_CLASS_COLORS["MAGE"].b = unitframecustomgradients["MAGE"].b1
		RAID_CLASS_COLORS["MAGE"].colorSrt = E:RGBToHex(unitframecustomgradients["MAGE"].r1,unitframecustomgradients["MAGE"].g1,unitframecustomgradients["MAGE"].b1, "ff")

		RAID_CLASS_COLORS["WARLOCK"].r = unitframecustomgradients["WARLOCK"].r1
		RAID_CLASS_COLORS["WARLOCK"].g = unitframecustomgradients["WARLOCK"].g1
		RAID_CLASS_COLORS["WARLOCK"].b = unitframecustomgradients["WARLOCK"].b1
		RAID_CLASS_COLORS["WARLOCK"].colorSrt = E:RGBToHex(unitframecustomgradients["WARLOCK"].r1,unitframecustomgradients["WARLOCK"].g1,unitframecustomgradients["WARLOCK"].b1, "ff")

		RAID_CLASS_COLORS["HUNTER"].r = unitframecustomgradients["HUNTER"].r1
		RAID_CLASS_COLORS["HUNTER"].g = unitframecustomgradients["HUNTER"].g1
		RAID_CLASS_COLORS["HUNTER"].b = unitframecustomgradients["HUNTER"].b1
		RAID_CLASS_COLORS["HUNTER"].colorSrt = E:RGBToHex(unitframecustomgradients["HUNTER"].r1,unitframecustomgradients["HUNTER"].g1,unitframecustomgradients["HUNTER"].b1, "ff")

		RAID_CLASS_COLORS["DEATHKNIGHT"].r = unitframecustomgradients["DEATHKNIGHT"].r1
		RAID_CLASS_COLORS["DEATHKNIGHT"].g = unitframecustomgradients["DEATHKNIGHT"].g1
		RAID_CLASS_COLORS["DEATHKNIGHT"].b = unitframecustomgradients["DEATHKNIGHT"].b1
		RAID_CLASS_COLORS["DEATHKNIGHT"].colorSrt = E:RGBToHex(unitframecustomgradients["DEATHKNIGHT"].r1,unitframecustomgradients["DEATHKNIGHT"].g1,unitframecustomgradients["DEATHKNIGHT"].b1, "ff")

		RAID_CLASS_COLORS["PALADIN"].r = unitframecustomgradients["PALADIN"].r1
		RAID_CLASS_COLORS["PALADIN"].g = unitframecustomgradients["PALADIN"].g1
		RAID_CLASS_COLORS["PALADIN"].b = unitframecustomgradients["PALADIN"].b1
		RAID_CLASS_COLORS["PALADIN"].colorSrt = E:RGBToHex(unitframecustomgradients["PALADIN"].r1,unitframecustomgradients["PALADIN"].g1,unitframecustomgradients["PALADIN"].b1, "ff")

		RAID_CLASS_COLORS["ROGUE"].r = unitframecustomgradients["ROGUE"].r1
		RAID_CLASS_COLORS["ROGUE"].g = unitframecustomgradients["ROGUE"].g1
		RAID_CLASS_COLORS["ROGUE"].b = unitframecustomgradients["ROGUE"].b1
		RAID_CLASS_COLORS["ROGUE"].colorSrt = E:RGBToHex(unitframecustomgradients["ROGUE"].r1,unitframecustomgradients["ROGUE"].g1,unitframecustomgradients["ROGUE"].b1, "ff")

		RAID_CLASS_COLORS["SHAMAN"].r = unitframecustomgradients["SHAMAN"].r1
		RAID_CLASS_COLORS["SHAMAN"].g = unitframecustomgradients["SHAMAN"].g1
		RAID_CLASS_COLORS["SHAMAN"].b = unitframecustomgradients["SHAMAN"].b1
		RAID_CLASS_COLORS["SHAMAN"].colorSrt = E:RGBToHex(unitframecustomgradients["SHAMAN"].r1,unitframecustomgradients["SHAMAN"].g1,unitframecustomgradients["SHAMAN"].b1, "ff")

		RAID_CLASS_COLORS["WARRIOR"].r = unitframecustomgradients["WARRIOR"].r1
		RAID_CLASS_COLORS["WARRIOR"].g = unitframecustomgradients["WARRIOR"].g1
		RAID_CLASS_COLORS["WARRIOR"].b = unitframecustomgradients["WARRIOR"].b1
		RAID_CLASS_COLORS["WARRIOR"].colorSrt = E:RGBToHex(unitframecustomgradients["WARRIOR"].r1,unitframecustomgradients["WARRIOR"].g1,unitframecustomgradients["WARRIOR"].b1, "ff")

		RAID_CLASS_COLORS["DRUID"].r = unitframecustomgradients["DRUID"].r1
		RAID_CLASS_COLORS["DRUID"].g = unitframecustomgradients["DRUID"].g1
		RAID_CLASS_COLORS["DRUID"].b = unitframecustomgradients["DRUID"].b1
		RAID_CLASS_COLORS["DRUID"].colorSrt = E:RGBToHex(unitframecustomgradients["DRUID"].r1,unitframecustomgradients["DRUID"].g1,unitframecustomgradients["DRUID"].b1, "ff")

		RAID_CLASS_COLORS["MONK"].r = unitframecustomgradients["MONK"].r1
		RAID_CLASS_COLORS["MONK"].g = unitframecustomgradients["MONK"].g1
		RAID_CLASS_COLORS["MONK"].b = unitframecustomgradients["MONK"].b1
		RAID_CLASS_COLORS["MONK"].colorSrt = E:RGBToHex(unitframecustomgradients["MONK"].r1,unitframecustomgradients["MONK"].g1,unitframecustomgradients["MONK"].b1, "ff")

		RAID_CLASS_COLORS["DEMONHUNTER"].r = unitframecustomgradients["DEMONHUNTER"].r1
		RAID_CLASS_COLORS["DEMONHUNTER"].g = unitframecustomgradients["DEMONHUNTER"].g1
		RAID_CLASS_COLORS["DEMONHUNTER"].b = unitframecustomgradients["DEMONHUNTER"].b1
		RAID_CLASS_COLORS["DEMONHUNTER"].colorSrt = E:RGBToHex(unitframecustomgradients["DEMONHUNTER"].r1,unitframecustomgradients["DEMONHUNTER"].g1,unitframecustomgradients["DEMONHUNTER"].b1, "ff")
	end]]
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
	if unitclass then
		return unitframeclass[unitclass]
	end
end

--get the custom texture
function ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass)
	if unitclass then
		return unitframeclasscustom[unitclass]
	end
end

--get the gradient colors
local bgfade
function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha, isBG)
	if unitclass then
		if isBG then
			bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
		else
			bgfade = 0
		end
		if not unitframegradients[unitclass] then
			if invert then
				if alpha then
					return unitframegradients["MANA"].r2 - bgfade, unitframegradients["MANA"].g2 - bgfade, unitframegradients["MANA"].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframegradients["MANA"].r1 - bgfade, unitframegradients["MANA"].g1 - bgfade, unitframegradients["MANA"].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframegradients["MANA"].r2 - bgfade, unitframegradients["MANA"].g2 - bgfade, unitframegradients["MANA"].b2 - bgfade, unitframegradients["MANA"].r1 - bgfade, unitframegradients["MANA"].g1 - bgfade, unitframegradients["MANA"].b1 - bgfade
				end
			else
				if alpha then
					return unitframegradients["MANA"].r1 - bgfade, unitframegradients["MANA"].g1 - bgfade, unitframegradients["MANA"].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframegradients["MANA"].r2 - bgfade, unitframegradients["MANA"].g2 - bgfade, unitframegradients["MANA"].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframegradients["MANA"].r1 - bgfade, unitframegradients["MANA"].g1 - bgfade, unitframegradients["MANA"].b1 - bgfade, unitframegradients["MANA"].r2 - bgfade, unitframegradients["MANA"].g2 - bgfade, unitframegradients["MANA"].b2 - bgfade
				end
			end
		else
			if invert then
				if alpha then
					return unitframegradients[unitclass].r2 - bgfade, unitframegradients[unitclass].g2 - bgfade, unitframegradients[unitclass].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframegradients[unitclass].r1 - bgfade, unitframegradients[unitclass].g1 - bgfade, unitframegradients[unitclass].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframegradients[unitclass].r2 - bgfade, unitframegradients[unitclass].g2 - bgfade, unitframegradients[unitclass].b2 - bgfade, unitframegradients[unitclass].r1 - bgfade, unitframegradients[unitclass].g1 - bgfade, unitframegradients[unitclass].b1 - bgfade
				end
			else
				if alpha then
					return unitframegradients[unitclass].r1 - bgfade, unitframegradients[unitclass].g1 - bgfade, unitframegradients[unitclass].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframegradients[unitclass].r2 - bgfade, unitframegradients[unitclass].g2 - bgfade, unitframegradients[unitclass].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframegradients[unitclass].r1 - bgfade, unitframegradients[unitclass].g1 - bgfade, unitframegradients[unitclass].b1 - bgfade, unitframegradients[unitclass].r2 - bgfade, unitframegradients[unitclass].g2 - bgfade, unitframegradients[unitclass].b2 - bgfade
				end
			end
		end
	end
end

--get the custom gradient colors
function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha, isBG)
	if unitclass then
		if isBG then
			bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
		else
			bgfade = 0
		end
		if not unitframecustomgradients[unitclass] then
			if invert then
				if alpha then
					return unitframecustomgradients["MANA"].r2 - bgfade, unitframecustomgradients["MANA"].g2 - bgfade, unitframecustomgradients["MANA"].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframecustomgradients["MANA"].r1 - bgfade, unitframecustomgradients["MANA"].g1 - bgfade, unitframecustomgradients["MANA"].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframecustomgradients["MANA"].r2 - bgfade, unitframecustomgradients["MANA"].g2 - bgfade, unitframecustomgradients["MANA"].b2 - bgfade, unitframecustomgradients["MANA"].r1 - bgfade, unitframecustomgradients["MANA"].g1 - bgfade, unitframecustomgradients["MANA"].b1 - bgfade
				end
			else
				if alpha then
					return unitframecustomgradients["MANA"].r1 - bgfade, unitframecustomgradients["MANA"].g1 - bgfade, unitframecustomgradients["MANA"].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframecustomgradients["MANA"].r2 - bgfade, unitframecustomgradients["MANA"].g2 - bgfade, unitframecustomgradients["MANA"].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframecustomgradients["MANA"].r1 - bgfade, unitframecustomgradients["MANA"].g1 - bgfade, unitframecustomgradients["MANA"].b1 - bgfade, unitframecustomgradients["MANA"].r2 - bgfade, unitframecustomgradients["MANA"].g2 - bgfade, unitframecustomgradients["MANA"].b2 - bgfade
				end
			end
		else
			if invert then
				if alpha then
					return unitframecustomgradients[unitclass].r2 - bgfade, unitframecustomgradients[unitclass].g2 - bgfade, unitframecustomgradients[unitclass].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframecustomgradients[unitclass].r1 - bgfade, unitframecustomgradients[unitclass].g1 - bgfade, unitframecustomgradients[unitclass].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframecustomgradients[unitclass].r2 - bgfade, unitframecustomgradients[unitclass].g2 - bgfade, unitframecustomgradients[unitclass].b2 - bgfade, unitframecustomgradients[unitclass].r1 - bgfade, unitframecustomgradients[unitclass].g1 - bgfade, unitframecustomgradients[unitclass].b1 - bgfade
				end
			else
				if alpha then
					return unitframecustomgradients[unitclass].r1 - bgfade, unitframecustomgradients[unitclass].g1 - bgfade, unitframecustomgradients[unitclass].b1 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, unitframecustomgradients[unitclass].r2 - bgfade, unitframecustomgradients[unitclass].g2 - bgfade, unitframecustomgradients[unitclass].b2 - bgfade, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
				else
					return unitframecustomgradients[unitclass].r1 - bgfade, unitframecustomgradients[unitclass].g1 - bgfade, unitframecustomgradients[unitclass].b1 - bgfade, unitframecustomgradients[unitclass].r2 - bgfade, unitframecustomgradients[unitclass].g2 - bgfade, unitframecustomgradients[unitclass].b2 - bgfade
				end
			end
		end
	end
end

--sets name with gradient colors using elvui
function ElvUI_EltreumUI:GradientName(name, unitclass)
	local text
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
		if not unitframecustomgradients[unitclass] then
			text = E:TextGradient(name, unitframecustomgradients["MANA"].r1, unitframecustomgradients["MANA"].g1, unitframecustomgradients["MANA"].b1, unitframecustomgradients["MANA"].r2, unitframecustomgradients["MANA"].g2, unitframecustomgradients["MANA"].b2)
		else
			text = E:TextGradient(name, unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2)
		end
	else
		if not unitframegradients[unitclass] then
			text = E:TextGradient(name, unitframegradients["MANA"].r1, unitframegradients["MANA"].g1, unitframegradients["MANA"].b1, unitframegradients["MANA"].r2, unitframegradients["MANA"].g2, unitframegradients["MANA"].b2)
		else
			text = E:TextGradient(name, unitframegradients[unitclass].r1, unitframegradients[unitclass].g1, unitframegradients[unitclass].b1, unitframegradients[unitclass].r2, unitframegradients[unitclass].g2, unitframegradients[unitclass].b2)
		end
	end
	return text
end

--sends the colors for chat
function ElvUI_EltreumUI:ChatCustomColor(unitclass)
	if unitclass then
		if not unitframecustomgradients[unitclass] then
			return unitframecustomgradients["NPCNEUTRAL"].r1, unitframecustomgradients["NPCNEUTRAL"].g1, unitframecustomgradients["NPCNEUTRAL"].b1
		else
			return unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1
		end
	else
		return unitframecustomgradients["NPCNEUTRAL"].r1, unitframecustomgradients["NPCNEUTRAL"].g1, unitframecustomgradients["NPCNEUTRAL"].b1
	end
end

--different for details because bars smaller and different
function ElvUI_EltreumUI:GradientColorsDetails(unitclass)
	if unitclass then
		if not unitframegradients[unitclass] then
			return unitframegradients["NPCNEUTRAL"].r1 - 0.2, unitframegradients["NPCNEUTRAL"].g1 - 0.2, unitframegradients["NPCNEUTRAL"].b1 - 0.2, 0.9, unitframegradients["NPCNEUTRAL"].r2 + 0.2, unitframegradients["NPCNEUTRAL"].g2 + 0.2, unitframegradients["NPCNEUTRAL"].b2 + 0.2, 0.9
		else
			return unitframegradients[unitclass].r1 - 0.2, unitframegradients[unitclass].g1 - 0.2, unitframegradients[unitclass].b1 - 0.2, 0.9, unitframegradients[unitclass].r2 + 0.2, unitframegradients[unitclass].g2 + 0.2, unitframegradients[unitclass].b2 + 0.2, 0.9
		end
	end
end

function ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass)
	if unitclass then
		if not unitframegradients[unitclass] then
			return unitframecustomgradients["NPCNEUTRAL"].r1, unitframecustomgradients["NPCNEUTRAL"].g1, unitframecustomgradients["NPCNEUTRAL"].b1, 0.9, unitframecustomgradients["NPCNEUTRAL"].r2, unitframecustomgradients["NPCNEUTRAL"].g2, unitframecustomgradients["NPCNEUTRAL"].b2, 0.9
		else
			return unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, 0.9, unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2, 0.9
		end
	end
end
