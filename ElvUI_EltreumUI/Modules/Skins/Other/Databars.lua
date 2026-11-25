local E = unpack(ElvUI)
local DB = E:GetModule('DataBars')
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateColor = _G.CreateColor
local databarMin = CreateColor(1, 1, 1, 1)
local databarMax = CreateColor(1, 1, 1, 1)
local classcolor = E.myClassColor
local GetWatchedFactionInfo = _G.C_Reputation and _G.C_Reputation.GetWatchedFactionInfo or _G.GetWatchedFactionInfo

--gradient xp
function ElvUI_EltreumUI:GradientDatabarXP()
	if _G["ElvUI_ExperienceBar"] and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP then
		local xpColor = E.db.databars.colors.experience
		local xpGrad = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPcolors
		databarMin:SetRGBA(xpColor.r, xpColor.g, xpColor.b, xpColor.a)
		databarMax:SetRGBA(xpGrad.r, xpGrad.g, xpGrad.b, xpColor.a)
		_G["ElvUI_ExperienceBar"]:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXPdirection, databarMin, databarMax)
	end
end
ElvUI_EltreumUI:SecureHook(DB, 'ExperienceBar_Update', 'GradientDatabarXP')

--gradient rep
function ElvUI_EltreumUI:GradientDatabarRep()
	if _G["ElvUI_ReputationBar"] and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.unitframes and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors then
		if not DB.db then return end
		if not DB.db.colors then return end

		local customColors = DB.db.colors.useCustomFactionColors
		local _, reaction, factionID
		if _G.C_Reputation and _G.C_Reputation.GetWatchedFactionData then
			local watchedFactionData = _G.C_Reputation.GetWatchedFactionData()
			if not watchedFactionData then return end
			reaction, factionID = watchedFactionData.reaction, watchedFactionData.factionID
			if factionID then
				local info = factionID and _G.C_GossipInfo.GetFriendshipReputation(factionID)
				if info and info.friendshipFactionID then
					local isMajorFaction = factionID and _G.C_Reputation.IsMajorFaction(factionID)
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
				local repGrad = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputationcolors
				local a = alpha or color.a or 1
				databarMin:SetRGBA(color.r, color.g, color.b, a)
				if reaction == 10 then
					databarMax:SetRGBA(E:Clamp(color.r - repGrad.r, 0, 1), E:Clamp(color.g - repGrad.g, 0, 1), E:Clamp(color.b - repGrad.b, 0, 1), a)
				else
					databarMax:SetRGBA(E:Clamp(color.r + repGrad.r, 0, 1), E:Clamp(color.g + repGrad.g, 0, 1), E:Clamp(color.b + repGrad.b, 0, 1), a)
				end
				_G["ElvUI_ReputationBar"]:GetStatusBarTexture():SetGradient("HORIZONTAL", databarMin, databarMax)
			end
		end
	end
end
ElvUI_EltreumUI:SecureHook(DB, 'ReputationBar_Update', 'GradientDatabarRep')

--gradient honor
function ElvUI_EltreumUI:GradientDatabarHonor()
	if _G["ElvUI_HonorBar"] and E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor then
		local honorColor = E.db.databars.colors.honor
		local honorGrad = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonorcolors
		databarMin:SetRGBA(honorColor.r, honorColor.g, honorColor.b, honorColor.a)
		databarMax:SetRGBA(E:Clamp(honorColor.r + honorGrad.r, 0, 1), E:Clamp(honorColor.g + honorGrad.g, 0, 1), E:Clamp(honorColor.b + honorGrad.b, 0, 1), honorColor.a)
		_G["ElvUI_HonorBar"]:GetStatusBarTexture():SetGradient("HORIZONTAL", databarMin, databarMax)
	end
end
if E.Retail then
	ElvUI_EltreumUI:SecureHook(DB, 'HonorBar_Update', 'GradientDatabarHonor')
end

