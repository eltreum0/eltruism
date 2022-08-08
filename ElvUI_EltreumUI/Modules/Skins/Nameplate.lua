local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
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
--local npcunfriendly = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly))
local npchostile = {r = "0.99999779462814", g = "0.18039175868034", b = "0.18039175868034"}
local goodthreat = {r = "0.27843075990677", g = "0.99999779462814", b = "0"}
local badthreat = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"}
local goodthreattransition = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"}
local badthreattransition = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"}
local offtank  = {r = "0.69411611557007", g = "0.16470551490784", b = "0.11764679849148"}
--local offtankgoodthreattransition --does this even exist?
--local offtankbadthreattransition --does this even exist?
--bar colors for party/raid/raid40
--local disconnected = {r = "0.83921384811401", g = "0.74901795387268", b = "0.65097898244858"}
--local disconnected dark mode 0.63137114048004 0.56078308820724 0.48627343773842

if E.Wrath or E.TBC or E.Classic then
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
	npcfriendly = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"}
	npcneutral = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"}
	npchostile = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"}
	goodthreat = {r = "0.27843075990677", g = "0.99999779462814", b = "0"}
	badthreat = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"}
	goodthreattransition = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"}
	badthreattransition = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"}
	--local offtank
	--local offtankgoodthreattransition
	--local offtankbadthreattransition
end

--gradient nameplates
--will need to check eltreumtarget and elvui_boss style filters due to health colors
local NP = E:GetModule('NamePlates')
local function testfunc(unit)
	if E.db.ElvUI_EltreumUI.gradientmode.npenable then
		if unit and unit.Health then
			local r, g, b = unit.Health:GetStatusBarColor()
			r = tostring(r)
			g = tostring(g)
			b = tostring(b)
			--print(r,g,b)

			if ((r == paladin.r) and (g == paladin.g) and (b == paladin.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("PALADIN"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("PALADIN"))
				end
			elseif ((r == warrior.r) and (g == warrior.g) and (b == warrior.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("WARRIOR"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("WARRIOR"))
				end
			elseif ((r == shaman.r) and (g == shaman.g) and (b == shaman.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("SHAMAN"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("SHAMAN"))
				end
			elseif ((r == druid.r) and (g == druid.g) and (b == druid.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("DRUID"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("DRUID"))
				end
			elseif ((r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("DEATHKNIGHT"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("DEATHKNIGHT"))
				end
			elseif ((r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("DEMONHUNTER"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("DEMONHUNTER"))
				end
			elseif ((r == monk.r) and (g == monk.g) and (b == monk.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("MONK"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("MONK"))
				end
			elseif ((r == rogue.r) and (g == rogue.g) and (b == rogue.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("ROGUE"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("ROGUE"))
				end
			elseif ((r == priest.r) and (g == priest.g) and (b == priest.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("PRIEST"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("PRIEST"))
				end
			elseif ((r == mage.r) and (g == mage.g) and (b == mage.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("MAGE"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("MAGE"))
				end
			elseif ((r == hunter.r) and (g == hunter.g) and (b == hunter.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("HUNTER"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("HUNTER"))
				end
			elseif ((r == warlock.r) and (g == warlock.g) and (b == warlock.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("WARLOCK"))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("WARLOCK"))
				end
			elseif ((r == npchostile.r) and (g == npchostile.g) and (b == npchostile.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
				end
			elseif ((r == npcneutral.r) and (g == npcneutral.g) and (b == npcneutral.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
				end
			elseif ((r == npcfriendly.r) and (g == npcfriendly.g) and (b == npcfriendly.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
				end
			elseif ((r == goodthreat.r) and (g == goodthreat.g) and (b == goodthreat.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREAT", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREAT", false, false))
				end
			elseif ((r == badthreat.r) and (g == badthreat.g) and (b == badthreat.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREAT", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("BADTHREAT", false, false))
				end
			elseif ((r == goodthreattransition.r) and (g == goodthreattransition.g) and (b == goodthreattransition.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("GOODTHREATTRANSITION", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColors("GOODTHREATTRANSITION", false, false))
				end
			elseif ((r == badthreattransition.r) and (g == badthreattransition.g) and (b == badthreattransition.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("BADTHREATTRANSITION", false, false))
				end
			elseif ((r == offtank.r) and (g == offtank.g) and (b == offtank.b)) then
				if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
				else
					unit.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.nporientation, ElvUI_EltreumUI:GradientColorsCustom("OFFTANK", false, false))
				end
			end
		end
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
--hooksecurefunc(NP, "StyleFilterUpdate", testfunc)
