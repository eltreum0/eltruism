local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
--local UnitExists = _G.UnitExists
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local playereffect = CreateFrame("playermodel", "EltruismPlayerEffect")
local targeteffect = CreateFrame("playermodel", "EltruismTargetEffect")
local targettargeteffect = CreateFrame("playermodel", "EltruismTargetTargetEffect")
local playerbar,targetbar
local reaction
local _, targetclass
local targettargetbar
local reactiontargettarget
local targettargetclass
local petbar
local petpetbar
local peteffect = CreateFrame("playermodel", "EltruismPetEffect")
local powerbareffectplayer = CreateFrame("PlayerModel", "EltruismPlayerPowerBarEffect")
local powerbareffecttarget = CreateFrame("PlayerModel", "EltruismTargetPowerBarEffect")
local powerbareffecttargettarget = CreateFrame("PlayerModel", "EltruismTargetTargetPowerBarEffect")
local powerbareffectpet = CreateFrame("PlayerModel", "EltruismPetPowerBarEffect")
local powerbar, targetpowerbar,targettargetpowerbar,petpowerbar

--models table, because each version has different texture paths
--its based on the color of the model, not the name/theme
local classModels = {}
if E.Retail then
	classModels = {
		["PRIEST"] = 590934,
		["PALADIN"] = 130593,
		--["PALADIN"] = 165575,
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
elseif E.Wrath then
	classModels = {
		["MAGE"] = "environments/stars/nexusraid_runeeffects_starry.m2",
		["PALADIN"] = "environments/stars/netherstormskybox.m2",
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "environments/stars/icecrownsky.m2",
		["PRIEST"] = "spells/christmassnowrain.m2",
		["DEATHKNIGHT"] = "spells/nefarianflamebreath.m2", --"spells/redradiationfog.m2", --"spells/frostbreath.m2",  --world/generic/passivedoodads/particleemitters/aurared.m2 , "environments/stars/bladesedgeskybox.m2"
		["WARRIOR"] = "spells/flamebreath.m2", --spells/disarm_impact_chest.m2
		["ROGUE"] = "environments/stars/shadowmoonillidan.m2",
		["WARLOCK"] = "environments/stars/netherstormskybox.m2",
		["DRUID"] = "spells/cyclonefire_state.m2",
		["NPCNEUTRAL"] = "spells/acidliquidbreath.m2",
		["NPCFRIENDLY"] = "environments/stars/portalworldlegionsky.m2",
		["NPCUNFRIENDLY"] = "spells/flamebreath.m2", --spells/darkritual_precast_base.m2",
		["NPCHOSTILE"] = "spells/deathanddecay_area_base.m2",
		--["DEMONHUNTER"] = "environments/stars/nexusraid_nebulasky.m2",
		--["PALADIN"] = "spells/arcanebreath.m2",
		--["NPCFRIENDLY"] = "spells/spells/cycloneearth_state.m2",
	}
elseif E.TBC then
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
		["NPCNEUTRAL"] = "spells/acidliquidbreath.m2",
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
		["MAGE"] = "spells/frostbreath.m2", --"spells/demonicsacrifice_felhunter_chest.m2"
		["WARLOCK"] = "spells/corruption_impactdot_med_base.m2",
		["DRUID"] = "spells/cyclonefire_state.m2",
		["NPCNEUTRAL"] = "spells/demonicsacrifice_voidwalker_chest.m2",
		["NPCFRIENDLY"] = "spells/acidliquidbreath.m2",
		["NPCUNFRIENDLY"] = "spells/flamebreath.m2", --spells/darkritual_precast_base.m2",
		["NPCHOSTILE"] = "spells/deathanddecay_area_base.m2",
	}
end

