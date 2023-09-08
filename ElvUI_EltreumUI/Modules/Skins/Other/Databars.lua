local E = unpack(ElvUI)
local DB = E:GetModule('DataBars')
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local classcolor = E:ClassColor(E.myclass, true)

--gradient xp
function ElvUI_EltreumUI:GradientDatabarXP()
	if _G["ElvUI_ExperienceBar"] and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP then
		_G["ElvUI_ExperienceBar"]:GetStatusBarTexture():SetGradient("HORIZONTAL", { r = E.db.databars.colors.experience.r, g = E.db.databars.colors.experience.g, b = E.db.databars.colors.experience.b, a = E.db.databars.colors.experience.a}, { r = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.r, g = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.g, b = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors.b, a = E.db.databars.colors.experience.a})
	end
end
hooksecurefunc(DB, 'ExperienceBar_Update', ElvUI_EltreumUI.GradientDatabarXP)

--gradient rep
function ElvUI_EltreumUI:GradientDatabarRep()
	if _G["ElvUI_ReputationBar"] and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation then
		if not DB.db then return end
		if not DB.db.colors then return end

		local customColors = DB.db.colors.useCustomFactionColors
		local _, reaction, factionID
		if E.Retail then
			 _, reaction, _, _, _, factionID = GetWatchedFactionInfo()
			if factionID then
				local info = factionID and C_GossipInfo.GetFriendshipReputation(factionID)
				if info and info.friendshipFactionID then
					local isMajorFaction = factionID and C_Reputation.IsMajorFaction(factionID)
					if isMajorFaction then
						reaction = 10
					end
				end
			end
		else
			_, reaction = GetWatchedFactionInfo()
		end
		if reaction then
			local customReaction = reaction == 9 or reaction == 10 -- 9 is paragon, 10 is renown
			local color = ((customColors or customReaction) and DB.db.colors.factionColors[reaction]) or _G.FACTION_BAR_COLORS[reaction]
			if color then
				local alpha = (customColors and color.a) or DB.db.colors.reputationAlpha or 1
				--databarRep:GetStatusBarTexture():SetGradientAlpha("HORIZONTAL", color.r, color.g, color.b, alpha or color.a or 1, color.r - 0.4, color.g - 0.1, color.b - 0.5, alpha or color.a or 1)
				if reaction == 10 then
					_G["ElvUI_ReputationBar"]:GetStatusBarTexture():SetGradient("HORIZONTAL", { r = color.r, g = color.g, b = color.b, a = alpha or color.a or 1}, {r =color.r - E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r,g= color.g - E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g,b= color.b - E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b,a= alpha or color.a or 1})
				else
					_G["ElvUI_ReputationBar"]:GetStatusBarTexture():SetGradient("HORIZONTAL", { r = color.r, g = color.g, b = color.b, a = alpha or color.a or 1}, {r =color.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.r,g= color.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.g,b= color.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors.b,a= alpha or color.a or 1})
				end
			end
		end
	end
end
hooksecurefunc(DB, 'ReputationBar_Update', ElvUI_EltreumUI.GradientDatabarRep)

--gradient honor
function ElvUI_EltreumUI:GradientDatabarHonor()
	if _G["ElvUI_HonorBar"] and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor then
		_G["ElvUI_HonorBar"]:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=E.db.databars.colors.honor.r,g= E.db.databars.colors.honor.g,b= E.db.databars.colors.honor.b,a= E.db.databars.colors.honor.a}, {r=E.db.databars.colors.honor.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.r,g=E.db.databars.colors.honor.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.g,b= E.db.databars.colors.honor.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors.b,a= E.db.databars.colors.honor.a})
	end
