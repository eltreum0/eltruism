local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local BackdropTemplateMixin = _G.BackdropTemplateMixin
local IsInInstance = _G.IsInInstance
local GetItemClassInfo = _G.GetItemClassInfo
local InCombatLockdown = _G.InCombatLockdown
local GetBindingKey = _G.GetBindingKey
local SetBindingClick = _G.SetBindingClick
local HandleModifiedItemClick = _G.HandleModifiedItemClick
local IsShiftKeyDown = _G.IsShiftKeyDown
local GameFontNormal = _G.GameFontNormal
local GameTooltip = _G.GameTooltip
local GetItemInfo = _G.GetItemInfo
local ipairs = _G.ipairs
local GetContainerNumSlots = _G.GetContainerNumSlots
local GetContainerItemLink = _G.GetContainerItemLink
local tonumber = _G.tonumber
local GetContainerItemQuestInfo = _G.GetContainerItemQuestInfo
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetBindingText = _G.GetBindingText
local CooldownFrame_Set = _G.CooldownFrame_Set
local GetContainerItemCooldown = _G.GetContainerItemCooldown
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local _, instanceType

--A merge of QBAr by Aezay with a few edits by Eltreum
--This module is GNU GPL v3
local EltruismQuestItemFrame = CreateFrame("Frame", "EltruismQuestItem", UIParent, BackdropTemplateMixin and "BackdropTemplate")	-- 9.0.1: Using BackdropTemplate
EltruismQuestItemFrame:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 34)
E:CreateMover(EltruismQuestItemFrame, "MoverEltruismQuestItem", "EltruismQuestItemBar", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,quests')
EltruismQuestItemFrame.tip = CreateFrame("GameTooltip","EltruismQuestItemTip",nil,"GameTooltipTemplate")
EltruismQuestItemFrame.tip:SetOwner(UIParent,"ANCHOR_NONE")

local slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
	"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
	"MainHandSlot", "SecondaryHandSlot",
}

