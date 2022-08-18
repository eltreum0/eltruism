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
--its based on the color of the model, not the name/theme
local classModels = {}
if E.Retail then
	classModels = {
		["PRIEST"] = 590934,
		["PALADIN"] = 130593,
		["HUNTER"] = 1251379,
		["SHAMAN"] = 130552,
		["MAGE"] = 235339,
		--["MAGE"] = 1538774,
		["WARLOCK"] = 3185115,
		["DEMONHUNTER"] = 235337,
		["DRUID"] = 2575322,
		["WARRIOR"] = 1684062,
		["ROGUE"] = 3152583,
		["DEATHKNIGHT"] = 130476,
		["MONK"] = 3513377,
		["NPCFRIENDLY"] = 1726751,
		["NPCUNFRIENDLY"] = 1965208,
		["NPCHOSTILE"] = 235284,
		["NPCNEUTRAL"] = 1306105,
		---130623 --shadowmoon tbc w/ meteors
		--130551, --icecrown very very blue
		--130525, --hellfire
		--4234796 smoky stormwind
		--937003 fire
	}
elseif E.Wrath or E.TBC then
	classModels = {
		["PRIEST"] = "spells/christmassnowrain.m2",
		["DEATHKNIGHT"] = "environments/stars/bladesedgeskybox.m2", --"spells/frostbreath.m2",
		["WARRIOR"] = "spells/flamebreath.m2", --spells/disarm_impact_chest.m2
		["ROGUE"] = "environments/stars/shadowmoonillidan.m2",
		["PALADIN"] = "environments/stars/netherstormskybox.m2",
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["WARLOCK"] = "environments/stars/netherstormskybox.m2",
		["SHAMAN"] = "spells/arcanepower_state_chest.m2",
		["DRUID"] = "spells/cyclonefire_state.m2",
		["MAGE"] = "spells/frostbreath.m2",
		["NPCNEUTRAL"] =  "spells/acidliquidbreath.m2",
		["NPCFRIENDLY"] = "environments/stars/portalworldlegionsky.m2",
		["NPCUNFRIENDLY"] = "spells/flamebreath.m2", --spells/darkritual_precast_base.m2",
		["NPCHOSTILE"] = "spells/deathanddecay_area_base.m2",
		--["DEMONHUNTER"] = "environments/stars/nexusraid_nebulasky.m2",
		--["PALADIN"] = "spells/arcanebreath.m2",
		--["NPCFRIENDLY"] = "spells/spells/cycloneearth_state.m2",
	}
else
	classModels = {
		["PRIEST"] = "spells/christmassnowrain.m2",
		["WARRIOR"] = "spells/disarm_impact_chest.m2",
		["ROGUE"] = "spells/sandvortex_state_base.m2", --"spells/corrosivesandbreath.m2",
		["PALADIN"] = "spells/holy_precast_uber_base.m2",
		["HUNTER"] = "spells/acidcloudbreath.m2",
		["SHAMAN"] = "spells/arcanepower_state_chest.m2",
		["MAGE"] = "spells/frostbreath.m2",  --"spells/demonicsacrifice_felhunter_chest.m2"
		["WARLOCK"] = "spells/corruption_impactdot_med_base.m2",
		["DRUID"] = "spells/cyclonefire_state.m2",
		["NPCFRIENDLY"] = "spells/spells/cycloneearth_state.m2",
		["NPCUNFRIENDLY"] = "spells/flamebreath.m2", --spells/darkritual_precast_base.m2",
		["NPCHOSTILE"] = "spells/deathanddecay_area_base.m2",
		["NPCNEUTRAL"] = "spells/demonicsacrifice_voidwalker_chest.m2",
	}
end

