local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')

--elvui spark hook
local function EltruismSpark()
	if E.db.ElvUI_EltreumUI.sparkcustomcolor.enable and E.private.unitframe.enable then
		local castbar = _G["ElvUF_Player_CastBar"]
		castbar.Spark_ = castbar:CreateTexture(nil, 'OVERLAY')
		castbar.Spark_:SetTexture(E.media.blankTex)
		castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.sparkcustomcolor.b, 1)
		castbar.Spark_:Size(E.db.ElvUI_EltreumUI.sparkcustomcolor.width)
	end
end
hooksecurefunc(UF, 'Construct_Castbar', EltruismSpark)

function ElvUI_EltreumUI:LeaderIndicatorSize(frame)
	frame.LeaderIndicator:Size(E.db.ElvUI_EltreumUI.otherstuff.leadersize)
	frame.AssistantIndicator:Size(E.db.ElvUI_EltreumUI.otherstuff.leadersize)
	frame.MasterLooterIndicator:Size(E.db.ElvUI_EltreumUI.otherstuff.leadersize)
end
hooksecurefunc(UF, 'Construct_RaidRoleFrames', ElvUI_EltreumUI.LeaderIndicatorSize)

--color unitframes target texture during light mode
local unitframeclass = {
	['WARRIOR'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga",
	['PALADIN'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga",
	['HUNTER'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga",
	['ROGUE'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga",
	['PRIEST'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga",
	['DEATHKNIGHT'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga",
	['SHAMAN'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga",
	['MAGE'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga",
	['WARLOCK'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga",
	['MONK'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga",
	['DRUID'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga",
	['DEMONHUNTER'] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga",
}

--bar colors for party/raid/raid40
--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
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
	['WARRIOR'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['PALADIN'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['HUNTER'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['ROGUE'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['PRIEST'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['DEATHKNIGHT'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['SHAMAN'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['MAGE'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['WARLOCK'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['MONK'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['DRUID'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
	['DEMONHUNTER'] = {r1 = 1, g1 = 1, b1 = 1, r2 = 0, g2= 0, b2 = 0},
}
local unitframegradients = {
	['WARRIOR'] = {r1 = 0.49019607843137, g1 = 0.39607843137255, b1 = 0.24313725490196, r2 = 0.8156862745098, g2= 0.63921568627451, b2 = 0.44705882352941},
	['PALADIN'] = {r1 = 0.95686274509804, g1 = 0.54901960784314, b1 = 0.72941176470588, r2 = 1, g2= 0.76078431372549, b2 = 0.86666666666667},
	['HUNTER'] = {r1 = 0.43921568627451, g1 = 0.69019607843137, b1 = 0.38039215686275, r2 = 0.80392156862745, g2= 1, b2 = 0.54117647058824},
	['ROGUE'] = {r1 = 1, g1 = 0.83137254901961, b1 = 0.25490196078431, r2 = 1, g2= 0.95686274509804, b2 = 0.4078431372549},
	['PRIEST'] = {r1 = 0.98823529411765, g1 = 0.98823529411765, b1 = 0.98823529411765, r2 = 0.3568627450980392, g2= 0.3568627450980392, b2 = 0.3568627450980392},
	['DEATHKNIGHT'] = {r1 = 0.76862745098039, g1 = 0.11764705882353, b1 = 0.22745098039216, r2 = 0.76862745098039, g2= 0.30588235294118, b2 = 0.40392156862745},
	['SHAMAN'] = {r1 = 0, g1 = 0.25882352941176, b1 = 0.50980392156863, r2 = 0, g2= 0.50588235294118, b2 = 1},
	['MAGE'] = {r1 = 0.16470588235294, g1 = 0.52549019607843, b1 = 0.61960784313725, r2 = 0.39607843137255, g2= 0.90980392156863, b2 = 1},
	['WARLOCK'] = {r1 = 0.26274509803922, g1 = 0.26666666666667, b1 = 0.46666666666667, r2 = 0.56862745098039, g2= 0.57254901960784, b2 = 1},
	['MONK'] = {r1 = 0, g1 = 0.77254901960784, b1 = 0.45882352941176, r2 = 0.1921568627451, g2= 1, b2 = 0.74901960784314},
	['DRUID'] = {r1 = 1, g1 = 0.48627450980392, b1 = 0.03921568627451, r2 = 1, g2= 0.37647058823529, b2 = 0.18823529411765},
	['DEMONHUNTER'] = {r1 = 0.50980392156863, g1 = 0.14901960784314, b1 = 0.63137254901961, r2 = 0.83921568627451, g2= 0.36078431372549, b2 = 1},
}

function ElvUI_EltreumUI:GradientColorTableUpdate()
	unitframecustomgradients = {
		['WARRIOR'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.warriorcustomcolorB2},
		['PALADIN'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.paladincustomcolorB2},
		['HUNTER'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.huntercustomcolorB2},
		['ROGUE'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.roguecustomcolorB2},
		['PRIEST'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.priestcustomcolorB2},
		['DEATHKNIGHT'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.deathknightcustomcolorB2},
		['SHAMAN'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.shamancustomcolorB2},
		['MAGE'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.magecustomcolorB2},
		['WARLOCK'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.warlockcustomcolorB2},
		['MONK'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.monkcustomcolorB2},
		['DRUID'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.druidcustomcolorB2},
		['DEMONHUNTER'] = {r1 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorR1, g1 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorG1, b1 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorB1, r2 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorR2, g2= E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorG2, b2 = E.db.ElvUI_EltreumUI.gradientmode.demonhuntercustomcolorB2},
	}
end

local EltruismGradientColorTableLoad = CreateFrame("FRAME")
EltruismGradientColorTableLoad:RegisterEvent("PLAYER_ENTERING_WORLD")
EltruismGradientColorTableLoad:RegisterEvent("PLAYER_STARTED_MOVING")
EltruismGradientColorTableLoad:SetScript("OnEvent", function()
	EltruismGradientColorTableLoad:UnregisterAllEvents()
	ElvUI_EltreumUI:GradientColorTableUpdate()
end)

function ElvUI_EltreumUI:ChangeUnitTexture()
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable then
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
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("target") and E.db.ElvUI_EltreumUI.gradientmode.enableplayertarget then
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
				else
					targetunitframe.Health:SetStatusBarTexture(targetbar)
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
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("targettarget") and E.db.ElvUI_EltreumUI.gradientmode.enableplayertarget then
					targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[targettargetclass]["r1"], unitframecustomgradients[targettargetclass]["g1"], unitframecustomgradients[targettargetclass]["b1"], unitframecustomgradients[targettargetclass]["r2"], unitframecustomgradients[targettargetclass]["g2"], unitframecustomgradients[targettargetclass]["b2"])
					else
						targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[targettargetclass]["r1"], unitframegradients[targettargetclass]["g1"], unitframegradients[targettargetclass]["b1"], unitframegradients[targettargetclass]["r2"], unitframegradients[targettargetclass]["g2"], unitframegradients[targettargetclass]["b2"])
					end
				else
					targettargetunitframe.Health:SetStatusBarTexture(targettargetbar)
				end
			end
		end

		--focus
		local _, focusclass = UnitClass("focus")
		local focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if focusclass and UnitIsPlayer("focus") then
			focusbar = unitframeclass[focusclass]
		end
		if UF.units.focus and UnitExists("focus") then
			local focusframe = _G["ElvUF_Focus"]
			if focusframe and focusframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					focusbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer("focus") and E.db.ElvUI_EltreumUI.gradientmode.enableplayertarget then
					focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[focusclass]["r1"], unitframecustomgradients[focusclass]["g1"], unitframecustomgradients[focusclass]["b1"], unitframecustomgradients[focusclass]["r2"], unitframecustomgradients[focusclass]["g2"], unitframecustomgradients[focusclass]["b2"])
					else
						focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[focusclass]["r1"], unitframegradients[focusclass]["g1"], unitframegradients[focusclass]["b1"], unitframegradients[focusclass]["r2"], unitframegradients[focusclass]["g2"], unitframegradients[focusclass]["b2"])
					end
				else
					focusframe.Health:SetStatusBarTexture(focusbar)
				end
			end
		end

		--pet
		local petbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga"
		if UF.units.pet then
			local petframe = _G["ElvUF_Pet"]
			if petframe and petframe.Health then
				petframe.Health:SetStatusBarTexture(petbar)
			end
		end
	end
end

function ElvUI_EltreumUI:ChangePlayerTexture()
	--print("change unit texture spam")
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable then
		--player
		local playertexture = unitframeclass[E.myclass]
		if UF.units.player then
			local unitframe = _G["ElvUF_Player"]
			if unitframe and unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					playertexture = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.playertexture)
				end
				if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableplayertarget then
					unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[E.myclass]["r1"], unitframecustomgradients[E.myclass]["g1"], unitframecustomgradients[E.myclass]["b1"], unitframecustomgradients[E.myclass]["r2"], unitframecustomgradients[E.myclass]["g2"], unitframecustomgradients[E.myclass]["b2"])
					else
						unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"])
					end
				else
					unitframe.Health:SetStatusBarTexture(playertexture)
				end
			end
		end
	end
end

local units = {
	["player"] = true,
	["party1"] = true,
	["party2"] = true,
	["party3"] = true,
	["party4"] = true,
	["party5"] = true,
	["raid1"] = true,
	["raid2"] = true,
	["raid3"] = true,
	["raid4"] = true,
	["raid5"] = true,
	["raid6"] = true,
	["raid7"] = true,
	["raid8"] = true,
	["raid9"] = true,
	["raid10"] = true,
	["raid11"] = true,
	["raid12"] = true,
	["raid13"] = true,
	["raid14"] = true,
	["raid15"] = true,
	["raid16"] = true,
	["raid17"] = true,
	["raid18"] = true,
	["raid19"] = true,
	["raid20"] = true,
	["raid21"] = true,
	["raid22"] = true,
	["raid23"] = true,
	["raid24"] = true,
	["raid25"] = true,
	["raid26"] = true,
	["raid27"] = true,
	["raid28"] = true,
	["raid29"] = true,
	["raid30"] = true,
	["raid31"] = true,
	["raid32"] = true,
	["raid33"] = true,
	["raid34"] = true,
	["raid35"] = true,
	["raid36"] = true,
	["raid37"] = true,
	["raid38"] = true,
	["raid39"] = true,
	["raid40"] = true,
}

function ElvUI_EltreumUI:ChangeGroupUnitframe(unit, r, g, b)
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable and UnitExists(unit) then --and units[unit] == true then
		--local header = _G['ElvUF_Raid40'] or _G['ElvUF_Raid'] or _G['ElvUF_Party']
		local header = nil
		if E.Retail then
			if UnitExists("raid6") == true and UnitExists("raid21") == false then
				header = _G['ElvUF_Raid']
			elseif UnitExists("raid21") == true then
				header = _G['ElvUF_Raid40']
			else
				header = _G['ElvUF_Party']
			end
		end
		if E.TBC or E.Classic then
			if UnitExists("raid6") == true and UnitExists("raid26") == false then
				header = _G['ElvUF_Raid']
			elseif UnitExists("raid26") == true then
				header = _G['ElvUF_Raid40']
			else
				header = _G['ElvUF_Party']
			end
		end

		local _, unit1class = UnitClass(unit)
		if not unit1class then
			return
		end
		local truer = 0
		local trueg = 0
		local trueb = 0
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
				--truer = 0.99999779462814
				--trueg = 0.99999779462814
				--trueb = 0.99999779462814
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
				--truer = 0.99999779462814
				--trueg = 0.99999779462814
				--trueb = 0.99999779462814
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





		if header ~= nil then
			for i = 1, header:GetNumChildren() do
				local group = select(i, header:GetChildren())
				for j = 1, group:GetNumChildren() do
					local unitbutton = select(j, group:GetChildren())
					if unitbutton and unitbutton.Health then
						local r1,g1,b1 = unitbutton.Health:GetStatusBarColor()
						local r = tostring(r1)
						local g = tostring(g1)
						local b = tostring(b1)
						--print(r1,g1,b1,unit1class)
						if tostring(g1) == tostring(trueg) and tostring(r1) == tostring(truer) and tostring(b1) == tostring(trueb) then
							if ((r == paladin.r) and (g == paladin.g) and (b == paladin.b)) or (r == unitframecustomgradients['PALADIN']["r2"] and g == unitframecustomgradients['PALADIN']["g2"] and b == unitframecustomgradients['PALADIN']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['PALADIN']["r1"], unitframecustomgradients['PALADIN']["g1"], unitframecustomgradients['PALADIN']["b1"], unitframecustomgradients['PALADIN']["r2"], unitframecustomgradients['PALADIN']["g2"], unitframecustomgradients['PALADIN']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['PALADIN']["r1"], unitframegradients['PALADIN']["g1"], unitframegradients['PALADIN']["b1"], unitframegradients['PALADIN']["r2"], unitframegradients['PALADIN']["g2"], unitframegradients['PALADIN']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
									end
								end
							elseif ((r == warrior.r) and (g == warrior.g) and (b == warrior.b)) or (r == unitframecustomgradients['WARRIOR']["r2"] and g == unitframecustomgradients['WARRIOR']["g2"] and b == unitframecustomgradients['WARRIOR']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['WARRIOR']["r1"], unitframecustomgradients['WARRIOR']["g1"], unitframecustomgradients['WARRIOR']["b1"], unitframecustomgradients['WARRIOR']["r2"], unitframecustomgradients['WARRIOR']["g2"], unitframecustomgradients['WARRIOR']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['WARRIOR']["r1"], unitframegradients['WARRIOR']["g1"], unitframegradients['WARRIOR']["b1"], unitframegradients['WARRIOR']["r2"], unitframegradients['WARRIOR']["g2"], unitframegradients['WARRIOR']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga")
									end
								end
							elseif ((r == shaman.r) and (g == shaman.g) and (b == shaman.b)) or (r == unitframecustomgradients['SHAMAN']["r2"] and g == unitframecustomgradients['SHAMAN']["g2"] and b == unitframecustomgradients['SHAMAN']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['SHAMAN']["r1"], unitframecustomgradients['SHAMAN']["g1"], unitframecustomgradients['SHAMAN']["b1"], unitframecustomgradients['SHAMAN']["r2"], unitframecustomgradients['SHAMAN']["g2"], unitframecustomgradients['SHAMAN']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['SHAMAN']["r1"], unitframegradients['SHAMAN']["g1"], unitframegradients['SHAMAN']["b1"], unitframegradients['SHAMAN']["r2"], unitframegradients['SHAMAN']["g2"], unitframegradients['SHAMAN']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga")
									end
								end
							elseif ((r == druid.r) and (g == druid.g) and (b == druid.b)) or (r == unitframecustomgradients['DRUID']["r2"] and g == unitframecustomgradients['DRUID']["g2"] and b == unitframecustomgradients['DRUID']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['DRUID']["r1"], unitframecustomgradients['DRUID']["g1"], unitframecustomgradients['DRUID']["b1"], unitframecustomgradients['DRUID']["r2"], unitframecustomgradients['DRUID']["g2"], unitframecustomgradients['DRUID']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['DRUID']["r1"], unitframegradients['DRUID']["g1"], unitframegradients['DRUID']["b1"], unitframegradients['DRUID']["r2"], unitframegradients['DRUID']["g2"], unitframegradients['DRUID']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga")
									end
								end
							elseif ((r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b)) or (r == unitframecustomgradients['DEATHKNIGHT']["r2"] and g == unitframecustomgradients['DEATHKNIGHT']["g2"] and b == unitframecustomgradients['DEATHKNIGHT']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['DEATHKNIGHT']["r1"], unitframecustomgradients['DEATHKNIGHT']["g1"], unitframecustomgradients['DEATHKNIGHT']["b1"], unitframecustomgradients['DEATHKNIGHT']["r2"], unitframecustomgradients['DEATHKNIGHT']["g2"], unitframecustomgradients['DEATHKNIGHT']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['DEATHKNIGHT']["r1"], unitframegradients['DEATHKNIGHT']["g1"], unitframegradients['DEATHKNIGHT']["b1"], unitframegradients['DEATHKNIGHT']["r2"], unitframegradients['DEATHKNIGHT']["g2"], unitframegradients['DEATHKNIGHT']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga")
									end
								end
							elseif ((r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b)) or (r == unitframecustomgradients['DEMONHUNTER']["r2"] and g == unitframecustomgradients['DEMONHUNTER']["g2"] and b == unitframecustomgradients['DEMONHUNTER']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['DEMONHUNTER']["r1"], unitframecustomgradients['DEMONHUNTER']["g1"], unitframecustomgradients['DEMONHUNTER']["b1"], unitframecustomgradients['DEMONHUNTER']["r2"], unitframecustomgradients['DEMONHUNTER']["g2"], unitframecustomgradients['DEMONHUNTER']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['DEMONHUNTER']["r1"], unitframegradients['DEMONHUNTER']["g1"], unitframegradients['DEMONHUNTER']["b1"], unitframegradients['DEMONHUNTER']["r2"], unitframegradients['DEMONHUNTER']["g2"], unitframegradients['DEMONHUNTER']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga")
									end
								end
							elseif ((r == monk.r) and (g == monk.g) and (b == monk.b)) or (r == unitframecustomgradients['MONK']["r2"] and g == unitframecustomgradients['MONK']["g2"] and b == unitframecustomgradients['MONK']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['MONK']["r1"], unitframecustomgradients['MONK']["g1"], unitframecustomgradients['MONK']["b1"], unitframecustomgradients['MONK']["r2"], unitframecustomgradients['MONK']["g2"], unitframecustomgradients['MONK']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['MONK']["r1"], unitframegradients['MONK']["g1"], unitframegradients['MONK']["b1"], unitframegradients['MONK']["r2"], unitframegradients['MONK']["g2"], unitframegradients['MONK']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga")
									end
								end
							elseif ((r == rogue.r) and (g == rogue.g) and (b == rogue.b)) or (r == unitframecustomgradients['ROGUE']["r2"] and g == unitframecustomgradients['ROGUE']["g2"] and b == unitframecustomgradients['ROGUE']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['ROGUE']["r1"], unitframecustomgradients['ROGUE']["g1"], unitframecustomgradients['ROGUE']["b1"], unitframecustomgradients['ROGUE']["r2"], unitframecustomgradients['ROGUE']["g2"], unitframecustomgradients['ROGUE']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['ROGUE']["r1"], unitframegradients['ROGUE']["g1"], unitframegradients['ROGUE']["b1"], unitframegradients['ROGUE']["r2"], unitframegradients['ROGUE']["g2"], unitframegradients['ROGUE']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga")
									end
								end
							elseif ((r == priest.r) and (g == priest.g) and (b == priest.b)) or (r == unitframecustomgradients['PRIEST']["r2"] and g == unitframecustomgradients['PRIEST']["g2"] and b == unitframecustomgradients['PRIEST']["b2"]) then
								--[[if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['PRIEST']["r1"], unitframecustomgradients['PRIEST']["g1"], unitframecustomgradients['PRIEST']["b1"], unitframecustomgradients['PRIEST']["r2"], unitframecustomgradients['PRIEST']["g2"], unitframecustomgradients['PRIEST']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['PRIEST']["r1"], unitframegradients['PRIEST']["g1"], unitframegradients['PRIEST']["b1"], unitframegradients['PRIEST']["r2"], unitframegradients['PRIEST']["g2"], unitframegradients['PRIEST']["b2"])
									end
								else]]
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
									end
								--end
							elseif ((r == mage.r) and (g == mage.g) and (b == mage.b)) or (r == unitframecustomgradients['MAGE']["r2"] and g == unitframecustomgradients['MAGE']["g2"] and b == unitframecustomgradients['MAGE']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['MAGE']["r1"], unitframecustomgradients['MAGE']["g1"], unitframecustomgradients['MAGE']["b1"], unitframecustomgradients['MAGE']["r2"], unitframecustomgradients['MAGE']["g2"], unitframecustomgradients['MAGE']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['MAGE']["r1"], unitframegradients['MAGE']["g1"], unitframegradients['MAGE']["b1"], unitframegradients['MAGE']["r2"], unitframegradients['MAGE']["g2"], unitframegradients['MAGE']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga")
									end
								end
							elseif ((r == hunter.r) and (g == hunter.g) and (b == hunter.b)) or (r == unitframecustomgradients['HUNTER']["r2"] and g == unitframecustomgradients['HUNTER']["g2"] and b == unitframecustomgradients['HUNTER']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['HUNTER']["r1"], unitframecustomgradients['HUNTER']["g1"], unitframecustomgradients['HUNTER']["b1"], unitframecustomgradients['HUNTER']["r2"], unitframecustomgradients['HUNTER']["g2"], unitframecustomgradients['HUNTER']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['HUNTER']["r1"], unitframegradients['HUNTER']["g1"], unitframegradients['HUNTER']["b1"], unitframegradients['HUNTER']["r2"], unitframegradients['HUNTER']["g2"], unitframegradients['HUNTER']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga")
									end
								end
							elseif ((r == warlock.r) and (g == warlock.g) and (b == warlock.b)) or (r == unitframecustomgradients['WARLOCK']["r2"] and g == unitframecustomgradients['WARLOCK']["g2"] and b == unitframecustomgradients['WARLOCK']["b2"]) then
								if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
									unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
									if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients['WARLOCK']["r1"], unitframecustomgradients['WARLOCK']["g1"], unitframecustomgradients['WARLOCK']["b1"], unitframecustomgradients['WARLOCK']["r2"], unitframecustomgradients['WARLOCK']["g2"], unitframecustomgradients['WARLOCK']["b2"])
									else
										unitbutton.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframegradients['WARLOCK']["r1"], unitframegradients['WARLOCK']["g1"], unitframegradients['WARLOCK']["b1"], unitframegradients['WARLOCK']["r2"], unitframegradients['WARLOCK']["g2"], unitframegradients['WARLOCK']["b2"])
									end
								else
									if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
										unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
									else
										unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga")
									end
								end
							else
								unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
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
	if E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable and not E.db.ElvUI_EltreumUI.lightmode then
		backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
		backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
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
	if E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable and E.db.ElvUI_EltreumUI.lightmode then
		ElvUI_EltreumUI.ChangeUnitTexture()
		ElvUI_EltreumUI.ChangePlayerTexture()
		if IsInGroup() == true then
			ElvUI_EltreumUI.ChangeGroupUnitframe()
		end
	end
end)

hooksecurefunc(UF, "Style", ElvUI_EltreumUI.ChangeUnitTexture)  --if not hooking into this then when the target of target changes it doesnt update
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangePlayerTexture)
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeGroupUnitframe) --test
hooksecurefunc(UF, 'Update_RaidFrames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'Update_Raid40Frames', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, 'Update_PartyFrames', ElvUI_EltreumUI.ChangeGroupUnitframe)

--gradient things
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.ChangePlayerTexture)
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, 'PostUpdateHealthColor', ElvUI_EltreumUI.ChangeGroupUnitframe)
hooksecurefunc(UF, "PostUpdateHealth", ElvUI_EltreumUI.ChangePlayerTexture)
hooksecurefunc(UF, "PostUpdateHealth", ElvUI_EltreumUI.ChangeUnitTexture)
hooksecurefunc(UF, 'PostUpdateHealth', ElvUI_EltreumUI.ChangeGroupUnitframe)
