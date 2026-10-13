local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local canaccessvalue = _G.canaccessvalue
local hooksecurefunc = _G.hooksecurefunc

--elvui castbar texture/gradient
function ElvUI_EltreumUI:Castbar_CheckInterrupt(castbar, unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not castbar or not castbar.GetStatusBarTexture then return end
	local unitActual = unit or castbar.unit or (castbar.__owner and castbar.__owner.unit)
	if unitActual == 'vehicle' then
		unitActual = 'player'
	end
	local _, unitclass
	if unitActual then
		_, unitclass = UnitClass(unitActual)
	end
	if not unitclass or not canaccessvalue(unitclass) then --secret class so do something else
		unitclass = E.myclass
	end
	local reactionUnit = unitActual and UnitReaction(unitActual, "player")
	local notInterruptible = canaccessvalue(castbar.notInterruptible) and castbar.notInterruptible

	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local tex = castbar:GetStatusBarTexture()
		if tex then
			local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
			local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			local isCustom = gm.npcustomcolor or gm.customcolor
			local isReverse = false
			if castbar.GetReverseFill then
				isReverse = castbar:GetReverseFill()
			end
			local nameplate = castbar.__owner
			if not isReverse and nameplate then
				local plateDB = NP.PlateDB and NP:PlateDB(nameplate)
				if plateDB and plateDB.castbar and plateDB.castbar.reverse then
					isReverse = true
				elseif nameplate.db and nameplate.db.castbar and nameplate.db.castbar.reverse then
					isReverse = true
				end
			end
			if not isReverse and castbar.reverse then
				isReverse = true
			end

			local c1, c2
			if notInterruptible then
				c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "noninterruptible_custom" or "noninterruptible_default", isReverse)
			else
				local isPlayer = unitActual and (UnitIsPlayer(unitActual) or (E.Retail and UnitInPartyIsAI(unitActual)))
				if isPlayer then
					if isCustom and not gm.classcolorcastbar then
						c1, c2 = ElvUI_EltreumUI:GetCastbarGradient("castbar_custom", isReverse)
					elseif gm.classcolorcastbar then
						c1, c2 = ElvUI_EltreumUI:GetHealthGradient(unitclass, isReverse, isCustom)
					else
						c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interruptible_custom" or "interruptible_default", isReverse)
					end
				else
					if gm.castbarreactioninterruptable then
						local reactionKey
						if ElvUI_EltreumUI.GetNameplateTargetType then
							reactionKey = ElvUI_EltreumUI:GetNameplateTargetType(castbar.__owner, unitActual)
						elseif reactionUnit then
							if reactionUnit >= 5 then
								reactionKey = "NPCFRIENDLY"
							elseif reactionUnit == 4 then
								reactionKey = "NPCNEUTRAL"
							elseif reactionUnit == 3 then
								reactionKey = "NPCUNFRIENDLY"
							elseif reactionUnit <= 2 then
								reactionKey = "NPCHOSTILE"
							end
						end
						if reactionKey then
							c1, c2 = ElvUI_EltreumUI:GetHealthGradient(reactionKey, isReverse, isCustom)
						else
							c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interruptible_custom" or "interruptible_default", isReverse)
						end
					else
						c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interruptible_custom" or "interruptible_default", isReverse)
					end
				end
			end
			if c1 and c2 then
				tex:SetGradient(orientation, c1, c2)
			end
		end
	end

	if castbar.EltruismNameplateBorder then
		local borderType = notInterruptible and "nointerrupt" or "interrupt"
		if castbar.EltruismNameplateBorder.EltruismCastBorderKey ~= borderType then
			castbar.EltruismNameplateBorder.EltruismCastBorderKey = borderType
			if borderType == "nointerrupt" then
				castbar.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castNoInterruptColor.r, E.db.nameplates.colors.castNoInterruptColor.g, E.db.nameplates.colors.castNoInterruptColor.b, 1)
			else
				castbar.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castColor.r, E.db.nameplates.colors.castColor.g, E.db.nameplates.colors.castColor.b, 1)
			end
		end
	end
end
ElvUI_EltreumUI:SecureHook(NP, "Castbar_CheckInterrupt", "Castbar_CheckInterrupt")

--interrupted
function ElvUI_EltreumUI:Castbar_PostCastFail(castbar)
	if not castbar or not castbar.GetStatusBarTexture then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local tex = castbar:GetStatusBarTexture()
		if tex then
			local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
			local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			local isCustom = gm.npcustomcolor or gm.customcolor
			local isReverse = false
			if castbar.GetReverseFill then
				isReverse = castbar:GetReverseFill()
			end
			local nameplate = castbar.__owner
			if not isReverse and nameplate then
				local plateDB = NP.PlateDB and NP:PlateDB(nameplate)
				if plateDB and plateDB.castbar and plateDB.castbar.reverse then
					isReverse = true
				elseif nameplate.db and nameplate.db.castbar and nameplate.db.castbar.reverse then
					isReverse = true
				end
			end
			if not isReverse and castbar.reverse then
				isReverse = true
			end
			local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "interrupted_custom" or "interrupted_default", isReverse)
			if c1 and c2 then
				tex:SetGradient(orientation, c1, c2)
			end
		end
	end
	if castbar.EltruismNameplateBorder then
		castbar.EltruismNameplateBorder.EltruismCastBorderKey = "failed"
		castbar.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castInterruptedColor.r, E.db.nameplates.colors.castInterruptedColor.g, E.db.nameplates.colors.castInterruptedColor.b, 1)
	end
end
ElvUI_EltreumUI:SecureHook(NP, "Castbar_PostCastFail", "Castbar_PostCastFail")
ElvUI_EltreumUI:SecureHook(NP, "Castbar_PostCastInterrupted", "Castbar_PostCastFail")

--try to also do it on np, but it seems to not always apply
function ElvUI_EltreumUI:NP_Update_Castbar(arg1, arg2)
	local nameplate = (arg1 and arg1.Castbar and arg1) or (arg2 and arg2.Castbar and arg2)
	if not nameplate or not nameplate.Castbar then return end
	local castbar = nameplate.Castbar
	if not (E.Modern and castbar.Shield) then return end
	local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	if not (gm and gm.npenable) then return end

	local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture
	if ufCustom and ufCustom.enable then
		castbar.Shield:SetTexture(E.LSM:Fetch("statusbar", ufCustom.castbartexture))
	elseif gm.useUFtexture then
		castbar.Shield:SetTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	else
		castbar.Shield:SetTexture(E.LSM:Fetch("statusbar", gm.texture))
	end

	local orientation = gm.nporientation or "VERTICAL"
	local isCustom = gm.npcustomcolor or gm.customcolor
	local sc1, sc2 = ElvUI_EltreumUI:GetCastbarGradient(isCustom and "noninterruptible_custom" or "noninterruptible_default")
	if not (sc1 and sc2) then return end

	local isReverse = false
	if castbar.GetReverseFill then
		isReverse = castbar:GetReverseFill()
	end
	if not isReverse and nameplate then
		local plateDB = NP.PlateDB and NP:PlateDB(nameplate)
		if plateDB and plateDB.castbar and plateDB.castbar.reverse then
			isReverse = true
		elseif nameplate.db and nameplate.db.castbar and nameplate.db.castbar.reverse then
			isReverse = true
		end
	end
	if not isReverse and castbar.reverse then
		isReverse = true
	end

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
ElvUI_EltreumUI:SecureHook(NP, "Update_Castbar", "NP_Update_Castbar")
