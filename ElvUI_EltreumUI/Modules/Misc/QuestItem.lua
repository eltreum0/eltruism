local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local BackdropTemplateMixin = _G.BackdropTemplateMixin
local IsInInstance = _G.IsInInstance
local GetItemClassInfo = _G.C_Item and _G.C_Item.GetItemClassInfo or _G.GetItemClassInfo
local InCombatLockdown = _G.InCombatLockdown
local GetBindingKey = _G.GetBindingKey
local SetBindingClick = _G.SetBindingClick
local HandleModifiedItemClick = _G.HandleModifiedItemClick
local GameTooltip = _G.GameTooltip
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local ipairs = _G.ipairs
local C_Container = _G.C_Container
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemLink = C_Container.GetContainerItemLink
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetContainerItemCooldown = C_Container.GetContainerItemCooldown
local tonumber = _G.tonumber
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
local GetBindingText = _G.GetBindingText
local CooldownFrame_Set = _G.CooldownFrame_Set
local _, instanceType
local GetItemSpell = _G.C_Item and _G.C_Item.GetItemSpell or _G.GetItemSpell


--A merge of QBAr by Aezay with a few edits by Eltreum
--This module is GNU GPL v3
local EltruismQuestItemFrame = CreateFrame("Frame", "EltruismQuestItem", UIParent, BackdropTemplateMixin and "BackdropTemplate")	-- 9.0.1: Using BackdropTemplate
EltruismQuestItemFrame:SetPoint("BOTTOM", E.UIParent, "BOTTOM", 0, 34)
E:CreateMover(EltruismQuestItemFrame, "MoverEltruismQuestItem", "EltruismQuestItemBar", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,quests,item')
EltruismQuestItemFrame.tip = CreateFrame("GameTooltip","EltruismQuestItemTip",nil,"GameTooltipTemplate")
EltruismQuestItemFrame.tip:SetOwner(UIParent,"ANCHOR_NONE")
EltruismQuestItemFrame.items = {}

-- Constants
local UPDATE_DELAY = 1.0 --was 0.5 but i think that might be too low
local ITEMID_PATTERN = "item:(%d+)"
local QUEST_TOKEN = (GetItemClassInfo and GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM or 12) or LOOT_JOURNAL_LEGENDARIES_SOURCE_QUEST or "Quest") -- Obtain the localization of the "Quest" type for items -- [7.0.3/Legion] API Removed: GetAuctionItemClasses()

local slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
	"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
	"MainHandSlot", "SecondaryHandSlot",
}

