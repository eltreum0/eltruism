local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--set the variables
local paladin = {r = "0.95686066150665", g = "0.54901838302612", b = "0.72941017150879"}
local warrior = {r = "0.77646887302399", g = "0.60784178972244", b = "0.4274500310421"}
local shaman = {r = "0", g = "0.4392147064209", b = "0.86666476726532"}
local druid = {r = "0.99999779462814", g = "0.48627343773842", b = "0.039215601980686"}
local deathknight = {r = "0.76862573623657", g = "0.11764679849148", b = "0.2274504750967"}
local demonhunter = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"}
local monk = {r = "0", g = "0.99999779462814", b = "0.59607714414597"}
local rogue = {r = "0.99999779462814", g = "0.95686066150665", b = "0.40784224867821"}
local priest = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"}
local mage = {r = "0.24705828726292", g = "0.78039044141769", b = "0.92156660556793"}
local hunter = {r = "0.66666519641876", g = "0.82744914293289", b = "0.44705784320831"}
local warlock = {r = "0.52941060066223", g = "0.53333216905594", b = "0.93333131074905"}
local npcfriendly = {r = "0.1999995559454", g = "0.7098023891449", b = "0"}
local npcneutral = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"}
local npcunfriendly = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"}
local npchostile = {r = "0.99999779462814", g = "0.18039175868034", b = "0.18039175868034"}
--local goodthreat = {r = "0.1999995559454", g = "0.7098023891449", b = "0"} -- is equal to friendly npc
--local badthreat = {r = "0.99999779462814", g = "0.18039175868034", b = "0.18039175868034"} -- is equal to hostile npc
--local goodthreattransition = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"} -- is equal to neutral npc
--local badthreattransition = {r = "0.7098023891449", g = "0.43137159943581", b = "0.27058765292168"}
--local offtank = {r = "0.72941017150879", g1 = "0.1999995559454", b = "0.99999779462814"}
--local offtankgoodthreattransition
--local offtankbadthreattransition = {r = "0.77646887302399", g1 = "0.60784178972244", b = "0.4274500310421"}
--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
--local disconnecteddarkmode = {r = "0.63137114048004", g = "0.56078308820724", b = "0.48627343773842"}
if E.Wrath or E.TBC or E.Classic then
	paladin = {r = "0.96078222990036", g = "0.54901838302612", b = "0.72941017150879"}
	warrior = {r = "0.78039044141769", g = "0.61176335811615", b = "0.43137159943581"}
	shaman = {r = "0", g = "0.4392147064209", b = "0.87058633565903"}
	druid = {r = "0.99999779462814", g = "0.49019500613213", b = "0.039215601980686"}
	deathknight = {r = "0.76862573623657", g = "0.1215683594346", b = "0.23137204349041"}
	rogue = {r = "0.99999779462814", g = "0.96078222990036", b = "0.41176378726959"}
	mage = {r = "0.25097984075546", g = "0.78039044141769", b = "0.92156660556793"}
	hunter = {r = "0.67058676481247", g = "0.8313707113266", b = "0.45097941160202"}
	warlock = {r = "0.52941060066223", g = "0.52941060066223", b = "0.92940974235535"}
	npcfriendly = {r = "0.29019543528557", g = "0.67842990159988", b = "0.30196011066437"}
	npcneutral = {r = "0.85097849369049", g = "0.76862573623657", b = "0.36078351736069"}
	npchostile = {r = "0.78039044141769", g = "0.25097984075546", b = "0.25097984075546"}
end

--gradient nameplates
local function GradientNameplates(unit)
	if E.db.ElvUI_EltreumUI.gradientmode.npenable then
		if unit and unit.Health then
			local _, className = UnitClass(unit.unit)
			local name, realm = UnitName(unit.unit)
			local player = UnitIsPlayer(unit.unit)
			if className and player then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom(className))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors(className))
				end
			elseif unit.reaction >= 5 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
				end
			elseif unit.reaction == 4 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
				end
			elseif unit.reaction == 3 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, false))
				end
			elseif unit.reaction <= 2 then
				if E.db.ElvUI_EltreumUI.gradientmode.npcustomcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
				end
			end
		end
	end
end
hooksecurefunc(NP, "Health_UpdateColor", GradientNameplates)
--hooksecurefunc(NP, "Update_StatusBars", GradientNameplates)
--hooksecurefunc(NP, "SetupTarget", GradientNameplates)
--hooksecurefunc(NP, "UpdateTargetPlate", GradientNameplates)
--hooksecurefunc(NP, "Update_ThreatIndicator", GradientNameplates)
--hooksecurefunc(NP, "ThreatIndicator_PostUpdate", GradientNameplates)
--hooksecurefunc(NP, "UpdatePlateSize", GradientNameplates)
--hooksecurefunc(NP, "Style", GradientNameplates)
--hooksecurefunc(NP, "StyleTargetPlate", GradientNameplates)
--hooksecurefunc(NP, "UpdatePlate", GradientNameplates)
--hooksecurefunc(NP, "StyleFilterUpdate", GradientNameplates)
