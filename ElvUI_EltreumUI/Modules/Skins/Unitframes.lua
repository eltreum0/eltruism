local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local tostring = _G.tostring
local select = _G.select

--set the textures or gradients
local truer = 0
local trueg = 0
local trueb = 0
local trueclass

function ElvUI_EltreumUI:ApplyUnitGradientTexture(unit,name)
	local _, classunit = UnitClass(unit)
	local namebar
	local reaction = UnitReaction(unit, "player")
	if UnitExists(unit) then
		if UnitIsPlayer(unit) then
			if classunit then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture(classunit)
			end
		elseif not UnitIsPlayer(unit) then
			if reaction >= 5 then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCFRIENDLY")
			elseif reaction == 4 then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCNEUTRAL")
			elseif reaction == 3 then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCUNFRIENDLY")
			elseif reaction <= 2 then
				namebar = ElvUI_EltreumUI:UnitframeClassTexture("NPCHOSTILE")
			end
		end
	end
	if UF["units"][unit] and UnitExists(unit) then
		local unitframe = _G["ElvUF_"..name]
		if unitframe and unitframe.Health then
			if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
				if UnitIsPlayer(unit) then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						namebar = ElvUI_EltreumUI:UnitframeClassTextureCustom(classunit)
					else
						namebar = E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["ufcustomtexture"][unit.."texture"])
					end
				elseif not UnitIsPlayer(unit) then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.classdetect then
						if reaction >= 5 then
							namebar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCFRIENDLY")
						elseif reaction == 4 then
							namebar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCNEUTRAL")
						elseif reaction == 3 then
							namebar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCUNFRIENDLY")
						elseif reaction <= 2 then
							namebar = ElvUI_EltreumUI:UnitframeClassTextureCustom("NPCHOSTILE")
						end
					else
						namebar = E.LSM:Fetch("statusbar", E.db["ElvUI_EltreumUI"]["ufcustomtexture"][unit.."texture"])
					end
				end
			end
			if E.db.ElvUI_EltreumUI.gradientmode.enable and UnitIsPlayer(unit) and E.db["ElvUI_EltreumUI"]["gradientmode"]["enable"..unit] then
				if E.db.ElvUI_EltreumUI.lightmode then
					unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, true))
							else
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
							end
						else
							unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
						end
					else
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, true))
							else
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
							end
						else
							unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.darkmode then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, true, true))
							else
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
							end
						else
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, true))
						end
					else
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if unit == "target" then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, true, true))
							else
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
							end
						else
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, true))
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer(unit)) and E.db["ElvUI_EltreumUI"]["gradientmode"]["enable"..unit] then
				if E.db.ElvUI_EltreumUI.lightmode then
					unitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
						if unit == "target" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reaction >= 5 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reaction == 4 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reaction == 3 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reaction <= 2 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reaction >= 5 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reaction == 4 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reaction == 3 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reaction <= 2 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reaction >= 5 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reaction == 4 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reaction == 3 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reaction <= 2 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reaction >= 5 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reaction == 4 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reaction == 3 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reaction <= 2 then
									unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reaction >= 5 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
							elseif reaction == 4 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
							elseif reaction == 3 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
							elseif reaction <= 2 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
							end
						else
							if reaction >= 5 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
							elseif reaction == 4 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
							elseif reaction == 3 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
							elseif reaction <= 2 then
								unitframe.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.darkmode then
					unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
					if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
						if unit == "target" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reaction >= 5 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reaction == 4 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reaction == 3 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reaction == 2 or reaction == 1 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reaction >= 5 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reaction == 4 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reaction == 3 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reaction == 2 or reaction == 1 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reaction >= 5 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reaction == 4 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reaction == 3 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reaction == 2 or reaction == 1 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reaction >= 5 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reaction == 4 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reaction == 3 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reaction == 2 or reaction == 1 then
									unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
								end
							end
						end
					else
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reaction >= 5 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
							elseif reaction == 4 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
							elseif reaction == 3 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
							elseif reaction == 2 or reaction == 1 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
							end
						else
							if reaction >= 5 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
							elseif reaction == 4 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
							elseif reaction == 3 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
							elseif reaction == 2 or reaction == 1 then
								unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
							end
						end
					end
				end
			else
				if E.db.ElvUI_EltreumUI.lightmode then
					unitframe.Health:SetStatusBarTexture(namebar)
				end
			end
		end
	end
end

