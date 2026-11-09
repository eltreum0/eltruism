local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type
local ipairs = _G.ipairs

--12.1.0 changes
local IsPlayerAtEffectiveMaxLevel = _G.GameRulesUtil and _G.GameRulesUtil.IsPlayerAtEffectiveMaxLevel or _G.IsPlayerAtEffectiveMaxLevel

--fixed cooldown text to be class color
function ElvUI_EltreumUI:CooldownColors()
	local valuecolors = E.myClassColor
	if E.db.ElvUI_EltreumUI.skins.classcolorcooldowns then
		if E.myclass == "PRIEST" then
			--[[E.db["cooldown"]["daysIndicator"]["b"] = 0.7
			E.db["cooldown"]["daysIndicator"]["g"] = 0.7
			E.db["cooldown"]["daysIndicator"]["r"] = 0.7
			E.db["cooldown"]["hhmmColorIndicator"]["b"] = 0.7
			E.db["cooldown"]["hhmmColorIndicator"]["g"] = 0.7
			E.db["cooldown"]["hhmmColorIndicator"]["r"] = 0.7
			E.db["cooldown"]["hoursIndicator"]["b"] = 0.7
			E.db["cooldown"]["hoursIndicator"]["g"] = 0.7
			E.db["cooldown"]["hoursIndicator"]["r"] = 0.7
			E.db["cooldown"]["minutesIndicator"]["b"] = 0.7
			E.db["cooldown"]["minutesIndicator"]["g"] = 0.7
			E.db["cooldown"]["minutesIndicator"]["r"] = 0.7
			E.db["cooldown"]["mmssColorIndicator"]["b"] = 0.7
			E.db["cooldown"]["mmssColorIndicator"]["g"] = 0.7
			E.db["cooldown"]["mmssColorIndicator"]["r"] = 0.7
			E.db["cooldown"]["secondsIndicator"]["b"] = 0.7
			E.db["cooldown"]["secondsIndicator"]["g"] = 0.7
			E.db["cooldown"]["secondsIndicator"]["r"] = 0.7
			E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["b"] = 0.7
			E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["g"] = 0.7
			E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = 0.7]]
			E.db["cooldown"]["auras"]["colors"]["text"]["b"] = 0.7
			E.db["cooldown"]["auras"]["colors"]["text"]["g"] = 0.7
			E.db["cooldown"]["auras"]["colors"]["text"]["r"] = 0.7
		else
			--[[E.db["cooldown"]["daysIndicator"]["b"] = valuecolors.b
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
			E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = valuecolors.r]]
			E.db["cooldown"]["auras"]["colors"]["text"]["b"] = valuecolors.b
			E.db["cooldown"]["auras"]["colors"]["text"]["g"] = valuecolors.g
			E.db["cooldown"]["auras"]["colors"]["text"]["r"] = valuecolors.r
		end

		--E:UpdateCooldownSettings('all')
		--E:CooldownSettings('all')
	end

	--leave it here for now
	if E.db.ElvUI_EltreumUI.otherstuff.colorbg then
		E.db.general.backdropcolor.b = valuecolors.b*0.3
		E.db.general.backdropcolor.g = valuecolors.g*0.3
		E.db.general.backdropcolor.r = valuecolors.r*0.3
		--E:UpdateMediaItems()
	end

	if E.db.unitframe.units.player.enable and E.db.unitframe.units.player.RestIcon.enable and E.db.ElvUI_EltreumUI.unitframes.blizzardresticonclasscolor and E.Modern then
		E.db.unitframe.units.player.RestIcon.color.r = valuecolors.r
		E.db.unitframe.units.player.RestIcon.color.g = valuecolors.g
		E.db.unitframe.units.player.RestIcon.color.b = valuecolors.b
		E.db.unitframe.units.player.RestIcon.color.a = 1.00
		E.db.unitframe.units.player.RestIcon.defaultColor = false
		_G["ElvUF_Player"]:Update() --update the unitframe so the rest icon updates
	end
end

