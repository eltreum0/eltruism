local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Forked from Chat Loot Icons by Stanzilla which is Public Domain
local function AddLootIcons(_, _, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif E.db.ElvUI_EltreumUI.chat.looticons then
		local function Icon(link)
			local texture = GetItemIcon(link)
			local _, _, itemQuality, itemLevel = GetItemInfo(link)
			if itemLevel > 1 and E.db.ElvUI_EltreumUI.chat.itemlevels and itemQuality then
				local _, _, _, hex = GetItemQualityColor(itemQuality)
				return "|T"..texture..":".. 12 .."|t|c"..hex.."["..itemLevel.."]|r"..link
			else
				return "|T"..texture..":".. 12 .."|t"..link
			end
		end
		message = message:gsub("(|c%x+|Hitem:.-|h|r)", Icon)
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
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", AddLootIcons)
ChatFrame_AddMessageEventFilter("CHAT_MSG_TRADESKILLS", AddLootIcons)