function ElvUI_EltreumUI:GradientCustomTexture(unit)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then

		--main issue = the toggle for some units like boss and arena wont work bc it checks for boss1,boss2... instead of just boss
		ElvUI_EltreumUI:ApplyUnitGradientTexture("player", "Player")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("target", "Target")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("targettarget", "TargetTarget")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("targettargettarget", "TargetTargetTarget")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("focus", "Focus")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("pet", "Pet")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("arena1", "Arena1")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("arena2", "Arena2")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("arena3", "Arena3")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("arena4", "Arena4")
		ElvUI_EltreumUI:ApplyUnitGradientTexture("arena5", "Arena5")
		if E.Retail then
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss1", "Boss1")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss2", "Boss2")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss3", "Boss3")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss4", "Boss4")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss5", "Boss5")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss6", "Boss6")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss7", "Boss7")
			ElvUI_EltreumUI:ApplyUnitGradientTexture("boss8", "Boss8")
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
			truer = 0
			trueg = 0
			trueb = 0

			if E.db.ElvUI_EltreumUI.lightmode then
				if E. Retail then
					if unit1class == 'WARRIOR' then
						truer = 0.77646887302399
						trueg = 0.60784178972244
						trueb = 0.4274500310421
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.95686066150665
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.66666519641876
						trueg = 0.82744914293289
						trueb = 0.44705784320831
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.99999779462814
						trueg = 0.95686066150665
						trueb = 0.40784224867821
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.gradientmode.enable then --priest ruins everything gradient
						trueclass = "PRIEST"
						return
					elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.gradientmode.enable then
						truer = 0.99999779462814
						trueg = 0.99999779462814
						trueb = 0.99999779462814
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.11764679849148
						trueb = 0.2274504750967
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' then
						truer = 0
						trueg = 0.4392147064209
						trueb = 0.86666476726532
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.24705828726292
						trueg = 0.78039044141769
						trueb = 0.92156660556793
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.52941060066223
						trueg = 0.53333216905594
						trueb = 0.93333131074905
						trueclass = "WARLOCK"
					elseif unit1class == 'MONK' then
						truer = 0
						trueg = 0.99999779462814
						trueb = 0.59607714414597
						trueclass = "MONK"
					elseif unit1class == 'DRUID' then
						truer = 0.99999779462814
						trueg = 0.48627343773842
						trueb = 0.039215601980686
						trueclass = "DRUID"
					elseif unit1class == 'DEMONHUNTER' then
						truer = 0.63921427726746
						trueg = 0.1882348805666
						trueb = 0.78823357820511
						trueclass = "DEMONHUNTER"
					end
				elseif E.Wrath or E.TBC or E.Classic then
					if unit1class == 'WARRIOR' then
						truer = 0.78039044141769
						trueg = 0.61176335811615
						trueb = 0.43137159943581
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.96078222990036
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.67058676481247
						trueg = 0.8313707113266
						trueb = 0.45097941160202
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.99999779462814
						trueg = 0.96078222990036
						trueb = 0.41176378726959
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' and E.db.ElvUI_EltreumUI.gradientmode.enable then --priest ruins everything gradient
						trueclass = "PRIEST"
						return
					elseif unit1class == 'PRIEST' and not E.db.ElvUI_EltreumUI.gradientmode.enable then
						truer = 0.99999779462814
						trueg = 0.99999779462814
						trueb = 0.99999779462814
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.76862573623657
						trueg = 0.1215683594346
						trueb = 0.23137204349041
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
						truer = 0
						trueg = 0.4392147064209
						trueb = 0.87058633565903
						trueclass = "SHAMAN"
					elseif unit1class == 'SHAMAN' and E.Classic then
						truer = 0.96078222990036
						trueg = 0.54901838302612
						trueb = 0.72941017150879
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.25097984075546
						trueg = 0.78039044141769
						trueb = 0.92156660556793
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.52941060066223
						trueg = 0.52941060066223
						trueb = 0.92940974235535
						trueclass = "WARLOCK"
					elseif unit1class == 'DRUID' then
						truer = 0.99999779462814
						trueg = 0.49019500613213
						trueb = 0.039215601980686
						trueclass = "DRUID"
					end
				end
			elseif E.db.ElvUI_EltreumUI.darkmode then
				if E. Retail then
					if unit1class == 'WARRIOR' then
						truer = 0.58039087057114
						trueg = 0.45490095019341
						trueb = 0.32156792283058
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.71764546632767
						trueg = 0.41176378726959
						trueb = 0.54509681463242
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.49803811311722
						trueg = 0.61960649490356
						trueb = 0.33333259820938
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.74901795387268
						trueg = 0.71764546632767
						trueb = 0.30588167905807
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' then
						truer = 0.74901795387268
						trueg = 0.74901795387268
						trueb = 0.74901795387268
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.086274318397045
						trueb = 0.16862708330154
						trueclass = "DEATHKNIGHT"
					elseif unit1class == 'SHAMAN' then
						truer = 0
						trueg = 0.32941102981567
						trueb = 0.65097898244858
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.18431332707405
						trueg = 0.58431243896484
						trueb = 0.69019454717636
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.39607757329941
						trueg = 0.39999911189079
						trueb = 0.69803768396378
						trueclass = "WARLOCK"
					elseif unit1class == 'MONK' then
						truer = 0
						trueg = 0.74901795387268
						trueb = 0.44705784320831
						trueclass = "MONK"
					elseif unit1class == 'DRUID' then
						truer = 0.74901795387268
						trueg = 0.36470508575439
						trueb = 0.027450919151306
						trueclass = "DRUID"
					elseif unit1class == 'DEMONHUNTER' then
						truer = 0.47843033075333
						trueg = 0.14117616415024
						trueb = 0.59215557575226
						trueclass = "DEMONHUNTER"
					end
				elseif E.Wrath or E.TBC or E.Classic then
					if unit1class == 'WARRIOR' then
						truer = 0.58431243896484
						trueg = 0.45882251858711
						trueb = 0.32156792283058
						trueclass = "WARRIOR"
					elseif unit1class == 'PALADIN' then
						truer = 0.72156703472137
						trueg = 0.41176378726959
						trueb = 0.54901838302612
						trueclass = "PALADIN"
					elseif unit1class == 'HUNTER' then
						truer = 0.50195968151093
						trueg = 0.62352806329727
						trueb = 0.33725416660309
						trueclass = "HUNTER"
					elseif unit1class == 'ROGUE' then
						truer = 0.74901795387268
						trueg = 0.72156703472137
						trueb = 0.30588167905807
						trueclass = "ROGUE"
					elseif unit1class == 'PRIEST' then
						truer = 0.74901795387268
						trueg = 0.74901795387268
						trueb = 0.74901795387268
						trueclass = "PRIEST"
					elseif unit1class == 'DEATHKNIGHT' then
						truer = 0.57646930217743
						trueg = 0.090195879340172
						trueb = 0.17254863679409
						trueclass = "DEMONHUNTER"
					elseif unit1class == 'SHAMAN' and (E.Wrath or E.TBC) then
						truer = 0
						trueg = 0.32941102981567
						trueb = 0.65097898244858
						trueclass = "SHAMAN"
					elseif unit1class == 'SHAMAN' and E.Classic then
						truer = 0.72156703472137
						trueg = 0.41176378726959
						trueb = 0.54901838302612
						trueclass = "SHAMAN"
					elseif unit1class == 'MAGE' then
						truer = 0.1882348805666
						trueg = 0.58431243896484
						trueb = 0.69019454717636
						trueclass = "MAGE"
					elseif unit1class == 'WARLOCK' then
						truer = 0.39607757329941
						trueg = 0.39607757329941
						trueb = 0.69803768396378
						trueclass = "WARLOCK"
					elseif unit1class == 'DRUID' then
						truer = 0.74901795387268
						trueg = 0.3686266541481
						trueb = 0.031372480094433
						trueclass = "DRUID"
					end
				end
			end

			local function ApplyGroupGradientTexture(g1,b1,r1,r,g,b,button)
				if tostring(g1) == tostring(trueg) and tostring(r1) == tostring(truer) and tostring(b1) == tostring(trueb) then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
						if E.db.ElvUI_EltreumUI.lightmode then
							button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								button.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass, false, true))
							else
								button.Health:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass, false, true))
							end
						elseif E.db.ElvUI_EltreumUI.darkmode then
							button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass, false, true))
							else
								button.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass, false, true))
							end
						end
					elseif not E.db.ElvUI_EltreumUI.gradientmode.enable then
						if E.db.ElvUI_EltreumUI.lightmode then
							if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
								button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
							else
								--button.Health:SetStatusBarTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-PL.tga")
								button.Health:SetStatusBarTexture(ElvUI_EltreumUI:UnitframeClassTexture(trueclass))
							end
						elseif E.db.ElvUI_EltreumUI.darkmode then
							if E.db.ElvUI_EltreumUI.ufcustomtexture.enable then
								button.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.paladintexture))
							end
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
							ApplyGroupGradientTexture(g1,b1,r1, r,g,b, groupbutton)
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
						ApplyGroupGradientTexture(g1,b1,r1, r,g,b, tankbutton)
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
						ApplyGroupGradientTexture(g1,b1,r1, r,g,b, assistbutton)
					end
				end
			end
		end

	end
end
hooksecurefunc(UF, "Style", ElvUI_EltreumUI.GradientCustomTexture) --if not hooking into this then when the target of target changes it doesnt update
hooksecurefunc(UF, "PostUpdateHealthColor", ElvUI_EltreumUI.GradientCustomTexture)

--Unitframe Backdrop Texture/Alpha
function ElvUI_EltreumUI:BackdropTexture(_, statusbar, backdropTex)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then
		if backdropTex and not E.db.ElvUI_EltreumUI.ufcustomtexture.backdrophidden then
			backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
			backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
			if statusbar and statusbar.backdrop and statusbar:GetName():match("Health") then
				statusbar.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
			end
		end
		if E.db.ElvUI_EltreumUI.ufcustomtexture.backdrophidden then
			if E.db.ElvUI_EltreumUI.lightmode then
				if backdropTex then
					backdropTex:SetAlpha(0)
				end
			end
			if statusbar and statusbar.backdrop and statusbar:GetName():match("Health") then
				statusbar.backdrop:Hide()
			end
		end
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)
--[[hooksecurefunc(UF, 'UpdateBackdropTextureColor', function()
	ElvUI_EltreumUI:BackdropTexture()
end)]]
