local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
local LCG = E.Libs.CustomGlow
local classcolor = E:ClassColor(E.myclass, true)
local glowcolor
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local string = _G.string
local UnitExists = _G.UnitExists
local tonumber = _G.tonumber
local UnitClass = _G.UnitClass
local UnitReaction = _G.UnitReaction
local UnitIsPlayer = _G.UnitIsPlayer
local GetSpecialization = _G.GetSpecialization
local GetSpecializationInfo = _G.GetSpecializationInfo
local UnitCanAttack = _G.UnitCanAttack
local GetShapeshiftForm = _G.GetShapeshiftForm
local IsInInstance = _G.IsInInstance
local WorldMapFrame = _G.WorldMapFrame
local tostring = _G.tostring
local C_CVar = _G.C_CVar
local InCombatLockdown = _G.InCombatLockdown
local SetCVar = _G.SetCVar
local TimeSinceLastUpdate
local debufftime
local _, targetclass
local reactiontarget
local id
local currentSpec
local stance
local instanceType
local mapID
local nameplateShowOnlyNames
local nameplateShowFriends

-- Different Debuffs/Buffs on nameplates
local ONUPDATE_INTERVAL = 0.1
function ElvUI_EltreumUI:PostUpdateIconDebuff(unit, button)
	if E.db.ElvUI_EltreumUI.glow.colorclassnp then
		glowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
	else
		glowcolor = {E.db.ElvUI_EltreumUI.glow.glowcustomcolornp.r, E.db.ElvUI_EltreumUI.glow.glowcustomcolornp.g, E.db.ElvUI_EltreumUI.glow.glowcustomcolornp.b, 1}
	end
	if button and button.spellID then
		if not string.find(unit, "nameplate") then
			return
		else
			--[[if button.caster ~= "player" then
				button:Hide()
			end]]
			if E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable then
				button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			end
			button.cd:SetFrameStrata('DIALOG')
			TimeSinceLastUpdate = 0
			if not button.cd then
				if E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow then
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Stop(button)
					elseif E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Stop(button)
					elseif E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Stop(button)
					end
				end
			else
				button.cd:SetScript('OnUpdate', function(self, elapsed)
					TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
					if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
						TimeSinceLastUpdate = 0

						--hide debuffs if they are not target
						if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hidedebuffsnontarget then
							if not UnitIsUnit(unit,"target") then
								button:Hide()
							else
								button:Show()
							end
						end

						--print("np button spam "..math.random(1,99))
						if button.cd.timer then
							if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hideSwipe then
								button.cd:SetSwipeColor(0, 0, 0, 0)
								button.cd:SetEdgeTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\Testing")
							end
							if E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable then
								button.cd.timer.text:ClearAllPoints()
								button.cd.timer.text:SetPoint("TOP", button.icon, "TOP", 0, 5)
							end
							debufftime = tonumber(button.cd.timer.text:GetText())
							if E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow then
								if debufftime ~= nil and debufftime <= E.db.ElvUI_EltreumUI.glow.numberdebuff and debufftime > 0 then
									if E.db.ElvUI_EltreumUI.glow.pixel then
										LCG.PixelGlow_Start(button, glowcolor, 6, 0.8, 4, 2, 1, 1, false, nil)
									elseif E.db.ElvUI_EltreumUI.glow.autocast then
										--LCG.AutoCastGlow_Start(button, glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
										LCG.AutoCastGlow_Start(button, glowcolor, 8, 1, 1.5, 1, 1)
									elseif E.db.ElvUI_EltreumUI.glow.blizzard then
										LCG.ButtonGlow_Start(button, glowcolor, 0.5)
									end
								else
									if E.db.ElvUI_EltreumUI.glow.pixel then
										LCG.PixelGlow_Stop(button)
									elseif E.db.ElvUI_EltreumUI.glow.autocast then
										LCG.AutoCastGlow_Stop(button)
									elseif E.db.ElvUI_EltreumUI.glow.blizzard then
										LCG.ButtonGlow_Stop(button)
									end
								end
							end
						else
							if E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow and (button.cd == nil or button.cd.timer == nil) then
								if E.db.ElvUI_EltreumUI.glow.pixel then
									LCG.PixelGlow_Stop(button)
								elseif E.db.ElvUI_EltreumUI.glow.autocast then
									LCG.AutoCastGlow_Stop(button)
								elseif E.db.ElvUI_EltreumUI.glow.blizzard then
									LCG.ButtonGlow_Stop(button)
								end
							end
						end
					end
				end)
			end
			button.count:SetParent(button.cd)
			if E.Wrath or E.Wrath or E.Classic then
				if E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable then
					button.count:Point('BOTTOMRIGHT', 2, -3) --elvui added a setting for it but its missing some things
				end
			end
		end
	end
	if UnitExists(unit) then
		UF.PostUpdateAura(self, unit, button) --error? TexCoord out of range (mostly in vehicles)
	end
end

function ElvUI_EltreumUI:PostUpdateIconBuff(unit, button)
	if button and button.spellID then
		if not string.find(unit, "nameplate") then
			return
		else
			button.icon:SetTexCoord(0.07, 0.93, 0.21, 0.79)
			TimeSinceLastUpdate = 0
			button.cd:SetScript('OnUpdate', function(self, elapsed)
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0
					if button.cd.timer then
						if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.hideSwipe then
							button.cd:SetSwipeColor(0, 0, 0, 0)
							button.cd:SetEdgeTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\Testing")
						end
						button.cd:SetEdgeTexture("Interface\\Cooldown\\edge",1,1,1,1)
						button.cd.timer.text:ClearAllPoints()
						button.cd.timer.text:SetDrawLayer('OVERLAY',1)
						button.cd.timer.text:Point("TOP", button.icon, "TOP", 0, 5)
					end
				end
			end)
			button.count:SetParent(button.cd)
			button.count:Point('BOTTOMRIGHT', 2, -3)
		end
	end
	if UnitExists(unit) then
		UF.PostUpdateAura(self, unit, button) --error? TexCoord out of range (mostly in vehicles)
	end
end

function ElvUI_EltreumUI:Construct_Auras(nameplate)
	if E.private.nameplates.enable and (E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable or E.db.ElvUI_EltreumUI.nameplates.widenameplate.npglow) then
		nameplate.Buffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIconBuff
		nameplate.Debuffs.PostUpdateIcon = ElvUI_EltreumUI.PostUpdateIconDebuff
	end
end
hooksecurefunc(NP, "Construct_Auras", ElvUI_EltreumUI.Construct_Auras)

--for general nameplates
local playerclassv1 = {
	["WARRIOR"] = "Eltreum-Class-Warrior",
	["PALADIN"] = "Eltreum-Class-Paladin",
	["HUNTER"] = "Eltreum-Class-Hunter",
	["ROGUE"] = "Eltreum-Class-Rogue",
	["PRIEST"] = "Eltreum-Class-Priest",
	["DEATHKNIGHT"] = "Eltreum-Class-DeathKnight",
	["SHAMAN"] = "Eltreum-Class-Paladin", -- issues becoming green due to color mixing so color changed to paladin from "Eltreum-Class-Shaman"
	["MAGE"] = "Eltreum-Class-Paladin", -- issues becoming green due to color mixing so color changed to paladin from "Eltreum-Class-Mage"
	["WARLOCK"] = "Eltreum-Class-Warlock",
	["MONK"] = "Eltreum-Class-Monk",
	["DRUID"] = "Eltreum-Class-Druid",
	["DEMONHUNTER"] = "Eltreum-Class-DemonHunter",
}

local playerclassv2 = {
	["WARRIOR"] = "Eltreum-Class-WarriorV2",
	["PALADIN"] = "Eltreum-Class-PaladinV2",
	["HUNTER"] = "Eltreum-Class-HunterV2",
	["ROGUE"] = "Eltreum-Class-RogueV2",
	["PRIEST"] = "Eltreum-Class-PriestV2",
	["DEATHKNIGHT"] = "Eltreum-Class-DeathKnightV2",
	["SHAMAN"] = "Eltreum-Class-ShamanV2",
	["MAGE"] = "Eltreum-Class-MageV2",
	["WARLOCK"] = "Eltreum-Class-WarlockV2",
	["MONK"] = "Eltreum-Class-MonkV2",
	["DRUID"] = "Eltreum-Class-DruidV2",
	["DEMONHUNTER"] = "Eltreum-Class-DemonHunterV2",
}

local playerclassv3 = {
	["WARRIOR"] = "Eltreum-Class-WarriorV3",
	["PALADIN"] = "Eltreum-Class-PaladinV3",
	["HUNTER"] = "Eltreum-Class-HunterV3",
	["ROGUE"] = "Eltreum-Class-RogueV3",
	["PRIEST"] = "Eltreum-Class-PriestV3",
	["DEATHKNIGHT"] = "Eltreum-Class-DeathKnightV3",
	["SHAMAN"] = "Eltreum-Class-ShamanV3",
	["MAGE"] = "Eltreum-Class-MageV3",
	["WARLOCK"] = "Eltreum-Class-WarlockV3",
	["MONK"] = "Eltreum-Class-MonkV3",
	["DRUID"] = "Eltreum-Class-DruidV3",
	["DEMONHUNTER"] = "Eltreum-Class-DemonHunterV3",
}

-- for rare nameplates
local rareclass = {
	["WARRIOR"] = "Eltreum-Class-Warrior",
	["PALADIN"] = "Eltreum-Class-Paladin",
	["HUNTER"] = "Eltreum-Class-Hunter",
	["ROGUE"] = "Eltreum-Class-Rogue",
	["PRIEST"] = "Eltreum-Class-Priest",
	["DEATHKNIGHT"] = "Eltreum-Class-DeathKnight",
	["SHAMAN"] = "Eltreum-Class-Shaman",
	["MAGE"] = "Eltreum-Class-Mage",
	["WARLOCK"] = "Eltreum-Class-Warlock",
	["MONK"] = "Eltreum-Class-Monk",
	["DRUID"] = "Eltreum-Class-Druid",
	["DEMONHUNTER"] = "Eltreum-Class-DemonHunter",
}

local nameplateclasscolors

--sets them enabled/disabled
function ElvUI_EltreumUI:SetStyleFilters()

	--fix threat
	if E.global.nameplates.filters.EltreumTarget then
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["health"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["healthClass"] = false
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then --gradient check for my filters
			E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = false
		end
	end

	--general disable/enable
	if (not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow) then
		if E.global.nameplates.filters.EltreumTarget and E.db["nameplates"]["filters"]["EltreumTarget"] then
			E.db["nameplates"]["filters"]["EltreumTarget"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumTarget.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumRare and E.db["nameplates"]["filters"]["EltreumRare"] then
			E.db["nameplates"]["filters"]["EltreumRare"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumRare.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumSpellsteal and E.db["nameplates"]["filters"]["EltreumSpellsteal"] then
			E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumSpellsteal.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumLevel and E.db["nameplates"]["filters"]["EltreumLevel"] then
			E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumLevel.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumHideNP and E.db["nameplates"]["filters"]["EltreumHideNP"] then
			E.db["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumHideNP.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumInterrupt and E.db["nameplates"]["filters"]["EltreumInterrupt"] then
			E.db["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumInterrupt.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumExecute and E.db["nameplates"]["filters"]["EltreumExecute"] then
			E.db["nameplates"]["filters"]["EltreumExecute"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumExecute.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumRestedNP and E.db["nameplates"]["filters"]["EltreumRestedNP"] then
			E.db["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumRestedNP.triggers.enable = false
		end
		if E.global.nameplates.filters.EltreumTotems and E.db["nameplates"]["filters"]["EltreumTotems"] then
			E.db["nameplates"]["filters"]["EltreumTotems"]["triggers"]["enable"] = false
			E.global.nameplates.filters.EltreumTotems.triggers.enable = false
		end
	else
		if E.global.nameplates.filters.EltreumTarget and E.db["nameplates"]["filters"]["EltreumTarget"] then
			E.db["nameplates"]["filters"]["EltreumTarget"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumTarget.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumRare and E.db["nameplates"]["filters"]["EltreumRare"] then
			E.db["nameplates"]["filters"]["EltreumRare"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumRare.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumSpellsteal and E.db["nameplates"]["filters"]["EltreumSpellsteal"] then
			E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumSpellsteal.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumLevel and E.db["nameplates"]["filters"]["EltreumLevel"] then
			E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumLevel.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumHideNP and E.db["nameplates"]["filters"]["EltreumHideNP"] then
			E.db["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumHideNP.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumInterrupt and E.db["nameplates"]["filters"]["EltreumInterrupt"] then
			E.db["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumInterrupt.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumExecute and E.db["nameplates"]["filters"]["EltreumExecute"] then
			E.db["nameplates"]["filters"]["EltreumExecute"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumExecute.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumRestedNP and E.db["nameplates"]["filters"]["EltreumRestedNP"] then
			E.db["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumRestedNP.triggers.enable = true
		end
		if E.global.nameplates.filters.EltreumTotems and E.db["nameplates"]["filters"]["EltreumTotems"] then
			E.db["nameplates"]["filters"]["EltreumTotems"]["triggers"]["enable"] = true
			E.global.nameplates.filters.EltreumTotems.triggers.enable = true
		end
	end

	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate then
		if E.global.nameplates.filters.EltreumTarget then
			E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["border"] = false
		end
		if E.global.nameplates.filters.EltreumRare then
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["border"] = false
		end
		if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["border"] = false
		end
	end

	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture then
		if E.global.nameplates.filters.EltreumTarget then
			E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = false
		end
		if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["enable"] = false
		end
	end

	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
		if E.global.nameplates.filters.EltreumRare then
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["enable"] = false
		end
	end
end

-- Nameplate options for Border and Glow and Texture
function ElvUI_EltreumUI:NamePlateOptions()
	nameplateclasscolors = E:ClassColor(E.myclass, true)
	if E.private.nameplates.enable then

		--fix threat
		if E.global.nameplates.filters.EltreumTarget then
			E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["health"] = false
			E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["healthClass"] = false
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then --gradient check for my filters
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = false
			end
		end

		--glow color
		if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow then
			E.db["nameplates"]["colors"]["glowColor"]["b"] = nameplateclasscolors.b
			E.db["nameplates"]["colors"]["glowColor"]["r"] = nameplateclasscolors.r
			E.db["nameplates"]["colors"]["glowColor"]["g"] = nameplateclasscolors.g
		end

		--border colors
		if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate then
			if E.global.nameplates.filters.EltreumTarget then
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["border"] = true
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			end
			if E.global.nameplates.filters.EltreumRare then
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["border"] = true
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			end
			if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
				E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["border"] = true
				E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["borderColor"]["b"] = nameplateclasscolors.b
				E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["borderColor"]["g"] = nameplateclasscolors.g
				E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["borderColor"]["r"] = nameplateclasscolors.r
			end
		elseif not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate then
			if E.global.nameplates.filters.EltreumTarget then
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["border"] = false
			end
			if E.global.nameplates.filters.EltreumRare then
				E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["border"] = false
			end
			if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
				E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["border"] = false
			end
		end

		--class color texture
		if E.global.nameplates.filters.EltreumTarget and E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			if E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V1" then
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = (playerclassv1[E.myclass])
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
			elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V2" then
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = (playerclassv2[E.myclass])
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
			elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V3" then
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = (playerclassv3[E.myclass])
				E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
			end
		end

		--color rares according to class
		if E.global.nameplates.filters.EltreumRare and (E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture or E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow or E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate) then
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["texture"] = (rareclass[E.myclass])
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["texture"]["enable"] = false
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["health"] = true
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["b"] = classcolor.b
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["g"] = classcolor.g
			E.global["nameplates"]["filters"]["EltreumRare"]["actions"]["color"]["healthColor"]["r"] = classcolor.r
		end

		--target's class color texture
		if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture and not E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable then
			_, targetclass = UnitClass("target")
			reactiontarget = UnitReaction("target", "player")
			if UnitExists("target") and E.global.nameplates.filters.EltreumTarget then
				if targetclass and UnitIsPlayer("target") then
					if E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V1" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = (playerclassv1[targetclass])
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
						if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
							E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnight"
							E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["enable"] = true
						end
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V2" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = (playerclassv2[targetclass])
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
						if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
							E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnightV2"
							E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["enable"] = true
						end
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V3" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = (playerclassv3[targetclass])
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
						if not E.Retail and E.global.nameplates.filters.ElvUI_Boss then
							E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnightV3"
							E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["enable"] = true
						end
					end
				elseif ( UnitIsPlayer("target") == false and ( reactiontarget >= 5) ) then
					if E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V1" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-Hunter"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V2" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-HunterV2"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V3" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-HunterV3"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					end
				elseif reactiontarget == 4 then
					if E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V1" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-Rogue"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V2" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-RogueV2"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V3" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-RogueV3"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					end
				elseif reactiontarget == 3 then
					if E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V1" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-Druid"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V2" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-DruidV2"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V3" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-DruidV3"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					end
				elseif reactiontarget == 2 or reactiontarget == 1 then
					if E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V1" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnight"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V2" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnightV2"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					elseif E.db.ElvUI_EltreumUI.nameplates.nptextureversion == "V3" then
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "Eltreum-Class-DeathKnightV3"
						E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
					end
				end
			end
		end

		--automatically hide classbar when targeting friendly targets
		if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.classbarautohide then
			--add spec info for retail

			if E.Retail then
				currentSpec = GetSpecialization()
				if currentSpec then
					id, _ = GetSpecializationInfo(currentSpec)
				end
			end
			if UnitExists("target") and UnitCanAttack("player", "target") then
				if E.Retail then
					--print(id)
					if E.myclass == 'DEATHKNIGHT' then
						_G["ElvNP_TargetClassPowerRunes"]:Show()
					elseif E.myclass == 'PALADIN ' or E.myclass == 'ROGUE' or E.myclass == 'WARLOCK' then
						_G["ElvNP_TargetClassPowerClassPower"]:Show()
					elseif E.myclass == 'DRUID' then
						stance = GetShapeshiftForm()
						if stance == 2 then --its a cat
							_G["ElvNP_TargetClassPowerClassPower"]:Show()
						else
							_G["ElvNP_TargetClassPowerClassPower"]:Hide()
						end
					elseif E.myclass == 'MONK' then
						if id == 269 then
							_G["ElvNP_TargetClassPowerClassPower"]:Show()
						elseif id == 268 then
							_G["ElvNP_TargetClassPowerStagger"]:Show()
						end
					elseif E.myclass == 'MAGE' then
						if id == 62 then
							_G["ElvNP_TargetClassPowerClassPower"]:Show()
						end
					end
				elseif E.Wrath or E.Classic then
					if E.myclass == 'ROGUE' then
						_G["ElvNP_TargetClassPowerClassPower"]:Show()
					elseif E.myclass == 'DEATHKNIGHT' then
						_G["ElvNP_TargetClassPowerRunes"]:Show()
					elseif E.myclass == 'DRUID' then
						stance = GetShapeshiftForm()
						if stance == 2 then --its a cat
							_G["ElvNP_TargetClassPowerClassPower"]:Show()
						else
							_G["ElvNP_TargetClassPowerClassPower"]:Hide()
						end
					end
				end
			elseif UnitExists("target") and (not UnitCanAttack("player", "target")) then
				if E.Retail then
					if E.myclass == 'DEATHKNIGHT' then
						_G["ElvNP_TargetClassPowerRunes"]:Hide()
					elseif E.myclass == 'PALADIN ' or E.myclass == 'ROGUE' or E.myclass == 'WARLOCK' then
						_G["ElvNP_TargetClassPowerClassPower"]:Hide()
					elseif E.myclass == 'DRUID' then
							_G["ElvNP_TargetClassPowerClassPower"]:Hide()
					elseif E.myclass == 'MONK' then
						if id == 269 then
							_G["ElvNP_TargetClassPowerClassPower"]:Hide()
						elseif id == 268 then
							_G["ElvNP_TargetClassPowerStagger"]:Hide()
						end
					elseif E.myclass == 'MAGE' then
						if id == 62 then
							_G["ElvNP_TargetClassPowerClassPower"]:Hide()
						end
					end
				elseif E.Wrath or E.Classic then
					if E.myclass == 'ROGUE' then
						_G["ElvNP_TargetClassPowerClassPower"]:Hide()
					elseif E.myclass == 'DEATHKNIGHT' then
						_G["ElvNP_TargetClassPowerRunes"]:Hide()
					elseif E.myclass == 'DRUID' then
						_G["ElvNP_TargetClassPowerClassPower"]:Hide()
					elseif E.myclass == 'DEATHKNIGHT' then
						_G["ElvNP_TargetClassPowerRunes"]:Hide()
					end
				end
			end
		end

		--automatically set the execute % based on class
		if E.global.nameplates.filters.EltreumExecute and E.db["nameplates"]["filters"]["EltreumExecute"] and E.db["nameplates"]["filters"]["EltreumExecute"]["triggers"]["enable"] then
			if E.Retail then
				if E.myclass == "WARRIOR" or E.myclass == "DEATHKNIGHT" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.35
				elseif E.myclass == "MAGE" or E.myclass == "ROGUE" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.30
				elseif E.myclass == "HUNTER" or E.myclass == "WARLOCK" or E.myclass == "PALADIN" or E.myclass == "PRIEST" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.20
				elseif E.myclass == "MONK" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.15
				else
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.10
				end
			elseif E.Wrath then
				if E.myclass == "MAGE" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.35
				elseif E.myclass == "WARRIOR" or E.myclass == "HUNTER" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.20
				else
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.10
				end
			elseif E.Classic then
				if E.myclass == "WARRIOR" then
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.20
				else
					E.global["nameplates"]["filters"]["EltreumExecute"]["triggers"]["underHealthThreshold"] = 0.10
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
		if E.Classic or E.Wrath then
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["font"] = E.db.general.font
			E.db["nameplates"]["units"]["ENEMY_NPC"]["title"]["fontOutline"] = E.db.general.fontStyle
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
	_, instanceType = IsInInstance()
	mapID = WorldMapFrame:GetMapID()
	nameplateShowOnlyNames = tostring(C_CVar.GetCVar('nameplateShowOnlyNames'))
	nameplateShowFriends = tostring(C_CVar.GetCVar('nameplateShowFriends'))
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
		if E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.friendlynames then
			if instanceType == "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena" or instanceType == "scenario" or instanceType == "none" or mapID == 1662 or mapID == 582 or mapID == 590 then
				if nameplateShowOnlyNames == "0" then
					SetCVar("nameplateShowOnlyNames", 1)
				end
			end
		end
		if E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly then
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
		if E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly then
			if nameplateShowFriends == "1" then
				SetCVar("nameplateShowFriends", 0)
			end
		end
	end
end

--change vertical and horizontal offsets when resting/not resting
function ElvUI_EltreumUI:NameplateRestedOverlaps()
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.restedoverlap then
		if not InCombatLockdown() then
			if IsResting() then
				SetCVar("nameplateOverlapH", 0)
				SetCVar("nameplateOverlapV", 0)
			else
				SetCVar("nameplateOverlapH", E.db["nameplates"]["overlapH"])
				SetCVar("nameplateOverlapV", E.db["nameplates"]["overlapV"])
			end
		end
	end
end

--Class color the target, plus use unit's target directly
local classcolorcast = {
	["DEATHKNIGHT"]	= "FFC41E3A",
	["DEMONHUNTER"]	= "FFA330C9",
	["DRUID"] = "FFFF7C0A",
	["HUNTER"] = "FFAAD372",
	["MAGE"] = "FF3FC7EB",
	["MONK"] = "FF00FF98",
	["PALADIN"]	= "FFF48CBA",
	["PRIEST"] = "FFFFFFFF",
	["ROGUE"] = "FFFFF468",
	["SHAMAN"] = "FF0070DD",
	["WARLOCK"] = "FF8788EE",
	["WARRIOR"] = "FFC69B6D",
	["HOSTILE"] = "FFFF0000",
	["UNFRIENDLY"] = "FFF26000",
	["NEUTRAL"] = "FFE4E400",
	["FRIENDLY"] = "FF33FF33",
	["EVOKER"] = "FF33937F",
}
function NP:Castbar_PostCastStart(unit)
	self:CheckInterrupt(unit)
	local plate = self.__owner
	local db = NP:PlateDB(plate)
	if db.castbar and db.castbar.enable and db.castbar.displayTarget then
		local frameType = plate.frameType
		if frameType == 'PLAYER' or frameType == 'ENEMY_NPC' or frameType == 'FRIENDLY_NPC' then
			if UnitExists(unit.."target") then
				--self.Text:SetFont(E.LSM:Fetch('font', NP.db.font), 8, NP.db.fontOutline) --change size so it doesnt overlap the cast time print(NP.db.fontSize)
				local spellName = E:ShortenString(self.spellName, 11)
				if UnitIsPlayer(unit.."target") then
					local _ , classes = UnitClass(unit.."target")
					self.Text:SetText(spellName..' > '.."|c"..classcolorcast[classes]..UnitName(unit..'target').."|r")
				else
					local reaction = UnitReaction(unit.."target", "player")
					if reaction >= 5 then
						self.Text:SetText(spellName..' > '.."|c"..classcolorcast["FRIENDLY"]..UnitName(unit..'target').."|r")
					elseif reaction == 4 then
						self.Text:SetText(spellName..' > '.."|c"..classcolorcast["NEUTRAL"]..UnitName(unit..'target').."|r")
					elseif reaction == 3 then
						self.Text:SetText(spellName..' > '.."|c"..classcolorcast["UNFRIENDLY"]..UnitName(unit..'target').."|r")
					elseif reaction == 2 or reaction == 1 then
						self.Text:SetText(spellName..' > '.."|c"..classcolorcast["HOSTILE"]..UnitName(unit..'target').."|r")
					end
				end
			end
		end
	end
end

local NP = E:GetModule('NamePlates')
hooksecurefunc(NP, 'Initialize', function()
	if E.db.ElvUI_EltreumUI.unitframes.darkpowercolor then
		NP.multiplier = 0
	end
end)
if E.Retail or E.Wrath then
	hooksecurefunc(NP, 'Construct_Runes', function()
		if E.db.ElvUI_EltreumUI.unitframes.darkpowercolor then
			NP.multiplier = 0
		end
	end)
end
