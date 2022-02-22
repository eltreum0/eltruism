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

--from Benik
local function ChangeUnitTexture()
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

local EltruismChangeUnitTextureFrame = CreateFrame("FRAME")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_TARGET", "player")
EltruismChangeUnitTextureFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismChangeUnitTextureFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
EltruismChangeUnitTextureFrame:SetScript("OnEvent", ChangeUnitTexture)
hooksecurefunc(UF, "Construct_HealthBar", ChangeUnitTexture)
hooksecurefunc(UF, "Style", ChangeUnitTexture)  --if not hooking into this then when the target of target changes it doesnt update

--from Benik
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
				unitframe.Health:SetStatusBarTexture(playertexture)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_HealthBar", ElvUI_EltreumUI.ChangePlayerTexture)

local EltruismPlayerTextureUpdate = CreateFrame("FRAME")
EltruismPlayerTextureUpdate:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismPlayerTextureUpdate:SetScript("OnEvent", ElvUI_EltreumUI.ChangePlayerTexture)

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
hooksecurefunc(UF, 'Update_RaidFrames', ElvUI_EltreumUI.ChangeRaidTexture)

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
hooksecurefunc(UF, 'Update_Raid40Frames', ElvUI_EltreumUI.ChangeRaid40Texture)

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
hooksecurefunc(UF, 'Update_PartyFrames', ElvUI_EltreumUI.ChangePartyTexture)

function ElvUI_EltreumUI:LeaderIndicatorSize(frame)
	frame.LeaderIndicator:Size(E.db.ElvUI_EltreumUI.otherstuff.leadersize)
	frame.AssistantIndicator:Size(E.db.ElvUI_EltreumUI.otherstuff.leadersize)
	frame.MasterLooterIndicator:Size(E.db.ElvUI_EltreumUI.otherstuff.leadersize)
end
hooksecurefunc(UF, 'Construct_RaidRoleFrames', ElvUI_EltreumUI.LeaderIndicatorSize)


--[[   --this controls everything that is transparent, not intended
function ElvUI_EltreumUI:DarkTexture(isTransparent, statusBar)
	if isTransparent then
		statusBar:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\AsphyxiaNorm.tga")
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.DarkTexture)
]]


--actual backdrop texture
function ElvUI_EltreumUI:BackdropTexture(statusBar, statusBarTex, backdropTex)
	backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
	backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)
