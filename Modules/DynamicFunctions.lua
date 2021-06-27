local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local UnitLevel = _G.UnitLevel
local myclass = E.myclass



--enforce correct spec profiles after loading if they are not the ones loaded in
--[[
function ElvUI_EltreumUI:EnforceProfiles()
	ElvDB
	["namespaces"]
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Auramaster - Stormrage"] = {
					"Eltreum Healer", -- [1]
					"Eltreum DPS/Tank", -- [2]
					"Eltreum DPS/Tank", -- [3]
					["enabled"] = true,
				},
			}.
		}

local isdualspec = ElvDB[namespaces]["LibDualSpec-1.0"]["char"][E.mynameRealm]["enabled"]
print (isdualspec)

end

ElvDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Auramaster - Stormrage"] = {
					"Eltreum Healer", -- [1]
					"Eltreum DPS/Tank", -- [2]
					"Eltreum DPS/Tank", -- [3]
					["enabled"] = true,
				},
			},
		},
	},
}

local profileKey = ElvDB.profileKeys
	local mynamerealm = ElvDB.profileKeys[E.mynameRealm]  --returns current profile?
	local data2 = ElvDB.profiles[profileKey] --returns nil

	print(profileKey)
	print(mynamerealm)



	local function tprint (tbl, indent)
	  if not indent then indent = 0 end
	  local toprint = string.rep(" ", indent) .. "{\r\n"
	  indent = indent + 2
	  for k, v in pairs(tbl) do
	    toprint = toprint .. string.rep(" ", indent)
	    if (type(k) == "number") then
	      toprint = toprint .. "[" .. k .. "] = "
	    elseif (type(k) == "string") then
	      toprint = toprint  .. k ..  "= "
	    end
	    if (type(v) == "number") then
	      toprint = toprint .. v .. ",\r\n"
	    elseif (type(v) == "string") then
	      toprint = toprint .. "\"" .. v .. "\",\r\n"
	    elseif (type(v) == "table") then
	      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
	    else
	      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
	    end
	  end
	  toprint = toprint .. string.rep(" ", indent-2) .. "}"
	  return toprint
	end
	print (tprint(profileKey))





]]--













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
