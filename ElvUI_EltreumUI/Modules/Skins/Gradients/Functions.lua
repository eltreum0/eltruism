local E = unpack(ElvUI)
local _G = _G
local tostring = _G.tostring
local CreateFrame = _G.CreateFrame
local GetClassColor = _G.C_ClassColor and _G.C_ClassColor.GetClassColor or _G.GetClassColor
local CreateColor = _G.CreateColor
local wipe = _G.wipe
local pairs = _G.pairs
local select = _G.select
local canaccessvalue = _G.canaccessvalue

local gradientColorCache = {}
local gradientCustomColorCache = {}
local defaultHealthGradients = { normal = {}, invert = {} }
local customHealthGradients = { normal = {}, invert = {} }
local defaultBackdropGradients = { normal = {}, invert = {} }
local customBackdropGradients = { normal = {}, invert = {} }
local defaultPowerGradients = { normal = {}, invert = {}, backdrop = {} }
local customPowerGradients = { normal = {}, invert = {}, backdrop = {} }
local cachedCastbars = {}

local defaultTableGradients = {}
local customTableGradients = {}
local defaultDetailsGradients = {}
local customDetailsGradients = {}
local gradientNameCache = { {}, {}, {}, {} }
local gradientNameDefaultCache = { {}, {} }
local gradientNameCacheCount = 0
local gradientNameDefaultCacheCount = 0
local MAX_NAME_CACHE_SIZE = 500
local colorupdateframe
ElvUI_EltreumUI.EltruismTextureVersion = 0

--clear cached name tables
local function ClearGradientNameCache(cache, count)
	for i = 1, count do
		wipe(cache[i])
	end
end
local cached_use_custom_names = false
local cached_bgfade = 0
local cached_healthalpha = 1
local cached_backdropalpha = 1
local deadColorMin, deadColorMax
local discColorMin, discColorMax
local tappedColorMin, tappedColorMax
local fallbackWhite = CreateColor(1, 1, 1, 1)

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

