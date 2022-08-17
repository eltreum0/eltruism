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
	playerbar = _G["ElvUF_Player"]
	targetbar = _G["ElvUF_Target"]

	if E.private.unitframe.enable then
		--playereffect:SetModel("spells/christmassnowrain.m2")
		playereffect:SetModel("environments/stars/hellfireskybox.m2")
		--playereffect:SetModel("environments/stars/shadowmoonskybox.m2")
		--playereffect:SetPosition(0, -0.85, 1.65)
		--playereffect:SetFacing(rad(180))
		playereffect:SetDesaturation(1)

		--targeteffect:SetModel("spells/fel_rainoffire_missile.m2")
		targeteffect:SetModel("environments/stars/hellfireskybox.m2")
		--targeteffect:SetModel("environments/stars/shadowmoonskybox.m2")
		--targeteffect:SetModel("environments/stars/nagrandskybox.m2")
		--targeteffect:SetModel("environments/stars/shadowmoonskybox.m2")
		--targeteffect:SetModel("environments/stars/netherstormskybox.m2")
		--targeteffect:SetPosition(0, -0.85, 1.65)
		--targeteffect:SetFacing(rad(180)) --for shadowmoon
		targeteffect:SetDesaturation(1)
		--targeteffect:ClearAllPoints()


		if E.db.ElvUI_EltreumUI.lightmode then
			playereffect:SetAllPoints(playerbar.Health:GetStatusBarTexture())
			playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel())
			playereffect:SetInside(playerbar.Health, 0, 0)
			playereffect:SetParent(playerbar.Health)
			playereffect:SetAlpha(0.4)

			targeteffect:ClearAllPoints()
			targeteffect:SetAllPoints(targetbar.Health:GetStatusBarTexture())
			targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel())
			targeteffect:SetInside(targetbar.Health, 0, 0)
			targeteffect:SetParent(targetbar.Health)
			targeteffect:SetAlpha(0.4)

		elseif E.db.ElvUI_EltreumUI.darkmode then
			playereffect:SetAlpha(0.5)
			playereffect:SetAllPoints(playerbar.Health.backdropTex)
			playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel())
			playereffect:SetInside(playerbar.Health.backdropTex, 0, 0)
			playereffect:SetParent(playerbar.Health)

			targeteffect:ClearAllPoints()
			targeteffect:SetAlpha(0.5)
			targeteffect:SetAllPoints(targetbar.Health.backdropTex)
			targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel())
			targeteffect:SetInside(targetbar.Health.backdropTex, 0, 0)
			targeteffect:SetParent(targetbar.Health)
		end
	end
end

hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.UFEffects)
hooksecurefunc(UF, "Update_TargetFrame", ElvUI_EltreumUI.UFEffects)