--hide raid/party/arena frames in bgs/arenas bc of battlegroundenemies/gladiusEX or similar
function ElvUI_EltreumUI:ArenaBattlegroundGroupUnitframes()
	if E.private.unitframe.enable then
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
		if E.db.ElvUI_EltreumUI.unitframes.bgunitframes then
			if instanceType == "pvp" then
				E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
				E.db["unitframe"]["units"]["raid1"]["visibility"] = "hide"
				E.db["unitframe"]["units"]["raid2"]["visibility"] = "hide"
				E.db["unitframe"]["units"]["raid3"]["visibility"] = "hide"
			elseif instanceType == "arena" then
				E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
				if E.db.ElvUI_EltreumUI.unitframes.arenaunitframes then
					E.db["unitframe"]["units"]["arena"]["enable"] = false
				end
			else
				E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][@party1,noexists] hide;show"
				E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists][@raid21,exists] hide;show"
				E.db["unitframe"]["units"]["raid2"]["visibility"] = "[@raid21,noexists][@raid31,exists] hide;show"
				E.db["unitframe"]["units"]["raid3"]["visibility"] = "[@raid31,noexists] hide;show"
				if E.db.ElvUI_EltreumUI.unitframes.arenaunitframes then
					E.db["unitframe"]["units"]["arena"]["enable"] = true
				end
			end
			--E:UpdateUnitFrames()
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
			elseif (instanceType == "pvp") then
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
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
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
	if E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext and E.Classic then
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
--[[function ElvUI_EltreumUI:DynamicLevelStyleFilter()
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
			--E:UpdateNamePlates()
		end
	end
end]]

--Dynamic Spellsteal Nameplate Style Filter
--[[function ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" and E.db.nameplates.filters.EltreumSpellsteal and not InCombatLockdown() then
			if E.Mists or E.TBC or E.Wrath or E.Modern then
				if E.myclass == 'MAGE' then
					level = UnitLevel("player")
					if E.Retail then
						if level >= 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					elseif not E.Classic then
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
			--E:UpdateNamePlates()
		end
	end
end]]