local unitframecustomgradients = {}
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
local unitframeclassV1 = unitframeclass
local unitframeclassV2 = {
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
local unitframeclassV3 = {
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
for k, v in pairs(unitframegradients) do
	unitframecustomgradients[k] = {r1 = v.r1, g1 = v.g1, b1 = v.b1, r2 = v.r2, g2 = v.g2, b2 = v.b2}
end

local function SetOrCreateColorPair(targetTbl, k, r1, g1, b1, a1, r2, g2, b2, a2)
	local pair = targetTbl[k]
	if pair then
		pair[1]:SetRGBA(r1, g1, b1, a1)
		pair[2]:SetRGBA(r2, g2, b2, a2)
	else
		targetTbl[k] = { CreateColor(r1, g1, b1, a1), CreateColor(r2, g2, b2, a2) }
	end
end

--fill the tabble with the values
local function PopulateGradients(sourceTable, targetHealth, targetBackdrop, targetPower, targetTable, targetDetails, isDetailsCustom, healthAlpha, backdropAlpha, bgOffset)
	for k, color in pairs(sourceTable) do
		local r1, g1, b1 = color.r1 or 1, color.g1 or 1, color.b1 or 1
		local r2, g2, b2 = color.r2 or 1, color.g2 or 1, color.b2 or 1
		local cr1, cg1, cb1 = E:Clamp(r1, 0, 1), E:Clamp(g1, 0, 1), E:Clamp(b1, 0, 1)
		local cr2, cg2, cb2 = E:Clamp(r2, 0, 1), E:Clamp(g2, 0, 1), E:Clamp(b2, 0, 1)
		local bgr1, bgg1, bgb1 = E:Clamp(r1 - bgOffset, 0, 1), E:Clamp(g1 - bgOffset, 0, 1), E:Clamp(b1 - bgOffset, 0, 1)
		local bgr2, bgg2, bgb2 = E:Clamp(r2 - bgOffset, 0, 1), E:Clamp(g2 - bgOffset, 0, 1), E:Clamp(b2 - bgOffset, 0, 1)

		SetOrCreateColorPair(targetHealth.normal, k, cr1, cg1, cb1, healthAlpha, cr2, cg2, cb2, healthAlpha)
		SetOrCreateColorPair(targetHealth.invert, k, cr2, cg2, cb2, healthAlpha, cr1, cg1, cb1, healthAlpha)
		SetOrCreateColorPair(targetBackdrop.normal, k, bgr1, bgg1, bgb1, backdropAlpha, bgr2, bgg2, bgb2, backdropAlpha)
		SetOrCreateColorPair(targetBackdrop.invert, k, bgr2, bgg2, bgb2, backdropAlpha, bgr1, bgg1, bgb1, backdropAlpha)
		SetOrCreateColorPair(targetPower.normal, k, cr1, cg1, cb1, 1, cr2, cg2, cb2, 1)
		SetOrCreateColorPair(targetPower.invert, k, cr2, cg2, cb2, 1, cr1, cg1, cb1, 1)
		SetOrCreateColorPair(targetPower.backdrop, k, bgr2, bgg2, bgb2, 1, bgr1, bgg1, bgb1, 1)

		local tblEntry = targetTable[k]
		if tblEntry then
			tblEntry.min.r, tblEntry.min.g, tblEntry.min.b = r1, g1, b1
			tblEntry.max.r, tblEntry.max.g, tblEntry.max.b = r2, g2, b2
		else
			targetTable[k] = {
				min = { r = r1, g = g1, b = b1 },
				max = { r = r2, g = g2, b = b2 },
			}
		end

		local detR1 = isDetailsCustom and r1 or (r1 - 0.2)
		local detG1 = isDetailsCustom and g1 or (g1 - 0.2)
		local detB1 = isDetailsCustom and b1 or (b1 - 0.2)
		local detR2 = isDetailsCustom and r2 or (r2 + 0.2)
		local detG2 = isDetailsCustom and g2 or (g2 + 0.2)
		local detB2 = isDetailsCustom and b2 or (b2 + 0.2)

		local detEntry = targetDetails[k]
		if detEntry then
			detEntry.min.r, detEntry.min.g, detEntry.min.b, detEntry.min.a = detR1, detG1, detB1, 0.9
			detEntry.max.r, detEntry.max.g, detEntry.max.b, detEntry.max.a = detR2, detG2, detB2, 0.9
		else
			targetDetails[k] = {
				min = { r = detR1, g = detG1, b = detB1, a = 0.9 },
				max = { r = detR2, g = detG2, b = detB2, a = 0.9 },
			}
		end
	end
end

--save the colors instead of recreating them
function ElvUI_EltreumUI:CacheGradients()
	local db = E.db.ElvUI_EltreumUI
	if not db then return end
	local uf = db.unitframes
	if not uf then return end
	local customTexture = uf.ufcustomtexture
	if not customTexture then return end
	local gm = uf.gradientmode
	local ufDB = E.db.unitframe
	local colors = ufDB.colors

	local transparentHealth = colors and colors.transparentHealth
	local isHidden = customTexture and customTexture.backdrophidden
	local healthAlpha = transparentHealth and (customTexture and customTexture.healthalpha or 1) or 1
	local backdropAlpha = isHidden and 0 or ((customTexture and customTexture.backdropalpha) or 1)
	if not isHidden and transparentHealth and backdropAlpha == 1 and healthAlpha < 1 then
		backdropAlpha = healthAlpha
	end
	local bgOffset = (gm and gm.bgfade) or 0
	cached_healthalpha = healthAlpha
	cached_backdropalpha = backdropAlpha
	cached_bgfade = (gm and gm.bgfade) or 0

	if gm then
		cached_use_custom_names = (gm.customcolor or gm.npcustomcolor)
	else
		cached_use_custom_names = false
	end

	ClearGradientNameCache(gradientNameCache, 4)
	gradientNameCacheCount = 0
	ClearGradientNameCache(gradientNameDefaultCache, 2)
	gradientNameDefaultCacheCount = 0
	if ElvUI_EltreumUI.ClearTooltipGradientCache then
		ElvUI_EltreumUI:ClearTooltipGradientCache()
	end

	PopulateGradients(unitframegradients, defaultHealthGradients, defaultBackdropGradients, defaultPowerGradients, defaultTableGradients, defaultDetailsGradients, false, healthAlpha, backdropAlpha, bgOffset)
	PopulateGradients(unitframecustomgradients, customHealthGradients, customBackdropGradients, customPowerGradients, customTableGradients, customDetailsGradients, true, healthAlpha, backdropAlpha, bgOffset)

	--castbar
	if gm then
		SetOrCreateColorPair(cachedCastbars, "noninterruptible_custom",
			E:Clamp(gm.castbarR2noninterruptiblecustom or 1, 0, 1), E:Clamp(gm.castbarG2noninterruptiblecustom or 0, 0, 1), E:Clamp(gm.castbarB2noninterruptiblecustom or 0, 0, 1), 1,
			E:Clamp(gm.castbarR1noninterruptiblecustom or 1, 0, 1), E:Clamp(gm.castbarG1noninterruptiblecustom or 0, 0, 1), E:Clamp(gm.castbarB1noninterruptiblecustom or 0, 0, 1), 1)
		SetOrCreateColorPair(cachedCastbars, "noninterruptible_default",
			E:Clamp(gm.castbarR2noninterruptible or 1, 0, 1), E:Clamp(gm.castbarG2noninterruptible or 0, 0, 1), E:Clamp(gm.castbarB2noninterruptible or 0, 0, 1), 1,
			E:Clamp(gm.castbarR1noninterruptible or 1, 0, 1), E:Clamp(gm.castbarG1noninterruptible or 0, 0, 1), E:Clamp(gm.castbarB1noninterruptible or 0, 0, 1), 1)
		SetOrCreateColorPair(cachedCastbars, "castbar_custom",
			E:Clamp(gm.castbarR1custom or 1, 0, 1), E:Clamp(gm.castbarG1custom or 1, 0, 1), E:Clamp(gm.castbarB1custom or 1, 0, 1), 1,
			E:Clamp(gm.castbarR2custom or 1, 0, 1), E:Clamp(gm.castbarG2custom or 1, 0, 1), E:Clamp(gm.castbarB2custom or 1, 0, 1), 1)
		SetOrCreateColorPair(cachedCastbars, "interruptible_custom",
			E:Clamp(gm.castbarR1interruptablecustom or 1, 0, 1), E:Clamp(gm.castbarG1interruptablecustom or 1, 0, 1), E:Clamp(gm.castbarB1interruptablecustom or 1, 0, 1), 1,
			E:Clamp(gm.castbarR2interruptablecustom or 1, 0, 1), E:Clamp(gm.castbarG2interruptablecustom or 1, 0, 1), E:Clamp(gm.castbarB2interruptablecustom or 1, 0, 1), 1)
		SetOrCreateColorPair(cachedCastbars, "interruptible_default",
			E:Clamp(gm.castbarR1interruptable or 1, 0, 1), E:Clamp(gm.castbarG1interruptable or 1, 0, 1), E:Clamp(gm.castbarB1interruptable or 1, 0, 1), 1,
			E:Clamp(gm.castbarR2interruptable or 1, 0, 1), E:Clamp(gm.castbarG2interruptable or 1, 0, 1), E:Clamp(gm.castbarB2interruptable or 1, 0, 1), 1)
		SetOrCreateColorPair(cachedCastbars, "interrupted_custom",
			E:Clamp(gm.castbarR1interruptedcustom or 1, 0, 1), E:Clamp(gm.castbarG1interruptedcustom or 1, 0, 1), E:Clamp(gm.castbarB1interruptedcustom or 1, 0, 1), 1,
			E:Clamp(gm.castbarR2interruptedcustom or 1, 0, 1), E:Clamp(gm.castbarG2interruptedcustom or 1, 0, 1), E:Clamp(gm.castbarB2interruptedcustom or 1, 0, 1), 1)
		SetOrCreateColorPair(cachedCastbars, "interrupted_default",
			E:Clamp(gm.castbarR1interrupted or 1, 0, 1), E:Clamp(gm.castbarG1interrupted or 1, 0, 1), E:Clamp(gm.castbarB1interrupted or 1, 0, 1), 1,
			E:Clamp(gm.castbarR2interrupted or 1, 0, 1), E:Clamp(gm.castbarG2interrupted or 1, 0, 1), E:Clamp(gm.castbarB2interrupted or 1, 0, 1), 1)
	end
end

local unitframeclasscustom = {}
local function SetCustomGrad(key, r1, g1, b1, r2, g2, b2)
	local t = unitframecustomgradients[key]
	if t then
		t.r1, t.g1, t.b1, t.r2, t.g2, t.b2 = r1, g1, b1, r2, g2, b2
	else
		unitframecustomgradients[key] = {r1 = r1, g1 = g1, b1 = b1, r2 = r2, g2 = g2, b2 = b2}
	end
end
function ElvUI_EltreumUI:GradientColorTableUpdate()
	local db = E.db.ElvUI_EltreumUI
	if not db then return end
	local uf = db.unitframes
	if not uf then return end
	local customTex = uf.ufcustomtexture
	local gm = uf.gradientmode
	if not customTex or not gm then return end
	local ufDB = E.db.unitframe

	unitframeclasscustom["WARRIOR"] = tostring(E.LSM:Fetch("statusbar", customTex.warriortexture))
	unitframeclasscustom["PALADIN"] = tostring(E.LSM:Fetch("statusbar", customTex.paladintexture))
	unitframeclasscustom["HUNTER"] = tostring(E.LSM:Fetch("statusbar", customTex.huntertexture))
	unitframeclasscustom["ROGUE"] = tostring(E.LSM:Fetch("statusbar", customTex.roguetexture))
	unitframeclasscustom["PRIEST"] = tostring(E.LSM:Fetch("statusbar", customTex.priesttexture))
	unitframeclasscustom["DEATHKNIGHT"] = tostring(E.LSM:Fetch("statusbar", customTex.deathknighttexture))
	unitframeclasscustom["SHAMAN"] = tostring(E.LSM:Fetch("statusbar", customTex.shamantexture))
	unitframeclasscustom["MAGE"] = tostring(E.LSM:Fetch("statusbar", customTex.magetexture))
	unitframeclasscustom["WARLOCK"] = tostring(E.LSM:Fetch("statusbar", customTex.warlocktexture))
	unitframeclasscustom["MONK"] = tostring(E.LSM:Fetch("statusbar", customTex.monktexture))
	unitframeclasscustom["DRUID"] = tostring(E.LSM:Fetch("statusbar", customTex.druidtexture))
	unitframeclasscustom["DEMONHUNTER"] = tostring(E.LSM:Fetch("statusbar", customTex.demonhuntertexture))
	unitframeclasscustom["EVOKER"] = tostring(E.LSM:Fetch("statusbar", customTex.evokertexture))
	unitframeclasscustom["NPCFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", customTex.npcfriendly))
	unitframeclasscustom["NPCNEUTRAL"] = tostring(E.LSM:Fetch("statusbar", customTex.npcneutral))
	unitframeclasscustom["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", customTex.npcunfriendly))
	unitframeclasscustom["NPCHOSTILE"] = tostring(E.LSM:Fetch("statusbar", customTex.npchostile))
	unitframeclasscustom["TAPPED"] = tostring(E.LSM:Fetch("statusbar", customTex.tappedtexture))
	unitframeclasscustom["RAID"] = tostring(E.LSM:Fetch("statusbar", customTex.raidtexture))
	unitframeclasscustom["PARTY"] = tostring(E.LSM:Fetch("statusbar", customTex.partytexture))

	SetCustomGrad("WARRIOR", gm.warriorcustomcolorR1, gm.warriorcustomcolorG1, gm.warriorcustomcolorB1, gm.warriorcustomcolorR2, gm.warriorcustomcolorG2, gm.warriorcustomcolorB2)
	SetCustomGrad("PALADIN", gm.paladincustomcolorR1, gm.paladincustomcolorG1, gm.paladincustomcolorB1, gm.paladincustomcolorR2, gm.paladincustomcolorG2, gm.paladincustomcolorB2)
	SetCustomGrad("HUNTER", gm.huntercustomcolorR1, gm.huntercustomcolorG1, gm.huntercustomcolorB1, gm.huntercustomcolorR2, gm.huntercustomcolorG2, gm.huntercustomcolorB2)
	SetCustomGrad("ROGUE", gm.roguecustomcolorR1, gm.roguecustomcolorG1, gm.roguecustomcolorB1, gm.roguecustomcolorR2, gm.roguecustomcolorG2, gm.roguecustomcolorB2)
	SetCustomGrad("PRIEST", gm.priestcustomcolorR1, gm.priestcustomcolorG1, gm.priestcustomcolorB1, gm.priestcustomcolorR2, gm.priestcustomcolorG2, gm.priestcustomcolorB2)
	SetCustomGrad("DEATHKNIGHT", gm.deathknightcustomcolorR1, gm.deathknightcustomcolorG1, gm.deathknightcustomcolorB1, gm.deathknightcustomcolorR2, gm.deathknightcustomcolorG2, gm.deathknightcustomcolorB2)
	SetCustomGrad("SHAMAN", gm.shamancustomcolorR1, gm.shamancustomcolorG1, gm.shamancustomcolorB1, gm.shamancustomcolorR2, gm.shamancustomcolorG2, gm.shamancustomcolorB2)
	SetCustomGrad("MAGE", gm.magecustomcolorR1, gm.magecustomcolorG1, gm.magecustomcolorB1, gm.magecustomcolorR2, gm.magecustomcolorG2, gm.magecustomcolorB2)
	SetCustomGrad("WARLOCK", gm.warlockcustomcolorR1, gm.warlockcustomcolorG1, gm.warlockcustomcolorB1, gm.warlockcustomcolorR2, gm.warlockcustomcolorG2, gm.warlockcustomcolorB2)
	SetCustomGrad("MONK", gm.monkcustomcolorR1, gm.monkcustomcolorG1, gm.monkcustomcolorB1, gm.monkcustomcolorR2, gm.monkcustomcolorG2, gm.monkcustomcolorB2)
	SetCustomGrad("DRUID", gm.druidcustomcolorR1, gm.druidcustomcolorG1, gm.druidcustomcolorB1, gm.druidcustomcolorR2, gm.druidcustomcolorG2, gm.druidcustomcolorB2)
	SetCustomGrad("DEMONHUNTER", gm.demonhuntercustomcolorR1, gm.demonhuntercustomcolorG1, gm.demonhuntercustomcolorB1, gm.demonhuntercustomcolorR2, gm.demonhuntercustomcolorG2, gm.demonhuntercustomcolorB2)
	SetCustomGrad("EVOKER", gm.evokercustomcolorR1, gm.evokercustomcolorG1, gm.evokercustomcolorB1, gm.evokercustomcolorR2, gm.evokercustomcolorG2, gm.evokercustomcolorB2)
	SetCustomGrad("NPCFRIENDLY", gm.npcfriendlyR1, gm.npcfriendlyG1, gm.npcfriendlyB1, gm.npcfriendlyR2, gm.npcfriendlyG2, gm.npcfriendlyB2)
	SetCustomGrad("NPCNEUTRAL", gm.npcneutralR1, gm.npcneutralG1, gm.npcneutralB1, gm.npcneutralR2, gm.npcneutralG2, gm.npcneutralB2)
	SetCustomGrad("NPCUNFRIENDLY", gm.npcunfriendlyR1, gm.npcunfriendlyG1, gm.npcunfriendlyB1, gm.npcunfriendlyR2, gm.npcunfriendlyG2, gm.npcunfriendlyB2)
	SetCustomGrad("NPCHOSTILE", gm.npchostileR1, gm.npchostileG1, gm.npchostileB1, gm.npchostileR2, gm.npchostileG2, gm.npchostileB2)
	SetCustomGrad("TAPPED", gm.tappedR1, gm.tappedG1, gm.tappedB1, gm.tappedR2, gm.tappedG2, gm.tappedB2)
	SetCustomGrad("GOODTHREAT", gm.goodthreatR1, gm.goodthreatG1, gm.goodthreatB1, gm.goodthreatR2, gm.goodthreatG2, gm.goodthreatB2)
	SetCustomGrad("BADTHREAT", gm.badthreatR1, gm.badthreatG1, gm.badthreatB1, gm.badthreatR2, gm.badthreatG2, gm.badthreatB2)
	SetCustomGrad("GOODTHREATTRANSITION", gm.goodthreattransitionR1, gm.goodthreattransitionG1, gm.goodthreattransitionB1, gm.goodthreattransitionR2, gm.goodthreattransitionG2, gm.goodthreattransitionB2)
	SetCustomGrad("BADTHREATTRANSITION", gm.badthreattransitionR1, gm.badthreattransitionG1, gm.badthreattransitionB1, gm.badthreattransitionR2, gm.badthreattransitionG2, gm.badthreattransitionB2)
	SetCustomGrad("OFFTANK", gm.offtankR1, gm.offtankG1, gm.offtankB1, gm.offtankR2, gm.offtankG2, gm.offtankB2)
	SetCustomGrad("OFFTANKBADTHREATTRANSITION", gm.badthreattransitionofftankR1, gm.badthreattransitionofftankG1, gm.badthreattransitionofftankB1, gm.badthreattransitionofftankR2, gm.badthreattransitionofftankG2, gm.badthreattransitionofftankB2)
	SetCustomGrad("OFFTANKGOODTHREATTRANSITION", gm.goodthreattransitionofftankR1, gm.goodthreattransitionofftankG1, gm.goodthreattransitionofftankB1, gm.goodthreattransitionofftankR2, gm.goodthreattransitionofftankG2, gm.goodthreattransitionofftankB2)
	SetCustomGrad("MANA", gm.manaR1, gm.manaG1, gm.manaB1, gm.manaR2, gm.manaG2, gm.manaB2)
	SetCustomGrad("RAGE", gm.rageR1, gm.rageG1, gm.rageB1, gm.rageR2, gm.rageG2, gm.rageB2)
	SetCustomGrad("FOCUS", gm.focusR1, gm.focusG1, gm.focusB1, gm.focusR2, gm.focusG2, gm.focusB2)
	SetCustomGrad("ENERGY", gm.energyR1, gm.energyG1, gm.energyB1, gm.energyR2, gm.energyG2, gm.energyB2)
	SetCustomGrad("RUNIC_POWER", gm.runicpowerR1, gm.runicpowerG1, gm.runicpowerB1, gm.runicpowerR2, gm.runicpowerG2, gm.runicpowerB2)
	SetCustomGrad("LUNAR_POWER", gm.lunarpowerR1, gm.lunarpowerG1, gm.lunarpowerB1, gm.lunarpowerR2, gm.lunarpowerG2, gm.lunarpowerB2)
	SetCustomGrad("ALT_POWER", gm.altpowerR1, gm.altpowerG1, gm.altpowerB1, gm.altpowerR2, gm.altpowerG2, gm.altpowerB2)
	SetCustomGrad("MAELSTROM", gm.maelstromR1, gm.maelstromG1, gm.maelstromB1, gm.maelstromR2, gm.maelstromG2, gm.maelstromB2)
	SetCustomGrad("INSANITY", gm.insanityR1, gm.insanityG1, gm.insanityB1, gm.insanityR2, gm.insanityG2, gm.insanityB2)
	SetCustomGrad("FURY", gm.furyR1, gm.furyG1, gm.furyB1, gm.furyR2, gm.furyG2, gm.furyB2)
	SetCustomGrad("PAIN", gm.painR1, gm.painG1, gm.painB1, gm.painR2, gm.painG2, gm.painB2)
	SetCustomGrad("ELTRUISM", 0.50, 0.70, 1, 0.67, 0.95, 1)
	SetCustomGrad("BACKDROP", gm.backdropR1, gm.backdropG1, gm.backdropB1, gm.backdropR2, gm.backdropG2, gm.backdropB2)

	if uf.uftextureversion == "V2" then
		unitframeclass = unitframeclassV2
	elseif uf.uftextureversion == "V3" then
		unitframeclass = unitframeclassV3
	else
		unitframeclass = unitframeclassV1
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

	ElvUI_EltreumUI.EltruismTextureVersion = ElvUI_EltreumUI.EltruismTextureVersion + 1
	wipe(gradientColorCache)
	wipe(gradientCustomColorCache)

	ElvUI_EltreumUI:CacheGradients()
	if colorupdateframe then
		colorupdateframe:UnregisterAllEvents()
	end

	if E.db and ufDB and ufDB.colors then
		local dead = ufDB.colors.health_backdrop_dead
		local alpha = customTex.backdropalpha or 1
		if dead then
			local dr, dg, db2 = E:Clamp(dead.r - 0.3, 0, 1), E:Clamp(dead.g - 0.3, 0, 1), E:Clamp(dead.b - 0.3, 0, 1)
			if deadColorMin then deadColorMin:SetRGBA(dr, dg, db2, alpha) else deadColorMin = CreateColor(dr, dg, db2, alpha) end
			if deadColorMax then deadColorMax:SetRGBA(dead.r, dead.g, dead.b, alpha) else deadColorMax = CreateColor(dead.r, dead.g, dead.b, alpha) end
		end

		local disc = ufDB.colors.disconnected
		if disc then
			local dcr, dcg, dcb = E:Clamp(disc.r - 0.3, 0, 1), E:Clamp(disc.g - 0.3, 0, 1), E:Clamp(disc.b - 0.3, 0, 1)
			if discColorMin then discColorMin:SetRGBA(dcr, dcg, dcb, alpha) else discColorMin = CreateColor(dcr, dcg, dcb, alpha) end
			if discColorMax then discColorMax:SetRGBA(disc.r, disc.g, disc.b, alpha) else discColorMax = CreateColor(disc.r, disc.g, disc.b, alpha) end
		end

		local tapped = ufDB.colors.tapped
		if tapped then
			local tr, tg, tb = E:Clamp(tapped.r - 0.3, 0, 1), E:Clamp(tapped.g - 0.3, 0, 1), E:Clamp(tapped.b - 0.3, 0, 1)
			if tappedColorMin then tappedColorMin:SetRGBA(tr, tg, tb, alpha) else tappedColorMin = CreateColor(tr, tg, tb, alpha) end
			if tappedColorMax then tappedColorMax:SetRGBA(tapped.r, tapped.g, tapped.b, alpha) else tappedColorMax = CreateColor(tapped.r, tapped.g, tapped.b, alpha) end
		end
	end

	--to make the previews update
	ElvUI_EltreumUI:CustomTexture("testunit")
	ElvUI_EltreumUI:GradientUF("testunit")
	ElvUI_EltreumUI:GradientPower("testunit")
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
	if db.otherstuff.minimapLocation.gradient and db.otherstuff.minimapLocation.gradientMode == "CLASS" then
		ElvUI_EltreumUI:UpdateMinimapLocationText(true)
	end
