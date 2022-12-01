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
		if E.Retail then
			databarXP:GetStatusBarTexture():SetGradient("HORIZONTAL", { r = E.db.databars.colors.experience.r, g = E.db.databars.colors.experience.g, b = E.db.databars.colors.experience.b, a = E.db.databars.colors.experience.a}, { r = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, g = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, b = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b, a = E.db.databars.colors.experience.a})
		else
			databarXP:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.experience.r, E.db.databars.colors.experience.g, E.db.databars.colors.experience.b, E.db.databars.colors.experience.a, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b, E.db.databars.colors.experience.a)
		end
	end

	--gradient rep
	databarRep = _G["ElvUI_ReputationBar"]
	if databarRep and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation then
		local customColors = DB.db.colors.useCustomFactionColors
		local _, reaction, factionID
		if E.Retail then
			 _, reaction, _, _, _, factionID = GetWatchedFactionInfo()
			if factionID then
				local info = factionID and C_GossipInfo.GetFriendshipReputation(factionID)
				if info and info.friendshipFactionID then
					local isMajorFaction = factionID and C_Reputation.IsMajorFaction(factionID)
					if isMajorFaction then
						local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)
						local renownColor = DB.db.colors.factionColors[10]
						local renownHex = E:RGBToHex(renownColor.r, renownColor.g, renownColor.b)
						reaction = 10
					end
				end
			end
		else
			_, reaction = GetWatchedFactionInfo()
		end
		local customReaction = reaction == 9 or reaction == 10 -- 9 is paragon, 10 is renown
		local color = (customColors or customReaction) and DB.db.colors.factionColors[reaction] or _G.FACTION_BAR_COLORS[reaction]
		local alpha = (customColors and color.a) or DB.db.colors.reputationAlpha
		if color then
			--databarRep:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", color.r, color.g, color.b, alpha or color.a or 1, color.r - 0.4, color.g - 0.1, color.b - 0.5, alpha or color.a or 1)
			if E.Retail then
				if reaction == 10 then
					databarRep:GetStatusBarTexture():SetGradient("HORIZONTAL", { r = color.r, g = color.g, b = color.b, a = alpha or color.a or 1}, {r =color.r - E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r,g= color.g - E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g,b= color.b - E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b,a= alpha or color.a or 1})
				else
					databarRep:GetStatusBarTexture():SetGradient("HORIZONTAL", { r = color.r, g = color.g, b = color.b, a = alpha or color.a or 1}, {r =color.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r,g= color.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g,b= color.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b,a= alpha or color.a or 1})
				end
			else
				databarRep:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", color.r, color.g, color.b, alpha or color.a or 1, color.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r, color.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g, color.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b, alpha or color.a or 1)
			end
		end
	end

	--gradient honor
	databarHonor = _G["ElvUI_HonorBar"]
	if databarHonor and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor then
		if E.Retail then
			databarHonor:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=E.db.databars.colors.honor.r,g= E.db.databars.colors.honor.g,b= E.db.databars.colors.honor.b,a= E.db.databars.colors.honor.a}, {r=E.db.databars.colors.honor.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.r,g=E.db.databars.colors.honor.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.g,b= E.db.databars.colors.honor.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.b,a= E.db.databars.colors.honor.a})
		else
			databarHonor:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", E.db.databars.colors.honor.r, E.db.databars.colors.honor.g, E.db.databars.colors.honor.b, E.db.databars.colors.honor.a, E.db.databars.colors.honor.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.r, E.db.databars.colors.honor.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.g, E.db.databars.colors.honor.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.b, E.db.databars.colors.honor.a)
		end
	end
end
hooksecurefunc(DB, 'ExperienceBar_Update', ElvUI_EltreumUI.GradientDatabar)
hooksecurefunc(DB, 'ReputationBar_Update', ElvUI_EltreumUI.GradientDatabar)
if E.Retail then
	hooksecurefunc(DB, 'HonorBar_Update', ElvUI_EltreumUI.GradientDatabar)
end

--gradient digsite and custom font stuff
function ElvUI_EltreumUI:GradientArcheology()
	if _G.ArcheologyDigsiteProgressBar then

		_G.ArcheologyDigsiteProgressBar:HookScript("OnShow", function()
			if not InCombatLockdown() then
				_G.ArcheologyDigsiteProgressBar:ClearAllPoints()
				_G.ArcheologyDigsiteProgressBar:SetPoint("CENTER", _G["EltruismArcheology"], "CENTER", 0, 0)
			end
		end)

		if _G.ArcheologyDigsiteProgressBar.BarTitle then
			_G.ArcheologyDigsiteProgressBar.BarTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontsize, E.db.general.fontStyle)
			local point, relativeTo, relativePoint, xOfs, yOfs = _G.ArcheologyDigsiteProgressBar.BarTitle:GetPoint()
			_G.ArcheologyDigsiteProgressBar.BarTitle:ClearAllPoints()
			_G.ArcheologyDigsiteProgressBar.BarTitle:SetPoint(point, relativeTo, relativePoint, xOfs+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsetx, yOfs+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsety)
		end
		if _G.ArcheologyDigsiteProgressBar.FillBar then
			_G.ArcheologyDigsiteProgressBar.FillBar:SetSize(E.db.ElvUI_EltreumUI.otherstuff.archeology.sizex,E.db.ElvUI_EltreumUI.otherstuff.archeology.sizey)
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if E.Retail then
					_G.ArcheologyDigsiteProgressBar.FillBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=E.db.ElvUI_EltreumUI.otherstuff.archeology.r1,g=E.db.ElvUI_EltreumUI.otherstuff.archeology.g1,b=E.db.ElvUI_EltreumUI.otherstuff.archeology.b1,a= 1}, {r=E.db.ElvUI_EltreumUI.otherstuff.archeology.r2,g=E.db.ElvUI_EltreumUI.otherstuff.archeology.g2,b=E.db.ElvUI_EltreumUI.otherstuff.archeology.b2,a= 1})
				else
					_G.ArcheologyDigsiteProgressBar.FillBar:GetStatusBarTexture():SetGradient("HORIZONTAL", E.db.ElvUI_EltreumUI.otherstuff.archeology.r1,E.db.ElvUI_EltreumUI.otherstuff.archeology.g1,E.db.ElvUI_EltreumUI.otherstuff.archeology.b1, E.db.ElvUI_EltreumUI.otherstuff.archeology.r2,E.db.ElvUI_EltreumUI.otherstuff.archeology.g2,E.db.ElvUI_EltreumUI.otherstuff.archeology.b2)
				end
			end
		end
	end
end
S:AddCallbackForAddon('Blizzard_ArchaeologyUI', "GradientArcheology", ElvUI_EltreumUI.GradientArcheology)
