local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local hooksecurefunc = _G.hooksecurefunc

--elvui castbar texture/gradient
function ElvUI_EltreumUI:CastBarTextureGradient(castbar, unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not E.private.unitframe.enable then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end

	if not castbar or not castbar.GetStatusBarTexture then
		castbar = _G["ElvUF_Player_CastBar"]
		unit = "player"
	end
	unit = unit or (castbar and castbar.__owner and castbar.__owner.unit)
	if not unit or not UnitExists(unit) then return end

	local parent = castbar.__owner or castbar:GetParent()
	local db = parent and parent.db and parent.db.castbar
	local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture

	if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable and castbar.Spark_ then
		castbar.Spark_:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture))
		if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture == 'Eltreum-Fade' and not (db and db.reverse) then
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
	end

	if castbar.SafeZone then
		castbar.SafeZone:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	end

	if ufCustom.enable then
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", ufCustom.castbartexture))
	elseif gm.enable then
		if gm.useUFtexture then
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		else
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", gm.texture))
		end
	end

	if gm.enable then
		if E.db.unitframe.colors.transparentCastbar then
			if castbar.bg then castbar.bg:SetVertexColor(0, 0, 0, 0) end
			if castbar.backdrop then castbar.backdrop:SetBackdropColor(0, 0, 0, ufCustom.backdropalpha) end
		end
		if E.db.unitframe.colors.customcastbarbackdrop then
			local cb = E.db.unitframe.colors.castbar_backdrop
			if castbar.backdrop then castbar.backdrop:SetBackdropColor(cb.r, cb.g, cb.b, cb.a) end
			if castbar.bg then castbar.bg:SetVertexColor(cb.r, cb.g, cb.b, cb.a) end
		end

		local tex = castbar:GetStatusBarTexture()
		if not tex then return end

		local orientation = gm.orientation or "HORIZONTAL"
		local isReverse = db and db.reverse
		local isCustom = gm.customcolor or gm.npcustomcolor
		local notInterruptible = E:NotSecretValue(castbar.notInterruptible) and castbar.notInterruptible
		local c1, c2

		if notInterruptible then
			if gm.enablecastbarnoninterruptible then
				c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "noninterruptible_custom" or "noninterruptible_default", isReverse)
			end
		else
			if not gm.enablecastbar then return end
			local isPlayer = (unit == "player") or UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit))
			local _, unitclass = UnitClass(unit)
			if not E:NotSecretValue(unitclass) then
				unitclass = E.myclass
			end
			if isPlayer then
				if isCustom and not gm.classcolorcastbar then
					c1, c2 = ElvUI_EltreumUI:GetCastbarGradient("castbar_custom", isReverse)
				elseif gm.classcolorcastbar then
					c1, c2 = ElvUI_EltreumUI:GetHealthGradient(unitclass, isReverse, isCustom)
				else
					c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interruptible_custom" or "interruptible_default", isReverse)
				end
			else
				if gm.castbarreactioninterruptable  then
					local reaction = UnitReaction(unit, "player")
					local reactionKey = "NPCNEUTRAL"
					if reaction then
						if reaction >= 5 then
							reactionKey = "NPCFRIENDLY"
						elseif reaction == 3 then
							reactionKey = "NPCUNFRIENDLY"
						elseif reaction <= 2 then
							reactionKey = "NPCHOSTILE"
						end
					end
					c1, c2 = ElvUI_EltreumUI:GetHealthGradient(reactionKey, isReverse, isCustom)
				else
					c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interruptible_custom" or "interruptible_default", isReverse)
				end
			end
		end
		if c1 and c2 then
			tex:SetGradient(orientation, c1, c2)
		end

		if E.Modern and castbar.Shield then
			local sc1, sc2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "noninterruptible_custom" or "noninterruptible_default")
			if sc1 and sc2 then
				castbar.Shield:SetVertexColor(sc2.r, sc2.g, sc2.b, 1)
				if castbar.ShieldGradientOverlay then
					castbar.ShieldGradientOverlay:SetVertexColor(sc1.r, sc1.g, sc1.b, 1)
				end
			end
		end
	end
end

function ElvUI_EltreumUI:UF_Construct_Castbar(_, frame)
	if ElvUI_EltreumUI.CastBarTextureGradient then
		ElvUI_EltreumUI:CastBarTextureGradient(frame and frame.Castbar, frame and frame.unit)
	end
	if ElvUI_EltreumUI.CastbarEffects then
		ElvUI_EltreumUI:CastbarEffects()
	end
end

function ElvUI_EltreumUI:UF_PostCastStart(castbar, unit)
	if ElvUI_EltreumUI.CastBarTextureGradient then
		ElvUI_EltreumUI:CastBarTextureGradient(castbar, unit)
	end
	if ElvUI_EltreumUI.CastbarEffects then
		ElvUI_EltreumUI:CastbarEffects()
	end
