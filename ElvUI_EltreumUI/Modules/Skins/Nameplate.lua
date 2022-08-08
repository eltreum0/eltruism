local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--set the variables
local paladin, warrior, shaman, druid, deathknight, demonhunter, monk, rogue, priest, mage, hunter, warlock
local npchostile, npcneutral, npcfriendly
local goodthreat, goodthreattransition, badthreattransition, badthreat
local offtank, offtankgoodthreattransition, offtankbadthreattransition
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
npcfriendly = {r = "0.4274500310421", g = "0.99999779462814", b = "0.44313627481461"}
npcneutral = {r = "0.99999779462814", g = "0.90195882320404", b = "0.42352849245071"}
--["NPCUNFRIENDLY"] = tostring(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.npcunfriendly))
npchostile = {r = "0.99999779462814", g = "0.32156792283058", b = "0.32156792283058"}
goodthreat = {r = "0.27843075990677", g = "0.99999779462814", b = "0"}
badthreat = {r = "0.99999779462814", g = "0.1764702051878", b = "0.1764702051878"}
goodthreattransition = {r = "0.99999779462814", g = "0.85097849369049", b = "0.1999995559454"}
badthreattransition = {r = "0.99999779462814", g = "0.50980281829834", b = "0.1999995559454"}
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
end

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
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("PALADIN"))--nameplatecustomgradients["PALADIN"]["r1"], nameplatecustomgradients["PALADIN"]["g1"], nameplatecustomgradients["PALADIN"]["b1"], nameplatecustomgradients["PALADIN"]["r2"], nameplatecustomgradients["PALADIN"]["g2"], nameplatecustomgradients["PALADIN"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("PALADIN"))--nameplategradients["PALADIN"]["r1"], nameplategradients["PALADIN"]["g1"], nameplategradients["PALADIN"]["b1"], nameplategradients["PALADIN"]["r2"], nameplategradients["PALADIN"]["g2"], nameplategradients["PALADIN"]["b2"])
			end
		elseif ((r == warrior.r) and (g == warrior.g) and (b == warrior.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("WARRIOR"))--nameplatecustomgradients["WARRIOR"]["r1"], nameplatecustomgradients["WARRIOR"]["g1"], nameplatecustomgradients["WARRIOR"]["b1"], nameplatecustomgradients["WARRIOR"]["r2"], nameplatecustomgradients["WARRIOR"]["g2"], nameplatecustomgradients["WARRIOR"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("WARRIOR"))--nameplategradients["WARRIOR"]["r1"], nameplategradients["WARRIOR"]["g1"], nameplategradients["WARRIOR"]["b1"], nameplategradients["WARRIOR"]["r2"], nameplategradients["WARRIOR"]["g2"], nameplategradients["WARRIOR"]["b2"])
			end
		elseif ((r == shaman.r) and (g == shaman.g) and (b == shaman.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("SHAMAN"))--nameplatecustomgradients["SHAMAN"]["r1"], nameplatecustomgradients["SHAMAN"]["g1"], nameplatecustomgradients["SHAMAN"]["b1"], nameplatecustomgradients["SHAMAN"]["r2"], nameplatecustomgradients["SHAMAN"]["g2"], nameplatecustomgradients["SHAMAN"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("SHAMAN"))--nameplategradients["SHAMAN"]["r1"], nameplategradients["SHAMAN"]["g1"], nameplategradients["SHAMAN"]["b1"], nameplategradients["SHAMAN"]["r2"], nameplategradients["SHAMAN"]["g2"], nameplategradients["SHAMAN"]["b2"])
			end
		elseif ((r == druid.r) and (g == druid.g) and (b == druid.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("DRUID"))--nameplatecustomgradients["DRUID"]["r1"], nameplatecustomgradients["DRUID"]["g1"], nameplatecustomgradients["DRUID"]["b1"], nameplatecustomgradients["DRUID"]["r2"], nameplatecustomgradients["DRUID"]["g2"], nameplatecustomgradients["DRUID"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("DRUID"))--nameplategradients["DRUID"]["r1"], nameplategradients["DRUID"]["g1"], nameplategradients["DRUID"]["b1"], nameplategradients["DRUID"]["r2"], nameplategradients["DRUID"]["g2"], nameplategradients["DRUID"]["b2"])
			end
		elseif ((r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("DEATHKNIGHT"))--nameplatecustomgradients["DEATHKNIGHT"]["r1"], nameplatecustomgradients["DEATHKNIGHT"]["g1"], nameplatecustomgradients["DEATHKNIGHT"]["b1"], nameplatecustomgradients["DEATHKNIGHT"]["r2"], nameplatecustomgradients["DEATHKNIGHT"]["g2"], nameplatecustomgradients["DEATHKNIGHT"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("DEATHKNIGHT"))--nameplategradients["DEATHKNIGHT"]["r1"], nameplategradients["DEATHKNIGHT"]["g1"], nameplategradients["DEATHKNIGHT"]["b1"], nameplategradients["DEATHKNIGHT"]["r2"], nameplategradients["DEATHKNIGHT"]["g2"], nameplategradients["DEATHKNIGHT"]["b2"])
			end
		elseif ((r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("DEMONHUNTER"))--nameplatecustomgradients["DEMONHUNTER"]["r1"], nameplatecustomgradients["DEMONHUNTER"]["g1"], nameplatecustomgradients["DEMONHUNTER"]["b1"], nameplatecustomgradients["DEMONHUNTER"]["r2"], nameplatecustomgradients["DEMONHUNTER"]["g2"], nameplatecustomgradients["DEMONHUNTER"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("DEMONHUNTER"))--nameplategradients["DEMONHUNTER"]["r1"], nameplategradients["DEMONHUNTER"]["g1"], nameplategradients["DEMONHUNTER"]["b1"], nameplategradients["DEMONHUNTER"]["r2"], nameplategradients["DEMONHUNTER"]["g2"], nameplategradients["DEMONHUNTER"]["b2"])
			end
		elseif ((r == monk.r) and (g == monk.g) and (b == monk.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("MONK"))--nameplatecustomgradients["MONK"]["r1"], nameplatecustomgradients["MONK"]["g1"], nameplatecustomgradients["MONK"]["b1"], nameplatecustomgradients["MONK"]["r2"], nameplatecustomgradients["MONK"]["g2"], nameplatecustomgradients["MONK"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("MONK"))--nameplategradients["MONK"]["r1"], nameplategradients["MONK"]["g1"], nameplategradients["MONK"]["b1"], nameplategradients["MONK"]["r2"], nameplategradients["MONK"]["g2"], nameplategradients["MONK"]["b2"])
			end
		elseif ((r == rogue.r) and (g == rogue.g) and (b == rogue.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("ROGUE"))--nameplatecustomgradients["ROGUE"]["r1"], nameplatecustomgradients["ROGUE"]["g1"], nameplatecustomgradients["ROGUE"]["b1"], nameplatecustomgradients["ROGUE"]["r2"], nameplatecustomgradients["ROGUE"]["g2"], nameplatecustomgradients["ROGUE"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("ROGUE"))--nameplategradients["ROGUE"]["r1"], nameplategradients["ROGUE"]["g1"], nameplategradients["ROGUE"]["b1"], nameplategradients["ROGUE"]["r2"], nameplategradients["ROGUE"]["g2"], nameplategradients["ROGUE"]["b2"])
			end
		--elseif ((r == priest.r) and (g == priest.g) and (b == priest.b)) then
		--	if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
		--		unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["PRIEST"]["r1"], nameplatecustomgradients["PRIEST"]["g1"], nameplatecustomgradients["PRIEST"]["b1"], nameplatecustomgradients["PRIEST"]["r2"], nameplatecustomgradients["PRIEST"]["g2"], nameplatecustomgradients["PRIEST"]["b2"])
		--	else
		--		unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["PRIEST"]["r1"], nameplategradients["PRIEST"]["g1"], nameplategradients["PRIEST"]["b1"], nameplategradients["PRIEST"]["r2"], nameplategradients["PRIEST"]["g2"], nameplategradients["PRIEST"]["b2"])
		--	end
		elseif ((r == mage.r) and (g == mage.g) and (b == mage.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("MAGE"))--nameplatecustomgradients["MAGE"]["r1"], nameplatecustomgradients["MAGE"]["g1"], nameplatecustomgradients["MAGE"]["b1"], nameplatecustomgradients["MAGE"]["r2"], nameplatecustomgradients["MAGE"]["g2"], nameplatecustomgradients["MAGE"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("MAGE"))--nameplategradients["MAGE"]["r1"], nameplategradients["MAGE"]["g1"], nameplategradients["MAGE"]["b1"], nameplategradients["MAGE"]["r2"], nameplategradients["MAGE"]["g2"], nameplategradients["MAGE"]["b2"])
			end
		elseif ((r == hunter.r) and (g == hunter.g) and (b == hunter.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("HUNTER"))--nameplatecustomgradients["HUNTER"]["r1"], nameplatecustomgradients["HUNTER"]["g1"], nameplatecustomgradients["HUNTER"]["b1"], nameplatecustomgradients["HUNTER"]["r2"], nameplatecustomgradients["HUNTER"]["g2"], nameplatecustomgradients["HUNTER"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("HUNTER"))--nameplategradients["HUNTER"]["r1"], nameplategradients["HUNTER"]["g1"], nameplategradients["HUNTER"]["b1"], nameplategradients["HUNTER"]["r2"], nameplategradients["HUNTER"]["g2"], nameplategradients["HUNTER"]["b2"])
			end
		elseif ((r == warlock.r) and (g == warlock.g) and (b == warlock.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("WARLOCK"))--nameplatecustomgradients["WARLOCK"]["r1"], nameplatecustomgradients["WARLOCK"]["g1"], nameplatecustomgradients["WARLOCK"]["b1"], nameplatecustomgradients["WARLOCK"]["r2"], nameplatecustomgradients["WARLOCK"]["g2"], nameplatecustomgradients["WARLOCK"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("WARLOCK"))--nameplategradients["WARLOCK"]["r1"], nameplategradients["WARLOCK"]["g1"], nameplategradients["WARLOCK"]["b1"], nameplategradients["WARLOCK"]["r2"], nameplategradients["WARLOCK"]["g2"], nameplategradients["WARLOCK"]["b2"])
			end
		elseif ((r == npchostile.r) and (g == npchostile.g) and (b == npchostile.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))--nameplatecustomgradients["NPCHOSTILE"]["r1"], nameplatecustomgradients["NPCHOSTILE"]["g1"], nameplatecustomgradients["NPCHOSTILE"]["b1"], nameplatecustomgradients["NPCHOSTILE"]["r2"], nameplatecustomgradients["NPCHOSTILE"]["g2"], nameplatecustomgradients["NPCHOSTILE"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))--nameplategradients["NPCHOSTILE"]["r1"], nameplategradients["NPCHOSTILE"]["g1"], nameplategradients["NPCHOSTILE"]["b1"], nameplategradients["NPCHOSTILE"]["r2"], nameplategradients["NPCHOSTILE"]["g2"], nameplategradients["NPCHOSTILE"]["b2"])
			end
		elseif ((r == npcneutral.r) and (g == npcneutral.g) and (b == npcneutral.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))--nameplatecustomgradients["NPCNEUTRAL"]["r1"], nameplatecustomgradients["NPCNEUTRAL"]["g1"], nameplatecustomgradients["NPCNEUTRAL"]["b1"], nameplatecustomgradients["NPCNEUTRAL"]["r2"], nameplatecustomgradients["NPCNEUTRAL"]["g2"], nameplatecustomgradients["NPCNEUTRAL"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))--nameplategradients["NPCNEUTRAL"]["r1"], nameplategradients["NPCNEUTRAL"]["g1"], nameplategradients["NPCNEUTRAL"]["b1"], nameplategradients["NPCNEUTRAL"]["r2"], nameplategradients["NPCNEUTRAL"]["g2"], nameplategradients["NPCNEUTRAL"]["b2"])
			end
		elseif ((r == npcfriendly.r) and (g == npcfriendly.g) and (b == npcfriendly.b)) then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))--nameplatecustomgradients["NPCFRIENDLY"]["r1"], nameplatecustomgradients["NPCFRIENDLY"]["g1"], nameplatecustomgradients["NPCFRIENDLY"]["b1"], nameplatecustomgradients["NPCFRIENDLY"]["r2"], nameplatecustomgradients["NPCFRIENDLY"]["g2"], nameplatecustomgradients["NPCFRIENDLY"]["b2"])
			else
				unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))--nameplategradients["NPCFRIENDLY"]["r1"], nameplategradients["NPCFRIENDLY"]["g1"], nameplategradients["NPCFRIENDLY"]["b1"], nameplategradients["NPCFRIENDLY"]["r2"], nameplategradients["NPCFRIENDLY"]["g2"], nameplategradients["NPCFRIENDLY"]["b2"])
			end
		--elseif ((r == goodthreat.r) and (g == goodthreat.g) and (b == goodthreat.b)) then
		--	if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
		--		unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplatecustomgradients["NPCFRIENDLY"]["r1"], nameplatecustomgradients["NPCFRIENDLY"]["g1"], nameplatecustomgradients["NPCFRIENDLY"]["b1"], nameplatecustomgradients["NPCFRIENDLY"]["r2"], nameplatecustomgradients["NPCFRIENDLY"]["g2"], nameplatecustomgradients["NPCFRIENDLY"]["b2"])
		--	else
		--		unit.Health:GetStatusBarTexture():SetGradient("VERTICAL", nameplategradients["NPCFRIENDLY"]["r1"], nameplategradients["NPCFRIENDLY"]["g1"], nameplategradients["NPCFRIENDLY"]["b1"], nameplategradients["NPCFRIENDLY"]["r2"], nameplategradients["NPCFRIENDLY"]["g2"], nameplategradients["NPCFRIENDLY"]["b2"])
		--	end
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
--hooksecurefunc(mod, "StyleFilterUpdate", testfunc)