end

colorupdateframe = CreateFrame("FRAME")
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
	if unitclass and canaccessvalue(unitclass) and unitframeclass[unitclass] then
		return unitframeclass[unitclass]
	else
		return "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Elvui-Norm.tga"
	end
end

--get the custom texture
function ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass)
	if unitclass and canaccessvalue(unitclass) and unitframeclasscustom[unitclass] then
		return unitframeclasscustom[unitclass]
	else
		return "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Elvui-Norm.tga"
	end
end

--return the background offset
local function bgfade(isBG)
	return isBG and cached_bgfade or 0
end

--return the backdrop alpha
local function bgalpha(alpha, isHealth)
	if alpha then
		return isHealth and cached_healthalpha or cached_backdropalpha
	end
	return 1
end

function ElvUI_EltreumUI:GetCachedBackdropAlpha()
	return cached_backdropalpha
end

function ElvUI_EltreumUI:GetHealthGradient(key, invert, isCustom)
	if not key or not canaccessvalue(key) then
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

function ElvUI_EltreumUI:GetBackdropGradient(key, invert, isCustom, ignoreClass)
	if ignoreClass or not key or not canaccessvalue(key) or key == "ELTRUISM" then
		key = "BACKDROP"
	end
	local tbl = isCustom and customBackdropGradients or defaultBackdropGradients
	local bucket = invert and tbl.invert or tbl.normal
	local entry = bucket[key] or bucket["BACKDROP"] or bucket["ELTRUISM"]
	if entry then
		return entry[1], entry[2]
	end
	if isCustom then
		return ElvUI_EltreumUI:GradientColorsCustom(key, invert, true, true, nil, false)
	else
		return ElvUI_EltreumUI:GradientColors(key, invert, true, true, nil, false)
	end