local pagingClasses = {"DEATHKNIGHT", "DEMONHUNTER", "DRUID", "EVOKER", "HUNTER", "MAGE", "MONK", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR",}

local function getBarPagingTable(bar)
	if type(bar) == "table" then
		return bar
	elseif type(bar) == "number" or type(bar) == "string" then
		local barKey = tostring(bar):match("%d+")
		if barKey and E.db.actionbar and E.db.actionbar["bar"..barKey] then
			return E.db.actionbar["bar"..barKey].paging
		end
	end
end

--clear paging
function ElvUI_EltreumUI:ClearActionBarPaging(bar)
	local paging = getBarPagingTable(bar)
	if not paging then return end

	for _, unitclass in ipairs(pagingClasses) do
		paging[unitclass] = ""
	end
end

--set default action paging on a specified bar or paging table
function ElvUI_EltreumUI:SetActionBarPaging(bar)
	local paging = getBarPagingTable(bar)
	if not paging then return end

	local pagingBase = E.Classic and "[vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:5] 11;" or "[overridebar] 18; [vehicleui] 16; [possessbar] 16; [bonusbar:5] 11;"

	paging.DEATHKNIGHT = pagingBase
	paging.DEMONHUNTER = pagingBase
	paging.HUNTER = pagingBase
	paging.MAGE = pagingBase
	paging.MONK = pagingBase
	paging.PALADIN = pagingBase
	paging.SHAMAN = pagingBase

	--stance/form-based classes
	paging.WARRIOR = pagingBase.." [stance:1] 7; [stance:2] 8; [stance:3] 9;"
	paging.WARLOCK = E.Classic and "[vehicleui] 12; [overridebar] 14; [possessbar] 12; [form:1] 7; [bonusbar:5] 11;" or pagingBase

	--rogue
	local rogueVehicle = E.Classic and "[vehicleui] 12; [overridebar] 14; [possessbar] 12;" or "[overridebar] 18; [vehicleui] 16; [possessbar] 16;"
	paging.ROGUE = "[bonusbar:1] 7; [bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; "..rogueVehicle.." [bonusbar:2] 8; [bonusbar:5] 11;" --other other besides this was causing problems with shadow dance

	--druid
	local druidVehicle = E.Classic and "[vehicleui] 12; [overridebar] 14; [possessbar] 12;" or "[vehicleui] 16; [overridebar] 18; [possessbar] 16;"
	paging.DRUID = druidVehicle.." [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10; [bonusbar:5] 11;"

	--priest and evoker
	if E.Classic then
		paging.PRIEST = "[vehicleui] 12; [overridebar] 14; [possessbar] 16; [bonusbar:5] 11; [stance:1] 7;"
	else
		paging.PRIEST = E.Forever and "[overridebar] 18; [vehicleui] 16; [possessbar] 16; [form:1] 7; [bonusbar:5] 11;" or pagingBase --need to check for mind control in forever
		paging.EVOKER = pagingBase.." [bonusbar:1] 7;"
	end
end

--swap bar1 and bar4 action paging / visibility
function ElvUI_EltreumUI:ActionPagingSwap(targetBar)
	if not (E.private.actionbar and E.private.actionbar.enable) then return end

	if InCombatLockdown() then
		ElvUI_EltreumUI:Print(_G.ERR_NOT_IN_COMBAT)
		return
	end

	local hideVisibility = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
	local showVisibility = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"

	local function barHasPaging(barNum)
		local bar = E.db.actionbar and E.db.actionbar["bar"..barNum]
		local p = bar and bar.paging
		if not p then return false end
		if p[E.myclass] and p[E.myclass] ~= "" then
			return true
		end
		for _, unitclass in ipairs(pagingClasses) do
			if p[unitclass] and p[unitclass] ~= "" then
				return true
			end
		end
		return false
	end

	local swapMsg
	if not targetBar then
		--swap between bar1 and bar4
		if (E.db.actionbar.bar1 and E.db.actionbar.bar1.visibility == hideVisibility) or barHasPaging(4) then
			targetBar = 1
			swapMsg = "Actionbar Paging swapped to Bar1"
		elseif (E.db.actionbar.bar4 and E.db.actionbar.bar4.visibility == hideVisibility) or barHasPaging(1) then
			targetBar = 4
			swapMsg = "Actionbar Paging swapped to Bar4"
		else
			targetBar = 4
			swapMsg = "Actionbar Paging set to Bar4"
		end
	else
		if type(targetBar) == "string" then
			targetBar = tonumber(targetBar:match("%d+"))
		else
			targetBar = tonumber(targetBar)
		end

		if not targetBar or targetBar < 1 or targetBar > 10 then
			ElvUI_EltreumUI:Print("Invalid action bar number. Please choose a bar between 1 and 10.")
			return
		end
		swapMsg = "Actionbar Paging set to Bar"..targetBar
	end

	--set visibility on the target bar
	if E.db.actionbar and E.db.actionbar["bar"..targetBar] then
		E.db.actionbar["bar"..targetBar].visibility = showVisibility
		ElvUI_EltreumUI:SetActionBarPaging(targetBar)
	end

	--clear paging on other bars
	for i = 1, 10 do
		if i ~= targetBar then
			ElvUI_EltreumUI:ClearActionBarPaging(i)
		end
	end

	--set visiblity on the other bars
	for _, i in ipairs({ 1, 2, 3, 4, 5, 7, 8, 9 }) do
		if i ~= targetBar and E.db.actionbar and E.db.actionbar["bar"..i] then
			E.db.actionbar["bar"..i].visibility = hideVisibility
		end
	end

	--also on stance
	if E.db.actionbar and E.db.actionbar.stanceBar then
		E.db.actionbar.stanceBar.visibility = hideVisibility
	end

	ElvUI_EltreumUI:Print(swapMsg)
	E:StaticPopup_Show('CONFIG_RL')
end

--fix master loot?
if E.Mists or E.TBC or E.Wrath then
	hooksecurefunc(_G.MasterLooterFrame, 'Hide', function(self)
		self:ClearAllPoints()
	end)
end

-- Inspired by Luckyone's performance option. Thanks Luckyone!
function ElvUI_EltreumUI:EmptyDetailsTable()
	if IsAddOnLoaded('Details') then
		_G._detalhes.encounter_spell_pool = {}
		_G._detalhes.npcid_pool = {}
		_G._detalhes.spell_pool = {}
		_G._detalhes.spell_school_cache = {}
		_G._detalhes.boss_mods_timers = {}
		_G._detalhes.trinket_data = {}
		_G._detalhes.keystone_cache = {}
		_G._detalhes.raid_data = {}

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
