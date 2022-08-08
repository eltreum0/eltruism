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

local unitcustomgradients = {
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
local unitgradients = {
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

function ElvUI_EltreumUI:ColorTableUpdate()
	unitcustomgradients = {
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
end

local GradientColorTableLoad = CreateFrame("FRAME")
GradientColorTableLoad:RegisterEvent("PLAYER_ENTERING_WORLD")
GradientColorTableLoad:RegisterEvent("PLAYER_STARTED_MOVING")
GradientColorTableLoad:SetScript("OnEvent", function()
	GradientColorTableLoad:UnregisterAllEvents()
	ElvUI_EltreumUI:ColorTableUpdate()
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
function ElvUI_EltreumUI:CastBarTextureGradient()
	local castbar = _G["ElvUF_Player_CastBar"]
	local targetcastbar = _G["ElvUF_Target_CastBar"]

	--spark
	if E.db.ElvUI_EltreumUI.sparkcustomcolor.enable and E.private.unitframe.enable then
		--castbar.Spark_ = castbar:CreateTexture(nil, 'OVERLAY')
		castbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.sparkcustomcolor.texture))
		if E.db.ElvUI_EltreumUI.sparkcustomcolor.texture == 'Eltreum-Fade' then --flip otherwise it will look wrong
			castbar.Spark_:SetTexCoord(1, 0, 0, 1)
		end
		castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.sparkcustomcolor.b, 1)
		castbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.sparkcustomcolor.width)
		--castbar.Spark_:SetAlpha(0.8) dunno since it can look bad with color mixing, infact textures themselves can look bad

		if UnitExists("target") then
			targetcastbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.sparkcustomcolor.texture))
			targetcastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.sparkcustomcolor.b, 1)
			targetcastbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.sparkcustomcolor.width)
		end
	end

	--gradient/texture
	if E.db.ElvUI_EltreumUI.UFmodifications then
		if E.db.ElvUI_EltreumUI.ufcustomtexture.enable and (not E.db.ElvUI_EltreumUI.gradientmode.enable) then
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture))
			if UnitExists("target") then
				targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture))
			end
		end

		--player
		if UnitExists("player") then
			local _, playerclass = UnitClass("player")
			if E.db.ElvUI_EltreumUI.ufcustomtexture.enable and (not E.db.ElvUI_EltreumUI.gradientmode.enable) then
				castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.castbartexture))
			end
			if E.db.ElvUI_EltreumUI.gradientmode.enable and (not E.db.ElvUI_EltreumUI.ufcustomtexture.enable) then
				if castbar.notInterruptible then --cant interrupt
					if E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarnoninterruptible then
						castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.unitframe.units.player.castbar.reverse == true then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptiblecustom)
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptible)
							end
						elseif E.db.unitframe.units.player.castbar.reverse == false then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptiblecustom)
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1noninterruptible)
							end
						end
					end
				elseif (not castbar.notInterruptible) then --can interrupt
					if E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbar then
						castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.unitframe.units.player.castbar.reverse == true then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1)
							elseif E.db.ElvUI_EltreumUI.gradientmode.customcolor and E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitcustomgradients[E.myclass]["r2"], unitcustomgradients[E.myclass]["g2"], unitcustomgradients[E.myclass]["b2"], unitcustomgradients[E.myclass]["r1"], unitcustomgradients[E.myclass]["g1"], unitcustomgradients[E.myclass]["b1"])
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients[E.myclass]["r2"], unitgradients[E.myclass]["g2"], unitgradients[E.myclass]["b2"], unitgradients[E.myclass]["r1"], unitgradients[E.myclass]["g1"], unitgradients[E.myclass]["b1"])
							end
						elseif E.db.unitframe.units.player.castbar.reverse == false then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2)
							elseif E.db.ElvUI_EltreumUI.gradientmode.customcolor and E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitcustomgradients[E.myclass]["r1"], unitcustomgradients[E.myclass]["g1"], unitcustomgradients[E.myclass]["b1"], unitcustomgradients[E.myclass]["r2"], unitcustomgradients[E.myclass]["g2"], unitcustomgradients[E.myclass]["b2"])
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients[E.myclass]["r1"], unitgradients[E.myclass]["g1"], unitgradients[E.myclass]["b1"], unitgradients[E.myclass]["r2"], unitgradients[E.myclass]["g2"], unitgradients[E.myclass]["b2"])
							end
						end
					end
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
			if E.db.ElvUI_EltreumUI.gradientmode.enable and (not E.db.ElvUI_EltreumUI.ufcustomtexture.enable) then
				if (targetcastbar.notInterruptible) then --cant interrupt
					if E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarnoninterruptible then
						targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.unitframe.units.target.castbar.reverse == true then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptiblecustom)
							else
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptible)
							end
						elseif E.db.unitframe.units.target.castbar.reverse == false then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptiblecustom)
							else
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1noninterruptible)
							end
						end
					end
				elseif (not targetcastbar.notInterruptible) then --can interrupt
					if E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbar then
						targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.unitframe.units.target.castbar.reverse == true then
							if UnitIsPlayer("target") then
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom)
								elseif E.db.ElvUI_EltreumUI.gradientmode.customcolor and E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitcustomgradients[targetclass]["r2"], unitcustomgradients[targetclass]["g2"], unitcustomgradients[targetclass]["b2"], unitcustomgradients[targetclass]["r1"], unitcustomgradients[targetclass]["g1"], unitcustomgradients[targetclass]["b1"])
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients[targetclass]["r2"], unitgradients[targetclass]["g2"], unitgradients[targetclass]["b2"], unitgradients[targetclass]["r1"], unitgradients[targetclass]["g1"], unitgradients[targetclass]["b1"])
								end
							else
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom)
								end
							end
						elseif E.db.unitframe.units.target.castbar.reverse == false then
							if UnitIsPlayer("target") then
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom)
								elseif E.db.ElvUI_EltreumUI.gradientmode.customcolor and E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitcustomgradients[targetclass]["r1"], unitcustomgradients[targetclass]["g1"], unitcustomgradients[targetclass]["b1"], unitcustomgradients[targetclass]["r2"], unitcustomgradients[targetclass]["g2"], unitcustomgradients[targetclass]["b2"])
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients[targetclass]["r1"], unitgradients[targetclass]["g1"], unitgradients[targetclass]["b1"], unitgradients[targetclass]["r2"], unitgradients[targetclass]["g2"], unitgradients[targetclass]["b2"])
								end
							else
								if E.db.ElvUI_EltreumUI.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom)
								elseif E.db.ElvUI_EltreumUI.gradientmode.customcolor and E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2custom)
								else
									if reactiontarget >= 5 then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients["NPCFRIENDLY"]["r1"], unitgradients["NPCFRIENDLY"]["g1"], unitgradients["NPCFRIENDLY"]["b1"], unitgradients["NPCFRIENDLY"]["r2"], unitgradients["NPCFRIENDLY"]["g2"], unitgradients["NPCFRIENDLY"]["b2"])
									elseif reactiontarget == 4 then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients["NPCNEUTRAL"]["r1"], unitgradients["NPCNEUTRAL"]["g1"], unitgradients["NPCNEUTRAL"]["b1"], unitgradients["NPCNEUTRAL"]["r2"], unitgradients["NPCNEUTRAL"]["g2"], unitgradients["NPCNEUTRAL"]["b2"])
									elseif reactiontarget == 3 then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients["NPCUNFRIENDLY"]["r1"], unitgradients["NPCUNFRIENDLY"]["g1"], unitgradients["NPCUNFRIENDLY"]["b1"], unitgradients["NPCUNFRIENDLY"]["r2"], unitgradients["NPCUNFRIENDLY"]["g2"], unitgradients["NPCUNFRIENDLY"]["b2"])
									elseif reactiontarget == 2 or reactiontarget == 1 then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitgradients["NPCHOSTILE"]["r1"], unitgradients["NPCHOSTILE"]["g1"], unitgradients["NPCHOSTILE"]["b1"], unitgradients["NPCHOSTILE"]["r2"], unitgradients["NPCHOSTILE"]["g2"], unitgradients["NPCHOSTILE"]["b2"])
									end
								end
							end
						end
					end
				end
			end
		end

	end
