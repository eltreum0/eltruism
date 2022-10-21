local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local castbar
local targetcastbar
local reactiontarget
local _, targetclass
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateColor = _G.CreateColor

function ElvUI_EltreumUI:CheckmMediaTagInterrupt()
	if IsAddOnLoaded("ElvUI_mMediaTag") then
		if E.db.mMediaTag.mCastbar.enable then
			return _G.mMediaTag_interruptinTime or _G.mMediaTag_interruptOnCD
		end
	else
		return false
	end
end

--elvui castbar texture/gradient
function ElvUI_EltreumUI:CastBarTextureGradient()
	castbar = _G["ElvUF_Player_CastBar"]
	targetcastbar = _G["ElvUF_Target_CastBar"]

	--spark
	if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable and E.private.unitframe.enable then
		castbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
		if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' then --flip otherwise it will look wrong
			castbar.Spark_:SetTexCoord(1, 0, 0, 1)
		end
		castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
		castbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
		if UnitExists("target") then
			targetcastbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
			targetcastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
			targetcastbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
		end
	end

	--gradient/texture
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture))
			if UnitExists("target") then
				targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture))
			end
		end

		--player
		if UnitExists("player") then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
				end
				if castbar.notInterruptible then --cant interrupt
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarnoninterruptible then
						if E.db.unitframe.units.player.castbar.reverse == true then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if E.Retail then
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, 1))
								else
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom)
								end
							else
								if E.Retail then
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, 1))
								else
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible)
								end
							end
						elseif E.db.unitframe.units.player.castbar.reverse == false then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if E.Retail then
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, 1))
								else
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom)
								end
							else
								if E.Retail then
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, 1))
								else
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible)
								end
							end
						end
					end
				elseif (not castbar.notInterruptible) then --can interrupt
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar then
						if E.db.unitframe.units.player.castbar.reverse == true then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
								if E.Retail then
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, 1))
								else
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1)
								end
							elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, true))
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, true))
							end
						elseif E.db.unitframe.units.player.castbar.reverse == false then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
								if E.Retail then
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, 1))
								else
									castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2)
								end
							elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
							end
						end
					end
				end
			end
		end

		--target
		if UnitExists("target") then
			_, targetclass = UnitClass("target")
			reactiontarget = UnitReaction("target", "player")
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if not  E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
					targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
				end
				if (targetcastbar.notInterruptible) then --cant interrupt
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible then
						if E.db.unitframe.units.target.castbar.reverse == true then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if E.Retail then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, 1))
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom)
								end
							else
								if E.Retail then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, 1))
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible)
								end
							end
						elseif E.db.unitframe.units.target.castbar.reverse == false then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								if E.Retail then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, 1))
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom)
								end
							else
								if E.Retail then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, 1))
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible)
								end
							end
						end
					end
				elseif (not targetcastbar.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt()) then --can interrupt
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar then
						if E.db.unitframe.units.target.castbar.reverse == true then
							if UnitIsPlayer("target") then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
									if E.Retail then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, 1))
									else
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom)
									end
								elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true))
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true))
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
									if E.Retail then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, 1))
									else
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom)
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if reactiontarget >= 5 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY",true))
											elseif reactiontarget == 4 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL",true))
											elseif reactiontarget == 3 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY",true))
											elseif reactiontarget <= 2 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE",true))
											end
										else
											if reactiontarget >= 5 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY",true))
											elseif reactiontarget == 4 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL",true))
											elseif reactiontarget == 3 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY",true))
											elseif reactiontarget <= 2 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE",true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if E.Retail then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, 1))
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom)
											end
										else
											if E.Retail then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, 1))
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable)
											end
										end
									end
								end
							end
						elseif E.db.unitframe.units.target.castbar.reverse == false then
							if UnitIsPlayer("target") then
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
									if E.Retail then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, 1))
									else
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
									end
								elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass))
								else
									targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))
								end
							else
								if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
									if E.Retail then
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, 1))
									else
										targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
									end
								else
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if reactiontarget >= 5 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
											elseif reactiontarget == 4 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
											elseif reactiontarget == 3 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
											elseif reactiontarget <= 2 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
											end
										else
											if reactiontarget >= 5 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
											elseif reactiontarget == 4 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
											elseif reactiontarget == 3 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
											elseif reactiontarget <= 2 then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
											if E.Retail then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, 1))
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom)
											end
										else
											if E.Retail then
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, 1))
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable)
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
	end
end
hooksecurefunc(UF, 'Construct_Castbar', ElvUI_EltreumUI.CastBarTextureGradient)
hooksecurefunc(UF, 'PostCastStart', ElvUI_EltreumUI.CastBarTextureGradient)

--color when interrupted
function ElvUI_EltreumUI:CastBarTextureGradientFail(unit)
	if not unit then return end

	castbar = _G["ElvUF_Player_CastBar"]
	targetcastbar = _G["ElvUF_Target_CastBar"]

	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) then
			--player
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarinterrupted and (unit == "player") then
				castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
				if E.db.unitframe.units.player.castbar.reverse == true then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom, 1))
					else
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted, 1))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom, 1))
					else
						castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted, 1))
					end
				end
			end
			--target
			if UnitExists("target") and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarinterrupted and targetcastbar ~= nil and (unit == "target") then
				targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
				if E.db.unitframe.units.target.castbar.reverse == true then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom, 1))
					else
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted, 1))
					end
				else
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom, 1))
					else
						targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted, 1), CreateColor(E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted, 1))
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, 'PostCastFail', ElvUI_EltreumUI.CastBarTextureGradientFail)
