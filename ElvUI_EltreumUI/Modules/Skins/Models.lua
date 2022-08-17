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


local classModelsTBC = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Warrior",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Paladin",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Hunter",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Rogue",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Priest",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DeathKnight",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Shaman",
	["MAGE"] = "environments/stars/netherstormskybox.m2",
	["WARLOCK"] = "environments/stars/shadowmoonskybox.m2",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Monk",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Druid",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunter",
}


---add effects to player/target UF
function ElvUI_EltreumUI:UFEffects()
	if E.db.ElvUI_EltreumUI.models.unitframe and E.private.unitframe.enable then
		playerbar = _G["ElvUF_Player"]
		targetbar = _G["ElvUF_Target"]


		--playereffect:SetModel("spells/christmassnowrain.m2")
		playereffect:SetModel("environments/stars/hellfireskybox.m2")
		--playereffect:SetModel("spells/fel_rainoffire_missile.m2")

		--playereffect:SetPosition(0, -0.85, 1.65)
		--playereffect:SetFacing(rad(180))
		playereffect:SetDesaturation(E.db.ElvUI_EltreumUI.models.ufdesaturation)
		playereffect:SetParent(playerbar.Health)

		--targeteffect:SetModel("spells/fel_rainoffire_missile.m2")
		targeteffect:SetModel("environments/stars/hellfireskybox.m2")
		--targeteffect:SetModel("environments/stars/shadowmoonskybox.m2")
		--targeteffect:SetModel("environments/stars/nagrandskybox.m2")
		--targeteffect:SetModel("environments/stars/shadowmoonskybox.m2")
		--targeteffect:SetModel("environments/stars/netherstormskybox.m2")
		--targeteffect:SetPosition(0, -0.85, 1.65)
		--targeteffect:SetFacing(rad(180)) --for shadowmoon
		targeteffect:SetDesaturation(E.db.ElvUI_EltreumUI.models.ufdesaturation)
		targeteffect:SetParent(targetbar.Health)

		if E.db.ElvUI_EltreumUI.lightmode then
			playereffect:SetAlpha(E.db.ElvUI_EltreumUI.models.ufalpha)
			playereffect:SetAllPoints(playerbar.Health:GetStatusBarTexture())
			playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel()-1)
			--playereffect:SetFrameLevel(playerbar.Portrait3D:GetFrameLevel())
			playereffect:SetInside(playerbar.Health:GetStatusBarTexture(), 0, 0)

			targeteffect:ClearAllPoints()
			targeteffect:SetAlpha(E.db.ElvUI_EltreumUI.models.ufalpha)
			targeteffect:SetAllPoints(targetbar.Health:GetStatusBarTexture())
			targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel()-1)
			--targeteffect:AddMaskTexture(targetbar.Health:GetStatusBarTexture())
			targeteffect:SetInside(targetbar.Health:GetStatusBarTexture(), 0, 0)

		elseif E.db.ElvUI_EltreumUI.darkmode then

			playereffect:SetAlpha(E.db.ElvUI_EltreumUI.models.ufalphadark)
			playereffect:SetAllPoints(playerbar.Health.backdropTex)
			playereffect:SetFrameLevel(playerbar.Portrait3D:GetFrameLevel())
			playereffect:SetInside(playerbar.Health.backdropTex, 0, 0)

			targeteffect:ClearAllPoints()
			targeteffect:SetAlpha(E.db.ElvUI_EltreumUI.models.ufalphadark)
			targeteffect:SetAllPoints(targetbar.Health.backdropTex)
			targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel())
			targeteffect:SetInside(targetbar.Health.backdropTex, 0, 0)


		end
	end
end

hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.UFEffects)
hooksecurefunc(UF, "Update_TargetFrame", ElvUI_EltreumUI.UFEffects)
