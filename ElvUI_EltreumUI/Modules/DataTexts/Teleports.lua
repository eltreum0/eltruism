local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local DT = E:GetModule("DataTexts")
local GetCombatRatingBonus = _G.GetCombatRatingBonus
local math = _G.math
local GetItemInfo = _G.GetItemInfo
local GetItemCount = _G.GetItemCount
local string = _G.string
local pairs = _G.pairs
local GetItemIcon = _G.GetItemIcon
local PlayerHasToy = _G.PlayerHasToy
local C_ToyBox = _G.C_ToyBox
local GetItemCooldown = (E.Retail or E.Wrath) and C_Container.GetItemCooldown or _G.GetItemCooldown
local CreateFrame = _G.CreateFrame
local GetBindLocation = _G.GetBindLocation
local GetTime = _G.GetTime
local GetSpellTexture = _G. GetSpellTexture
local GetSpellInfo = _G.GetSpellInfo
local IsSpellKnown = _G.IsSpellKnown
local GetSpellCooldown = _G.GetSpellCooldown
local tostring = _G.tostring
local mod = _G.mod
local IsUsableItem = _G.IsUsableItem
local hsIsReady = true
local USE = _G.USE or "Use"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------hearthstone/tp item datatext
--based yet again on elvui config
--most from https://www.wowhead.com/item=6948/hearthstone#comments
local TeleportsItems = {
	6948, --hearthstone
	22630, --atiesh-greatstaff-of-the-guardian
	22631, --atiesh-greatstaff-of-the-guardian
	22632, --atiesh-greatstaff-of-the-guardian
	22589, --atiesh-greatstaff-of-the-guardian
	54452, --ethereal-portal
	93672, --dark-portal
	184871, --dark-portal 2?
	110560, --garrison-hearthstone
	140192, --dalaran-hearthstone
	141605, --flight-masters-whistle
	128353,--admirals-compass
	18984, --dimensional-ripper-everlook
	18986, --ultrasafe-transporter-gadgetzan
	30542, --dimensional-ripper-area-52
	30544, --ultrasafe-transporter-toshleys-station
	48933, --wormhole-generator-northrend
	87215, --wormhole-generator-pandaria
	112059, --wormhole-centrifuge
	151652, --wormhole-generator-argus
	168807,--wormhole-generator-kultiras
	168808,--wormhole-generator-zandalar
	172924, --wormhole-generator-shadowlands
	198156, --wyrmhole-dragonflight
	32757, --blessed-medallion-of-karabor
	40585, --signet-of-the-kirin-tor
	40586, --band-of-the-kirin-tor
	48954, --etched-band-of-the-kirin-tor
	48955, --etched-loop-of-the-kirin-tor
	48956, --etched-ring-of-the-kirin-tor
	48957, --etched-signet-of-the-kirin-tor
	45688, --inscribed-band-of-the-kirin-tor
	45689, --inscribed-loop-of-the-kirin-tor
	45690, --inscribed-ring-of-the-kirin-tor
	45691, --inscribed-signet-of-the-kirin-tor
	44934, --loop-of-the-kirin-tor
	44935, --ring-of-the-kirin-tor
	51557, --runed-signet-of-the-kirin-tor
	51558, --runed-loop-of-the-kirin-tor
	51559, --runed-ring-of-the-kirin-tor
	51560, --runed-band-of-the-kirin-tor
	139599, --empowered-ring-of-the-kirin-tor
	63206, --wrap-of-unity
	63207, --wrap-of-unity
	63352, --shroud-of-cooperation
	63353, --shroud-of-cooperation
	65274, --cloak-of-coordination
	65360, --cloak-of-coordination
	46874, --argent-crusaders-tabard
	63378, --hellscreams-reach-tabard
	63379, --baradins-wardens-tabard
	28585, --ruby-slippers
	37863, --direbrews-remote
	43824,--the-schools-of-arcane-magic-mastery
	50287, --boots-of-the-bay
	52251, --jainas-locket
	64457, --the-last-relic-of-argus
	95050, --the-brassiest-knuckle
	95051, --the-brassiest-knuckle
	103678, --time-lost-artifact
	118663,--relic-of-karabor
	118907, --pit-fighters-punching-ring
	118908, --pit-fighters-punching-ring
	129276,--beginners-guide-to-dimensional-rifting
	128502,--hunters-seeking-crystal
	138448,--emblem-of-margoss
	142298, --astonishingly-scarlet-slippers
	142469, --violet-seal-of-the-grand-magus
	144391, --pugilists-powerful-punching-ring
	151016, --fractured-necrolyte-skull
	180817, --cypher-of-relocation
	29796, --socrethars-teleportation-stone
	61379, --gidwins-hearthstone
	68808, --heros-hearthstone
	68809, --veterans-hearthstone
	92510, --voljins-hearthstone
	35230, --darnarians-scroll-of-teleportation
	119183, --scroll-of-risky-recall
	139590, --scroll-of-teleport-ravenholdt
	141015, --scroll-of-town-portal-kaldelar
	141014, --scroll-of-town-portal-sashjtar
	141017, --scroll-of-town-portal-liantril
	141016, --scroll-of-town-portal-faronaar
	141013, --scroll-of-town-portal-shalanir
	142543, --scroll-of-town-portal
	95567, --kirin-tor-beacon
	95568, --sunreaver-beacon
	37118, --scroll-of-recall
	44314, --scroll-of-recall-ii
	44315, --scroll-of-recall-iii
	58487, --potion-of-deepholm
	17690, --frostwolf-insignia-rank-1
	17691, --stormpike-insignia-rank-1
	17900, --stormpike-insignia-rank-2
	17901, --stormpike-insignia-rank-3
	17902, --stormpike-insignia-rank-4
	17903, --stormpike-insignia-rank-5
	17904, --stormpike-insignia-rank-6
	17905, --frostwolf-insignia-rank-2
	17906, --frostwolf-insignia-rank-3
	17907, --frostwolf-insignia-rank-4
	17908, --frostwolf-insignia-rank-5
	17909, --frostwolf-insignia-rank-6
}
local TeleportsSpells = {
	556, --astral-recall
	50977, --death-gate
	126892, --zen-pilgrimage
	193753, --dreamwalk
	193759, --teleport-hall-of-the-guardian
	131204, --path-of-the-jade-serpent
	131205, --path-of-the-stout-brew
	131206, --path-of-the-shado-pan
	131222, --path-of-the-mogu-king
	131225, --path-of-the-setting-sun
	131228, --path-of-the-black-ox
	131229, --path-of-the-scarlet-mitre
	131231, --path-of-the-scarlet-blade
	131232, --path-of-the-necromancer
	159895, --path-of-the-bloodmaul
	159896, --path-of-the-iron-prow
	159897, --path-of-the-vigilant
	159898, --path-of-the-skies
	159899, --path-of-the-crescent-moon
	159900, --path-of-the-dark-rail
	159901, --path-of-the-verdant
	159902, --path-of-the-burning-mountain
	354462, --path-of-the-courageous
	354463, --path-of-the-plagued
	354464, --path-of-the-misty-forest
	354465, --path-of-the-sinful-soul
	354467, --path-of-the-undefeated
	354468, --path-of-the-scheming-loa
	354469, --path-of-the-stone-warden
	367416, --path-of-the-streetwise-merchant
	373262, --path-of-the-fallen-guardian
	373274, --path-of-the-scrappy-prince
	373190, --path-of-the-sire
	373191, --path-of-the-tormented-soul
	373192, --path-of-the-first-ones
	393222, --path-of-the-watchers-legacy
	393273, --path-of-the-draconic-diploma
	393256, --path-of-the-clutch-defender
	393262, --path-of-the-windswept-plains
	393283, --path-of-the-titanic-reservoir
	393276, --path-of-the-obsidian-hoard
	393279, --path-of-arcane-secrets
	393764, --path-of-proven-worth
	393766, --path-of-the-grand-magistrix
	393267, --path-of-the-rotting-woods
}
--the maw to avoid cypher showing up everywhere
local mawIDs = {
	["11400"] = true,
	["1543"] = true,
	["1550"] = true,
	["2456"] = true,
	["2364"] = true,
}
local teleportupdate = CreateFrame("FRAME")
local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 1
local displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()

