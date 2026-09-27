local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local CreateFrame = _G.CreateFrame
local playereffect = CreateFrame("playermodel", "EltruismPlayerEffect")
local targeteffect = CreateFrame("playermodel", "EltruismTargetEffect")
local targettargeteffect = CreateFrame("playermodel", "EltruismTargetTargetEffect")
local focuseffect = CreateFrame("playermodel", "EltruismFocusEffect")
local peteffect = CreateFrame("playermodel", "EltruismPetEffect")
local powerbareffectplayer = CreateFrame("PlayerModel", "EltruismPlayerPowerBarEffect")
local powerbareffecttarget = CreateFrame("PlayerModel", "EltruismTargetPowerBarEffect")
local powerbareffecttargettarget = CreateFrame("PlayerModel", "EltruismTargetTargetPowerBarEffect")
local powerbareffectfocus = CreateFrame("PlayerModel", "EltruismFocusPowerBarEffect")
local powerbareffectpet = CreateFrame("PlayerModel", "EltruismPetPowerBarEffect")
local castbareffectplayer = CreateFrame("PlayerModel", "EltruismPlayerCastBarEffect")
local castbareffecttarget = CreateFrame("PlayerModel", "EltruismTargetCastBarEffect")
local CreateVector3D = _G.CreateVector3D
local rad = _G.rad
local UnitReaction = _G.UnitReaction
local UnitInPartyIsAI = _G.UnitInPartyIsAI
local UnitCanAttack = _G.UnitCanAttack
local UnitIsEnemy = _G.UnitIsEnemy
local UnitIsFriend = _G.UnitIsFriend

--models table, because each version has different texture paths
--its based on the color of the model, not the name/theme
local classModels = {
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
	["MONK"] = 130495,
	["NPCFRIENDLY"] = 1726751,
	["NPCUNFRIENDLY"] = 1965208,
	["NPCHOSTILE"] = 241128, --235284
	["NPCNEUTRAL"] = 1306105,
	["EVOKER"] = 130525,
	---130623 --shadowmoon tbc w/ meteors
	--130551, --icecrown very very blue
	--130525, --hellfire
	--4234796 smoky stormwind
	--937003 fire
}
if E.Mists then
	classModels = {
		["MAGE"] = "environments/stars/nexusraid_runeeffects_starry.m2",
		["PALADIN"] = "environments/stars/netherstormskybox.m2", --spells/dragonbreath_arcane.m2
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "environments/stars/icecrownsky.m2",
		["PRIEST"] = "environments/stars/mantiddarksky01.m2",
		["DEATHKNIGHT"] = "environments/stars/bladesedgeskybox.m2", --"spells/nefarianflamebreath.m2", --(166613) --"spells/redradiationfog.m2" (166693), --"spells/frostbreath.m2" (166215), --world/generic/passivedoodads/particleemitters/aurared.m2 (199918) , "environments/stars/bladesedgeskybox.m2" (130476)
		["WARRIOR"] = "environments/stars/wintergraspsmokysky_night.m2", --spells/disarm_impact_chest.m2
		["ROGUE"] = "environments/stars/shadowmoonillidan.m2",
		["WARLOCK"] = "environments/stars/nagrandskybox.m2",
		["DRUID"] = "spells/cyclonefire_state.m2",
		["NPCNEUTRAL"] = "spells/acidliquidbreath.m2",
		["NPCFRIENDLY"] = "environments/stars/portalworldlegionsky.m2",
		["NPCUNFRIENDLY"] = "spells/flamebreath.m2", --spells/darkritual_precast_base.m2",
		["NPCHOSTILE"] = "spells/zulaman_firedoor_unit.m2",
		["MONK"] = "environments/stars/deathclouds.m2",
		--["DEMONHUNTER"] = "environments/stars/nexusraid_nebulasky.m2",
		--["PALADIN"] = "spells/arcanebreath.m2",
		--["NPCFRIENDLY"] = "spells/spells/cycloneearth_state.m2",
	}