--add effects to player
function ElvUI_EltreumUI:PlayerUFEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			playerbar = _G["ElvUF_Player"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				--playereffect:ClearModel()
				playereffect:SetModel(classModels[E.myclass])
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CUSTOM" then
				--playereffect:ClearModel()
				if E.Retail then
					playereffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodel)
				else
					playereffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic)
				end
			end

			if playerbar then
				playereffect:SetDesaturation(E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation)
				playereffect:SetParent(playerbar.Health)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					playereffect:SetAllPoints(playerbar.Health:GetStatusBarTexture())
					playereffect:SetInside(playerbar.Health:GetStatusBarTexture(), 0, 0)
					playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel())
					playereffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				--elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				else
					playereffect:SetAllPoints(playerbar.Health)
					playereffect:SetInside(playerbar.Health, 0, 0)
					playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel()-1)
					playereffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
				--playereffect:SetFrameLevel(playerbar.Portrait3D:GetFrameLevel())
			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			powerbar = _G["ElvUF_Player_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffectplayer:SetModel(1715069)
					powerbareffectplayer:MakeCurrentCameraCustom()
					powerbareffectplayer:SetTransform(-0.035, 0, 0, rad(270), 0, 0, 0.585)
					powerbareffectplayer:SetPortraitZoom(1)
					powerbareffectplayer:SetAlpha(0.4) --might do this
				else
					powerbareffectplayer:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectplayer:SetPosition(1.2, 0, 0)
					powerbareffectplayer:SetAlpha(0.4) --might do this
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
				if E.Retail then
					powerbareffectplayer:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
				else
					powerbareffectplayer:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
				end
			end

			if powerbar then
				--powerbareffectplayer:SetAlpha(1)
				powerbareffectplayer:ClearAllPoints()
				powerbareffectplayer:SetAllPoints(powerbar:GetStatusBarTexture())
				powerbareffectplayer:SetFrameLevel(powerbar:GetFrameLevel())
				powerbareffectplayer:SetInside(powerbar:GetStatusBarTexture(), 0, 0)
				powerbareffectplayer:SetParent(powerbar)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_PlayerFrame", ElvUI_EltreumUI.PlayerUFEffects)
hooksecurefunc(UF, "Update_PlayerFrame", ElvUI_EltreumUI.PlayerUFEffects)

--add effects to target
function ElvUI_EltreumUI:TargetUFEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			targetbar = _G["ElvUF_Target"]
			reaction = UnitReaction("target", "player")
			_, targetclass = UnitClass("target")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				--targeteffect:ClearModel()
				if UnitIsPlayer("target") and targetclass then
					targeteffect:SetModel(classModels[targetclass])
				else
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
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CUSTOM" then
				--targeteffect:ClearModel()
				if E.Retail then
					targeteffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodel)
				else
					targeteffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic)
				end
			end

			if targetbar then
				targeteffect:SetDesaturation(E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation)
				targeteffect:SetParent(targetbar.Health)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					targeteffect:ClearAllPoints()
					targeteffect:SetAllPoints(targetbar.Health:GetStatusBarTexture())
					targeteffect:SetInside(targetbar.Health:GetStatusBarTexture(), 0, 0)
					targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel())
					targeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				--elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				else
					targeteffect:ClearAllPoints()
					targeteffect:SetAllPoints(targetbar.Health)
					targeteffect:SetInside(targetbar.Health, 0, 0)
					targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel()-1)
					targeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
				--targeteffect:AddMaskTexture(targetbar.Health:GetStatusBarTexture())
			end
		end

		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			targetpowerbar = _G["ElvUF_Target_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffecttarget:SetModel(1715069)
					powerbareffecttarget:MakeCurrentCameraCustom()
					powerbareffecttarget:SetTransform(-0.035, 0, 0, rad(270), 0, 0, 0.585)
					powerbareffecttarget:SetPortraitZoom(1)
					powerbareffecttarget:SetAlpha(0.4) --might do this
				else
					powerbareffecttarget:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffecttarget:SetPosition(1.2, 0, 0)
					powerbareffecttarget:SetAlpha(0.4) --might do this
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
				if E.Retail then
					powerbareffecttarget:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
				else
					powerbareffecttarget:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
				end
			end
			if targetpowerbar then
				--powerbareffecttarget:SetAlpha(1)
				powerbareffecttarget:ClearAllPoints()
				powerbareffecttarget:SetAllPoints(targetpowerbar:GetStatusBarTexture())
				powerbareffecttarget:SetFrameLevel(targetpowerbar:GetFrameLevel())
				powerbareffecttarget:SetInside(targetpowerbar:GetStatusBarTexture(), 0, 0)
				powerbareffecttarget:SetParent(targetpowerbar)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.TargetUFEffects)
hooksecurefunc(UF, "Update_TargetFrame", ElvUI_EltreumUI.TargetUFEffects)

