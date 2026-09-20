local E = unpack(ElvUI)
local _G = _G
local tostring = _G.tostring
local CreateFrame = _G.CreateFrame
local GetClassColor = _G.C_ClassColor and _G.C_ClassColor.GetClassColor or _G.GetClassColor
local CreateColor = _G.CreateColor
local wipe = _G.wipe
local pairs = _G.pairs

local gradientColorCache = {}
local gradientCustomColorCache = {}
local defaultHealthGradients = { normal = {}, invert = {} }
local customHealthGradients = { normal = {}, invert = {} }
local defaultBackdropGradients = { normal = {}, invert = {} }
local customBackdropGradients = { normal = {}, invert = {} }
local defaultPowerGradients = { normal = {}, invert = {}, backdrop = {} }
local customPowerGradients = { normal = {}, invert = {}, backdrop = {} }
local cachedCastbars = {}
local deadColorMin, deadColorMax
local discColorMin, discColorMax
local tappedColorMin, tappedColorMax
local fallbackWhite = CreateColor(1, 1, 1, 1)

local function clamp(val)
	if val < 0 then
		return 0
	elseif val > 1 then
		return 1
	end
	return val
end

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

--fill the tabble with the values
local function PopulateGradients(sourceTable, targetHealth, targetBackdrop, targetPower, healthAlpha, backdropAlpha, bgOffset)
	for k, color in pairs(sourceTable) do
		local r1, g1, b1 = color.r1 or 1, color.g1 or 1, color.b1 or 1
		local r2, g2, b2 = color.r2 or 1, color.g2 or 1, color.b2 or 1

		targetHealth.normal[k] = {
			CreateColor(clamp(r1), clamp(g1), clamp(b1), healthAlpha),
			CreateColor(clamp(r2), clamp(g2), clamp(b2), healthAlpha)
		}

		targetHealth.invert[k] = {
			CreateColor(clamp(r2), clamp(g2), clamp(b2), healthAlpha),
			CreateColor(clamp(r1), clamp(g1), clamp(b1), healthAlpha)
		}

		targetBackdrop.normal[k] = {
			CreateColor(clamp(r1 - bgOffset), clamp(g1 - bgOffset), clamp(b1 - bgOffset), backdropAlpha),
			CreateColor(clamp(r2 - bgOffset), clamp(g2 - bgOffset), clamp(b2 - bgOffset), backdropAlpha)
		}

		targetBackdrop.invert[k] = {
			CreateColor(clamp(r2 - bgOffset), clamp(g2 - bgOffset), clamp(b2 - bgOffset), backdropAlpha),
			CreateColor(clamp(r1 - bgOffset), clamp(g1 - bgOffset), clamp(b1 - bgOffset), backdropAlpha)
		}

		targetPower.normal[k] = {
			CreateColor(clamp(r1), clamp(g1), clamp(b1), 1),
			CreateColor(clamp(r2), clamp(g2), clamp(b2), 1)
		}

		targetPower.invert[k] = {
			CreateColor(clamp(r2), clamp(g2), clamp(b2), 1),
			CreateColor(clamp(r1), clamp(g1), clamp(b1), 1)
		}

		targetPower.backdrop[k] = {
			CreateColor(clamp(r2 - bgOffset), clamp(g2 - bgOffset), clamp(b2 - bgOffset), 1),
			CreateColor(clamp(r1 - bgOffset), clamp(g1 - bgOffset), clamp(b1 - bgOffset), 1)
		}
	end
end