local function EltruismTeleportsOnEvent(self)
	local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
	local start, duration = GetItemCooldown(6948)
	if not start then return end
	local cooldown = start + duration - GetTime()
	if cooldown >= 2 then
		displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t |cffED7474"..GetBindLocation().."|r"
		hsIsReady = false
	elseif cooldown <= 0 then
		displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()
		hsIsReady = true
	end
	self.text:SetText(displayStringEltruismTeleports)
end

local function EltruismTeleportsOnEnter(self)
	DT.tooltip:ClearLines()
	local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
	for i,v in pairs(TeleportsItems) do
		local texture = GetItemIcon(v)
		local name = GetItemInfo(v)
		local hasItem = GetItemCount(v)

		if v == 180817 then --hide cypher if outside the maw
			local mapID = not E.Retail and tostring(_G.WorldMapFrame:GetMapID()) or tostring(C_Map.GetBestMapForUnit("player"))
			--print(mapID)
			if not mawIDs[mapID] then
				hasItem = 0
			end
		end

		if texture and name and ((hasItem > 0 and IsUsableItem(v)) or (E.Retail and PlayerHasToy(v) and C_ToyBox.IsToyUsable(v))) then
			local start, duration = GetItemCooldown(v)
			local cooldown = start + duration - GetTime()
			if cooldown >= 2 then
				local hours = math.floor(cooldown /3600)
				local minutes = math.floor(cooldown / 60)
				local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
				if hours >= 1 then
					minutes = math.floor(mod(cooldown,3600)/60)
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
				else
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
				end
			elseif cooldown <= 0 then
				DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..name.."|r", "|cff00FF00"..L["Ready"].."|r")
			end
		end
	end
	for i,v in pairs(TeleportsSpells) do
		local texture = GetSpellTexture(v)
		local name = GetSpellInfo(v)
		local hasSpell = IsSpellKnown(v)
		if texture and name and hasSpell then
			local start, duration = GetSpellCooldown(v)
			local cooldown = start + duration - GetTime()
			if cooldown >= 2 then
				local hours = math.floor(cooldown /3600)
				local minutes = math.floor(cooldown / 60)
				local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
				if hours >= 1 then
					minutes = math.floor(mod(cooldown,3600)/60)
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
				else
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
				end
			elseif cooldown <= 0 then
				DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..name.."|r", "|cff00FF00"..L["Ready"].."|r")
			end
		end
	end
	local start, duration = GetItemCooldown(6948)
	local cooldown = start + duration - GetTime()
	if cooldown >= 2 then
		displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t |cffdb3030"..GetBindLocation().."|r"
		hsIsReady = false
	else
		displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()
		hsIsReady = true
	end
	DT.tooltip:AddDoubleLine(L["Double Click:"], USE.." "..GetItemInfo(6948))
	DT.tooltip:Show()

	teleportupdate:SetScript("OnUpdate", function(self, elapsed)
		--print("onupdate spam"..math.random(1,99))
		TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
		if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
			TimeSinceLastUpdate = 0
			DT.tooltip:ClearLines()
			local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
			for i,v in pairs(TeleportsItems) do
				local texture = GetItemIcon(v)
				local name = GetItemInfo(v)
				local hasItem = GetItemCount(v)

				if v == 180817 then --hide cypher if outside the maw
					local mapID = not E.Retail and tostring(_G.WorldMapFrame:GetMapID()) or tostring(C_Map.GetBestMapForUnit("player"))
					if not mawIDs[mapID] then
						hasItem = 0
					end
				end

				if texture and name and (hasItem > 0 or (E.Retail and PlayerHasToy(v) and C_ToyBox.IsToyUsable(v)) ) then
					local start, duration = GetItemCooldown(v)
					local cooldown = start + duration - GetTime()
					if cooldown >= 2 then
						local hours = math.floor(cooldown /3600)
						local minutes = math.floor(cooldown / 60)
						local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
						if hours >= 1 then
							minutes = math.floor(mod(cooldown,3600)/60)
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
						else
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
						end
					elseif cooldown <= 0 then
						DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..name.."|r", "|cff00FF00"..L["Ready"].."|r")
					end
				end
			end
			for i,v in pairs(TeleportsSpells) do
				local texture = GetSpellTexture(v)
				local name = GetSpellInfo(v)
				local hasSpell = IsSpellKnown(v)
				if texture and name and hasSpell then
					local start, duration = GetSpellCooldown(v)
					local cooldown = start + duration - GetTime()
					if cooldown >= 2 then
						local hours = math.floor(cooldown /3600)
						local minutes = math.floor(cooldown / 60)
						local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
						if hours >= 1 then
							minutes = math.floor(mod(cooldown,3600)/60)
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
						else
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..name.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
						end
					elseif cooldown <= 0 then
						DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..name.."|r", "|cff00FF00"..L["Ready"].."|r")
					end
				end
			end
			local start, duration = GetItemCooldown(6948)
			local cooldown = start + duration - GetTime()
			if cooldown >= 2 then
				displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t |cffdb3030"..GetBindLocation().."|r"
				hsIsReady = false
			else
				displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:2:62:2:62|t "..GetBindLocation()
				hsIsReady = true
			end
			DT.tooltip:AddDoubleLine(L["Double Click:"], USE.." "..GetItemInfo(6948))
			DT.tooltip:Show()
		end
	end)
