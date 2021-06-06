local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn
local _G = _G
local UnitLevel = _G.UnitLevel

--Dynamically swap datatexts based on player class
function ElvUI_EltreumUI:DynamicClassicDatatext()
	local myclass = E.myclass
	if not E.db.movers then E.db.movers = {} end
	if myclass == 'HUNTER' or myclass == 'WARLOCK' then
		E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Ammo"
	else
		E.db["datatexts"]["panels"]["LeftChatDataPanel"][3] = "Friends"
	end
end

--Dynamic Level Nameplate Style Filter
function ElvUI_EltreumUI:DynamicLevelStyleFilter()
	if E.db.ElvUI_EltreumUI.nameplatelevel.enable then
		local level = UnitLevel("player")
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.Retail then
			if level == 60 then
				E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
			end
		elseif ElvUI_EltreumUI.TBC then
			if level == 70 then
				E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
			end
		end
	else
		return
	end
end