-- These items are not marked as being quest items, but we want to include them anyway
local qItems = {
	972,
	3985,
	4854,
	4945,
	5411,
	5456,	-- Divining Scroll (item has no Use: text, even though you can use it)
	5996,
	6372,
	6636,
	7843,
	8432,
	8474,
	8529,
	10569,
	10687,
	10688,
	10689,
	10690,
	10695,
	11116,
	11568,
	11582,	-- Fel Salve
	11914, -- Cursed Ooze Jar
	11948,	-- Tainted Ooze Jar
	11955,
	12565,
	12886,
	12922,	-- Empty Canteen
	16302,
	16321,
	16790,
	20483,
	21713,	-- Elune's Candle (Lunar Festival)
	23361,	-- Cleansing Vial
	23417,
	23645,
	23792,	-- Tree Disguise Kit
	23818,	-- Stillpine Furbolg Language Primer
	24084,	-- Draenei Banner
	24278,	-- Flare Gun
	24330,
	24335,
	24355,
	24355,	-- Ironvine Seeds
	24421,
	24467, -- living fire
	24474,
	24501,	-- Gordawg's Boulder
	24504,
	24558,
	24559,
	25458, -- mag'har battle standard
	25465,	-- Stormcrow Amulet
	25539,
	25552,	-- Warmaul Ogre Banner
	25555,	-- Kil'sorrow Banner
	25658,	-- Damp Woolen Blanket
	25853,	-- Pack of Incendiary Bombs (Old Hillsbrad)
	28038,	-- Seaforium PU-36 Explosive Nether Modulator
	28132,	-- Area 52 Special
	28607, -- Sunfury Disguise
	29324,
	29443,
	29473,
	29588,
	29590,
	29778,
	30105,
	30540,
	30576,
	30712,
	30719,
	30811,
	31121,
	31122,
	31495,
	31518,
	31664,
	31702,
	31955,
	32385,
	32386,
	32405,
	32406,
	32726,
	32971,	-- Water Bucket (Hallow's End)
	33096,	-- Complimentary Brewfest Sampler (Brew Fest)
	33349, --plague vials
	33614, --empty apothecary's flask
	33615, --flask of vrykul blood
	33621, --plague spray
	33634,	-- Orehammer's Precision Bombs, quest from Howling Fjord
	34023, --empty apothecary's flask
	34024, --flask of vrykul blood
	34076,
	34475, -- arcane charges
	34483, --orb of murloc control
	34871,
	35233, --multiphase spectographic goggles
	35704,
	35792,
	36770,
	36771,
	37173,
	37265,
	37445,
	37661, --gossamer potion
	37708,
	37877,
	38351,
	38657,
	38659,
	38676,
	38684,
	38689,
	38697,
	38699,
	38701,
	38709,
	38731,
	39041,
	39154,
	39157,
	39158,
	39164,
	39165,
	39187,
	39206,
	39238,
	39253,
	39268,
	39566,
	39574,
	39576,
	39615,
	39645,
	39664,
	39700,
	39737,
	40390,
	40397,
	40551,
	40587,
	40676,
	40730,
	40731,
	40732,
	40946,
	41131,
	41179,
	41340,
	41366,
	41372,
	41390,
	41430,
	41431,
	41615,
	41776,
	41988,
	42164,
	42419,
	42424,
	42441,
	42442,
	42479,
	42480,
	42481,
	42499,
	42624,
	42679,
	42769,
	42774,
	42781,
	42797,
	42837,
	42840,
	42918,
	42928,
	43101,
	43139,
	43142,
	43147,
	43153,
	43166,
	43206,
	43243,
	43289,
	43315,
	43524,
	43564,
	43608,
	43968,
	44048,
	44064,
	44065,
	44127,
	44186,
	44212,
	44222,
	44251,
	44304,
	44307,
	44433,
	44450,
	44653,
	44704,
	44890,
	44950,
	45067,	-- Egg Basket -- Az: offhand item, but I wanted it on my bar for a hotkey
	46861,	-- Bouquet of Orange Marigolds (Day of the Dead)
	49132, -- fireliminator x-21
	49278,	-- Goblin Rocket Pack (ICC - Lootship)
	49368, -- ambassador disquise
	56909,	-- Earthen Ring Unbinding Totem (Cata event)
	60501, 	-- Stormstone, Deepholm Quest
	185956,
	180008, --resonating anima core
	45072, --noblegarden egg that has to be opened
}
local blocklist = {
	[176809] = true, -- junk item that for some reason showed up
	[8529] = true, --noggenfogger
	[180536] = true, --broken kyrian flute, can't be used
	[180817] = true, -- cypher of relocation
	[45067] = true, --noblegarden dress transmog
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
	if E.db.ElvUI_EltreumUI.quests.questitems then
		_, instanceType = IsInInstance()
		if instanceType ~= "none" then
			EltruismQuestItemFrame:Hide()
			EltruismQuestItemFrame:UnregisterAllEvents()
		else
			--Events
			--these events will fire correctly
			--ACTIONBAR_UPDATE_COOLDOWN,UNIT_INVENTORY_CHANGED,MAIL_SUCCESS
			EltruismQuestItemFrame:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
			EltruismQuestItemFrame:RegisterEvent("MAIL_SUCCESS") -- when mailing quest items UNIT_INVENTORY_CHANGED does not fire

			--these events will simply request an update
			EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE_DELAYED")
			--EltruismQuestItemFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
			EltruismQuestItemFrame:RegisterEvent("QUEST_WATCH_UPDATE")
			EltruismQuestItemFrame:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
			EltruismQuestItemFrame:RegisterEvent("QUEST_ACCEPTED") -- Needed for items that starts a quest, when we accept it, update to remove the icon
			--EltruismQuestItemFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
			--EltruismQuestItemFrame:RegisterEvent("UPDATE_BINDINGS")
			EltruismQuestItemFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
			--these were causing memory issues, exploding whenever a waypoint was set
			--EltruismQuestItemFrame:RegisterEvent("QUEST_LOG_UPDATE") -- For when items get added/removed during quest
			EltruismQuestItemFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")	-- Should work better than PLAYER_ENTERING_WORLD

			if not InCombatLockdown() then
				EltruismQuestItemFrame:Show()
			end

			if E.db.ElvUI_EltreumUI.quests.questitemsbar1 and E.private.actionbar.enable then
				if not InCombatLockdown() then
					EltruismQuestItemFrame:SetParent(_G["ElvUI_Bar1Button1"])
				end
			end
			if not InCombatLockdown() then
				EltruismQuestItemFrame:SetSize(E.db.ElvUI_EltreumUI.quests.questitemsize,E.db.ElvUI_EltreumUI.quests.questitemsize)
				EltruismQuestItemFrame:SetClampedToScreen(true)
				EltruismQuestItemFrame:SetFrameStrata("MEDIUM")
			end


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

			--register keybind
			if not InCombatLockdown() then
				if bindingText1 then
					--SetBindingClick(bindingText1, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1))
					SetBindingClick(bindingText1, "EltruismQuestItem1")
				end
				if bindingText2 then
					--SetBindingClick(bindingText2, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 2))
					SetBindingClick(bindingText2, "EltruismQuestItem2")
				end
				if bindingText3 then
					--SetBindingClick(bindingText3, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 3))
					SetBindingClick(bindingText3, "EltruismQuestItem3")
				end
				if bindingText4 then
					--SetBindingClick(bindingText4, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 4))
					SetBindingClick(bindingText4, "EltruismQuestItem4")
				end
				if bindingText5 then
					--SetBindingClick(bindingText5, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 5))
					SetBindingClick(bindingText5, "EltruismQuestItem5")
				end
				if bindingText6 then
					--SetBindingClick(bindingText6, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 6))
					SetBindingClick(bindingText6, "EltruismQuestItem6")
				end
				if bindingText7 then
					--SetBindingClick(bindingText7, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 7))
					SetBindingClick(bindingText7, "EltruismQuestItem7")
				end
				if bindingText8 then
					--SetBindingClick(bindingText8, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 8))
					SetBindingClick(bindingText8, "EltruismQuestItem8")
				end
				if bindingText9 then
					--SetBindingClick(bindingText9, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 9))
					SetBindingClick(bindingText9, "EltruismQuestItem9")
				end
				if bindingText10 then
					--SetBindingClick(bindingText10, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 10))
					SetBindingClick(bindingText10, "EltruismQuestItem10")
				end
				if bindingText11 then
					--SetBindingClick(bindingText11, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 11))
					SetBindingClick(bindingText11, "EltruismQuestItem11")
				end
				if bindingText12 then
					--SetBindingClick(bindingText12, "EltruismQuestItem"..(#EltruismQuestItemFrame.items + 12))
					SetBindingClick(bindingText12, "EltruismQuestItem12")
				end
			end

			-- update mover position
			function EltruismQuestItemFrame:FixPosition()
				--print("fixing position")
				E:Delay(0, function()
					if not InCombatLockdown() and _G["EltruismQuestItem1"] then
						local point, relativeTo, relativePoint, xOfs, yOfs = EltruismQuestItemFrame:GetPoint()
						_G["EltruismQuestItem1"]:ClearAllPoints()
						if E.db.ElvUI_EltreumUI.quests.questorientation == "HORIZONTAL" then
							if EltruismQuestItemFrame.shownItems ~= 1 then
								if (EltruismQuestItemFrame.shownItems % 2) == 0 then
									if xOfs >= 0 then
										--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2), yOfs)
										_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2)-(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2), yOfs)
									elseif xOfs < 0 then
										--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2), yOfs)
										_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-1)*E.db.ElvUI_EltreumUI.quests.questitemsize)/2)+(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2), yOfs)
									end
								else
									if xOfs >= 0 then
										--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize+1))/2), yOfs)
										_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs-(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2)-(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize+1))/2), yOfs)
									elseif xOfs < 0 then
										--_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize-1))/2), yOfs)
										_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs+(E.db.ElvUI_EltreumUI.quests.questitemspacing *(EltruismQuestItemFrame.shownItems-1)/2)+(((EltruismQuestItemFrame.shownItems-(EltruismQuestItemFrame.shownItems % 2))*(E.db.ElvUI_EltreumUI.quests.questitemsize-1))/2), yOfs)
									end
								end
							else
								_G["EltruismQuestItem1"]:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
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
			local function OnUpdate(_,elapsed)
				--print("quest item spam "..math.random(1,99))
				EltruismQuestItemFrame.updateTime = (EltruismQuestItemFrame.updateTime + elapsed)
				if (EltruismQuestItemFrame.updateTime > UPDATE_DELAY) then
					--print("setting onupdate to nil, updating buttons")
					--print("updated in: ", EltruismQuestItemFrame.updateTime)
					EltruismQuestItemFrame:SetScript("OnUpdate",nil)
					EltruismQuestItemFrame:UpdateButtons()
				end
			end
			--------------------------------------------------------------------------------------------------------
			--                                                Items                                               --
			--------------------------------------------------------------------------------------------------------
			-- OnClick
			--local function Button_OnClick(self,button, down)
			local function Button_OnClick(button, _, _)
				--print(button,down)
				-- Handle Modified Click
				--print("button_onclick")
				if (HandleModifiedItemClick(button.link)) then
					return
				end
				button:Click("LeftButton", true)
			end

			-- Make Loot Button
			local function CreateItemButton()
				--print("creatingitembutton")
				local b = CreateFrame("Button","EltruismQuestItem"..(#EltruismQuestItemFrame.items + 1),EltruismQuestItemFrame,"SecureActionButtonTemplate")
				b:CreateBackdrop('Transparent')
				b:SetSize(E.db.ElvUI_EltreumUI.quests.questitemsize,E.db.ElvUI_EltreumUI.quests.questitemsizey)
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not b.shadow then
						b:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(b.shadow)
					end
				end
				b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
				b:RegisterForClicks("LeftButtonUp","RightButtonUp")
				b:SetScript("OnEnter", function (button)
					GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
					local bag, slot = button:GetAttribute("bag"), button:GetAttribute("slot")
					if (bag) then
						GameTooltip:SetBagItem(bag,slot)
					else
						GameTooltip:SetInventoryItem("player",slot)
					end
					if E.db.ElvUI_EltreumUI.quests.questitemsfade then
						b:SetAlpha(1)
					end
				end)
				b:SetScript("OnLeave", function()
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
				b.count:SetFont(E.LSM:Fetch("font", E.db.general.font), 14, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				b.count:SetTextColor(1,1,1)
				b.count:SetPoint("BOTTOMRIGHT",b.icon, 0, 0)

				b.cooldown = CreateFrame("Cooldown",nil,b,"CooldownFrameTemplate")
				b.cooldown:SetAllPoints()
				E:RegisterCooldown(b.cooldown)

				if E.db.ElvUI_EltreumUI.quests.showkeybind then
					b.bind = b:CreateFontString(nil,"ARTWORK","NumberFontNormalSmallGray")
					b.bind:SetPoint("TOPLEFT",b.icon,0,0)
					b.bind:SetPoint("TOPRIGHT",b.icon,0,0)
					b.bind:SetJustifyH("LEFT")
				end

				b:Show()
				--if (#EltruismQuestItemFrame.items == 0) then
				if (EltruismQuestItemFrame.shownItems == 0) then
					if E.db.ElvUI_EltreumUI.quests.questorientation == "HORIZONTAL" then
						b:SetPoint("TOPLEFT",EltruismQuestItemFrame,0,0)
					else
						b:SetPoint("BOTTOM",EltruismQuestItemFrame,0,0)
					end
				end
				EltruismQuestItemFrame.items[#EltruismQuestItemFrame.items + 1] = b
				return b
			end

			-- Add Button
			local function AddButton(index,bag,slot,link,itemId,count)
				--print("adding button")
				local btn = EltruismQuestItemFrame.items[index] or CreateItemButton()
				local _, _, _, _, _, _, _, _, _, itemTexture, _, _ = GetItemInfo(link)
				--print(link,index)
				btn.icon:SetTexture(itemTexture)
				--btn.icon:SetTexCoord(0.08,0.92,0.08,0.92)
				--btn.icon:SetTexCoord(unpack(E.TexCoords))

				--from elvui trim action bar button
				local left, right, top, bottom = 0.08,0.92,0.08,0.92
				local width, height = btn:GetSize()
				local ratio = width / height
				if ratio > 1 then
					local trimAmount = (1 - (1 / ratio)) * 0.5
					top = top + trimAmount
					bottom = bottom - trimAmount
				else
					local trimAmount = (1 - ratio) * 0.5
					left = left + trimAmount
					right = right - trimAmount
				end
				btn.icon:SetTexCoord(left, right, top, bottom)
				btn.count:SetText(count and count > 1 and count or "")

				btn.link = link
				btn.itemId = itemId

				btn:SetAttribute("bag",bag)
				btn:SetAttribute("slot",slot)
				btn:RegisterForClicks("AnyDown", "AnyUp")

				if (index > 1) then
					btn:ClearAllPoints()
					if E.db.ElvUI_EltreumUI.quests.questorientation == "HORIZONTAL" then
						btn:SetPoint("LEFT", EltruismQuestItemFrame.items[index - 1], "RIGHT", E.db.ElvUI_EltreumUI.quests.questitemspacing, 0) --CONTROLS SPACING
					else
						btn:SetPoint("TOP", EltruismQuestItemFrame.items[index - 1], "BOTTOM", 0, -E.db.ElvUI_EltreumUI.quests.questitemspacing) --CONTROLS SPACING
					end
				end
				btn:Show()

				-- update mover position
				EltruismQuestItemFrame:FixPosition()
			end

			-- Check Item -- Az: Some items which starts a quest, are not marked as "Quest" in itemType or itemSubType. Ex: item:17008
			local function CheckItemTooltip(link,itemId)
				--print("checking item tooltip")
				local _, _, _, _, _, itemType, itemSubType, _, itemEquipLoc, _, _, classID = GetItemInfo(link)

				-- Include predefinded items
				for _, id in ipairs(qItems) do
					if (itemId == id) and not blocklist[itemId] then
						return 1
					end
				end

				--old, was causing issues
				-- Scan Tip -- Az: any reason we cant just check for more or equal to 4 lines, or would some quest items fail that check?
				--[[EltruismQuestItemFrame.tip:ClearLines()
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
				end]]

				--new
				if (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12) and itemEquipLoc == "" and GetItemSpell(itemId) ~= nil then
					if not blocklist[itemId] then
						return 1
					end
				end
			end
			--------------------------------------------------------------------------------------------------------
			--                                               Update                                               --
			--------------------------------------------------------------------------------------------------------
			-- Request a Button Update
			function EltruismQuestItemFrame:RequestUpdate()
				--print("requesting update")
				EltruismQuestItemFrame.updateTime = 0
				EltruismQuestItemFrame:SetScript("OnUpdate",OnUpdate)
				--print("re quest item spam "..math.random(1,99))
			end
			EltruismQuestItemFrame:RequestUpdate()

			--check for other buttons that are the same
			local function CheckButtonExistence(itemId)
				for i =1, #EltruismQuestItemFrame.items do
					if EltruismQuestItemFrame.items[i].itemId and EltruismQuestItemFrame.items[i].itemId == itemId then
						return false
					end
				end

				return true
			end

			-- Update Buttons
			function EltruismQuestItemFrame:UpdateButtons()
				--print("updating buttons function")
				-- Check if we are locked by combat
				if (InCombatLockdown()) then
					return
				end

				--reset ids
				if #EltruismQuestItemFrame.items > 0 then
					for i =1, #EltruismQuestItemFrame.items do
						EltruismQuestItemFrame.items[i].itemId = 0
					end
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
								local _, _, _, _, _, itemType, itemSubType, _, _, _, _, classID = GetItemInfo(link)
								if CheckButtonExistence(itemId) then
									if E.Retail or E.Cata then
										local questInfo = C_Container.GetContainerItemQuestInfo(bag,slot)
										if ((questInfo.isQuestItem or (itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12)) and GetItemSpell(itemId) ~= nil) or (CheckItemTooltip(link,itemId)) then
											local _, count = GetContainerItemInfo(bag,slot)
											AddButton(index,bag,slot,link,itemId,count)
											index = (index + 1)
										end
									elseif E.Cata or E.Classic then
										if ((itemType == QUEST_TOKEN or itemSubType == QUEST_TOKEN or classID == 12) and GetItemSpell(itemId) ~= nil) or (CheckItemTooltip(link,itemId)) then
											local _, count = GetContainerItemInfo(bag,slot)
											AddButton(index,bag,slot,link,itemId,count)
											index = (index + 1)
										end
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
						if CheckButtonExistence(itemId) then
							if not blocklist[itemId] then
								AddButton(index,nil,slotId,link,itemId)
								index = (index + 1)
							end
						end
					end
				end

				-- Set Shown Items
				EltruismQuestItemFrame.shownItems = (index - 1)
				for i = index, #self.items do
					self.items[i]:Hide()
				end

				--update bind text
				if E.db.ElvUI_EltreumUI.quests.showkeybind then
					for i = 1, EltruismQuestItemFrame.shownItems do
						self.items[i].bind:SetText(GetBindingText(GetBindingKey("CLICK ".."EltruismQuestItem"..i..":LeftButton")))
					end
				end

				-- Update Misc
				EltruismQuestItemFrame:UpdateCooldowns()
			end

			-- Update Cooldowns
			function EltruismQuestItemFrame:UpdateCooldowns()
				--print("updating cooldowns function")
				for i = 1, EltruismQuestItemFrame.shownItems do
					local bag, slot = self.items[i]:GetAttribute("bag"), self.items[i]:GetAttribute("slot")
					if (bag) then
						CooldownFrame_Set(self.items[i].cooldown,GetContainerItemCooldown(bag,slot))
					else
						CooldownFrame_Set(self.items[i].cooldown,GetInventoryItemCooldown("player",slot))
					end
				end
				if E.db.ElvUI_EltreumUI.quests.showkeybind then
					if bindingText1 and EltruismQuestItemFrame.shownItems >= 1 then
						self.items[1].bind:SetText(bindingText1)
					end
					if bindingText2 and EltruismQuestItemFrame.shownItems >= 2 then
						self.items[2].bind:SetText(bindingText2)
					end
					if bindingText3 and EltruismQuestItemFrame.shownItems >= 3 then
						self.items[3].bind:SetText(bindingText3)
					end
					if bindingText4 and EltruismQuestItemFrame.shownItems >= 4 then
						self.items[4].bind:SetText(bindingText4)
					end
					if bindingText5 and EltruismQuestItemFrame.shownItems >= 5 then
						self.items[5].bind:SetText(bindingText5)
					end
					if bindingText6 and EltruismQuestItemFrame.shownItems >= 6 then
						self.items[6].bind:SetText(bindingText6)
					end
					if bindingText7 and EltruismQuestItemFrame.shownItems >= 7 then
						self.items[7].bind:SetText(bindingText7)
					end
					if bindingText8 and EltruismQuestItemFrame.shownItems >= 8 then
						self.items[8].bind:SetText(bindingText8)
					end
					if bindingText9 and EltruismQuestItemFrame.shownItems >= 9 then
						self.items[9].bind:SetText(bindingText9)
					end
					if bindingText10 and EltruismQuestItemFrame.shownItems >= 10 then
						self.items[10].bind:SetText(bindingText10)
					end
					if bindingText11 and EltruismQuestItemFrame.shownItems >= 11 then
						self.items[11].bind:SetText(bindingText11)
					end
					if bindingText12 and EltruismQuestItemFrame.shownItems >= 12 then
						self.items[12].bind:SetText(bindingText12)
					end
				end
			end

			--------------------------------------------------------------------------------------------------------
			--                                               Events                                               --
			--------------------------------------------------------------------------------------------------------
			EltruismQuestItemFrame:SetScript("OnEvent",function(frame,event,...)
				--print(event.." quest onevent spam "..math.random(1,99))
				if (frame[event]) then
					--print("registered",event)
					frame[event](frame,event,...)
				else
					--print("unregisteredevent",event)
					EltruismQuestItemFrame:RequestUpdate()
				end
			end)

			-- Update Cooldowns
			function EltruismQuestItemFrame:ACTIONBAR_UPDATE_COOLDOWN()
				--print("actionbar update cooldown")
				if not EltruismQuestItemFrame.shownItems then --added this check
					EltruismQuestItemFrame.shownItems = 0
				end
				if (EltruismQuestItemFrame.shownItems > 0) then
					EltruismQuestItemFrame:UpdateCooldowns()
				end
			end

			-- Inventory Changed
			function EltruismQuestItemFrame:UNIT_INVENTORY_CHANGED(_,unit)
				--print("unit inventory changed")
				if (unit == "player") then
					EltruismQuestItemFrame:RequestUpdate()
					-- update mover position
					EltruismQuestItemFrame:FixPosition()
				end
			end

			-- Inventory might've changed because of mail
			function EltruismQuestItemFrame:MAIL_SUCCESS()
				--print("mail sucess")
				EltruismQuestItemFrame:RequestUpdate()
				-- update mover position
				EltruismQuestItemFrame:FixPosition()
			end

		end
	else
		EltruismQuestItemFrame:UnregisterAllEvents()
	end
end
