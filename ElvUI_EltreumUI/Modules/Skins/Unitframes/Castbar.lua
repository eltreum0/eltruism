local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local UnitInPartyIsAI = _G.UnitInPartyIsAI

--elvui castbar texture/gradient
function ElvUI_EltreumUI.CastBarTextureGradient(castbar, unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not E.private.unitframe.enable then return end
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then return end

	if not castbar or not castbar.GetStatusBarTexture then
		castbar = _G["ElvUF_Player_CastBar"]
		unit = "player"
	end
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
	elseif gm.useUFtexture then
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	else
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", gm.texture))
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
		local isCustom = gm.customcolor
		local notInterruptible = E:NotSecretValue(castbar.notInterruptible) and castbar.notInterruptible
		local c1, c2
		if notInterruptible then
			if gm.enablecastbarnoninterruptible then
				if castbar.Shield then castbar.Shield:SetAlpha(0) end
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
					c1, c2 = ElvUI_EltreumUI:GetHealthGradient(reactionKey, isReverse, isCustom and gm.classcolorcastbar)
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
hooksecurefunc(UF, 'Construct_Castbar', ElvUI_EltreumUI.CastBarTextureGradient)
hooksecurefunc(UF, 'PostCastStart', ElvUI_EltreumUI.CastBarTextureGradient)
hooksecurefunc(UF, 'PostCastInterruptible', ElvUI_EltreumUI.CastBarTextureGradient)

--color when interrupted/failed
function ElvUI_EltreumUI.CastBarTextureGradientFail(castbar)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if not castbar or not castbar.GetStatusBarTexture then return end

	local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
	if not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not gm.enable then return end

	if not gm.enablecastbarinterrupted then return end

	local ufCustom = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture

	if ufCustom.enable then
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", ufCustom.castbartexture))
	elseif gm.useUFtexture then
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
	else
		castbar:SetStatusBarTexture(E.LSM:Fetch("statusbar", gm.texture))
	end

	local tex = castbar:GetStatusBarTexture()
	if not tex then return end

	local parent = castbar.__owner or castbar:GetParent()
	local db = parent and parent.db and parent.db.castbar
	local isReverse = db and db.reverse

	local c1, c2 = ElvUI_EltreumUI:GetCastbarGradient(gm.customcolor and "interrupted_custom" or "interrupted_default", isReverse)
	if c1 and c2 then
		tex:SetGradient(gm.orientation or "HORIZONTAL", c1, c2)
	end
end
hooksecurefunc(UF, 'PostCastFail', ElvUI_EltreumUI.CastBarTextureGradientFail)

