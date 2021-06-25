local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UnitLevel = _G.UnitLevel
local myclass = E.myclass

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