---add effects to player/target UF
function ElvUI_EltreumUI:UFEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.models.unitframe then
			playerbar = _G["ElvUF_Player"]
			targetbar = _G["ElvUF_Target"]

			if E.db.ElvUI_EltreumUI.models.modeltype == "CLASS" then
				playereffect:ClearModel()
				playereffect:SetModel(classModels[E.myclass])
				targeteffect:ClearModel()
				local _, targetclass = UnitClass("target")
				if UnitIsPlayer("target") then
					targeteffect:SetModel(classModels[targetclass])
				else
					local reaction = UnitReaction("target", "player")
					if reaction then
						if reaction >= 5 then
							targeteffect:SetModel(classModels["NPCFRIENDLY"])
						elseif reaction == 4 then
							targeteffect:SetModel(classModels["NPCNEUTRAL"])
						elseif reaction == 3 then
							targeteffect:SetModel(classModels["NPCUNFRIENDLY"])
						elseif reaction == 2 or reaction == 1 then
							targeteffect:SetModel(classModels["NPCHOSTILE"])
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.models.modeltype == "CUSTOM" then
				playereffect:ClearModel()
				if E.Retail then
					playereffect:SetModel(E.db.ElvUI_EltreumUI.models.custommodel)
				else
					playereffect:SetModel(E.db.ElvUI_EltreumUI.models.custommodelclassic)
				end
				targeteffect:ClearModel()
				if E.Retail then
					targeteffect:SetModel(E.db.ElvUI_EltreumUI.models.custommodel)
				else
					targeteffect:SetModel(E.db.ElvUI_EltreumUI.models.custommodelclassic)
				end
			end

			if playerbar then
				playereffect:SetDesaturation(E.db.ElvUI_EltreumUI.models.ufdesaturation)
				playereffect:SetParent(playerbar.Health)
				if E.db.ElvUI_EltreumUI.lightmode then
					playereffect:SetAllPoints(playerbar.Health:GetStatusBarTexture())
					playereffect:SetInside(playerbar.Health:GetStatusBarTexture(), 0, 0)
				--elseif E.db.ElvUI_EltreumUI.darkmode then
				else
					playereffect:SetAllPoints(playerbar.Health)
					playereffect:SetInside(playerbar.Health, 0, 0)
				end
				playereffect:SetAlpha(E.db.ElvUI_EltreumUI.models.ufalpha)
				playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel()-1)
				--playereffect:SetFrameLevel(playerbar.Portrait3D:GetFrameLevel())
			end

			if targetbar then
				targeteffect:SetDesaturation(E.db.ElvUI_EltreumUI.models.ufdesaturation)
				targeteffect:SetParent(targetbar.Health)
				if E.db.ElvUI_EltreumUI.lightmode then
					targeteffect:ClearAllPoints()
					targeteffect:SetAllPoints(targetbar.Health:GetStatusBarTexture())
					targeteffect:SetInside(targetbar.Health:GetStatusBarTexture(), 0, 0)
				--elseif E.db.ElvUI_EltreumUI.darkmode then
				else
					targeteffect:ClearAllPoints()
					targeteffect:SetAllPoints(targetbar.Health)
					targeteffect:SetInside(targetbar.Health, 0, 0)
				end
				targeteffect:SetAlpha(E.db.ElvUI_EltreumUI.models.ufalpha)
				targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel()-1)
				--targeteffect:AddMaskTexture(targetbar.Health:GetStatusBarTexture())
			end
		end
	end
end
hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.UFEffects)
hooksecurefunc(UF, "Update_TargetFrame", ElvUI_EltreumUI.UFEffects)

--castbar model effect
local castbareffectplayer = CreateFrame("PlayerModel", "EltruismPlayerCastBarEffect")
local castbareffecttarget = CreateFrame("PlayerModel", "EltruismTargetCastBarEffect")
local castbar
local targetcastbar

--add effect to castbar
function ElvUI_EltreumUI:CastbarEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.models.castbar then
			castbar = _G["ElvUF_Player_CastBar"]
			targetcastbar = _G["ElvUF_Target_CastBar"]

			if castbar then
				if E.db.ElvUI_EltreumUI.models.modeltypecast == "DEFAULT" then
					if E.Retail then
						castbareffectplayer:SetModel(165821)
					else
						castbareffectplayer:SetModel("spells/corruption_impactdot_med_base.m2")
					end
					castbareffectplayer:SetPosition(0, -0.85, 1.65)
					castbareffectplayer:SetFacing(rad(180))
				elseif E.db.ElvUI_EltreumUI.models.modeltypecast == "CUSTOM" then
					if E.Retail then
						castbareffectplayer:SetModel(E.db.ElvUI_EltreumUI.models.custommodelcast)
					else
						castbareffectplayer:SetModel(E.db.ElvUI_EltreumUI.models.custommodelclassiccast)
					end
				end
				castbareffectplayer:SetAlpha(1)
				castbareffectplayer:SetAllPoints(castbar:GetStatusBarTexture())
				castbareffectplayer:SetFrameLevel(castbar:GetFrameLevel())
				castbareffectplayer:SetInside(castbar:GetStatusBarTexture(), 0, 0)
				castbareffectplayer:SetParent(castbar)
			end

			if targetcastbar then
				if E.db.ElvUI_EltreumUI.models.modeltypecast == "DEFAULT" then
					if E.Retail then
						castbareffecttarget:SetModel(165821)
					else
						castbareffecttarget:SetModel("spells/corruption_impactdot_med_base.m2")
					end
					castbareffecttarget:SetPosition(0, -0.85, 1.65)
					castbareffecttarget:SetFacing(rad(180))
				elseif E.db.ElvUI_EltreumUI.models.modeltypecast == "CUSTOM" then
					if E.Retail then
						castbareffecttarget:SetModel(E.db.ElvUI_EltreumUI.models.custommodelcast)
					else
						castbareffecttarget:SetModel(E.db.ElvUI_EltreumUI.models.custommodelclassiccast)
					end
				end
				castbareffecttarget:SetAlpha(1)
				castbareffecttarget:ClearAllPoints()
				castbareffecttarget:SetAllPoints(targetcastbar:GetStatusBarTexture())
				castbareffecttarget:SetFrameLevel(targetcastbar:GetFrameLevel())
				castbareffecttarget:SetInside(targetcastbar:GetStatusBarTexture(), 0, 0)
				castbareffecttarget:SetParent(targetcastbar)
			end
		end
	end
end
hooksecurefunc(UF, 'Construct_Castbar', ElvUI_EltreumUI.CastbarEffects)
hooksecurefunc(UF, 'PostCastStart', ElvUI_EltreumUI.CastbarEffects)
