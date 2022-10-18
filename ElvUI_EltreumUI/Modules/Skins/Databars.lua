local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local DB = E:GetModule('DataBars')
local S = E:GetModule('Skins')
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

--gradient digsite and custom font stuff
function ElvUI_EltreumUI:GradientArcheology()
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable and _G.ArcheologyDigsiteProgressBar then
		_G.ArcheologyDigsiteProgressBar.FillBar:GetStatusBarTexture():SetGradient("HORIZONTAL",E.db.ElvUI_EltreumUI.otherstuff.archeology.r1,E.db.ElvUI_EltreumUI.otherstuff.archeology.g1,E.db.ElvUI_EltreumUI.otherstuff.archeology.b1,E.db.ElvUI_EltreumUI.otherstuff.archeology.r2,E.db.ElvUI_EltreumUI.otherstuff.archeology.g2,E.db.ElvUI_EltreumUI.otherstuff.archeology.b2)
	end
	if _G.ArcheologyDigsiteProgressBar.BarTitle then
		_G.ArcheologyDigsiteProgressBar.BarTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontsize, E.db.general.fontStyle)
		local point, relativeTo, relativePoint, xOfs, yOfs = _G.ArcheologyDigsiteProgressBar.BarTitle:GetPoint()
		_G.ArcheologyDigsiteProgressBar.BarTitle:ClearAllPoints()
		_G.ArcheologyDigsiteProgressBar.BarTitle:SetPoint(point, relativeTo, relativePoint, xOfs+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsetx, yOfs+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsety)
	end
end
S:AddCallbackForAddon('Blizzard_ArchaeologyUI', "GradientArcheology", ElvUI_EltreumUI.GradientArcheology)
