local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local LCG = E.Libs.CustomGlow
local classcolor = E:ClassColor(E.myclass, true)

-- Different Debuffs/Buffs on nameplates
local ONUPDATE_INTERVAL = 0.1
function ElvUI_EltreumUI:PostUpdateIconDebuff(unit, button)
	if E.private.nameplates.enable == true then

		local glowcolor
		if E.db.ElvUI_EltreumUI.glow.colorclass then
			glowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
		else
			glowcolor = {E.db.ElvUI_EltreumUI.glowcustomcolornp.r, E.db.ElvUI_EltreumUI.glowcustomcolornp.g, E.db.ElvUI_EltreumUI.glowcustomcolornp.b, 1}
		end

		if E.db.ElvUI_EltreumUI.widenameplate.enable or E.db.ElvUI_EltreumUI.widenameplate.npglow then
			--changing the texture and the size will likely not be needed in 12.38, but the cooldown will be
			if button and button.spellID then
				if not string.find(unit, "nameplate") then
					return
				else
					if E.Classic or E.TBC then
						if E.db.ElvUI_EltreumUI.widenameplate.enable then
							button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
						end
					end
					button.cd:SetFrameStrata('DIALOG')
					--button.cd:SetDrawSwipe(false) --works to erase it
					local TimeSinceLastUpdate = 0
					if not button.cd then
						LCG.PixelGlow_Stop(button)
					else
						button.cd:SetScript('OnUpdate', function(self, elapsed)
							TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
							if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
								TimeSinceLastUpdate = 0
								--print("np button spam "..math.random(1,99))
								if button.cd.timer then
									if E.db.ElvUI_EltreumUI.widenameplate.enable then
										button.cd.timer.text:ClearAllPoints()
										button.cd.timer.text:Point("TOP", button.icon, "TOP", 0, 5)
									end
									local _, g, b, a = button.cd.timer.text:GetTextColor()
									if E.db.ElvUI_EltreumUI.widenameplate.npglow then
										if (g == 0 or b == 0) and a > 0.5 and button.cd.timer.text then
											LCG.PixelGlow_Start(button, glowcolor, 6, 0.8, 4, 2, 1, 1, false, nil)
										else
											LCG.PixelGlow_Stop(button)
										end
									end
								else
									if E.db.ElvUI_EltreumUI.widenameplate.npglow and (button.cd == nil or button.cd.timer == nil)then
										LCG.PixelGlow_Stop(button)
									end
								end
							end
						end)
					end
					--[[if E.Classic or E.TBC then
						if E.db.ElvUI_EltreumUI.widenameplate.enable then
							button:SetWidth(25)
							button:SetHeight(18)
						end
					end]]
					button.count:SetParent(button.cd)
					if E.TBC or E.Classic then
						if E.db.ElvUI_EltreumUI.widenameplate.enable then
							button.count:Point('BOTTOMRIGHT', 2, -3) --elvui added a setting for it but its missing some things
						end
					end
				end
			end
			UF.PostUpdateAura(self, unit, button)
		end
	end
end

function ElvUI_EltreumUI:PostUpdateIconBuff(unit, button)
	if E.private.nameplates.enable == true then
		if E.db.ElvUI_EltreumUI.widenameplate.enable then
			if button and button.spellID then
				if not string.find(unit, "nameplate") then
					--print("np button buff nil "..math.random(1,99))
					--button.cd:SetScript('OnUpdate', nil)
					return
				else
					if E.Classic or E.TBC then
						button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
					end
					local TimeSinceLastUpdate = 0
					--print("np button buff spam "..math.random(1,99))
					button.cd:SetScript('OnUpdate', function(self, elapsed)
					TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
						if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
							TimeSinceLastUpdate = 0
							if button.cd.timer then
								button.cd.timer.text:ClearAllPoints()
								button.cd.timer.text:SetDrawLayer('OVERLAY',1)
								button.cd.timer.text:Point("TOP", button.icon, "TOP", 0, 5)
							end
						end
					end)
					if E.Classic or E.TBC then
						button:SetWidth(25)
						button:SetHeight(18)
					end
					button.count:SetParent(button.cd)
					button.count:Point('BOTTOMRIGHT', 2, -3)
				end
			end
			UF.PostUpdateAura(self, unit, button)  --error?
		end
	end
