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
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
						else
							unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, true))
						else
							unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, true))
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
		local reactiontarget = UnitReaction("target", "player")
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
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true))
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true))
							else
								targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true, true))
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true, true))
							else
								targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, false, true))
							end
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("target")) and E.db.ElvUI_EltreumUI.gradientmode.enabletarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactiontarget == 4 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactiontarget == 3 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactiontarget >= 5 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactiontarget == 4 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactiontarget == 3 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactiontarget == 2 or reactiontarget == 1 then
									targetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
		local reactiontargettarget = UnitReaction("targettarget", "player")
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
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargetclass))
						else
							targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargetclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargetclass, false, true))
						else
							targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargetclass, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("targettarget")) and E.db.ElvUI_EltreumUI.gradientmode.enabletargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAl", true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAl"))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactiontargettarget >= 5 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactiontargettarget == 4 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactiontargettarget == 3 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactiontargettarget == 2 or reactiontarget == 1 then
									targettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
		local reactiontargettargettarget = UnitReaction("targettargettarget", "player")
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
							targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargettargetclass))
						else
							targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation,ElvUI_EltreumUI:GradientColors(targettargettargetclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targettargettargetclass, false, true))
						else
							targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targettargettargetclass, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("targettargettarget")) and E.db.ElvUI_EltreumUI.gradientmode.enabletargettargettarget then
					if E.db.ElvUI_EltreumUI.lightmode then
						targettargettargetunitframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAl", true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						targettargettargetunitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", true, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", true, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", true, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", true, true))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", true, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", true, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", true, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", true, true))
								end
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactiontargettargettarget >= 5 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactiontargettargettarget == 4 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactiontargettargettarget == 3 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactiontargettargettarget == 2 or reactiontarget == 1 then
									targettargettargetunitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
		local reactionfocus = UnitReaction("focus", "player")
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
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass))
						else
							focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, false, true))
						else
							focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, false, true))
						end
					end
				elseif E.db.ElvUI_EltreumUI.gradientmode.enable and (not UnitIsPlayer("focus")) and E.db.ElvUI_EltreumUI.gradientmode.enablefocus then
					if E.db.ElvUI_EltreumUI.lightmode then
						focusframe.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
							elseif reactionfocus == 4 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
							elseif reactionfocus == 3 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						focusframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
							end
						else
							if reactionfocus >= 5 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
							elseif reactionfocus == 4 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
							elseif reactionfocus == 3 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
							elseif reactionfocus == 2 or reactionfocus == 1 then
								focusframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
						else
							petframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						petframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
						else
							petframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
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
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, true))
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, true))
							else
								arena1unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena1unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, true, true))
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena1class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, true, true))
							else
								arena1unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena1class, false, true))
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
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, true))
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, true))
							else
								arena2unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena2unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, true, true))
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena2class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, true, true))
							else
								arena2unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena2class, false, true))
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
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, true))
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, true))
							else
								arena3unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena3unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, true, true))
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena3class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, true, true))
							else
								arena3unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena3class, false, true))
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
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class, true))
							else
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class, true))
							else
								arena4unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena4unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class, true, true))
							else
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena4class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class, true, true))
							else
								arena4unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena4class, false, true))
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
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class, true))
							else
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class, true))
							else
								arena5unitframe.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class))
							end
						end
					elseif E.db.ElvUI_EltreumUI.darkmode then
						arena5unitframe.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
						if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class, true, true))
							else
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(arena5class, false, true))
							end
						else
							if E.db.ElvUI_EltreumUI.gradientmode.orientation == "HORIZONTAL" then
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class, true, true))
							else
								arena5unitframe.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(arena5class, false, true))
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
			local reactionboss1 = UnitReaction("boss1", "player")
			if bossframe1 and reactionboss1 ~= nil then
				if bossframe1 and bossframe1.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe1.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss1 >= 5 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss1 == 4 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss1 == 3 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss1 >= 5 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss1 == 4 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss1 == 3 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe1.Health.backdropTex then
							bossframe1.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss1 >= 5 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss1 == 4 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss1 == 3 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss1 >= 5 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss1 == 4 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss1 == 3 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss1 == 2 or reactionboss1 == 1 then
									bossframe1.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss2 = UnitReaction("boss2", "player")
			if bossframe2 and reactionboss2 ~= nil then
				if bossframe2 and bossframe2.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe2.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss2 >= 5 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss2 == 4 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss2 == 3 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss2 >= 5 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss2 == 4 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss2 == 3 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe2.Health.backdropTex then
							bossframe2.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss2 >= 5 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss2 == 4 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss2 == 3 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss2 >= 5 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss2 == 4 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss2 == 3 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss2 == 2 or reactionboss2 == 1 then
									bossframe2.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss3 = UnitReaction("boss3", "player")
			if bossframe3 and reactionboss3 ~= nil then
				if bossframe3 and bossframe3.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe3.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss3 >= 5 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss3 == 4 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss3 == 3 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss3 >= 5 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss3 == 4 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss3 == 3 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe3.Health.backdropTex then
							bossframe3.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss3 >= 5 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss3 == 4 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss3 == 3 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss3 >= 5 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss3 == 4 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss3 == 3 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss3 == 2 or reactionboss3 == 1 then
									bossframe3.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss4 = UnitReaction("boss4", "player")
			if bossframe4 and reactionboss4 ~= nil then
				if bossframe4 and bossframe4.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe4.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss4 >= 5 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss4 == 4 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss4 == 3 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss4 >= 5 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss4 == 4 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss4 == 3 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe4.Health.backdropTex then
							bossframe4.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss4 >= 5 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss4 == 4 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss4 == 3 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss4 >= 5 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss4 == 4 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss4 == 3 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss4 == 2 or reactionboss4 == 1 then
									bossframe4.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss5 = UnitReaction("boss5", "player")
			if bossframe5 and reactionboss5 ~= nil then
				if bossframe5 and bossframe5.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe5.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss5 >= 5 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss5 == 4 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss5 == 3 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss5 >= 5 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss5 == 4 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss5 == 3 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe5.Health.backdropTex then
							bossframe5.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss5 >= 5 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss5 == 4 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss5 == 3 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss5 >= 5 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss5 == 4 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss5 == 3 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss5 == 2 or reactionboss5 == 1 then
									bossframe5.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss6 = UnitReaction("boss6", "player")
			if bossframe6 and reactionboss6 ~= nil then
				if bossframe6 and bossframe6.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe6.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss6 >= 5 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss6 == 4 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss6 == 3 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss6 >= 5 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss6 == 4 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss6 == 3 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe6.Health.backdropTex then
							bossframe6.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss6 >= 5 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss6 == 4 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss6 == 3 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss6 >= 5 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss6 == 4 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss6 == 3 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss6 == 2 or reactionboss6 == 1 then
									bossframe6.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss7 = UnitReaction("boss7", "player")
			if bossframe7 and reactionboss7 ~= nil then
				if bossframe7 and bossframe7.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe7.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss7 >= 5 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss7 == 4 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss7 == 3 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss7 >= 5 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss7 == 4 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss7 == 3 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe7.Health.backdropTex then
							bossframe7.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss7 >= 5 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss7 == 4 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss7 == 3 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss7 >= 5 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss7 == 4 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss7 == 3 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss7 == 2 or reactionboss7 == 1 then
									bossframe7.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local reactionboss8 = UnitReaction("boss8", "player")
			if bossframe8 and reactionboss8 ~= nil then
				if bossframe8 and bossframe8.Health then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enableboss then
						if E.db.ElvUI_EltreumUI.lightmode then
							bossframe8.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss8 >= 5 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
								elseif reactionboss8 == 4 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
								elseif reactionboss8 == 3 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
								end
							else
								if reactionboss8 >= 5 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
								elseif reactionboss8 == 4 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
								elseif reactionboss8 == 3 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
								end
							end
						elseif E.db.ElvUI_EltreumUI.darkmode and bossframe8.Health.backdropTex then
							bossframe8.Health.backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								if reactionboss8 >= 5 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
								elseif reactionboss8 == 4 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
								elseif reactionboss8 == 3 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
								end
							else
								if reactionboss8 >= 5 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
								elseif reactionboss8 == 4 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
								elseif reactionboss8 == 3 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
								elseif reactionboss8 == 2 or reactionboss8 == 1 then
									bossframe8.Health.backdropTex:SetGradientAlpha(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
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
			local trueclass
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

			local function ApplyGradientTexture(g1,b1,r1,r,g,b,button)
				if tostring(g1) == tostring(trueg) and tostring(r1) == tostring(truer) and tostring(b1) == tostring(trueb) then
					if E.db.ElvUI_EltreumUI.gradientmode.enable and E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits then
						if E.db.ElvUI_EltreumUI.lightmode then
							button.Health:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.gradientmode.texture))
							if E.db.ElvUI_EltreumUI.gradientmode.customcolor then
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(trueclass))
							else
								button.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(trueclass))
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

