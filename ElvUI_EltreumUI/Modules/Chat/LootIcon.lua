local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local gsub = _G.gsub

--From Chat Loot Icons by Stanzilla which is Public Domain
local function AddLootIcons(self, event, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.chat then
		return
	elseif E.db.ElvUI_EltreumUI.chat.looticons then
		local function Icon(link)
			local texture = GetItemIcon(link)
			return "\124T" .. texture .. ":" .. 12 .. "\124t" .. link
		end
		message = message:gsub("(\124c%x+\124Hitem:.-\124h\124r)", Icon)
		return false, message, ...
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", AddLootIcons)