--save the colors instead of recreating them
function ElvUI_EltreumUI:CacheGradients()
	local db = E.db and E.db.ElvUI_EltreumUI
	local uf = db and db.unitframes
	local customTexture = uf and uf.ufcustomtexture
	local gm = uf and uf.gradientmode
	local colors = E.db and E.db.unitframe and E.db.unitframe.colors

	local transparentHealth = (colors and colors.transparentHealth) or (uf and uf.lightmode)
	local healthAlpha = transparentHealth and (customTexture and customTexture.healthalpha or 1) or 1
	local backdropAlpha = (customTexture and customTexture.backdropalpha) or 1
	if backdropAlpha == 1 and healthAlpha < 1 then
		backdropAlpha = healthAlpha
	end
	local bgOffset = (gm and gm.bgfade) or 0

	wipe(defaultHealthGradients.normal)
	wipe(defaultHealthGradients.invert)
	wipe(customHealthGradients.normal)
	wipe(customHealthGradients.invert)
	wipe(defaultBackdropGradients.normal)
	wipe(defaultBackdropGradients.invert)
	wipe(customBackdropGradients.normal)
	wipe(customBackdropGradients.invert)
	wipe(defaultPowerGradients.normal)
	wipe(defaultPowerGradients.invert)
	wipe(defaultPowerGradients.backdrop)
	wipe(customPowerGradients.normal)
	wipe(customPowerGradients.invert)
	wipe(customPowerGradients.backdrop)
	wipe(cachedCastbars)

	PopulateGradients(unitframegradients, defaultHealthGradients, defaultBackdropGradients, defaultPowerGradients, healthAlpha, backdropAlpha, bgOffset)
	PopulateGradients(unitframecustomgradients, customHealthGradients, customBackdropGradients, customPowerGradients, healthAlpha, backdropAlpha, bgOffset)

	--castbar
	if gm then
		cachedCastbars.noninterruptible_custom = {
			CreateColor(clamp(gm.targetcastbarR2noninterruptiblecustom or 1), clamp(gm.targetcastbarG2noninterruptiblecustom or 0), clamp(gm.targetcastbarB2noninterruptiblecustom or 0), 1),
			CreateColor(clamp(gm.targetcastbarR1noninterruptiblecustom or 1), clamp(gm.targetcastbarG1noninterruptiblecustom or 0), clamp(gm.targetcastbarB1noninterruptiblecustom or 0), 1)
		}
		cachedCastbars.noninterruptible_default = {
			CreateColor(clamp(gm.targetcastbarR2noninterruptible or 1), clamp(gm.targetcastbarG2noninterruptible or 0), clamp(gm.targetcastbarB2noninterruptible or 0), 1),
			CreateColor(clamp(gm.targetcastbarR1noninterruptible or 1), clamp(gm.targetcastbarG1noninterruptible or 0), clamp(gm.targetcastbarB1noninterruptible or 0), 1)
		}
		cachedCastbars.target_custom = {
			CreateColor(clamp(gm.targetcastbarR1custom or 1), clamp(gm.targetcastbarG1custom or 1), clamp(gm.targetcastbarB1custom or 1), 1),
			CreateColor(clamp(gm.targetcastbarR2custom or 1), clamp(gm.targetcastbarG2custom or 1), clamp(gm.targetcastbarB2custom or 1), 1)
		}
		cachedCastbars.interruptible_custom = {
			CreateColor(clamp(gm.targetcastbarR1interruptablecustom or 1), clamp(gm.targetcastbarG1interruptablecustom or 1), clamp(gm.targetcastbarB1interruptablecustom or 1), 1),
			CreateColor(clamp(gm.targetcastbarR2interruptablecustom or 1), clamp(gm.targetcastbarG2interruptablecustom or 1), clamp(gm.targetcastbarB2interruptablecustom or 1), 1)
		}
		cachedCastbars.interruptible_default = {
			CreateColor(clamp(gm.targetcastbarR1interruptable or 1), clamp(gm.targetcastbarG1interruptable or 1), clamp(gm.targetcastbarB1interruptable or 1), 1),
			CreateColor(clamp(gm.targetcastbarR2interruptable or 1), clamp(gm.targetcastbarG2interruptable or 1), clamp(gm.targetcastbarB2interruptable or 1), 1)
		}
	end
end

