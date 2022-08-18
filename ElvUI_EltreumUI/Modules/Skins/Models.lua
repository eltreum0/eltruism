local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local playereffect = CreateFrame("playermodel", "EltruismPlayerEffect")
local targeteffect = CreateFrame("playermodel", "EltruismTargetEffect")
local playerbar,targetbar

--models table, because each version has different texture paths
local classModels = {}
if E.Retail then
	classModels = {
		["PRIEST"] = "spells/christmassnowrain.m2",
		["WARRIOR"] = "spells/flamebreath.m2",
		["ROGUE"] = "spells/corrosivesandbreath.m2",
		["PALADIN"] = "spells/arcanebreath.m2",
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "spells/waterliquidbreath.m2",
		["MAGE"] = "environments/stars/astromancer_baseskybox01.m2",
		["WARLOCK"] = "environments/stars/general_legionskybox01.m2",
		["DRUID"] = "environments/stars/nagrandskybox.m2",
		["DEATHKNIGHT"] = "spells/frostbreath.m2",
		["MONK"] = "spells/acidcloudbreath.m2",
		["DEMONHUNTER"] = "spells/acidliquidbreath.m2",
	}
elseif E.Wrath then
	classModels = {
		["PRIEST"] = "spells/christmassnowrain.m2",
		["WARRIOR"] = "spells/flamebreath.m2",
		["ROGUE"] = "spells/corrosivesandbreath.m2",
		["PALADIN"] = "spells/arcanebreath.m2",
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "spells/waterliquidbreath.m2",
		["MAGE"] = "environments/stars/netherstormskybox.m2",
		["WARLOCK"] = "environments/stars/shadowmoonskybox.m2",
		["DRUID"] = "environments/stars/nagrandskybox.m2",
		["DEATHKNIGHT"] = "spells/frostbreath.m2",
		["MONK"] = "spells/acidcloudbreath.m2",
		["DEMONHUNTER"] = "spells/acidliquidbreath.m2",
	}
elseif E.TBC then
	classModels = {
		["PRIEST"] = "spells/christmassnowrain.m2",
		["WARRIOR"] = "spells/flamebreath.m2",
		["ROGUE"] = "spells/corrosivesandbreath.m2",
		["PALADIN"] = "spells/arcanebreath.m2",
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "spells/waterliquidbreath.m2",
		["MAGE"] = "environments/stars/netherstormskybox.m2",
		["WARLOCK"] = "environments/stars/shadowmoonskybox.m2",
		["DRUID"] = "environments/stars/nagrandskybox.m2",
		["DEATHKNIGHT"] = "spells/frostbreath.m2",
		["MONK"] = "spells/acidcloudbreath.m2",
		["DEMONHUNTER"] = "spells/acidliquidbreath.m2",
	}
elseif E.Classic then
	classModels = {
		["PRIEST"] = "spells/christmassnowrain.m2",
		["WARRIOR"] = "spells/flamebreath.m2",
		["ROGUE"] = "spells/corrosivesandbreath.m2",
		["PALADIN"] = "spells/arcanebreath.m2",
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "spells/waterliquidbreath.m2",
		["MAGE"] = "environments/stars/netherstormskybox.m2",
		["WARLOCK"] = "environments/stars/shadowmoonskybox.m2",
		["DRUID"] = "environments/stars/nagrandskybox.m2",
		["DEATHKNIGHT"] = "spells/frostbreath.m2",
		["MONK"] = "spells/acidcloudbreath.m2",
		["DEMONHUNTER"] = "spells/acidliquidbreath.m2",
	}
end

---add effects to player/target UF
function ElvUI_EltreumUI:UFEffects()
	if E.db.ElvUI_EltreumUI.models.unitframe and E.private.unitframe.enable then
		playerbar = _G["ElvUF_Player"]
		playereffect:SetModel(classModels[E.myclass])
		playereffect:SetDesaturation(E.db.ElvUI_EltreumUI.models.ufdesaturation)
		playereffect:SetParent(playerbar.Health)

		targetbar = _G["ElvUF_Target"]
		local _, targetclass = UnitClass("target")
		if UnitIsPlayer("target") then
			targeteffect:SetModel(classModels[targetclass])
		else
			targeteffect:SetModel("environments/stars/hellfireskybox.m2")
		end
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
