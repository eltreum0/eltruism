local E = unpack(ElvUI)
local _G = _G
local tostring = _G.tostring
local CreateFrame = _G.CreateFrame
local ElvUI_EltreumUI = _G.ElvUI_EltreumUI

--set the variables
--maybe recreating colors can be avoided by setting the color as a variable and then creating if it doesnt exist like maybe so:
-- _G.Warrior1 = Warrior1 or CreateColor(r,g,b,a)
local unitframegradients = {
	["WARRIOR"] = {r1 = 0.427, g1 = 0.137, b1 = 0.09, r2 = 0.564, g2 = 0.431, b2 = 0.247},
	["PALADIN"] = {r1 = 1, g1 = 0.266, b1 = 0.537, r2 = 0.956, g2 = 0.549, b2 = 0.729},
	["HUNTER"] = {r1 = 0.403, g1 = 0.537, b1 = 0.223, r2 = 0.670, g2 = 0.929, b2 = 0.309},
	["MONK"] = {r1 = 0.015, g1 = 0.607, b1 = 0.368, r2 = 0, g2 = 1, b2 = 0.588},
	["ROGUE"] = {r1 = 1, g1 = 0.686, b1 = 0, r2 = 1, g2 = 0.831, b2 = 0.254},
	["PRIEST"] = {r1 = 0.356, g1 = 0.356, b1 = 0.356, r2 = 0.988, g2 = 0.988, b2 = 0.988},
	["DEATHKNIGHT"] = {r1 = 0.498, g1 = 0.074, b1 = 0.149, r2 = 1, g2 = 0.184, b2 = 0.239},
	["SHAMAN"] = {r1 = 0, g1 = 0.258, b1 = 0.509, r2 = 0.392, g2 = 0.443, b2 = 1},
	["MAGE"] = {r1 = 0, g1 = 0.333, b1 = 0.537, r2 = 0.490, g2 = 0.870, b2 = 1},
	["WARLOCK"] = {r1 = 0.262, g1 = 0.266, b1 = 0.466, r2 = 0.662, g2= 0.392, b2 = 0.784},
	["DRUID"] = {r1 = 1, g1 = 0.239, b1 = 0.007, r2 = 1, g2 = 0.486, b2 = 0.039},
	["DEMONHUNTER"] = {r1 = 0.364, g1 = 0.137, b1 = 0.572, r2 = 0.745, g2 = 0.192, b2 = 1},
	["EVOKER"] = {r1 = 0.196, g1 = 0.466, b1 = 0.537, r2 = 0.2, g2 = 0.576, b2 = 0.498},
	["NPCFRIENDLY"] = {r1 = 0.309, g1 = 0.850, b1 = 0.2, r2 = 0.341, g2 = 0.627, b2 = 0.407},
	["NPCNEUTRAL"] = {r1 = 0.815, g1 = 1, b1 = 0, r2 = 1, g2 = 0.858, b2 = 0.207},
	["NPCUNFRIENDLY"] = {r1 = 0.843, g1 = 0.301, b1 = 0, r2 = 0.831, g2 = 0.458, b2 = 0},
	["NPCHOSTILE"] = {r1 = 1, g1 = 0.090, b1 = 0, r2 = 1, g2 = 0, b2 = 0.549},
	["TAPPED"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2 = 0, b2 = 0},
	["GOODTHREAT"] = {r1 = 0.278, g1 = 1, b1 = 0, r2 = 0.952, g2 = 0.999, b2 = 0},
	["BADTHREAT"] = {r1 = 1, g1 = 0.176, b1 = 0.176, r2 = 0.823, g2 = 0, b2 = 0.349},
	["GOODTHREATTRANSITION"] = {r1 = 1, g1 = 0.996, b1 = 0.2, r2 = 1, g2 = 0.733, b2 = 0},
	["BADTHREATTRANSITION"] = {r1 = 1, g1 = 0.392, b1 = 0.2, r2 = 1, g2 = 0.984, b2 = 0},
	["OFFTANK"] = {r1 = 0.729, g1 = 0.2, b1 = 1, r2 = 0.341, g2 = 0, b2 = 1},
	["OFFTANKBADTHREATTRANSITION"] = {r1 = 0.709, g1 = 0.431, b1 = 0.270, r2 = 0.901, g2 = 0.152, b2 = 0},
	["OFFTANKGOODTHREATTRANSITION"] = {r1 = 0.309, g1 = 0.450, b1 = 0.631, r2 = 0, g2 = 1, b2 = 0.709},
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
	["ELTRUISM"] = {r1 = 0.50, g1 = 0.70, b1 = 1,r2 = 0.67, g2 = 0.95, b2 = 1}, --addon gradient (7fb3ff (darker 1A4682), abf2ff)
	["BACKDROP"] = {r1 = 0, g1 = 0, b1 = 0,r2 = 0.1, g2 = 0.1, b2 = 0.1}, --backdrop gradient
}
local unitframecustomgradients = unitframegradients
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
local unitframeclasscustom = unitframeclass

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
		["ELTRUISM"] = {r1 = 0.50, g1 = 0.70, b1 = 1,r2 = 0.67, g2 = 0.95, b2 = 1}, --addon gradient
		["BACKDROP"] = {r1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.backdropR1, g1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.backdropG1, b1 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.backdropB1, r2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.backdropR2, g2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.backdropG2, b2 = E.db.ElvUI_EltreumUI.unitframes.gradientmode.backdropB2}, --backdrop gradient
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

	--to make the previews update
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	if not E.private.unitframe.disabledBlizzardFrames.raid then
		ElvUI_EltreumUI:BlizzardTexturesGradient()
	end
	if E.db.ElvUI_EltreumUI.skins.cell then
		ElvUI_EltreumUI:EltruismCell()
	end