local unitframeclasscustom = unitframeclass
function ElvUI_EltreumUI:GradientColorTableUpdate()
	local db = E.db and E.db.ElvUI_EltreumUI
	local uf = db and db.unitframes
	if not uf then return end
	local customTex = uf.ufcustomtexture
	local gm = uf.gradientmode
	if not customTex or not gm then return end

	unitframeclasscustom = {
		["WARRIOR"] = tostring(E.LSM:Fetch("statusbar", customTex.warriortexture)),
		["PALADIN"] = tostring(E.LSM:Fetch("statusbar", customTex.paladintexture)),
		["HUNTER"] = tostring(E.LSM:Fetch("statusbar", customTex.huntertexture)),
		["ROGUE"] = tostring(E.LSM:Fetch("statusbar", customTex.roguetexture)),
		["PRIEST"] = tostring(E.LSM:Fetch("statusbar", customTex.priesttexture)),
		["DEATHKNIGHT"] = tostring(E.LSM:Fetch("statusbar", customTex.deathknighttexture)),
		["SHAMAN"] = tostring(E.LSM:Fetch("statusbar", customTex.shamantexture)),
		["MAGE"] = tostring(E.LSM:Fetch("statusbar", customTex.magetexture)),
		["WARLOCK"] = tostring(E.LSM:Fetch("statusbar", customTex.warlocktexture)),
		["MONK"] = tostring(E.LSM:Fetch("statusbar", customTex.monktexture)),
		["DRUID"] = tostring(E.LSM:Fetch("statusbar", customTex.druidtexture)),
		["DEMONHUNTER"] = tostring(E.LSM:Fetch("statusbar", customTex.demonhuntertexture)),
		["EVOKER"] = tostring(E.LSM:Fetch("statusbar", customTex.evokertexture)),
		["NPCFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", customTex.npcfriendly)),
		["NPCNEUTRAL"] = tostring(E.LSM:Fetch("statusbar", customTex.npcneutral)),
		["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", customTex.npcunfriendly)),
		["NPCHOSTILE"] = tostring(E.LSM:Fetch("statusbar", customTex.npchostile)),
		["TAPPED"] = tostring(E.LSM:Fetch("statusbar", customTex.tappedtexture)),
		["RAID"] = tostring(E.LSM:Fetch("statusbar", customTex.raidtexture)),
		["PARTY"] = tostring(E.LSM:Fetch("statusbar", customTex.partytexture)),
	}
	unitframecustomgradients = {
		["WARRIOR"] = {r1 = gm.warriorcustomcolorR1, g1 = gm.warriorcustomcolorG1, b1 = gm.warriorcustomcolorB1, r2 = gm.warriorcustomcolorR2, g2 = gm.warriorcustomcolorG2, b2 = gm.warriorcustomcolorB2},
		["PALADIN"] = {r1 = gm.paladincustomcolorR1, g1 = gm.paladincustomcolorG1, b1 = gm.paladincustomcolorB1, r2 = gm.paladincustomcolorR2, g2 = gm.paladincustomcolorG2, b2 = gm.paladincustomcolorB2},
		["HUNTER"] = {r1 = gm.huntercustomcolorR1, g1 = gm.huntercustomcolorG1, b1 = gm.huntercustomcolorB1, r2 = gm.huntercustomcolorR2, g2 = gm.huntercustomcolorG2, b2 = gm.huntercustomcolorB2},
		["ROGUE"] = {r1 = gm.roguecustomcolorR1, g1 = gm.roguecustomcolorG1, b1 = gm.roguecustomcolorB1, r2 = gm.roguecustomcolorR2, g2 = gm.roguecustomcolorG2, b2 = gm.roguecustomcolorB2},
		["PRIEST"] = {r1 = gm.priestcustomcolorR1, g1 = gm.priestcustomcolorG1, b1 = gm.priestcustomcolorB1, r2 = gm.priestcustomcolorR2, g2 = gm.priestcustomcolorG2, b2 = gm.priestcustomcolorB2},
		["DEATHKNIGHT"] = {r1 = gm.deathknightcustomcolorR1, g1 = gm.deathknightcustomcolorG1, b1 = gm.deathknightcustomcolorB1, r2 = gm.deathknightcustomcolorR2, g2= gm.deathknightcustomcolorG2, b2 = gm.deathknightcustomcolorB2},
		["SHAMAN"] = {r1 = gm.shamancustomcolorR1, g1 = gm.shamancustomcolorG1, b1 = gm.shamancustomcolorB1, r2 = gm.shamancustomcolorR2, g2 = gm.shamancustomcolorG2, b2 = gm.shamancustomcolorB2},
		["MAGE"] = {r1 = gm.magecustomcolorR1, g1 = gm.magecustomcolorG1, b1 = gm.magecustomcolorB1, r2 = gm.magecustomcolorR2, g2 = gm.magecustomcolorG2, b2 = gm.magecustomcolorB2},
		["WARLOCK"] = {r1 = gm.warlockcustomcolorR1, g1 = gm.warlockcustomcolorG1, b1 = gm.warlockcustomcolorB1, r2 = gm.warlockcustomcolorR2, g2 = gm.warlockcustomcolorG2, b2 = gm.warlockcustomcolorB2},
		["MONK"] = {r1 = gm.monkcustomcolorR1, g1 = gm.monkcustomcolorG1, b1 = gm.monkcustomcolorB1, r2 = gm.monkcustomcolorR2, g2 = gm.monkcustomcolorG2, b2 = gm.monkcustomcolorB2},
		["DRUID"] = {r1 = gm.druidcustomcolorR1, g1 = gm.druidcustomcolorG1, b1 = gm.druidcustomcolorB1, r2 = gm.druidcustomcolorR2, g2 = gm.druidcustomcolorG2, b2 = gm.druidcustomcolorB2},
		["DEMONHUNTER"] = {r1 = gm.demonhuntercustomcolorR1, g1 = gm.demonhuntercustomcolorG1, b1 = gm.demonhuntercustomcolorB1, r2 = gm.demonhuntercustomcolorR2, g2= gm.demonhuntercustomcolorG2, b2 = gm.demonhuntercustomcolorB2},
		["EVOKER"] = {r1 = gm.evokercustomcolorR1, g1 = gm.evokercustomcolorG1, b1 = gm.evokercustomcolorB1, r2 = gm.evokercustomcolorR2, g2= gm.evokercustomcolorG2, b2 = gm.evokercustomcolorB2},
		["NPCFRIENDLY"] = {r1 = gm.npcfriendlyR1, g1 = gm.npcfriendlyG1, b1 = gm.npcfriendlyB1, r2 = gm.npcfriendlyR2, g2 = gm.npcfriendlyG2, b2 = gm.npcfriendlyB2},
		["NPCNEUTRAL"] = {r1 = gm.npcneutralR1, g1 = gm.npcneutralG1, b1 = gm.npcneutralB1, r2 = gm.npcneutralR2, g2 = gm.npcneutralG2, b2 = gm.npcneutralB2},
		["NPCUNFRIENDLY"] = {r1 = gm.npcunfriendlyR1, g1 = gm.npcunfriendlyG1, b1 = gm.npcunfriendlyB1, r2 = gm.npcunfriendlyR2, g2 = gm.npcunfriendlyG2, b2 = gm.npcunfriendlyB2},
		["NPCHOSTILE"] = {r1 = gm.npchostileR1, g1 = gm.npchostileG1, b1 = gm.npchostileB1, r2 = gm.npchostileR2, g2 = gm.npchostileG2, b2 = gm.npchostileB2},
		["TAPPED"] = {r1 = gm.tappedR1, g1 = gm.tappedG1, b1 = gm.tappedB1, r2 = gm.tappedR2, g2= gm.tappedG2, b2 = gm.tappedB2},
		["GOODTHREAT"] = {r1 = gm.goodthreatR1, g1 = gm.goodthreatG1, b1 = gm.goodthreatB1, r2 = gm.goodthreatR2, g2 = gm.goodthreatG2, b2 = gm.goodthreatB2},
		["BADTHREAT"] = {r1 = gm.badthreatR1, g1 = gm.badthreatG1, b1 = gm.badthreatB1, r2 = gm.badthreatR2, g2 = gm.badthreatG2, b2 = gm.badthreatB2},
		["GOODTHREATTRANSITION"] = {r1 = gm.goodthreattransitionR1, g1 = gm.goodthreattransitionG1, b1 = gm.goodthreattransitionB1, r2 = gm.goodthreattransitionR2, g2 = gm.goodthreattransitionG2, b2 = gm.goodthreattransitionB2},
		["BADTHREATTRANSITION"] = {r1 = gm.badthreattransitionR1, g1 = gm.badthreattransitionG1, b1 = gm.badthreattransitionB1, r2 = gm.badthreattransitionR2, g2 = gm.badthreattransitionG2, b2 = gm.badthreattransitionB2},
		["OFFTANK"] = {r1 = gm.offtankR1, g1 = gm.offtankG1, b1 = gm.offtankB1, r2 = gm.offtankR2, g2 = gm.offtankG2, b2 = gm.offtankB2},
		["OFFTANKBADTHREATTRANSITION"] = {r1 = gm.badthreattransitionofftankR1, g1 = gm.badthreattransitionofftankG1, b1 = gm.badthreattransitionofftankB1, r2 = gm.badthreattransitionofftankR2, g2 = gm.badthreattransitionofftankG2, b2 = gm.badthreattransitionofftankB2},
		["OFFTANKGOODTHREATTRANSITION"] = {r1 = gm.goodthreattransitionofftankR1, g1 = gm.goodthreattransitionofftankG1, b1 = gm.goodthreattransitionofftankB1, r2 = gm.goodthreattransitionofftankR2, g2 = gm.goodthreattransitionofftankG2, b2 = gm.goodthreattransitionofftankB2},
		["MANA"] = {r1 = gm.manaR1, g1 = gm.manaG1, b1 = gm.manaB1, r2 = gm.manaR2, g2 = gm.manaG2, b2 = gm.manaB2}, --MANA
		["RAGE"] = {r1 = gm.rageR1, g1 = gm.rageG1, b1 = gm.rageB1, r2 = gm.rageR2, g2 = gm.rageG2, b2 = gm.rageB2}, --RAGE
		["FOCUS"] = {r1 = gm.focusR1, g1 = gm.focusG1, b1 = gm.focusB1, r2 = gm.focusR2, g2 = gm.focusG2, b2 = gm.focusB2}, --FOCUS
		["ENERGY"] = {r1 = gm.energyR1, g1 = gm.energyG1, b1 = gm.energyB1, r2 = gm.energyR2, g2 = gm.energyG2, b2 = gm.energyB2}, --ENERGY
		["RUNIC_POWER"] = {r1 = gm.runicpowerR1, g1 = gm.runicpowerG1, b1 = gm.runicpowerB1, r2 = gm.runicpowerR2, g2 = gm.runicpowerG2, b2 = gm.runicpowerB2}, --RUNIC POWER
		["LUNAR_POWER"] = {r1 = gm.lunarpowerR1, g1 = gm.lunarpowerG1, b1 = gm.lunarpowerB1, r2 = gm.lunarpowerR2, g2 = gm.lunarpowerG2, b2 = gm.lunarpowerB2}, --LUNAR POWER
		["ALT_POWER"] = {r1 = gm.altpowerR1, g1 = gm.altpowerG1, b1 = gm.altpowerB1, r2 = gm.altpowerR2, g2 = gm.altpowerG2, b2 = gm.altpowerB2}, --ALTERNATE POWER
		["MAELSTROM"] = {r1 = gm.maelstromR1, g1 = gm.maelstromG1, b1 = gm.maelstromB1, r2 = gm.maelstromR2, g2 = gm.maelstromG2, b2 = gm.maelstromB2}, --MAELSTROM
		["INSANITY"] = {r1 = gm.insanityR1, g1 = gm.insanityG1, b1 = gm.insanityB1, r2 = gm.insanityR2, g2 = gm.insanityG2, b2 = gm.insanityB2}, --INSANITY
		["FURY"] = {r1 = gm.furyR1, g1 = gm.furyG1, b1 = gm.furyB1, r2 = gm.furyR2, g2 = gm.furyG2, b2 = gm.furyB2}, --FURY
		["PAIN"] = {r1 = gm.painR1, g1 = gm.painG1, b1 = gm.painB1, r2 = gm.painR2, g2 = gm.painG2, b2 = gm.painB2}, --PAIN
		["ELTRUISM"] = {r1 = 0.50, g1 = 0.70, b1 = 1,r2 = 0.67, g2 = 0.95, b2 = 1}, --addon gradient
		["BACKDROP"] = {r1 = gm.backdropR1, g1 = gm.backdropG1, b1 = gm.backdropB1, r2 = gm.backdropR2, g2 = gm.backdropG2, b2 = gm.backdropB2}, --backdrop gradient
	}
	if uf.uftextureversion == "V2" then
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
	elseif uf.uftextureversion == "V3" then
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

	wipe(gradientColorCache)
	wipe(gradientCustomColorCache)

	ElvUI_EltreumUI:CacheGradients()
	ElvUI_EltreumUI:IncrementHealthBackdropEpoch()

	if E.db and E.db.unitframe and E.db.unitframe.colors then
		local dead = E.db.unitframe.colors.health_backdrop_dead
		local alpha = customTex.backdropalpha or 1
		if dead then
			deadColorMin = CreateColor(clamp(dead.r - 0.3), clamp(dead.g - 0.3), clamp(dead.b - 0.3), alpha)
			deadColorMax = CreateColor(dead.r, dead.g, dead.b, alpha)
		end

		local disc = E.db.unitframe.colors.disconnected
		if disc then
			discColorMin = CreateColor(clamp(disc.r - 0.3), clamp(disc.g - 0.3), clamp(disc.b - 0.3), alpha)
			discColorMax = CreateColor(disc.r, disc.g, disc.b, alpha)
		end

		local tapped = E.db.unitframe.colors.tapped
		if tapped then
			tappedColorMin = CreateColor(clamp(tapped.r - 0.3), clamp(tapped.g - 0.3), clamp(tapped.b - 0.3), alpha)
			tappedColorMax = CreateColor(tapped.r, tapped.g, tapped.b, alpha)
		end
	end

	--to make the previews update
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	if not (E.private and E.private.unitframe and E.private.unitframe.disabledBlizzardFrames and E.private.unitframe.disabledBlizzardFrames.raid) then
		if ElvUI_EltreumUI.BlizzardTexturesGradient then
			ElvUI_EltreumUI:BlizzardTexturesGradient()
		end
	end
	if db.skins and db.skins.cell then
		if ElvUI_EltreumUI.EltruismCell then
			ElvUI_EltreumUI:EltruismCell()
		end
	end
	if _G["EltruismPlayerRestLoopRestTexture"] and uf.blizzardresticongradient then
		if (gm.customcolor or gm.npcustomcolor) then
			if ElvUI_EltreumUI.GradientColorsCustom then
				_G["EltruismPlayerRestLoopRestTexture"]:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
			end
		else
			if ElvUI_EltreumUI.GradientColors then
				_G["EltruismPlayerRestLoopRestTexture"]:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
			end
		end
	end