end

--[[function ElvUI_EltreumUI:GetPowerGradient(powertype, invert, isBG, isCustom)
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
end]]

function ElvUI_EltreumUI:GetCastbarGradient(key, invert)
	local entry = cachedCastbars[key]
	if entry then
		if invert then
			return entry[2], entry[1]
		else
			return entry[1], entry[2]
		end
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
	local flags = (invert and 1 or 0) + (alpha and 2 or 0) + (isBG and 4 or 0) + (isHealth and 8 or 0)
	local entry
	if customalpha and customalpha ~= 0 then
		local ca = c1[16]
		local cf = ca and ca[flags]
		entry = cf and cf[customalpha]
	else
		entry = c1[flags]
	end
	if entry then
		return entry[1], entry[2]
	end
end

local function SetCachedColors(cache, minColor, maxColor, unitclass, invert, alpha, isBG, customalpha, isHealth)
	local flags = (invert and 1 or 0) + (alpha and 2 or 0) + (isBG and 4 or 0) + (isHealth and 8 or 0)
	local c1 = cache[unitclass]
	if not c1 then c1 = {} cache[unitclass] = c1 end
	if customalpha and customalpha ~= 0 then
		local ca = c1[16]
		if not ca then ca = {} c1[16] = ca end
		local cf = ca[flags]
		if not cf then cf = {} ca[flags] = cf end
		cf[customalpha] = { minColor, maxColor }
	else
		c1[flags] = { minColor, maxColor }
	end
