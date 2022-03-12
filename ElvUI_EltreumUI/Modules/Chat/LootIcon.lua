local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Forked from Chat Loot Icons by Stanzilla which is Public Domain
local function AddLootIcons(_, _, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif E.db.ElvUI_EltreumUI.chat.looticons then
		local function Icon(link)

			local ilvlpattern = _G.ITEM_LEVEL:gsub('%%d', '(%%d+)')
			local texture = GetItemIcon(link)
			local itemLevel

			--from elvui
			local tt = E.ScanTooltip
			tt:SetOwner(_G.UIParent, 'ANCHOR_NONE')
			tt:SetHyperlink(link)
			for x = 1, tt:NumLines() do
				local line = _G['ElvUI_ScanTooltipTextLeft'..x]
				if line then
					local lineText = line:GetText()
					if lineText ~= nil then
						itemLevel = tonumber(lineText:match(ilvlpattern))
						if itemLevel ~= nil then
							break
						end
					end
				end
			end
			tt:Hide()

			local _, _, itemQuality, _, _, itemType = GetItemInfo(link)
			if itemLevel == nil then
				itemLevel = select(4, GetItemInfo(link))
			end

			local item = Item:CreateFromItemLink(link)
			item:ContinueOnItemLoad(function()
				itemType = select(6, GetItemInfo(link))
				itemQuality = item:GetItemQuality()
				--print(itemType, itemQuality, itemLevel)
			end)

			--local fontsize = select(2, GetChatWindowInfo(1))
			--itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(item)
			if itemLevel ~= nil and itemLevel > 1 and E.db.ElvUI_EltreumUI.chat.itemlevels and itemQuality ~= nil and itemType ~= "Consumable" then
				local _, _, _, hex = GetItemQualityColor(itemQuality)
				--return "|T"..texture..":".. 12 .."|t|c"..hex.."["..itemLevel.."]|r"..link
				--return "|T"..texture..":"..fontsize..":"..fontsize..":0:0:64:64:5:59:5:59|t|c"..hex.."["..itemLevel.."]|r"..link
				return "|T"..texture..":12:12:0:0:64:64:5:59:5:59|t|c"..hex.."["..itemLevel.."]|r"..link
			else
				--return "|T"..texture..":".. 12 .."|t"..link
				--return "|T"..texture..":"..fontsize..":"..fontsize..":0:0:64:64:5:59:5:59|t"..link
				return "|T"..texture..":12:12:0:0:64:64:5:59:5:59|t"..link
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
