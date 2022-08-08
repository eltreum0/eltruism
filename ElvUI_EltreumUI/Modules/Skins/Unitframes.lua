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

function ElvUI_EltreumUI:UnitframeClassTexture(unitclass)
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
		["NPCFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga",
		["NPCNEUTRAL"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga",
		["NPCUNFRIENDLY"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga",
		["NPCHOSTILE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga",
	}
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

	return unitframeclass[unitclass]
end

function ElvUI_EltreumUI:UnitframeClassTextureCustom(unitclass)
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
	return unitframeclasscustom[unitclass]
end

function ElvUI_EltreumUI:UnitframeClassColor(unitclass)
	local paladin, warrior, shaman, druid, deathknight, demonhunter, monk, rogue, priest, mage, hunter, warlock
	local npchostile, npcneutral, npcfriendly
	local goodthreat, goodtransition, badtransition, badthreat
	local offtank, offtankgoodtransition, offtankbadtransition
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
		--["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly)),
		["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
		["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
		["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
		["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
		["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
		--bar colors for party/raid/raid40
		--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
		--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
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
			--["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly)),
			["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
			["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
			["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
			["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
			["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
			--bar colors for party/raid/raid40
			--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
			--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
		}
	end
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
				--["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly)),
				["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
				["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
				["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
				["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
				["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
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
				--["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly)),
				["NPCHOSTILE"] = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"},
				["GOODTHREAT"] = {r = "0.27843075990677", g = "0.99999779462814", b = "0"},
				["BADTHREAT"] = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"},
				["GOODTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"},
				["BADTHREATTRANSITION"] = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"},
				--bar colors for party/raid/raid40
				--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
				--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842
			}
		end
	end
	return classtable[unitclass].r, classtable[unitclass].g, classtable[unitclass].b
end

function ElvUI_EltreumUI:GradientColors(unitclass)
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
	return unitframegradients[unitclass].r1, unitframegradients[unitclass].g1, unitframegradients[unitclass].b1, unitframegradients[unitclass].r2, unitframegradients[unitclass].g2, unitframegradients[unitclass].b2
end

function ElvUI_EltreumUI:GradientColorsCustom(unitclass, invert)
	local unitframecustomgradients = {
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

	if invert then
		return unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2, unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1
	else
		return unitframecustomgradients[unitclass].r1, unitframecustomgradients[unitclass].g1, unitframecustomgradients[unitclass].b1, unitframecustomgradients[unitclass].r2, unitframecustomgradients[unitclass].g2, unitframecustomgradients[unitclass].b2
	end
end

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
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))   --unitframecustomgradients[E.myclass]["r1"], unitframecustomgradients[E.myclass]["g1"], unitframecustomgradients[E.myclass]["b1"], unitframecustomgradients[E.myclass]["r2"], unitframecustomgradients[E.myclass]["g2"], unitframecustomgradients[E.myclass]["b2"])
						else
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))--unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))--unitframecustomgradients[E.myclass]["r1"], unitframecustomgradients[E.myclass]["g1"], unitframecustomgradients[E.myclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[E.myclass]["r2"], unitframecustomgradients[E.myclass]["g2"], unitframecustomgradients[E.myclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))--unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true))--unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"])
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))--unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true))--unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"])
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))--unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true))--unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass))--unitframecustomgradients[targetclass]["r1"], unitframecustomgradients[targetclass]["g1"], unitframecustomgradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targetclass]["r2"], unitframecustomgradients[targetclass]["g2"], unitframecustomgradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true))--unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))--unitframegradients[targetclass]["r1"], unitframegradients[targetclass]["g1"], unitframegradients[targetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targetclass]["r2"], unitframegradients[targetclass]["g2"], unitframegradients[targetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("target")) and E.db.ElvUI_EltreumUI.gradientmode.enabletarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))--unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))--unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))--unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"])
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))--unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true))--unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))--unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))--unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"])
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))--unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))--unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))--unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))--unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true))--unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))--unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))-- unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargetclass))--unitframecustomgradients[targettargetclass]["r1"], unitframecustomgradients[targettargetclass]["g1"], unitframecustomgradients[targettargetclass]["b1"], unitframecustomgradients[targettargetclass]["r2"], unitframecustomgradients[targettargetclass]["g2"], unitframecustomgradients[targettargetclass]["b2"])
						else
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargetclass))--unitframegradients[targettargetclass]["r1"], unitframegradients[targettargetclass]["g1"], unitframegradients[targettargetclass]["b1"], unitframegradients[targettargetclass]["r2"], unitframegradients[targettargetclass]["g2"], unitframegradients[targettargetclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargetclass))--unitframecustomgradients[targettargetclass]["r1"], unitframecustomgradients[targettargetclass]["g1"], unitframecustomgradients[targettargetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targettargetclass]["r2"], unitframecustomgradients[targettargetclass]["g2"], unitframecustomgradients[targettargetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargetclass))--unitframegradients[targettargetclass]["r1"], unitframegradients[targettargetclass]["g1"], unitframegradients[targettargetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targettargetclass]["r2"], unitframegradients[targettargetclass]["g2"], unitframegradients[targettargetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("targettarget")) and E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))--unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))--unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))--unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"])
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))--unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAl", true))--unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))--unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))--unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"])
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAl"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))--unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))--unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))--unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))--unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true))--unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))--unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))--unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
		local reactiontargettargettarget = UnitReaction("player", "targettargettarget")
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
							targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargettargetclass))--unitframecustomgradients[targettargettargetclass]["r1"], unitframecustomgradients[targettargettargetclass]["g1"], unitframecustomgradients[targettargettargetclass]["b1"], unitframecustomgradients[targettargettargetclass]["r2"], unitframecustomgradients[targettargettargetclass]["g2"], unitframecustomgradients[targettargettargetclass]["b2"])
						else
							targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors(targettargettargetclass))-- unitframegradients[targettargettargetclass]["r1"], unitframegradients[targettargettargetclass]["g1"], unitframegradients[targettargettargetclass]["b1"], unitframegradients[targettargettargetclass]["r2"], unitframegradients[targettargettargetclass]["g2"], unitframegradients[targettargettargetclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargettargetclass))--unitframecustomgradients[targettargettargetclass]["r1"], unitframecustomgradients[targettargettargetclass]["g1"], unitframecustomgradients[targettargettargetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[targettargettargetclass]["r2"], unitframecustomgradients[targettargettargetclass]["g2"], unitframecustomgradients[targettargettargetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargettargetclass))--unitframegradients[targettargettargetclass]["r1"], unitframegradients[targettargettargetclass]["g1"], unitframegradients[targettargettargetclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[targettargettargetclass]["r2"], unitframegradients[targettargettargetclass]["g2"], unitframegradients[targettargettargetclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))--unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"])
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAl", true))--unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"])
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))--unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"])
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))--unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"])
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))--unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))--unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))--unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))--unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true))--unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))--unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))--unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
		local reactionfocus = UnitReaction("player", "focus")
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
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass))--unitframecustomgradients[focusclass]["r1"], unitframecustomgradients[focusclass]["g1"], unitframecustomgradients[focusclass]["b1"], unitframecustomgradients[focusclass]["r2"], unitframecustomgradients[focusclass]["g2"], unitframecustomgradients[focusclass]["b2"])
						else
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass))--unitframegradients[focusclass]["r1"], unitframegradients[focusclass]["g1"], unitframegradients[focusclass]["b1"], unitframegradients[focusclass]["r2"], unitframegradients[focusclass]["g2"], unitframegradients[focusclass]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass))--unitframecustomgradients[focusclass]["r1"], unitframecustomgradients[focusclass]["g1"], unitframecustomgradients[focusclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[focusclass]["r2"], unitframecustomgradients[focusclass]["g2"], unitframecustomgradients[focusclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass))--unitframegradients[focusclass]["r1"], unitframegradients[focusclass]["g1"], unitframegradients[focusclass]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[focusclass]["r2"], unitframegradients[focusclass]["g2"], unitframegradients[focusclass]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("focus")) and E.db.ElvUI_EltreumUI.gradientmode.enablefocus then
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"])
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"])
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"])
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"])
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"])
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"])
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--unitframecustomgradients["NPCNEUTRAL"]["r1"], unitframecustomgradients["NPCNEUTRAL"]["g1"], unitframecustomgradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCNEUTRAL"]["r2"], unitframecustomgradients["NPCNEUTRAL"]["g2"], unitframecustomgradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))--unitframecustomgradients["NPCUNFRIENDLY"]["r1"], unitframecustomgradients["NPCUNFRIENDLY"]["g1"], unitframecustomgradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCUNFRIENDLY"]["r2"], unitframecustomgradients["NPCUNFRIENDLY"]["g2"], unitframecustomgradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--unitframecustomgradients["NPCHOSTILE"]["r1"], unitframecustomgradients["NPCHOSTILE"]["g1"], unitframecustomgradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCHOSTILE"]["r2"], unitframecustomgradients["NPCHOSTILE"]["g2"], unitframecustomgradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"],E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--unitframegradients["NPCNEUTRAL"]["r1"], unitframegradients["NPCNEUTRAL"]["g1"], unitframegradients["NPCNEUTRAL"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCNEUTRAL"]["r2"], unitframegradients["NPCNEUTRAL"]["g2"], unitframegradients["NPCNEUTRAL"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))--unitframegradients["NPCUNFRIENDLY"]["r1"], unitframegradients["NPCUNFRIENDLY"]["g1"], unitframegradients["NPCUNFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCUNFRIENDLY"]["r2"], unitframegradients["NPCUNFRIENDLY"]["g2"], unitframegradients["NPCUNFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--unitframegradients["NPCHOSTILE"]["r1"], unitframegradients["NPCHOSTILE"]["g1"], unitframegradients["NPCHOSTILE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCHOSTILE"]["r2"], unitframegradients["NPCHOSTILE"]["g2"], unitframegradients["NPCHOSTILE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))--unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"])
						else
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"])
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						petframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--unitframecustomgradients["NPCFRIENDLY"]["r1"], unitframecustomgradients["NPCFRIENDLY"]["g1"], unitframecustomgradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["NPCFRIENDLY"]["r2"], unitframecustomgradients["NPCFRIENDLY"]["g2"], unitframecustomgradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						else
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--unitframegradients["NPCFRIENDLY"]["r1"], unitframegradients["NPCFRIENDLY"]["g1"], unitframegradients["NPCFRIENDLY"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["NPCFRIENDLY"]["r2"], unitframegradients["NPCFRIENDLY"]["g2"], unitframegradients["NPCFRIENDLY"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, true))--unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"], unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"])
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class))--unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"], unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, true))--unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"], unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"])
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class))--unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"], unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena1unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, true))--unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class))--unitframecustomgradients[arena1class]["r1"], unitframecustomgradients[arena1class]["g1"], unitframecustomgradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena1class]["r2"], unitframecustomgradients[arena1class]["g2"], unitframecustomgradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, true))--unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class))--unitframegradients[arena1class]["r1"], unitframegradients[arena1class]["g1"], unitframegradients[arena1class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena1class]["r2"], unitframegradients[arena1class]["g2"], unitframegradients[arena1class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, true))--unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"], unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"])
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class))--unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"], unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, true))--unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"], unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"])
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class))--unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"], unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena2unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, true))--unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class))--unitframecustomgradients[arena2class]["r1"], unitframecustomgradients[arena2class]["g1"], unitframecustomgradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena2class]["r2"], unitframecustomgradients[arena2class]["g2"], unitframecustomgradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, true))--unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class))--unitframegradients[arena2class]["r1"], unitframegradients[arena2class]["g1"], unitframegradients[arena2class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena2class]["r2"], unitframegradients[arena2class]["g2"], unitframegradients[arena2class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, true))--unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"], unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"])
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class))--unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"], unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"])
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, true))--unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"], unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"])
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class))--unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"], unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"])
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena3unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, true))--unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class))--unitframecustomgradients[arena3class]["r1"], unitframecustomgradients[arena3class]["g1"], unitframecustomgradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients[arena3class]["r2"], unitframecustomgradients[arena3class]["g2"], unitframecustomgradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, true))--unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class))--unitframegradients[arena3class]["r1"], unitframegradients[arena3class]["g1"], unitframegradients[arena3class]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients[arena3class]["r2"], unitframegradients[arena3class]["g2"], unitframegradients[arena3class]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
			--local bossbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga"
			local bossbar = ElvUI_EltreumUI:UnitframeClassTexture("DEATHKNIGHT")
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
				elseif E.Wrath or E.TBC or E.Classic then
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
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.1215683594346
						trueb = 0.23137204349041
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
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
				elseif E.Wrath or E.TBC or E.Classic then
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
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.090195879340172
						trueb = 0.17254863679409
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
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

			local function ApplyGradientTexture(g1,b1,r1,r,g,b,button)
				if tostring(g1) == tostring(trueg) and tostring(r1) == tostring(truer) and tostring(b1) == tostring(trueb) then
					if ((r == paladin.r) and (g == paladin.g) and (b == paladin.b)) or (r == unitframecustomgradients["PALADIN"]["r2"] and g == unitframecustomgradients["PALADIN"]["g2"] and b == unitframecustomgradients["PALADIN"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PALADIN"]["r1"], unitframecustomgradients["PALADIN"]["g1"], unitframecustomgradients["PALADIN"]["b1"], unitframecustomgradients["PALADIN"]["r2"], unitframecustomgradients["PALADIN"]["g2"], unitframecustomgradients["PALADIN"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PALADIN"]["r1"], unitframegradients["PALADIN"]["g1"], unitframegradients["PALADIN"]["b1"], unitframegradients["PALADIN"]["r2"], unitframegradients["PALADIN"]["g2"], unitframegradients["PALADIN"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PALADIN"]["r1"], unitframecustomgradients["PALADIN"]["g1"], unitframecustomgradients["PALADIN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["PALADIN"]["r2"], unitframecustomgradients["PALADIN"]["g2"], unitframecustomgradients["PALADIN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PALADIN"]["r1"], unitframegradients["PALADIN"]["g1"], unitframegradients["PALADIN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["PALADIN"]["r2"], unitframegradients["PALADIN"]["g2"], unitframegradients["PALADIN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("PALADIN"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
								end
							end
						end
					elseif ((r == warrior.r) and (g == warrior.g) and (b == warrior.b)) or (r == unitframecustomgradients["WARRIOR"]["r2"] and g == unitframecustomgradients["WARRIOR"]["g2"] and b == unitframecustomgradients["WARRIOR"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARRIOR"]["r1"], unitframecustomgradients["WARRIOR"]["g1"], unitframecustomgradients["WARRIOR"]["b1"], unitframecustomgradients["WARRIOR"]["r2"], unitframecustomgradients["WARRIOR"]["g2"], unitframecustomgradients["WARRIOR"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARRIOR"]["r1"], unitframegradients["WARRIOR"]["g1"], unitframegradients["WARRIOR"]["b1"], unitframegradients["WARRIOR"]["r2"], unitframegradients["WARRIOR"]["g2"], unitframegradients["WARRIOR"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARRIOR"]["r1"], unitframecustomgradients["WARRIOR"]["g1"], unitframecustomgradients["WARRIOR"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["WARRIOR"]["r2"], unitframecustomgradients["WARRIOR"]["g2"], unitframecustomgradients["WARRIOR"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARRIOR"]["r1"], unitframegradients["WARRIOR"]["g1"], unitframegradients["WARRIOR"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["WARRIOR"]["r2"], unitframegradients["WARRIOR"]["g2"], unitframegradients["WARRIOR"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("WARRIOR"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
								end
							end
						end
					elseif ((r == shaman.r) and (g == shaman.g) and (b == shaman.b)) or (r == unitframecustomgradients["SHAMAN"]["r2"] and g == unitframecustomgradients["SHAMAN"]["g2"] and b == unitframecustomgradients["SHAMAN"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["SHAMAN"]["r1"], unitframecustomgradients["SHAMAN"]["g1"], unitframecustomgradients["SHAMAN"]["b1"], unitframecustomgradients["SHAMAN"]["r2"], unitframecustomgradients["SHAMAN"]["g2"], unitframecustomgradients["SHAMAN"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["SHAMAN"]["r1"], unitframegradients["SHAMAN"]["g1"], unitframegradients["SHAMAN"]["b1"], unitframegradients["SHAMAN"]["r2"], unitframegradients["SHAMAN"]["g2"], unitframegradients["SHAMAN"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["SHAMAN"]["r1"], unitframecustomgradients["SHAMAN"]["g1"], unitframecustomgradients["SHAMAN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["SHAMAN"]["r2"], unitframecustomgradients["SHAMAN"]["g2"], unitframecustomgradients["SHAMAN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["SHAMAN"]["r1"], unitframegradients["SHAMAN"]["g1"], unitframegradients["SHAMAN"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["SHAMAN"]["r2"], unitframegradients["SHAMAN"]["g2"], unitframegradients["SHAMAN"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("SHAMAN"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
								end
							end
						end
					elseif ((r == druid.r) and (g == druid.g) and (b == druid.b)) or (r == unitframecustomgradients["DRUID"]["r2"] and g == unitframecustomgradients["DRUID"]["g2"] and b == unitframecustomgradients["DRUID"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DRUID"]["r1"], unitframecustomgradients["DRUID"]["g1"], unitframecustomgradients["DRUID"]["b1"], unitframecustomgradients["DRUID"]["r2"], unitframecustomgradients["DRUID"]["g2"], unitframecustomgradients["DRUID"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DRUID"]["r1"], unitframegradients["DRUID"]["g1"], unitframegradients["DRUID"]["b1"], unitframegradients["DRUID"]["r2"], unitframegradients["DRUID"]["g2"], unitframegradients["DRUID"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DRUID"]["r1"], unitframecustomgradients["DRUID"]["g1"], unitframecustomgradients["DRUID"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["DRUID"]["r2"], unitframecustomgradients["DRUID"]["g2"], unitframecustomgradients["DRUID"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DRUID"]["r1"], unitframegradients["DRUID"]["g1"], unitframegradients["DRUID"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["DRUID"]["r2"], unitframegradients["DRUID"]["g2"], unitframegradients["DRUID"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("DRUID"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
								end
							end
						end
					elseif ((r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b)) or (r == unitframecustomgradients["DEATHKNIGHT"]["r2"] and g == unitframecustomgradients["DEATHKNIGHT"]["g2"] and b == unitframecustomgradients["DEATHKNIGHT"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEATHKNIGHT"]["r1"], unitframecustomgradients["DEATHKNIGHT"]["g1"], unitframecustomgradients["DEATHKNIGHT"]["b1"], unitframecustomgradients["DEATHKNIGHT"]["r2"], unitframecustomgradients["DEATHKNIGHT"]["g2"], unitframecustomgradients["DEATHKNIGHT"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEATHKNIGHT"]["r1"], unitframegradients["DEATHKNIGHT"]["g1"], unitframegradients["DEATHKNIGHT"]["b1"], unitframegradients["DEATHKNIGHT"]["r2"], unitframegradients["DEATHKNIGHT"]["g2"], unitframegradients["DEATHKNIGHT"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEATHKNIGHT"]["r1"], unitframecustomgradients["DEATHKNIGHT"]["g1"], unitframecustomgradients["DEATHKNIGHT"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["DEATHKNIGHT"]["r2"], unitframecustomgradients["DEATHKNIGHT"]["g2"], unitframecustomgradients["DEATHKNIGHT"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEATHKNIGHT"]["r1"], unitframegradients["DEATHKNIGHT"]["g1"], unitframegradients["DEATHKNIGHT"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["DEATHKNIGHT"]["r2"], unitframegradients["DEATHKNIGHT"]["g2"], unitframegradients["DEATHKNIGHT"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("DEATHKNIGHT"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
								end
							end
						end
					elseif ((r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b)) or (r == unitframecustomgradients["DEMONHUNTER"]["r2"] and g == unitframecustomgradients["DEMONHUNTER"]["g2"] and b == unitframecustomgradients["DEMONHUNTER"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEMONHUNTER"]["r1"], unitframecustomgradients["DEMONHUNTER"]["g1"], unitframecustomgradients["DEMONHUNTER"]["b1"], unitframecustomgradients["DEMONHUNTER"]["r2"], unitframecustomgradients["DEMONHUNTER"]["g2"], unitframecustomgradients["DEMONHUNTER"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEMONHUNTER"]["r1"], unitframegradients["DEMONHUNTER"]["g1"], unitframegradients["DEMONHUNTER"]["b1"], unitframegradients["DEMONHUNTER"]["r2"], unitframegradients["DEMONHUNTER"]["g2"], unitframegradients["DEMONHUNTER"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["DEMONHUNTER"]["r1"], unitframecustomgradients["DEMONHUNTER"]["g1"], unitframecustomgradients["DEMONHUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["DEMONHUNTER"]["r2"], unitframecustomgradients["DEMONHUNTER"]["g2"], unitframecustomgradients["DEMONHUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["DEMONHUNTER"]["r1"], unitframegradients["DEMONHUNTER"]["g1"], unitframegradients["DEMONHUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["DEMONHUNTER"]["r2"], unitframegradients["DEMONHUNTER"]["g2"], unitframegradients["DEMONHUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("DEMONHUNTER"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
								end
							end
						end
					elseif ((r == monk.r) and (g == monk.g) and (b == monk.b)) or (r == unitframecustomgradients["MONK"]["r2"] and g == unitframecustomgradients["MONK"]["g2"] and b == unitframecustomgradients["MONK"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MONK"]["r1"], unitframecustomgradients["MONK"]["g1"], unitframecustomgradients["MONK"]["b1"], unitframecustomgradients["MONK"]["r2"], unitframecustomgradients["MONK"]["g2"], unitframecustomgradients["MONK"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MONK"]["r1"], unitframegradients["MONK"]["g1"], unitframegradients["MONK"]["b1"], unitframegradients["MONK"]["r2"], unitframegradients["MONK"]["g2"], unitframegradients["MONK"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MONK"]["r1"], unitframecustomgradients["MONK"]["g1"], unitframecustomgradients["MONK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["MONK"]["r2"], unitframecustomgradients["MONK"]["g2"], unitframecustomgradients["MONK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MONK"]["r1"], unitframegradients["MONK"]["g1"], unitframegradients["MONK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["MONK"]["r2"], unitframegradients["MONK"]["g2"], unitframegradients["MONK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("MONK"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
								end
							end
						end
					elseif ((r == rogue.r) and (g == rogue.g) and (b == rogue.b)) or (r == unitframecustomgradients["ROGUE"]["r2"] and g == unitframecustomgradients["ROGUE"]["g2"] and b == unitframecustomgradients["ROGUE"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["ROGUE"]["r1"], unitframecustomgradients["ROGUE"]["g1"], unitframecustomgradients["ROGUE"]["b1"], unitframecustomgradients["ROGUE"]["r2"], unitframecustomgradients["ROGUE"]["g2"], unitframecustomgradients["ROGUE"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["ROGUE"]["r1"], unitframegradients["ROGUE"]["g1"], unitframegradients["ROGUE"]["b1"], unitframegradients["ROGUE"]["r2"], unitframegradients["ROGUE"]["g2"], unitframegradients["ROGUE"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["ROGUE"]["r1"], unitframecustomgradients["ROGUE"]["g1"], unitframecustomgradients["ROGUE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["ROGUE"]["r2"], unitframecustomgradients["ROGUE"]["g2"], unitframecustomgradients["ROGUE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["ROGUE"]["r1"], unitframegradients["ROGUE"]["g1"], unitframegradients["ROGUE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["ROGUE"]["r2"], unitframegradients["ROGUE"]["g2"], unitframegradients["ROGUE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("ROGUE"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
								end
							end
						end
					elseif ((r == priest.r) and (g == priest.g) and (b == priest.b)) or (r == unitframecustomgradients["PRIEST"]["r2"] and g == unitframecustomgradients["PRIEST"]["g2"] and b == unitframecustomgradients["PRIEST"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PRIEST"]["r1"], unitframecustomgradients["PRIEST"]["g1"], unitframecustomgradients["PRIEST"]["b1"], unitframecustomgradients["PRIEST"]["r2"], unitframecustomgradients["PRIEST"]["g2"], unitframecustomgradients["PRIEST"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PRIEST"]["r1"], unitframegradients["PRIEST"]["g1"], unitframegradients["PRIEST"]["b1"], unitframegradients["PRIEST"]["r2"], unitframegradients["PRIEST"]["g2"], unitframegradients["PRIEST"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["PRIEST"]["r1"], unitframecustomgradients["PRIEST"]["g1"], unitframecustomgradients["PRIEST"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["PRIEST"]["r2"], unitframecustomgradients["PRIEST"]["g2"], unitframecustomgradients["PRIEST"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["PRIEST"]["r1"], unitframegradients["PRIEST"]["g1"], unitframegradients["PRIEST"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["PRIEST"]["r2"], unitframegradients["PRIEST"]["g2"], unitframegradients["PRIEST"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("PRIEST"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
								end
							end
						end
					elseif ((r == mage.r) and (g == mage.g) and (b == mage.b)) or (r == unitframecustomgradients["MAGE"]["r2"] and g == unitframecustomgradients["MAGE"]["g2"] and b == unitframecustomgradients["MAGE"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MAGE"]["r1"], unitframecustomgradients["MAGE"]["g1"], unitframecustomgradients["MAGE"]["b1"], unitframecustomgradients["MAGE"]["r2"], unitframecustomgradients["MAGE"]["g2"], unitframecustomgradients["MAGE"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MAGE"]["r1"], unitframegradients["MAGE"]["g1"], unitframegradients["MAGE"]["b1"], unitframegradients["MAGE"]["r2"], unitframegradients["MAGE"]["g2"], unitframegradients["MAGE"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["MAGE"]["r1"], unitframecustomgradients["MAGE"]["g1"], unitframecustomgradients["MAGE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["MAGE"]["r2"], unitframecustomgradients["MAGE"]["g2"], unitframecustomgradients["MAGE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["MAGE"]["r1"], unitframegradients["MAGE"]["g1"], unitframegradients["MAGE"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["MAGE"]["r2"], unitframegradients["MAGE"]["g2"], unitframegradients["MAGE"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("MAGE"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
								end
							end
						end
					elseif ((r == hunter.r) and (g == hunter.g) and (b == hunter.b)) or (r == unitframecustomgradients["HUNTER"]["r2"] and g == unitframecustomgradients["HUNTER"]["g2"] and b == unitframecustomgradients["HUNTER"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["HUNTER"]["r1"], unitframecustomgradients["HUNTER"]["g1"], unitframecustomgradients["HUNTER"]["b1"], unitframecustomgradients["HUNTER"]["r2"], unitframecustomgradients["HUNTER"]["g2"], unitframecustomgradients["HUNTER"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["HUNTER"]["r1"], unitframegradients["HUNTER"]["g1"], unitframegradients["HUNTER"]["b1"], unitframegradients["HUNTER"]["r2"], unitframegradients["HUNTER"]["g2"], unitframegradients["HUNTER"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["HUNTER"]["r1"], unitframecustomgradients["HUNTER"]["g1"], unitframecustomgradients["HUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["HUNTER"]["r2"], unitframecustomgradients["HUNTER"]["g2"], unitframecustomgradients["HUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["HUNTER"]["r1"], unitframegradients["HUNTER"]["g1"], unitframegradients["HUNTER"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["HUNTER"]["r2"], unitframegradients["HUNTER"]["g2"], unitframegradients["HUNTER"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("HUNTER"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
								end
							end
						end
					elseif ((r == warlock.r) and (g == warlock.g) and (b == warlock.b)) or (r == unitframecustomgradients["WARLOCK"]["r2"] and g == unitframecustomgradients["WARLOCK"]["g2"] and b == unitframecustomgradients["WARLOCK"]["b2"]) then
						if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
							if E.db.ElvUI_EltreumUI.lightmode then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARLOCK"]["r1"], unitframecustomgradients["WARLOCK"]["g1"], unitframecustomgradients["WARLOCK"]["b1"], unitframecustomgradients["WARLOCK"]["r2"], unitframecustomgradients["WARLOCK"]["g2"], unitframecustomgradients["WARLOCK"]["b2"])
								else
									button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARLOCK"]["r1"], unitframegradients["WARLOCK"]["g1"], unitframegradients["WARLOCK"]["b1"], unitframegradients["WARLOCK"]["r2"], unitframegradients["WARLOCK"]["g2"], unitframegradients["WARLOCK"]["b2"])
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients["WARLOCK"]["r1"], unitframecustomgradients["WARLOCK"]["g1"], unitframecustomgradients["WARLOCK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframecustomgradients["WARLOCK"]["r2"], unitframecustomgradients["WARLOCK"]["g2"], unitframecustomgradients["WARLOCK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								else
									button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients["WARLOCK"]["r1"], unitframegradients["WARLOCK"]["g1"], unitframegradients["WARLOCK"]["b1"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha, unitframegradients["WARLOCK"]["r2"], unitframegradients["WARLOCK"]["g2"], unitframegradients["WARLOCK"]["b2"], E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
								end
							end
						elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
							if E.db.ElvUI_EltreumUI.lightmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
								else
									--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga")
									button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("WARLOCK"))
								end
							elseif E.db.ElvUI_EltreumUI.darkmode then
								if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
									button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.lightmode then
							--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
							--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
							button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture("PRIEST"))
						end
					end
				else --might be priest, use texture then if gradient, custom texture woulnt work because its class based and would force it on all
					if E.db.ElvUI_EltreumUI.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.lightmode then
							button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						elseif E.db.ElvUI_EltreumUI.darkmode and button.Health.backdropTex then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
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
	if E.private.unitframe.enable and (not E.db.ElvUI_EltreumUI.lightmode) and E.db.ElvUI_EltreumUI.UFmodifications then
		if not E.db.ElvUI_EltreumUI.gradientmode.enable then
			backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
			backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
		end
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)
