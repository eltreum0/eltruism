local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local PlaySoundFile = _G.PlaySoundFile
local gsub = _G.gsub
local string = _G.string
local WT = E.Libs.AceAddon:GetAddon("ElvUI_WindTools", true)

--Color System messages
local classcolorsescape = {
	['DEATHKNIGHT']	= "C41E3A",
	['DEMONHUNTER']	= "A330C9",
	['DRUID'] = "FF7C0A",
	['HUNTER'] = "AAD372",
	['MAGE'] = "3FC7EB",
	['MONK'] = "00FF98",
	['PALADIN']	= "F48CBA",
	['PRIEST'] = "FFFFFF",
	['ROGUE'] = "FFF468",
	['SHAMAN'] = "0070DD",
	['WARLOCK'] = "8788EE",
	['WARRIOR'] = "C69B6D",
}
local function ColorSysMsgs(self, event, message, ...)
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
	local sizeString = ":12:12"
	local roleIcons = {
		TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
		HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
		DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
	}
	_G.INLINE_TANK_ICON = roleIcons.TANK
	_G.INLINE_HEALER_ICON = roleIcons.HEALER
	_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_INLINE_TOAST_ALERT", ColorSysMsgs)
ChatFrame_AddMessageEventFilter("ROLE_CHANGED_INFORM", ColorSysMsgs)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ColorSysMsgs) --this is for testing purposes

--party/raid role icons
if IsAddOnLoaded("ElvUI_WindTools") then
	local CT = WT:GetModule("ChatText")
	function ElvUI_EltreumUI:RoleIcons(_)
		local sizeString = ":12:12"
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
		}
		CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
		CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
		CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
	end
	hooksecurefunc(CT, "UpdateRoleIcons", ElvUI_EltreumUI.RoleIcons)
end

--icons in chat when party member swaps roles
function ElvUI_EltreumUI:ChatRoleSwapIcons()
	local sizeString = ":12:12"
	local roleIcons = {
		TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
		HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
		DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
	}
	_G.INLINE_TANK_ICON = roleIcons.TANK
	_G.INLINE_HEALER_ICON = roleIcons.HEALER
	_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
end

--hide talking head
local EltrusimHideTalkingHead = CreateFrame('Frame', "EltruismHideTalkingHead")
EltrusimHideTalkingHead:RegisterEvent('PLAYER_ENTERING_WORLD')
EltrusimHideTalkingHead:RegisterEvent('ADDON_LOADED')
function ElvUI_EltreumUI:EltrusimHideTalkingHead()
	if E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead then
		EltrusimHideTalkingHead:SetScript('OnEvent', function(_, event, addon)
			if event == 'PLAYER_ENTERING_WORLD' then
				if IsAddOnLoaded('Blizzard_TalkingHeadUI') then
					hooksecurefunc('TalkingHeadFrame_PlayCurrent', function()
						_G.TalkingHeadFrame:Hide()
					end)
				end
			end
			if event == 'ADDON_LOADED' then
				 if IsAddOnLoaded('Blizzard_TalkingHeadUI') then
					hooksecurefunc('TalkingHeadFrame_PlayCurrent', function()
						_G.TalkingHeadFrame:Hide()
					end)
				end
			end
		end)
	end
end