elseif E.Classic or E.TBC or E.Wrath then
	classModels = {
		["PRIEST"] = "spells/snowballpowdery_impact_base.m2",--"spells/snowball_impact_chest.m2", --"spells/christmassnowrain.m2" was strangely removed
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
		if not E.private.ElvUI_EltreumUI or not E.private.ElvUI_EltreumUI.install_version then return end
		local db = E.db.ElvUI_EltreumUI
		if not db or not db.unitframes or not db.unitframes.models or not db.unitframes.UFmodifications then return end
		local modelsDB = db.unitframes.models

		if modelsDB.unitframe then
			local playerbar = _G["ElvUF_Player"]
			local playerAlpha = playerbar and playerbar:GetAlpha() or 1
			if playerbar and not playerbar.EltruismModelAlphaHooked then
				hooksecurefunc(playerbar, "SetAlpha", function(_, alpha)
					local baseAlpha = (E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.models.ufalpha) or E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark or 1
					if playereffect then playereffect:SetAlpha(alpha * baseAlpha) end
					if powerbareffectplayer then powerbareffectplayer:SetAlpha(alpha * (E.Modern and 0.4 or 0.8)) end
					if castbareffectplayer then castbareffectplayer:SetAlpha(alpha) end
				end)
				playerbar.EltruismModelAlphaHooked = true
			end
			if modelsDB.modeltype == "CLASS" then
				--playereffect:ClearModel()
				playereffect:SetModel(classModels[E.myclass])
			elseif modelsDB.modeltype == "CUSTOM" then
				--playereffect:ClearModel()
				if E.Modern then
					playereffect:SetModel(modelsDB.custommodel)
				else
					playereffect:SetModel(modelsDB.custommodelclassic)
				end
			end

			if playerbar then
				playereffect:SetDesaturation(modelsDB.ufdesaturation)
				playereffect:SetParent(playerbar.Health)
				if db.unitframes.lightmode then
					if modelsDB.insideHP then
						playereffect:SetInside(playerbar.Health:GetStatusBarTexture(), 0, 0)
					else
						playereffect:SetInside(playerbar.Health, 0, 0)
					end
					playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel())
					playereffect:SetAlpha(modelsDB.ufalpha * (playerAlpha))
				elseif db.unitframes.darkmode then
					if modelsDB.insideHP then
						playereffect:SetInside(playerbar.Health.bg, 0, 0)
					else
						playereffect:SetInside(playerbar.Health, 0, 0)
					end
					playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel()-1)
					playereffect:SetAlpha(modelsDB.ufalphadark * (playerAlpha))
				end
			end
		end
		if modelsDB.powerbar then
			local powerbar = _G["ElvUF_Player_PowerBar"]
			if modelsDB.modeltypepower == "DEFAULT" then
				if E.Modern then
					powerbareffectplayer:SetModel(1715069)
					powerbareffectplayer:MakeCurrentCameraCustom()
					powerbareffectplayer:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.785)
					powerbareffectplayer:SetPortraitZoom(1)
					powerbareffectplayer:SetAlpha(0.4 * (playerAlpha)) --might do this
				else
					powerbareffectplayer:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectplayer:SetPosition(1.2, 0, -0.5)
					powerbareffectplayer:SetAlpha(0.8 * (playerAlpha)) --might do this
				end
			elseif modelsDB.modeltypepower == "CUSTOM" then
				if E.Modern then
					powerbareffectplayer:SetModel(modelsDB.custommodelpower)
				else
					powerbareffectplayer:SetModel(modelsDB.custommodelclassicpower)
				end
			end

			if powerbar then
				--powerbareffectplayer:SetAlpha(1)
				--powerbareffectplayer:ClearAllPoints()
				--powerbareffectplayer:SetAllPoints(powerbar:GetStatusBarTexture())
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
		if not E.private.ElvUI_EltreumUI or not E.private.ElvUI_EltreumUI.install_version then return end
		local db = E.db.ElvUI_EltreumUI
		if not db or not db.unitframes or not db.unitframes.models or not db.unitframes.UFmodifications then return end
		local modelsDB = db.unitframes.models

		if modelsDB.unitframe then
			local targetbar = _G["ElvUF_Target"]
			local targetAlpha = targetbar and targetbar:GetAlpha() or 1
			if targetbar and not targetbar.EltruismModelAlphaHooked then
				hooksecurefunc(targetbar, "SetAlpha", function(_, alpha)
					local baseAlpha = (E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.models.ufalpha) or E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark or 1
					if targeteffect then targeteffect:SetAlpha(alpha * baseAlpha) end
					if powerbareffecttarget then powerbareffecttarget:SetAlpha(alpha * (E.Modern and 0.4 or 0.8)) end
					if castbareffecttarget then castbareffecttarget:SetAlpha(alpha) end
				end)
				targetbar.EltruismModelAlphaHooked = true
			end
			local reactiontarget = UnitReaction("target", "player")
			local _, targetclass = UnitClass("target")
			if not E:NotSecretValue(targetclass) or not targetclass then
				targetclass = E.myclass
			end
			if modelsDB.modeltype == "CLASS" then
				--targeteffect:ClearModel()
				if (UnitIsPlayer("target") or (E.Retail and UnitInPartyIsAI("target"))) and targetclass then
					targeteffect:SetModel(classModels[targetclass])
				else
					local npcModel
					if reactiontarget and E:NotSecretValue(reactiontarget) then
						if reactiontarget >= 5 then
							npcModel = classModels["NPCFRIENDLY"]
						elseif reactiontarget == 4 then
							npcModel = classModels["NPCNEUTRAL"]
						elseif reactiontarget == 3 then
							npcModel = classModels["NPCUNFRIENDLY"]
						elseif reactiontarget == 2 or reactiontarget == 1 then
							npcModel = classModels["NPCHOSTILE"]
						end
					end
					if not npcModel then
						if (UnitCanAttack and E:NotSecretValue(UnitCanAttack("player", "target")) and UnitCanAttack("player", "target")) or (UnitIsEnemy and E:NotSecretValue(UnitIsEnemy("player", "target")) and UnitIsEnemy("player", "target")) then
							npcModel = classModels["NPCHOSTILE"]
						elseif UnitIsFriend and E:NotSecretValue(UnitIsFriend("player", "target")) and UnitIsFriend("player", "target") then
							npcModel = classModels["NPCFRIENDLY"]
						else
							npcModel = classModels["NPCHOSTILE"]
						end
					end
					if npcModel then
						targeteffect:SetModel(npcModel)
					end
				end
			elseif modelsDB.modeltype == "CUSTOM" then
				--targeteffect:ClearModel()
				if E.Modern then
					targeteffect:SetModel(modelsDB.custommodel)
				else
					targeteffect:SetModel(modelsDB.custommodelclassic)
				end
			end

			if targetbar then
				targeteffect:SetDesaturation(modelsDB.ufdesaturation)
				targeteffect:SetParent(targetbar.Health)
				if db.unitframes.lightmode then
					if modelsDB.insideHP then
						targeteffect:SetInside(targetbar.Health:GetStatusBarTexture(), 0, 0)
					else
						targeteffect:SetInside(targetbar.Health, 0, 0)
					end
					targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel())
					targeteffect:SetAlpha(modelsDB.ufalpha * (targetAlpha))
				elseif db.unitframes.darkmode then
					if modelsDB.insideHP then
						targeteffect:SetInside(targetbar.Health.bg, 0, 0)
					else
						targeteffect:SetInside(targetbar.Health, 0, 0)
					end
					targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel()-1)
					targeteffect:SetAlpha(modelsDB.ufalphadark * (targetAlpha))
				end
				--targeteffect:AddMaskTexture(targetbar.Health:GetStatusBarTexture())
			end
		end

		if modelsDB.powerbar then
			local targetpowerbar = _G["ElvUF_Target_PowerBar"]
			if modelsDB.modeltypepower == "DEFAULT" then
				if E.Modern then
					powerbareffecttarget:SetModel(1715069)
					powerbareffecttarget:MakeCurrentCameraCustom()
					powerbareffecttarget:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffecttarget:SetPortraitZoom(1)
					powerbareffecttarget:SetAlpha(0.4 * (targetAlpha)) --might do this
				else
					powerbareffecttarget:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffecttarget:SetPosition(1.2, 0, -0.5)
					powerbareffecttarget:SetAlpha(0.8 * (targetAlpha)) --might do this
				end
			elseif modelsDB.modeltypepower == "CUSTOM" then
				if E.Modern then
					powerbareffecttarget:SetModel(modelsDB.custommodelpower)
				else
					powerbareffecttarget:SetModel(modelsDB.custommodelclassicpower)
				end
			end
			if targetpowerbar then
				--powerbareffecttarget:SetAlpha(1)
				--powerbareffecttarget:ClearAllPoints()
				--powerbareffecttarget:SetAllPoints(targetpowerbar:GetStatusBarTexture())
				powerbareffecttarget:SetFrameLevel(targetpowerbar:GetFrameLevel())
				powerbareffecttarget:SetInside(targetpowerbar:GetStatusBarTexture(), 0, 0)
				powerbareffecttarget:SetParent(targetpowerbar)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_TargetFrame", ElvUI_EltreumUI.TargetUFEffects)