--gradient digsite and custom font stuff
function ElvUI_EltreumUI:GradientArcheology()
	if _G.ArcheologyDigsiteProgressBar then
		if _G.ArcheologyDigsiteProgressBar.BarTitle then
			_G.ArcheologyDigsiteProgressBar.BarTitle:Hide()
			_G.ArcheologyDigsiteProgressBar.BarTitle:SetAlpha(0)
			_G.ArcheologyDigsiteProgressBar.EltruismBarTitle = _G.ArcheologyDigsiteProgressBar:CreateFontString(nil, "ARTWORK")
			_G.ArcheologyDigsiteProgressBar.EltruismBarTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			_G.ArcheologyDigsiteProgressBar.EltruismBarTitle:SetPoint("TOP", _G["EltruismArcheology"], "TOP", 0+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsetx, 0+E.db.ElvUI_EltreumUI.otherstuff.archeology.archeologyfontoffsety)
			_G.ArcheologyDigsiteProgressBar.EltruismBarTitle:SetText(_G.ArcheologyDigsiteProgressBar.BarTitle:GetText())
			hooksecurefunc(_G.ArcheologyDigsiteProgressBar.BarTitle,"SetText", function(_,text)
				_G.ArcheologyDigsiteProgressBar.EltruismBarTitle:SetText(text)
			end)
		end
		if _G.ArcheologyDigsiteProgressBar.FillBar then
			_G.ArcheologyDigsiteProgressBar.FillBar:SetSize(E.db.ElvUI_EltreumUI.otherstuff.archeology.sizex,E.db.ElvUI_EltreumUI.otherstuff.archeology.sizey)
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				local arch = E.db.ElvUI_EltreumUI.otherstuff.archeology
				databarMin:SetRGBA(arch.r1, arch.g1, arch.b1, 1)
				databarMax:SetRGBA(arch.r2, arch.g2, arch.b2, 1)
				_G.ArcheologyDigsiteProgressBar.FillBar:GetStatusBarTexture():SetGradient("HORIZONTAL", databarMin, databarMax)
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
			local altAlpha = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha
			local altGrad = E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPowercolors
			if E.db.general.altPowerBar.statusBarColorGradient then
				local power, maxPower = B.AltPowerBar.powerValue or 0, B.AltPowerBar.powerMaxValue or 0
				if not ElvUI_EltreumUI:IsThisASafeSecret(power,true) then return end
				local value = (maxPower > 0 and power / maxPower) or 0
				local r, g, b = E:ColorGradient(value,0.8,0,0, 0.8,0.8,0, 0,0.8,0)
				databarMin:SetRGBA(r, g, b, altAlpha)
				databarMax:SetRGBA(E:Clamp(r + altGrad.r, 0, 1), E:Clamp(g + altGrad.g, 0, 1), E:Clamp(b + altGrad.b, 0, 1), altAlpha)
				B.AltPowerBar:GetStatusBarTexture():SetGradient("HORIZONTAL", databarMin, databarMax)
			else
				local color = E.db.general.altPowerBar.statusBarColor
				databarMin:SetRGBA(color.r, color.g, color.b, altAlpha)
				databarMax:SetRGBA(E:Clamp(color.r + altGrad.r, 0, 1), E:Clamp(color.g + altGrad.g, 0, 1), E:Clamp(color.b + altGrad.b, 0, 1), altAlpha)
				B.AltPowerBar:GetStatusBarTexture():SetGradient("HORIZONTAL", databarMin, databarMax)
			end
		end
	end
end

if E.Retail then
	ElvUI_EltreumUI:SecureHook(B, 'UpdateAltPowerBarColors', 'BlizzardAltPower')
	ElvUI_EltreumUI:SecureHook(B, 'UpdateAltPowerBar', 'BlizzardAltPower')
end

--add class color bar on the bottom
local EltruismDataTextTexture = _G.CreateFrame("FRAME")
function ElvUI_EltreumUI:BottomDatabarTexture()
	local gradtop = false
	local relativePoint = "BOTTOM"
	local _
	if _G["DTPanelEltruismDataTextMover"] then
		_, _, relativePoint = _G["DTPanelEltruismDataTextMover"]:GetPoint()
	end

	if E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar and not EltruismDataTextTexture.texture then
		local width = _G.ceil(E.screenWidth)
		EltruismDataTextTexture:SetSize(width,16)
		EltruismDataTextTexture.texture = EltruismDataTextTexture:CreateTexture(nil,"BACKGROUND")
		if _G["DTPanelEltruismDataTextMover"] and _G["DTPanelEltruismDataTextMover"].parent then
			EltruismDataTextTexture:SetParent(_G["DTPanelEltruismDataTextMover"].parent)
			EltruismDataTextTexture.texture:SetParent(EltruismDataTextTexture)
		end
		EltruismDataTextTexture:SetFrameStrata("BACKGROUND")
		EltruismDataTextTexture:SetFrameLevel(1)
		EltruismDataTextTexture.texture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade2.tga")
		EltruismDataTextTexture.texture:SetSize(width,23)
		EltruismDataTextTexture.texture:SetPoint("BOTTOM", EltruismDataTextTexture)
		if _G["DTPanelEltruismDataTextMover"] then
			EltruismDataTextTexture:SetPoint("BOTTOM", _G["DTPanelEltruismDataTextMover"],"BOTTOM",0,0)
			if relativePoint:match("TOP") then
				gradtop = true
				EltruismDataTextTexture.texture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade3.tga")
			end
		else
			EltruismDataTextTexture:SetPoint("BOTTOM", E.UIParent)
		end
		if E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.custom then
			EltruismDataTextTexture.texture:SetVertexColor(E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.r, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.g, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.b, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha)
		else
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					EltruismDataTextTexture.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom(E.myclass, gradtop, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
				else
					EltruismDataTextTexture.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors(E.myclass, gradtop, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
				end
			else
				EltruismDataTextTexture.texture:SetVertexColor(classcolor.r, classcolor.g, classcolor.b, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha)
			end
		end
	end

	if EltruismDataTextTexture.texture then
		if relativePoint:match("TOP") then
			gradtop = true
			EltruismDataTextTexture.texture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade3.tga")
		elseif relativePoint:match("BOTTOM") then
			gradtop = false
			EltruismDataTextTexture.texture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Statusbar\\EltreumFade2.tga")
		end
		if E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.custom then
			EltruismDataTextTexture.texture:SetVertexColor(E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.r, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.g, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.b, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha)
		else
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then
				if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
					EltruismDataTextTexture.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColorsCustom(E.myclass, gradtop, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
				else
					EltruismDataTextTexture.texture:SetGradient("VERTICAL", ElvUI_EltreumUI:GradientColors(E.myclass, gradtop, true, false, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha))
				end
			else
				EltruismDataTextTexture.texture:SetVertexColor(classcolor.r, classcolor.g, classcolor.b, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha)
			end
		end

		if not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar then
			EltruismDataTextTexture:Hide()
		else
			EltruismDataTextTexture:Show()
		end
	end
end
