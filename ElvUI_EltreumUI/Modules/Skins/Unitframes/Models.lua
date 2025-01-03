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
local powerbar, targetpowerbar, targettargetpowerbar, petpowerbar
local _, targetclass, targettargetbar, playerbar,targetbar, reactiontarget,reactionpet
local reactiontargettarget, targettargetclass, petbar
local focuspowerbar, focusbar, focusclass,reactionfocus
local CreateVector3D = _G.CreateVector3D
local rad = _G.rad
local UnitReaction = _G.UnitReaction
local UnitInPartyIsAI = _G.UnitInPartyIsAI

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
	["MONK"] = 3513377,
	["NPCFRIENDLY"] = 1726751,
	["NPCUNFRIENDLY"] = 1965208,
	["NPCHOSTILE"] = 235284,
	["NPCNEUTRAL"] = 1306105,
	["EVOKER"] = 130525,
	---130623 --shadowmoon tbc w/ meteors
	--130551, --icecrown very very blue
	--130525, --hellfire
	--4234796 smoky stormwind
	--937003 fire
}
if E.Cata then
	classModels = {
		["MAGE"] = "environments/stars/nexusraid_runeeffects_starry.m2",
		["PALADIN"] = "environments/stars/netherstormskybox.m2", --spells/dragonbreath_arcane.m2
		["HUNTER"] = "environments/stars/hellfireskybox.m2",
		["SHAMAN"] = "environments/stars/icecrownsky.m2",
		["PRIEST"] = "spells/christmassnowrain.m2",
		["DEATHKNIGHT"] = "spells/nefarianflamebreath.m2", --"spells/redradiationfog.m2", --"spells/frostbreath.m2", --world/generic/passivedoodads/particleemitters/aurared.m2 , "environments/stars/bladesedgeskybox.m2"
		["WARRIOR"] = "spells/flamebreath.m2", --spells/disarm_impact_chest.m2
		["ROGUE"] = "environments/stars/shadowmoonillidan.m2",
		["WARLOCK"] = "environments/stars/nagrandskybox.m2",
		["DRUID"] = "spells/cyclonefire_state.m2",
		["NPCNEUTRAL"] = "spells/acidliquidbreath.m2",
		["NPCFRIENDLY"] = "environments/stars/portalworldlegionsky.m2",
		["NPCUNFRIENDLY"] = "spells/flamebreath.m2", --spells/darkritual_precast_base.m2",
		["NPCHOSTILE"] = "spells/deathanddecay_area_base.m2",
		--["DEMONHUNTER"] = "environments/stars/nexusraid_nebulasky.m2",
		--["PALADIN"] = "spells/arcanebreath.m2",
		--["NPCFRIENDLY"] = "spells/spells/cycloneearth_state.m2",
	}
