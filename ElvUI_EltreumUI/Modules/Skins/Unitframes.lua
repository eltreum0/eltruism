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
local paladin = {r = "0.95686066150665", g = "0.54901838302612", b = "0.72941017150879"}
local warrior = {r = "0.77646887302399", g = "0.60784178972244", b = "0.4274500310421"}
local shaman = {r = "0", g = "0.4392147064209", b = "0.86666476726532",}
local druid = {r = "0.99999779462814", g = "0.48627343773842", b = "0.039215601980686"}
local deathknight = {r = "0.76862573623657", g = "0.11764679849148", b = "0.2274504750967"}
local demonhunter = {r = "0.63921427726746", g = "0.1882348805666", b = "0.78823357820511"}
local monk = {r = "0", g = "0.99999779462814", b = "0.59607714414597"}
local rogue = {r = "0.99999779462814", g = "0.95686066150665", b = "0.40784224867821"}
local priest = {r = "0.99999779462814", g = "0.99999779462814", b = "0.99999779462814"}
local mage = {r = "0.24705828726292", g = "0.78039044141769", b = "0.92156660556793"}
local hunter = {r = "0.66666519641876", g = "0.82744914293289", b = "0.44705784320831"}
local warlock = {r = "0.52941060066223", g = "0.53333216905594", b = "0.93333131074905"}

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
		if UF.units.target then
			local unitframe = _G["ElvUF_Target"]
			if unitframe and unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					targetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettexture)
				end
				unitframe.Health:SetStatusBarTexture(targetbar)
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
		if UF.units.targettarget then
			local unitframe = _G["ElvUF_TargetTarget"]
			if unitframe and unitframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					targettargetbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.targettargettexture)
				end
				unitframe.Health:SetStatusBarTexture(targettargetbar)
			end
		end

		--focus
		local _, focusclass = UnitClass("focus")
		local focusbar = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga"
		if focusclass and UnitIsPlayer("focus") then
			focusbar = unitframeclass[focusclass]
		end
		if UF.units.focus then
			local focusframe = _G["ElvUF_Focus"]
			if focusframe and focusframe.Health then
				if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
					focusbar = E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.focustexture)
				end
				focusframe.Health:SetStatusBarTexture(focusbar)
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

				if E.db.ElvUI_EltreumUI.gradientmode.enable then
					--unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					unitframe.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, unitframecustomgradients[E.myclass]["r1"], unitframecustomgradients[E.myclass]["g1"], unitframecustomgradients[E.myclass]["b1"], unitframecustomgradients[E.myclass]["r2"], unitframecustomgradients[E.myclass]["g2"], unitframecustomgradients[E.myclass]["b2"])
					else
						unitframe.Health:GetStatusBarTexture():SetGradient("HORIZONTAL", unitframegradients[E.myclass]["r1"], unitframegradients[E.myclass]["g1"], unitframegradients[E.myclass]["b1"], unitframegradients[E.myclass]["r2"], unitframegradients[E.myclass]["g2"], unitframegradients[E.myclass]["b2"])
					end
				else
					unitframe.Health:SetStatusBarTexture(playertexture)
				end
			end
		end
	end
end