end

local colorupdateframe = CreateFrame("FRAME")
colorupdateframe:RegisterEvent("PLAYER_ENTERING_WORLD")
colorupdateframe:RegisterEvent("PLAYER_STARTED_MOVING")
colorupdateframe:RegisterEvent("FIRST_FRAME_RENDERED")
colorupdateframe:RegisterEvent("PLAYER_LOGIN")
colorupdateframe:SetScript("OnEvent", function()
	if E.db and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.unitframes then
		colorupdateframe:UnregisterAllEvents()
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end
end)

--get the texture
function ElvUI_EltreumUI:UnitframeClassTexture(unitclass)
	if E:NotSecretValue(unitclass) and unitclass and unitframeclass and unitframeclass[unitclass] then
		return unitframeclass[unitclass]
	else
		return "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Elvui-Norm.tga"
	end
end

--get the custom texture
function ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass)
	if E:NotSecretValue(unitclass) and unitclass and unitframeclasscustom and unitframeclasscustom[unitclass] then
		return unitframeclasscustom[unitclass]
	else
		return "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Elvui-Norm.tga"
	end
end

--return the background offset
local function bgfade(isBG)
	if isBG then
		local db = E.db and E.db.ElvUI_EltreumUI
		local gm = db and db.unitframes and db.unitframes.gradientmode
		return gm and gm.bgfade or 0
	else
		return 0
	end