end

local function EltruismTeleportsOnLeave()
	teleportupdate:SetScript("OnUpdate", nil)
	if not InCombatLockdown() then
		E:Delay(1, function()_G["EltruismHearthStoneSecureButton"]:Hide() end) --delay because showing leaves the datatext so this would trigger early
	end
end

_G["EltruismHearthStoneSecureButton"] = _G["EltruismHearthStoneSecureButton"] or CreateFrame('Button', "EltruismHearthStoneSecureButton", nil, 'SecureActionButtonTemplate')
_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'item')
local name = GetItemInfo(6948)
_G["EltruismHearthStoneSecureButton"]:SetAttribute('item', name)
_G["EltruismHearthStoneSecureButton"]:RegisterForClicks("AnyUp", "AnyDown")
local function EltruismTeleportsOnClick(self, button)
	if InCombatLockdown() then return end
	if not hsIsReady and E.myclass == "SHAMAN" then
		_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'spell')
		local name = GetSpellInfo(556)
		_G["EltruismHearthStoneSecureButton"]:SetAttribute('spell', name)
	else
		_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'item')
		local name = GetItemInfo(6948)
		_G["EltruismHearthStoneSecureButton"]:SetAttribute('item', name)
	end
	_G["EltruismHearthStoneSecureButton"]:RegisterForClicks("AnyUp", "AnyDown")
	_G["EltruismHearthStoneSecureButton"]:Show()
	_G["EltruismHearthStoneSecureButton"]:SetAllPoints(self)
end
DT:RegisterDatatext('EltruismTeleports', nil, { 'SPELL_UPDATE_COOLDOWN', 'BAG_UPDATE_COOLDOWN', "HEARTHSTONE_BOUND"}, EltruismTeleportsOnEvent, nil, EltruismTeleportsOnClick, EltruismTeleportsOnEnter, EltruismTeleportsOnLeave, L["Eltruism Hearthstones/Teleports"], nil, nil)