elseif E.Classic then
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
		if not E.private.ElvUI_EltreumUI then
			return
		elseif not E.private.ElvUI_EltreumUI.install_version then
			return
		elseif not E.db.ElvUI_EltreumUI then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.models then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
			return
		end
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
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						playereffect:SetInside(playerbar.Health:GetStatusBarTexture(), 0, 0)
					else
						playereffect:SetInside(playerbar.Health, 0, 0)
					end
					playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel())
					playereffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						playereffect:SetInside(playerbar.Health.bg, 0, 0)
					else
						playereffect:SetInside(playerbar.Health, 0, 0)
					end
					playereffect:SetFrameLevel(playerbar.Health:GetFrameLevel()-1)
					playereffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			powerbar = _G["ElvUF_Player_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffectplayer:SetModel(1715069)
					powerbareffectplayer:MakeCurrentCameraCustom()
					powerbareffectplayer:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.785)
					powerbareffectplayer:SetPortraitZoom(1)
					powerbareffectplayer:SetAlpha(0.4) --might do this
				else
					powerbareffectplayer:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectplayer:SetPosition(1.2, 0, -0.5)
					powerbareffectplayer:SetAlpha(0.8) --might do this
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
		if not E.private.ElvUI_EltreumUI then
			return
		elseif not E.private.ElvUI_EltreumUI.install_version then
			return
		elseif not E.db.ElvUI_EltreumUI then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.models then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
			return
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			targetbar = _G["ElvUF_Target"]
			reactiontarget = UnitReaction("target", "player")
			_, targetclass = UnitClass("target")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				--targeteffect:ClearModel()
				if (UnitIsPlayer("target") or (E.Retail and UnitInPartyIsAI("target"))) and targetclass then
					targeteffect:SetModel(classModels[targetclass])
				else
					if reactiontarget then
						if reactiontarget >= 5 then
							targeteffect:SetModel(classModels["NPCFRIENDLY"])
						elseif reactiontarget == 4 then
							targeteffect:SetModel(classModels["NPCNEUTRAL"])
						elseif reactiontarget == 3 then
							targeteffect:SetModel(classModels["NPCUNFRIENDLY"])
						elseif reactiontarget == 2 or reactiontarget == 1 then
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
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						targeteffect:SetInside(targetbar.Health:GetStatusBarTexture(), 0, 0)
					else
						targeteffect:SetInside(targetbar.Health, 0, 0)
					end
					targeteffect:SetFrameLevel(targetbar.Health:GetFrameLevel())
					targeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						targeteffect:SetInside(targetbar.Health.bg, 0, 0)
					else
						targeteffect:SetInside(targetbar.Health, 0, 0)
					end
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
					powerbareffecttarget:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffecttarget:SetPortraitZoom(1)
					powerbareffecttarget:SetAlpha(0.4) --might do this
				else
					powerbareffecttarget:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffecttarget:SetPosition(1.2, 0, -0.5)
					powerbareffecttarget:SetAlpha(0.8) --might do this
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
		if not E.private.ElvUI_EltreumUI then
			return
		elseif not E.private.ElvUI_EltreumUI.install_version then
			return
		elseif not E.db.ElvUI_EltreumUI then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.models then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
			return
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			targettargetbar = _G["ElvUF_TargetTarget"]
			reactiontargettarget = UnitReaction("targettarget", "player")
			_, targettargetclass = UnitClass("targettarget")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				if (UnitIsPlayer("targettarget") or (E.Retail and UnitInPartyIsAI("targettarget"))) and targettargetclass then
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
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						targettargeteffect:SetInside(targettargetbar.Health:GetStatusBarTexture(), 0, 0)
					else
						targettargeteffect:SetInside(targettargetbar.Health, 0, 0)
					end
					targettargeteffect:SetFrameLevel(targettargetbar.Health:GetFrameLevel())
					targettargeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						targettargeteffect:SetInside(targettargetbar.Health.bg, 0, 0)
					else
						targettargeteffect:SetInside(targettargetbar.Health, 0, 0)
					end
					targettargeteffect:SetFrameLevel(targettargetbar.Health:GetFrameLevel()-1)
					targettargeteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
			end
		end

		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			targettargetpowerbar = _G["ElvUF_TargetTarget_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffecttargettarget:SetModel(1715069)
					powerbareffecttargettarget:MakeCurrentCameraCustom()
					powerbareffecttargettarget:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffecttargettarget:SetPortraitZoom(1)
					powerbareffecttargettarget:SetAlpha(0.4) --might do this
				else
					powerbareffecttargettarget:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffecttargettarget:SetPosition(1.2, 0, -0.5)
					powerbareffecttargettarget:SetAlpha(0.8) --might do this
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
		if not E.private.ElvUI_EltreumUI then
			return
		elseif not E.private.ElvUI_EltreumUI.install_version then
			return
		elseif not E.db.ElvUI_EltreumUI then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.models then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
			return
		elseif E.Classic then
			return
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			focusbar = _G["ElvUF_Focus"]
			reactionfocus = UnitReaction("focus", "player")
			_, focusclass = UnitClass("focus")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
				--focuseffect:ClearModel()
				if (UnitIsPlayer("focus") or (E.Retail and UnitInPartyIsAI("focus"))) and focusclass then
					focuseffect:SetModel(classModels[focusclass])
				else
					if reactionfocus then
						if reactionfocus >= 5 then
							focuseffect:SetModel(classModels["NPCFRIENDLY"])
						elseif reactionfocus == 4 then
							focuseffect:SetModel(classModels["NPCNEUTRAL"])
						elseif reactionfocus == 3 then
							focuseffect:SetModel(classModels["NPCUNFRIENDLY"])
						elseif reactionfocus == 2 or reactionfocus == 1 then
							focuseffect:SetModel(classModels["NPCHOSTILE"])
						end
					end
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CUSTOM" then
				--focuseffect:ClearModel()
				if E.Retail then
					focuseffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodel)
				else
					focuseffect:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic)
				end
			end

			if focusbar then
				focuseffect:SetDesaturation(E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation)
				focuseffect:SetParent(focusbar.Health)
				if E.db.ElvUI_EltreumUI.unitframes.lightmode then
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						focuseffect:SetInside(focusbar.Health:GetStatusBarTexture(), 0, 0)
					else
						focuseffect:SetInside(focusbar.Health, 0, 0)
					end
					focuseffect:SetFrameLevel(focusbar.Health:GetFrameLevel())
					focuseffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						focuseffect:SetInside(focusbar.Health.bg, 0, 0)
					else
						focuseffect:SetInside(focusbar.Health, 0, 0)
					end
					focuseffect:SetFrameLevel(focusbar.Health:GetFrameLevel()-1)
					focuseffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end
			end
		end

		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			focuspowerbar = _G["ElvUF_Focus_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffectfocus:SetModel(1715069)
					powerbareffectfocus:MakeCurrentCameraCustom()
					powerbareffectfocus:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffectfocus:SetPortraitZoom(1)
					powerbareffectfocus:SetAlpha(0.4) --might do this
				else
					powerbareffectfocus:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectfocus:SetPosition(1.2, 0, -0.5)
					powerbareffectfocus:SetAlpha(0.8) --might do this
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
				if E.Retail then
					powerbareffectfocus:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
				else
					powerbareffectfocus:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
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
if E.Retail or E.Cata then
	hooksecurefunc(UF, "Construct_FocusFrame", ElvUI_EltreumUI.FocusUFEffects)
	hooksecurefunc(UF, "Update_FocusFrame", ElvUI_EltreumUI.FocusUFEffects)
end

--add effects to pet
function ElvUI_EltreumUI:PetUFEffects()
	if E.private.unitframe.enable then
		if not E.private.ElvUI_EltreumUI then
			return
		elseif not E.private.ElvUI_EltreumUI.install_version then
			return
		elseif not E.db.ElvUI_EltreumUI then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.models then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
			return
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.unitframe then
			petbar = _G["ElvUF_Pet"]
			reactionpet = UnitReaction("pet", "player")

			if E.db.ElvUI_EltreumUI.unitframes.models.modeltype == "CLASS" then
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
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						peteffect:SetInside(petbar.Health:GetStatusBarTexture(), 0, 0)
					else
						peteffect:SetInside(petbar.Health, 0, 0)
					end
					peteffect:SetFrameLevel(petbar.Health:GetFrameLevel())
					peteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
				elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
					if E.db.ElvUI_EltreumUI.unitframes.models.insideHP then
						peteffect:SetInside(petbar.Health.bg, 0, 0)
					else
						peteffect:SetInside(petbar.Health, 0, 0)
					end
					peteffect:SetFrameLevel(petbar.Health:GetFrameLevel()-1)
					peteffect:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
				end

			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.models.powerbar then
			petpowerbar = _G["ElvUF_Pet_PowerBar"]
			if E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" then
				if E.Retail then
					powerbareffectpet:SetModel(1715069)
					powerbareffectpet:MakeCurrentCameraCustom()
					powerbareffectpet:SetTransform(CreateVector3D(-0.035, 0, 0), CreateVector3D(rad(270), 0, 0), 0.585)
					powerbareffectpet:SetPortraitZoom(1)
					powerbareffectpet:SetAlpha(0.8) --might do this
				else
					powerbareffectpet:SetModel("spells/arcanepower_state_chest.m2")
					powerbareffectpet:SetPosition(1.2, 0, -0.5)
					powerbareffectpet:SetAlpha(0.6) --might do this
				end
			elseif E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "CUSTOM" then
				if E.Retail then
					powerbareffectpet:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower)
				else
					powerbareffectpet:SetModel(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower)
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
local castbareffectplayer = CreateFrame("PlayerModel", "EltruismPlayerCastBarEffect")
local castbareffecttarget = CreateFrame("PlayerModel", "EltruismTargetCastBarEffect")
local castbar
local targetcastbar

--add effect to castbar
function ElvUI_EltreumUI:CastbarEffects()
	if E.private.unitframe.enable then
		if not E.private.ElvUI_EltreumUI then
			return
		elseif not E.private.ElvUI_EltreumUI.install_version then
			return
		elseif not E.db.ElvUI_EltreumUI then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.models then
			return
		elseif not E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
			return
		end
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
	if E.Retail then
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
