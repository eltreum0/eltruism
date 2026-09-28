local E = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateColor = _G.CreateColor

local function clamp(val)
	if val < 0 then
		return 0
	elseif val > 1 then
		return 1
	end
	return val
end
local npPowerMin = CreateColor(1, 1, 1, 1)
local npPowerMax = CreateColor(1, 1, 1, 1)

--power gradient/combo/runes
function ElvUI_EltreumUI:NPClassPower_SetBarColor(bar, r, g, b)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower then
			if bar.classPowerID or bar.token then --use somechecking for classpower and power bars
				local tex = bar:GetStatusBarTexture()
				if tex then
					local orientation = E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL"
					npPowerMin:SetRGBA(clamp(r - 0.3), clamp(g - 0.3), clamp(b - 0.3), 1)
					npPowerMax:SetRGBA(clamp(r), clamp(g), clamp(b), 1)
					tex:SetGradient(orientation, npPowerMin, npPowerMax)
				end
			else
				local parent = bar:GetParent()
				ElvUI_EltreumUI.GradientNameplates(parent or bar)
			end
			--bar.bg:SetAlpha(0)
		else
			local parent = bar:GetParent()
			ElvUI_EltreumUI.GradientNameplates(parent or bar)
		end
	end
end
hooksecurefunc(NP, "SetStatusBarColor", ElvUI_EltreumUI.NPClassPower_SetBarColor)
--will need to likely hook ClassPower_UpdateColor AND Power_UpdateColor

--style filters were removed
--[[
--to fix stylefilter for gradient nameplates
function ElvUI_EltreumUI:StyleFilterClearChanges(frame)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	-- bar stuff
	local h = frame.Health
	if h.r and h.g and h.b then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			ElvUI_EltreumUI.GradientNameplates(frame)
		end
	end
end
hooksecurefunc(NP, "StyleFilterClearChanges", ElvUI_EltreumUI.StyleFilterClearChanges)

--to set slight gradient to style filter
function ElvUI_EltreumUI:StyleFilterSetChanges(frame)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		if frame.StyleFilterChanges.health and frame.StyleFilterChanges.health.colors then
			local hc = frame.StyleFilterChanges.health.color
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				frame.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL", {r=hc.r,g= hc.g,b= hc.b,a= hc.a or 1}, {r=hc.r + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterr,g= hc.g + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterg,b= hc.b + E.db.ElvUI_EltreumUI.unitframes.gradientmode.stylefilterb,a= hc.a or 1})
			else
				frame.Health:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.nporientation or "VERTICAL", {r=hc.r,g= hc.g,b= hc.b,a= hc.a or 1}, {r=hc.r-0.4,g= hc.g-0.4,b= hc.b-0.4,a= hc.a or 1})
			end
		end
	end
end
hooksecurefunc(NP, "StyleFilterSetChanges", ElvUI_EltreumUI.StyleFilterSetChanges)
]]
