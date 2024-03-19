local E = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local ChatFrame_AddMessageEventFilter = _G.ChatFrame_AddMessageEventFilter
local ChatFrame_RemoveMessageEventFilter = _G.ChatFrame_RemoveMessageEventFilter
local GetItemIcon = _G.C_Item and _G.C_Item.GetItemIconByID or _G.GetItemIcon
local tonumber = _G.tonumber
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local select = _G.select
local Item = _G.Item
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local UIParent = _G.UIParent
local ilvlpattern
local texture
local itemLevel
local tt
local itemQuality, classID
local hex
local GetPlayerInfoByGUID = _G.GetPlayerInfoByGUID

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

--Forked from Chat Loot Icons by Stanzilla which is Public Domain, modified to do more things
local function AddLootIcons(_, _, message, ...)
	local _, _, _, _, _, _, _, _, _, _, guid = ...
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.db.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.chat then
		return
	elseif E.db.ElvUI_EltreumUI.chat.enable then
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

			_, _, itemQuality, _, _, _, _, _, _, _, _, classID = GetItemInfo(link)
			if itemLevel == nil then
				itemLevel = select(4, GetItemInfo(link))
			end

			local item = Item:CreateFromItemLink(link)
			if not item:IsItemEmpty() then
				item:ContinueOnItemLoad(function()
					classID = select(12, GetItemInfo(link))
					itemQuality = item:GetItemQuality()
					--print(itemType, itemQuality, itemLevel)
				end)
			end

			--local fontsize = select(2, GetChatWindowInfo(1))
			--itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent = GetItemInfo(item)
			if itemLevel ~= nil and itemLevel > 1 and E.db.ElvUI_EltreumUI.chat.itemlevels and itemQuality ~= nil and (classID == 2 or classID == 4 or classID == 3) then
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
		if E.db.ElvUI_EltreumUI.chat.looticons and not E.db.ElvUI_EltreumUI.chat.classcolorchat then
			--[[if guid then
				local localizedClass, englishClass, localizedRace, englishRace, sex, name, realm = GetPlayerInfoByGUID(guid)
				print(name,englishRace,englishClass)
			end]]
			message = message:gsub("(|c%x+|Hitem:.-|h|r)", Icon)
			return false, message, ...
		elseif E.db.ElvUI_EltreumUI.chat.looticons and E.db.ElvUI_EltreumUI.chat.classcolorchat and not E.db.chat.chatHistory then
			if guid ~= nil then
				local _, unitclass = GetPlayerInfoByGUID(guid)
				local msg
				if E.db.ElvUI_EltreumUI.chat.classcolorchatcustom then
					local r,g,b = ElvUI_EltreumUI:ChatCustomColor(unitclass)
					msg = "|c"..E:RGBToHex(r,g,b, 'ff')..message:gsub("(|c%x+|Hitem:.-|h|r)", Icon).."|r"
				else
					msg = "|cff"..classcolorsescape[unitclass]..message:gsub("(|c%x+|Hitem:.-|h|r)", Icon).."|r"
				end
				return false, msg, ...
			else
				message = message:gsub("(|c%x+|Hitem:.-|h|r)", Icon)
				return false, message, ...
			end
		elseif not E.db.ElvUI_EltreumUI.chat.looticons and E.db.ElvUI_EltreumUI.chat.classcolorchat and not E.db.chat.chatHistory then
			if guid ~= nil then
				local _, unitclass = GetPlayerInfoByGUID(guid)
				local msg
				if E.db.ElvUI_EltreumUI.chat.classcolorchatcustom then
					local r,g,b = ElvUI_EltreumUI:ChatCustomColor(unitclass)
					msg = "|c"..E:RGBToHex(r,g,b, 'ff')..message.."|r"
				else
					msg = "|cff"..classcolorsescape[unitclass]..message.."|r"
				end
				return false, msg, ...
			else
				return false, message, ...
			end
		end
	elseif not E.db.ElvUI_EltreumUI.chat.enable or (not E.db.ElvUI_EltreumUI.chat.looticons and not E.db.ElvUI_EltreumUI.chat.classcolorchat) then
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_LOOT", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY_LEADER", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_LEADER", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_WARNING", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BN_WHISPER", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_OFFICER", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID", AddLootIcons)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_TRADESKILLS", AddLootIcons)
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