end

function ElvUI_EltreumUI:Construct_Auras(nameplate)
	if E.private.nameplates.enable == true then
		nameplate.Buffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIconBuff
		nameplate.Debuffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIconDebuff
	end
end
hooksecurefunc(NP, "Construct_Auras", ElvUI_EltreumUI.Construct_Auras)

--for general nameplates
local playerclass = {
	['WARRIOR'] = "Eltreum-Class-Warrior",
	['PALADIN'] = "Eltreum-Class-Paladin",
	['HUNTER'] = "Eltreum-Class-Hunter",
	['ROGUE'] = "Eltreum-Class-Rogue",
	['PRIEST'] = "Eltreum-Class-Priest",
	['DEATHKNIGHT'] = "Eltreum-Class-DeathKnight",
	['SHAMAN'] = "Eltreum-Class-Paladin", -- issues becoming green due to color mixing so color changed to paladin from "Eltreum-Class-Shaman"
	['MAGE'] = "Eltreum-Class-Paladin", -- issues becoming green due to color mixing so color changed to paladin from "Eltreum-Class-Mage"
	['WARLOCK'] = "Eltreum-Class-Warlock",
	['MONK'] = "Eltreum-Class-Monk",
	['DRUID'] = "Eltreum-Class-Druid",
	['DEMONHUNTER'] = "Eltreum-Class-DemonHunter",
}
-- for rare nameplates
local rareclass = {
	['WARRIOR'] = "Eltreum-Class-Warrior",
	['PALADIN'] = "Eltreum-Class-Paladin",
	['HUNTER'] = "Eltreum-Class-Hunter",
	['ROGUE'] = "Eltreum-Class-Rogue",
	['PRIEST'] = "Eltreum-Class-Priest",
	['DEATHKNIGHT'] = "Eltreum-Class-DeathKnight",
	['SHAMAN'] = "Eltreum-Class-Shaman",
	['MAGE'] = "Eltreum-Class-Mage",
	['WARLOCK'] = "Eltreum-Class-Warlock",
	['MONK'] = "Eltreum-Class-Monk",
	['DRUID'] = "Eltreum-Class-Druid",
	['DEMONHUNTER'] = "Eltreum-Class-DemonHunter",
}

