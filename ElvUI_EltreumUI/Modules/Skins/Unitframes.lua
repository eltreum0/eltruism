local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')

--color unitframes target texture during light mode
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
}

--bar colors for party/raid/raid40
--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
local paladin, warrior, shaman, druid, deathknight, demonhunter, monk, rogue, priest, mage, hunter, warlock
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
elseif E.TBC or E.Classic then
	paladin = {r = "0.96078222990036", g = "0.54901838302612", b = "0.72941017150879"}
	warrior = {r = "0.78039044141769", g = "0.61176335811615", b = "0.43137159943581"}
	shaman = {r = "0", g = "0.4392147064209", b = "0.87058633565903"}
	druid = {r = "0.99999779462814", g = "0.49019500613213", b = "0.039215601980686"}
	deathknight = {r = "0.76862573623657", g = "0.11764679849148", b = "0.2274504750967"}
	demonhunter = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"}
	monk = {r = "0", g = "0.99999779462814", b = "0.59607714414597"}
	rogue = {r = "0.99999779462814", g = "0.96078222990036", b = "0.41176378726959"}
	priest = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"}
	mage = {r = "0.25097984075546", g = "0.78039044141769", b = "0.92156660556793"}
	hunter = {r = "0.67058676481247", g = "0.8313707113266", b = "0.45097941160202"}
	warlock = {r = "0.52941060066223", g = "0.52941060066223", b = "0.92940974235535"}
end

local unitframecustomgradients = {
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
	["NPCNEUTRAL"] = {r1 = 0.712358744169101, g1 = 0.63137254901961, b1 = 0.15490196078431, r2 = 1, g2 = 0.85686274509804, b2 = 0.2078431372549},
	["NPCUNFRIENDLY"] = {r1 = 0.84313725490196, g1 = 0.30196078431373, b1 = 0, r2 = 0.83137254901961, g2 = 0.45882352941176, b2 = 0},
	["NPCHOSTILE"] = {r1 = 0.31764705882353, g1 = 0.066666666666667, b1 = 0.07843137254902, r2 = 1, g2 = 0.15686274509804, b2 = 0.15686274509804},
}

function ElvUI_EltreumUI:GradientColorTableUpdate()
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
		elseif E.TBC or E.Classic then
			paladin = {r = "0.72156703472137", g = "0.41176378726959", b = "0.54901838302612"}
			warrior = {r = "0.58431243896484", g = "0.45882251858711", b = "0.32156792283058"}
			shaman = {r = "0", g = "0.32941102981567", b = "0.65097898244858"}
			druid = {r = "0.74901795387268", g = "0.3686266541481", b = "0.031372480094433"}
			deathknight = {r = "0.76862573623657", g = "0.11764679849148", b = "0.2274504750967"}
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

local EltruismGradientColorTableLoad = CreateFrame("FRAME")
EltruismGradientColorTableLoad:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismGradientColorTableLoad:RegisterEvent("PLAYER_STARTED_MOVING")
EltruismGradientColorTableLoad:SetScript("OnEvent", function()
	EltruismGradientColorTableLoad:UnregisterAllEvents()
	ElvUI_EltreumUI:GradientColorTableUpdate()
end)

--Databar gradient
function ElvUI_EltreumUI:GradientDatabar()
	local databarXP = _G["ElvUI_ExperienceBar"]
	if databarXP and E.db.ElvUI_EltreumUI.gradientmode.gradientXP then
		databarXP:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.experience.r, E.db.databars.colors.experience.g, E.db.databars.colors.experience.b, E.db.databars.colors.experience.a, 0.8, 0.4, 1, E.db.databars.colors.experience.a)
	end
end
local DB = E:GetModule('DataBars')
hooksecurefunc(DB, 'ExperienceBar_Update', ElvUI_EltreumUI.GradientDatabar)

--elvui castbar texture/gradient
function ElvUI_EltreumUI:CastBarTexture()
	local castbar = _G["ElvUF_Player_CastBar"]
	local targetcastbar = _G["ElvUF_Target_CastBar"]

	--spark
	if E.db.ElvUI_EltreumUI.sparkcustomcolor.enable and E.private.unitframe.enable then
		--castbar.Spark_ = castbar:CreateTexture(nil, 'OVERLAY')
		--castbar.Spark_:SetTexture(E.media.blankTex)
		castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.sparkcustomcolor.b, 1)
		castbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.sparkcustomcolor.width)

		if UnitExists("target") then
			targetcastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.sparkcustomcolor.b, 1)
			targetcastbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.sparkcustomcolor.width)
		end
	end

	--gradient/texture
	if E.db.ElvUI_EltreumUI.UFmodifications then
		if E.db.ElvUI_EltreumUI.ufcustomtexture.enable and (not E.db.ElvUI_EltreumUI.gradientmode.enable) then
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture))
		end

		--player
		if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar and (not E.db.ElvUI_EltreumUI.ufcustomtexture.enable) then
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
			local r,g,b = _G["ElvUF_Player_CastBar"]:GetStatusBarColor()
			local r1 = tostring(r)
			local g1 = tostring(g)
			local b1 = tostring(b)
			if (r1 == "0.78039044141769" and g1 == "0.25097984075546" and b1 == "0.25097984075546") then --cant interrupt
				return
			elseif r1 == "0.30196011066437" and g1 == "0.30196011066437" and b1 == "0.30196011066437" then --interrupted/failed
				return
			else
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2, E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
				else
					castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
				end
			end
		end

		--target
		if UnitExists("target") then
			local _, targetclass = UnitClass("target")
			local reactiontarget = UnitReaction("player", "target")
			if E.db.ElvUI_EltreumUI.ufcustomtexture.enable and (not E.db.ElvUI_EltreumUI.gradientmode.enable) then
				targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture))
			end
			if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar and (not E.db.ElvUI_EltreumUI.ufcustomtexture.enable) then
				targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
				local r,g,b = _G["ElvUF_Target_CastBar"]:GetStatusBarColor()
				local r1 = tostring(r)
				local g1 = tostring(g)
				local b1 = tostring(b)
				if (r1 == "0.78039044141769" and g1 == "0.25097984075546" and b1 == "0.25097984075546") then --cant interrupt
					return
				elseif r1 == "0.30196011066437" and g1 == "0.30196011066437" and b1 == "0.30196011066437" then --interrupted/failed
					return
				elseif E.db.unitframe.units.target.castbar.reverse == true then
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						if UnitIsPlayer("target") then
							targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"])
						else
							if reactiontarget >= 5 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
							elseif reactiontarget == 4 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"])
							elseif reactiontarget == 3 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"])
							elseif reactiontarget == 2 or reactiontarget == 1 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"])
							end
						end
					else
						if UnitIsPlayer("target") then
							targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"])
						else
							if reactiontarget >= 5 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"])
							elseif reactiontarget == 4 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"])
							elseif reactiontarget == 3 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"])
							elseif reactiontarget == 2 or reactiontarget == 1 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"])
							end
						end
					end

				elseif E.db.unitframe.units.target.castbar.reverse == false then
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						if UnitIsPlayer("target") then
							targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"])
						else
							if reactiontarget >= 5 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
							elseif reactiontarget == 4 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
							elseif reactiontarget == 3 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
							elseif reactiontarget == 2 or reactiontarget == 1 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
							end
						end
					else
						if UnitIsPlayer("target") then
							targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"])
						else
							if reactiontarget >= 5 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
							elseif reactiontarget == 4 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
							elseif reactiontarget == 3 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
							elseif reactiontarget == 2 or reactiontarget == 1 then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
							end
						end
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, 'PostCastStart', ElvUI_EltreumUI.CastBarTexture)
hooksecurefunc(UF, 'Construct_Castbar', ElvUI_EltreumUI.CastBarTexture)
--hooksecurefunc(UF, 'PostCastStop', ElvUI_EltreumUI.CastBarTexture)
--hooksecurefunc(UF, 'PostCastFail', ElvUI_EltreumUI.CastBarTexture)
--hooksecurefunc(UF, 'Configure_Castbar', ElvUI_EltreumUI.CastBarTexture)