hooksecurefunc(UF, "Update_TargetFrame", ElvUI_EltreumUI.TargetUFEffects)

--add effects to target of target
function ElvUI_EltreumUI:TargetTargetUFEffects()
	if E.private.unitframe.enable then
		if not E.private.ElvUI_EltreumUI or not E.private.ElvUI_EltreumUI.install_version then return end
		local db = E.db.ElvUI_EltreumUI
		if not db or not db.unitframes or not db.unitframes.models or not db.unitframes.UFmodifications then return end
		local modelsDB = db.unitframes.models

		if modelsDB.unitframe then
			local targettargetbar = _G["ElvUF_TargetTarget"]
			local targettargetAlpha = targettargetbar and targettargetbar:GetAlpha() or 1
			if targettargetbar and not targettargetbar.EltruismModelAlphaHooked then
				hooksecurefunc(targettargetbar, "SetAlpha", function(_, alpha)
					local baseAlpha = (E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.models.ufalpha) or E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark or 1
					if targettargeteffect then targettargeteffect:SetAlpha(alpha * baseAlpha) end
					if powerbareffecttargettarget then powerbareffecttargettarget:SetAlpha(alpha * (E.Modern and 0.4 or 0.8)) end
				end)
				targettargetbar.EltruismModelAlphaHooked = true
			end
			local reactiontargettarget = UnitReaction("targettarget", "player")
			local _, targettargetclass = UnitClass("targettarget")
			if not E:NotSecretValue(targettargetclass) or not targettargetclass then
				targettargetclass = E.myclass
			end

			if modelsDB.modeltype == "CLASS" then
				if (UnitIsPlayer("targettarget") or (E.Retail and UnitInPartyIsAI("targettarget"))) and targettargetclass then
					targettargeteffect:SetModel(classModels[targettargetclass])
				else
					local npcModel
					if reactiontargettarget and E:NotSecretValue(reactiontargettarget) then
						if reactiontargettarget >= 5 then
							npcModel = classModels["NPCFRIENDLY"]
						elseif reactiontargettarget == 4 then
							npcModel = classModels["NPCNEUTRAL"]
						elseif reactiontargettarget == 3 then
							npcModel = classModels["NPCUNFRIENDLY"]
						elseif reactiontargettarget == 2 or reactiontargettarget == 1 then
							npcModel = classModels["NPCHOSTILE"]
						end
					end
					if not npcModel then
						if (UnitCanAttack and E:NotSecretValue(UnitCanAttack("player", "targettarget")) and UnitCanAttack("player", "targettarget")) or (UnitIsEnemy and E:NotSecretValue(UnitIsEnemy("player", "targettarget")) and UnitIsEnemy("player", "targettarget")) then
							npcModel = classModels["NPCHOSTILE"]
						elseif UnitIsFriend and E:NotSecretValue(UnitIsFriend("player", "targettarget")) and UnitIsFriend("player", "targettarget") then
							npcModel = classModels["NPCFRIENDLY"]
						else
							npcModel = classModels["NPCHOSTILE"]
						end
					end
					if npcModel then
						targettargeteffect:SetModel(npcModel)
					end
				end
			elseif modelsDB.modeltype == "CUSTOM" then
				if E.Modern then
					targettargeteffect:SetModel(modelsDB.custommodel)
				else
					targettargeteffect:SetModel(modelsDB.custommodelclassic)
				end
			end

			if targettargetbar then
				targettargeteffect:SetDesaturation(modelsDB.ufdesaturation)
				targettargeteffect:SetParent(targettargetbar.Health)
				if db.unitframes.lightmode then
					if modelsDB.insideHP then
						targettargeteffect:SetInside(targettargetbar.Health:GetStatusBarTexture(), 0, 0)
					else
						targettargeteffect:SetInside(targettargetbar.Health, 0, 0)
					end
					targettargeteffect:SetFrameLevel(targettargetbar.Health:GetFrameLevel())
					targettargeteffect:SetAlpha(modelsDB.ufalpha * (targettargetAlpha))
				elseif db.unitframes.darkmode then
					if modelsDB.insideHP then
						targettargeteffect:SetInside(targettargetbar.Health.bg, 0, 0)
					else
						targettargeteffect:SetInside(targettargetbar.Health, 0, 0)
					end
					targettargeteffect:SetFrameLevel(targettargetbar.Health:GetFrameLevel()-1)
					targettargeteffect:SetAlpha(modelsDB.ufalphadark * (targettargetAlpha))
				end
			end
		end

		if modelsDB.powerbar then
			local targettargetpowerbar = _G["ElvUF_TargetTarget_PowerBar"]
			if modelsDB.modeltypepower == "DEFAULT" then
				if E.Modern then
					powerbareffecttargettarget:SetModel(1715069)
					powerbareffecttargettarget:MakeCurrentCameraCustom()
					powerbareffecttargettarget:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffecttargettarget:SetPortraitZoom(1)
					powerbareffecttargettarget:SetAlpha(0.4 * (targettargetAlpha)) --might do this
				else
					powerbareffecttargettarget:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffecttargettarget:SetPosition(1.2, 0, -0.5)
					powerbareffecttargettarget:SetAlpha(0.8 * (targettargetAlpha)) --might do this
				end
			elseif modelsDB.modeltypepower == "CUSTOM" then
				if E.Modern then
					powerbareffecttargettarget:SetModel(modelsDB.custommodelpower)
				else
					powerbareffecttargettarget:SetModel(modelsDB.custommodelclassicpower)
				end
			end

			if targettargetpowerbar then
				--powerbareffecttargettarget:SetAlpha(1)
				--powerbareffecttargettarget:ClearAllPoints()
				--powerbareffecttargettarget:SetAllPoints(targettargetpowerbar:GetStatusBarTexture())
				powerbareffecttargettarget:SetFrameLevel(targettargetpowerbar:GetFrameLevel())
				powerbareffecttargettarget:SetInside(targettargetpowerbar:GetStatusBarTexture(), 0, 0)
				powerbareffecttargettarget:SetParent(targettargetpowerbar)
			end
		end
	end