end
hooksecurefunc(UF, 'Construct_Castbar', ElvUI_EltreumUI.CastBarTextureGradient)
hooksecurefunc(UF, 'PostCastStart', ElvUI_EltreumUI.CastBarTextureGradient)

--color when interrupted
function ElvUI_EltreumUI:CastBarTextureGradientFail(unit)
	if not unit then return end

	local castbar = _G["ElvUF_Player_CastBar"]
	local targetcastbar = _G["ElvUF_Target_CastBar"]

	if E.db.ElvUI_EltreumUI.UFmodifications then
		if E.db.ElvUI_EltreumUI.gradientmode.enable and (not E.db.ElvUI_EltreumUI.ufcustomtexture.enable) then
			--player
			if E.db.ElvUI_EltreumUI.gradientmode.enableplayercastbarinterrupted and (unit == "player") then
				castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
				if E.db.unitframe.units.player.castbar.reverse == true then
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1interrupted)
					else
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1interrupted)
					end
				else
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2interrupted)
					else
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR1interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG1interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB1interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarR2interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarG2interrupted, E.db.ElvUI_EltreumUI.gradientmode.playercastbarB2interrupted)
					end
				end
			end
			--target
			if UnitExists("target") and E.db.ElvUI_EltreumUI.gradientmode.enabletargetcastbarinterrupted and targetcastbar ~= nil and (unit == "target") then
				targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
				if E.db.unitframe.units.target.castbar.reverse == true then
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1interrupted)
					else
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1interrupted)
					end
				else
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2interrupted)
					else
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR1interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG1interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB1interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarR2interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarG2interrupted, E.db.ElvUI_EltreumUI.gradientmode.targetcastbarB2interrupted)
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, 'PostCastFail', ElvUI_EltreumUI.CastBarTextureGradientFail)