end

--return the backdrop alpha
local function bgalpha(alpha, isHealth)
	if alpha then
		local db = E.db and E.db.ElvUI_EltreumUI
		local uf = db and db.unitframes and db.unitframes.ufcustomtexture
		if isHealth then
			return uf and uf.healthalpha or 1
		else
			return uf and uf.backdropalpha or 1
		end
	else
		return 1
	end
end

function ElvUI_EltreumUI:GetHealthGradient(key, invert, isCustom)
	if not key or not E:NotSecretValue(key) then
		key = "ELTRUISM"
	end
	local tbl = isCustom and customHealthGradients or defaultHealthGradients
	local bucket = invert and tbl.invert or tbl.normal
	local entry = bucket[key] or bucket["ELTRUISM"]
	if entry then
		return entry[1], entry[2]
	end
	if isCustom then
		return ElvUI_EltreumUI:GradientColorsCustom(key, invert, true, false, nil, true)
	else
		return ElvUI_EltreumUI:GradientColors(key, invert, true, false, nil, true)
	end
end

function ElvUI_EltreumUI:GetBackdropGradient(key, invert, isCustom)
	if not key or not E:NotSecretValue(key) then
		key = "ELTRUISM"
	end
	local tbl = isCustom and customBackdropGradients or defaultBackdropGradients
	local bucket = invert and tbl.invert or tbl.normal
	local entry = bucket[key] or bucket["ELTRUISM"]
	if entry then
		return entry[1], entry[2]
	end
	if isCustom then
		return ElvUI_EltreumUI:GradientColorsCustom(key, invert, true, true, nil, false)
	else
		return ElvUI_EltreumUI:GradientColors(key, invert, true, true, nil, false)
	end