end
if E.Retail then
	hooksecurefunc(DB, 'HonorBar_Update', ElvUI_EltreumUI.GradientDatabarHonor)
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

			--in 10.1.7 this doesnt seem to actually clear and move the text
			local point, relativeTo, relativePoint, xOfs, yOfs = _G.ArcheologyDigsiteProgressBar.BarTitle:GetPoint()
			_G.ArcheologyDigsiteProgressBar.BarTitle:ClearAllPoints()
			_G.ArcheologyDigsiteProgressBar.BarTitle:SetPoint(point, relativeTo, relativePoint, xOfs+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsetx, yOfs+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsety)
		end
		if _G.ArcheologyDigsiteProgressBar.FillBar then
			_G.ArcheologyDigsiteProgressBar.FillBar:SetSize(E.db.ElvUI_EltreumUI.otherstuff.archeology.sizex,E.db.ElvUI_EltreumUI.otherstuff.archeology.sizey)
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				_G.ArcheologyDigsiteProgressBar.FillBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=E.db.ElvUI_EltreumUI.otherstuff.archeology.r1,g=E.db.ElvUI_EltreumUI.otherstuff.archeology.g1,b=E.db.ElvUI_EltreumUI.otherstuff.archeology.b1,a= 1}, {r=E.db.ElvUI_EltreumUI.otherstuff.archeology.r2,g=E.db.ElvUI_EltreumUI.otherstuff.archeology.g2,b=E.db.ElvUI_EltreumUI.otherstuff.archeology.b2,a= 1})
			end
		end
	end
end
S:AddCallbackForAddon('Blizzard_ArchaeologyUI', "GradientArcheology", ElvUI_EltreumUI.GradientArcheology)

--gradient Blizzard Alt Power
local B = E:GetModule('Blizzard')
function ElvUI_EltreumUI:BlizzardAltPower()
	if B.AltPowerBar and B.AltPowerBar:IsShown() then
		B.AltPowerBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.unitframe.statusbar))
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPower then
			if E.db.general.altPowerBar.statusBarColorGradient then
				local power, maxPower = B.AltPowerBar.powerValue or 0, B.AltPowerBar.powerMaxValue or 0
				local value = (maxPower > 0 and power / maxPower) or 0
				local r, g, b = E:ColorGradient(value,0.8,0,0, 0.8,0.8,0, 0,0.8,0)
				B.AltPowerBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r,g= g,b= b,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors.r,g=g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors.g,b= b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors.b,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
			else
				local color = E.db.general.altPowerBar.statusBarColor
				B.AltPowerBar:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=color.r,g= color.g,b= color.b,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha}, {r=color.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors.r,g=color.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors.g,b= color.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors.b,a= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha})
			end
		end
	end
end

if E.Retail then
	hooksecurefunc(B, 'UpdateAltPowerBarColors', ElvUI_EltreumUI.BlizzardAltPower)
	hooksecurefunc(B, 'UpdateAltPowerBar', ElvUI_EltreumUI.BlizzardAltPower)
end

--add class color bar on the bottom
local bottomclassbar = CreateFrame("FRAME")
function ElvUI_EltreumUI:BottomDatabarTexture()
	if E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar and not bottomclassbar.texture then
		local width = ceil(E.screenWidth)
		bottomclassbar:SetSize(width,16)
		bottomclassbar:SetPoint("BOTTOM", UIParent)
		bottomclassbar.texture = bottomclassbar:CreateTexture(nil,"BACKGROUND")
		bottomclassbar:SetFrameStrata("BACKGROUND")
		bottomclassbar:SetFrameLevel(1)
		bottomclassbar.texture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade2.tga")
		bottomclassbar.texture:SetSize(width,23)
		bottomclassbar.texture:SetPoint("BOTTOM", UIParent)
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				bottomclassbar.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
			else
				bottomclassbar.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors(E.myclass, false, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
			end
		else
			bottomclassbar.texture:SetVertexColor(classcolor.r, classcolor.g, classcolor.b, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha)
		end
	end

	if bottomclassbar.texture then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				bottomclassbar.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
			else
				bottomclassbar.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors(E.myclass, false, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
			end
		else
			bottomclassbar.texture:SetVertexColor(classcolor.r, classcolor.g, classcolor.b, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha)
		end

		if not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar then
			bottomclassbar:Hide()
		else
			bottomclassbar:Show()
		end
	end
end
