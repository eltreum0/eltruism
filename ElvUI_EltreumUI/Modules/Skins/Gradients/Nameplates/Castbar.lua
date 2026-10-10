local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitCanAttack = _G.UnitCanAttack
local issecretvalue = _G.issecretvalue

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
	if not unitclass or issecretvalue(unitclass) then --secret class so do something else
		unitclass = E.myclass
	end
	local reactionUnit = unitActual and UnitReaction(unitActual, "player")
	local notInterruptible = E:NotSecretValue(castbar.notInterruptible) and castbar.notInterruptible
	local canAttack = unitActual and UnitCanAttack('player', unitActual)

	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local tex = castbar:GetStatusBarTexture()
		if tex then
			local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
			local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			if notInterruptible and canAttack then
				local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "noninterruptible_custom" or "noninterruptible_default")
				tex:SetGradient(orientation, c1, c2)
			else
				local isPlayer = unitActual and (UnitIsPlayer(unitActual) or (E.Retail and UnitInPartyIsAI(unitActual)))
				if isPlayer then
					if gm.npcustomcolor and not gm.classcolorcastbar then
						local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient("castbar_custom")
						tex:SetGradient(orientation, c1, c2)
					elseif gm.classcolorcastbar then
						local c1, c2 = ElvUI_EltreumUI:GetHealthGradient(unitclass, false, gm.npcustomcolor)
						tex:SetGradient(orientation, c1, c2)
					else
						local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "interruptible_custom" or "interruptible_default")
						tex:SetGradient(orientation, c1, c2)
					end
				else
					if gm.npcustomcolor and not gm.classcolorcastbar then
						local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient("interruptible_custom")
						tex:SetGradient(orientation, c1, c2)
					else
						if gm.castbarreactioninterruptable then
							local reactionKey
							if reactionUnit then
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
								local c1, c2 = ElvUI_EltreumUI:GetHealthGradient(reactionKey, false, gm.npcustomcolor and gm.classcolorcastbar)
								tex:SetGradient(orientation, c1, c2)
							else
								local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "interruptible_custom" or "interruptible_default")
								tex:SetGradient(orientation, c1, c2)
							end
						else
							local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "interruptible_custom" or "interruptible_default")
							tex:SetGradient(orientation, c1, c2)
						end
					end
				end
			end
		end
	end
	if castbar.EltruismNameplateBorder then
		local borderType = (notInterruptible and canAttack) and "nointerrupt" or "interrupt"
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
			local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "interrupted_custom" or "interrupted_default")
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
