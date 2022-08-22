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

local rollstring = "rolls" or "tira" or "掷出" or "würfelt. Ergebnis:" or "obtient un" or "님이 주사위를 굴려" or "tira los dados y obtiene" or "выбрасывает" or "擲出"
local onlinestring = "online" or "접속 중" or "en ligne" or "在线" or "conectado" or "目前在線" or "В сети"
local offlinestring = "offline" or "님이 게임을 종료했습니다." or "déconnecter" or "下线了" or "desconectado" or "下線了" or "выходит из игрового" or "desconectou"
local joinsstring = "joins the" or "파티에 합류했" or "rejoint" or "schließt sich" or "加入了" or "une" or "вступает" or "entra " or "unisce" or "join the" or "joindre à" or "beitreten" or "unirte" or "принять участие" or "entrar" or "unirti" or "invitato" or "joined the" or "공격대에 합" or "rejoint" or "sich dem Schlachtzug" or "入了团" or 'unido' or "入了團" or "присоединяется к рейдовой" or "entrou "
local leavestring = "has left the" or "떠났습" or "quitté" or "verlassen" or "离开" or "abandonado" or "離開" or "abandonou" or "lascia" or "verlässt" or "leaves the" or "leave the" or "deja" or "покидает" or " sai "

local function ColorSysMsgs(_, event, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.chat then
		return
	end
	if E.db.ElvUI_EltreumUI.chat.colorsysmsg then

		if message:find(rollstring) then
			local msg = (string.format("|cff"..classcolorsescape[E.myclass]..message.."|r"))
			if msg:find(rollstring.." 1 ") then
				if E.db.ElvUI_EltreumUI.chat.rollsound then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.ogg", "Master")
				end
				return false, gsub(msg, rollstring.." 1", rollstring.." |cffFF00001|r"), ...
			elseif msg:find(rollstring.." 100 ") then
				if E.db.ElvUI_EltreumUI.chat.rollsound then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\WillSmith-Ahaha.ogg", "Master")
				end
				return false, gsub(msg, rollstring.." 100", rollstring.." |cffFFFF00100|r"), ...
			else
				return false, msg, ...
			end
		end
		if message:find(onlinestring) then --german, english, italian all use the same online/offline
			return false, gsub(message, onlinestring, "|cff00FF00"..onlinestring.."|r"), ...
		end
		if message:find(offlinestring) then
			return false, gsub(message, offlinestring, "|cffFF0000"..offlinestring.."|r"), ...
		end
		if message:find(joinsstring) then
			return false, gsub(message, joinsstring, "|cff82B4ff"..joinsstring.."|r"), ...
		end
		if message:find(leavestring) then
			return false, gsub(message, leavestring, "|cffB50909"..leavestring.."|r"), ...
		end
	end

	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_INLINE_TOAST_ALERT", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("ROLE_CHANGED_INFORM", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("PLAYER_ROLES_ASSIGNED", ColorSysMsgs)
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
	if E.db.ElvUI_EltreumUI.skins.hidetalkinghead then
		EltruismHideTalkingHead:SetScript('OnEvent', function(_, event)
			if event == 'PLAYER_ENTERING_WORLD' or event == 'ADDON_LOADED' then
				if E.Retail then
					if not IsAddOnLoaded("Blizzard_TalkingHeadUI") then
						UIParentLoadAddOn("Blizzard_TalkingHeadUI")
						if IsAddOnLoaded('Blizzard_TalkingHeadUI') then
							local TalkingHeadFrame = _G.TalkingHeadFrame
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
_G.INLINE_TANK_ICON = roleIcons.TANK
_G.INLINE_HEALER_ICON = roleIcons.HEALER
_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER

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

--[[
Interface/LFGFrame/GroupFinder
E.media.roleIcons = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\UI-LFG-ICON-ROLES"
_G.LFG_LIST_GROUP_DATA_ATLASES = {
	--Roles
	TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga',
	HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga',
	DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga',
}
]]
