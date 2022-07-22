local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local unpack = _G.unpack
local WT = E.Libs.AceAddon:GetAddon("ElvUI_WindTools", true)
local ChatFrame_AddMessageEventFilter = _G.ChatFrame_AddMessageEventFilter
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local string = _G.string
local PlaySoundFile = _G.PlaySoundFile
local gsub = _G.gsub
local UIParentLoadAddOn = _G.UIParentLoadAddOn
local INLINE_TANK_ICON = _G.INLINE_TANK_ICON
local INLINE_HEALER_ICON = _G.INLINE_HEALER_ICON
local INLINE_DAMAGER_ICON = _G.INLINE_DAMAGER_ICON
local TalkingHeadFrame = _G.TalkingHeadFrame

--Color System messages
local classcolorsescape = {
	["DEATHKNIGHT"]	= "C41E3A",
	["DEMONHUNTER"]	= "A330C9",
	["DRUID"] = "FF7C0A",
	["HUNTER"] = "AAD372",
	["MAGE"] = "3FC7EB",
	["MONK"] = "00FF98",
	["PALADIN"]	= "F48CBA",
	["PRIEST"] = "FFFFFF",
	["ROGUE"] = "FFF468",
	["SHAMAN"] = "0070DD",
	["WARLOCK"] = "8788EE",
	["WARRIOR"] = "C69B6D",
}
local function ColorSysMsgs(_, event, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.chat then
		return
	elseif E.db.ElvUI_EltreumUI.chat.colorsysmsg then
		if message:find("rolls") or message:find("tira") or message:find("掷出") or message:find("würfelt. Ergebnis:") or message:find("obtient un") or message:find("님이 주사위를 굴려") or message:find("tira los dados y obtiene") or message:find("выбрасывает") or message:find("擲出") then
			local msg = (string.format("|cff"..classcolorsescape[E.myclass]..message.."|r"))
			if msg:find("rolls 1 ") then
				if E.db.ElvUI_EltreumUI.chat.rollsound then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.ogg", "Master")
				end
				return false, gsub(msg, "rolls 1", "rolls |cffFF00001|r"), ...
			elseif msg:find("rolls 100 ") then
				if E.db.ElvUI_EltreumUI.chat.rollsound then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\WillSmith-Ahaha.ogg", "Master")
				end
				return false, gsub(msg, "rolls 100", "rolls |cffFFFF00100|r"), ...
			else
				return false, msg, ...
			end
		end
		if message:find("online") then --german, english, italian all use the same online/offline
			return false, gsub(message, "online", "|cff00FF00online|r"), ...
		end
		if message:find("offline") then
			return false, gsub(message, "offline", "|cffFF0000offline|r"), ...
		end
		if message:find("joins the") then
			return false, gsub(message, "joins", "|cff82B4ffjoins|r"), ...
		end
		if message:find("join the") then
			return false, gsub(message, "joins", "|cff82B4ffjoin|r"), ...
		end
		if message:find("joined the") then
			return false, gsub(message, "joined", "|cff82B4ffjoined|r"), ...
		end
		if message:find("has left the") then
			return false, gsub(message, "left", "|cffB50909left|r"), ...
		end
		if message:find("leaves the") then
			return false, gsub(message, "leaves", "|cffB50909leaves|r"), ...
		end
		if message:find("leave the") then
			return false, gsub(message, "leave", "|cffB50909leave|r"), ...
		end
	end

	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
		}
		INLINE_TANK_ICON = roleIcons.TANK
		INLINE_HEALER_ICON = roleIcons.HEALER
		INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_INLINE_TOAST_ALERT", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("ROLE_CHANGED_INFORM", ColorSysMsgs)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ColorSysMsgs) --this is for testing purposes

--icons in chat/UF when party member swaps roles
function ElvUI_EltreumUI:ChatRoleSwapIcons()
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		if E.Retail then
			local UF = E:GetModule('UnitFrames')
				UF.RoleIconTextures = {
				TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
				HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
				DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
			}
		end
		if IsAddOnLoaded("ElvUI_SLE") then
			local SLE = unpack(ElvUI_SLE)
			SLE.rolePaths["Eltruism"] = {
				TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
				HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
				DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
			}
		end
	end
end

--hide talking head
local EltruismHideTalkingHead = CreateFrame('Frame', "EltruismHideTalkingHeadFrame")
EltruismHideTalkingHead:RegisterEvent('PLAYER_ENTERING_WORLD')
EltruismHideTalkingHead:RegisterEvent('ADDON_LOADED')
function ElvUI_EltreumUI:EltruismHideTalkingHead()
	if E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead then
		EltruismHideTalkingHead:SetScript('OnEvent', function(_, event)
			if event == 'PLAYER_ENTERING_WORLD' or event == 'ADDON_LOADED' then
				if E.Retail then
					if not IsAddOnLoaded("Blizzard_TalkingHeadUI") then
						UIParentLoadAddOn("Blizzard_TalkingHeadUI")
						if IsAddOnLoaded('Blizzard_TalkingHeadUI') then
							hooksecurefunc('TalkingHeadFrame_PlayCurrent', function()
								TalkingHeadFrame:Hide()
							end)
							EltruismHideTalkingHead:UnregisterAllEvents()
						end
					end
				else
					EltruismHideTalkingHead:UnregisterAllEvents()
				end
			end
		end)
	end
end

-- Replace Chat Icons (by abusing line reading order)
if not IsAddOnLoaded("ElvUI_EltreumUI") then return end
if not E.private then return end
if not E.private.ElvUI_EltreumUI then return end
if not E.private.ElvUI_EltreumUI.install_version then return end
if not E.db then return end
if not E.db.ElvUI_EltreumUI then return end
if not E.db.ElvUI_EltreumUI.otherstuff then return end
if not E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then return end

local CH = E:GetModule('Chat')
local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""

local roleIcons = {
	TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
	HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
	DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
}

INLINE_TANK_ICON = roleIcons.TANK
INLINE_HEALER_ICON = roleIcons.HEALER
INLINE_DAMAGER_ICON = roleIcons.DAMAGER

CH.RoleIcons = {
	TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
	HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
	DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
}

if IsAddOnLoaded("ElvUI_WindTools") then
	local CT = WT:GetModule("ChatText")
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
		CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
		CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
	end
	local function RoleIcons()
		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		end
	end
	hooksecurefunc(CT, "UpdateRoleIcons", RoleIcons)
end
