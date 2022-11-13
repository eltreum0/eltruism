local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local tostring = _G.tostring
local CreateFrame = _G.CreateFrame
local bgfade

do

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
		["EVOKER"] = {r1 = 0.19607843137255, g1 = 0.46666666666667, b1 = 0.53725490196078, r2 = 0.2, g2 = 0.57647058823529, b2 = 0.49803921568627},
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
		["FURY"] = {r1 = 0.79, g1 = 0.26, b1 = 1, r2 = 1, g2 = 0, b2 = 0.95}, --FURY
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
		["EVOKER"] = {r1 = 0.19607843137255, g1 = 0.46666666666667, b1 = 0.53725490196078, r2 = 0.2, g2 = 0.57647058823529, b2 = 0.49803921568627},
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
		["FURY"] = {r1 = 0.79, g1 = 0.26, b1 = 1, r2 = 1, g2 = 0, b2 = 0.95}, --FURY
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
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-EV.tga",
		["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga",
		["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga",
		["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga",
		["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga",
		["TAPPED"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Tapped.tga",
	}
	local unitframeclasscustom = {
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
		["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-EV.tga",
		["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga",
		["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga",
		["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga",
		["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga",
		["TAPPED"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Tapped.tga",
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
			["EVOKER"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture)),
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
			["EVOKER"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorR2, g2= E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.evokercustomcolorB2},
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
				["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-EVv2.tga",
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
				["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-EVv3.tga",
				["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HTv3.tga",
				["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RGv3.tga",
				["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DRv3.tga",
				["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DKv3.tga",
				["TAPPED"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Tappedv3.tga",
			}
		end

		if E.Retail then
			local minwarriorAinv = {r=unitframegradients["WARRIOR"].r2,g= unitframegradients["WARRIOR"].g2,b= unitframegradients["WARRIOR"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarriorinv = {r=unitframegradients["WARRIOR"].r2,g= unitframegradients["WARRIOR"].g2,b= unitframegradients["WARRIOR"].b2,a= 1}
			local minwarriorAbginv = {r=unitframegradients["WARRIOR"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarriorbginv = {r=unitframegradients["WARRIOR"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minwarriorA = {r=unitframegradients["WARRIOR"].r1,g= unitframegradients["WARRIOR"].g1,b= unitframegradients["WARRIOR"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarrior = {r=unitframegradients["WARRIOR"].r1,g= unitframegradients["WARRIOR"].g1,b= unitframegradients["WARRIOR"].b1,a= 1}
			local minwarriorAbg = {r=unitframegradients["WARRIOR"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarriorbg = {r=unitframegradients["WARRIOR"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxwarriorA = {r=unitframegradients["WARRIOR"].r2,g= unitframegradients["WARRIOR"].g2,b= unitframegradients["WARRIOR"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarrior = {r=unitframegradients["WARRIOR"].r2,g= unitframegradients["WARRIOR"].g2,b= unitframegradients["WARRIOR"].b2,a= 1}
			local maxwarriorAbg = {r=unitframegradients["WARRIOR"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarriorbg = {r=unitframegradients["WARRIOR"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxwarriorAinv = {r=unitframegradients["WARRIOR"].r1,g= unitframegradients["WARRIOR"].g1,b= unitframegradients["WARRIOR"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarriorinv = {r=unitframegradients["WARRIOR"].r1,g= unitframegradients["WARRIOR"].g1,b= unitframegradients["WARRIOR"].b1,a= 1}
			local maxwarriorAbginv = {r=unitframegradients["WARRIOR"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarriorbginv = {r=unitframegradients["WARRIOR"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARRIOR"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARRIOR"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minpaladinAinv = {r=unitframegradients["PALADIN"].r2,g= unitframegradients["PALADIN"].g2,b= unitframegradients["PALADIN"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpaladininv = {r=unitframegradients["PALADIN"].r2,g= unitframegradients["PALADIN"].g2,b= unitframegradients["PALADIN"].b2,a= 1}
			local minpaladinAbginv = {r=unitframegradients["PALADIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpaladinbginv = {r=unitframegradients["PALADIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minpaladinA = {r=unitframegradients["PALADIN"].r1,g= unitframegradients["PALADIN"].g1,b= unitframegradients["PALADIN"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpaladin = {r=unitframegradients["PALADIN"].r1,g= unitframegradients["PALADIN"].g1,b= unitframegradients["PALADIN"].b1,a= 1}
			local minpaladinAbg = {r=unitframegradients["PALADIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpaladinbg = {r=unitframegradients["PALADIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxpaladinA = {r=unitframegradients["PALADIN"].r2,g= unitframegradients["PALADIN"].g2,b= unitframegradients["PALADIN"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpaladin = {r=unitframegradients["PALADIN"].r2,g= unitframegradients["PALADIN"].g2,b= unitframegradients["PALADIN"].b2,a= 1}
			local maxpaladinAbg = {r=unitframegradients["PALADIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpaladinbg = {r=unitframegradients["PALADIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxpaladinAinv = {r=unitframegradients["PALADIN"].r1,g= unitframegradients["PALADIN"].g1,b= unitframegradients["PALADIN"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpaladininv = {r=unitframegradients["PALADIN"].r1,g= unitframegradients["PALADIN"].g1,b= unitframegradients["PALADIN"].b1,a= 1}
			local maxpaladinAbginv = {r=unitframegradients["PALADIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpaladinbginv = {r=unitframegradients["PALADIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PALADIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PALADIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minhunterAinv = {r=unitframegradients["HUNTER"].r2,g= unitframegradients["HUNTER"].g2,b= unitframegradients["HUNTER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minhunterinv = {r=unitframegradients["HUNTER"].r2,g= unitframegradients["HUNTER"].g2,b= unitframegradients["HUNTER"].b2,a= 1}
			local minhunterAbginv = {r=unitframegradients["HUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minhunterbginv = {r=unitframegradients["HUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minhunterA = {r=unitframegradients["HUNTER"].r1,g= unitframegradients["HUNTER"].g1,b= unitframegradients["HUNTER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minhunter = {r=unitframegradients["HUNTER"].r1,g= unitframegradients["HUNTER"].g1,b= unitframegradients["HUNTER"].b1,a= 1}
			local minhunterAbg = {r=unitframegradients["HUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minhunterbg = {r=unitframegradients["HUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxhunterA = {r=unitframegradients["HUNTER"].r2,g= unitframegradients["HUNTER"].g2,b= unitframegradients["HUNTER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxhunter = {r=unitframegradients["HUNTER"].r2,g= unitframegradients["HUNTER"].g2,b= unitframegradients["HUNTER"].b2,a= 1}
			local maxhunterAbg = {r=unitframegradients["HUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxhunterbg = {r=unitframegradients["HUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxhunterAinv = {r=unitframegradients["HUNTER"].r1,g= unitframegradients["HUNTER"].g1,b= unitframegradients["HUNTER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxhunterinv = {r=unitframegradients["HUNTER"].r1,g= unitframegradients["HUNTER"].g1,b= unitframegradients["HUNTER"].b1,a= 1}
			local maxhunterAbginv = {r=unitframegradients["HUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxhunterbginv = {r=unitframegradients["HUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["HUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["HUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmonkAinv = {r=unitframegradients["MONK"].r2,g= unitframegradients["MONK"].g2,b= unitframegradients["MONK"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmonkinv = {r=unitframegradients["MONK"].r2,g= unitframegradients["MONK"].g2,b= unitframegradients["MONK"].b2,a= 1}
			local minmonkAbginv = {r=unitframegradients["MONK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmonkbginv = {r=unitframegradients["MONK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmonkA = {r=unitframegradients["MONK"].r1,g= unitframegradients["MONK"].g1,b= unitframegradients["MONK"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmonk = {r=unitframegradients["MONK"].r1,g= unitframegradients["MONK"].g1,b= unitframegradients["MONK"].b1,a= 1}
			local minmonkAbg = {r=unitframegradients["MONK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmonkbg = {r=unitframegradients["MONK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmonkA = {r=unitframegradients["MONK"].r2,g= unitframegradients["MONK"].g2,b= unitframegradients["MONK"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmonk = {r=unitframegradients["MONK"].r2,g= unitframegradients["MONK"].g2,b= unitframegradients["MONK"].b2,a= 1}
			local maxmonkAbg = {r=unitframegradients["MONK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmonkbg = {r=unitframegradients["MONK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmonkAinv = {r=unitframegradients["MONK"].r1,g= unitframegradients["MONK"].g1,b= unitframegradients["MONK"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmonkinv = {r=unitframegradients["MONK"].r1,g= unitframegradients["MONK"].g1,b= unitframegradients["MONK"].b1,a= 1}
			local maxmonkAbginv = {r=unitframegradients["MONK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmonkbginv = {r=unitframegradients["MONK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MONK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MONK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minrogueAinv = {r=unitframegradients["ROGUE"].r2,g= unitframegradients["ROGUE"].g2,b= unitframegradients["ROGUE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrogueinv = {r=unitframegradients["ROGUE"].r2,g= unitframegradients["ROGUE"].g2,b= unitframegradients["ROGUE"].b2,a= 1}
			local minrogueAbginv = {r=unitframegradients["ROGUE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minroguebginv = {r=unitframegradients["ROGUE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minrogueA = {r=unitframegradients["ROGUE"].r1,g= unitframegradients["ROGUE"].g1,b= unitframegradients["ROGUE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrogue = {r=unitframegradients["ROGUE"].r1,g= unitframegradients["ROGUE"].g1,b= unitframegradients["ROGUE"].b1,a= 1}
			local minrogueAbg = {r=unitframegradients["ROGUE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minroguebg = {r=unitframegradients["ROGUE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxrogueA = {r=unitframegradients["ROGUE"].r2,g= unitframegradients["ROGUE"].g2,b= unitframegradients["ROGUE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrogue = {r=unitframegradients["ROGUE"].r2,g= unitframegradients["ROGUE"].g2,b= unitframegradients["ROGUE"].b2,a= 1}
			local maxrogueAbg = {r=unitframegradients["ROGUE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxroguebg = {r=unitframegradients["ROGUE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxrogueAinv = {r=unitframegradients["ROGUE"].r1,g= unitframegradients["ROGUE"].g1,b= unitframegradients["ROGUE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrogueinv = {r=unitframegradients["ROGUE"].r1,g= unitframegradients["ROGUE"].g1,b= unitframegradients["ROGUE"].b1,a= 1}
			local maxrogueAbginv = {r=unitframegradients["ROGUE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxroguebginv = {r=unitframegradients["ROGUE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ROGUE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ROGUE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minpriestAinv = {r=unitframegradients["PRIEST"].r2,g= unitframegradients["PRIEST"].g2,b= unitframegradients["PRIEST"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpriestinv = {r=unitframegradients["PRIEST"].r2,g= unitframegradients["PRIEST"].g2,b= unitframegradients["PRIEST"].b2,a= 1}
			local minpriestAbginv = {r=unitframegradients["PRIEST"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpriestbginv = {r=unitframegradients["PRIEST"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minpriestA = {r=unitframegradients["PRIEST"].r1,g= unitframegradients["PRIEST"].g1,b= unitframegradients["PRIEST"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpriest = {r=unitframegradients["PRIEST"].r1,g= unitframegradients["PRIEST"].g1,b= unitframegradients["PRIEST"].b1,a= 1}
			local minpriestAbg = {r=unitframegradients["PRIEST"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpriestbg = {r=unitframegradients["PRIEST"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxpriestA = {r=unitframegradients["PRIEST"].r2,g= unitframegradients["PRIEST"].g2,b= unitframegradients["PRIEST"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpriest = {r=unitframegradients["PRIEST"].r2,g= unitframegradients["PRIEST"].g2,b= unitframegradients["PRIEST"].b2,a= 1}
			local maxpriestAbg = {r=unitframegradients["PRIEST"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpriestbg = {r=unitframegradients["PRIEST"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxpriestAinv = {r=unitframegradients["PRIEST"].r1,g= unitframegradients["PRIEST"].g1,b= unitframegradients["PRIEST"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpriestinv = {r=unitframegradients["PRIEST"].r1,g= unitframegradients["PRIEST"].g1,b= unitframegradients["PRIEST"].b1,a= 1}
			local maxpriestAbginv = {r=unitframegradients["PRIEST"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpriestbginv = {r=unitframegradients["PRIEST"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PRIEST"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PRIEST"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mindeathknightAinv = {r=unitframegradients["DEATHKNIGHT"].r2,g= unitframegradients["DEATHKNIGHT"].g2,b= unitframegradients["DEATHKNIGHT"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindeathknightinv = {r=unitframegradients["DEATHKNIGHT"].r2,g= unitframegradients["DEATHKNIGHT"].g2,b= unitframegradients["DEATHKNIGHT"].b2,a= 1}
			local mindeathknightAbginv = {r=unitframegradients["DEATHKNIGHT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindeathknightbginv = {r=unitframegradients["DEATHKNIGHT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mindeathknightA = {r=unitframegradients["DEATHKNIGHT"].r1,g= unitframegradients["DEATHKNIGHT"].g1,b= unitframegradients["DEATHKNIGHT"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindeathknight = {r=unitframegradients["DEATHKNIGHT"].r1,g= unitframegradients["DEATHKNIGHT"].g1,b= unitframegradients["DEATHKNIGHT"].b1,a= 1}
			local mindeathknightAbg = {r=unitframegradients["DEATHKNIGHT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindeathknightbg = {r=unitframegradients["DEATHKNIGHT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxdeathknightA = {r=unitframegradients["DEATHKNIGHT"].r2,g= unitframegradients["DEATHKNIGHT"].g2,b= unitframegradients["DEATHKNIGHT"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdeathknight = {r=unitframegradients["DEATHKNIGHT"].r2,g= unitframegradients["DEATHKNIGHT"].g2,b= unitframegradients["DEATHKNIGHT"].b2,a= 1}
			local maxdeathknightAbg = {r=unitframegradients["DEATHKNIGHT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdeathknightbg = {r=unitframegradients["DEATHKNIGHT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxdeathknightAinv = {r=unitframegradients["DEATHKNIGHT"].r1,g= unitframegradients["DEATHKNIGHT"].g1,b= unitframegradients["DEATHKNIGHT"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdeathknightinv = {r=unitframegradients["DEATHKNIGHT"].r1,g= unitframegradients["DEATHKNIGHT"].g1,b= unitframegradients["DEATHKNIGHT"].b1,a= 1}
			local maxdeathknightAbginv = {r=unitframegradients["DEATHKNIGHT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdeathknightbginv = {r=unitframegradients["DEATHKNIGHT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEATHKNIGHT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEATHKNIGHT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minshamanAinv = {r=unitframegradients["SHAMAN"].r2,g= unitframegradients["SHAMAN"].g2,b= unitframegradients["SHAMAN"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minshamaninv = {r=unitframegradients["SHAMAN"].r2,g= unitframegradients["SHAMAN"].g2,b= unitframegradients["SHAMAN"].b2,a= 1}
			local minshamanAbginv = {r=unitframegradients["SHAMAN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minshamanbginv = {r=unitframegradients["SHAMAN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minshamanA = {r=unitframegradients["SHAMAN"].r1,g= unitframegradients["SHAMAN"].g1,b= unitframegradients["SHAMAN"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minshaman = {r=unitframegradients["SHAMAN"].r1,g= unitframegradients["SHAMAN"].g1,b= unitframegradients["SHAMAN"].b1,a= 1}
			local minshamanAbg = {r=unitframegradients["SHAMAN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minshamanbg = {r=unitframegradients["SHAMAN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxshamanA = {r=unitframegradients["SHAMAN"].r2,g= unitframegradients["SHAMAN"].g2,b= unitframegradients["SHAMAN"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxshaman = {r=unitframegradients["SHAMAN"].r2,g= unitframegradients["SHAMAN"].g2,b= unitframegradients["SHAMAN"].b2,a= 1}
			local maxshamanAbg = {r=unitframegradients["SHAMAN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxshamanbg = {r=unitframegradients["SHAMAN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxshamanAinv = {r=unitframegradients["SHAMAN"].r1,g= unitframegradients["SHAMAN"].g1,b= unitframegradients["SHAMAN"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxshamaninv = {r=unitframegradients["SHAMAN"].r1,g= unitframegradients["SHAMAN"].g1,b= unitframegradients["SHAMAN"].b1,a= 1}
			local maxshamanAbginv = {r=unitframegradients["SHAMAN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxshamanbginv = {r=unitframegradients["SHAMAN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["SHAMAN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["SHAMAN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmageAinv = {r=unitframegradients["MAGE"].r2,g= unitframegradients["MAGE"].g2,b= unitframegradients["MAGE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmageinv = {r=unitframegradients["MAGE"].r2,g= unitframegradients["MAGE"].g2,b= unitframegradients["MAGE"].b2,a= 1}
			local minmageAbginv = {r=unitframegradients["MAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmagebginv = {r=unitframegradients["MAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmageA = {r=unitframegradients["MAGE"].r1,g= unitframegradients["MAGE"].g1,b= unitframegradients["MAGE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmage = {r=unitframegradients["MAGE"].r1,g= unitframegradients["MAGE"].g1,b= unitframegradients["MAGE"].b1,a= 1}
			local minmageAbg = {r=unitframegradients["MAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmagebg = {r=unitframegradients["MAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmageA = {r=unitframegradients["MAGE"].r2,g= unitframegradients["MAGE"].g2,b= unitframegradients["MAGE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmage = {r=unitframegradients["MAGE"].r2,g= unitframegradients["MAGE"].g2,b= unitframegradients["MAGE"].b2,a= 1}
			local maxmageAbg = {r=unitframegradients["MAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmagebg = {r=unitframegradients["MAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmageAinv = {r=unitframegradients["MAGE"].r1,g= unitframegradients["MAGE"].g1,b= unitframegradients["MAGE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmageinv = {r=unitframegradients["MAGE"].r1,g= unitframegradients["MAGE"].g1,b= unitframegradients["MAGE"].b1,a= 1}
			local maxmageAbginv = {r=unitframegradients["MAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmagebginv = {r=unitframegradients["MAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minwarlockAinv = {r=unitframegradients["WARLOCK"].r2,g= unitframegradients["WARLOCK"].g2,b= unitframegradients["WARLOCK"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarlockinv = {r=unitframegradients["WARLOCK"].r2,g= unitframegradients["WARLOCK"].g2,b= unitframegradients["WARLOCK"].b2,a= 1}
			local minwarlockAbginv = {r=unitframegradients["WARLOCK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarlockbginv = {r=unitframegradients["WARLOCK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minwarlockA = {r=unitframegradients["WARLOCK"].r1,g= unitframegradients["WARLOCK"].g1,b= unitframegradients["WARLOCK"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarlock = {r=unitframegradients["WARLOCK"].r1,g= unitframegradients["WARLOCK"].g1,b= unitframegradients["WARLOCK"].b1,a= 1}
			local minwarlockAbg = {r=unitframegradients["WARLOCK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minwarlockbg = {r=unitframegradients["WARLOCK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxwarlockA = {r=unitframegradients["WARLOCK"].r2,g= unitframegradients["WARLOCK"].g2,b= unitframegradients["WARLOCK"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarlock = {r=unitframegradients["WARLOCK"].r2,g= unitframegradients["WARLOCK"].g2,b= unitframegradients["WARLOCK"].b2,a= 1}
			local maxwarlockAbg = {r=unitframegradients["WARLOCK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarlockbg = {r=unitframegradients["WARLOCK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxwarlockAinv = {r=unitframegradients["WARLOCK"].r1,g= unitframegradients["WARLOCK"].g1,b= unitframegradients["WARLOCK"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarlockinv = {r=unitframegradients["WARLOCK"].r1,g= unitframegradients["WARLOCK"].g1,b= unitframegradients["WARLOCK"].b1,a= 1}
			local maxwarlockAbginv = {r=unitframegradients["WARLOCK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxwarlockbginv = {r=unitframegradients["WARLOCK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["WARLOCK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["WARLOCK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mindruidAinv = {r=unitframegradients["DRUID"].r2,g= unitframegradients["DRUID"].g2,b= unitframegradients["DRUID"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindruidinv = {r=unitframegradients["DRUID"].r2,g= unitframegradients["DRUID"].g2,b= unitframegradients["DRUID"].b2,a= 1}
			local mindruidAbginv = {r=unitframegradients["DRUID"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindruidbginv = {r=unitframegradients["DRUID"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mindruidA = {r=unitframegradients["DRUID"].r1,g= unitframegradients["DRUID"].g1,b= unitframegradients["DRUID"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindruid = {r=unitframegradients["DRUID"].r1,g= unitframegradients["DRUID"].g1,b= unitframegradients["DRUID"].b1,a= 1}
			local mindruidAbg = {r=unitframegradients["DRUID"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindruidbg = {r=unitframegradients["DRUID"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxdruidA = {r=unitframegradients["DRUID"].r2,g= unitframegradients["DRUID"].g2,b= unitframegradients["DRUID"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdruid = {r=unitframegradients["DRUID"].r2,g= unitframegradients["DRUID"].g2,b= unitframegradients["DRUID"].b2,a= 1}
			local maxdruidAbg = {r=unitframegradients["DRUID"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdruidbg = {r=unitframegradients["DRUID"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxdruidAinv = {r=unitframegradients["DRUID"].r1,g= unitframegradients["DRUID"].g1,b= unitframegradients["DRUID"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdruidinv = {r=unitframegradients["DRUID"].r1,g= unitframegradients["DRUID"].g1,b= unitframegradients["DRUID"].b1,a= 1}
			local maxdruidAbginv = {r=unitframegradients["DRUID"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdruidbginv = {r=unitframegradients["DRUID"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DRUID"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DRUID"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mindemonhunterAinv = {r=unitframegradients["DEMONHUNTER"].r2,g= unitframegradients["DEMONHUNTER"].g2,b= unitframegradients["DEMONHUNTER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindemonhunterinv = {r=unitframegradients["DEMONHUNTER"].r2,g= unitframegradients["DEMONHUNTER"].g2,b= unitframegradients["DEMONHUNTER"].b2,a= 1}
			local mindemonhunterAbginv = {r=unitframegradients["DEMONHUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindemonhunterbginv = {r=unitframegradients["DEMONHUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mindemonhunterA = {r=unitframegradients["DEMONHUNTER"].r1,g= unitframegradients["DEMONHUNTER"].g1,b= unitframegradients["DEMONHUNTER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindemonhunter = {r=unitframegradients["DEMONHUNTER"].r1,g= unitframegradients["DEMONHUNTER"].g1,b= unitframegradients["DEMONHUNTER"].b1,a= 1}
			local mindemonhunterAbg = {r=unitframegradients["DEMONHUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mindemonhunterbg = {r=unitframegradients["DEMONHUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxdemonhunterA = {r=unitframegradients["DEMONHUNTER"].r2,g= unitframegradients["DEMONHUNTER"].g2,b= unitframegradients["DEMONHUNTER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdemonhunter = {r=unitframegradients["DEMONHUNTER"].r2,g= unitframegradients["DEMONHUNTER"].g2,b= unitframegradients["DEMONHUNTER"].b2,a= 1}
			local maxdemonhunterAbg = {r=unitframegradients["DEMONHUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdemonhunterbg = {r=unitframegradients["DEMONHUNTER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxdemonhunterAinv = {r=unitframegradients["DEMONHUNTER"].r1,g= unitframegradients["DEMONHUNTER"].g1,b= unitframegradients["DEMONHUNTER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdemonhunterinv = {r=unitframegradients["DEMONHUNTER"].r1,g= unitframegradients["DEMONHUNTER"].g1,b= unitframegradients["DEMONHUNTER"].b1,a= 1}
			local maxdemonhunterAbginv = {r=unitframegradients["DEMONHUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxdemonhunterbginv = {r=unitframegradients["DEMONHUNTER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["DEMONHUNTER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["DEMONHUNTER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minevokerAinv = {r=unitframegradients["EVOKER"].r2,g= unitframegradients["EVOKER"].g2,b= unitframegradients["EVOKER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minevokerinv = {r=unitframegradients["EVOKER"].r2,g= unitframegradients["EVOKER"].g2,b= unitframegradients["EVOKER"].b2,a= 1}
			local minevokerAbginv = {r=unitframegradients["EVOKER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minevokerbginv = {r=unitframegradients["EVOKER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minevokerA = {r=unitframegradients["EVOKER"].r1,g= unitframegradients["EVOKER"].g1,b= unitframegradients["EVOKER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minevoker = {r=unitframegradients["EVOKER"].r1,g= unitframegradients["EVOKER"].g1,b= unitframegradients["EVOKER"].b1,a= 1}
			local minevokerAbg = {r=unitframegradients["EVOKER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minevokerbg = {r=unitframegradients["EVOKER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxevokerA = {r=unitframegradients["EVOKER"].r2,g= unitframegradients["EVOKER"].g2,b= unitframegradients["EVOKER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxevoker = {r=unitframegradients["EVOKER"].r2,g= unitframegradients["EVOKER"].g2,b= unitframegradients["EVOKER"].b2,a= 1}
			local maxevokerAbg = {r=unitframegradients["EVOKER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxevokerbg = {r=unitframegradients["EVOKER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxevokerAinv = {r=unitframegradients["EVOKER"].r1,g= unitframegradients["EVOKER"].g1,b= unitframegradients["EVOKER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxevokerinv = {r=unitframegradients["EVOKER"].r1,g= unitframegradients["EVOKER"].g1,b= unitframegradients["EVOKER"].b1,a= 1}
			local maxevokerAbginv = {r=unitframegradients["EVOKER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxevokerbginv = {r=unitframegradients["EVOKER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["EVOKER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["EVOKER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpcfriendlyAinv = {r=unitframegradients["NPCFRIENDLY"].r2,g= unitframegradients["NPCFRIENDLY"].g2,b= unitframegradients["NPCFRIENDLY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcfriendlyinv = {r=unitframegradients["NPCFRIENDLY"].r2,g= unitframegradients["NPCFRIENDLY"].g2,b= unitframegradients["NPCFRIENDLY"].b2,a= 1}
			local minnpcfriendlyAbginv = {r=unitframegradients["NPCFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcfriendlybginv = {r=unitframegradients["NPCFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpcfriendlyA = {r=unitframegradients["NPCFRIENDLY"].r1,g= unitframegradients["NPCFRIENDLY"].g1,b= unitframegradients["NPCFRIENDLY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcfriendly = {r=unitframegradients["NPCFRIENDLY"].r1,g= unitframegradients["NPCFRIENDLY"].g1,b= unitframegradients["NPCFRIENDLY"].b1,a= 1}
			local minnpcfriendlyAbg = {r=unitframegradients["NPCFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcfriendlybg = {r=unitframegradients["NPCFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpcfriendlyA = {r=unitframegradients["NPCFRIENDLY"].r2,g= unitframegradients["NPCFRIENDLY"].g2,b= unitframegradients["NPCFRIENDLY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcfriendly = {r=unitframegradients["NPCFRIENDLY"].r2,g= unitframegradients["NPCFRIENDLY"].g2,b= unitframegradients["NPCFRIENDLY"].b2,a= 1}
			local maxnpcfriendlyAbg = {r=unitframegradients["NPCFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcfriendlybg = {r=unitframegradients["NPCFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpcfriendlyAinv = {r=unitframegradients["NPCFRIENDLY"].r1,g= unitframegradients["NPCFRIENDLY"].g1,b= unitframegradients["NPCFRIENDLY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcfriendlyinv = {r=unitframegradients["NPCFRIENDLY"].r1,g= unitframegradients["NPCFRIENDLY"].g1,b= unitframegradients["NPCFRIENDLY"].b1,a= 1}
			local maxnpcfriendlyAbginv = {r=unitframegradients["NPCFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcfriendlybginv = {r=unitframegradients["NPCFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpcneutralAinv = {r=unitframegradients["NPCNEUTRAL"].r2,g= unitframegradients["NPCNEUTRAL"].g2,b= unitframegradients["NPCNEUTRAL"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcneutralinv = {r=unitframegradients["NPCNEUTRAL"].r2,g= unitframegradients["NPCNEUTRAL"].g2,b= unitframegradients["NPCNEUTRAL"].b2,a= 1}
			local minnpcneutralAbginv = {r=unitframegradients["NPCNEUTRAL"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcneutralbginv = {r=unitframegradients["NPCNEUTRAL"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpcneutralA = {r=unitframegradients["NPCNEUTRAL"].r1,g= unitframegradients["NPCNEUTRAL"].g1,b= unitframegradients["NPCNEUTRAL"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcneutral = {r=unitframegradients["NPCNEUTRAL"].r1,g= unitframegradients["NPCNEUTRAL"].g1,b= unitframegradients["NPCNEUTRAL"].b1,a= 1}
			local minnpcneutralAbg = {r=unitframegradients["NPCNEUTRAL"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcneutralbg = {r=unitframegradients["NPCNEUTRAL"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpcneutralA = {r=unitframegradients["NPCNEUTRAL"].r2,g= unitframegradients["NPCNEUTRAL"].g2,b= unitframegradients["NPCNEUTRAL"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcneutral = {r=unitframegradients["NPCNEUTRAL"].r2,g= unitframegradients["NPCNEUTRAL"].g2,b= unitframegradients["NPCNEUTRAL"].b2,a= 1}
			local maxnpcneutralAbg = {r=unitframegradients["NPCNEUTRAL"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcneutralbg = {r=unitframegradients["NPCNEUTRAL"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpcneutralAinv = {r=unitframegradients["NPCNEUTRAL"].r1,g= unitframegradients["NPCNEUTRAL"].g1,b= unitframegradients["NPCNEUTRAL"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcneutralinv = {r=unitframegradients["NPCNEUTRAL"].r1,g= unitframegradients["NPCNEUTRAL"].g1,b= unitframegradients["NPCNEUTRAL"].b1,a= 1}
			local maxnpcneutralAbginv = {r=unitframegradients["NPCNEUTRAL"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcneutralbginv = {r=unitframegradients["NPCNEUTRAL"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCNEUTRAL"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCNEUTRAL"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpcunfriendlyAinv = {r=unitframegradients["NPCUNFRIENDLY"].r2,g= unitframegradients["NPCUNFRIENDLY"].g2,b= unitframegradients["NPCUNFRIENDLY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcunfriendlyinv = {r=unitframegradients["NPCUNFRIENDLY"].r2,g= unitframegradients["NPCUNFRIENDLY"].g2,b= unitframegradients["NPCUNFRIENDLY"].b2,a= 1}
			local minnpcunfriendlyAbginv = {r=unitframegradients["NPCUNFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcunfriendlybginv = {r=unitframegradients["NPCUNFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpcunfriendlyA = {r=unitframegradients["NPCUNFRIENDLY"].r1,g= unitframegradients["NPCUNFRIENDLY"].g1,b= unitframegradients["NPCUNFRIENDLY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcunfriendly = {r=unitframegradients["NPCUNFRIENDLY"].r1,g= unitframegradients["NPCUNFRIENDLY"].g1,b= unitframegradients["NPCUNFRIENDLY"].b1,a= 1}
			local minnpcunfriendlyAbg = {r=unitframegradients["NPCUNFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpcunfriendlybg = {r=unitframegradients["NPCUNFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpcunfriendlyA = {r=unitframegradients["NPCUNFRIENDLY"].r2,g= unitframegradients["NPCUNFRIENDLY"].g2,b= unitframegradients["NPCUNFRIENDLY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcunfriendly = {r=unitframegradients["NPCUNFRIENDLY"].r2,g= unitframegradients["NPCUNFRIENDLY"].g2,b= unitframegradients["NPCUNFRIENDLY"].b2,a= 1}
			local maxnpcunfriendlyAbg = {r=unitframegradients["NPCUNFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcunfriendlybg = {r=unitframegradients["NPCUNFRIENDLY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpcunfriendlyAinv = {r=unitframegradients["NPCUNFRIENDLY"].r1,g= unitframegradients["NPCUNFRIENDLY"].g1,b= unitframegradients["NPCUNFRIENDLY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcunfriendlyinv = {r=unitframegradients["NPCUNFRIENDLY"].r1,g= unitframegradients["NPCUNFRIENDLY"].g1,b= unitframegradients["NPCUNFRIENDLY"].b1,a= 1}
			local maxnpcunfriendlyAbginv = {r=unitframegradients["NPCUNFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpcunfriendlybginv = {r=unitframegradients["NPCUNFRIENDLY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCUNFRIENDLY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCUNFRIENDLY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpchostileAinv = {r=unitframegradients["NPCHOSTILE"].r2,g= unitframegradients["NPCHOSTILE"].g2,b= unitframegradients["NPCHOSTILE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpchostileinv = {r=unitframegradients["NPCHOSTILE"].r2,g= unitframegradients["NPCHOSTILE"].g2,b= unitframegradients["NPCHOSTILE"].b2,a= 1}
			local minnpchostileAbginv = {r=unitframegradients["NPCHOSTILE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpchostilebginv = {r=unitframegradients["NPCHOSTILE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minnpchostileA = {r=unitframegradients["NPCHOSTILE"].r1,g= unitframegradients["NPCHOSTILE"].g1,b= unitframegradients["NPCHOSTILE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpchostile = {r=unitframegradients["NPCHOSTILE"].r1,g= unitframegradients["NPCHOSTILE"].g1,b= unitframegradients["NPCHOSTILE"].b1,a= 1}
			local minnpchostileAbg = {r=unitframegradients["NPCHOSTILE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minnpchostilebg = {r=unitframegradients["NPCHOSTILE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpchostileA = {r=unitframegradients["NPCHOSTILE"].r2,g= unitframegradients["NPCHOSTILE"].g2,b= unitframegradients["NPCHOSTILE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpchostile = {r=unitframegradients["NPCHOSTILE"].r2,g= unitframegradients["NPCHOSTILE"].g2,b= unitframegradients["NPCHOSTILE"].b2,a= 1}
			local maxnpchostileAbg = {r=unitframegradients["NPCHOSTILE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpchostilebg = {r=unitframegradients["NPCHOSTILE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxnpchostileAinv = {r=unitframegradients["NPCHOSTILE"].r1,g= unitframegradients["NPCHOSTILE"].g1,b= unitframegradients["NPCHOSTILE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpchostileinv = {r=unitframegradients["NPCHOSTILE"].r1,g= unitframegradients["NPCHOSTILE"].g1,b= unitframegradients["NPCHOSTILE"].b1,a= 1}
			local maxnpchostileAbginv = {r=unitframegradients["NPCHOSTILE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxnpchostilebginv = {r=unitframegradients["NPCHOSTILE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["NPCHOSTILE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["NPCHOSTILE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mintappedAinv = {r=unitframegradients["TAPPED"].r2,g= unitframegradients["TAPPED"].g2,b= unitframegradients["TAPPED"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mintappedinv = {r=unitframegradients["TAPPED"].r2,g= unitframegradients["TAPPED"].g2,b= unitframegradients["TAPPED"].b2,a= 1}
			local mintappedAbginv = {r=unitframegradients["TAPPED"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mintappedbginv = {r=unitframegradients["TAPPED"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mintappedA = {r=unitframegradients["TAPPED"].r1,g= unitframegradients["TAPPED"].g1,b= unitframegradients["TAPPED"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mintapped = {r=unitframegradients["TAPPED"].r1,g= unitframegradients["TAPPED"].g1,b= unitframegradients["TAPPED"].b1,a= 1}
			local mintappedAbg = {r=unitframegradients["TAPPED"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mintappedbg = {r=unitframegradients["TAPPED"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxtappedA = {r=unitframegradients["TAPPED"].r2,g= unitframegradients["TAPPED"].g2,b= unitframegradients["TAPPED"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxtapped = {r=unitframegradients["TAPPED"].r2,g= unitframegradients["TAPPED"].g2,b= unitframegradients["TAPPED"].b2,a= 1}
			local maxtappedAbg = {r=unitframegradients["TAPPED"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxtappedbg = {r=unitframegradients["TAPPED"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxtappedAinv = {r=unitframegradients["TAPPED"].r1,g= unitframegradients["TAPPED"].g1,b= unitframegradients["TAPPED"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxtappedinv = {r=unitframegradients["TAPPED"].r1,g= unitframegradients["TAPPED"].g1,b= unitframegradients["TAPPED"].b1,a= 1}
			local maxtappedAbginv = {r=unitframegradients["TAPPED"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxtappedbginv = {r=unitframegradients["TAPPED"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["TAPPED"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["TAPPED"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mingoodthreatAinv = {r=unitframegradients["GOODTHREAT"].r2,g= unitframegradients["GOODTHREAT"].g2,b= unitframegradients["GOODTHREAT"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreatinv = {r=unitframegradients["GOODTHREAT"].r2,g= unitframegradients["GOODTHREAT"].g2,b= unitframegradients["GOODTHREAT"].b2,a= 1}
			local mingoodthreatAbginv = {r=unitframegradients["GOODTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreatbginv = {r=unitframegradients["GOODTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mingoodthreatA = {r=unitframegradients["GOODTHREAT"].r1,g= unitframegradients["GOODTHREAT"].g1,b= unitframegradients["GOODTHREAT"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreat = {r=unitframegradients["GOODTHREAT"].r1,g= unitframegradients["GOODTHREAT"].g1,b= unitframegradients["GOODTHREAT"].b1,a= 1}
			local mingoodthreatAbg = {r=unitframegradients["GOODTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreatbg = {r=unitframegradients["GOODTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxgoodthreatA = {r=unitframegradients["GOODTHREAT"].r2,g= unitframegradients["GOODTHREAT"].g2,b= unitframegradients["GOODTHREAT"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreat = {r=unitframegradients["GOODTHREAT"].r2,g= unitframegradients["GOODTHREAT"].g2,b= unitframegradients["GOODTHREAT"].b2,a= 1}
			local maxgoodthreatAbg = {r=unitframegradients["GOODTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreatbg = {r=unitframegradients["GOODTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxgoodthreatAinv = {r=unitframegradients["GOODTHREAT"].r1,g= unitframegradients["GOODTHREAT"].g1,b= unitframegradients["GOODTHREAT"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreatinv = {r=unitframegradients["GOODTHREAT"].r1,g= unitframegradients["GOODTHREAT"].g1,b= unitframegradients["GOODTHREAT"].b1,a= 1}
			local maxgoodthreatAbginv = {r=unitframegradients["GOODTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreatbginv = {r=unitframegradients["GOODTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minbadthreatAinv = {r=unitframegradients["BADTHREAT"].r2,g= unitframegradients["BADTHREAT"].g2,b= unitframegradients["BADTHREAT"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreatinv = {r=unitframegradients["BADTHREAT"].r2,g= unitframegradients["BADTHREAT"].g2,b= unitframegradients["BADTHREAT"].b2,a= 1}
			local minbadthreatAbginv = {r=unitframegradients["BADTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreatbginv = {r=unitframegradients["BADTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minbadthreatA = {r=unitframegradients["BADTHREAT"].r1,g= unitframegradients["BADTHREAT"].g1,b= unitframegradients["BADTHREAT"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreat = {r=unitframegradients["BADTHREAT"].r1,g= unitframegradients["BADTHREAT"].g1,b= unitframegradients["BADTHREAT"].b1,a= 1}
			local minbadthreatAbg = {r=unitframegradients["BADTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreatbg = {r=unitframegradients["BADTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxbadthreatA = {r=unitframegradients["BADTHREAT"].r2,g= unitframegradients["BADTHREAT"].g2,b= unitframegradients["BADTHREAT"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreat = {r=unitframegradients["BADTHREAT"].r2,g= unitframegradients["BADTHREAT"].g2,b= unitframegradients["BADTHREAT"].b2,a= 1}
			local maxbadthreatAbg = {r=unitframegradients["BADTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreatbg = {r=unitframegradients["BADTHREAT"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxbadthreatAinv = {r=unitframegradients["BADTHREAT"].r1,g= unitframegradients["BADTHREAT"].g1,b= unitframegradients["BADTHREAT"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreatinv = {r=unitframegradients["BADTHREAT"].r1,g= unitframegradients["BADTHREAT"].g1,b= unitframegradients["BADTHREAT"].b1,a= 1}
			local maxbadthreatAbginv = {r=unitframegradients["BADTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreatbginv = {r=unitframegradients["BADTHREAT"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREAT"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREAT"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mingoodthreattransitionAinv = {r=unitframegradients["GOODTHREATTRANSITION"].r2,g= unitframegradients["GOODTHREATTRANSITION"].g2,b= unitframegradients["GOODTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreattransitioninv = {r=unitframegradients["GOODTHREATTRANSITION"].r2,g= unitframegradients["GOODTHREATTRANSITION"].g2,b= unitframegradients["GOODTHREATTRANSITION"].b2,a= 1}
			local mingoodthreattransitionAbginv = {r=unitframegradients["GOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreattransitionbginv = {r=unitframegradients["GOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mingoodthreattransitionA = {r=unitframegradients["GOODTHREATTRANSITION"].r1,g= unitframegradients["GOODTHREATTRANSITION"].g1,b= unitframegradients["GOODTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreattransition = {r=unitframegradients["GOODTHREATTRANSITION"].r1,g= unitframegradients["GOODTHREATTRANSITION"].g1,b= unitframegradients["GOODTHREATTRANSITION"].b1,a= 1}
			local mingoodthreattransitionAbg = {r=unitframegradients["GOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mingoodthreattransitionbg = {r=unitframegradients["GOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxgoodthreattransitionA = {r=unitframegradients["GOODTHREATTRANSITION"].r2,g= unitframegradients["GOODTHREATTRANSITION"].g2,b= unitframegradients["GOODTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreattransition = {r=unitframegradients["GOODTHREATTRANSITION"].r2,g= unitframegradients["GOODTHREATTRANSITION"].g2,b= unitframegradients["GOODTHREATTRANSITION"].b2,a= 1}
			local maxgoodthreattransitionAbg = {r=unitframegradients["GOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreattransitionbg = {r=unitframegradients["GOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxgoodthreattransitionAinv = {r=unitframegradients["GOODTHREATTRANSITION"].r1,g= unitframegradients["GOODTHREATTRANSITION"].g1,b= unitframegradients["GOODTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreattransitioninv = {r=unitframegradients["GOODTHREATTRANSITION"].r1,g= unitframegradients["GOODTHREATTRANSITION"].g1,b= unitframegradients["GOODTHREATTRANSITION"].b1,a= 1}
			local maxgoodthreattransitionAbginv = {r=unitframegradients["GOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxgoodthreattransitionbginv = {r=unitframegradients["GOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["GOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["GOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minbadthreattransitionAinv = {r=unitframegradients["BADTHREATTRANSITION"].r2,g= unitframegradients["BADTHREATTRANSITION"].g2,b= unitframegradients["BADTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreattransitioninv = {r=unitframegradients["BADTHREATTRANSITION"].r2,g= unitframegradients["BADTHREATTRANSITION"].g2,b= unitframegradients["BADTHREATTRANSITION"].b2,a= 1}
			local minbadthreattransitionAbginv = {r=unitframegradients["BADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreattransitionbginv = {r=unitframegradients["BADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minbadthreattransitionA = {r=unitframegradients["BADTHREATTRANSITION"].r1,g= unitframegradients["BADTHREATTRANSITION"].g1,b= unitframegradients["BADTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreattransition = {r=unitframegradients["BADTHREATTRANSITION"].r1,g= unitframegradients["BADTHREATTRANSITION"].g1,b= unitframegradients["BADTHREATTRANSITION"].b1,a= 1}
			local minbadthreattransitionAbg = {r=unitframegradients["BADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minbadthreattransitionbg = {r=unitframegradients["BADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxbadthreattransitionA = {r=unitframegradients["BADTHREATTRANSITION"].r2,g= unitframegradients["BADTHREATTRANSITION"].g2,b= unitframegradients["BADTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreattransition = {r=unitframegradients["BADTHREATTRANSITION"].r2,g= unitframegradients["BADTHREATTRANSITION"].g2,b= unitframegradients["BADTHREATTRANSITION"].b2,a= 1}
			local maxbadthreattransitionAbg = {r=unitframegradients["BADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreattransitionbg = {r=unitframegradients["BADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxbadthreattransitionAinv = {r=unitframegradients["BADTHREATTRANSITION"].r1,g= unitframegradients["BADTHREATTRANSITION"].g1,b= unitframegradients["BADTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreattransitioninv = {r=unitframegradients["BADTHREATTRANSITION"].r1,g= unitframegradients["BADTHREATTRANSITION"].g1,b= unitframegradients["BADTHREATTRANSITION"].b1,a= 1}
			local maxbadthreattransitionAbginv = {r=unitframegradients["BADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxbadthreattransitionbginv = {r=unitframegradients["BADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["BADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["BADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minofftankAinv = {r=unitframegradients["OFFTANK"].r2,g= unitframegradients["OFFTANK"].g2,b= unitframegradients["OFFTANK"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankinv = {r=unitframegradients["OFFTANK"].r2,g= unitframegradients["OFFTANK"].g2,b= unitframegradients["OFFTANK"].b2,a= 1}
			local minofftankAbginv = {r=unitframegradients["OFFTANK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankbginv = {r=unitframegradients["OFFTANK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minofftankA = {r=unitframegradients["OFFTANK"].r1,g= unitframegradients["OFFTANK"].g1,b= unitframegradients["OFFTANK"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftank = {r=unitframegradients["OFFTANK"].r1,g= unitframegradients["OFFTANK"].g1,b= unitframegradients["OFFTANK"].b1,a= 1}
			local minofftankAbg = {r=unitframegradients["OFFTANK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankbg = {r=unitframegradients["OFFTANK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxofftankA = {r=unitframegradients["OFFTANK"].r2,g= unitframegradients["OFFTANK"].g2,b= unitframegradients["OFFTANK"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftank = {r=unitframegradients["OFFTANK"].r2,g= unitframegradients["OFFTANK"].g2,b= unitframegradients["OFFTANK"].b2,a= 1}
			local maxofftankAbg = {r=unitframegradients["OFFTANK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankbg = {r=unitframegradients["OFFTANK"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxofftankAinv = {r=unitframegradients["OFFTANK"].r1,g= unitframegradients["OFFTANK"].g1,b= unitframegradients["OFFTANK"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankinv = {r=unitframegradients["OFFTANK"].r1,g= unitframegradients["OFFTANK"].g1,b= unitframegradients["OFFTANK"].b1,a= 1}
			local maxofftankAbginv = {r=unitframegradients["OFFTANK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankbginv = {r=unitframegradients["OFFTANK"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANK"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANK"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minofftankbadthreattransitionAinv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankbadthreattransitioninv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2,a= 1}
			local minofftankbadthreattransitionAbginv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankbadthreattransitionbginv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minofftankbadthreattransitionA = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankbadthreattransition = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1,a= 1}
			local minofftankbadthreattransitionAbg = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankbadthreattransitionbg = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxofftankbadthreattransitionA = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankbadthreattransition = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2,a= 1}
			local maxofftankbadthreattransitionAbg = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankbadthreattransitionbg = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxofftankbadthreattransitionAinv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankbadthreattransitioninv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1,a= 1}
			local maxofftankbadthreattransitionAbginv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankbadthreattransitionbginv = {r=unitframegradients["OFFTANKBADTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKBADTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKBADTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minofftankgoodthreattransitionAinv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankgoodthreattransitioninv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2,a= 1}
			local minofftankgoodthreattransitionAbginv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankgoodthreattransitionbginv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minofftankgoodthreattransitionA = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankgoodthreattransition = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1,a= 1}
			local minofftankgoodthreattransitionAbg = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minofftankgoodthreattransitionbg = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxofftankgoodthreattransitionA = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankgoodthreattransition = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2,a= 1}
			local maxofftankgoodthreattransitionAbg = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankgoodthreattransitionbg = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxofftankgoodthreattransitionAinv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankgoodthreattransitioninv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1,a= 1}
			local maxofftankgoodthreattransitionAbginv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxofftankgoodthreattransitionbginv = {r=unitframegradients["OFFTANKGOODTHREATTRANSITION"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["OFFTANKGOODTHREATTRANSITION"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["OFFTANKGOODTHREATTRANSITION"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmanaAinv = {r=unitframegradients["MANA"].r2,g= unitframegradients["MANA"].g2,b= unitframegradients["MANA"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmanainv = {r=unitframegradients["MANA"].r2,g= unitframegradients["MANA"].g2,b= unitframegradients["MANA"].b2,a= 1}
			local minmanaAbginv = {r=unitframegradients["MANA"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmanabginv = {r=unitframegradients["MANA"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmanaA = {r=unitframegradients["MANA"].r1,g= unitframegradients["MANA"].g1,b= unitframegradients["MANA"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmana = {r=unitframegradients["MANA"].r1,g= unitframegradients["MANA"].g1,b= unitframegradients["MANA"].b1,a= 1}
			local minmanaAbg = {r=unitframegradients["MANA"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmanabg = {r=unitframegradients["MANA"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmanaA = {r=unitframegradients["MANA"].r2,g= unitframegradients["MANA"].g2,b= unitframegradients["MANA"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmana = {r=unitframegradients["MANA"].r2,g= unitframegradients["MANA"].g2,b= unitframegradients["MANA"].b2,a= 1}
			local maxmanaAbg = {r=unitframegradients["MANA"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmanabg = {r=unitframegradients["MANA"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmanaAinv = {r=unitframegradients["MANA"].r1,g= unitframegradients["MANA"].g1,b= unitframegradients["MANA"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmanainv = {r=unitframegradients["MANA"].r1,g= unitframegradients["MANA"].g1,b= unitframegradients["MANA"].b1,a= 1}
			local maxmanaAbginv = {r=unitframegradients["MANA"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmanabginv = {r=unitframegradients["MANA"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MANA"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MANA"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minrageAinv = {r=unitframegradients["RAGE"].r2,g= unitframegradients["RAGE"].g2,b= unitframegradients["RAGE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrageinv = {r=unitframegradients["RAGE"].r2,g= unitframegradients["RAGE"].g2,b= unitframegradients["RAGE"].b2,a= 1}
			local minrageAbginv = {r=unitframegradients["RAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minragebginv = {r=unitframegradients["RAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minrageA = {r=unitframegradients["RAGE"].r1,g= unitframegradients["RAGE"].g1,b= unitframegradients["RAGE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrage = {r=unitframegradients["RAGE"].r1,g= unitframegradients["RAGE"].g1,b= unitframegradients["RAGE"].b1,a= 1}
			local minrageAbg = {r=unitframegradients["RAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minragebg = {r=unitframegradients["RAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxrageA = {r=unitframegradients["RAGE"].r2,g= unitframegradients["RAGE"].g2,b= unitframegradients["RAGE"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrage = {r=unitframegradients["RAGE"].r2,g= unitframegradients["RAGE"].g2,b= unitframegradients["RAGE"].b2,a= 1}
			local maxrageAbg = {r=unitframegradients["RAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxragebg = {r=unitframegradients["RAGE"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxrageAinv = {r=unitframegradients["RAGE"].r1,g= unitframegradients["RAGE"].g1,b= unitframegradients["RAGE"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrageinv = {r=unitframegradients["RAGE"].r1,g= unitframegradients["RAGE"].g1,b= unitframegradients["RAGE"].b1,a= 1}
			local maxrageAbginv = {r=unitframegradients["RAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxragebginv = {r=unitframegradients["RAGE"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RAGE"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RAGE"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minfocusAinv = {r=unitframegradients["FOCUS"].r2,g= unitframegradients["FOCUS"].g2,b= unitframegradients["FOCUS"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfocusinv = {r=unitframegradients["FOCUS"].r2,g= unitframegradients["FOCUS"].g2,b= unitframegradients["FOCUS"].b2,a= 1}
			local minfocusAbginv = {r=unitframegradients["FOCUS"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfocusbginv = {r=unitframegradients["FOCUS"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minfocusA = {r=unitframegradients["FOCUS"].r1,g= unitframegradients["FOCUS"].g1,b= unitframegradients["FOCUS"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfocus = {r=unitframegradients["FOCUS"].r1,g= unitframegradients["FOCUS"].g1,b= unitframegradients["FOCUS"].b1,a= 1}
			local minfocusAbg = {r=unitframegradients["FOCUS"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfocusbg = {r=unitframegradients["FOCUS"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxfocusA = {r=unitframegradients["FOCUS"].r2,g= unitframegradients["FOCUS"].g2,b= unitframegradients["FOCUS"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfocus = {r=unitframegradients["FOCUS"].r2,g= unitframegradients["FOCUS"].g2,b= unitframegradients["FOCUS"].b2,a= 1}
			local maxfocusAbg = {r=unitframegradients["FOCUS"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfocusbg = {r=unitframegradients["FOCUS"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxfocusAinv = {r=unitframegradients["FOCUS"].r1,g= unitframegradients["FOCUS"].g1,b= unitframegradients["FOCUS"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfocusinv = {r=unitframegradients["FOCUS"].r1,g= unitframegradients["FOCUS"].g1,b= unitframegradients["FOCUS"].b1,a= 1}
			local maxfocusAbginv = {r=unitframegradients["FOCUS"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfocusbginv = {r=unitframegradients["FOCUS"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FOCUS"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FOCUS"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minenergyAinv = {r=unitframegradients["ENERGY"].r2,g= unitframegradients["ENERGY"].g2,b= unitframegradients["ENERGY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minenergyinv = {r=unitframegradients["ENERGY"].r2,g= unitframegradients["ENERGY"].g2,b= unitframegradients["ENERGY"].b2,a= 1}
			local minenergyAbginv = {r=unitframegradients["ENERGY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minenergybginv = {r=unitframegradients["ENERGY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minenergyA = {r=unitframegradients["ENERGY"].r1,g= unitframegradients["ENERGY"].g1,b= unitframegradients["ENERGY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minenergy = {r=unitframegradients["ENERGY"].r1,g= unitframegradients["ENERGY"].g1,b= unitframegradients["ENERGY"].b1,a= 1}
			local minenergyAbg = {r=unitframegradients["ENERGY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minenergybg = {r=unitframegradients["ENERGY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxenergyA = {r=unitframegradients["ENERGY"].r2,g= unitframegradients["ENERGY"].g2,b= unitframegradients["ENERGY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxenergy = {r=unitframegradients["ENERGY"].r2,g= unitframegradients["ENERGY"].g2,b= unitframegradients["ENERGY"].b2,a= 1}
			local maxenergyAbg = {r=unitframegradients["ENERGY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxenergybg = {r=unitframegradients["ENERGY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxenergyAinv = {r=unitframegradients["ENERGY"].r1,g= unitframegradients["ENERGY"].g1,b= unitframegradients["ENERGY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxenergyinv = {r=unitframegradients["ENERGY"].r1,g= unitframegradients["ENERGY"].g1,b= unitframegradients["ENERGY"].b1,a= 1}
			local maxenergyAbginv = {r=unitframegradients["ENERGY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxenergybginv = {r=unitframegradients["ENERGY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ENERGY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ENERGY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minrunic_powerAinv = {r=unitframegradients["RUNIC_POWER"].r2,g= unitframegradients["RUNIC_POWER"].g2,b= unitframegradients["RUNIC_POWER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrunic_powerinv = {r=unitframegradients["RUNIC_POWER"].r2,g= unitframegradients["RUNIC_POWER"].g2,b= unitframegradients["RUNIC_POWER"].b2,a= 1}
			local minrunic_powerAbginv = {r=unitframegradients["RUNIC_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrunic_powerbginv = {r=unitframegradients["RUNIC_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minrunic_powerA = {r=unitframegradients["RUNIC_POWER"].r1,g= unitframegradients["RUNIC_POWER"].g1,b= unitframegradients["RUNIC_POWER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrunic_power = {r=unitframegradients["RUNIC_POWER"].r1,g= unitframegradients["RUNIC_POWER"].g1,b= unitframegradients["RUNIC_POWER"].b1,a= 1}
			local minrunic_powerAbg = {r=unitframegradients["RUNIC_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minrunic_powerbg = {r=unitframegradients["RUNIC_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxrunic_powerA = {r=unitframegradients["RUNIC_POWER"].r2,g= unitframegradients["RUNIC_POWER"].g2,b= unitframegradients["RUNIC_POWER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrunic_power = {r=unitframegradients["RUNIC_POWER"].r2,g= unitframegradients["RUNIC_POWER"].g2,b= unitframegradients["RUNIC_POWER"].b2,a= 1}
			local maxrunic_powerAbg = {r=unitframegradients["RUNIC_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrunic_powerbg = {r=unitframegradients["RUNIC_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxrunic_powerAinv = {r=unitframegradients["RUNIC_POWER"].r1,g= unitframegradients["RUNIC_POWER"].g1,b= unitframegradients["RUNIC_POWER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrunic_powerinv = {r=unitframegradients["RUNIC_POWER"].r1,g= unitframegradients["RUNIC_POWER"].g1,b= unitframegradients["RUNIC_POWER"].b1,a= 1}
			local maxrunic_powerAbginv = {r=unitframegradients["RUNIC_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxrunic_powerbginv = {r=unitframegradients["RUNIC_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["RUNIC_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["RUNIC_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minlunar_powerAinv = {r=unitframegradients["LUNAR_POWER"].r2,g= unitframegradients["LUNAR_POWER"].g2,b= unitframegradients["LUNAR_POWER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minlunar_powerinv = {r=unitframegradients["LUNAR_POWER"].r2,g= unitframegradients["LUNAR_POWER"].g2,b= unitframegradients["LUNAR_POWER"].b2,a= 1}
			local minlunar_powerAbginv = {r=unitframegradients["LUNAR_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minlunar_powerbginv = {r=unitframegradients["LUNAR_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minlunar_powerA = {r=unitframegradients["LUNAR_POWER"].r1,g= unitframegradients["LUNAR_POWER"].g1,b= unitframegradients["LUNAR_POWER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minlunar_power = {r=unitframegradients["LUNAR_POWER"].r1,g= unitframegradients["LUNAR_POWER"].g1,b= unitframegradients["LUNAR_POWER"].b1,a= 1}
			local minlunar_powerAbg = {r=unitframegradients["LUNAR_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minlunar_powerbg = {r=unitframegradients["LUNAR_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxlunar_powerA = {r=unitframegradients["LUNAR_POWER"].r2,g= unitframegradients["LUNAR_POWER"].g2,b= unitframegradients["LUNAR_POWER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxlunar_power = {r=unitframegradients["LUNAR_POWER"].r2,g= unitframegradients["LUNAR_POWER"].g2,b= unitframegradients["LUNAR_POWER"].b2,a= 1}
			local maxlunar_powerAbg = {r=unitframegradients["LUNAR_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxlunar_powerbg = {r=unitframegradients["LUNAR_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxlunar_powerAinv = {r=unitframegradients["LUNAR_POWER"].r1,g= unitframegradients["LUNAR_POWER"].g1,b= unitframegradients["LUNAR_POWER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxlunar_powerinv = {r=unitframegradients["LUNAR_POWER"].r1,g= unitframegradients["LUNAR_POWER"].g1,b= unitframegradients["LUNAR_POWER"].b1,a= 1}
			local maxlunar_powerAbginv = {r=unitframegradients["LUNAR_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxlunar_powerbginv = {r=unitframegradients["LUNAR_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["LUNAR_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["LUNAR_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minalt_powerAinv = {r=unitframegradients["ALT_POWER"].r2,g= unitframegradients["ALT_POWER"].g2,b= unitframegradients["ALT_POWER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minalt_powerinv = {r=unitframegradients["ALT_POWER"].r2,g= unitframegradients["ALT_POWER"].g2,b= unitframegradients["ALT_POWER"].b2,a= 1}
			local minalt_powerAbginv = {r=unitframegradients["ALT_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minalt_powerbginv = {r=unitframegradients["ALT_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minalt_powerA = {r=unitframegradients["ALT_POWER"].r1,g= unitframegradients["ALT_POWER"].g1,b= unitframegradients["ALT_POWER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minalt_power = {r=unitframegradients["ALT_POWER"].r1,g= unitframegradients["ALT_POWER"].g1,b= unitframegradients["ALT_POWER"].b1,a= 1}
			local minalt_powerAbg = {r=unitframegradients["ALT_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minalt_powerbg = {r=unitframegradients["ALT_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxalt_powerA = {r=unitframegradients["ALT_POWER"].r2,g= unitframegradients["ALT_POWER"].g2,b= unitframegradients["ALT_POWER"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxalt_power = {r=unitframegradients["ALT_POWER"].r2,g= unitframegradients["ALT_POWER"].g2,b= unitframegradients["ALT_POWER"].b2,a= 1}
			local maxalt_powerAbg = {r=unitframegradients["ALT_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxalt_powerbg = {r=unitframegradients["ALT_POWER"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxalt_powerAinv = {r=unitframegradients["ALT_POWER"].r1,g= unitframegradients["ALT_POWER"].g1,b= unitframegradients["ALT_POWER"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxalt_powerinv = {r=unitframegradients["ALT_POWER"].r1,g= unitframegradients["ALT_POWER"].g1,b= unitframegradients["ALT_POWER"].b1,a= 1}
			local maxalt_powerAbginv = {r=unitframegradients["ALT_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxalt_powerbginv = {r=unitframegradients["ALT_POWER"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["ALT_POWER"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["ALT_POWER"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmaelstromAinv = {r=unitframegradients["MAELSTROM"].r2,g= unitframegradients["MAELSTROM"].g2,b= unitframegradients["MAELSTROM"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmaelstrominv = {r=unitframegradients["MAELSTROM"].r2,g= unitframegradients["MAELSTROM"].g2,b= unitframegradients["MAELSTROM"].b2,a= 1}
			local minmaelstromAbginv = {r=unitframegradients["MAELSTROM"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmaelstrombginv = {r=unitframegradients["MAELSTROM"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minmaelstromA = {r=unitframegradients["MAELSTROM"].r1,g= unitframegradients["MAELSTROM"].g1,b= unitframegradients["MAELSTROM"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmaelstrom = {r=unitframegradients["MAELSTROM"].r1,g= unitframegradients["MAELSTROM"].g1,b= unitframegradients["MAELSTROM"].b1,a= 1}
			local minmaelstromAbg = {r=unitframegradients["MAELSTROM"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minmaelstrombg = {r=unitframegradients["MAELSTROM"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmaelstromA = {r=unitframegradients["MAELSTROM"].r2,g= unitframegradients["MAELSTROM"].g2,b= unitframegradients["MAELSTROM"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmaelstrom = {r=unitframegradients["MAELSTROM"].r2,g= unitframegradients["MAELSTROM"].g2,b= unitframegradients["MAELSTROM"].b2,a= 1}
			local maxmaelstromAbg = {r=unitframegradients["MAELSTROM"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmaelstrombg = {r=unitframegradients["MAELSTROM"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxmaelstromAinv = {r=unitframegradients["MAELSTROM"].r1,g= unitframegradients["MAELSTROM"].g1,b= unitframegradients["MAELSTROM"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmaelstrominv = {r=unitframegradients["MAELSTROM"].r1,g= unitframegradients["MAELSTROM"].g1,b= unitframegradients["MAELSTROM"].b1,a= 1}
			local maxmaelstromAbginv = {r=unitframegradients["MAELSTROM"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxmaelstrombginv = {r=unitframegradients["MAELSTROM"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["MAELSTROM"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["MAELSTROM"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mininsanityAinv = {r=unitframegradients["INSANITY"].r2,g= unitframegradients["INSANITY"].g2,b= unitframegradients["INSANITY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mininsanityinv = {r=unitframegradients["INSANITY"].r2,g= unitframegradients["INSANITY"].g2,b= unitframegradients["INSANITY"].b2,a= 1}
			local mininsanityAbginv = {r=unitframegradients["INSANITY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mininsanitybginv = {r=unitframegradients["INSANITY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local mininsanityA = {r=unitframegradients["INSANITY"].r1,g= unitframegradients["INSANITY"].g1,b= unitframegradients["INSANITY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mininsanity = {r=unitframegradients["INSANITY"].r1,g= unitframegradients["INSANITY"].g1,b= unitframegradients["INSANITY"].b1,a= 1}
			local mininsanityAbg = {r=unitframegradients["INSANITY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local mininsanitybg = {r=unitframegradients["INSANITY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxinsanityA = {r=unitframegradients["INSANITY"].r2,g= unitframegradients["INSANITY"].g2,b= unitframegradients["INSANITY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxinsanity = {r=unitframegradients["INSANITY"].r2,g= unitframegradients["INSANITY"].g2,b= unitframegradients["INSANITY"].b2,a= 1}
			local maxinsanityAbg = {r=unitframegradients["INSANITY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxinsanitybg = {r=unitframegradients["INSANITY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxinsanityAinv = {r=unitframegradients["INSANITY"].r1,g= unitframegradients["INSANITY"].g1,b= unitframegradients["INSANITY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxinsanityinv = {r=unitframegradients["INSANITY"].r1,g= unitframegradients["INSANITY"].g1,b= unitframegradients["INSANITY"].b1,a= 1}
			local maxinsanityAbginv = {r=unitframegradients["INSANITY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxinsanitybginv = {r=unitframegradients["INSANITY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["INSANITY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["INSANITY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minfuryAinv = {r=unitframegradients["FURY"].r2,g= unitframegradients["FURY"].g2,b= unitframegradients["FURY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfuryinv = {r=unitframegradients["FURY"].r2,g= unitframegradients["FURY"].g2,b= unitframegradients["FURY"].b2,a= 1}
			local minfuryAbginv = {r=unitframegradients["FURY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfurybginv = {r=unitframegradients["FURY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minfuryA = {r=unitframegradients["FURY"].r1,g= unitframegradients["FURY"].g1,b= unitframegradients["FURY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfury = {r=unitframegradients["FURY"].r1,g= unitframegradients["FURY"].g1,b= unitframegradients["FURY"].b1,a= 1}
			local minfuryAbg = {r=unitframegradients["FURY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minfurybg = {r=unitframegradients["FURY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxfuryA = {r=unitframegradients["FURY"].r2,g= unitframegradients["FURY"].g2,b= unitframegradients["FURY"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfury = {r=unitframegradients["FURY"].r2,g= unitframegradients["FURY"].g2,b= unitframegradients["FURY"].b2,a= 1}
			local maxfuryAbg = {r=unitframegradients["FURY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfurybg = {r=unitframegradients["FURY"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxfuryAinv = {r=unitframegradients["FURY"].r1,g= unitframegradients["FURY"].g1,b= unitframegradients["FURY"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfuryinv = {r=unitframegradients["FURY"].r1,g= unitframegradients["FURY"].g1,b= unitframegradients["FURY"].b1,a= 1}
			local maxfuryAbginv = {r=unitframegradients["FURY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxfurybginv = {r=unitframegradients["FURY"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["FURY"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["FURY"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minpainAinv = {r=unitframegradients["PAIN"].r2,g= unitframegradients["PAIN"].g2,b= unitframegradients["PAIN"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpaininv = {r=unitframegradients["PAIN"].r2,g= unitframegradients["PAIN"].g2,b= unitframegradients["PAIN"].b2,a= 1}
			local minpainAbginv = {r=unitframegradients["PAIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpainbginv = {r=unitframegradients["PAIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local minpainA = {r=unitframegradients["PAIN"].r1,g= unitframegradients["PAIN"].g1,b= unitframegradients["PAIN"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpain = {r=unitframegradients["PAIN"].r1,g= unitframegradients["PAIN"].g1,b= unitframegradients["PAIN"].b1,a= 1}
			local minpainAbg = {r=unitframegradients["PAIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local minpainbg = {r=unitframegradients["PAIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxpainA = {r=unitframegradients["PAIN"].r2,g= unitframegradients["PAIN"].g2,b= unitframegradients["PAIN"].b2 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpain = {r=unitframegradients["PAIN"].r2,g= unitframegradients["PAIN"].g2,b= unitframegradients["PAIN"].b2,a= 1}
			local maxpainAbg = {r=unitframegradients["PAIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpainbg = {r=unitframegradients["PAIN"].r2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b2 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}
			local maxpainAinv = {r=unitframegradients["PAIN"].r1,g= unitframegradients["PAIN"].g1,b= unitframegradients["PAIN"].b1 ,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpaininv = {r=unitframegradients["PAIN"].r1,g= unitframegradients["PAIN"].g1,b= unitframegradients["PAIN"].b1,a= 1}
			local maxpainAbginv = {r=unitframegradients["PAIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
			local maxpainbginv = {r=unitframegradients["PAIN"].r1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,g= unitframegradients["PAIN"].g1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,b= unitframegradients["PAIN"].b1 - E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade,a= 1}



			unitframegradients = {
				["WARRIOR"] = {r1 = minwarriorA, g1 = maxwarriorA},
				["PALADIN"] = {r1 = minpaladinA, g1 = maxpaladinA},
				["HUNTER"] = {r1 = minhunterA, g1 = maxhunterA},
				["MONK"] = {r1 = minmonkA, g1 = maxmonkA},
				["ROGUE"] = {r1 = minrogueA, g1 = maxrogueA},
				["PRIEST"] = {r1 = minpriestA, g1 = maxpriestA},
				["DEATHKNIGHT"] = {r1 = mindeathknightA, g1 = maxdeathknightA},
				["SHAMAN"] = {r1 = minshamanA, g1 = maxshamanA},
				["MAGE"] = {r1 = minmageA, g1 = maxmageA},
				["WARLOCK"] = {r1 = minwarlockA, g1 = maxwarlockA},
				["DRUID"] = {r1 = mindruidA, g1 = maxdruidA},
				["DEMONHUNTER"] = {r1 = mindemonhunterA, g1 = maxdemonhunterA},
				["EVOKER"] = {r1 = minevokerA, g1 = maxevokerA},
				["NPCFRIENDLY"] = {r1 = minnpcfriendlyA, g1 = maxnpcfriendlyA},
				["NPCNEUTRAL"] = {r1 = minnpcneutralA, g1 = maxnpcneutralA},
				["NPCUNFRIENDLY"] = {r1 = minnpcunfriendlyA, g1 = maxnpcunfriendlyA},
				["NPCHOSTILE"] = {r1 = minnpchostileA, g1 = maxnpchostileA},
				["TAPPED"] = {r1 = mintappedA, g1 = maxtappedA},
				["GOODTHREAT"] = {r1 = mingoodthreatA, g1 = maxgoodthreatA},
				["BADTHREAT"] = {r1 = minbadthreatA, g1 = maxbadthreatA},
				["GOODTHREATTRANSITION"] = {r1 = mingoodthreattransitionA, g1 = maxgoodthreattransitionA},
				["BADTHREATTRANSITION"] = {r1 = minbadthreattransitionA, g1 = maxbadthreattransitionA},
				["OFFTANK"] = {r1 = minofftankA, g1 = maxofftankA},
				["OFFTANKBADTHREATTRANSITION"] = {r1 = minofftankbadthreattransitionA, g1 = maxofftankbadthreattransitionA},
				["OFFTANKGOODTHREATTRANSITION"] = {r1 = minofftankgoodthreattransitionA, g1 = maxofftankgoodthreattransitionA},
				["MANA"] = {r1 = minmanaA, g1 = maxmanaA},
				["RAGE"] = {r1 = minrageA, g1 = maxrageA},
				["FOCUS"] = {r1 = minfocusA, g1 = maxfocusA},
				["ENERGY"] = {r1 = minenergyA, g1 = maxenergyA},
				["RUNIC_POWER"] = {r1 = minrunic_powerA, g1 = maxrunic_powerA},
				["LUNAR_POWER"] = {r1 = minlunar_powerA, g1 = maxlunar_powerA},
				["ALT_POWER"] = {r1 = minalt_powerA, g1 = maxalt_powerA},
				["MAELSTROM"] = {r1 = minmaelstromA, g1 = maxmaelstromA},
				["INSANITY"] = {r1 = mininsanityA, g1 = maxinsanityA},
				["FURY"] = {r1 = minfuryA, g1 = maxfuryA},
				["PAIN"] = {r1 = minpainA, g1 = maxpainA},
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
	function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha, isBG)
		if E.Retail then
			if unitclass then
				if isBG then
					bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
				else
					bgfade = 0
				end
				if not unitframegradients[unitclass] then
					if invert then
						if alpha then
							return {r=unitframegradients["MANA"].r2 - bgfade,g= unitframegradients["MANA"].g2 - bgfade,b= unitframegradients["MANA"].b2 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=unitframegradients["MANA"].r1 - bgfade, g=unitframegradients["MANA"].g1 - bgfade, b=unitframegradients["MANA"].b1 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
						else
							return {r=unitframegradients["MANA"].r2 - bgfade,g= unitframegradients["MANA"].g2 - bgfade,b= unitframegradients["MANA"].b2 - bgfade,a= 1}, {r=unitframegradients["MANA"].r1 - bgfade, g=unitframegradients["MANA"].g1 - bgfade,b= unitframegradients["MANA"].b1 - bgfade, a=1}
						end
					else
						if alpha then
							return {r=unitframegradients["MANA"].r1 - bgfade,g= unitframegradients["MANA"].g1 - bgfade,b= unitframegradients["MANA"].b1 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=unitframegradients["MANA"].r2 - bgfade, g=unitframegradients["MANA"].g2 - bgfade,b= unitframegradients["MANA"].b2 - bgfade, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
						else
							return {r=unitframegradients["MANA"].r1 - bgfade,g= unitframegradients["MANA"].g1 - bgfade,b= unitframegradients["MANA"].b1 - bgfade,a= 1}, {r=unitframegradients["MANA"].r2 - bgfade, g=unitframegradients["MANA"].g2 - bgfade, b=unitframegradients["MANA"].b2 - bgfade,a= 1}
						end
					end
				else
					if invert then
						if alpha then
							return unitframegradients[unitclass].r1,unitframegradients[unitclass].g1
						else
							return unitframegradients[unitclass].r1,unitframegradients[unitclass].g1
						end
					else
						if alpha then
							return unitframegradients[unitclass].r1,unitframegradients[unitclass].g1
						else
							return unitframegradients[unitclass].r1,unitframegradients[unitclass].g1
						end
					end
				end
			end
		else
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
	end

	--get the custom gradient colors
	function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha, isBG)
		if E.Retail then
			if unitclass then
				if isBG then
					bgfade = E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
				else
					bgfade = 0
				end
				if not unitframecustomgradients[unitclass] then
					if invert then
						if alpha then
							return {r=unitframecustomgradients["MANA"].r2 - bgfade,g= unitframecustomgradients["MANA"].g2 - bgfade,b= unitframecustomgradients["MANA"].b2 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=unitframecustomgradients["MANA"].r1 - bgfade,g= unitframecustomgradients["MANA"].g1 - bgfade,b= unitframecustomgradients["MANA"].b1 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
						else
							return {r=unitframecustomgradients["MANA"].r2 - bgfade,g= unitframecustomgradients["MANA"].g2 - bgfade,b= unitframecustomgradients["MANA"].b2 - bgfade,a= 1}, {r=unitframecustomgradients["MANA"].r1 - bgfade,g= unitframecustomgradients["MANA"].g1 - bgfade,b= unitframecustomgradients["MANA"].b1 - bgfade,a= 1}
						end
					else
						if alpha then
							return {r=unitframecustomgradients["MANA"].r1 - bgfade,g= unitframecustomgradients["MANA"].g1 - bgfade,b= unitframecustomgradients["MANA"].b1 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=unitframecustomgradients["MANA"].r2 - bgfade,g= unitframecustomgradients["MANA"].g2 - bgfade,b= unitframecustomgradients["MANA"].b2 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
						else
							return {r=unitframecustomgradients["MANA"].r1 - bgfade,g= unitframecustomgradients["MANA"].g1 - bgfade,b= unitframecustomgradients["MANA"].b1 - bgfade,a= 1}, {r=unitframecustomgradients["MANA"].r2 - bgfade,g= unitframecustomgradients["MANA"].g2 - bgfade,b= unitframecustomgradients["MANA"].b2 - bgfade,a= 1}
						end
					end
				else
					if invert then
						if alpha then
							return {r=unitframecustomgradients[unitclass].r2 - bgfade,g= unitframecustomgradients[unitclass].g2 - bgfade,b= unitframecustomgradients[unitclass].b2 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=unitframecustomgradients[unitclass].r1 - bgfade,g= unitframecustomgradients[unitclass].g1 - bgfade,b= unitframecustomgradients[unitclass].b1 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
						else
							return {r=unitframecustomgradients[unitclass].r2 - bgfade,g= unitframecustomgradients[unitclass].g2 - bgfade,b=unitframecustomgradients[unitclass].b2 - bgfade,a= 1}, {r=unitframecustomgradients[unitclass].r1 - bgfade,g= unitframecustomgradients[unitclass].g1 - bgfade,b= unitframecustomgradients[unitclass].b1 - bgfade,a= 1}
						end
					else
						if alpha then
							return {r=unitframecustomgradients[unitclass].r1 - bgfade,g= unitframecustomgradients[unitclass].g1 - bgfade,b= unitframecustomgradients[unitclass].b1 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=unitframecustomgradients[unitclass].r2 - bgfade,g= unitframecustomgradients[unitclass].g2 - bgfade,b= unitframecustomgradients[unitclass].b2 - bgfade,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}
						else
							return {r=unitframecustomgradients[unitclass].r1 - bgfade,g= unitframecustomgradients[unitclass].g1 - bgfade,b= unitframecustomgradients[unitclass].b1 - bgfade,a= 1}, {r=unitframecustomgradients[unitclass].r2 - bgfade,g= unitframecustomgradients[unitclass].g2 - bgfade,b= unitframecustomgradients[unitclass].b2 - bgfade,a= 1}
						end
					end
				end
			end
		else
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
		if E.Retail then
			if unitclass then
				if not unitframegradients[unitclass] then
					return unitframegradients[unitclass].r1,unitframegradients[unitclass].g1
				else
					return unitframegradients[unitclass].r1,unitframegradients[unitclass].g1
				end
			end
		else
			if unitclass then
				if not unitframegradients[unitclass] then
					return unitframegradients["NPCNEUTRAL"].r1 - 0.2, unitframegradients["NPCNEUTRAL"].g1 - 0.2, unitframegradients["NPCNEUTRAL"].b1 - 0.2, 0.9, unitframegradients["NPCNEUTRAL"].r2 + 0.2, unitframegradients["NPCNEUTRAL"].g2 + 0.2, unitframegradients["NPCNEUTRAL"].b2 + 0.2, 0.9
				else
					return unitframegradients[unitclass].r1 - 0.2, unitframegradients[unitclass].g1 - 0.2, unitframegradients[unitclass].b1 - 0.2, 0.9, unitframegradients[unitclass].r2 + 0.2, unitframegradients[unitclass].g2 + 0.2, unitframegradients[unitclass].b2 + 0.2, 0.9
				end
			end
		end
	end

	function ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass)
		if E.Retail then
			if unitclass then
				if not unitframegradients[unitclass] then
					return {r=unitframecustomgradients["NPCNEUTRAL"].r1,g= unitframecustomgradients["NPCNEUTRAL"].g1,b= unitframecustomgradients["NPCNEUTRAL"].b1, a=0.9}, {r=unitframecustomgradients["NPCNEUTRAL"].r2,g= unitframecustomgradients["NPCNEUTRAL"].g2, b=unitframecustomgradients["NPCNEUTRAL"].b2, a=0.9}
				else
					return {r=unitframecustomgradients[unitclass].r1,g= unitframecustomgradients[unitclass].g1,b= unitframecustomgradients[unitclass].b1, a=0.9}, {r=unitframecustomgradients[unitclass].r2,g= unitframecustomgradients[unitclass].g2,b= unitframecustomgradients[unitclass].b2, a=0.9}
				end
			end
		else
			if unitclass then
				if not unitframegradients[unitclass] then
					return unitframecustomgradients["NPCNEUTRAL"].r1, unitframecustomgradients["NPCNEUTRAL"].g1, unitframecustomgradients["NPCNEUTRAL"].b1, 0.9, unitframecustomgradients["NPCNEUTRAL"].r2, unitframecustomgradients["NPCNEUTRAL"].g2, unitframecustomgradients["NPCNEUTRAL"].b2, 0.9
				else
					return unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, 0.9, unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2, 0.9
				end
			end
		end
	end

end
