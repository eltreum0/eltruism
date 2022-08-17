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

	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Rogue",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Priest",

	["HUNTER"] = "environments/stars/hellfireskybox.m2",
	["SHAMAN"] = "spells/christmassnowrain.m2",
	["MAGE"] = "environments/stars/netherstormskybox.m2",
	["WARLOCK"] = "environments/stars/shadowmoonskybox.m2",
	["DRUID"] = "environments/stars/nagrandskybox.m2",

	["DEATHKNIGHT"] = "environments/stars/dragonblightscarletskybox.m2",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/Monk",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/DemonHunter",
}


---add effects to player/target UF
function ElvUI_EltreumUI:UFEffects()
	if E.db.ElvUI_EltreumUI.models.unitframe and E.private.unitframe.enable then
		playerbar = _G["ElvUF_Player"]
		targetbar = _G["ElvUF_Target"]

		playereffect:SetModel("spells/arcanebreath.m2")
		playereffect:SetDesaturation(E.db.ElvUI_EltreumUI.models.ufdesaturation)
		playereffect:SetParent(playerbar.Health)


		targeteffect:SetModel("spells/arcanebreath.m2")
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