function ElvUI_EltreumUI:ChangeUnitTexture()
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then

		--player
		local playertexture = unitframeclass[E.myclass]
		if UF.units.player then
			local unitframe = _G["ElvUF_Player"]
			if unitframe and unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					playertexture = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.playertexture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableplayer then
					if E.db.ElvUI_EltreumUI.lightmode then
						unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[E.myclass]["r1"], unitframecustomgradients[E.myclass]["g1"], unitframecustomgradients[E.myclass]["b1"], unitframecustomgradients[E.myclass]["r2"], unitframecustomgradients[E.myclass]["g2"], unitframecustomgradients[E.myclass]["b2"])
						else
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[E.myclass]["r1"], unitframecustomgradients[E.myclass]["g1"], unitframecustomgradients[E.myclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[E.myclass]["r2"], unitframecustomgradients[E.myclass]["g2"], unitframecustomgradients[E.myclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
		local reactiontarget = UnitReaction("player", "target")
		if UnitExists("target") then
			if UnitIsPlayer("target") then
				if targetclass then
					targetbar = unitframeclass[targetclass]
				end
			elseif not UnitIsPlayer("target") then
				if reactiontarget >= 5 then
					targetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga"
				elseif reactiontarget == 4 then
					targetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga"
				elseif reactiontarget == 3 then
					targetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga"
				elseif reactiontarget == 2 or reactiontarget == 1 then
					targetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga"
				end
			end
		end
		if UF.units.target and UnitExists("target") then
			local targetunitframe = _G["ElvUF_Target"]
			if targetunitframe and targetunitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					targetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettexture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("target") and E.db.ElvUI_EltreumUI.gradientmode.enabletarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"])
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"])
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("target")) and E.db.ElvUI_EltreumUI.gradientmode.enabletarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"])
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"])
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
		local reactiontargettarget = UnitReaction("player", "targettarget")
		local targettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if UnitExists("targettarget") then
			if UnitIsPlayer("targettarget") then
				if targettargetclass then
					targettargetbar = unitframeclass[targettargetclass]
				end
			elseif not UnitIsPlayer("targettarget") then
				if reactiontargettarget >= 5 then
					targettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga"
				elseif reactiontargettarget == 4 then
					targettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga"
				elseif reactiontargettarget == 3 then
					targettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga"
				elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
					targettargetbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga"
				end
			end
		end
		if UF.units.targettarget and UnitExists("targettarget") then
			local targettargetunitframe = _G["ElvUF_TargetTarget"]
			if targettargetunitframe and targettargetunitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					targettargetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettexture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("targettarget") and E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targettargetclass]["r1"], unitframecustomgradients[targettargetclass]["g1"], unitframecustomgradients[targettargetclass]["b1"], unitframecustomgradients[targettargetclass]["r2"], unitframecustomgradients[targettargetclass]["g2"], unitframecustomgradients[targettargetclass]["b2"])
						else
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targettargetclass]["r1"], unitframegradients[targettargetclass]["g1"], unitframegradients[targettargetclass]["b1"], unitframegradients[targettargetclass]["r2"], unitframegradients[targettargetclass]["g2"], unitframegradients[targettargetclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targettargetclass]["r1"], unitframecustomgradients[targettargetclass]["g1"], unitframecustomgradients[targettargetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targettargetclass]["r2"], unitframecustomgradients[targettargetclass]["g2"], unitframecustomgradients[targettargetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targettargetclass]["r1"], unitframegradients[targettargetclass]["g1"], unitframegradients[targettargetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targettargetclass]["r2"], unitframegradients[targettargetclass]["g2"], unitframegradients[targettargetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("targettarget")) and E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"])
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"])
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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

		--focus
		local _, focusclass = UnitClass("focus")
		local reactionfocus = UnitReaction("player", "focus")
		local focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if focusclass and UnitIsPlayer("focus") then
			focusbar = unitframeclass[focusclass]
		elseif not UnitIsPlayer("focus") and UnitExists("focus") then
			if reactionfocus >= 5 then
				focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga"
			elseif reactionfocus == 4 then
				focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga"
			elseif reactionfocus == 3 then
				focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga"
			elseif reactionfocus == 2 or reactionfocus == 1 then
				focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga"
			end
		end
		if UF.units.focus and UnitExists("focus") then
			local focusframe = _G["ElvUF_Focus"]
			if focusframe and focusframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					focusbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("focus") and E.db.ElvUI_EltreumUI.gradientmode.enablefocus then
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[focusclass]["r1"], unitframecustomgradients[focusclass]["g1"], unitframecustomgradients[focusclass]["b1"], unitframecustomgradients[focusclass]["r2"], unitframecustomgradients[focusclass]["g2"], unitframecustomgradients[focusclass]["b2"])
						else
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[focusclass]["r1"], unitframegradients[focusclass]["g1"], unitframegradients[focusclass]["b1"], unitframegradients[focusclass]["r2"], unitframegradients[focusclass]["g2"], unitframegradients[focusclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[focusclass]["r1"], unitframecustomgradients[focusclass]["g1"], unitframecustomgradients[focusclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[focusclass]["r2"], unitframecustomgradients[focusclass]["g2"], unitframecustomgradients[focusclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[focusclass]["r1"], unitframegradients[focusclass]["g1"], unitframegradients[focusclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[focusclass]["r2"], unitframegradients[focusclass]["g2"], unitframegradients[focusclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("focus")) and E.db.ElvUI_EltreumUI.gradientmode.enablefocus then
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
		local petbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga"
		if UF.units.pet then
			local petframe = _G["ElvUF_Pet"]
			if petframe and petframe.Health then
				if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableplayer then
					if E.db.ElvUI_EltreumUI.lightmode then
						petframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
						else
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						petframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
				arena1bar = unitframeclass[arena1class]
			end
			local arena1unitframe = _G["ElvUF_Arena1"]
			if arena1unitframe and arena1unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					arena1bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena1texture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena1") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena1unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"], unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"])
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"], unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"], unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"])
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"], unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena1unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
				arena2bar = unitframeclass[arena2class]
			end
			local arena2unitframe = _G["ElvUF_Arena2"]
			if arena2unitframe and arena2unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					arena2bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena2texture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena2") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena2unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"], unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"])
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"], unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"], unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"])
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"], unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena2unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
				arena3bar = unitframeclass[arena3class]
			end
			local arena3unitframe = _G["ElvUF_Arena3"]
			if arena3unitframe and arena3unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					arena3bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena3texture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena3") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena3unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"], unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"])
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"], unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"], unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"])
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"], unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena3unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
				arena4bar = unitframeclass[arena4class]
			end
			local arena4unitframe = _G["ElvUF_Arena4"]
			if arena4unitframe and arena4unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					arena4bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena4texture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena4") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena4unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena4class]["r2"], unitframecustomgradients[arena4class]["g2"], unitframecustomgradients[arena4class]["b2"], unitframecustomgradients[arena4class]["r1"], unitframecustomgradients[arena4class]["g1"], unitframecustomgradients[arena4class]["b1"])
							else
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena4class]["r1"], unitframecustomgradients[arena4class]["g1"], unitframecustomgradients[arena4class]["b1"], unitframecustomgradients[arena4class]["r2"], unitframecustomgradients[arena4class]["g2"], unitframecustomgradients[arena4class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena4class]["r2"], unitframegradients[arena4class]["g2"], unitframegradients[arena4class]["b2"], unitframegradients[arena4class]["r1"], unitframegradients[arena4class]["g1"], unitframegradients[arena4class]["b1"])
							else
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena4class]["r1"], unitframegradients[arena4class]["g1"], unitframegradients[arena4class]["b1"], unitframegradients[arena4class]["r2"], unitframegradients[arena4class]["g2"], unitframegradients[arena4class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena4unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena4class]["r2"], unitframecustomgradients[arena4class]["g2"], unitframecustomgradients[arena4class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena4class]["r1"], unitframecustomgradients[arena4class]["g1"], unitframecustomgradients[arena4class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena4class]["r1"], unitframecustomgradients[arena4class]["g1"], unitframecustomgradients[arena4class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena4class]["r2"], unitframecustomgradients[arena4class]["g2"], unitframecustomgradients[arena4class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena4class]["r2"], unitframegradients[arena4class]["g2"], unitframegradients[arena4class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena4class]["r1"], unitframegradients[arena4class]["g1"], unitframegradients[arena4class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena4class]["r1"], unitframegradients[arena4class]["g1"], unitframegradients[arena4class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena4class]["r2"], unitframegradients[arena4class]["g2"], unitframegradients[arena4class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
				arena5bar = unitframeclass[arena5class]
			end
			local arena5unitframe = _G["ElvUF_Arena5"]
			if arena5unitframe and arena5unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					arena5bar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.arena5texture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("arena5") and E.db.ElvUI_EltreumUI.gradientmode.enablearena then
					if E.db.ElvUI_EltreumUI.lightmode then
						arena5unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena5class]["r2"], unitframecustomgradients[arena5class]["g2"], unitframecustomgradients[arena5class]["b2"], unitframecustomgradients[arena5class]["r1"], unitframecustomgradients[arena5class]["g1"], unitframecustomgradients[arena5class]["b1"])
							else
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena5class]["r1"], unitframecustomgradients[arena5class]["g1"], unitframecustomgradients[arena5class]["b1"], unitframecustomgradients[arena5class]["r2"], unitframecustomgradients[arena5class]["g2"], unitframecustomgradients[arena5class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena5class]["r2"], unitframegradients[arena5class]["g2"], unitframegradients[arena5class]["b2"], unitframegradients[arena5class]["r1"], unitframegradients[arena5class]["g1"], unitframegradients[arena5class]["b1"])
							else
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena5class]["r1"], unitframegradients[arena5class]["g1"], unitframegradients[arena5class]["b1"], unitframegradients[arena5class]["r2"], unitframegradients[arena5class]["g2"], unitframegradients[arena5class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena5unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena5class]["r2"], unitframecustomgradients[arena5class]["g2"], unitframecustomgradients[arena5class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena5class]["r1"], unitframecustomgradients[arena5class]["g1"], unitframecustomgradients[arena5class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[arena5class]["r1"], unitframecustomgradients[arena5class]["g1"], unitframecustomgradients[arena5class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena5class]["r2"], unitframecustomgradients[arena5class]["g2"], unitframecustomgradients[arena5class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena5class]["r2"], unitframegradients[arena5class]["g2"], unitframegradients[arena5class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena5class]["r1"], unitframegradients[arena5class]["g1"], unitframegradients[arena5class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[arena5class]["r1"], unitframegradients[arena5class]["g1"], unitframegradients[arena5class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena5class]["r2"], unitframegradients[arena5class]["g2"], unitframegradients[arena5class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local bossbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga"
			local bossframe1 = _G["ElvUF_Boss1"]
			local reactionboss1 = UnitReaction("player", "boss1")
			if bossframe1 and reactionboss1 ~= nil then
				if bossframe1 and bossframe1.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe1.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss1 >= 5 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss1 == 4 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss1 == 3 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss1 == 2 or reactionfocus == 1 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss1 >= 5 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss1 == 4 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss1 == 3 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss1 == 2 or reactionfocus == 1 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe1.Health.backdropTex then
							bossframe1.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss1 >= 5 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss1 == 4 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss1 == 3 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss1 == 2 or reactionfocus == 1 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss1 >= 5 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss1 == 4 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss1 == 3 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss1 == 2 or reactionfocus == 1 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss2 = UnitReaction("player", "boss2")
			if bossframe2 and reactionboss2 ~= nil then
				if bossframe2 and bossframe2.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe2.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss2 >= 5 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss2 == 4 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss2 == 3 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss2 == 2 or reactionfocus == 1 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss2 >= 5 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss2 == 4 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss2 == 3 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss2 == 2 or reactionfocus == 1 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe2.Health.backdropTex then
							bossframe2.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss2 >= 5 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss2 == 4 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss2 == 3 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss2 == 2 or reactionfocus == 1 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss2 >= 5 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss2 == 4 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss2 == 3 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss2 == 2 or reactionfocus == 1 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss3 = UnitReaction("player", "boss3")
			if bossframe3 and reactionboss3 ~= nil then
				if bossframe3 and bossframe3.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe3.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss3 >= 5 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss3 == 4 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss3 == 3 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss3 == 2 or reactionfocus == 1 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss3 >= 5 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss3 == 4 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss3 == 3 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss3 == 2 or reactionfocus == 1 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe3.Health.backdropTex then
							bossframe3.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss3 >= 5 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss3 == 4 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss3 == 3 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss3 == 2 or reactionfocus == 1 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss3 >= 5 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss3 == 4 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss3 == 3 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss3 == 2 or reactionfocus == 1 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss4 = UnitReaction("player", "boss4")
			if bossframe4 and reactionboss4 ~= nil then
				if bossframe4 and bossframe4.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe4.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss4 >= 5 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss4 == 4 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss4 == 3 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss4 == 2 or reactionfocus == 1 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss4 >= 5 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss4 == 4 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss4 == 3 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss4 == 2 or reactionfocus == 1 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe4.Health.backdropTex then
							bossframe4.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss4 >= 5 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss4 == 4 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss4 == 3 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss4 == 2 or reactionfocus == 1 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss4 >= 5 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss4 == 4 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss4 == 3 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss4 == 2 or reactionfocus == 1 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss5 = UnitReaction("player", "boss5")
			if bossframe5 and reactionboss5 ~= nil then
				if bossframe5 and bossframe5.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe5.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss5 >= 5 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss5 == 4 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss5 == 3 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss5 == 2 or reactionfocus == 1 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss5 >= 5 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss5 == 4 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss5 == 3 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss5 == 2 or reactionfocus == 1 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe5.Health.backdropTex then
							bossframe5.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss5 >= 5 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss5 == 4 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss5 == 3 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss5 == 2 or reactionfocus == 1 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss5 >= 5 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss5 == 4 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss5 == 3 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss5 == 2 or reactionfocus == 1 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss6 = UnitReaction("player", "boss6")
			if bossframe6 and reactionboss6 ~= nil then
				if bossframe6 and bossframe6.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe6.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss6 >= 5 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss6 == 4 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss6 == 3 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss6 == 2 or reactionfocus == 1 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss6 >= 5 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss6 == 4 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss6 == 3 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss6 == 2 or reactionfocus == 1 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe6.Health.backdropTex then
							bossframe6.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss6 >= 5 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss6 == 4 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss6 == 3 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss6 == 2 or reactionfocus == 1 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss6 >= 5 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss6 == 4 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss6 == 3 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss6 == 2 or reactionfocus == 1 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss7 = UnitReaction("player", "boss7")
			if bossframe7 and reactionboss7 ~= nil then
				if bossframe7 and bossframe7.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe7.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss7 >= 5 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss7 == 4 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss7 == 3 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss7 == 2 or reactionfocus == 1 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss7 >= 5 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss7 == 4 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss7 == 3 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss7 == 2 or reactionfocus == 1 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe7.Health.backdropTex then
							bossframe7.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss7 >= 5 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss7 == 4 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss7 == 3 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss7 == 2 or reactionfocus == 1 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss7 >= 5 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss7 == 4 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss7 == 3 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss7 == 2 or reactionfocus == 1 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			local reactionboss8 = UnitReaction("player", "boss8")
			if bossframe8 and reactionboss8 ~= nil then
				if bossframe8 and bossframe8.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe8.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss8 >= 5 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss8 == 4 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss8 == 3 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss8 == 2 or reactionfocus == 1 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactionboss8 >= 5 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactionboss8 == 4 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactionboss8 == 3 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactionboss8 == 2 or reactionfocus == 1 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe8.Health.backdropTex then
							bossframe8.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss8 >= 5 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss8 == 4 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss8 == 3 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss8 == 2 or reactionfocus == 1 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactionboss8 >= 5 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss8 == 4 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss8 == 3 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactionboss8 == 2 or reactionfocus == 1 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
	end
end

function ElvUI_EltreumUI:ChangeGroupUnitframe(unit)--(unit, r, g, b)
	if E.private.unitframe.enable and UnitExists(unit) and E.db.ElvUI_EltreumUI.UFmodifications and (E.db.ElvUI_EltreumUI.lightmode or E.db.ElvUI_EltreumUI.darkmode) then
		--local header = nil
		local header = _G["ElvUF_Raid"] or _G["ElvUF_Raid40"] or _G["ElvUF_Party"] or _G["ElvUF_Tank"] or _G["ElvUF_Assist"]
		--[[if _G["ElvUF_Raid"] and _G["ElvUF_Raid"]:IsShown() then
			header = _G["ElvUF_Raid"]
		elseif _G["ElvUF_Raid40"] and _G["ElvUF_Raid40"]:IsShown() then
			header = _G["ElvUF_Raid40"]
		elseif _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsShown() then
			header = _G["ElvUF_Party"]
		end]]

		local _, unit1class = UnitClass(unit)
		if not unit1class then
			return
		end
		local truer = 0
		local trueg = 0
		local trueb = 0
		if E.db.ElvUI_EltreumUI.lightmode then
			if E. Retail then
				if unit1class == 'WARRIOR' then
					truer = 0.77646887302399
					trueg = 0.60784178972244
					trueb = 0.4274500310421
				elseif unit1class == 'PALADIN' then
					truer = 0.95686066150665
					trueg = 0.54901838302612
					trueb = 0.72941017150879
				elseif unit1class == 'HUNTER' then
					truer = 0.66666519641876
					trueg = 0.82744914293289
					trueb = 0.44705784320831
				elseif unit1class == 'ROGUE' then
					truer = 0.99999779462814
					trueg = 0.95686066150665
					trueb = 0.40784224867821
				elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.gradientmode.enable then --priest ruins everything gradient
					return
				elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.gradientmode.enable then
					truer = 0.99999779462814
					trueg = 0.99999779462814
					trueb = 0.99999779462814
				elseif unit1class == 'DEATHKNIGHT' then
					truer = 0.76862573623657
					trueg = 0.11764679849148
					trueb = 0.2274504750967
				elseif unit1class == 'SHAMAN' then
					truer = 0
					trueg = 0.4392147064209
					trueb = 0.86666476726532
				elseif unit1class == 'MAGE' then
					truer = 0.24705828726292
					trueg = 0.78039044141769
					trueb = 0.92156660556793
				elseif unit1class == 'WARLOCK' then
					truer = 0.52941060066223
					trueg = 0.53333216905594
					trueb = 0.93333131074905
				elseif unit1class == 'MONK' then
					truer = 0
					trueg = 0.99999779462814
					trueb = 0.59607714414597
				elseif unit1class == 'DRUID' then
					truer = 0.99999779462814
					trueg = 0.48627343773842
					trueb = 0.039215601980686
				elseif unit1class == 'DEMONHUNTER' then
					truer = 0.63921427726746
					trueg = 0.1882348805666
					trueb = 0.78823357820511
				end
			elseif E.TBC or E.Classic then
				if unit1class == 'WARRIOR' then
					truer = 0.78039044141769
					trueg = 0.61176335811615
					trueb = 0.43137159943581
				elseif unit1class == 'PALADIN' then
					truer = 0.96078222990036
					trueg = 0.54901838302612
					trueb = 0.72941017150879
				elseif unit1class == 'HUNTER' then
					truer = 0.67058676481247
					trueg = 0.8313707113266
					trueb = 0.45097941160202
				elseif unit1class == 'ROGUE' then
					truer = 0.99999779462814
					trueg = 0.96078222990036
					trueb = 0.41176378726959
				elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.gradientmode.enable then --priest ruins everything gradient
					return
				elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.gradientmode.enable then
					truer = 0.99999779462814
					trueg = 0.99999779462814
					trueb = 0.99999779462814
				elseif unit1class == 'SHAMAN' and E.TBC then
					truer = 0
					trueg = 0.4392147064209
					trueb = 0.87058633565903
				elseif unit1class == 'SHAMAN' and E.Classic then
					truer = 0.96078222990036
					trueg = 0.54901838302612
					trueb = 0.72941017150879
				elseif unit1class == 'MAGE' then
					truer = 0.25097984075546
					trueg = 0.78039044141769
					trueb = 0.92156660556793
				elseif unit1class == 'WARLOCK' then
					truer = 0.52941060066223
					trueg = 0.52941060066223
					trueb = 0.92940974235535
				elseif unit1class == 'DRUID' then
					truer = 0.99999779462814
					trueg = 0.49019500613213
					trueb = 0.039215601980686
				end
			end
		elseif E.db.ElvUI_EltreumUI.darkmode then
			if E. Retail then
				if unit1class == 'WARRIOR' then
					truer = 0.58039087057114
					trueg = 0.45490095019341
					trueb = 0.32156792283058
				elseif unit1class == 'PALADIN' then
					truer = 0.71764546632767
					trueg = 0.41176378726959
					trueb = 0.54509681463242
				elseif unit1class == 'HUNTER' then
					truer = 0.49803811311722
					trueg = 0.61960649490356
					trueb = 0.33333259820938
				elseif unit1class == 'ROGUE' then
					truer = 0.74901795387268
					trueg = 0.71764546632767
					trueb = 0.30588167905807
				elseif unit1class == 'PRIEST' then
					truer = 0.74901795387268
					trueg = 0.74901795387268
					trueb = 0.74901795387268
				elseif unit1class == 'DEATHKNIGHT' then
					truer = 0.57646930217743
					trueg = 0.086274318397045
					trueb = 0.16862708330154
				elseif unit1class == 'SHAMAN' then
					truer = 0
					trueg = 0.32941102981567
					trueb = 0.65097898244858
				elseif unit1class == 'MAGE' then
					truer = 0.18431332707405
					trueg = 0.58431243896484
					trueb = 0.69019454717636
				elseif unit1class == 'WARLOCK' then
					truer = 0.39607757329941
					trueg = 0.39999911189079
					trueb = 0.69803768396378
				elseif unit1class == 'MONK' then
					truer = 0
					trueg = 0.74901795387268
					trueb = 0.44705784320831
				elseif unit1class == 'DRUID' then
					truer = 0.74901795387268
					trueg = 0.36470508575439
					trueb = 0.027450919151306
				elseif unit1class == 'DEMONHUNTER' then
					truer = 0.47843033075333
					trueg = 0.14117616415024
					trueb = 0.59215557575226
				end
			elseif E.TBC or E.Classic then
				if unit1class == 'WARRIOR' then
					truer = 0.58431243896484
					trueg = 0.45882251858711
					trueb = 0.32156792283058
				elseif unit1class == 'PALADIN' then
					truer = 0.72156703472137
					trueg = 0.41176378726959
					trueb = 0.54901838302612
				elseif unit1class == 'HUNTER' then
					truer = 0.50195968151093
					trueg = 0.62352806329727
					trueb = 0.33725416660309
				elseif unit1class == 'ROGUE' then
					truer = 0.74901795387268
					trueg = 0.72156703472137
					trueb = 0.30588167905807
				elseif unit1class == 'PRIEST' then
					truer = 0.74901795387268
					trueg = 0.74901795387268
					trueb = 0.74901795387268
				elseif unit1class == 'SHAMAN' and E.TBC then
					truer = 0
					trueg = 0.32941102981567
					trueb = 0.65097898244858
				elseif unit1class == 'SHAMAN' and E.Classic then
					truer = 0.72156703472137
					trueg = 0.41176378726959
					trueb = 0.54901838302612
				elseif unit1class == 'MAGE' then
					truer = 0.1882348805666
					trueg = 0.58431243896484
					trueb = 0.69019454717636
				elseif unit1class == 'WARLOCK' then
					truer = 0.39607757329941
					trueg = 0.39607757329941
					trueb = 0.69803768396378
				elseif unit1class == 'DRUID' then
					truer = 0.74901795387268
					trueg = 0.3686266541481
					trueb = 0.031372480094433
				end
			end
		end

		if header ~= nil then
			for i = 1, header:GetNumChildren() do
				local group = select(i, header:GetChildren())
				for j = 1, group:GetNumChildren() do
					local unitbutton = select(j, group:GetChildren())
					if unitbutton and unitbutton.Health then
						local r1,g1,b1
						if E.db.ElvUI_EltreumUI.lightmode then
							r1,g1,b1 = unitbutton.Health:GetStatusBarColor()
						elseif E.db.ElvUI_EltreumUI.darkmode and unitbutton.Health.backdropTex then
							r1,g1,b1 = unitbutton.Health.backdropTex:GetVertexColor()
						end
						local r = tostring(r1)
						local g = tostring(g1)
						local b = tostring(b1)
						if tostring(g1) == tostring(trueg) and tostring(r1) == tostring(truer) and tostring(b1) == tostring(trueb) then
							if ((r == paladin.r) and (g == paladin.g) and (b == paladin.b)) or (r == unitframecustomgradients["PALADIN"]["r2"] and g == unitframecustomgradients["PALADIN"]["g2"] and b == unitframecustomgradients["PALADIN"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PALADIN"]["r1"], unitframecustomgradients["PALADIN"]["g1"], unitframecustomgradients["PALADIN"]["b1"], unitframecustomgradients["PALADIN"]["r2"], unitframecustomgradients["PALADIN"]["g2"], unitframecustomgradients["PALADIN"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PALADIN"]["r1"], unitframegradients["PALADIN"]["g1"], unitframegradients["PALADIN"]["b1"], unitframegradients["PALADIN"]["r2"], unitframegradients["PALADIN"]["g2"], unitframegradients["PALADIN"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PALADIN"]["r1"], unitframecustomgradients["PALADIN"]["g1"], unitframecustomgradients["PALADIN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["PALADIN"]["r2"], unitframecustomgradients["PALADIN"]["g2"], unitframecustomgradients["PALADIN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PALADIN"]["r1"], unitframegradients["PALADIN"]["g1"], unitframegradients["PALADIN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["PALADIN"]["r2"], unitframegradients["PALADIN"]["g2"], unitframegradients["PALADIN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
										end
									end
								end
							elseif ((r == warrior.r) and (g == warrior.g) and (b == warrior.b)) or (r == unitframecustomgradients["WARRIOR"]["r2"] and g == unitframecustomgradients["WARRIOR"]["g2"] and b == unitframecustomgradients["WARRIOR"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARRIOR"]["r1"], unitframecustomgradients["WARRIOR"]["g1"], unitframecustomgradients["WARRIOR"]["b1"], unitframecustomgradients["WARRIOR"]["r2"], unitframecustomgradients["WARRIOR"]["g2"], unitframecustomgradients["WARRIOR"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARRIOR"]["r1"], unitframegradients["WARRIOR"]["g1"], unitframegradients["WARRIOR"]["b1"], unitframegradients["WARRIOR"]["r2"], unitframegradients["WARRIOR"]["g2"], unitframegradients["WARRIOR"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARRIOR"]["r1"], unitframecustomgradients["WARRIOR"]["g1"], unitframecustomgradients["WARRIOR"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["WARRIOR"]["r2"], unitframecustomgradients["WARRIOR"]["g2"], unitframecustomgradients["WARRIOR"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARRIOR"]["r1"], unitframegradients["WARRIOR"]["g1"], unitframegradients["WARRIOR"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["WARRIOR"]["r2"], unitframegradients["WARRIOR"]["g2"], unitframegradients["WARRIOR"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
										end
									end
								end
							elseif ((r == shaman.r) and (g == shaman.g) and (b == shaman.b)) or (r == unitframecustomgradients["SHAMAN"]["r2"] and g == unitframecustomgradients["SHAMAN"]["g2"] and b == unitframecustomgradients["SHAMAN"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["SHAMAN"]["r1"], unitframecustomgradients["SHAMAN"]["g1"], unitframecustomgradients["SHAMAN"]["b1"], unitframecustomgradients["SHAMAN"]["r2"], unitframecustomgradients["SHAMAN"]["g2"], unitframecustomgradients["SHAMAN"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["SHAMAN"]["r1"], unitframegradients["SHAMAN"]["g1"], unitframegradients["SHAMAN"]["b1"], unitframegradients["SHAMAN"]["r2"], unitframegradients["SHAMAN"]["g2"], unitframegradients["SHAMAN"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["SHAMAN"]["r1"], unitframecustomgradients["SHAMAN"]["g1"], unitframecustomgradients["SHAMAN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["SHAMAN"]["r2"], unitframecustomgradients["SHAMAN"]["g2"], unitframecustomgradients["SHAMAN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["SHAMAN"]["r1"], unitframegradients["SHAMAN"]["g1"], unitframegradients["SHAMAN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["SHAMAN"]["r2"], unitframegradients["SHAMAN"]["g2"], unitframegradients["SHAMAN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
										end
									end
								end
							elseif ((r == druid.r) and (g == druid.g) and (b == druid.b)) or (r == unitframecustomgradients["DRUID"]["r2"] and g == unitframecustomgradients["DRUID"]["g2"] and b == unitframecustomgradients["DRUID"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DRUID"]["r1"], unitframecustomgradients["DRUID"]["g1"], unitframecustomgradients["DRUID"]["b1"], unitframecustomgradients["DRUID"]["r2"], unitframecustomgradients["DRUID"]["g2"], unitframecustomgradients["DRUID"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DRUID"]["r1"], unitframegradients["DRUID"]["g1"], unitframegradients["DRUID"]["b1"], unitframegradients["DRUID"]["r2"], unitframegradients["DRUID"]["g2"], unitframegradients["DRUID"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DRUID"]["r1"], unitframecustomgradients["DRUID"]["g1"], unitframecustomgradients["DRUID"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["DRUID"]["r2"], unitframecustomgradients["DRUID"]["g2"], unitframecustomgradients["DRUID"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DRUID"]["r1"], unitframegradients["DRUID"]["g1"], unitframegradients["DRUID"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["DRUID"]["r2"], unitframegradients["DRUID"]["g2"], unitframegradients["DRUID"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
										end
									end
								end
							elseif ((r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b)) or (r == unitframecustomgradients["DEATHKNIGHT"]["r2"] and g == unitframecustomgradients["DEATHKNIGHT"]["g2"] and b == unitframecustomgradients["DEATHKNIGHT"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEATHKNIGHT"]["r1"], unitframecustomgradients["DEATHKNIGHT"]["g1"], unitframecustomgradients["DEATHKNIGHT"]["b1"], unitframecustomgradients["DEATHKNIGHT"]["r2"], unitframecustomgradients["DEATHKNIGHT"]["g2"], unitframecustomgradients["DEATHKNIGHT"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEATHKNIGHT"]["r1"], unitframegradients["DEATHKNIGHT"]["g1"], unitframegradients["DEATHKNIGHT"]["b1"], unitframegradients["DEATHKNIGHT"]["r2"], unitframegradients["DEATHKNIGHT"]["g2"], unitframegradients["DEATHKNIGHT"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEATHKNIGHT"]["r1"], unitframecustomgradients["DEATHKNIGHT"]["g1"], unitframecustomgradients["DEATHKNIGHT"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["DEATHKNIGHT"]["r2"], unitframecustomgradients["DEATHKNIGHT"]["g2"], unitframecustomgradients["DEATHKNIGHT"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEATHKNIGHT"]["r1"], unitframegradients["DEATHKNIGHT"]["g1"], unitframegradients["DEATHKNIGHT"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["DEATHKNIGHT"]["r2"], unitframegradients["DEATHKNIGHT"]["g2"], unitframegradients["DEATHKNIGHT"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
										end
									end
								end
							elseif ((r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b)) or (r == unitframecustomgradients["DEMONHUNTER"]["r2"] and g == unitframecustomgradients["DEMONHUNTER"]["g2"] and b == unitframecustomgradients["DEMONHUNTER"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEMONHUNTER"]["r1"], unitframecustomgradients["DEMONHUNTER"]["g1"], unitframecustomgradients["DEMONHUNTER"]["b1"], unitframecustomgradients["DEMONHUNTER"]["r2"], unitframecustomgradients["DEMONHUNTER"]["g2"], unitframecustomgradients["DEMONHUNTER"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEMONHUNTER"]["r1"], unitframegradients["DEMONHUNTER"]["g1"], unitframegradients["DEMONHUNTER"]["b1"], unitframegradients["DEMONHUNTER"]["r2"], unitframegradients["DEMONHUNTER"]["g2"], unitframegradients["DEMONHUNTER"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEMONHUNTER"]["r1"], unitframecustomgradients["DEMONHUNTER"]["g1"], unitframecustomgradients["DEMONHUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["DEMONHUNTER"]["r2"], unitframecustomgradients["DEMONHUNTER"]["g2"], unitframecustomgradients["DEMONHUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEMONHUNTER"]["r1"], unitframegradients["DEMONHUNTER"]["g1"], unitframegradients["DEMONHUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["DEMONHUNTER"]["r2"], unitframegradients["DEMONHUNTER"]["g2"], unitframegradients["DEMONHUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
										end
									end
								end
							elseif ((r == monk.r) and (g == monk.g) and (b == monk.b)) or (r == unitframecustomgradients["MONK"]["r2"] and g == unitframecustomgradients["MONK"]["g2"] and b == unitframecustomgradients["MONK"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MONK"]["r1"], unitframecustomgradients["MONK"]["g1"], unitframecustomgradients["MONK"]["b1"], unitframecustomgradients["MONK"]["r2"], unitframecustomgradients["MONK"]["g2"], unitframecustomgradients["MONK"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MONK"]["r1"], unitframegradients["MONK"]["g1"], unitframegradients["MONK"]["b1"], unitframegradients["MONK"]["r2"], unitframegradients["MONK"]["g2"], unitframegradients["MONK"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MONK"]["r1"], unitframecustomgradients["MONK"]["g1"], unitframecustomgradients["MONK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["MONK"]["r2"], unitframecustomgradients["MONK"]["g2"], unitframecustomgradients["MONK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MONK"]["r1"], unitframegradients["MONK"]["g1"], unitframegradients["MONK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["MONK"]["r2"], unitframegradients["MONK"]["g2"], unitframegradients["MONK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
										end
									end
								end
							elseif ((r == rogue.r) and (g == rogue.g) and (b == rogue.b)) or (r == unitframecustomgradients["ROGUE"]["r2"] and g == unitframecustomgradients["ROGUE"]["g2"] and b == unitframecustomgradients["ROGUE"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["ROGUE"]["r1"], unitframecustomgradients["ROGUE"]["g1"], unitframecustomgradients["ROGUE"]["b1"], unitframecustomgradients["ROGUE"]["r2"], unitframecustomgradients["ROGUE"]["g2"], unitframecustomgradients["ROGUE"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["ROGUE"]["r1"], unitframegradients["ROGUE"]["g1"], unitframegradients["ROGUE"]["b1"], unitframegradients["ROGUE"]["r2"], unitframegradients["ROGUE"]["g2"], unitframegradients["ROGUE"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["ROGUE"]["r1"], unitframecustomgradients["ROGUE"]["g1"], unitframecustomgradients["ROGUE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["ROGUE"]["r2"], unitframecustomgradients["ROGUE"]["g2"], unitframecustomgradients["ROGUE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["ROGUE"]["r1"], unitframegradients["ROGUE"]["g1"], unitframegradients["ROGUE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["ROGUE"]["r2"], unitframegradients["ROGUE"]["g2"], unitframegradients["ROGUE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
										end
									end
								end
							elseif ((r == priest.r) and (g == priest.g) and (b == priest.b)) or (r == unitframecustomgradients["PRIEST"]["r2"] and g == unitframecustomgradients["PRIEST"]["g2"] and b == unitframecustomgradients["PRIEST"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PRIEST"]["r1"], unitframecustomgradients["PRIEST"]["g1"], unitframecustomgradients["PRIEST"]["b1"], unitframecustomgradients["PRIEST"]["r2"], unitframecustomgradients["PRIEST"]["g2"], unitframecustomgradients["PRIEST"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PRIEST"]["r1"], unitframegradients["PRIEST"]["g1"], unitframegradients["PRIEST"]["b1"], unitframegradients["PRIEST"]["r2"], unitframegradients["PRIEST"]["g2"], unitframegradients["PRIEST"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PRIEST"]["r1"], unitframecustomgradients["PRIEST"]["g1"], unitframecustomgradients["PRIEST"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["PRIEST"]["r2"], unitframecustomgradients["PRIEST"]["g2"], unitframecustomgradients["PRIEST"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PRIEST"]["r1"], unitframegradients["PRIEST"]["g1"], unitframegradients["PRIEST"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["PRIEST"]["r2"], unitframegradients["PRIEST"]["g2"], unitframegradients["PRIEST"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
										end
									end
								end
							elseif ((r == mage.r) and (g == mage.g) and (b == mage.b)) or (r == unitframecustomgradients["MAGE"]["r2"] and g == unitframecustomgradients["MAGE"]["g2"] and b == unitframecustomgradients["MAGE"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MAGE"]["r1"], unitframecustomgradients["MAGE"]["g1"], unitframecustomgradients["MAGE"]["b1"], unitframecustomgradients["MAGE"]["r2"], unitframecustomgradients["MAGE"]["g2"], unitframecustomgradients["MAGE"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MAGE"]["r1"], unitframegradients["MAGE"]["g1"], unitframegradients["MAGE"]["b1"], unitframegradients["MAGE"]["r2"], unitframegradients["MAGE"]["g2"], unitframegradients["MAGE"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MAGE"]["r1"], unitframecustomgradients["MAGE"]["g1"], unitframecustomgradients["MAGE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["MAGE"]["r2"], unitframecustomgradients["MAGE"]["g2"], unitframecustomgradients["MAGE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MAGE"]["r1"], unitframegradients["MAGE"]["g1"], unitframegradients["MAGE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["MAGE"]["r2"], unitframegradients["MAGE"]["g2"], unitframegradients["MAGE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
										end
									end
								end
							elseif ((r == hunter.r) and (g == hunter.g) and (b == hunter.b)) or (r == unitframecustomgradients["HUNTER"]["r2"] and g == unitframecustomgradients["HUNTER"]["g2"] and b == unitframecustomgradients["HUNTER"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["HUNTER"]["r1"], unitframecustomgradients["HUNTER"]["g1"], unitframecustomgradients["HUNTER"]["b1"], unitframecustomgradients["HUNTER"]["r2"], unitframecustomgradients["HUNTER"]["g2"], unitframecustomgradients["HUNTER"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["HUNTER"]["r1"], unitframegradients["HUNTER"]["g1"], unitframegradients["HUNTER"]["b1"], unitframegradients["HUNTER"]["r2"], unitframegradients["HUNTER"]["g2"], unitframegradients["HUNTER"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["HUNTER"]["r1"], unitframecustomgradients["HUNTER"]["g1"], unitframecustomgradients["HUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["HUNTER"]["r2"], unitframecustomgradients["HUNTER"]["g2"], unitframecustomgradients["HUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["HUNTER"]["r1"], unitframegradients["HUNTER"]["g1"], unitframegradients["HUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["HUNTER"]["r2"], unitframegradients["HUNTER"]["g2"], unitframegradients["HUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
										end
									end
								end
							elseif ((r == warlock.r) and (g == warlock.g) and (b == warlock.b)) or (r == unitframecustomgradients["WARLOCK"]["r2"] and g == unitframecustomgradients["WARLOCK"]["g2"] and b == unitframecustomgradients["WARLOCK"]["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									if E.db.ElvUI_EltreumUI.lightmode then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARLOCK"]["r1"], unitframecustomgradients["WARLOCK"]["g1"], unitframecustomgradients["WARLOCK"]["b1"], unitframecustomgradients["WARLOCK"]["r2"], unitframecustomgradients["WARLOCK"]["g2"], unitframecustomgradients["WARLOCK"]["b2"])
										else
											unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARLOCK"]["r1"], unitframegradients["WARLOCK"]["g1"], unitframegradients["WARLOCK"]["b1"], unitframegradients["WARLOCK"]["r2"], unitframegradients["WARLOCK"]["g2"], unitframegradients["WARLOCK"]["b2"])
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
										if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARLOCK"]["r1"], unitframecustomgradients["WARLOCK"]["g1"], unitframecustomgradients["WARLOCK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["WARLOCK"]["r2"], unitframecustomgradients["WARLOCK"]["g2"], unitframecustomgradients["WARLOCK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										else
											unitbutton.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARLOCK"]["r1"], unitframegradients["WARLOCK"]["g1"], unitframegradients["WARLOCK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["WARLOCK"]["r2"], unitframegradients["WARLOCK"]["g2"], unitframegradients["WARLOCK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
										end
									end
								elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
									if E.db.ElvUI_EltreumUI.lightmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
										else
											unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga")
										end
									elseif E.db.ElvUI_EltreumUI.darkmode then
										if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
											unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
										end
									end
								end
							else
								if E.db.ElvUI_EltreumUI.lightmode then
									--unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
									unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
								end
							end
						else --might be priest, use texture then if gradient, custom texture woulnt work because its class based and would force it on all
							if E.db.ElvUI_EltreumUI.gradientmode.enable then
								if E.db.ElvUI_EltreumUI.lightmode then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								elseif E.db.ElvUI_EltreumUI.darkmode and unitbutton.Health.backdropTex then
									unitbutton.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								end
							end
						end
					end
				end
			end
		end
	end
end

--Unitframe Backdrop Texture
function ElvUI_EltreumUI:BackdropTexture(_, _, backdropTex)
	if E.private.unitframe.enable and (not E.db.ElvUI_EltreumUI.lightmode) and E.db.ElvUI_EltreumUI.UFmodifications then
		if not E.db.ElvUI_EltreumUI.gradientmode.enable then
			backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
			backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
		end
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)

local EltruismChangeUnitTextureFrame = CreateFrame("FRAME")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_TARGET", "player")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_TARGET", "target")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismChangeUnitTextureFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EltruismChangeUnitTextureFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismChangeUnitTextureFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
EltruismChangeUnitTextureFrame:SetScript("OnEvent", function()
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then
		ElvUI_EltreumUI:ChangeUnitTexture()
		if IsInGroup() == true then
			ElvUI_EltreumUI:ChangeGroupUnitframe()
			--ElvUI_EltreumUI:ChangeTankUnitframe()
			--ElvUI_EltreumUI:ChangeAssistUnitframe()
		end
	end
end)


function ElvUI_EltreumUI:HookUFColor(unit)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications and (E.db.ElvUI_EltreumUI.lightmode or E.db.ElvUI_EltreumUI.darkmode) then
		ElvUI_EltreumUI:ChangeUnitTexture()
		if UnitExists(unit) then
			ElvUI_EltreumUI:ChangeGroupUnitframe(unit)
			--ElvUI_EltreumUI:ChangeTankUnitframe(unit)
			--ElvUI_EltreumUI:ChangeAssistUnitframe(unit)
		end
	end
end
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.HookUFColor)

hooksecurefunc(UF, "Style", ElvUI_EltreumUI.ChangeUnitTexture) --if not hooking into this then when the target of target changes it doesnt update


--light mode
--hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.ChangeUnitTexture)
--hooksecurefunc(UF, 'PostUpdateHealthColor', ElvUI_EltreumUI.ChangeGroupUnitframe)
--hooksecurefunc(UF, 'PostUpdateHealthColor', ElvUI_EltreumUI.ChangeTankUnitframe)
--hooksecurefunc(UF, 'PostUpdateHealthColor', ElvUI_EltreumUI.ChangeAssistUnitframe)


--[[
hooksecurefunc(UF, 'Update_RaidFrames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'Update_Raid40Frames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'Update_PartyFrames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'Update_TankFrames', ElvUI_EltreumUI.ChangeTankUnitframe)
hooksecurefunc(UF, 'Update_AssistFrames', ElvUI_EltreumUI.ChangeAssistUnitframe)

hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeTankUnitframe)
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeAssistUnitframe)

--dark mode
hooksecurefunc(UF, "PostUpdateHealth", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, 'PostUpdateHealth', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'PostUpdateHealth', ElvUI_EltreumUI.ChangeTankUnitframe)
hooksecurefunc(UF, 'PostUpdateHealth', ElvUI_EltreumUI.ChangeAssistUnitframe)

--arena
hooksecurefunc(UF, 'Update_ArenaFrames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'Construct_ArenaFrames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'PostUpdateArenaPreparation', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'PostUpdateArenaFrame', ElvUI_EltreumUI.ChangeGroupUnitframe)
]]