end
local colorupdateframe = CreateFrame("FRAME")
colorupdateframe:RegisterEvent("PLAYER_ENTERING_WORLD")
colorupdateframe:RegisterEvent("PLAYER_STARTED_MOVING")
colorupdateframe:RegisterEvent("FIRST_FRAME_RENDERED")
colorupdateframe:RegisterEvent("PLAYER_LOGIN")

--10.2 event order list
--[[local eventorder = {
	["ADDON_LOADED"] = true,
	["UPDATE_BINDINGS"] = true,
	["UPDATE_FLOATING_CHAT_WINDOWS"] = true,
	["UI_SCALE_CHANGED"] = true,
	["CVAR_UPDATE"] = true,
	["UPDATE_FACTION"] = true,
	["OPEN_SPLASH_SCREEN"] = true,
	["VARIABLES_LOADED"] = true,
	["UPDATE_MACROS"] = true,
	["UPDATE_CHAT_WINDOWS"] = true,
	["UPDATE_CHAT_COLOR"] = true,
	["UPDATE_CHAT_COLOR_NAME_BY_CLASS"] = true,
	["DISPLAY_SIZE_CHANGED"] = true,
	["PLAYER_TALENT_UPDATE"] = true,
	["PLAYER_PVP_TALENT_UPDATE"] = true,
	["UPDATE_INVENTORY_DURABILITY"] = true,
	["BAG_UPDATE"] = true,
	["BAG_CONTAINER_UPDATE"] = true,
	["UPDATE_VEHICLE_ACTIONBAR"] = true,
	["SKILL_LINES_CHANGED"] = true,
	["CURRENCY_DISPLAY_UPDATE"] = true,
	["VEHICLE_ANGLE_SHOW"] = true,
	["VEHICLE_POWER_SHOW"] = true,
	["SPELL_ACTIVATION_OVERLAY_HIDE"] = true,
	["MOUNT_JOURNAL_SEARCH_UPDATED"] = true,
	["TRANSMOG_SEARCH_UPDATED"] = true,
	["COMPACT_UNIT_FRAME_PROFILES_LOADED"] = true,
	["INITIAL_CLUBS_LOADED"] = true,
	["CONTENT_TRACKING_LIST_UPDATE"] = true,
	["EDIT_MODE_LAYOUTS_UPDATED"] = true,
	["MENTORSHIP_STATUS_CHANGED"] = true,
	["TRAIT_CONFIG_LIST_UPDATED"] = true,
	["CALENDAR_ACTION_PENDING"] = true,
	--THEN FINALLY
	["PLAYER_LOGIN"] = false,
	--there is also FIRST_FRAME_RENDERED
}]]

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

