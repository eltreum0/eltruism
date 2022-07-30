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

function ElvUI_EltreumUI:BattlegroundGroupUnitframes()
	if E.db.ElvUI_EltreumUI.otherstuff.bgunitframes and E.private.unitframe.enable then
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
			E.db["unitframe"]["units"]["raid"]["visibility"] = "hide"
			E.db["unitframe"]["units"]["raid40"]["visibility"] = "hide"
		elseif E.Retail and IsAddOnLoaded('GladiusEx') and instanceType == "arena" then
			E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
		else
			E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][nogroup] hide;show"
			E.db["unitframe"]["units"]["raid"]["visibility"] = "[@raid6,noexists][@raid21,exists] hide;show"
			E.db["unitframe"]["units"]["raid40"]["visibility"] = "[@raid21,noexists] hide;show"
		end

		--E:StaggeredUpdateAll(nil, true)
		E:UpdateUnitFrames()
	end
end

function ElvUI_EltreumUI:ArenaUnitframes()
	if E.db.ElvUI_EltreumUI.otherstuff.arenaunitframes and E.private.unitframe.enable then
		local _, instanceType = IsInInstance()
		if instanceType == "arena" then
			ElvUF_Arena1:Hide()
			ElvUF_Arena2:Hide()
			ElvUF_Arena3:Hide()
			ElvUF_Arena4:Hide()
			--ConsoleExec("ElvUF_Arena4:Hide()")
			ElvUF_Arena5:Hide()
		end
	end
end

function ElvUI_EltreumUI:DynamicBuffs()
	if E.db.ElvUI_EltreumUI.otherstuff.arenabuffs and E.private.unitframe.enable and not InCombatLockdown() then
		local _, instanceType = IsInInstance()
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
	if E.db.ElvUI_EltreumUI.dynamicdatatext.enable then
		if not E.db.movers then E.db.movers = {} end
		if E.myclass == 'HUNTER' or E.myclass == 'WARLOCK' or E.myclass == 'WARRIOR' or E.myclass == 'ROGUE' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Eltruism Ammo"
		elseif E.myclass == 'PALADIN' or E.myclass == 'MAGE' or E.myclass == 'PRIEST' or E.myclass == 'DRUID' or E.myclass == 'SHAMAN' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Friends"
		end
	end
end

--Dynamic Level Nameplate Style Filter
function ElvUI_EltreumUI:DynamicLevelStyleFilter()
	if E.db.ElvUI_EltreumUI.nameplatelevel.enable and E.db.nameplates.filters.EltreumLevel and not InCombatLockdown() then
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

			local level = UnitLevel("player")
			if E.Classic or E.Retail then
				if level < 60 then
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
				elseif level == 60 then
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
			elseif E.TBC then
				if level < 70 then
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
				elseif level == 70 then
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
					end
				end
			elseif E.Wrath then
				if level < 80 then
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
				elseif level == 80 then
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
					end
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
			if E.Wrath or E.TBC or E.Retail then
				if E.myclass == 'MAGE' then
					local level = UnitLevel("player")
					if E.Retail then
						if level >= 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					elseif E.Wrath or E.TBC then
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
			E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10; [vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1] 7;"
			E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
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
		elseif E.db.actionbar.bar4.visibility == "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; show;"
			E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10; [vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1] 7;"
			E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
			E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;"
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
		end
	end
end

--fix master loot?
if E.Wrath or E.TBC then
	hooksecurefunc(_G.MasterLooterFrame, 'Hide', function(self)
		self:ClearAllPoints()
	end)
end

-- Inspired by Luckyone's performance option. Thanks Luckyone!
function ElvUI_EltreumUI:EmptyDetailsTable()
	_detalhes.encounter_spell_pool = {}
	_detalhes.npcid_pool = {}
	_detalhes.spell_pool = {}
	_detalhes.spell_school_cache = {}
	_detalhes.boss_mods_timers = {}
end

