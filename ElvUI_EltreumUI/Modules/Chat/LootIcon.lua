local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Forked from Chat Loot Icons by Stanzilla which is Public Domain
local function AddLootIcons(_, _, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif E.db.ElvUI_EltreumUI.chat.looticons then
		local function Icon(link)
			local texture = GetItemIcon(link)
			--texture:SetTexCoord(0.08,0.92,0.08,0.92) --texture number not file
			local _, _, itemQuality, itemLevel, _, itemType = GetItemInfo(link)
			--itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(item)
			if itemLevel ~= nil and itemLevel > 1 and E.db.ElvUI_EltreumUI.chat.itemlevels and itemQuality and itemType ~= "Consumable" then
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
