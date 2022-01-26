local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--A merge of QBAr by Aezay with a few edits by Eltreum
--This module is GNU GPL v3
function ElvUI_EltreumUI:QuestItem()

	-- Constants
	local UPDATE_DELAY = 0.5
	local ITEMID_PATTERN = "item:(%d+)"
	local QUEST_TOKEN = (GetItemClassInfo and GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM or 12) or LOOT_JOURNAL_LEGENDARIES_SOURCE_QUEST or "Quest") -- Obtain the localization of the "Quest" type for items -- [7.0.3/Legion] API Removed: GetAuctionItemClasses()
	local slots = {
		"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
		"MainHandSlot", "SecondaryHandSlot",
	}

	-- Config
	local cfg = {
			enabled = true,
			showTips = true,
			vertical = false,
			mirrored = false,
			btnSize = 36,
			padding = 1,
		}

	local EltruismQuestItemFrame = CreateFrame("Frame","EltruismQuestItem",UIParent,BackdropTemplateMixin and "BackdropTemplate");	-- 9.0.1: Using BackdropTemplate
	EltruismQuestItemFrame:SetSize(cfg.btnSize,cfg.btnSize);
	EltruismQuestItemFrame:SetClampedToScreen(true)
	EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE");
	EltruismQuestItemFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	EltruismQuestItemFrame:RegisterEvent("QUEST_ACCEPTED");			-- Needed for items that starts a quest, when we accept it, update to remove the icon
	--EltruismQuestItemFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN"); --hmm
	--EltruismQuestItemFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	EltruismQuestItemFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");	-- Should work better than PLAYER_ENTERING_WORLD
	--EltruismQuestItemFrame:RegisterForClicks()
	EltruismQuestItemFrame:Show()
	local bindingText = GetBindingKey("EltruismQuestItem")
	EltruismQuestItemFrame:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 34)
	E:CreateMover(EltruismQuestItemFrame, "MoverEltruismQuestItem", "EltruismQuestItem", nil, nil, nil, "ALL")

	-- These items are not marked as being quest items, but we want to include them anyway
	local qItems = {
		23818,	-- Stillpine Furbolg Language Primer
		23792,	-- Tree Disguise Kit
		24084,	-- Draenei Banner
		24278,	-- Flare Gun
		5456,	-- Divining Scroll (item has no Use: text, even though you can use it)

		11582,	-- Fel Salve
		12922,	-- Empty Canteen
		11914,  -- Cursed Ooze Jar
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

		--45067,	-- Egg Basket -- Az: offhand item, but I wanted it on my bar for a hotkey
	}

	--------------------------------------------------------------------------------------------------------
	--                                                Main                                                --
	--------------------------------------------------------------------------------------------------------

	EltruismQuestItemFrame:SetFrameStrata("MEDIUM");

	local function OnUpdate(self,elapsed)
		print("quest item spam "..math.random(1,99))
		self.updateTime = (self.updateTime + elapsed);
		if (self.updateTime > UPDATE_DELAY) then
			self:SetScript("OnUpdate",nil);
			self:UpdateButtons();
		end
	end

	--EltruismQuestItemFrame:EnableMouse(nil);

	EltruismQuestItemFrame.tip = CreateFrame("GameTooltip","EltruismQuestItem",nil,"GameTooltipTemplate");
	EltruismQuestItemFrame.tip:SetOwner(UIParent,"ANCHOR_NONE");
	EltruismQuestItemFrame.items = {};
	--EltruismQuestItemFrame:RequestUpdate()

	--------------------------------------------------------------------------------------------------------
	--                                                Items                                               --
	--------------------------------------------------------------------------------------------------------

	-- Button Scripts
	local function Button_OnEnter(self)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		local bag, slot = self:GetAttribute("bag"), self:GetAttribute("slot");
		if (bag) then
			GameTooltip:SetBagItem(bag,slot);
		else
			GameTooltip:SetInventoryItem("player",slot);
		end
	end

	-- OnClick
	local function Button_OnClick(self,button, down)
		-- Handle Modified Click
		if (HandleModifiedItemClick(self.link)) then
			return;
		-- Ignore
		elseif (IsShiftKeyDown()) then
			EltruismQuestItemFrame:RequestUpdate();
		-- Set Hotkey
		elseif (self.itemId ~= cfg.lastItem) then
			cfg.lastItem = self.itemId;
		end
	end

	-- Make Loot Button
	local function CreateItemButton()
		local b = CreateFrame("Button","EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1),EltruismQuestItemFrame,"SecureActionButtonTemplate");
		b:SetSize(cfg.btnSize,cfg.btnSize);
		--b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
		b:SetHighlightTexture("Interface\\Buttons\\OldButtonHilight-Square")
		b:RegisterForClicks("LeftButtonUp","RightButtonUp");
		b:SetScript("OnEnter",Button_OnEnter);
		b:SetScript("OnLeave", function() GameTooltip:Hide() end);
		b:HookScript("OnClick",Button_OnClick);
		b:SetAttribute("type*","item");

		b.icon = b:CreateTexture(nil,"ARTWORK");
		b.icon:SetAllPoints();

		b.count = b:CreateFontString(nil,"ARTWORK");
		b.count:SetFont(GameFontNormal:GetFont(),14,"OUTLINE");
		b.count:SetTextColor(1,1,1);
		b.count:SetPoint("BOTTOMRIGHT",b.icon,-3,3);

		b.cooldown = CreateFrame("Cooldown",nil,b,"CooldownFrameTemplate");
		b.cooldown:SetAllPoints();

		b.bind = b:CreateFontString(nil,"ARTWORK","NumberFontNormalSmallGray");
		b.bind:SetPoint("TOPLEFT",b.icon,3,-3);
		b.bind:SetPoint("TOPRIGHT",b.icon,-3,-3);
		b.bind:SetJustifyH("RIGHT");

		--b.bind:SetText
		if (#EltruismQuestItemFrame.items == 0) then
			b:SetPoint("TOPLEFT",EltruismQuestItemFrame,0,0);
		end

		EltruismQuestItemFrame.items[#EltruismQuestItemFrame.items + 1] = b;
		return b;
	end

 	--register keybind
	SetBindingClick(bindingText, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1), "LeftButton")

	-- Add Button
	local function AddButton(index,bag,slot,link,itemId,count)
		local btn = EltruismQuestItemFrame.items[index] or CreateItemButton();
		local _, _, _, _, _, _, _, _, _, itemTexture, _, classID = GetItemInfo(link);
		--if classID == 12 then --its a quest item
			btn.icon:SetTexture(itemTexture);
			btn.count:SetText(count and count > 1 and count or "");

			btn.link = link;
			btn.itemId = itemId;

			btn:SetAttribute("bag",bag);
			btn:SetAttribute("slot",slot);

			if (index > 1) then
				btn:ClearAllPoints();
				if (cfg.vertical) then
					if (cfg.mirrored) then
						btn:SetPoint("BOTTOM",EltruismQuestItemFrame.items[index - 1],"TOP",0,cfg.padding);
					else
						btn:SetPoint("TOP",EltruismQuestItemFrame.items[index - 1],"BOTTOM",0,cfg.padding * -1);
					end
				else
					if (cfg.mirrored) then
						btn:SetPoint("RIGHT",EltruismQuestItemFrame.items[index - 1],"LEFT",cfg.padding * -1,0);
					else
						btn:SetPoint("LEFT",EltruismQuestItemFrame.items[index - 1],"RIGHT",cfg.padding,0);
					end
				end
			end
			btn:Show();
		--end
	end

	-- Check Item -- Az: Some items which starts a quest, are not marked as "Quest" in itemType or itemSubType. Ex: item:17008
	local function CheckItemTooltip(link,itemId)
		local itemName, _, _, _, _, itemType, itemSubType, _, _, _, _, classID = GetItemInfo(link);
		-- Include predefinded items
		for _, id in ipairs(qItems) do
			if (itemId == id) then
				return 1;
			end
		end
		-- Scan Tip -- Az: any reason we cant just check for more or equal to 4 lines, or would some quest items fail that check?
		EltruismQuestItemFrame.tip:ClearLines();
		EltruismQuestItemFrame.tip:SetHyperlink(link);
		local numLines = EltruismQuestItemFrame.tip:NumLines();
		--local line2 = (_G[modName.."TipTextLeft2"]:GetText() or "");
		--if (numLines >= 3) and (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or line2 == ITEM_BIND_QUEST or line2 == GetZoneText()) then
		if (numLines >= 3) and (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN) then
			for i = 3, numLines do
				local text = _G["EltruismQuestItem".."TipTextLeft"..i]:GetText() or "";
				if (text:find("^"..ITEM_SPELL_TRIGGER_ONUSE)) then
					return 1;
				end
			end
		end
	end

	--------------------------------------------------------------------------------------------------------
	--                                               Update                                               --
	--------------------------------------------------------------------------------------------------------

	-- Request a Button Update
	function EltruismQuestItemFrame:RequestUpdate()
		self.updateTime = 0;
		self:SetScript("OnUpdate",OnUpdate);
		print("re quest item spam "..math.random(1,99))
	end
	EltruismQuestItemFrame:RequestUpdate()

	-- Update Buttons
	function EltruismQuestItemFrame:UpdateButtons()
		-- Check if we are locked by combat
		if (InCombatLockdown()) then
			return;
		end
		-- locals
		local index = 1;
		-- Inventory
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag,slot);
				local itemId = link and tonumber(link:match(ITEMID_PATTERN));
				if (link) and (itemId) then
					local isQuestItem, questId, isActive = GetContainerItemQuestInfo(bag,slot);
					if isQuestItem then
					--if (questId and not isActive) or (cfg.userList[itemId]) or (CheckItemTooltip(link,itemId)) then
						--icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagID, slot)
						local _, count = GetContainerItemInfo(bag,slot);
						AddButton(index,bag,slot,link,itemId,count);
						index = (index + 1);
					end
				end
			end
		end
		-- Equipped Items
		for _, slotName in ipairs(slots) do
			local slotId = GetInventorySlotInfo(slotName);
			local link = GetInventoryItemLink("player",slotId);
			local itemId = link and tonumber(link:match(ITEMID_PATTERN));
			if (link) and (itemId) and (CheckItemTooltip(link,itemId)) then
				AddButton(index,nil,slotId,link,itemId);
				index = (index + 1);
			end
		end
		-- Set Shown Items
		self.shownItems = (index - 1);
		for i = index, #self.items do
			self.items[i]:Hide();
		end
		-- Update Misc
		self:UpdateCooldowns();
	end

	-- Update Cooldowns
	function EltruismQuestItemFrame:UpdateCooldowns()
		for i = 1, self.shownItems do
			local bag, slot = self.items[i]:GetAttribute("bag"), self.items[i]:GetAttribute("slot");
			if (bag) then
				CooldownFrame_Set(self.items[i].cooldown,GetContainerItemCooldown(bag,slot));
			else
				CooldownFrame_Set(self.items[i].cooldown,GetInventoryItemCooldown("player",slot));
			end
			if (not InCombatLockdown()) and (self.shownItems == 1 or cfg.lastItem == self.items[i].itemId) then
				self.items[i].bind:SetText(bindingText);
			end
		end
	end

	--------------------------------------------------------------------------------------------------------
	--                                               Events                                               --
	--------------------------------------------------------------------------------------------------------

	EltruismQuestItemFrame:SetScript("OnEvent",function(self,event,...)
		if (self[event]) then
			self[event](self,event,...);
		else
			self:RequestUpdate();
		end
	end);

	-- Update Cooldowns
	function EltruismQuestItemFrame:ACTIONBAR_UPDATE_COOLDOWN(event)
		if not self.shownItems then  --added this check
			self.shownItems = 0
		end
		if (self.shownItems > 0) then
			self:UpdateCooldowns();
		end
	end

	-- Inventory Changed
	function EltruismQuestItemFrame:UNIT_INVENTORY_CHANGED(event,unit)
		if (unit == "player") then
			self:RequestUpdate();
		end
	end

end