end

function ElvUI_EltreumUI:GetPowerGradient(powertype, invert, isBG, isCustom)
	if not powertype or not E:NotSecretValue(powertype) then
		powertype = "ELTRUISM"
	end
	local tbl = isCustom and customPowerGradients or defaultPowerGradients
	local bucket
	if isBG then
		bucket = tbl.backdrop
	elseif invert then
		bucket = tbl.invert
	else
		bucket = tbl.normal
	end
	local entry = bucket[powertype] or bucket["ELTRUISM"]
	if entry then
		return entry[1], entry[2]
	end
	if isCustom then
		return ElvUI_EltreumUI:GradientColorsCustom(powertype, invert, false, isBG)
	else
		return ElvUI_EltreumUI:GradientColors(powertype, invert, false, isBG)
	end
end

function ElvUI_EltreumUI:GetCastbarGradient(key)
	local entry = cachedCastbars[key]
	if entry then
		return entry[1], entry[2]
	end
	return fallbackWhite, fallbackWhite
end

function ElvUI_EltreumUI:GetDeadColors()
	return deadColorMin, deadColorMax
end

function ElvUI_EltreumUI:GetDisconnectedColors()
	return discColorMin, discColorMax
end

function ElvUI_EltreumUI:GetTappedColors()
	return tappedColorMin, tappedColorMax