--Dynamic Experience Bar Mouseover
function ElvUI_EltreumUI:DynamicExperienceDatabar()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		local level = UnitLevel("player")
		if E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar then
			if E.Retail or E.Classic then
				if level < 60 then
					E.db.databars.experience.mouseover = false
					E.db.databars.experience.enable = true
				elseif level == 60 then
					E.db.databars.experience.mouseover = true
					E.db.databars.experience.enable = false
				end
			elseif E.TBC then
				if level < 70 then
					E.db.databars.experience.mouseover = false
					E.db.databars.experience.enable = true
				elseif level == 70 then
					E.db.databars.experience.mouseover = true
					E.db.databars.experience.enable = false
				end
			elseif E.Wrath then
				if level < 80 then
					E.db.databars.experience.mouseover = false
					E.db.databars.experience.enable = true
				elseif level == 80 then
					E.db.databars.experience.mouseover = true
					E.db.databars.experience.enable = false
				end
			end
			E:UpdateDataBars()
		end
	end
end

function ElvUI_EltreumUI:TransparentChat()
	E.db["chat"]["fadeUndockedTabs"] = true
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["panelTabTransparency"] = true
	E.db["chat"]["fadeTabsNoBackdrop"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
	E:UpdateChat()
	E:UpdateLayout()
	E:UpdateDataBars()
	E:UpdateDataTexts()
	--E:StaggeredUpdateAll()
	if _G["EltruismRightChatShadowFrame"] then
		_G["EltruismRightChatShadowFrame"]:Hide()
	end
	if _G["EltruismLeftChatShadowFrame"] then
		_G["EltruismLeftChatShadowFrame"]:Hide()
	end
	ElvUI_EltreumUI:Print("Chat set to Transparent mode")
end

function ElvUI_EltreumUI:DarkChat()
	E.db["chat"]["fadeUndockedTabs"] = false
	E.db["chat"]["panelBackdrop"] = "SHOWBOTH"
	E.db["chat"]["panelTabTransparency"] = false
	E.db["chat"]["fadeTabsNoBackdrop"] = false
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = true
	E:UpdateChat()
	E:UpdateLayout()
	E:UpdateDataBars()
	E:UpdateDataTexts()
	--E:StaggeredUpdateAll()
	if _G["EltruismRightChatShadowFrame"] then
		_G["EltruismRightChatShadowFrame"]:Show()
	end
	if _G["EltruismLeftChatShadowFrame"] then
		_G["EltruismLeftChatShadowFrame"]:Show()
	end
	ElvUI_EltreumUI:Print("Chat set to Dark mode")
end

--automatically space the actionbar if borders is enabled
function ElvUI_EltreumUI:ActionbarBorderAdjust()
	if E.db.ElvUI_EltreumUI.borders.borderautoadjust then
		--if not using one of my profiles then disable auto adjust to prevent overwriting settings and return
		if not (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
			E.db.ElvUI_EltreumUI.borders.borderautoadjust = false
		else
			if E.db.ElvUI_EltreumUI.borders.borders then
				--general border settings for both profiles
				E.db.ElvUI_EltreumUI.borders.texture = "Eltreum-Border-1"
				--E.db.ElvUI_EltreumUI.borders.classcolor = true
				E.db.ElvUI_EltreumUI.borders.auraborder = true
				E.db.ElvUI_EltreumUI.borders.aurasizex = 53
				E.db.ElvUI_EltreumUI.borders.aurasizey = 53
				E.db.ElvUI_EltreumUI.borders.chatborder = true
				E.db.ElvUI_EltreumUI.borders.leftchatborderx = 432
				E.db.ElvUI_EltreumUI.borders.leftchatbordery = 224
				E.db.ElvUI_EltreumUI.borders.rightchatborderx = 432
				E.db.ElvUI_EltreumUI.borders.rightchatbordery = 224
				E.db.ElvUI_EltreumUI.borders.partyborders = true
				E.db.ElvUI_EltreumUI.borders.raidborders = true
				E.db.ElvUI_EltreumUI.borders.raid40borders = true
				E.db.ElvUI_EltreumUI.borders.playertargetsize = 20
				E.db.ElvUI_EltreumUI.borders.baredgesize = 13
				E.db.ElvUI_EltreumUI.borders.playertargetcastsize = 20
				E.db.ElvUI_EltreumUI.borders.petsize = 20
				E.db.ElvUI_EltreumUI.borders.totembar = true
				E.db.ElvUI_EltreumUI.borders.groupsize = 14
				E.db.ElvUI_EltreumUI.borders.focussize = 20
				E.db.ElvUI_EltreumUI.borders.bosssize = 20
				E.db.ElvUI_EltreumUI.borders.minimapsize = 15
				E.db.ElvUI_EltreumUI.borders.chatsize = 13
				E.db.ElvUI_EltreumUI.borders.aurasize = 13
				E.db.ElvUI_EltreumUI.borders.powerbarborder = false
				E.db.ElvUI_EltreumUI.borders.powerbarsize = 4
				E.db.ElvUI_EltreumUI.borders.xpowerbar = 138.8
				E.db.ElvUI_EltreumUI.borders.ypowerbar = 12
				E.db.ElvUI_EltreumUI.borders.minimapborder = true
				E.db.ElvUI_EltreumUI.borders.petborder = true
				E.db.ElvUI_EltreumUI.borders.playerborder = true
				E.db.ElvUI_EltreumUI.borders.xplayer = 302
				E.db.ElvUI_EltreumUI.borders.yplayer = 75
				E.db.ElvUI_EltreumUI.borders.playercastborder = true
				E.db.ElvUI_EltreumUI.borders.yplayercast = 58
				E.db.ElvUI_EltreumUI.borders.targetborder = true
				E.db.ElvUI_EltreumUI.borders.xtarget = 302.8
				E.db.ElvUI_EltreumUI.borders.ytarget = 75
				E.db.ElvUI_EltreumUI.borders.targetcastborder = true
				E.db.ElvUI_EltreumUI.borders.xcasttarget = 272
				E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
				E.db.ElvUI_EltreumUI.borders.targettargetborder = true
				E.db.ElvUI_EltreumUI.borders.ytargettarget = 75
				E.db.ElvUI_EltreumUI.borders.focusborder = true
				E.db.ElvUI_EltreumUI.borders.xfocus = 224
				E.db.ElvUI_EltreumUI.borders.yfocus = 72
				E.db.ElvUI_EltreumUI.borders.bossborder = true
				E.db.ElvUI_EltreumUI.borders.minimapsizex = 226
				E.db.ElvUI_EltreumUI.borders.focuscastborder = true
				E.db.ElvUI_EltreumUI.borders.xcastfocus = 365
				E.db.ElvUI_EltreumUI.borders.ycastfocus = 62

				if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
					E.db.ElvUI_EltreumUI.borders.minimapsizey = 225
				else
					E.db.ElvUI_EltreumUI.borders.minimapsizey = 247
				end
				E.db.ElvUI_EltreumUI.borders.stancexborder = 49
				E.db.ElvUI_EltreumUI.borders.stanceyborder = 42
				E.db.ElvUI_EltreumUI.borders.petactionxborder = 49
				E.db.ElvUI_EltreumUI.borders.petactionyborder = 44
				E.db.ElvUI_EltreumUI.borders.petactionedgesize = 13

				E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 5
				E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,-1"
				E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,1,-1"
				E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-4"

				if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then
					E.db["actionbar"]["bar1"]["buttonSpacing"] = 4
					E.db["actionbar"]["bar2"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar3"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar4"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar5"]["buttonSpacing"] = 5
					E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,221"
					E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,187"
					E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,154"
					E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,121"
					if E.db.ElvUI_EltreumUI.otherstuff.alternativegroups == false then
						E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-4"
						E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-4"
						E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 7
						E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 3
						E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 6
						E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 3
					end
					E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 272
					E.db["ElvUI_EltreumUI"]["borders"]["xtargettarget"] = 132.8
					E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 65
					E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
					E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 56
					E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 50
					E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 56
					E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 50
					E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 56
					E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 50
					E.db["ElvUI_EltreumUI"]["borders"]["bar5xborder"] = 56
					E.db["ElvUI_EltreumUI"]["borders"]["bar5yborder"] = 50
					E.db.ElvUI_EltreumUI.borders.partysizex = 222
					E.db.ElvUI_EltreumUI.borders.partysizey = 98
					E.db.ElvUI_EltreumUI.borders.raidsizex = 140
					E.db.ElvUI_EltreumUI.borders.raidsizey = 63
					E.db.ElvUI_EltreumUI.borders.xboss = 250
					E.db.ElvUI_EltreumUI.borders.yboss = 87
					E.db.ElvUI_EltreumUI.borders.raid40sizex = 140
					E.db.ElvUI_EltreumUI.borders.raid40sizey = 63
					E.db.ElvUI_EltreumUI.borders.xcasttarget = 272
					E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
					E.db.ElvUI_EltreumUI.borders.petsizex = 192
					E.db.ElvUI_EltreumUI.borders.totemxborder = 51
					E.db.ElvUI_EltreumUI.borders.totemyborder = 51

					if E.Wrath then
						E.db["general"]["totems"]["spacing"] = 5
						E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
					end
					if not E.Retail then
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,97"
					end
				elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
					E.db["actionbar"]["bar1"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar2"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar3"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar4"]["buttonSpacing"] = 5
					E.db["actionbar"]["bar5"]["buttonSpacing"] = 5
					E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
					E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,278"
					E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,311,249"
					E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,249"
					E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-311,249"
					E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-308,309"
					E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 294
					E.db["ElvUI_EltreumUI"]["borders"]["xtargettarget"] = 162
					E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 61
					E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar5xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar5yborder"] = 46
					E.db.ElvUI_EltreumUI.borders.partysizex = 173
					E.db.ElvUI_EltreumUI.borders.partysizey = 98
					E.db.ElvUI_EltreumUI.borders.raidsizex = 172
					E.db.ElvUI_EltreumUI.borders.raidsizey = 68
					E.db.ElvUI_EltreumUI.borders.xboss = 248
					E.db.ElvUI_EltreumUI.borders.yboss = 78
					E.db.ElvUI_EltreumUI.borders.raid40sizex = 122
					E.db.ElvUI_EltreumUI.borders.raid40sizey = 68
					E.db.ElvUI_EltreumUI.borders.xcasttarget = 296
					E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
					E.db.ElvUI_EltreumUI.borders.petsizex = 130
					E.db.ElvUI_EltreumUI.borders.totemxborder = 46
					E.db.ElvUI_EltreumUI.borders.totemyborder = 46

					if E.Wrath then
						E.db["general"]["totems"]["spacing"] = 5
					end
				end
			elseif not E.db.ElvUI_EltreumUI.borders.borders then
				E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,0"
				E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,1,0"
				E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-3"
				E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 3

				if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then
					E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
					E.db["actionbar"]["bar2"]["buttonSpacing"] = 2
					E.db["actionbar"]["bar3"]["buttonSpacing"] = 2
					E.db["actionbar"]["bar4"]["buttonSpacing"] = 2
					E.db["actionbar"]["bar5"]["buttonSpacing"] = 2
					E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,221"
					E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,190"
					E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,159"
					E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,128"
					E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,106"
					if E.db.ElvUI_EltreumUI.otherstuff.alternativegroups == false then
						E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
						E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
						E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 3
						E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 3
					end
					if E.Wrath then
						E.db["general"]["totems"]["spacing"] = 3
					end
				elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
					E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
					E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
					E.db["actionbar"]["bar3"]["buttonSpacing"] = 3
					E.db["actionbar"]["bar4"]["buttonSpacing"] = 3
					E.db["actionbar"]["bar5"]["buttonSpacing"] = 3
					E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
					E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,280"
					E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,308,253"
					E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,253"
					E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-308,253"
					E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-308,308"
					if E.Wrath then
						E.db["general"]["totems"]["spacing"] = 3
					end
				end
			end
			if E.Wrath then --for some reason wrath needs to do this or totems will error when it updates positions due to setpoint
				local AB = E:GetModule('ActionBars')
				AB:UpdateTotemBindings()
			end
			E:UpdateActionBars()
			E:UpdateMoverPositions()
		end
	end
end

--based on elvui mail datatext
local mailsoundframe = CreateFrame("FRAME")
--mailsoundframe:RegisterEvent("MAIL_INBOX_UPDATE")
mailsoundframe:RegisterEvent("UPDATE_PENDING_MAIL")
local mailthrottle = 0
mailsoundframe:SetScript("OnEvent", function()
	if HasNewMail() == true and E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable and not InCombatLockdown() and mailthrottle == 0 then
		PlaySoundFile(E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.otherstuff.mailsound) , "Master")
		mailthrottle = 1
		C_Timer.After(2, function()
			mailthrottle = 0
		end)
	end
end)
