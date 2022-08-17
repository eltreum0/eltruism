local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer

local playereffect = CreateFrame("playermodel", "EltruismPlayerEffect")
local targeteffect = CreateFrame("playermodel", "EltruismTargetEffect")
local playerbar,targetbar

---add effects to player/target UF
function ElvUI_EltreumUI:UFEffects()
	playerbar = _G["ElvUF_Player_HealthBar"]
	targetbar = _G["ElvUF_Target_HealthBar"]

	if E.private.unitframe.enable then
		--playereffect:SetModel("spells/christmassnowrain.m2")
		playereffect:SetModel("environments/stars/shadowmoonskybox.m2")
		--playereffect:SetPosition(0, -0.85, 1.65)
		--playereffect:SetFacing(rad(180))
		playereffect:SetAlpha(1)
		playereffect:SetAllPoints(playerbar.backdrop)
		playereffect:SetFrameLevel(playerbar.backdrop:GetFrameLevel())
		playereffect:SetInside(playerbar.backdrop, 0, 0)
		playereffect:SetParent(playerbar)

		if UnitExists("target") then
			--targeteffect:SetModel("spells/fel_rainoffire_missile.m2")
			--targeteffect:SetModel("environments/stars/hellfireskybox.m2")
			--targeteffect:SetModel("environments/stars/shadowmoonskybox.m2")
			--targeteffect:SetModel("environments/stars/nagrandskybox.m2")
			targeteffect:SetModel("environments/stars/netherstormskybox.m2")
			--targeteffect:SetPosition(0, -0.85, 1.65)
			--targeteffect:SetFacing(rad(180)) --for shadowmoon
			targeteffect:SetAlpha(1)
			targeteffect:ClearAllPoints()
			targeteffect:SetAllPoints(targetbar.backdrop)
			targeteffect:SetFrameLevel(targetbar.backdrop:GetFrameLevel())
			targeteffect:SetInside(targetbar.backdrop, 0, 0)
			targeteffect:SetParent(targetbar)
		end
	end
end