end

local function GetCachedColors(cache, unitclass, invert, alpha, isBG, customalpha, isHealth)
	local c1 = cache[unitclass]
	if not c1 then return end
	local c2 = c1[invert or false]
	if not c2 then return end
	local c3 = c2[alpha or false]
	if not c3 then return end
	local c4 = c3[isBG or false]
	if not c4 then return end
	local c5 = c4[customalpha or 0]
	if not c5 then return end
	local entry = c5[isHealth or false]
	if entry then
		return entry[1], entry[2]
	end
end

local function SetCachedColors(cache, minColor, maxColor, unitclass, invert, alpha, isBG, customalpha, isHealth)
	local invKey = invert or false
	local alphaKey = alpha or false
	local bgKey = isBG or false
	local custAlphaKey = customalpha or 0
	local healthKey = isHealth or false

	local c1 = cache[unitclass]
	if not c1 then c1 = {}; cache[unitclass] = c1 end
	local c2 = c1[invKey]
	if not c2 then c2 = {}; c1[invKey] = c2 end
	local c3 = c2[alphaKey]
	if not c3 then c3 = {}; c2[alphaKey] = c3 end
	local c4 = c3[bgKey]
	if not c4 then c4 = {}; c3[bgKey] = c4 end
	local c5 = c4[custAlphaKey]
	if not c5 then c5 = {}; c4[custAlphaKey] = c5 end
	c5[healthKey] = { minColor, maxColor }
end

--get the gradient colors
function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha, isBG, customalpha, isHealth)
	if not unitclass or not E:NotSecretValue(unitclass) then
		if unitclass and not E:NotSecretValue(unitclass) then
			local classColor = GetClassColor(unitclass)
			if classColor then
				return classColor, classColor
			end
		end
		unitclass = "ELTRUISM"
	end

	local minC, maxC = GetCachedColors(gradientColorCache, unitclass, invert, alpha, isBG, customalpha, isHealth)
	if minC then
		return minC, maxC
	end

	local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
	local bgOffset = bgfade(isBG)
	local aVal = customalpha or bgalpha(alpha, isHealth)
	local minColor, maxColor

	if invert then
		minColor = CreateColor(clamp(color.r2 - bgOffset), clamp(color.g2 - bgOffset), clamp(color.b2 - bgOffset), aVal)
		maxColor = CreateColor(clamp(color.r1 - bgOffset), clamp(color.g1 - bgOffset), clamp(color.b1 - bgOffset), aVal)
	else
		minColor = CreateColor(clamp(color.r1 - bgOffset), clamp(color.g1 - bgOffset), clamp(color.b1 - bgOffset), aVal)
		maxColor = CreateColor(clamp(color.r2 - bgOffset), clamp(color.g2 - bgOffset), clamp(color.b2 - bgOffset), aVal)
	end

	SetCachedColors(gradientColorCache, minColor, maxColor, unitclass, invert, alpha, isBG, customalpha, isHealth)
	return minColor, maxColor
end

