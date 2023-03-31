local E, L, V, P, G = unpack(ElvUI)
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
	["EVOKER"] = "33937F",
}

local rollstring
local onlinestring
local offlinestring
local joinsstring
local joinsstring2
local joinsstring3
local leavestring
local leavestring2

local function ColorSysMsgs(_, event, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.chat then
		return
	end
	if E.db.ElvUI_EltreumUI.chat.colorsysmsg then
		if E.locale == "deDE" then
			rollstring = "würfelt. Ergebnis:"
			onlinestring = "online"
			offlinestring = "offline"
			joinsstring = "schließt sich"
			joinsstring2 = "sich dem Schlachtzug"
			joinsstring3 = "beitreten"
			leavestring = "verlässt"
			leavestring2 = "verlassen"
		elseif E.locale == "enUS" or E.locale == "enGB" or E.locale == "enCN" or E.locale == "enTW" then
			rollstring = "rolls"
			onlinestring = "online"
			offlinestring = "offline"
			joinsstring = "joins"
			joinsstring2 = " join "
			joinsstring3 = " joined "
			leavestring = " left "
			leavestring2 = "leaves"
		elseif E.locale == "zhCN" then
			rollstring = "掷出"
			onlinestring = "在线"
			offlinestring = "下线了"
			joinsstring = "加入了"
			joinsstring2 = "入了团"
			joinsstring3 = "joined the"
			leavestring = "离开"
			leavestring2 = "leaves the"
		elseif E.locale == "zhTW" then
			rollstring = "擲出"
			onlinestring = "目前在線"
			offlinestring = "下線了"
			joinsstring = "入了團"
			joinsstring2 = "join the"
			joinsstring3 = "joined the"
			leavestring = "離開"
			leavestring2 = "leaves the"
		elseif E.locale == "esMX" or E.locale == "esES" then
			rollstring = "tira los dados y obtiene"
			onlinestring = "conectado"
			offlinestring = " desconectado"
			joinsstring = " se une "
			joinsstring2 = "unisce "
			joinsstring3 = "joined the"
			leavestring = "abandonado"
			leavestring2 = "deja"
		elseif E.locale == "frFR" then
			rollstring = "obtient un"
			onlinestring = "en ligne "
			offlinestring = "déconnecter"
			joinsstring = "rejoint"
			joinsstring2 = "joindre à"
			joinsstring3 = "joined the"
			leavestring = "quitté"
			leavestring2 = "leaves the"
		elseif E.locale == "itIT" then
			rollstring = " tira "
			onlinestring = "online"
			offlinestring = "offline"
			joinsstring = "unisce"
			joinsstring2 = "unirti"
			joinsstring3 = "unirte"
			leavestring = "lascia "
			leavestring2 = "lasci "
		elseif E.locale == "koKR" then
			rollstring = "님이 주사위를 굴려"
			onlinestring = "접속 중"
			offlinestring = "님이 게임을 종료했습니다."
			joinsstring = "파티에 합류했"
			joinsstring2 = "공격대에 합"
			joinsstring3 = "joined the"
			leavestring = "떠났습"
			leavestring2 = "leaves the"
		elseif E.locale == "ptBR" or E.locale == "ptPT" then
			rollstring = " tira "
			onlinestring = "conectado"
			offlinestring = "desconectou"
			joinsstring = " entra "
			joinsstring2 = "entrar"
			joinsstring3 = "entrou "
			leavestring = "abandonou"
			leavestring2 = " sai "
		elseif E.locale == "ruRU" then
			rollstring = "выбрасывает"
			onlinestring = "В сети"
			offlinestring = "выходит из игрового"
			joinsstring = "вступает"
			joinsstring2 = "принять участие"
			joinsstring3 = "присоединяется к рейдовой"
			leavestring = "покидает"
			leavestring2 = "leaves the"
		end
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
		if message:find(joinsstring) then
			return false, gsub(message, joinsstring, "|cff82B4ff"..joinsstring.."|r"), ...
		end
		if message:find(joinsstring2) then
			return false, gsub(message, joinsstring2, "|cff82B4ff"..joinsstring2.."|r"), ...
		end
		if message:find(joinsstring3) then
			return false, gsub(message, joinsstring3, "|cff82B4ff"..joinsstring3.."|r"), ...
		end
		if message:find(leavestring) then
			return false, gsub(message, leavestring, "|cffB50909"..leavestring.."|r"), ...
		end
		if message:find(leavestring2) then
			return false, gsub(message, leavestring2, "|cffB50909"..leavestring2.."|r"), ...
		end
		if message:find("leave the") then
			return false, gsub(message, "leave", "|cffB50909leave|r"), ...
		end
		if message:find(onlinestring) then --german, english, italian all use the same online/offline
			return false, gsub(message, onlinestring, "|cff00FF00"..onlinestring.."|r"), ...
		end
		if message:find(offlinestring) then
			return false, gsub(message, offlinestring, "|cffFF0000"..offlinestring.."|r"), ...
		end
	end

	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
		if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
			local roleIcons = {
				TANK = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank, sizeString),
				HEALER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer, sizeString),
				DAMAGER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps, sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "IOS" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "MATERIAL" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga', sizeString),
			}
			_G.INLINE_TANK_ICON = roleIcons.TANK
			_G.INLINE_HEALER_ICON = roleIcons.HEALER
			_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
		end
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
		local UF = E:GetModule('UnitFrames')
		if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
			UF.RoleIconTextures = {
				TANK = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank,
				HEALER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer,
				DAMAGER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps,
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "IOS" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "MATERIAL" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga',
			}
		end
		if IsAddOnLoaded("ElvUI_SLE") then
			local SLE = unpack(ElvUI_SLE)
			SLE.rolePaths["Eltruism"] = {
				TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
				HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
				DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
			}
			SLE.rolePaths["Atwood ElvUI"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga',
			}
			SLE.rolePaths["Atwood Glow"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga',
			}
			SLE.rolePaths["Atwood Graved"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga',
			}
			SLE.rolePaths["Atwood Grey"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga',
			}
			SLE.rolePaths["Atwood White"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga',
			}
			SLE.rolePaths["RELEAF"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga',
			}
			SLE.rolePaths["iOS"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga',
			}
			SLE.rolePaths["Material"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga',
			}
			SLE.rolePaths["Eltruism Custom"] = {
				TANK = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank,
				HEALER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer,
				DAMAGER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps,
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
			if event == 'PLAYER_ENTERING_WORLD' or event == 'ADDON_LOADED' or IsAddOnLoaded("Blizzard_TalkingHeadUI") then
				if E.Retail then
					local TalkingHeadFrame = _G.TalkingHeadFrame
					if TalkingHeadFrame then
						hooksecurefunc(_G["TalkingHeadFrame"], "PlayCurrent", function()
							TalkingHeadFrame:Hide()
						end)
						hooksecurefunc(_G["TalkingHeadFrame"], "Reset", function()
							TalkingHeadFrame:Hide()
						end)
						EltruismHideTalkingHead:UnregisterAllEvents()
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

local CH = E:GetModule('Chat')
local sizeString = "\":"..E.db["chat"]["fontSize"]..":"..E.db["chat"]["fontSize"].."\""
if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
	if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
		local roleIcons = {
			TANK = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank, sizeString),
			HEALER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer, sizeString),
			DAMAGER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps, sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank, sizeString),
			HEALER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer, sizeString),
			DAMAGER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps, sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga', sizeString),
		}
		CH.RoleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Dps.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "IOS" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "MATERIAL" then
		local roleIcons = {
			TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga', sizeString),
			HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga', sizeString),
			DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga', sizeString),
		}
		_G.INLINE_TANK_ICON = roleIcons.TANK
		_G.INLINE_HEALER_ICON = roleIcons.HEALER
		_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
	end

	if IsAddOnLoaded("ElvUI_WindTools") then
		local CT = WT:GetModule("ChatText")
		if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
			local roleIcons = {
				TANK = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank, sizeString),
				HEALER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer, sizeString),
				DAMAGER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps, sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "IOS" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "MATERIAL" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga', sizeString),
			}
			CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
			CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
			CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
		end

		local function RoleIcons()
			if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
				local roleIcons = {
					TANK = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank, sizeString),
					HEALER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer, sizeString),
					DAMAGER = E:TextureString([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps, sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "IOS" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "MATERIAL" then
				local roleIcons = {
					TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga', sizeString),
					HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga', sizeString),
					DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga', sizeString),
				}
				CT.cache.blizzardRoleIcons.Tank = roleIcons.TANK
				CT.cache.blizzardRoleIcons.Healer = roleIcons.HEALER
				CT.cache.blizzardRoleIcons.DPS = roleIcons.DAMAGER
			end
		end
		hooksecurefunc(CT, "UpdateRoleIcons", RoleIcons)
	end
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