end
hooksecurefunc(UF, "Construct_TargetTargetFrame", ElvUI_EltreumUI.TargetTargetUFEffects)
hooksecurefunc(UF, "Update_TargetTargetFrame", ElvUI_EltreumUI.TargetTargetUFEffects)

--add effects to focus
function ElvUI_EltreumUI:FocusUFEffects()
	if E.private.unitframe.enable then
		if not E.private.ElvUI_EltreumUI or not E.private.ElvUI_EltreumUI.install_version then return end
		local db = E.db.ElvUI_EltreumUI
		if not db or not db.unitframes or not db.unitframes.models or not db.unitframes.UFmodifications or E.Classic then return end
		local modelsDB = db.unitframes.models

		if modelsDB.unitframe then
			local focusbar = _G["ElvUF_Focus"]
			local focusAlpha = focusbar and focusbar:GetAlpha() or 1
			if focusbar and not focusbar.EltruismModelAlphaHooked then
				hooksecurefunc(focusbar, "SetAlpha", function(_, alpha)
					local baseAlpha = (E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.models.ufalpha) or E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark or 1
					if focuseffect then focuseffect:SetAlpha(alpha * baseAlpha) end
					if powerbareffectfocus then powerbareffectfocus:SetAlpha(alpha * (E.Modern and 0.4 or 0.8)) end
				end)
				focusbar.EltruismModelAlphaHooked = true
			end
			local reactionfocus = UnitReaction("focus", "player")
			local _, focusclass = UnitClass("focus")
			if not E:NotSecretValue(focusclass) or not focusclass then
				focusclass = E.myclass
			end

			if modelsDB.modeltype == "CLASS" then
				--focuseffect:ClearModel()
				if (UnitIsPlayer("focus") or (E.Retail and UnitInPartyIsAI("focus"))) and focusclass then
					focuseffect:SetModel(classModels[focusclass])
				else
					local npcModel
					if reactionfocus and E:NotSecretValue(reactionfocus) then
						if reactionfocus >= 5 then
							npcModel = classModels["NPCFRIENDLY"]
						elseif reactionfocus == 4 then
							npcModel = classModels["NPCNEUTRAL"]
						elseif reactionfocus == 3 then
							npcModel = classModels["NPCUNFRIENDLY"]
						elseif reactionfocus == 2 or reactionfocus == 1 then
							npcModel = classModels["NPCHOSTILE"]
						end
					end
					if not npcModel then
						if (UnitCanAttack and E:NotSecretValue(UnitCanAttack("player", "focus")) and UnitCanAttack("player", "focus")) or (UnitIsEnemy and E:NotSecretValue(UnitIsEnemy("player", "focus")) and UnitIsEnemy("player", "focus")) then
							npcModel = classModels["NPCHOSTILE"]
						elseif UnitIsFriend and E:NotSecretValue(UnitIsFriend("player", "focus")) and UnitIsFriend("player", "focus") then
							npcModel = classModels["NPCFRIENDLY"]
						else
							npcModel = classModels["NPCHOSTILE"]
						end
					end
					if npcModel then
						focuseffect:SetModel(npcModel)
					end
				end
			elseif modelsDB.modeltype == "CUSTOM" then
				--focuseffect:ClearModel()
				if E.Modern then
					focuseffect:SetModel(modelsDB.custommodel)
				else
					focuseffect:SetModel(modelsDB.custommodelclassic)
				end
			end

			if focusbar then
				focuseffect:SetDesaturation(modelsDB.ufdesaturation)
				focuseffect:SetParent(focusbar.Health)
				if db.unitframes.lightmode then
					if modelsDB.insideHP then
						focuseffect:SetInside(focusbar.Health:GetStatusBarTexture(), 0, 0)
					else
						focuseffect:SetInside(focusbar.Health, 0, 0)
					end
					focuseffect:SetFrameLevel(focusbar.Health:GetFrameLevel())
					focuseffect:SetAlpha(modelsDB.ufalpha * (focusAlpha))
				elseif db.unitframes.darkmode then
					if modelsDB.insideHP then
						focuseffect:SetInside(focusbar.Health.bg, 0, 0)
					else
						focuseffect:SetInside(focusbar.Health, 0, 0)
					end
					focuseffect:SetFrameLevel(focusbar.Health:GetFrameLevel()-1)
					focuseffect:SetAlpha(modelsDB.ufalphadark * (focusAlpha))
				end
			end
		end

		if modelsDB.powerbar then
			local focuspowerbar = _G["ElvUF_Focus_PowerBar"]
			if modelsDB.modeltypepower == "DEFAULT" then
				if E.Modern then
					powerbareffectfocus:SetModel(1715069)
					powerbareffectfocus:MakeCurrentCameraCustom()
					powerbareffectfocus:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffectfocus:SetPortraitZoom(1)
					powerbareffectfocus:SetAlpha(0.4 * (focusAlpha)) --might do this
				else
					powerbareffectfocus:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectfocus:SetPosition(1.2, 0, -0.5)
					powerbareffectfocus:SetAlpha(0.8 * (focusAlpha)) --might do this
				end
			elseif modelsDB.modeltypepower == "CUSTOM" then
				if E.Modern then
					powerbareffectfocus:SetModel(modelsDB.custommodelpower)
				else
					powerbareffectfocus:SetModel(modelsDB.custommodelclassicpower)
				end
			end
			if focuspowerbar then
				--powerbareffectfocus:SetAlpha(1)
				--powerbareffectfocus:ClearAllPoints()
				--powerbareffectfocus:SetAllPoints(focuspowerbar:GetStatusBarTexture())
				powerbareffectfocus:SetFrameLevel(focuspowerbar:GetFrameLevel())
				powerbareffectfocus:SetInside(focuspowerbar:GetStatusBarTexture(), 0, 0)
				powerbareffectfocus:SetParent(focuspowerbar)
			end
		end
	end