--get the custom gradient colors
function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha, isBG, customalpha, isHealth)
	if not unitclass or not E:NotSecretValue(unitclass) then
		if unitclass and not E:NotSecretValue(unitclass) then
			local classColor = GetClassColor(unitclass)
			if classColor then
				return classColor, classColor
			end
		end
		unitclass = "ELTRUISM"
	end

	local minC, maxC = GetCachedColors(gradientCustomColorCache, unitclass, invert, alpha, isBG, customalpha, isHealth)
	if minC then
		return minC, maxC
	end

	local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
	local bgOffset = bgfade(isBG)
	local aVal = customalpha or bgalpha(alpha, isHealth)
	local minColor, maxColor

	if invert then
		minColor = CreateColor(clamp(color.r2 - bgOffset), clamp(color.g2 - bgOffset), clamp(color.b2 - bgOffset), aVal)
		maxColor = CreateColor(clamp(color.r1 - bgOffset), clamp(color.g1 - bgOffset), clamp(color.b1 - bgOffset), aVal)
	else
		minColor = CreateColor(clamp(color.r1 - bgOffset), clamp(color.g1 - bgOffset), clamp(color.b1 - bgOffset), aVal)
		maxColor = CreateColor(clamp(color.r2 - bgOffset), clamp(color.g2 - bgOffset), clamp(color.b2 - bgOffset), aVal)
	end

	SetCachedColors(gradientCustomColorCache, minColor, maxColor, unitclass, invert, alpha, isBG, customalpha, isHealth)
	return minColor, maxColor
end

--sets name with gradient colors using elvui
function ElvUI_EltreumUI:GradientName(name, unitclass, isTarget,isUnit,isCustom)
	if not name then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret(name,true) and isUnit then
		local cs = ElvUI_EltreumUI:GetClassColorsRGB(unitclass,3)
		return E:RGBToHex(cs.r,cs.g,cs.b) .. name
	else
		local db = E.db and E.db.ElvUI_EltreumUI
		local gm = db and db.unitframes and db.unitframes.gradientmode
		if (gm and (gm.customcolor or gm.npcustomcolor)) or isCustom then
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
end

--sets name with default gradient colors using elvui
function ElvUI_EltreumUI:GradientNameDefaultColors(name, unitclass, isTarget,isUnit)
	if not name then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret(name,true) and isUnit then
		local cs = ElvUI_EltreumUI:GetClassColorsRGB(unitclass,3)
		return E:RGBToHex(cs.r,cs.g,cs.b) .. name
	else
		local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
		if not isTarget then
			return E:TextGradient(name, color.r1, color.g1, color.b1, color.r2, color.g2, color.b2)
		else
			return E:TextGradient(name, color.r2, color.g2, color.b2, color.r1, color.g1, color.b1)
		end
	end
end

--sends the colors for chat
function ElvUI_EltreumUI:ChatCustomColor(unitclass)
	if E:NotSecretValue(unitclass) then
		local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
		return color.r1, color.g1, color.b1
	else
		return ElvUI_EltreumUI:GetClassColorsRGB(unitclass)
	end
end

--get the custom colors
function ElvUI_EltreumUI:GetGradientCustomColor(unitclass)
	if E:NotSecretValue(unitclass) then
		local color = unitframecustomgradients[unitclass] or unitframecustomgradients["ELTRUISM"]
		return {r = color.r1, g = color.g1, b = color.b1}, {r = color.r2, g = color.g2, b = color.b2}
	else
		return ElvUI_EltreumUI:GetClassColorsRGB(unitclass,2)
	end
end

--get the default colors
function ElvUI_EltreumUI:GetGradientDefaultColor(unitclass)
	if E:NotSecretValue(unitclass) then
		local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
		return {r = color.r1, g = color.g1, b = color.b1}, {r = color.r2, g = color.g2, b = color.b2}
	else
		return ElvUI_EltreumUI:GetClassColorsRGB(unitclass,2)
	end
end

--different for details because bars smaller and different
function ElvUI_EltreumUI:GradientColorsDetails(unitclass)
	if E:NotSecretValue(unitclass) then
		local color = unitframegradients[unitclass] or unitframegradients["NPCNEUTRAL"]
		return {r = color.r1 - 0.2, g = color.g1 - 0.2, b = color.b1 - 0.2, a = 0.9}, {r = color.r2 + 0.2, g = color.g2 + 0.2, b = color.b2 + 0.2, a = 0.9}
	else
		return ElvUI_EltreumUI:GetClassColorsRGB(unitclass,2)
	end
end

function ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass)
	if E:NotSecretValue(unitclass) then
		local color = unitframecustomgradients[unitclass] or unitframecustomgradients["NPCNEUTRAL"]
		return {r = color.r1, g = color.g1, b = color.b1, a = 0.9}, {r = color.r2, g = color.g2, b = color.b2, a = 0.9}
	else
		return ElvUI_EltreumUI:GetClassColorsRGB(unitclass,2)
	end
end
