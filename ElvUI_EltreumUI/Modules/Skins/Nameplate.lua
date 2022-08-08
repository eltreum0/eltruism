local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local tostring = _G.tostring
local select = _G.select

local paladin, warrior, shaman, druid, deathknight, demonhunter, monk, rogue, priest, mage, hunter, warlock
local npchostile, npcneutral, npcfriendly
local goodthreat, goodtransition, badtransition, badthreat
local offtank, offtankgoodtransition, offtankbadtransition

if E.Retail then
	paladin = {r = "0.95686066150665", g = "0.54901838302612", b = "0.72941017150879"}
	warrior = {r = "0.77646887302399", g = "0.60784178972244", b = "0.4274500310421"}
	shaman = {r = "0", g = "0.4392147064209", b = "0.86666476726532"}
	druid = {r = "0.99999779462814", g = "0.48627343773842", b = "0.039215601980686"}
	deathknight = {r = "0.76862573623657", g = "0.11764679849148", b = "0.2274504750967"}
	demonhunter = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"}
	monk = {r = "0", g = "0.99999779462814", b = "0.59607714414597"}
	rogue = {r = "0.99999779462814", g = "0.95686066150665", b = "0.40784224867821"}
	priest = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"}
	mage = {r = "0.24705828726292", g = "0.78039044141769", b = "0.92156660556793"}
	hunter = {r = "0.66666519641876", g = "0.82744914293289", b = "0.44705784320831"}
	warlock = {r = "0.52941060066223", g = "0.53333216905594", b = "0.93333131074905"}
elseif E.Wrath or E.TBC or E.Classic then
	paladin = {r = "0.96078222990036", g = "0.54901838302612", b = "0.72941017150879"}
	warrior = {r = "0.78039044141769", g = "0.61176335811615", b = "0.43137159943581"}
	shaman = {r = "0", g = "0.4392147064209", b = "0.87058633565903"}
	druid = {r = "0.99999779462814", g = "0.49019500613213", b = "0.039215601980686"}
	deathknight = {r = "0.76862573623657", g = "0.1215683594346", b = "0.23137204349041"}
	demonhunter = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"}
	monk = {r = "0", g = "0.99999779462814", b = "0.59607714414597"}
	rogue = {r = "0.99999779462814", g = "0.96078222990036", b = "0.41176378726959"}
	priest = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"}
	mage = {r = "0.25097984075546", g = "0.78039044141769", b = "0.92156660556793"}
	hunter = {r = "0.67058676481247", g = "0.8313707113266", b = "0.45097941160202"}
	warlock = {r = "0.52941060066223", g = "0.52941060066223", b = "0.92940974235535"}
	npchostile = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"}
	npcneutral = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"}
	npcfriendly = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"}
	goodthreat = {r = "0.27843075990677", g = "0.99999779462814", b = "0"}
	badthreat = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"}
	goodtransition = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"}
	badtransition = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"}
end