-- Nameplate options for Border and Glow and Texture
function ElvUI_EltreumUI:NamePlateOptions()
	local nameplateclasscolors
	nameplateclasscolors = E:ClassColor(E.myclass, true)
	if E.private.nameplates.enable == true then
		if E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow then
			E.db["nameplates"]["colors"]["glowColor"]["b"] = nameplateclasscolors.b
			E.db["nameplates"]["colors"]["glowColor"]["r"] = nameplateclasscolors.r
			E.db["nameplates"]["colors"]["glowColor"]["g"] = nameplateclasscolors.g
		end
		if E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate then
			E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = true
			E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
			E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
			E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			if not E.private.ElvUI_EltreumUI.install_version then
				return
			elseif E.private.ElvUI_EltreumUI.install_version > "2.0.0" and E.global.nameplates.filters.EltreumRare then
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["border"] = true
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			end
		else
			--E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["color"]["border"] = false
			if not E.private.ElvUI_EltreumUI.install_version then
				return
			elseif E.private.ElvUI_EltreumUI.install_version > "2.0.0" and E.global.nameplates.filters.EltreumRare then
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["border"] = false
			end
		end
		if E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture then
			E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = (playerclass[E.myclass])
			if not E.private.ElvUI_EltreumUI.install_version then
				return
			elseif E.private.ElvUI_EltreumUI.install_version > "2.0.0" and E.global.nameplates.filters.EltreumRare then
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["texture"] = (rareclass[E.myclass])
			end
		end
		if E.db.ElvUI_EltreumUI.nameplateOptions.targetclasstexture then
			local _, targetclass = UnitClass("target")
			local reactiontarget = UnitReaction("player", "target")
			if UnitExists("target") then
				if targetclass and UnitIsPlayer("target") then
					E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = (playerclass[targetclass])
				elseif ( UnitIsPlayer("target") == false and ( reactiontarget >= 5) ) then
					E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = "Eltreum-Class-Hunter"
				elseif reactiontarget == 4 then
					E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = "Eltreum-Class-Rogue"
				elseif reactiontarget == 3 then
					E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = "Eltreum-Class-Druid"
				elseif reactiontarget == 2 or reactiontarget == 1  then
					E.global["nameplates"]["filters"]["ElvUI_Target"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnight"
				end
			end
		end
		--automatically hide classbar when targeting friendly targets
		if E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide then
			--add spec info for retail
			local id, _
			if E.Retail then
				local currentSpec = GetSpecialization()
				if currentSpec then
					id, _ = GetSpecializationInfo(currentSpec)
				end
			end
			if UnitExists("target") and UnitCanAttack("player", "target") then
				if E.Retail then
					--print(id)
					if E.myclass == 'DEATHKNIGHT' then
						_G['ElvNP_TargetClassPowerRunes']:Show()
					elseif E.myclass == 'PALADIN ' or E.myclass == 'ROGUE' or E.myclass == 'WARLOCK' then
						_G['ElvNP_TargetClassPowerClassPower']:Show()
					elseif E.myclass == 'DRUID' then
						local stance = GetShapeshiftForm()
						if stance == 2 then --its a cat
							_G['ElvNP_TargetClassPowerClassPower']:Show()
						else
							_G['ElvNP_TargetClassPowerClassPower']:Hide()
						end
					elseif E.myclass == 'MONK' then
						if id == 269 then
							_G['ElvNP_TargetClassPowerClassPower']:Show()
						elseif id == 268 then
							_G['ElvNP_TargetClassPowerStagger']:Show()
						end
					elseif E.myclass == 'MAGE' then
						if id == 62 then
							_G['ElvNP_TargetClassPowerClassPower']:Show()
						end
					end
				elseif E.TBC or E.Classic then
					if E.myclass == 'ROGUE' then
						_G['ElvNP_TargetClassPowerClassPower']:Show()
					elseif E.myclass == 'DRUID' then
						local stance = GetShapeshiftForm()
						if stance == 2 then --its a cat
							_G['ElvNP_TargetClassPowerClassPower']:Show()
						else
							_G['ElvNP_TargetClassPowerClassPower']:Hide()
						end
					end
				end
			elseif UnitExists("target") and (not UnitCanAttack("player", "target")) then
				if E.Retail then
					if E.myclass == 'DEATHKNIGHT' then
						_G['ElvNP_TargetClassPowerRunes']:Hide()
					elseif E.myclass == 'PALADIN ' or E.myclass == 'ROGUE' or E.myclass == 'WARLOCK' then
						_G['ElvNP_TargetClassPowerClassPower']:Hide()
					elseif E.myclass == 'DRUID' then
							_G['ElvNP_TargetClassPowerClassPower']:Hide()
					elseif E.myclass == 'MONK' then
						if id == 269 then
							_G['ElvNP_TargetClassPowerClassPower']:Hide()
						elseif id == 268 then
							_G['ElvNP_TargetClassPowerStagger']:Hide()
						end
					elseif E.myclass == 'MAGE' then
						if id == 62 then
							_G['ElvNP_TargetClassPowerClassPower']:Hide()
						end
					end
				elseif E.TBC or E.Classic then
					if E.myclass == 'ROGUE' then
						_G['ElvNP_TargetClassPowerClassPower']:Hide()
					elseif E.myclass == 'DRUID' then
						_G['ElvNP_TargetClassPowerClassPower']:Hide()
					end
				end
			end
		end
	end
end

local EltruismNamePlateOptionsFrame = CreateFrame("FRAME")
EltruismNamePlateOptionsFrame:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
EltruismNamePlateOptionsFrame:SetScript("OnEvent", ElvUI_EltreumUI.NamePlateOptions)

--add threat to nameplate by putting threat into title and moving title to the healthbar
function ElvUI_EltreumUI:ClassicThreatNP()
	if E.private.nameplates.enable == true then
		if E.Classic or E.TBC then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = "Kimberley"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontOutline"] = "OUTLINE"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["enable"] = true
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["parent"] = "Health"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontSize"] = 10
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["format"] = "[threat:percent]"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["position"] = "CENTER"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["yOffset"] = 0
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["xOffset"] = -55
		end
	end
end

--- Friendly Nameplate Control
function ElvUI_EltreumUI:FriendlyNameplates()
	local _, instanceType = IsInInstance()
	local mapID = WorldMapFrame:GetMapID()
	local nameplateShowOnlyNames = C_CVar.GetCVar('nameplateShowOnlyNames')
	local nameplateShowFriends = C_CVar.GetCVar('nameplateShowFriends')
	--print(mapID, instanceType)
	if not InCombatLockdown() then
		if E.Retail then
			local UnitNameHostleNPC = C_CVar.GetCVar('UnitNameHostleNPC')
			local UnitNameInteractiveNPC =C_CVar.GetCVar('UnitNameInteractiveNPC')
			local UnitNameNPC = C_CVar.GetCVar('UnitNameNPC')
			if E.db.ElvUI_EltreumUI.cvars.autohidenpcname then
				if instanceType == "none" then
					if UnitNameHostleNPC == "1" then
						SetCVar('UnitNameHostleNPC', 0)
					end
					if UnitNameInteractiveNPC == "1" then
						SetCVar('UnitNameInteractiveNPC', 0)
					end
					if UnitNameNPC == "1" then
						SetCVar('UnitNameNPC', 0)
					end
				elseif instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" or mapID == 1662 or mapID == 582 or mapID == 590 then
					if UnitNameHostleNPC == "0" then
						SetCVar('UnitNameHostleNPC', 1)
					end
					if UnitNameInteractiveNPC == "0" then
						SetCVar('UnitNameInteractiveNPC', 1)
					end
					if UnitNameNPC == "0" then
						SetCVar('UnitNameNPC', 1)
					end
				end
			end
		end
		if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames then
			if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" or instanceType == "none" or mapID == 1662 or mapID == 582 or mapID == 590 then
				if nameplateShowOnlyNames == "0" then
					SetCVar("nameplateShowOnlyNames", 1)
				end
			end
		end
		if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly then
			if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" then
				if nameplateShowFriends == "1" then
					SetCVar("nameplateShowFriends", 0)
				end
			end
			if instanceType == "none" or mapID == 1662 or mapID == 582 or mapID == 590 then
				if nameplateShowFriends == "0" then
					SetCVar("nameplateShowFriends", 1)
				end
			end
		end
		if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly then
			if nameplateShowFriends == "1" then
				SetCVar("nameplateShowFriends", 0)
			end
		end
	end
end

--restore nameplate cvars if user wants
function ElvUI_EltreumUI:RestoreNameplateNames()
	SetCVar('nameplateShowFriendlyMinions', 1)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar("nameplateShowFriends", 1)
	SetCVar('UnitNameHostleNPC', 1)
	SetCVar('UnitNameInteractiveNPC', 1)
	SetCVar('UnitNameNPC', 1)
	SetCVar('UnitNameEnemyGuardianName', 1)
	SetCVar('UnitNameEnemyMinionName', 1)
	SetCVar('UnitNameEnemyPetName', 1)
	SetCVar('UnitNameFriendlyPetName', 1)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyTotemName', 1)
end