end

--resolve gradient colors
local function ResolveGradientColors(unitclass, invert, alpha, isBG, customalpha, isHealth, powerTable, cache, colorTable)
	if not unitclass then
		unitclass = "ELTRUISM"
	elseif not E:NotSecretValue(unitclass) then
		local classColor = GetClassColor(unitclass)
		if classColor then
			return classColor, classColor
		end
		unitclass = "ELTRUISM"
	end

	if not alpha and not isBG and not customalpha and not isHealth then
		local modeTable = invert and powerTable.invert or powerTable.normal
		local entry = modeTable[unitclass] or modeTable["ELTRUISM"]
		if entry then
			return entry[1], entry[2]
		end
	end

	local minC, maxC = GetCachedColors(cache, unitclass, invert, alpha, isBG, customalpha, isHealth)
	if minC then
		return minC, maxC
	end

	local color = colorTable[unitclass] or colorTable["ELTRUISM"]
	local bgOffset = bgfade(isBG)
	local aVal = customalpha or bgalpha(alpha, isHealth)
	local minColor, maxColor

	if invert then
		minColor = CreateColor(E:Clamp(color.r2 - bgOffset, 0, 1), E:Clamp(color.g2 - bgOffset, 0, 1), E:Clamp(color.b2 - bgOffset, 0, 1), aVal)
		maxColor = CreateColor(E:Clamp(color.r1 - bgOffset, 0, 1), E:Clamp(color.g1 - bgOffset, 0, 1), E:Clamp(color.b1 - bgOffset, 0, 1), aVal)
	else
		minColor = CreateColor(E:Clamp(color.r1 - bgOffset, 0, 1), E:Clamp(color.g1 - bgOffset, 0, 1), E:Clamp(color.b1 - bgOffset, 0, 1), aVal)
		maxColor = CreateColor(E:Clamp(color.r2 - bgOffset, 0, 1), E:Clamp(color.g2 - bgOffset, 0, 1), E:Clamp(color.b2 - bgOffset, 0, 1), aVal)
	end

	SetCachedColors(cache, minColor, maxColor, unitclass, invert, alpha, isBG, customalpha, isHealth)
	return minColor, maxColor