end
ElvUI_EltreumUI:SecureHook(UF, 'Construct_Castbar', 'UF_Construct_Castbar')
ElvUI_EltreumUI:SecureHook(UF, 'PostCastStart', 'UF_PostCastStart')
ElvUI_EltreumUI:SecureHook(UF, 'PostCastInterruptible', 'CastBarTextureGradient')

--color when interrupted/failed
function ElvUI_EltreumUI:CastBarTextureGradientFail(castbar)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not castbar or not castbar.GetStatusBarTexture then return end

	local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end
	local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture

	if ufCustom.enable then
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", ufCustom.castbartexture))
	elseif gm.enable then
		if gm.useUFtexture then
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		else
			castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", gm.texture))
		end
	end

	if gm.enable and gm.enablecastbarinterrupted then
		local tex = castbar:GetStatusBarTexture()
		if not tex then return end

		local parent = castbar.__owner or castbar:GetParent()
		local db = parent and parent.db and parent.db.castbar
		local isReverse = db and db.reverse

		local isCustom = gm.customcolor or gm.npcustomcolor
		local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interrupted_custom" or "interrupted_default", isReverse)
		if c1 and c2 then
			tex:SetGradient(gm.orientation or "HORIZONTAL", c1, c2)
		end
	end
end
ElvUI_EltreumUI:SecureHook(UF, 'PostCastFail', 'CastBarTextureGradientFail')
ElvUI_EltreumUI:SecureHook(UF, 'PostCastInterrupted', 'CastBarTextureGradientFail')

function ElvUI_EltreumUI:UF_Configure_Castbar(arg1, arg2)
	local targetFrame = (arg1 and arg1.Castbar and arg1) or (arg2 and arg2.Castbar and arg2)
	if not targetFrame or not targetFrame.Castbar then return end
	local castbar = targetFrame.Castbar
	if not (E.Modern and castbar.Shield) then return end
	local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	if not (gm and gm.enable and gm.enablecastbarnoninterruptible) then return end

	local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture
	if ufCustom and ufCustom.enable then
		castbar.Shield:SetTexture(E.LSM:Fetch("statusbar", ufCustom.castbartexture))
	elseif gm.useUFtexture then
		castbar.Shield:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	else
		castbar.Shield:SetTexture(E.LSM:Fetch("statusbar", gm.texture))
	end

	local orientation = gm.orientation or "HORIZONTAL"
	local isCustom = gm.customcolor or gm.npcustomcolor
	local isReverse = false
	if castbar.GetReverseFill then
		isReverse = castbar:GetReverseFill()
	end
	if not isReverse and targetFrame.db and targetFrame.db.castbar then
		isReverse = targetFrame.db.castbar.reverse
	end
	if not isReverse and castbar.reverse then
		isReverse = true
	end

	local sc1, sc2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "noninterruptible_custom" or "noninterruptible_default")
	if not (sc1 and sc2) then return end

	if not castbar.ShieldGradientOverlay then
		castbar.ShieldGradientOverlay = castbar:CreateTexture(nil, 'OVERLAY', nil, 3)
	end
	castbar.ShieldGradientOverlay:ClearAllPoints()
	castbar.ShieldGradientOverlay:SetAllPoints(castbar.Shield)

	if orientation == "VERTICAL" then
		castbar.ShieldGradientOverlay:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade2.tga")
		if isReverse then
			castbar.ShieldGradientOverlay:SetTexCoord(0, 1, 1, 0)
		else
			castbar.ShieldGradientOverlay:SetTexCoord(1, 0, 0, 1)
		end
	else
		castbar.ShieldGradientOverlay:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade.tga")
		if isReverse then
			castbar.ShieldGradientOverlay:SetTexCoord(0, 1, 0, 1)
		else
			castbar.ShieldGradientOverlay:SetTexCoord(1, 0, 0, 1)
		end
	end

	castbar.Shield:SetVertexColor(sc2.r, sc2.g, sc2.b, 1)
	castbar.ShieldGradientOverlay:SetVertexColor(sc1.r, sc1.g, sc1.b, 1)

	castbar.Shield.alphaValue = 1
	castbar.Shield:SetAlpha(0)
	castbar.ShieldGradientOverlay:SetAlpha(0)

	if not castbar.Shield.EltruismHooked then
		castbar.Shield.EltruismHooked = true
		hooksecurefunc(castbar.Shield, "SetAlphaFromBoolean", function(shield, val, aTrue, aFalse)
			local cb = shield:GetParent()
			if cb and cb.ShieldGradientOverlay then
				cb.ShieldGradientOverlay:SetAlphaFromBoolean(val, aTrue or 1, aFalse or 0)
			end
		end)
	end
end
ElvUI_EltreumUI:SecureHook(UF, "Configure_Castbar", "UF_Configure_Castbar")