-- These items are not marked as being quest items, but we want to include them anyway
local qItems = {
	--by Eltreum
	28607, -- Sunfury Disguise
	28132, -- area 52 bomb
	28038, -- seaforium explosive
	49132, -- fireliminator x-21
	49368, -- ambassador disquise
	24501, -- gordawag's boulder
	24467, -- living fire
	25458, -- mag'har battle standard
	34475, -- arcane charges
	34483, --orb of murloc control
	35233, --multiphase spectographic goggles

	-- by Az
	23818,	-- Stillpine Furbolg Language Primer
	23792,	-- Tree Disguise Kit
	24084,	-- Draenei Banner
	24278,	-- Flare Gun
	5456,	-- Divining Scroll (item has no Use: text, even though you can use it)

	11582,	-- Fel Salve
	12922,	-- Empty Canteen
	11914, -- Cursed Ooze Jar
	11948,	-- Tainted Ooze Jar
	28038,	-- Seaforium PU-36 Explosive Nether Modulator
	28132,	-- Area 52 Special
	23361,	-- Cleansing Vial
	25465,	-- Stormcrow Amulet
	24355,	-- Ironvine Seeds
	25552,	-- Warmaul Ogre Banner
	25555,	-- Kil'sorrow Banner
	25658,	-- Damp Woolen Blanket
	25853,	-- Pack of Incendiary Bombs (Old Hillsbrad)
	24501,	-- Gordawg's Boulder

	33634,	-- Orehammer's Precision Bombs, quest from Howling Fjord
	49278,	-- Goblin Rocket Pack (ICC - Lootship)

	33096,	-- Complimentary Brewfest Sampler (Brew Fest)
	32971,	-- Water Bucket (Hallow's End)
	46861,	-- Bouquet of Orange Marigolds (Day of the Dead)
	21713,	-- Elune's Candle (Lunar Festival)

	56909,	-- Earthen Ring Unbinding Totem (Cata event)
	60501, 	-- Stormstone, Deepholm Quest
	45067,	-- Egg Basket -- Az: offhand item, but I wanted it on my bar for a hotkey
}
local blocklist = {
	[176809] = true, -- junk item that for some reason showed up

	[180817] = true, -- cypher of relocation
	--[140212] = true, --test item

	--[24468] = true, --burstcap mushroom
	--[24449] = true, --fertile spores
	--[24291] = true, --bog lord tendril
	--[24497] = true, --feralfen protection totem
	--[25448] = true, --blacksting's stinger
	--[25491] = true, --salvaged spore sacs
	--[24238] = true, --mushroom sample
	--[24472] = true, --boss grog'ak's head
}

function ElvUI_EltreumUI:QuestItem()
	_, instanceType = IsInInstance()
	if E.db.ElvUI_EltreumUI.quests.questitems then
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" or instanceType == "arena" or instanceType == "pvp" then
			EltruismQuestItemFrame:Hide()
		else
			if not EltruismQuestItemFrame:IsShown() then
				EltruismQuestItemFrame:Show()
			end
			-- Constants
			local UPDATE_DELAY = 0.5
			local ITEMID_PATTERN = "item:(%d+)"
			local QUEST_TOKEN = (GetItemClassInfo and GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM or 12) or LOOT_JOURNAL_LEGENDARIES_SOURCE_QUEST or "Quest") -- Obtain the localization of the "Quest" type for items -- [7.0.3/Legion] API Removed: GetAuctionItemClasses()

			-- Config
			local cfg = {
				btnSize = E.db.ElvUI_EltreumUI.quests.questitemsize,
			}
			if E.db.ElvUI_EltreumUI.quests.questitemsbar1 and E.private.actionbar.enable then
				if not InCombatLockdown() then
					EltruismQuestItemFrame:SetParent(_G["ElvUI_Bar1Button1"])
				end
			end
			if not InCombatLockdown() then
				EltruismQuestItemFrame:SetSize(cfg.btnSize,cfg.btnSize)
				EltruismQuestItemFrame:SetClampedToScreen(true)
				EltruismQuestItemFrame:SetFrameStrata("MEDIUM")
			end
			--EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE")
			EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE_DELAYED")
			EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
			EltruismQuestItemFrame:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
			EltruismQuestItemFrame:RegisterEvent("QUEST_WATCH_UPDATE")
			EltruismQuestItemFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
			EltruismQuestItemFrame:RegisterEvent("MAIL_SUCCESS") -- when mailing quest items UNIT_INVENTORY_CHANGED does not fire
			EltruismQuestItemFrame:RegisterEvent("QUEST_ACCEPTED") -- Needed for items that starts a quest, when we accept it, update to remove the icon
			EltruismQuestItemFrame:RegisterEvent("QUEST_LOG_UPDATE") -- For when items get added/removed during quest
			EltruismQuestItemFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")	-- Should work better than PLAYER_ENTERING_WORLD

			--get the keybind
			local bindingText1 = GetBindingKey("CLICK EltruismQuestItem1:LeftButton")
			local bindingText2 = GetBindingKey("CLICK EltruismQuestItem2:LeftButton")
			local bindingText3 = GetBindingKey("CLICK EltruismQuestItem3:LeftButton")
			local bindingText4 = GetBindingKey("CLICK EltruismQuestItem4:LeftButton")
			local bindingText5 = GetBindingKey("CLICK EltruismQuestItem5:LeftButton")
			local bindingText6 = GetBindingKey("CLICK EltruismQuestItem6:LeftButton")
			local bindingText7 = GetBindingKey("CLICK EltruismQuestItem7:LeftButton")
			local bindingText8 = GetBindingKey("CLICK EltruismQuestItem8:LeftButton")
			local bindingText9 = GetBindingKey("CLICK EltruismQuestItem9:LeftButton")
			local bindingText10 = GetBindingKey("CLICK EltruismQuestItem10:LeftButton")
			local bindingText11 = GetBindingKey("CLICK EltruismQuestItem11:LeftButton")
			local bindingText12 = GetBindingKey("CLICK EltruismQuestItem12:LeftButton")

			-- update mover position
			function EltruismQuestItemFrame:FixPosition()
				E:Delay(0, function()
					if not InCombatLockdown() and _G["EltruismQuestItem1"] then
						local point, relativeTo, relativePoint, xOfs, yOfs = EltruismQuestItemFrame:GetPoint()
						_G["EltruismQuestItem1"]:ClearAllPoints()
						if self.shownItems ~= 1 then
							if (self.shownItems % 2) == 0 then
								if xOfs >= 0 then
									_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((self.shownItems-1)*cfg.btnSize)/2), yOfs)
								elseif xOfs < 0 then
									_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(((self.shownItems-1)*cfg.btnSize)/2), yOfs)
								end
							else
								if xOfs >= 0 then
									_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((self.shownItems-(self.shownItems % 2))*(cfg.btnSize+1))/2), yOfs)
								elseif xOfs < 0 then
									_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(((self.shownItems-(self.shownItems % 2))*(cfg.btnSize-1))/2), yOfs)
								end
							end
						else
							_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
						end
					end
				end)
			end

			--------------------------------------------------------------------------------------------------------
			--                                                Main                                                --
			--------------------------------------------------------------------------------------------------------
			local function OnUpdate(self,elapsed)
				--print("quest item spam "..math.random(1,99))
				self.updateTime = (self.updateTime + elapsed)
				if (self.updateTime > UPDATE_DELAY) then
					EltruismQuestItemFrame:SetScript("OnUpdate",nil)
					EltruismQuestItemFrame:UpdateButtons()
				end
			end

			EltruismQuestItemFrame.tip = CreateFrame("GameTooltip","EltruismQuestItem",nil,"GameTooltipTemplate")
			EltruismQuestItemFrame.tip:SetOwner(UIParent,"ANCHOR_NONE")
			EltruismQuestItemFrame.items = {}
			--------------------------------------------------------------------------------------------------------
			--                                                Items                                               --
			--------------------------------------------------------------------------------------------------------
			-- OnClick
			--local function Button_OnClick(self,button, down)
			local function Button_OnClick(self, _, _)
				-- Handle Modified Click
				if (HandleModifiedItemClick(self.link)) then
					return
				-- Ignore
				elseif (IsShiftKeyDown()) then
					EltruismQuestItemFrame:RequestUpdate()
				-- Set Hotkey
				elseif (self.itemId ~= cfg.lastItem) then
					cfg.lastItem = self.itemId
				end
			end

			-- Make Loot Button
			local function CreateItemButton()
				local b = CreateFrame("Button","EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1),EltruismQuestItemFrame,"SecureActionButtonTemplate")
				b:CreateBackdrop('Transparent')
				b:SetSize(cfg.btnSize,cfg.btnSize)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not b.shadow then
						b:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					end
				end
				b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
				b:RegisterForClicks("LeftButtonUp","RightButtonUp")
				b:SetScript("OnEnter", function (self)
					GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
					local bag, slot = self:GetAttribute("bag"), self:GetAttribute("slot")
					if (bag) then
						GameTooltip:SetBagItem(bag,slot)
					else
						GameTooltip:SetInventoryItem("player",slot)
					end
					if E.db.ElvUI_EltreumUI.quests.questitemsfade then
						b:SetAlpha(1)
					end
				end)
				b:SetScript("OnLeave", function(self)
					if E.db.ElvUI_EltreumUI.quests.questitemsfade then
						b:SetAlpha(0)
					end
					GameTooltip:Hide()
				end)
				b:HookScript("OnClick",Button_OnClick)
				b:SetAttribute("type*","item")

				b.icon = b:CreateTexture(nil,"ARTWORK")
				b.icon:SetAllPoints()

				b.count = b:CreateFontString(nil,"ARTWORK")
				b.count:SetFont(E.LSM:Fetch("font", E.db.general.font), 14, E.db.general.fontStyle)
				b.count:SetTextColor(1,1,1)
				b.count:SetPoint("BOTTOMRIGHT",b.icon, 0, 0)

				b.cooldown = CreateFrame("Cooldown",nil,b,"CooldownFrameTemplate")
				b.cooldown:SetAllPoints()

				b.bind = b:CreateFontString(nil,"ARTWORK","NumberFontNormalSmallGray")
				b.bind:SetPoint("TOPLEFT",b.icon,0,0)
				b.bind:SetPoint("TOPRIGHT",b.icon,0,0)
				b.bind:SetJustifyH("LEFT")

				b:Show()
				--if (#EltruismQuestItemFrame.items == 0) then
				if (self.shownItems == 0) then
					b:SetPoint("TOPLEFT",EltruismQuestItemFrame,0,0)
				end
				EltruismQuestItemFrame.items[#EltruismQuestItemFrame.items + 1] = b
				return b
			end

			--register keybind
			if not InCombatLockdown() then
				if bindingText1 then
					SetBindingClick(bindingText1, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1))
				end
				if bindingText2 then
					SetBindingClick(bindingText2, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 2))
				end
				if bindingText3 then
					SetBindingClick(bindingText3, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 3))
				end
				if bindingText4 then
					SetBindingClick(bindingText4, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 4))
				end
				if bindingText5 then
					SetBindingClick(bindingText5, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 5))
				end
				if bindingText6 then
					SetBindingClick(bindingText6, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 6))
				end
				if bindingText7 then
					SetBindingClick(bindingText7, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 7))
				end
				if bindingText8 then
					SetBindingClick(bindingText8, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 8))
				end
				if bindingText9 then
					SetBindingClick(bindingText9, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 9))
				end
				if bindingText10 then
					SetBindingClick(bindingText10, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 10))
				end
				if bindingText11 then
					SetBindingClick(bindingText11, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 11))
				end
				if bindingText12 then
					SetBindingClick(bindingText12, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 12))
				end
			end

			-- Add Button
			local function AddButton(index,bag,slot,link,itemId,count)
				local btn = EltruismQuestItemFrame.items[index] or CreateItemButton()
				local _, _, _, _, _, _, _, _, _, itemTexture, _, _ = GetItemInfo(link)
				--print(link,index)
				btn.icon:SetTexture(itemTexture)
				btn.icon:SetTexCoord(0.08,0.92,0.08,0.92)
				btn.count:SetText(count and count > 1 and count or "")

				btn.link = link
				btn.itemId = itemId

				btn:SetAttribute("bag",bag)
				btn:SetAttribute("slot",slot)

				if (index > 1) then
					btn:ClearAllPoints()
					btn:SetPoint("LEFT",EltruismQuestItemFrame.items[index - 1],"RIGHT",2,0)
				end
				btn:Show()

				-- update mover position
				EltruismQuestItemFrame:FixPosition()
			end

			-- Check Item -- Az: Some items which starts a quest, are not marked as "Quest" in itemType or itemSubType. Ex: item:17008
			local function CheckItemTooltip(link,itemId)
				local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc, _, _, classID = GetItemInfo(link)

				-- Include predefinded items
				for _, id in ipairs(qItems) do
					if (itemId == id) then
						return 1
					end
				end
				-- Scan Tip -- Az: any reason we cant just check for more or equal to 4 lines, or would some quest items fail that check?
				EltruismQuestItemFrame.tip:ClearLines()
				EltruismQuestItemFrame.tip:SetHyperlink(link)
				local numLines = EltruismQuestItemFrame.tip:NumLines()
				local line2 = (_G["EltruismQuestItemTipTextLeft2"]:GetText() or "")
				if (numLines >= 3) and (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12 or line2 == ITEM_BIND_QUEST or line2 == GetZoneText()) and itemEquipLoc == "" then
					for i = 3, numLines do
						if _G["EltruismQuestItemTipTextLeft"..i] then
							local text = _G["EltruismQuestItemTipTextLeft"..i]:GetText() or ""
							if text and (text:find("^"..ITEM_SPELL_TRIGGER_ONUSE)) then
								return 1
							end
						end
					end
				end
			end
			--------------------------------------------------------------------------------------------------------
			--                                               Update                                               --
			--------------------------------------------------------------------------------------------------------
			-- Request a Button Update
			function EltruismQuestItemFrame:RequestUpdate()
				self.updateTime = 0
				EltruismQuestItemFrame:SetScript("OnUpdate",OnUpdate)
				--print("re quest item spam "..math.random(1,99))
			end
			EltruismQuestItemFrame:RequestUpdate()

			-- Update Buttons
			function EltruismQuestItemFrame:UpdateButtons()
				-- Check if we are locked by combat
				if (InCombatLockdown()) then
					return
				end
				-- locals
				local index = 1
				-- Inventory
				for bag = 0, NUM_BAG_SLOTS do
					for slot = 1, GetContainerNumSlots(bag) do
						local link = GetContainerItemLink(bag,slot)
						local itemId = link and tonumber(link:match(ITEMID_PATTERN))
						if (link) and (itemId) then
							if not blocklist[itemId] then
								local _, _, _, _, _, itemType, _, _, _, _, _, classID = GetItemInfo(link)
								if E.Retail then
									local isQuestItem, _, _ = GetContainerItemQuestInfo(bag,slot)
									if isQuestItem or ((itemType == "Quest" or classID == 12) and GetItemSpell(itemId) ~= nil) or (CheckItemTooltip(link,itemId)) then
										local _, count = GetContainerItemInfo(bag,slot)
										AddButton(index,bag,slot,link,itemId,count)
										index = (index + 1)
									end
								elseif E.Wrath or E.TBC or E.Classic then
									if ((itemType == "Quest" or classID == 12) and GetItemSpell(itemId) ~= nil) or (CheckItemTooltip(link,itemId)) then
										local _, count = GetContainerItemInfo(bag,slot)
										AddButton(index,bag,slot,link,itemId,count)
										index = (index + 1)
									end
								end
							end
						end
					end
				end
				-- Equipped Items
				for _, slotName in ipairs(slots) do
					local slotId = GetInventorySlotInfo(slotName)
					local link = GetInventoryItemLink("player",slotId)
					local itemId = link and tonumber(link:match(ITEMID_PATTERN))
					if (link) and (itemId) and (CheckItemTooltip(link,itemId)) and GetItemSpell(itemId) ~= nil then
						AddButton(index,nil,slotId,link,itemId)
						index = (index + 1)
					end
				end

				--for some reason sometimes it doesnt remove, sometimes it does, might need to implement a check somewhat like this to remove items
				--[[--check if removed
				local check = {}
				for i = 1 , #EltruismQuestItemFrame.items + 1 do
					if _G["EltruismQuestItem"..i] and _G["EltruismQuestItem"..i].itemId then
						tinsert(check, _G["EltruismQuestItem"..i].itemId)
					end
				end
				local verify = {}
				for bag = 0, NUM_BAG_SLOTS do
					for slot = 1, GetContainerNumSlots(bag) do
						local link = GetContainerItemLink(bag,slot)
						local itemId = link and tonumber(link:match(ITEMID_PATTERN))
						tinsert(verify,itemId)
					end
				end

				local function TableComp(a,b) --algorithm is O(n log n), due to table growth. --https://old.reddit.com/r/lua/comments/417v44/efficient_table_comparison/cz0oydn/
					local t1,t2 = {}, {} -- temp tables
					for k,v in pairs(a) do -- copy all values into keys for constant time lookups
					    t1[k] = (t1[k] or 0) + 1 -- make sure we track how many times we see each value.
					end
					for k,v in pairs(b) do
					    t2[k] = (t2[k] or 0) + 1
					end
					for k,v in pairs(t1) do -- go over every element
					    if v ~= t2[k] then return false end -- if the number of times that element was seen don't match...
					end
					return true
				end
				print(TableComp(check,verify))]]

				-- Set Shown Items
				self.shownItems = (index - 1)
				for i = index, #self.items do
					self.items[i]:Hide()
				end
				--update bind text
				for i = 1, self.shownItems do
					self.items[i].bind:SetText(GetBindingText(GetBindingKey("CLICK ".."EltruismQuestItem"..i..":LeftButton"),"",1))
				end
				-- Update Misc
				EltruismQuestItemFrame:UpdateCooldowns()
			end

			-- Update Cooldowns
			function EltruismQuestItemFrame:UpdateCooldowns()
				for i = 1, self.shownItems do
					local bag, slot = self.items[i]:GetAttribute("bag"), self.items[i]:GetAttribute("slot")
					if (bag) then
						CooldownFrame_Set(self.items[i].cooldown,GetContainerItemCooldown(bag,slot))
					else
						CooldownFrame_Set(self.items[i].cooldown,GetInventoryItemCooldown("player",slot))
					end
				end
				if bindingText1 and self.shownItems >= 1 then
					self.items[1].bind:SetText(bindingText1)
				end
				if bindingText2 and self.shownItems >= 2 then
					self.items[2].bind:SetText(bindingText2)
				end
				if bindingText3 and self.shownItems >= 3 then
					self.items[3].bind:SetText(bindingText3)
				end
				if bindingText4 and self.shownItems >= 4 then
					self.items[4].bind:SetText(bindingText4)
				end
				if bindingText5 and self.shownItems >= 5 then
					self.items[5].bind:SetText(bindingText5)
				end
				if bindingText6 and self.shownItems >= 6 then
					self.items[6].bind:SetText(bindingText6)
				end
				if bindingText7 and self.shownItems >= 7 then
					self.items[7].bind:SetText(bindingText7)
				end
				if bindingText8 and self.shownItems >= 8 then
					self.items[8].bind:SetText(bindingText8)
				end
				if bindingText9 and self.shownItems >= 9 then
					self.items[9].bind:SetText(bindingText9)
				end
				if bindingText10 and self.shownItems >= 10 then
					self.items[10].bind:SetText(bindingText10)
				end
				if bindingText11 and self.shownItems >= 11 then
					self.items[11].bind:SetText(bindingText11)
				end
				if bindingText12 and self.shownItems >= 12 then
					self.items[12].bind:SetText(bindingText12)
				end
			end

			--------------------------------------------------------------------------------------------------------
			--                                               Events                                               --
			--------------------------------------------------------------------------------------------------------
			EltruismQuestItemFrame:SetScript("OnEvent",function(self,event,...)
				--print(event.." quest onevent spam "..math.random(1,99))
				if (self[event]) then
					self[event](self,event,...)
				else
					EltruismQuestItemFrame:RequestUpdate()
				end
			end)

			-- Update Cooldowns
			function EltruismQuestItemFrame:ACTIONBAR_UPDATE_COOLDOWN(event)
				if not self.shownItems then --added this check
					self.shownItems = 0
				end
				if (self.shownItems > 0) then
					EltruismQuestItemFrame:UpdateCooldowns()
				end
			end

			-- Inventory Changed
			function EltruismQuestItemFrame:UNIT_INVENTORY_CHANGED(event,unit)
				if (unit == "player") then
					EltruismQuestItemFrame:RequestUpdate()
					-- update mover position
					EltruismQuestItemFrame:FixPosition()
				end
			end

			-- Inventory might've changed because of mail
			function EltruismQuestItemFrame:MAIL_SUCCESS(event)
				EltruismQuestItemFrame:RequestUpdate()
				-- update mover position
				EltruismQuestItemFrame:FixPosition()
			end

		end
	end
end
