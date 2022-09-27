local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local DB = E:GetModule('DataBars')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local databarXP, databarRep, databarHonor

--Databar gradient
function ElvUI_EltreumUI:GradientDatabar()
	--gradient xp
	databarXP = _G["ElvUI_ExperienceBar"]
	if databarXP and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP then
		databarXP:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.experience.r, E.db.databars.colors.experience.g, E.db.databars.colors.experience.b, E.db.databars.colors.experience.a, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b, E.db.databars.colors.experience.a)
	end

	--gradient rep
	databarRep = _G["ElvUI_ReputationBar"]
	if databarRep and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation then
		local customColors = DB.db.colors.useCustomFactionColors
		local _, reaction = GetWatchedFactionInfo()
		local alpha = not customColors and DB.db.colors.reputationAlpha
		local color = (customColors or reaction == 9) and DB.db.colors.factionColors[reaction] or _G.FACTION_BAR_COLORS[reaction] -- reaction 9 is Paragon
		if color then
			--databarRep:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", color.r, color.g, color.b, alpha or color.a or 1, color.r - 0.4, color.g - 0.1, color.b - 0.5, alpha or color.a or 1)
			databarRep:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", color.r, color.g, color.b, alpha or color.a or 1,
				color.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r, color.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g, color.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b, alpha or color.a or 1)
		end
	end

	--gradient honor
	databarHonor = _G["ElvUI_HonorBar"]
	if databarHonor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor then
		databarHonor:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.honor.r, E.db.databars.colors.honor.g, E.db.databars.colors.honor.b, E.db.databars.colors.honor.a, E.db.databars.colors.honor.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.r, E.db.databars.colors.honor.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.g, E.db.databars.colors.honor.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.b, E.db.databars.colors.honor.a)
	end
end
hooksecurefunc(DB, 'ExperienceBar_Update', ElvUI_EltreumUI.GradientDatabar)
hooksecurefunc(DB, 'ReputationBar_Update', ElvUI_EltreumUI.GradientDatabar)
if E.Retail then
	hooksecurefunc(DB, 'HonorBar_Update', ElvUI_EltreumUI.GradientDatabar)
end

--gradient tooltip health
local function SetTooltipGradient(unit)
	if not unit then return end
	if not E.private.tooltip.enable then return end
	local _, classunit = UnitClass(unit)
	local reaction = UnitReaction(unit, "player")
	local _, classunit = UnitClass(unit)
	local reaction = UnitReaction(unit, "player")
	if _G.GameTooltip:IsForbidden() then return end
	if UnitIsPlayer(unit) then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
			_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(classunit, false, false))
		else
			_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(classunit, false, false))
		end
	else
		if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
				_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("TAPPED", false, false))
			else
				_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("TAPPED", false, false))
			end
		else
			if reaction and reaction >= 5 then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", false, false))
				else
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", false, false))
				end
			elseif reaction and reaction == 4 then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", false, false))
				else
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", false, false))
				end
			elseif reaction and reaction == 3 then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", false, false))
				else
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", false, false))
				end
			elseif reaction and reaction <= 2 then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", false, false))
				else
					_G.GameTooltipStatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", false, false))
				end
			end
		end
	end
end

local TT = E:GetModule('Tooltip')
function ElvUI_EltreumUI:GradientTooltip(tt, unit)
	if tt and tt:IsForbidden() then return end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and E.private.tooltip.enable then
		local _, fixunit = _G.GameTooltip:GetUnit()
		SetTooltipGradient(fixunit)
		if not self.isHooked then
			_G.GameTooltipStatusBar:HookScript("OnShow", function()
				local _,unittp = _G.GameTooltip:GetUnit()
				if unittp then
					SetTooltipGradient(unittp)
				end
			end)
			self.isHooked = true
		end
	end
end
hooksecurefunc(TT, 'AddTargetInfo', ElvUI_EltreumUI.GradientTooltip)
hooksecurefunc(TT, 'GameTooltip_OnTooltipSetUnit', ElvUI_EltreumUI.GradientTooltip)
