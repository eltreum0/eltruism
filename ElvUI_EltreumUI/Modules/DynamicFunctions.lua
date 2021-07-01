local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UnitLevel = _G.UnitLevel
local myclass = E.myclass
local IsInInstance = _G.IsInInstance

function ElvUI_EltreumUI:BattlegroundGroupUnitframes()
	if E.db.ElvUI_EltreumUI.otherstuff.bgunitframes then
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" then
			E.db["unitframe"]["units"]["raid"]["visibility"] = "hide"
			E.db["unitframe"]["units"]["raid40"]["visibility"] = "hide"
		else
			E.db["unitframe"]["units"]["raid"]["visibility"] = "[@raid6,noexists][@raid21,exists] hide;show"
			E.db["unitframe"]["units"]["raid40"]["visibility"] = "[@raid21,noexists] hide;show"
		end
	end
end

function ElvUI_EltreumUI:ArenaUnitframes()
	if E.db.ElvUI_EltreumUI.otherstuff.arenaunitframes then
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

function  ElvUI_EltreumUI:DynamicBuffs()
	if E.db.ElvUI_EltreumUI.otherstuff.arenabuffs then
		local _, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = true
			E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = true
			ElvUI_EltreumUI:Print(L["Buffs have been updated for Arenas"])
		elseif instanceType == "none" then
			--if not E.db.movers then E.db.movers = {} end
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = false
			E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
			--E.db["unitframe"]["units"]["player"]["buffs"]["enable"] = false
			ElvUI_EltreumUI:Print(L["Buffs have been updated for Open World"])
		end
		--E:StaggeredUpdateAll(nil, true)
		--eltruism defaults
		--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = true
		--E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = true
		--E.db["unitframe"]["units"]["player"]["buffs"]["enable"] = false
	end
end

--Dynamically datatext swap based on player class
function ElvUI_EltreumUI:DynamicClassicDatatext()
	if E.db.ElvUI_EltreumUI.dynamicdatatext.enable then

		if not E.db.movers then E.db.movers = {} end
		if myclass == 'HUNTER' or myclass == 'WARLOCK' or myclass == 'WARRIOR' or myclass == 'ROGUE' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Eltruism Ammo"
		elseif myclass == 'PALADIN' or myclass == 'MAGE' or myclass == 'PRIEST' or myclass == 'DRUID' or myclass == 'SHAMAN' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Friends"
		end
	end
end

--Dynamic Level Nameplate Style Filter
function ElvUI_EltreumUI:DynamicLevelStyleFilter()
	if E.db.ElvUI_EltreumUI.nameplatelevel.enable then
		if not E.private.ElvUI_EltreumUI.install_version then
			return
		else
			local level = UnitLevel("player")
			if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.Retail then
				if level == 60 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
					end
				elseif level < 60 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
					end
				end
			elseif ElvUI_EltreumUI.TBC then
				if level == 70 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
					end
				elseif level < 70 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
					end
				end
			end
		end
	end
end

--Dynamic Spellsteal Nameplate Style Filter
function ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
			if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Retail then
				if myclass == 'MAGE' then
					local level = UnitLevel("player")
					if ElvUI_EltreumUI.Retail then
						if level >= 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					elseif ElvUI_EltreumUI.TBC then
						if level == 70 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 70 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					end
				else
					E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
				end
			elseif ElvUI_EltreumUI.Classic then
				if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
					E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
				end
			end
		end
	end
end