end

--get the gradient colors
function ElvUI_EltreumUI:GradientColors(unitclass, invert, alpha, isBG, customalpha, isHealth)
	return ResolveGradientColors(unitclass, invert, alpha, isBG, customalpha, isHealth, defaultPowerGradients, gradientColorCache, unitframegradients)
end

--get the custom gradient colors
function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert, alpha, isBG, customalpha, isHealth)
	return ResolveGradientColors(unitclass, invert, alpha, isBG, customalpha, isHealth, customPowerGradients, gradientCustomColorCache, unitframecustomgradients)
end

--sets name with gradient colors using elvui
function ElvUI_EltreumUI:GradientName(name, unitclass, isTarget, isUnit, isCustom)
	if not name then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret(name, true) and isUnit then
		local cs = ElvUI_EltreumUI:GetClassColorsRGB(unitclass, 3)
		return E:RGBToHex(cs.r, cs.g, cs.b) .. name
	end

	local useCustom = cached_use_custom_names or isCustom
	local mode = useCustom and (isTarget and 4 or 3) or (isTarget and 2 or 1)
	local classKey = unitclass or false
	local modeTable = gradientNameCache[mode]
	local classTable = modeTable[classKey]
	if classTable then
		local cachedName = classTable[name]
		if cachedName then return cachedName end
	end

	local colorTable = useCustom and unitframecustomgradients or unitframegradients
	local color = colorTable[unitclass] or colorTable["ELTRUISM"]
	local result
	if not isTarget then
		result = E:TextGradient(name, color.r1, color.g1, color.b1, color.r2, color.g2, color.b2)
	else
		result = E:TextGradient(name, color.r2, color.g2, color.b2, color.r1, color.g1, color.b1)
	end

	if gradientNameCacheCount >= MAX_NAME_CACHE_SIZE then
		ClearGradientNameCache(gradientNameCache, 4)
		gradientNameCacheCount = 0
		classTable = nil
	end
	if not classTable then
		classTable = {}
		modeTable[classKey] = classTable
	end
	classTable[name] = result
	gradientNameCacheCount = gradientNameCacheCount + 1
	return result
