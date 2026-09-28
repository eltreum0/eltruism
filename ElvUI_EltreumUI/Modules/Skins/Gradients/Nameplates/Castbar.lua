local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitCanAttack = _G.UnitCanAttack

--elvui castbar texture/gradient
function ElvUI_EltreumUI:Castbar_CheckInterrupt(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if unit == 'vehicle' then
		unit = 'player'
	end
	local _, unitclass = UnitClass(unit)
	if not E:NotSecretValue(unitclass) then --secret class so do something else
		unitclass = E.myclass
	end
	local reactionUnit = UnitReaction(unit, "player")
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		local tex = self:GetStatusBarTexture()
		if tex then
			local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
			local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
			if self.notInterruptible and UnitCanAttack('player', unit) then
				local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.npcustomcolor and "noninterruptible_custom" or "noninterruptible_default")
				tex:SetGradient(orientation, c1, c2)
			elseif (not self.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt()) then
				if UnitIsPlayer(unit) or (E.Retail and UnitInPartyIsAI(unit)) then
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
	if self.EltruismNameplateBorder then
		local borderType = (self.notInterruptible and UnitCanAttack('player', unit)) and "nointerrupt" or (((not self.notInterruptible) and (not ElvUI_EltreumUI:CheckmMediaTagInterrupt())) and "interrupt" or nil)
		if borderType and self.EltruismNameplateBorder.EltruismCastBorderKey ~= borderType then
			self.EltruismNameplateBorder.EltruismCastBorderKey = borderType
			if borderType == "nointerrupt" then
				self.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castNoInterruptColor.r, E.db.nameplates.colors.castNoInterruptColor.g, E.db.nameplates.colors.castNoInterruptColor.b, 1)
			else
				self.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castColor.r, E.db.nameplates.colors.castColor.g, E.db.nameplates.colors.castColor.b, 1)
			end
		end
	end
end
if not E.Modern then
	hooksecurefunc(NP, "Castbar_CheckInterrupt", ElvUI_EltreumUI.Castbar_CheckInterrupt)
end

--interrupted
function ElvUI_EltreumUI:Castbar_PostCastFail()
	if self.EltruismNameplateBorder then
		self.EltruismNameplateBorder.EltruismCastBorderKey = "failed"
		self.EltruismNameplateBorder:SetBackdropBorderColor(E.db.nameplates.colors.castInterruptedColor.r, E.db.nameplates.colors.castInterruptedColor.g, E.db.nameplates.colors.castInterruptedColor.b, 1)
	end
end
if not E.Modern then
	hooksecurefunc(NP, "Castbar_PostCastFail", ElvUI_EltreumUI.Castbar_PostCastFail)
end