end
if E.Modern or E.Mists or E.TBC or E.Wrath then
	hooksecurefunc(UF, "Construct_FocusFrame", ElvUI_EltreumUI.FocusUFEffects)
	hooksecurefunc(UF, "Update_FocusFrame", ElvUI_EltreumUI.FocusUFEffects)
end

--add effects to pet
function ElvUI_EltreumUI:PetUFEffects()
	if E.private.unitframe.enable then
		if not E.private.ElvUI_EltreumUI or not E.private.ElvUI_EltreumUI.install_version then return end
		local db = E.db.ElvUI_EltreumUI
		if not db or not db.unitframes or not db.unitframes.models or not db.unitframes.UFmodifications then return end
		local modelsDB = db.unitframes.models

		if modelsDB.unitframe then
			local petbar = _G["ElvUF_Pet"]
			local petAlpha = petbar and petbar:GetAlpha() or 1
			if petbar and not petbar.EltruismModelAlphaHooked then
				hooksecurefunc(petbar, "SetAlpha", function(_, alpha)
					local baseAlpha = (E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.models.ufalpha) or E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark or 1
					if peteffect then peteffect:SetAlpha(alpha * baseAlpha) end
					if powerbareffectpet then powerbareffectpet:SetAlpha(alpha * (E.Modern and 0.8 or 0.6)) end
				end)
				petbar.EltruismModelAlphaHooked = true
			end
			local reactionpet = UnitReaction("pet", "player")

			if modelsDB.modeltype == "CLASS" then
				--peteffect:ClearModel()
				if reactionpet then
					if reactionpet >= 5 then
						peteffect:SetModel(classModels["NPCFRIENDLY"])
					elseif reactionpet == 4 then
						peteffect:SetModel(classModels["NPCNEUTRAL"])
					elseif reactionpet == 3 then
						peteffect:SetModel(classModels["NPCUNFRIENDLY"])
					elseif reactionpet == 2 or reactionpet == 1 then
						peteffect:SetModel(classModels["NPCHOSTILE"])
					end
				end
			elseif modelsDB.modeltype == "CUSTOM" then
				--peteffect:ClearModel()
				if E.Modern then
					peteffect:SetModel(modelsDB.custommodel)
				else
					peteffect:SetModel(modelsDB.custommodelclassic)
				end
			end

			if petbar then
				peteffect:SetDesaturation(modelsDB.ufdesaturation)
				peteffect:SetParent(petbar.Health)
				if db.unitframes.lightmode then
					if modelsDB.insideHP then
						peteffect:SetInside(petbar.Health:GetStatusBarTexture(), 0, 0)
					else
						peteffect:SetInside(petbar.Health, 0, 0)
					end
					peteffect:SetFrameLevel(petbar.Health:GetFrameLevel())
					peteffect:SetAlpha(modelsDB.ufalpha * (petAlpha))
				elseif db.unitframes.darkmode then
					if modelsDB.insideHP then
						peteffect:SetInside(petbar.Health.bg, 0, 0)
					else
						peteffect:SetInside(petbar.Health, 0, 0)
					end
					peteffect:SetFrameLevel(petbar.Health:GetFrameLevel()-1)
					peteffect:SetAlpha(modelsDB.ufalphadark * (petAlpha))
				end

			end
		end
		if modelsDB.powerbar then
			local petpowerbar = _G["ElvUF_Pet_PowerBar"]
			if modelsDB.modeltypepower == "DEFAULT" then
				if E.Modern then
					powerbareffectpet:SetModel(1715069)
					powerbareffectpet:MakeCurrentCameraCustom()
					powerbareffectpet:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffectpet:SetPortraitZoom(1)
					powerbareffectpet:SetAlpha(0.8 * (petAlpha)) --might do this
				else
					powerbareffectpet:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectpet:SetPosition(1.2, 0, -0.5)
					powerbareffectpet:SetAlpha(0.6 * (petAlpha)) --might do this
				end
			elseif modelsDB.modeltypepower == "CUSTOM" then
				if E.Modern then
					powerbareffectpet:SetModel(modelsDB.custommodelpower)
				else
					powerbareffectpet:SetModel(modelsDB.custommodelclassicpower)
				end
			end
			if petpowerbar then
				--powerbareffectpet:ClearAllPoints()
				--powerbareffectpet:SetAllPoints(petpowerbar:GetStatusBarTexture())
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
local castbar
local targetcastbar