end

--sets name with default gradient colors using elvui
function ElvUI_EltreumUI:GradientNameDefaultColors(name, unitclass, isTarget, isUnit)
	if not name then return end
	if not ElvUI_EltreumUI:IsThisASafeSecret(name, true) and isUnit then
		local cs = ElvUI_EltreumUI:GetClassColorsRGB(unitclass, 3)
		return E:RGBToHex(cs.r, cs.g, cs.b) .. name
	end

	local mode = isTarget and 2 or 1
	local classKey = unitclass or false
	local modeTable = gradientNameDefaultCache[mode]
	local classTable = modeTable[classKey]
	if classTable then
		local cachedName = classTable[name]
		if cachedName then return cachedName end
	end

	local color = unitframegradients[unitclass] or unitframegradients["ELTRUISM"]
	local result
	if not isTarget then
		result = E:TextGradient(name, color.r1, color.g1, color.b1, color.r2, color.g2, color.b2)
	else
		result = E:TextGradient(name, color.r2, color.g2, color.b2, color.r1, color.g1, color.b1)
	end

	if gradientNameDefaultCacheCount >= MAX_NAME_CACHE_SIZE then
		ClearGradientNameCache(gradientNameDefaultCache, 2)
		gradientNameDefaultCacheCount = 0
		classTable = nil
	end
	if not classTable then
		classTable = {}
		modeTable[classKey] = classTable
	end
	classTable[name] = result
	gradientNameDefaultCacheCount = gradientNameDefaultCacheCount + 1
	return result
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
		local entry = customTableGradients[unitclass] or customTableGradients["ELTRUISM"]
		if entry then
			return entry.min, entry.max
		end
	end
	return ElvUI_EltreumUI:GetClassColorsRGB(unitclass, 4)
