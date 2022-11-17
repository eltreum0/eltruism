local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local targetcastbar,focuscastbar,castbar
local reactiontarget,reactionfocus
local _, targetclass, focusclass
local IsAddOnLoaded = _G.IsAddOnLoaded
local headergroup,group,groupbutton

do

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
		if E.private.unitframe.enable then
			castbar = _G["ElvUF_Player_CastBar"]
			targetcastbar = _G["ElvUF_Target_CastBar"]
			focuscastbar = _G["ElvUF_Focus_CastBar"]

			--spark
			if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable and castbar then

				castbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
				if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' then --flip otherwise it will look wrong
					castbar.Spark_:SetTexCoord(1, 0, 0, 1)
				end
				if castbar.empowering then
					castbar.Spark_:SetBlendMode('ADD')
					castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringr, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringg, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringb, 1)
				else
					castbar.Spark_:SetBlendMode('BLEND')
					castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
				end
				castbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)

				if UnitExists("target") and targetcastbar then
					targetcastbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
					if targetcastbar.empowering then
						targetcastbar.Spark_:SetBlendMode('ADD')
						targetcastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringr, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringg, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringb, 1)
					else
						targetcastbar.Spark_:SetBlendMode('BLEND')
						targetcastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
					end

					targetcastbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
					if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' and not E.db.unitframe.units.target.castbar.reverse then
						targetcastbar.Spark_:SetTexCoord(1, 0, 0, 1)
					end
				end

				if UnitExists("focus") and focuscastbar then
					focuscastbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
					if focuscastbar.empowering then
						focuscastbar.Spark_:SetBlendMode('ADD')
						focuscastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringr, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringg, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.empoweringb, 1)
					else
						focuscastbar.Spark_:SetBlendMode('BLEND')
						focuscastbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
					end

					focuscastbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
					if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' then --flip otherwise it will look wrong
						focuscastbar.Spark_:SetTexCoord(1, 0, 0, 1)
					end
				end
			end

			--gradient/texture
			if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
				if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable and castbar then
					castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture))
					if UnitExists("target") and targetcastbar then
						targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture))
					end
				end

				--player
				if UnitExists("player") and castbar then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.unitframe.colors.transparentCastbar then
							castbar.bg:SetVertexColor(0,0,0,0)
							castbar.backdrop:SetBackdropColor(0,0,0,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						end
						if E.db.unitframe.colors.customcastbarbackdrop then
							castbar.backdrop:SetBackdropColor(E.db.unitframe.colors.castbar_backdrop.r,E.db.unitframe.colors.castbar_backdrop.g,E.db.unitframe.colors.castbar_backdrop.b,E.db.unitframe.colors.castbar_backdrop.a)
							castbar.bg:SetVertexColor(E.db.unitframe.colors.castbar_backdrop.r,E.db.unitframe.colors.castbar_backdrop.g,E.db.unitframe.colors.castbar_backdrop.b,E.db.unitframe.colors.castbar_backdrop.a)
						end
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
						if castbar.notInterruptible then --cant interrupt
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbarnoninterruptible then
								if E.db.unitframe.units.player.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
											end
										else
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, a=1})
											else
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom)
											end
										end
									else
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
											end
										else
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible,a= 1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, a=1})
											else
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible)
											end
										end
									end
								elseif not E.db.unitframe.units.player.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
											end
										else
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom, a=1})
											else
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptiblecustom)
											end
										end
									else
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
											end
										else
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible, a=1})
											else
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1noninterruptible)
											end
										end
									end
								end
							end
						elseif (not castbar.notInterruptible) then --can interrupt
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableplayercastbar then
								if E.db.unitframe.units.player.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
											end
										else
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, a=1})
											else
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1)
											end
										end
									elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, true, true))
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, true, true))
											end
										else
											castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, true))
										end
									else
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, true, true))
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, true, true))
											end
										else
											castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, true))
										end
									end
								elseif not E.db.unitframe.units.player.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
											end
										else
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2, a=1})
											else
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2)
											end
										end
									elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar then
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, true))
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, true))
											end
										else
											castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
										end
									else
										if E.db.unitframe.colors.transparentCastbar then
											if E.Retail then
												castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, true))
											else
												castbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, true))
											end
										else
											castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
										end
									end
								end
							end
						end
					end
				end

				--target
				if UnitExists("target") and targetcastbar then
					_, targetclass = UnitClass("target")
					reactiontarget = UnitReaction("target", "player")
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.unitframe.colors.transparentCastbar then
							targetcastbar.bg:SetVertexColor(0, 0, 0, 0)
							targetcastbar.backdrop:SetBackdropColor(0, 0, 0, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						end
						if E.db.unitframe.colors.customcastbarbackdrop then
							targetcastbar.backdrop:SetBackdropColor(E.db.unitframe.colors.castbar_backdrop.r,E.db.unitframe.colors.castbar_backdrop.g,E.db.unitframe.colors.castbar_backdrop.b,E.db.unitframe.colors.castbar_backdrop.a)
							targetcastbar.bg:SetVertexColor(E.db.unitframe.colors.castbar_backdrop.r,E.db.unitframe.colors.castbar_backdrop.g,E.db.unitframe.colors.castbar_backdrop.b,E.db.unitframe.colors.castbar_backdrop.a)
						end
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
						if (targetcastbar.notInterruptible) then --cant interrupt
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible then
								if E.db.unitframe.units.target.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if E.Retail then
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, a=1})
										else
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom)
										end
									else
										if E.Retail then
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, a=1})
										else
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible)
										end
									end
								elseif not E.db.unitframe.units.target.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if E.Retail then
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, a=1})
										else
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom)
										end
									else
										if E.Retail then
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, a=1})
										else
											targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible)
										end
									end
								end
							end
						elseif (not targetcastbar.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt()) then --can interrupt
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar then
								if E.db.unitframe.units.target.castbar.reverse then
									if UnitIsPlayer("target") then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1})
												else
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom)
												end
											end
										elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true, true))
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true, true))
												end
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, true))
											end
										else
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true, true))
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true, true))
												end
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1})
												else
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom)
												end
											end
										else
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
												if E.db.unitframe.colors.transparentCastbar then
													if E.Retail then
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY",true, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL",true, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY",true, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE",true, true))
															end
														else
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY",true, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL",true, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY",true, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE",true, true))
															end
														end
													else
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY",true, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL",true, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY",true, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE",true, true))
															end
														else
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY",true, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL",true, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY",true, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE",true, true))
															end
														end
													end
												else
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
												end
											else
												if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=1})
														else
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom)
														end
													end
												else
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=1})
														else
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable)
														end
													end
												end
											end
										end
									end
								elseif not E.db.unitframe.units.target.castbar.reverse then
									if UnitIsPlayer("target") then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1})
												else
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
												end
											end
										elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, false, true))
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass, false, true))
												end
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(targetclass))
											end
										else
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, false, true))
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass, false, true))
												end
											else
												targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(targetclass))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1})
												else
													targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
												end
											end
										else
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
												if E.db.unitframe.colors.transparentCastbar then
													if E.Retail then
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
															end
														else
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
															end
														end
													else
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
															end
														else
															if reactiontarget >= 5 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
															elseif reactiontarget == 4 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
															elseif reactiontarget == 3 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
															elseif reactiontarget <= 2 then
																targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
															end
														end
													end
												else
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
												end
											else
												if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=1})
														else
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom)
														end
													end
												else
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															targetcastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=1})
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

				--focus
				if UnitExists("focus") and focuscastbar then
					_, focusclass = UnitClass("focus")
					reactionfocus = UnitReaction("focus", "player")
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
						if E.db.unitframe.colors.transparentCastbar then
							focuscastbar.bg:SetVertexColor(0, 0, 0, 0)
							focuscastbar.backdrop:SetBackdropColor(0, 0, 0, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
						end
						if E.db.unitframe.colors.customcastbarbackdrop then
							focuscastbar.backdrop:SetBackdropColor(E.db.unitframe.colors.castbar_backdrop.r,E.db.unitframe.colors.castbar_backdrop.g,E.db.unitframe.colors.castbar_backdrop.b,E.db.unitframe.colors.castbar_backdrop.a)
							focuscastbar.bg:SetVertexColor(E.db.unitframe.colors.castbar_backdrop.r,E.db.unitframe.colors.castbar_backdrop.g,E.db.unitframe.colors.castbar_backdrop.b,E.db.unitframe.colors.castbar_backdrop.a)
						end
						if not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
							focuscastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
						end
						if (focuscastbar.notInterruptible) then --cant interrupt
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarnoninterruptible then
								if E.db.unitframe.units.focus.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if E.Retail then
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, a=1})
										else
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom)
										end
									else
										if E.Retail then
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, a=1})
										else
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible)
										end
									end
								elseif not E.db.unitframe.units.focus.castbar.reverse then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
										if E.Retail then
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom, a=1})
										else
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptiblecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptiblecustom)
										end
									else
										if E.Retail then
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible, a=1})
										else
											focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1noninterruptible, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1noninterruptible)
										end
									end
								end
							end
						elseif (not focuscastbar.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt()) then --can interrupt
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbar then
								if E.db.unitframe.units.focus.castbar.reverse then
									if UnitIsPlayer("focus") then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1})
												else
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom)
												end
											end
										elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, true, true))
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, true, true))
												end
											else
												focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, true))
											end
										else
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, true, true))
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, true, true))
												end
											else
												focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, true))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom,E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1})
												else
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom)
												end
											end
										else
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
												if E.db.unitframe.colors.transparentCastbar then
													if E.Retail then
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY",true, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL",true, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY",true, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE",true, true))
															end
														else
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY",true, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL",true, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY",true, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE",true, true))
															end
														end
													else
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY",true, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL",true, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY",true, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE",true, true))
															end
														else
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY",true, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL",true, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY",true, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE",true, true))
															end
														end
													end
												else
													if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
														if reactionfocus >= 5 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY",true))
														elseif reactionfocus == 4 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL",true))
														elseif reactionfocus == 3 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY",true))
														elseif reactionfocus <= 2 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE",true))
														end
													else
														if reactionfocus >= 5 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY",true))
														elseif reactionfocus == 4 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL",true))
														elseif reactionfocus == 3 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY",true))
														elseif reactionfocus <= 2 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE",true))
														end
													end
												end
											else
												if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=1})
														else
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom)
														end
													end
												else
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=1})
														else
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable)
														end
													end
												end
											end
										end
									end
								elseif not E.db.unitframe.units.focus.castbar.reverse then
									if UnitIsPlayer("focus") then
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1})
												else
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
												end
											end
										elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, false, true))
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass, false, true))
												end
											else
												focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(focusclass))
											end
										else
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, false, true))
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass, false, true))
												end
											else
												focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(focusclass))
											end
										end
									else
										if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
											if E.db.unitframe.colors.transparentCastbar then
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
												else
													focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
												end
											else
												if E.Retail then
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom, a=1})
												else
													focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2custom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2custom)
												end
											end
										else
											if E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarreactioninterruptable then
												if E.db.unitframe.colors.transparentCastbar then
													if E.Retail then
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
															end
														else
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
															end
														end
													else
														if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, true))
															end
														else
															if reactionfocus >= 5 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, true))
															elseif reactionfocus == 4 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, true))
															elseif reactionfocus == 3 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, true))
															elseif reactionfocus <= 2 then
																focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, true))
															end
														end
													end
												else
													if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar then
														if reactionfocus >= 5 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY"))
														elseif reactionfocus == 4 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL"))
														elseif reactionfocus == 3 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY"))
														elseif reactionfocus <= 2 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE"))
														end
													else
														if reactionfocus >= 5 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY"))
														elseif reactionfocus == 4 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL"))
														elseif reactionfocus == 3 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY"))
														elseif reactionfocus <= 2 then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE"))
														end
													end
												end
											else
												if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom, a=1})
														else
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptablecustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptablecustom)
														end
													end
												else
													if E.db.unitframe.colors.transparentCastbar then
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
														else
															focuscastbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha)
														end
													else
														if E.Retail then
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable, a=1})
														else
															focuscastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptable, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptable)
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

			--group unit custom texture
			headergroup = nil
			if _G["ElvUF_Raid1"] and _G["ElvUF_Raid1"]:IsShown() then
				headergroup = _G["ElvUF_Raid1"]
			elseif _G["ElvUF_Raid2"] and _G["ElvUF_Raid2"]:IsShown() then
				headergroup = _G["ElvUF_Raid2"]
			elseif _G["ElvUF_Raid3"] and _G["ElvUF_Raid3"]:IsShown() then
				headergroup = _G["ElvUF_Raid3"]
			elseif _G["ElvUF_Party"] and _G["ElvUF_Party"]:IsShown() then
				headergroup = _G["ElvUF_Party"]
			end

			if headergroup ~= nil then
				for i = 1, headergroup:GetNumChildren() do
					group = select(i, headergroup:GetChildren())
					for j = 1, group:GetNumChildren() do
						groupbutton = select(j, group:GetChildren())
						if groupbutton and groupbutton.Castbar then
							if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable then
								groupbutton.Castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture))
							end
							if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable then
								groupbutton.Castbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
								if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' then --flip otherwise it will look wrong
									groupbutton.Castbar.Spark_:SetTexCoord(1, 0, 0, 1)
								end
								groupbutton.Castbar.Spark_:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.r, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.g, E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.b, 1)
								groupbutton.Castbar.Spark_:SetWidth(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width)
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
					if E.Retail then
						if E.db.unitframe.units.player.castbar.reverse then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom, a=1})
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted,a= 1})
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom, a=1})
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted,a= 1})
							end
						end
					else
						if E.db.unitframe.units.player.castbar.reverse then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom)
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted)
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interruptedcustom)
							else
								castbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.playercastbarB2interrupted)
							end
						end
					end
				end
				--target
				if UnitExists("target") and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enabletargetcastbarinterrupted and targetcastbar ~= nil and (unit == "target") then
					targetcastbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.gradientmode.texture))
					if E.Retail then
						if E.db.unitframe.units.target.castbar.reverse then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom, a=1})
							else
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted, a=1})
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, b=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom, a=1})
							else
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted, g=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted, a=1}, {r=E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted,g= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted,b= E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted, a=1})
							end
						end
					else
						if E.db.unitframe.units.target.castbar.reverse then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom)
							else
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted)
							end
						else
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interruptedcustom, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interruptedcustom)
							else
								targetcastbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB1interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarR2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarG2interrupted, E.db.ElvUI_EltreumUI.unitframes.gradientmode.targetcastbarB2interrupted)
							end
						end
					end
				end
			end
		end
	end
	hooksecurefunc(UF, 'PostCastFail', ElvUI_EltreumUI.CastBarTextureGradientFail)

end