--add effects to target
function ElvUI_EltreumUI:TargetTargetUFEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			targettargetbar = _G["ElvUF_TargetTarget"]
			reactiontargettarget = UnitReaction("targettarget", "player")
			_, targettargetclass = UnitClass("targettarget")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				if UnitIsPlayer("targettarget") and targettargetclass then
					targettargeteffect:SetModel(classModels[targettargetclass])
				else
					if reactiontargettarget then
						if reactiontargettarget >= 5 then
							targettargeteffect:SetModel(classModels["NPCFRIENDLY"])
						elseif reactiontargettarget == 4 then
							targettargeteffect:SetModel(classModels["NPCNEUTRAL"])
						elseif reactiontargettarget == 3 then
							targettargeteffect:SetModel(classModels["NPCUNFRIENDLY"])
						elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
							targettargeteffect:SetModel(classModels["NPCHOSTILE"])
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CUSTOM" then
				if E.Retail then
					targettargeteffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodel)
				else
					targettargeteffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic)
				end
			end

			if targettargetbar then
				targeteffect:SetDesaturation(E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation)
				targettargeteffect:SetParent(targettargetbar.Health)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					targettargeteffect:ClearAllPoints()
					targettargeteffect:SetAllPoints(targettargetbar.Health:GetStatusBarTexture())
					targettargeteffect:SetInside(targettargetbar.Health:GetStatusBarTexture(), 0, 0)
					targettargeteffect:SetFrameLevel(targettargetbar.Health:GetFrameLevel())
					targettargeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				--elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				else
					targettargeteffect:ClearAllPoints()
					targettargeteffect:SetAllPoints(targettargetbar.Health)
					targettargeteffect:SetInside(targettargetbar.Health, 0, 0)
					targettargeteffect:SetFrameLevel(targettargetbar.Health:GetFrameLevel()-1)
					targettargeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
				--targeteffect:AddMaskTexture(targetbar.Health:GetStatusBarTexture())
			end
		end

		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			targettargetpowerbar = _G["ElvUF_TargetTarget_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffecttargettarget:SetModel(1715069)
					powerbareffecttargettarget:MakeCurrentCameraCustom()
					powerbareffecttargettarget:SetTransform(-0.035, 0, 0, rad(270), 0, 0, 0.585)
					powerbareffecttargettarget:SetPortraitZoom(1)
					powerbareffecttargettarget:SetAlpha(0.4) --might do this
				else
					powerbareffecttargettarget:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffecttargettarget:SetPosition(1.2, 0, 0)
					powerbareffecttargettarget:SetAlpha(0.4) --might do this
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
				if E.Retail then
					powerbareffecttargettarget:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
				else
					powerbareffecttargettarget:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
				end
			end

			if targettargetpowerbar then
				--powerbareffecttargettarget:SetAlpha(1)
				powerbareffecttargettarget:ClearAllPoints()
				powerbareffecttargettarget:SetAllPoints(targettargetpowerbar:GetStatusBarTexture())
				powerbareffecttargettarget:SetFrameLevel(targettargetpowerbar:GetFrameLevel())
				powerbareffecttargettarget:SetInside(targettargetpowerbar:GetStatusBarTexture(), 0, 0)
				powerbareffecttargettarget:SetParent(targettargetpowerbar)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_TargetTargetFrame", ElvUI_EltreumUI.TargetTargetUFEffects)
hooksecurefunc(UF, "Update_TargetTargetFrame", ElvUI_EltreumUI.TargetTargetUFEffects)

--update whenever the target changes target
local targetoftargetupdater = CreateFrame("FRAME")
targetoftargetupdater:RegisterEvent("UNIT_TARGET", "target")
targetoftargetupdater:SetScript("OnEvent", function()
	ElvUI_EltreumUI:TargetTargetUFEffects()
end)

--add effects to pet
function ElvUI_EltreumUI:PetUFEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			petbar = _G["ElvUF_Pet"]
			petpetbar = _G["ElvUF_PetPet"]
			reaction = UnitReaction("pet", "player")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				--peteffect:ClearModel()
				if reaction then
					if reaction >= 5 then
						peteffect:SetModel(classModels["NPCFRIENDLY"])
					elseif reaction == 4 then
						peteffect:SetModel(classModels["NPCNEUTRAL"])
					elseif reaction == 3 then
						peteffect:SetModel(classModels["NPCUNFRIENDLY"])
					elseif reaction == 2 or reaction == 1 then
						peteffect:SetModel(classModels["NPCHOSTILE"])
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CUSTOM" then
				--peteffect:ClearModel()
				if E.Retail then
					peteffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodel)
				else
					peteffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic)
				end
			end

			if petbar then
				peteffect:SetDesaturation(E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation)
				peteffect:SetParent(petbar.Health)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					peteffect:ClearAllPoints()
					peteffect:SetAllPoints(petbar.Health:GetStatusBarTexture())
					peteffect:SetInside(petbar.Health:GetStatusBarTexture(), 0, 0)
					peteffect:SetFrameLevel(petbar.Health:GetFrameLevel())
					peteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				--elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
				else
					peteffect:ClearAllPoints()
					peteffect:SetAllPoints(petbar.Health)
					peteffect:SetInside(petbar.Health, 0, 0)
					peteffect:SetFrameLevel(petbar.Health:GetFrameLevel()-1)
					peteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
				--peteffect:AddMaskTexture(petbar.Health:GetStatusBarTexture())
			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			petpowerbar = _G["ElvUF_Pet_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffectpet:SetModel(1715069)
					powerbareffectpet:MakeCurrentCameraCustom()
					powerbareffectpet:SetTransform(-0.035, 0, 0, rad(270), 0, 0, 0.585)
					powerbareffectpet:SetPortraitZoom(1)
					powerbareffectpet:SetAlpha(0.4) --might do this
				else
					powerbareffectpet:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectpet:SetPosition(1.2, 0, 0)
					powerbareffectpet:SetAlpha(0.4) --might do this
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
				if E.Retail then
					powerbareffectpet:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
				else
					powerbareffectpet:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
				end
			end
			if petpowerbar then
				--powerbareffectpet:SetAlpha(1)
				powerbareffectpet:SetAllPoints(petpowerbar:GetStatusBarTexture())
				powerbareffectpet:SetFrameLevel(petpowerbar:GetFrameLevel())
				powerbareffectpet:SetInside(petpowerbar:GetStatusBarTexture(), 0, 0)
				powerbareffectpet:SetParent(petpowerbar)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_PetFrame", ElvUI_EltreumUI.PetUFEffects)
hooksecurefunc(UF, "Update_PetFrame", ElvUI_EltreumUI.PetUFEffects)

--castbar model effect
local castbareffectplayer = CreateFrame("PlayerModel", "EltruismPlayerCastBarEffect")
local castbareffecttarget = CreateFrame("PlayerModel", "EltruismTargetCastBarEffect")
local castbar
local targetcastbar

--add effect to castbar
function ElvUI_EltreumUI:CastbarEffects()
	if E.private.unitframe.enable then
		if E.db.ElvUI_EltreumUI.unitframes.models.castbar then
			castbar = _G["ElvUF_Player_CastBar"]
			targetcastbar = _G["ElvUF_Target_CastBar"]

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast == "DEFAULT" then
				if E.Retail then
					castbareffectplayer:SetModel(165821)
					castbareffecttarget:SetModel(165821)
				else
					castbareffectplayer:SetModel("spells/corruption_impactdot_med_base.m2")
					castbareffecttarget:SetModel("spells/corruption_impactdot_med_base.m2")
				end
				castbareffectplayer:SetPosition(0, -0.85, 1.65)
				castbareffectplayer:SetFacing(rad(180))
				castbareffecttarget:SetPosition(0, -0.85, 1.65)
				castbareffecttarget:SetFacing(rad(180))
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast == "CUSTOM" then
				if E.Retail then
					castbareffectplayer:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelcast)
					castbareffecttarget:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelcast)
				else
					castbareffectplayer:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassiccast)
					castbareffecttarget:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassiccast)
				end
			end

			if castbar then
				castbareffectplayer:SetAlpha(1)
				castbareffectplayer:SetAllPoints(castbar:GetStatusBarTexture())
				castbareffectplayer:SetFrameLevel(castbar:GetFrameLevel())
				castbareffectplayer:SetInside(castbar:GetStatusBarTexture(), 0, 0)
				castbareffectplayer:SetParent(castbar)
			end

			if targetcastbar then
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