function ElvUI_EltreumUI:ChangeRaidTexture()
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable then
		local header = _G['ElvUF_Raid']
		for i = 1, header:GetNumChildren() do
			local group = select(i, header:GetChildren())
			for j = 1, group:GetNumChildren() do
				local unitbutton = select(j, group:GetChildren())
				if unitbutton and unitbutton.Health then
					local r1,g1,b1 = unitbutton.Health:GetStatusBarColor()
					local r = tostring(r1)
					local g = tostring(g1)
					local b = tostring(b1)
					if (r == paladin.r) and (g == paladin.g) and (b == paladin.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
						end
					elseif (r == warrior.r) and (g == warrior.g) and (b == warrior.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga")
						end
					elseif (r == shaman.r) and (g == shaman.g) and (b == shaman.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga")
						end
					elseif (r == druid.r) and (g == druid.g) and (b == druid.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga")
						end
					elseif (r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga")
						end
					elseif (r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga")
						end
					elseif (r == monk.r) and (g == monk.g) and (b == monk.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga")
						end
					elseif (r == rogue.r) and (g == rogue.g) and (b == rogue.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga")
						end
					elseif (r == priest.r) and (g == priest.g) and (b == priest.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
						end
					elseif (r == mage.r) and (g == mage.g) and (b == mage.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga")
						end
					elseif (r == hunter.r) and (g == hunter.g) and (b == hunter.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga")
						end
					elseif (r == warlock.r) and (g == warlock.g) and (b == warlock.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga")
						end
					else
						unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					end
				end
			end
		end
	end
end

function ElvUI_EltreumUI:ChangeRaid40Texture()
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable then
		local header = _G['ElvUF_Raid40']
		for i = 1, header:GetNumChildren() do
			local group = select(i, header:GetChildren())
			for j = 1, group:GetNumChildren() do
				local unitbutton = select(j, group:GetChildren())
				if unitbutton and unitbutton.Health then
					local r1,g1,b1 = unitbutton.Health:GetStatusBarColor()
					local r = tostring(r1)
					local g = tostring(g1)
					local b = tostring(b1)
					if (r == paladin.r) and (g == paladin.g) and (b == paladin.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
						end
					elseif (r == warrior.r) and (g == warrior.g) and (b == warrior.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga")
						end
					elseif (r == shaman.r) and (g == shaman.g) and (b == shaman.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga")
						end
					elseif (r == druid.r) and (g == druid.g) and (b == druid.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga")
						end
					elseif (r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga")
						end
					elseif (r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga")
						end
					elseif (r == monk.r) and (g == monk.g) and (b == monk.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga")
						end
					elseif (r == rogue.r) and (g == rogue.g) and (b == rogue.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga")
						end
					elseif (r == priest.r) and (g == priest.g) and (b == priest.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
						end
					elseif (r == mage.r) and (g == mage.g) and (b == mage.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga")
						end
					elseif (r == hunter.r) and (g == hunter.g) and (b == hunter.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga")
						end
					elseif (r == warlock.r) and (g == warlock.g) and (b == warlock.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga")
						end
					else
						unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					end
				end
			end
		end
	end
end

function ElvUI_EltreumUI:ChangePartyTexture()
	if E.db.ElvUI_EltreumUI.lightmode and E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable then
		local header = _G['ElvUF_Party']
		for i = 1, header:GetNumChildren() do
			local group = select(i, header:GetChildren())
			for j = 1, group:GetNumChildren() do
				local unitbutton = select(j, group:GetChildren())
				if unitbutton and unitbutton.Health then
					local r1,g1,b1 = unitbutton.Health:GetStatusBarColor()
					local r = tostring(r1)
					local g = tostring(g1)
					local b = tostring(b1)
					if (r == paladin.r) and (g == paladin.g) and (b == paladin.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
						end
					elseif (r == warrior.r) and (g == warrior.g) and (b == warrior.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warriortexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WA.tga")
						end
					elseif (r == shaman.r) and (g == shaman.g) and (b == shaman.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.shamantexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-SH.tga")
						end
					elseif (r == druid.r) and (g == druid.g) and (b == druid.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.druidtexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DR.tga")
						end
					elseif (r == deathknight.r) and (g == deathknight.g) and (b == deathknight.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.deathknighttexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DK.tga")
						end
					elseif (r == demonhunter.r) and (g == demonhunter.g) and (b == demonhunter.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.demonhuntertexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-DH.tga")
						end
					elseif (r == monk.r) and (g == monk.g) and (b == monk.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.monktexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MK.tga")
						end
					elseif (r == rogue.r) and (g == rogue.g) and (b == rogue.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.roguetexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-RG.tga")
						end
					elseif (r == priest.r) and (g == priest.g) and (b == priest.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.priesttexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PR.tga")
						end
					elseif (r == mage.r) and (g == mage.g) and (b == mage.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.magetexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-MG.tga")
						end
					elseif (r == hunter.r) and (g == hunter.g) and (b == hunter.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.huntertexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-HT.tga")
						end
					elseif (r == warlock.r) and (g == warlock.g) and (b == warlock.b) then
						if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
							unitbutton.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.warlocktexture))
						else
							unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-WL.tga")
						end
					else
						unitbutton.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga")
					end
				end
			end
		end
	end
end

--Unitframe Backdrop Texture
--function ElvUI_EltreumUI:BackdropTexture(statusBar, statusBarTex, backdropTex)
function ElvUI_EltreumUI:BackdropTexture(_, _, backdropTex)
	if E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable and not E.db.ElvUI_EltreumUI.lightmode then
		backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
		backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)

local EltruismTextureHooks = CreateFrame("FRAME")
EltruismTextureHooks:RegisterUnitEvent("PLAYER_ENTERING_WORLD")
EltruismTextureHooks:SetScript("OnEvent", function()
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

		unitframegradients = {
			['WARRIOR'] = {r1 = 0.77646887302399, g1 = 0.60784178972244, b1 = 0.4274500310421, r2 = 0.7686274509803922, g2= 0.7333333333333333, b2 = 0.6980392156862745},
			['PALADIN'] = {r1 = 0.95686066150665, g1 = 0.54901838302612, b1 = 0.72941017150879, r2 = 0.9490196078431373, g2= 0.7215686274509804, b2 = 0.8235294117647059},
			['HUNTER'] = {r1 = 0.66666519641876, g1 = 0.82744914293289, b1 = 0.44705784320831, r2 = 0.7686274509803922, g2= 0.8196078431372549, b2 = 0.7019607843137255},
			['ROGUE'] = {r1 = 0.99999779462814, g1 = 0.95686066150665, b1 = 0.40784224867821, r2 = 0.99999779462814, g2= 0.9843137254901961, b2 = 0.8274509803921569},
			['PRIEST'] = {r1 = 0.99999779462814, g1 = 0.99999779462814, b1 = 0.99999779462814, r2 = 0.3568627450980392, g2= 0.3568627450980392, b2 = 0.3568627450980392},
			['DEATHKNIGHT'] = {r1 = 0.76862573623657, g1 = 0.11764679849148, b1 = 0.2274504750967, r2 = 0.7568627450980392, g2= 0.3647058823529412, b2 = 0.4352941176470588},
			['SHAMAN'] = {r1 = 0, g1 = 0.4392147064209, b1 = 0.86666476726532, r2 = 0.3529411764705882, g2= 0.6196078431372549, b2 = 0.9098039215686275},
			['MAGE'] = {r1 = 0.24705828726292, g1 = 0.78039044141769, b1 = 0.92156660556793, r2 = 0.603921568627451, g2= 0.8549019607843137, b2 = 0.9176470588235294},
			['WARLOCK'] = {r1 = 0.52941060066223, g1 = 0.53333216905594, b1 = 0.93333131074905, r2 = 0.6941176470588235, g2= 0.6980392156862745, b2 = 0.9294117647058824},
			['MONK'] = {r1 = 0, g1 = 0.99999779462814, b1 = 0.59607714414597, r2 = 0.4588235294117647, g2= 0.99999779462814, b2 = 0.4588235294117647},
			['DRUID'] = {r1 = 0.99999779462814, g1 = 0.48627343773842, b1 = 0.039215601980686, r2 = 0.99999779462814, g2= 0.4627450980392157, b2 = 0.3294117647058824},
			['DEMONHUNTER'] = {r1 = 0.63921427726746, g1 = 0.1882348805666, b1 = 0.78823357820511, r2 = 0.6823529411764706, g2= 0.396078431372549, b2 = 0.7764705882352941},
		}




	if E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.lightmode then
			hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangeUnitTexture)
			hooksecurefunc(UF, "Style", ElvUI_EltreumUI.ChangeUnitTexture)  --if not hooking into this then when the target of target changes it doesnt update
			hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangePlayerTexture)
			hooksecurefunc(UF, 'Update_RaidFrames', ElvUI_EltreumUI.ChangeRaidTexture)
			hooksecurefunc(UF, 'Update_Raid40Frames', ElvUI_EltreumUI.ChangeRaid40Texture)
			hooksecurefunc(UF, 'Update_PartyFrames', ElvUI_EltreumUI.ChangePartyTexture)
		elseif not E.db.ElvUI_EltreumUI.lightmode then
			hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)
		end
	end
end)

local EltruismChangeUnitTextureFrame = CreateFrame("FRAME")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_TARGET", "player")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_TARGET", "target")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismChangeUnitTextureFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("PLAYER_ENTERING_WORLD")
EltruismChangeUnitTextureFrame:SetScript("OnEvent", function()
	if E.db.ElvUI_EltreumUI.modetexture and E.private.unitframe.enable and E.db.ElvUI_EltreumUI.lightmode then
		ElvUI_EltreumUI.ChangeUnitTexture()
		ElvUI_EltreumUI.ChangePlayerTexture()
		ElvUI_EltreumUI.ChangeRaidTexture()
		ElvUI_EltreumUI.ChangeRaid40Texture()
		ElvUI_EltreumUI.ChangePartyTexture()
		ElvUI_EltreumUI.ChangePlayerTexture()
	end
end)