local nameplatecustomgradients = {
	["WARRIOR"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["PALADIN"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["HUNTER"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["ROGUE"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["PRIEST"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["DEATHKNIGHT"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["SHAMAN"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["MAGE"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["WARLOCK"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["MONK"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["DRUID"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["DEMONHUNTER"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["NPCFRIENDLY"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["NPCNEUTRAL"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["NPCUNFRIENDLY"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	["NPCHOSTILE"] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
}
local nameplategradients = {
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
	["NPCNEUTRAL"] = {r1 = 0.712358744169101, g1 = 0.63137254901961, b1 = 0.15490196078431, r2 = 1, g2 = 0.85686274509804, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	["NPCHOSTILE"] = {r1 = 0.31764705882353, g1 = 0.066666666666667, b1 = 0.07843137254902, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
}

function ElvUI_EltreumUI:NPGradientColorTableUpdate()
	nameplatecustomgradients = {
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
	}

	if E.db.ElvUI_EltreumUI.darkmode then
		if E.Retail then
			paladin = {r = "0.71764546632767", g = "0.41176378726959", b = "0.54509681463242"}
			warrior = {r = "0.58039087057114", g = "0.45490095019341", b = "0.32156792283058"}
			shaman = {r = "0", g = "0.32941102981567", b = "0.65097898244858"}
			druid = {r = "0.74901795387268", g = "0.36470508575439", b = "0.027450919151306"}
			deathknight = {r = "0.57646930217743", g = "0.086274318397045", b = "0.16862708330154"}
			demonhunter = {r = "0.47843033075333", g = "0.14117616415024", b = "0.59215557575226"}
			monk = {r = "0", g = "0.74901795387268", b = "0.44705784320831"}
			rogue = {r = "0.74901795387268", g = "0.71764546632767", b = "0.30588167905807"}
			priest = {r = "0.74901795387268", g = "0.74901795387268", b = "0.74901795387268"}
			mage = {r = "0.18431332707405", g = "0.58431243896484", b = "0.69019454717636"}
			hunter = {r = "0.49803811311722", g = "0.61960649490356", b = "0.33333259820938"}
			warlock = {r = "0.39607757329941", g = "0.39999911189079", b = "0.69803768396378"}
		elseif E.Wrath or E.TBC or E.Classic then
			paladin = {r = "0.72156703472137", g = "0.41176378726959", b = "0.54901838302612"}
			warrior = {r = "0.58431243896484", g = "0.45882251858711", b = "0.32156792283058"}
			shaman = {r = "0", g = "0.32941102981567", b = "0.65097898244858"}
			druid = {r = "0.74901795387268", g = "0.3686266541481", b = "0.031372480094433"}
			deathknight = {r = "0.57646930217743", g = "0.090195879340172", b = "0.17254863679409"}
			demonhunter = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"}
			monk = {r = "0", g = "0.99999779462814", b = "0.59607714414597"}
			rogue = {r = "0.74901795387268", g = "0.72156703472137", b = "0.30588167905807"}
			priest = {r = "0.74901795387268", g = "0.74901795387268", b = "0.74901795387268"}
			mage = {r = "0.1882348805666", g = "0.58431243896484", b = "0.69019454717636"}
			hunter = {r = "0.50195968151093", g = "0.62352806329727", b = "0.33725416660309"}
			warlock = {r = "0.39607757329941", g = "0.39607757329941", b = "0.69803768396378"}
		end
	end
end

local EltruismNPGradientColorTableLoad = CreateFrame("FRAME")
EltruismNPGradientColorTableLoad:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismNPGradientColorTableLoad:RegisterEvent("PLAYER_STARTED_MOVING")
EltruismNPGradientColorTableLoad:SetScript("OnEvent", function()
	EltruismNPGradientColorTableLoad:UnregisterAllEvents()
	ElvUI_EltreumUI:NPGradientColorTableUpdate()
end)

--gradient nameplates
--will need to check eltreumtarget and elvui_boss style filters due to health colors
local NP = E:GetModule('NamePlates')
local function testfunc(unit)
	if unit and unit.Health then
		local r, g, b = unit.Health:GetStatusBarColor()
		r = tostring(r)
		g = tostring(g)
		b = tostring(b)
		--print(r,g,b)
		--trying to get the unit's class results in a table with user data, so the unit is not the actual unit

		if ((r == paladin.r) and (g == paladin.g) and (b == paladin.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["PALADIN"]["r1"], nameplatecustomgradients["PALADIN"]["g1"], nameplatecustomgradients["PALADIN"]["b1"], nameplatecustomgradients["PALADIN"]["r2"], nameplatecustomgradients["PALADIN"]["g2"], nameplatecustomgradients["PALADIN"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["PALADIN"]["r1"], nameplategradients["PALADIN"]["g1"], nameplategradients["PALADIN"]["b1"], nameplategradients["PALADIN"]["r2"], nameplategradients["PALADIN"]["g2"], nameplategradients["PALADIN"]["b2"])
			end
		elseif ((r == warrior.r) and (g == warrior.g) and (b == warrior.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["WARRIOR"]["r1"], nameplatecustomgradients["WARRIOR"]["g1"], nameplatecustomgradients["WARRIOR"]["b1"], nameplatecustomgradients["WARRIOR"]["r2"], nameplatecustomgradients["WARRIOR"]["g2"], nameplatecustomgradients["WARRIOR"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["WARRIOR"]["r1"], nameplategradients["WARRIOR"]["g1"], nameplategradients["WARRIOR"]["b1"], nameplategradients["WARRIOR"]["r2"], nameplategradients["WARRIOR"]["g2"], nameplategradients["WARRIOR"]["b2"])
			end
		elseif ((r == shaman.r) and (g == shaman.g) and (b == shaman.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["SHAMAN"]["r1"], nameplatecustomgradients["SHAMAN"]["g1"], nameplatecustomgradients["SHAMAN"]["b1"], nameplatecustomgradients["SHAMAN"]["r2"], nameplatecustomgradients["SHAMAN"]["g2"], nameplatecustomgradients["SHAMAN"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["SHAMAN"]["r1"], nameplategradients["SHAMAN"]["g1"], nameplategradients["SHAMAN"]["b1"], nameplategradients["SHAMAN"]["r2"], nameplategradients["SHAMAN"]["g2"], nameplategradients["SHAMAN"]["b2"])
			end
		elseif ((r == druid.r) and (g == druid.g) and (b == druid.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["DRUID"]["r1"], nameplatecustomgradients["DRUID"]["g1"], nameplatecustomgradients["DRUID"]["b1"], nameplatecustomgradients["DRUID"]["r2"], nameplatecustomgradients["DRUID"]["g2"], nameplatecustomgradients["DRUID"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["DRUID"]["r1"], nameplategradients["DRUID"]["g1"], nameplategradients["DRUID"]["b1"], nameplategradients["DRUID"]["r2"], nameplategradients["DRUID"]["g2"], nameplategradients["DRUID"]["b2"])
			end
		elseif ((r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["DEATHKNIGHT"]["r1"], nameplatecustomgradients["DEATHKNIGHT"]["g1"], nameplatecustomgradients["DEATHKNIGHT"]["b1"], nameplatecustomgradients["DEATHKNIGHT"]["r2"], nameplatecustomgradients["DEATHKNIGHT"]["g2"], nameplatecustomgradients["DEATHKNIGHT"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["DEATHKNIGHT"]["r1"], nameplategradients["DEATHKNIGHT"]["g1"], nameplategradients["DEATHKNIGHT"]["b1"], nameplategradients["DEATHKNIGHT"]["r2"], nameplategradients["DEATHKNIGHT"]["g2"], nameplategradients["DEATHKNIGHT"]["b2"])
			end
		elseif ((r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["DEMONHUNTER"]["r1"], nameplatecustomgradients["DEMONHUNTER"]["g1"], nameplatecustomgradients["DEMONHUNTER"]["b1"], nameplatecustomgradients["DEMONHUNTER"]["r2"], nameplatecustomgradients["DEMONHUNTER"]["g2"], nameplatecustomgradients["DEMONHUNTER"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["DEMONHUNTER"]["r1"], nameplategradients["DEMONHUNTER"]["g1"], nameplategradients["DEMONHUNTER"]["b1"], nameplategradients["DEMONHUNTER"]["r2"], nameplategradients["DEMONHUNTER"]["g2"], nameplategradients["DEMONHUNTER"]["b2"])
			end
		elseif ((r == monk.r) and (g == monk.g) and (b == monk.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["MONK"]["r1"], nameplatecustomgradients["MONK"]["g1"], nameplatecustomgradients["MONK"]["b1"], nameplatecustomgradients["MONK"]["r2"], nameplatecustomgradients["MONK"]["g2"], nameplatecustomgradients["MONK"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["MONK"]["r1"], nameplategradients["MONK"]["g1"], nameplategradients["MONK"]["b1"], nameplategradients["MONK"]["r2"], nameplategradients["MONK"]["g2"], nameplategradients["MONK"]["b2"])
			end
		elseif ((r == rogue.r) and (g == rogue.g) and (b == rogue.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["ROGUE"]["r1"], nameplatecustomgradients["ROGUE"]["g1"], nameplatecustomgradients["ROGUE"]["b1"], nameplatecustomgradients["ROGUE"]["r2"], nameplatecustomgradients["ROGUE"]["g2"], nameplatecustomgradients["ROGUE"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["ROGUE"]["r1"], nameplategradients["ROGUE"]["g1"], nameplategradients["ROGUE"]["b1"], nameplategradients["ROGUE"]["r2"], nameplategradients["ROGUE"]["g2"], nameplategradients["ROGUE"]["b2"])
			end
		--[[elseif ((r == priest.r) and (g == priest.g) and (b == priest.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["PRIEST"]["r1"], nameplatecustomgradients["PRIEST"]["g1"], nameplatecustomgradients["PRIEST"]["b1"], nameplatecustomgradients["PRIEST"]["r2"], nameplatecustomgradients["PRIEST"]["g2"], nameplatecustomgradients["PRIEST"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["PRIEST"]["r1"], nameplategradients["PRIEST"]["g1"], nameplategradients["PRIEST"]["b1"], nameplategradients["PRIEST"]["r2"], nameplategradients["PRIEST"]["g2"], nameplategradients["PRIEST"]["b2"])
			end]]
		elseif ((r == mage.r) and (g == mage.g) and (b == mage.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["MAGE"]["r1"], nameplatecustomgradients["MAGE"]["g1"], nameplatecustomgradients["MAGE"]["b1"], nameplatecustomgradients["MAGE"]["r2"], nameplatecustomgradients["MAGE"]["g2"], nameplatecustomgradients["MAGE"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["MAGE"]["r1"], nameplategradients["MAGE"]["g1"], nameplategradients["MAGE"]["b1"], nameplategradients["MAGE"]["r2"], nameplategradients["MAGE"]["g2"], nameplategradients["MAGE"]["b2"])
			end
		elseif ((r == hunter.r) and (g == hunter.g) and (b == hunter.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["HUNTER"]["r1"], nameplatecustomgradients["HUNTER"]["g1"], nameplatecustomgradients["HUNTER"]["b1"], nameplatecustomgradients["HUNTER"]["r2"], nameplatecustomgradients["HUNTER"]["g2"], nameplatecustomgradients["HUNTER"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["HUNTER"]["r1"], nameplategradients["HUNTER"]["g1"], nameplategradients["HUNTER"]["b1"], nameplategradients["HUNTER"]["r2"], nameplategradients["HUNTER"]["g2"], nameplategradients["HUNTER"]["b2"])
			end
		elseif ((r == warlock.r) and (g == warlock.g) and (b == warlock.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["WARLOCK"]["r1"], nameplatecustomgradients["WARLOCK"]["g1"], nameplatecustomgradients["WARLOCK"]["b1"], nameplatecustomgradients["WARLOCK"]["r2"], nameplatecustomgradients["WARLOCK"]["g2"], nameplatecustomgradients["WARLOCK"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["WARLOCK"]["r1"], nameplategradients["WARLOCK"]["g1"], nameplategradients["WARLOCK"]["b1"], nameplategradients["WARLOCK"]["r2"], nameplategradients["WARLOCK"]["g2"], nameplategradients["WARLOCK"]["b2"])
			end
		elseif ((r == npchostile.r) and (g == npchostile.g) and (b == npchostile.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["NPCHOSTILE"]["r1"], nameplatecustomgradients["NPCHOSTILE"]["g1"], nameplatecustomgradients["NPCHOSTILE"]["b1"], nameplatecustomgradients["NPCHOSTILE"]["r2"], nameplatecustomgradients["NPCHOSTILE"]["g2"], nameplatecustomgradients["NPCHOSTILE"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["NPCHOSTILE"]["r1"], nameplategradients["NPCHOSTILE"]["g1"], nameplategradients["NPCHOSTILE"]["b1"], nameplategradients["NPCHOSTILE"]["r2"], nameplategradients["NPCHOSTILE"]["g2"], nameplategradients["NPCHOSTILE"]["b2"])
			end
		elseif ((r == npcneutral.r) and (g == npcneutral.g) and (b == npcneutral.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["NPCNEUTRAL"]["r1"], nameplatecustomgradients["NPCNEUTRAL"]["g1"], nameplatecustomgradients["NPCNEUTRAL"]["b1"], nameplatecustomgradients["NPCNEUTRAL"]["r2"], nameplatecustomgradients["NPCNEUTRAL"]["g2"], nameplatecustomgradients["NPCNEUTRAL"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["NPCNEUTRAL"]["r1"], nameplategradients["NPCNEUTRAL"]["g1"], nameplategradients["NPCNEUTRAL"]["b1"], nameplategradients["NPCNEUTRAL"]["r2"], nameplategradients["NPCNEUTRAL"]["g2"], nameplategradients["NPCNEUTRAL"]["b2"])
			end
		elseif ((r == npcfriendly.r) and (g == npcfriendly.g) and (b == npcfriendly.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["NPCFRIENDLY"]["r1"], nameplatecustomgradients["NPCFRIENDLY"]["g1"], nameplatecustomgradients["NPCFRIENDLY"]["b1"], nameplatecustomgradients["NPCFRIENDLY"]["r2"], nameplatecustomgradients["NPCFRIENDLY"]["g2"], nameplatecustomgradients["NPCFRIENDLY"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["NPCFRIENDLY"]["r1"], nameplategradients["NPCFRIENDLY"]["g1"], nameplategradients["NPCFRIENDLY"]["b1"], nameplategradients["NPCFRIENDLY"]["r2"], nameplategradients["NPCFRIENDLY"]["g2"], nameplategradients["NPCFRIENDLY"]["b2"])
			end
		--[[elseif ((r == goodthreat.r) and (g == goodthreat.g) and (b == goodthreat.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["NPCFRIENDLY"]["r1"], nameplatecustomgradients["NPCFRIENDLY"]["g1"], nameplatecustomgradients["NPCFRIENDLY"]["b1"], nameplatecustomgradients["NPCFRIENDLY"]["r2"], nameplatecustomgradients["NPCFRIENDLY"]["g2"], nameplatecustomgradients["NPCFRIENDLY"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["NPCFRIENDLY"]["r1"], nameplategradients["NPCFRIENDLY"]["g1"], nameplategradients["NPCFRIENDLY"]["b1"], nameplategradients["NPCFRIENDLY"]["r2"], nameplategradients["NPCFRIENDLY"]["g2"], nameplategradients["NPCFRIENDLY"]["b2"])
			end]]
		end


		--goodthreat, goodtransition, badtransition, badthreat

	end
end
hooksecurefunc(NP, "Health_UpdateColor", testfunc)
--hooksecurefunc(NP, "Update_StatusBars", testfunc)
--hooksecurefunc(NP, "SetupTarget", testfunc)
--hooksecurefunc(NP, "UpdateTargetPlate", testfunc)
--hooksecurefunc(NP, "Update_ThreatIndicator", testfunc)
--hooksecurefunc(NP, "ThreatIndicator_PostUpdate", testfunc)
--hooksecurefunc(NP, "UpdatePlateSize", testfunc)
--hooksecurefunc(NP, "Style", testfunc)
--hooksecurefunc(NP, "StyleTargetPlate", testfunc)
--hooksecurefunc(NP, "UpdatePlate", testfunc)
--hooksecurefunc(mod, "StyleFilterUpdate", testfunc)