end

--get the default colors
function ElvUI_EltreumUI:GetGradientDefaultColor(unitclass)
	if E:NotSecretValue(unitclass) then
		local entry = defaultTableGradients[unitclass] or defaultTableGradients["ELTRUISM"]
		if entry then
			return entry.min, entry.max
		end
	end
	return ElvUI_EltreumUI:GetClassColorsRGB(unitclass, 4)
end

--different for details because bars smaller and different
function ElvUI_EltreumUI:GradientColorsDetails(unitclass)
	if E:NotSecretValue(unitclass) then
		local entry = defaultDetailsGradients[unitclass] or defaultDetailsGradients["NPCNEUTRAL"]
		if entry then
			return entry.min, entry.max
		end
	end
	return ElvUI_EltreumUI:GetClassColorsRGB(unitclass, 4)
end

function ElvUI_EltreumUI:GradientColorsDetailsCustom(unitclass)
	if E:NotSecretValue(unitclass) then
		local entry = customDetailsGradients[unitclass] or customDetailsGradients["NPCNEUTRAL"]
		if entry then
			return entry.min, entry.max
		end
	end
	return ElvUI_EltreumUI:GetClassColorsRGB(unitclass, 4)
end

--set gradient using vertex color of regions of a frame
local function applyGradientToRegions(numRegions, r, g, b, ...)
	for k = 1, numRegions do
		local region = select(k, ...)
		if region and region.SetVertexColor then
			local percentage = 1 - (k / (numRegions + 1))
			region:SetVertexColor((r * percentage), (g * percentage), (b * percentage), 1)
		end
	end
end
function ElvUI_EltreumUI:ApplyGlowGradient(glowFrame, r, g, b)
	if not glowFrame then return end
	applyGradientToRegions(glowFrame:GetNumRegions(), r, g, b, glowFrame:GetRegions())
end
