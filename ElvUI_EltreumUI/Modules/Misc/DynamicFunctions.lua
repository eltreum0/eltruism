local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsInInstance = _G.IsInInstance
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local UnitLevel = _G.UnitLevel
local HasNewMail = _G.HasNewMail
local PlaySoundFile = _G.PlaySoundFile
local C_Timer = _G.C_Timer
local _, instanceType
local level
local IsPlayerAtEffectiveMaxLevel = _G.IsPlayerAtEffectiveMaxLevel

--fixed cooldown text to be class color
function ElvUI_EltreumUI:CooldownColors()
	if E.db.ElvUI_EltreumUI.skins.classcolorcooldowns then
		local valuecolors = E:ClassColor(E.myclass, true)
		E.db["cooldown"]["daysIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["daysIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["daysIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["hhmmColorIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["hhmmColorIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["hhmmColorIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["hoursIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["hoursIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["hoursIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["minutesIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["minutesIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["minutesIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["mmssColorIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["mmssColorIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["mmssColorIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["secondsIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["secondsIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["secondsIndicator"]["r"] = valuecolors.r
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["b"] = valuecolors.b
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["g"] = valuecolors.g
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = valuecolors.r

		E:UpdateCooldownSettings('all')
	end
end

--hide raid/party/arena frames in bgs/arenas bc of battlegroundenemies/gladiusEX or similar
function ElvUI_EltreumUI:ArenaBattlegroundGroupUnitframes()
	if E.private.unitframe.enable then
		_, instanceType = IsInInstance()
		if E.db.ElvUI_EltreumUI.unitframes.bgunitframes then
			if instanceType == "pvp" then
				E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
				E.db["unitframe"]["units"]["raid1"]["visibility"] = "hide"
				E.db["unitframe"]["units"]["raid2"]["visibility"] = "hide"
				E.db["unitframe"]["units"]["raid3"]["visibility"] = "hide"
			elseif instanceType == "arena" then
				if IsAddOnLoaded('GladiusEx') then
					E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
				end
				if E.db.ElvUI_EltreumUI.unitframes.arenaunitframes then
					E.db["unitframe"]["units"]["arena"]["enable"] = false
				end
			else
				E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][nogroup] hide;show"
				E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists][@raid21,exists] hide;show"
				E.db["unitframe"]["units"]["raid2"]["visibility"] = "[@raid21,noexists][@raid31,exists] hide;show"
				E.db["unitframe"]["units"]["raid3"]["visibility"] = "[@raid31,noexists] hide;show"
				if E.db.ElvUI_EltreumUI.unitframes.arenaunitframes or IsAddOnLoaded("BattleGroundEnemies") then
					E.db["unitframe"]["units"]["arena"]["enable"] = true
				end
			end
			E:UpdateUnitFrames()
		end
		if E.db.ElvUI_EltreumUI.unitframes.arenaunitframes then
			local UF = E:GetModule('UnitFrames')
			UF:CreateAndUpdateUFGroup('arena', 5)
			if instanceType == "arena" then
				_G["ElvUF_Arena1"]:Hide()
				_G["ElvUF_Arena2"]:Hide()
				_G["ElvUF_Arena3"]:Hide()
				_G["ElvUF_Arena4"]:Hide()
				_G["ElvUF_Arena5"]:Hide()
			elseif (instanceType == "pvp" and IsAddOnLoaded("BattleGroundEnemies")) then
				_G["ElvUF_Arena1"]:Hide()
				_G["ElvUF_Arena2"]:Hide()
				_G["ElvUF_Arena3"]:Hide()
				_G["ElvUF_Arena4"]:Hide()
				_G["ElvUF_Arena5"]:Hide()
			end
		end
	end
end

--show/hide buffs if in arena or not
function ElvUI_EltreumUI:DynamicBuffs()
	if E.db.ElvUI_EltreumUI.unitframes.arenabuffs and E.private.unitframe.enable and not InCombatLockdown() then
		_, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = true
			E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = true
			ElvUI_EltreumUI:Print(L["Buffs have been updated for Arenas"])
		elseif instanceType == "none" then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = false
			E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
			ElvUI_EltreumUI:Print(L["Buffs have been updated for Open World"])
		end
	end
end

--Dynamically datatext swap based on player class
function ElvUI_EltreumUI:DynamicClassicDatatext()
	if E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext then
		if not E.db.movers then E.db.movers = {} end
		if E.myclass == 'HUNTER' or E.myclass == 'WARLOCK' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][1] = "Eltruism Ammo"
			if E.db["datatexts"]["panels"]["EltruismDataText"] then
				E.db["datatexts"]["panels"]["EltruismDataText"][1] = "Eltruism Ammo"
			end
		end
	end
end

--Dynamic Level Nameplate Style Filter
function ElvUI_EltreumUI:DynamicLevelStyleFilter()
	if E.db.ElvUI_EltreumUI.nameplates.nameplatelevel and E.db.nameplates.filters.EltreumLevel and not InCombatLockdown() then
		if not E.private.ElvUI_EltreumUI.install_version then
			return
		else
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "TOPRIGHT"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = -6
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -13
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "TOPRIGHT"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13

			if not IsPlayerAtEffectiveMaxLevel() then
				if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
					E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "TOPRIGHT"
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = -6
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -13
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "TOPRIGHT"
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13
				end
			elseif IsPlayerAtEffectiveMaxLevel() then
				if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
					E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = "[eltruism:targetcast:indicator]"
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "CENTER"
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = 0
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -28
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = "[eltruism:targetcast:indicator]"
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "CENTER"
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = 0
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -28
					--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
					--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
				end
			end
			E:UpdateNamePlates()
		end
	end
end

--Dynamic Spellsteal Nameplate Style Filter
function ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" and E.db.nameplates.filters.EltreumSpellsteal and not InCombatLockdown() then
			if E.Wrath or E.Retail then
				if E.myclass == 'MAGE' then
					level = UnitLevel("player")
					if E.Retail then
						if level >= 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					elseif E.Wrath then
						if level >= 70 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 70 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					end
				else
					E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
				end
			elseif E.Classic then
				if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
					E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
				end
			end
			E:UpdateNamePlates()
		end
	end
end

--swap bar1 and bar4 action paging / visibility
function ElvUI_EltreumUI:ActionPagingSwap()
	if E.private.actionbar.enable then
		if E.db.actionbar.bar1.visibility == "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; show;"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

			if E.Retail then
				E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["MONK"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 16; [overridebar] 18; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
				E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["EVOKER"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;[bonusbar:1] 7;"
			else
				E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
				E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[form:1] 7;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;[stance:1] 7;  [stance:2] 8; [stance:3] 9;"
				E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11; [bonusbar:1] 7;"
			end

			E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = ""
			E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = ""
			E.db["actionbar"]["bar4"]["paging"]["DRUID"] = ""
			E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = ""
			E.db["actionbar"]["bar4"]["paging"]["MAGE"] = ""
			E.db["actionbar"]["bar4"]["paging"]["MONK"] = ""
			E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = ""
			E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = ""
			E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = ""
			E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = ""
			E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = ""
			E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = ""
			E.db["actionbar"]["bar4"]["paging"]["EVOKER"] = ""

		elseif E.db.actionbar.bar4.visibility == "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; show;"

			if E.Retail then
				E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["MONK"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 16; [overridebar] 18; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
				E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["EVOKER"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;[bonusbar:1] 7;"
			else
				E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
				E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[form:1] 7;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;[stance:1] 7;  [stance:2] 8; [stance:3] 9;"
				E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11; [bonusbar:1] 7;"
			end

			E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = ""
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = ""
			E.db["actionbar"]["bar1"]["paging"]["DRUID"] = ""
			E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = ""
			E.db["actionbar"]["bar1"]["paging"]["MAGE"] = ""
			E.db["actionbar"]["bar1"]["paging"]["MONK"] = ""
			E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = ""
			E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = ""
			E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = ""
			E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = ""
			E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = ""
			E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = ""
			E.db["actionbar"]["bar1"]["paging"]["EVOKER"] = ""
		end
	end
end

--fix master loot?
if E.Wrath then
	hooksecurefunc(_G.MasterLooterFrame, 'Hide', function(self)
		self:ClearAllPoints()
	end)
end

-- Inspired by Luckyone's performance option. Thanks Luckyone!
function ElvUI_EltreumUI:EmptyDetailsTable()
	if IsAddOnLoaded('Details') then
		_detalhes.encounter_spell_pool = {}
		_detalhes.npcid_pool = {}
		_detalhes.spell_pool = {}
		_detalhes.spell_school_cache = {}
		_detalhes.boss_mods_timers = {}

		ElvUI_EltreumUI:Print("Details tables were cleared")
	else
		ElvUI_EltreumUI:Print("Details is not loaded or enabled")
	end
end

--Dynamic Experience Bar Mouseover
function ElvUI_EltreumUI:DynamicExperienceDatabar()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		if E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar then
			if not IsPlayerAtEffectiveMaxLevel() then
				E.db.databars.experience.mouseover = false
				E.db.databars.experience.enable = true
			elseif IsPlayerAtEffectiveMaxLevel() then
				E.db.databars.experience.mouseover = true
				E.db.databars.experience.enable = false
			end
			E:UpdateDataBars()
		end
	end
end

--based on elvui mail datatext
local mailsoundframe = CreateFrame("FRAME")
--mailsoundframe:RegisterEvent("MAIL_INBOX_UPDATE")
mailsoundframe:RegisterEvent("UPDATE_PENDING_MAIL")
local mailthrottle = 0
mailsoundframe:SetScript("OnEvent", function()
	if not E.private.ElvUI_EltreumUI then return end
	if not E.private.ElvUI_EltreumUI.install_version then return end
	if not E.db.ElvUI_EltreumUI.otherstuff then return end
	if HasNewMail() == true and E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable and not InCombatLockdown() and mailthrottle == 0 then

		if E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "tts" and E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice ~= nil then
			--C_VoiceChat.SpeakText(voiceID, text, destination, rate, volume)
			C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume)
		elseif E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "sharedmedia" then
			PlaySoundFile(E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.otherstuff.mailsound) , "Master")
		end
		mailthrottle = 1
		C_Timer.After(2, function()
			mailthrottle = 0
		end)
	end
end)