--add effect to castbar
function ElvUI_EltreumUI:CastbarEffects()
	if E.private.unitframe.enable then
		if not E.private.ElvUI_EltreumUI or not E.private.ElvUI_EltreumUI.install_version then return end
		local db = E.db.ElvUI_EltreumUI
		if not db or not db.unitframes or not db.unitframes.models or not db.unitframes.UFmodifications then return end
		local modelsDB = db.unitframes.models

		if modelsDB.castbar then
			castbar = _G["ElvUF_Player_CastBar"]
			targetcastbar = _G["ElvUF_Target_CastBar"]

			if modelsDB.modeltypecast == "DEFAULT" then
				if E.Modern then
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
			elseif modelsDB.modeltypecast == "CUSTOM" then
				if E.Modern then
					castbareffectplayer:SetModel(modelsDB.custommodelcast)
					castbareffecttarget:SetModel(modelsDB.custommodelcast)
				else
					castbareffectplayer:SetModel(modelsDB.custommodelclassiccast)
					castbareffecttarget:SetModel(modelsDB.custommodelclassiccast)
				end
			end

			if castbar then
				castbareffectplayer:SetAlpha(1)
				--castbareffectplayer:SetAllPoints(castbar:GetStatusBarTexture())
				castbareffectplayer:SetFrameLevel(castbar:GetFrameLevel())
				castbareffectplayer:SetInside(castbar:GetStatusBarTexture(), 0, 0)
				castbareffectplayer:SetParent(castbar)
			end

			if targetcastbar then
				castbareffecttarget:SetAlpha(1)
				--castbareffecttarget:ClearAllPoints()
				--castbareffecttarget:SetAllPoints(targetcastbar:GetStatusBarTexture())
				castbareffecttarget:SetFrameLevel(targetcastbar:GetFrameLevel())
				castbareffecttarget:SetInside(targetcastbar:GetStatusBarTexture(), 0, 0)
				castbareffecttarget:SetParent(targetcastbar)
			end
		end
	end
