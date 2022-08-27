local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local DB = E:GetModule('DataBars')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local databarXP, databarRep, databarHonor





--Databar gradient
function ElvUI_EltreumUI:GradientDatabar()
	databarXP = _G["ElvUI_ExperienceBar"]
	if databarXP and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP then
		databarXP:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.experience.r, E.db.databars.colors.experience.g, E.db.databars.colors.experience.b, E.db.databars.colors.experience.a, 0.8, 0.4, 1, E.db.databars.colors.experience.a)
	end


	databarRep = _G["ElvUI_ReputationBar"]
	if databarRep and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation then
		local customColors = DB.db.colors.useCustomFactionColors
		local name, reaction, minValue, maxValue, curValue, factionID = GetWatchedFactionInfo()
		local alpha = not customColors and DB.db.colors.reputationAlpha

		local color = (customColors or reaction == 9) and DB.db.colors.factionColors[reaction] or _G.FACTION_BAR_COLORS[reaction] -- reaction 9 is Paragon
		local r,g,b = databarRep:GetStatusBarColor()

		if color then
			databarRep:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", color.r, color.g, color.b, alpha or color.a or 1, 0.8, 0.4, 1, alpha or color.a or 1)
		end
	end

	databarHonor = _G["ElvUI_HonorBar"]
	if databarHonor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor then
		databarHonor:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.honor.r, E.db.databars.colors.honor.g, E.db.databars.colors.honor.b, E.db.databars.colors.honor.a, 0.8, 0.4, 1, E.db.databars.colors.honor.a)
	end


end

hooksecurefunc(DB, 'ExperienceBar_Update', ElvUI_EltreumUI.GradientDatabar)
hooksecurefunc(DB, 'ReputationBar_Update', ElvUI_EltreumUI.GradientDatabar)
hooksecurefunc(DB, 'HonorBar_Update', ElvUI_EltreumUI.GradientDatabar)