--Unitframe Backdrop Texture/Alpha
function ElvUI_EltreumUI:BackdropTexture(_, statusbar, backdropTex)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.UFmodifications then --and (not E.db.ElvUI_EltreumUI.lightmode) then
		--if not E.db.ElvUI_EltreumUI.gradientmode.enable then
			if backdropTex then
				backdropTex:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.ufcustomtexture.backdroptexture))
				backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
				if E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha < 1 and E.db.ElvUI_EltreumUI.lightmode then
					if statusbar and statusbar.backdrop then
						statusbar.backdrop:Hide()
					end
				end
			end
			if E.db.ElvUI_EltreumUI.ufcustomtexture.backdrophidden then
				if statusbar and statusbar.backdrop then
					if E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha == 0 then
						statusbar.backdrop:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
						backdropTex:SetAlpha(E.db.ElvUI_EltreumUI.ufcustomtexture.backdropalpha)
					else
						statusbar.backdrop:Hide()
						backdropTex:SetAlpha(0)
					end
				end
			end
		--end
	end
end
hooksecurefunc(UF, 'ToggleTransparentStatusBar', ElvUI_EltreumUI.BackdropTexture)
--[[hooksecurefunc(UF, 'UpdateBackdropTextureColor', function()
	ElvUI_EltreumUI:BackdropTexture()
end)]]
