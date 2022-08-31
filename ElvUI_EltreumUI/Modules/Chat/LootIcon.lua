local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local ChatFrame_AddMessageEventFilter = _G.ChatFrame_AddMessageEventFilter
local GetItemIcon = _G.GetItemIcon
local tonumber = _G.tonumber
local GetItemInfo = _G.GetItemInfo
local select = _G.select
local Item = _G.Item
local GetItemQualityColor = _G.GetItemQualityColor
local UIParent = _G.UIParent
local ilvlpattern
local texture
local itemLevel
local tt
local _, itemQuality, itemType
local hex

--Forked from Chat Loot Icons by Stanzilla which is Public Domain
local function AddLootIcons(_, _, message, ...)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif E.db.ElvUI_EltreumUI.chat.enable and E.db.ElvUI_EltreumUI.chat.looticons then
		local function Icon(link)

			ilvlpattern = _G.ITEM_LEVEL:gsub('%%d', '(%%d+)')
			texture = GetItemIcon(link)

			--from elvui
			tt = E.ScanTooltip
			tt:SetOwner(UIParent, 'ANCHOR_NONE')
			tt:SetHyperlink(link)
			for x = 1, tt:NumLines() do
				local line = _G["ElvUI_ScanTooltipTextLeft"..x]
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

			_, _, itemQuality, _, _, itemType = GetItemInfo(link)
			if itemLevel == nil then
				itemLevel = select(4, GetItemInfo(link))
			end

			local item = Item:CreateFromItemLink(link)
			if not item:IsItemEmpty() then
				item:ContinueOnItemLoad(function()
					itemType = select(6, GetItemInfo(link))
					itemQuality = item:GetItemQuality()
					--print(itemType, itemQuality, itemLevel)
				end)
			end

			--local fontsize = select(2, GetChatWindowInfo(1))
			--itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(item)
			if itemLevel ~= nil and itemLevel > 1 and E.db.ElvUI_EltreumUI.chat.itemlevels and itemQuality ~= nil and (itemType == "Weapon" or itemType == "Armor" or itemType == "Gem") then
				_, _, _, hex = GetItemQualityColor(itemQuality)
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


--gradient text experiment
--[[local function test(_,event,message,...)
	local string = message
	--return false, gsub(message, string, E:TextGradient(string, 1,0,0,0,1,0)), ...
	return false, gsub(message, string, ElvUI_EltreumUI:GradientName(string, E.myclass)), ...
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_ALLIANCE", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_HORDE", test)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_NEUTRAL", test)
]]