end
hooksecurefunc(UF, 'Construct_Castbar', ElvUI_EltreumUI.CastbarEffects)
hooksecurefunc(UF, 'PostCastStart', ElvUI_EltreumUI.CastbarEffects)

local modelupdater = CreateFrame("FRAME")
modelupdater:RegisterUnitEvent("UNIT_TARGET", "target") --update whenever the target changes target
modelupdater:RegisterUnitEvent("UNIT_PET", "player") --refresh everything
modelupdater:RegisterEvent("PLAYER_FOCUS_CHANGED")
modelupdater:RegisterEvent("PLAYER_ENTERING_WORLD") --refresh everything
modelupdater:RegisterEvent("PLAYER_REGEN_DISABLED")
modelupdater:RegisterUnitEvent("PLAYER_FLAGS_CHANGED", "player") --refresh everything
modelupdater:RegisterEvent("CINEMATIC_STOP") --cinematic might've caused it, so refresh everything
modelupdater:SetScript("OnEvent", function(_, event)
	ElvUI_EltreumUI:TargetTargetUFEffects()
	ElvUI_EltreumUI:FocusUFEffects()
	if E.Modern then --forever seems to have the bug too, but it always returns isvisible true and alpha 1 for power bar
		if event == 'PLAYER_ENTERING_WORLD' or event == "PLAYER_FLAGS_CHANGED" or event == "CINEMATIC_STOP" or event == "PLAYER_REGEN_DISABLED" then
			if _G["ElvUF_Player"] and _G["ElvUF_Player"]:GetAlpha() ~= 0 then
				ElvUI_EltreumUI:PlayerUFEffects()
			end
			ElvUI_EltreumUI:TargetUFEffects()
			if _G["ElvUF_Pet"] and _G["ElvUF_Pet"]:GetAlpha() ~= 0 then
				ElvUI_EltreumUI:PetUFEffects()
			end
			ElvUI_EltreumUI:CastbarEffects()
		end
		if event == "UNIT_PET" then
			if _G["ElvUF_Pet"] and _G["ElvUF_Pet"]:GetAlpha() ~= 0 then
				ElvUI_EltreumUI:PetUFEffects()
			end
		end
	else
		if event == 'PLAYER_ENTERING_WORLD' or event == "PLAYER_FLAGS_CHANGED" or event == "CINEMATIC_STOP" then
			ElvUI_EltreumUI:PlayerUFEffects()
			ElvUI_EltreumUI:TargetUFEffects()
			ElvUI_EltreumUI:PetUFEffects()
			ElvUI_EltreumUI:CastbarEffects()
		end
		if event == "UNIT_PET" then
			ElvUI_EltreumUI:PetUFEffects()
		end
	end
end)