--return the background offset
local function bgfade(isBG)
	if isBG then
		return E.db.ElvUI_EltreumUI.unitframes.gradientmode.bgfade
	else
		return 0
	end
end

--return the backdrop alpha
local function bgalpha(alpha, isHealth)
	if alpha then
		if isHealth then
			return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha
		else
			return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
		end
	else
		return 1
	end
end

--get the gradient colors
function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha, isBG, customalpha, isHealth)
	local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
	if customalpha then
		if invert then
			return {r = ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1), a = customalpha}, {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = customalpha}
		else
			return {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = customalpha}, {r = ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1), a = customalpha}
		end
	else
		if invert then
			return {r = ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1), a = bgalpha(alpha,isHealth)}, {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = bgalpha(alpha,isHealth)}
		else
			return {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = bgalpha(alpha,isHealth)}, {r = ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1), a = bgalpha(alpha,isHealth)}
		end
	end
end

--get the custom gradient colors
function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha, isBG, customalpha, isHealth)
	local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
	if customalpha then
		if invert then
			return {r= ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1),g= ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1),b= ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1),a= customalpha}, { r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = customalpha}
		else
			return {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = customalpha}, {r=ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1),g= ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1),b= ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1),a= customalpha}
		end
	else
		if invert then
			return {r=ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1),g= ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1),b= ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1),a= bgalpha(alpha,isHealth)}, {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1), a = bgalpha(alpha,isHealth)}
		else
			return {r = ElvUI_EltreumUI:Interval(color.r1 - bgfade(isBG), 0, 1), g = ElvUI_EltreumUI:Interval(color.g1 - bgfade(isBG), 0, 1), b = ElvUI_EltreumUI:Interval(color.b1 - bgfade(isBG), 0, 1),a = bgalpha(alpha,isHealth)}, {r=ElvUI_EltreumUI:Interval(color.r2 - bgfade(isBG), 0, 1),g= ElvUI_EltreumUI:Interval(color.g2 - bgfade(isBG), 0, 1),b= ElvUI_EltreumUI:Interval(color.b2 - bgfade(isBG), 0, 1),a= bgalpha(alpha,isHealth)}
		end
	end
end

--sets name with gradient colors using elvui
function ElvUI_EltreumUI:GradientName(name, unitclass, isTarget)
	if not name then return end
	--local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
		local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
		if not isTarget then
			return E:TextGradient(name, color.r1, color.g1, color.b1, color.r2, color.g2, color.b2)
		else
			return E:TextGradient(name, color.r2, color.g2, color.b2, color.r1, color.g1, color.b1)
		end
	else
		local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
		if not isTarget then
			return E:TextGradient(name, color.r1, color.g1, color.b1, color.r2, color.g2, color.b2)
		else
			return E:TextGradient(name, color.r2, color.g2, color.b2, color.r1, color.g1, color.b1)
		end
	end
end

--sets name with default gradient colors using elvui
function ElvUI_EltreumUI:GradientNameDefaultColors(name, unitclass, isTarget)
	if not name then return end
	local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
	if not isTarget then
		return E:TextGradient(name, color.r1, color.g1, color.b1, color.r2, color.g2, color.b2)
	else
		return E:TextGradient(name, color.r2, color.g2, color.b2, color.r1, color.g1, color.b1)
	end
end

--sends the colors for chat
function ElvUI_EltreumUI:ChatCustomColor(unitclass)
	local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
	return color.r1, color.g1, color.b1
end

--different for details because bars smaller and different
function ElvUI_EltreumUI:GradientColorsDetails(unitclass)
	local color = unitframegradients[unitclass] or unitframegradients["NPCNEUTRAL"]
	return {r = color.r1 - 0.2, g = color.g1 - 0.2, b = color.b1 - 0.2, a = 0.9}, {r = color.r2 + 0.2, g = color.g2 + 0.2, b = color.b2 + 0.2, a = 0.9}
end

function ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass)
	local color = unitframecustomgradients[unitclass] or unitframecustomgradients["NPCNEUTRAL"]
	return {r = color.r1, g = color.g1, b = color.b1, a = 0.9}, {r = color.r2, g = color.g2, b = color.b2, a = 0.9}
end
