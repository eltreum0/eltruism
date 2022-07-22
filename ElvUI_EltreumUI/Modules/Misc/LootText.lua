local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local Deformat = _G.LibStub("LibDeformat-3.0")
local CombatText = _G.CombatText
local CreateFrame = _G.CreateFrame
local getLoot = _G.getLoot
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll
local ERR_INV_FULL = _G.ERR_INV_FULL
local GetItemInfo = _G.GetItemInfo
local GetItemQualityColor = _G.GetItemQualityColor
local LOOT_MONEY_SPLIT = _G.LOOT_MONEY_SPLIT
local YOU_LOOT_MONEY = _G.YOU_LOOT_MONEY
local SILVER_AMOUNT = _G.SILVER_AMOUNT
local GOLD_AMOUNT = _G.GOLD_AMOUNT
local COPPER_AMOUNT = _G.COPPER_AMOUNT
local CURRENCY_GAINED_MULTIPLE_BONUS = _G.CURRENCY_GAINED_MULTIPLE_BONUS
local CURRENCY_GAINED_MULTIPLE = _G.CURRENCY_GAINED_MULTIPLE
local CURRENCY_GAINED = _G.CURRENCY_GAINED
local C_CurrencyInfo = _G.C_CurrencyInfo
local LOOT_ITEM_SELF_MULTIPLE = _G.LOOT_ITEM_SELF_MULTIPLE
local LOOT_ITEM_PUSHED_SELF_MULTIPLE = _G.LOOT_ITEM_PUSHED_SELF_MULTIPLE
local LOOT_ITEM_SELF = _G.LOOT_ITEM_SELF
local LOOT_ITEM_PUSHED_SELF = _G.LOOT_ITEM_PUSHED_SELF
local CombatText_GetAvailableString = _G.CombatText_GetAvailableString
local COMBAT_TEXT_LOCATIONS = _G.COMBAT_TEXT_LOCATIONS
local pairs = _G.pairs
local COMBAT_TEXT_TO_ANIMATE = _G.COMBAT_TEXT_TO_ANIMATE
local COMBAT_TEXT_SPACING = _G.COMBAT_TEXT_SPACING
local COMBAT_TEXT_MAX_OFFSET = _G.COMBAT_TEXT_MAX_OFFSET
local COMBAT_TEXT_X_ADJUSTMENT = _G.COMBAT_TEXT_X_ADJUSTMENT
local COMBAT_TEXT_CRIT_MINHEIGHT = _G.COMBAT_TEXT_CRIT_MINHEIGHT
local COMBAT_TEXT_HEIGHT = _G.COMBAT_TEXT_HEIGHT
local fastrandom = _G.fastrandom
local COMBAT_TEXT_STAGGER_RANGE = _G.COMBAT_TEXT_STAGGER_RANGE
local WorldFrame = _G.WorldFrame
local tinsert = _G.tinsert

-- LootText is a fork of Scrolling Loot Text (SLoTe) by xavjer using fixes by Eltreum for pet caging and other things
-- SLoTE uses GNU GPLv3 and as such this module of Eltruism also uses GNU GPLv3

--Create the loottext frame
local LootTextframe = CreateFrame("Frame", "EltruismLoot")
LootTextframe:RegisterEvent("UI_ERROR_MESSAGE")
LootTextframe:RegisterEvent("CHAT_MSG_LOOT")
LootTextframe:RegisterEvent("CHAT_MSG_MONEY")
LootTextframe:RegisterEvent("CHAT_MSG_CURRENCY")
LootTextframe:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
LootTextframe:RegisterEvent("LOOT_OPENED")
LootTextframe:RegisterEvent("PLAYER_REGEN_ENABLED")
LootTextframe:RegisterEvent("PLAYER_REGEN_DISABLED")

function ElvUI_EltreumUI:LootText()
	if E.db.ElvUI_EltreumUI.loottext.enable then
		local scale = E.db.ElvUI_EltreumUI.loottext.scale
		local strata = E.db.ElvUI_EltreumUI.loottext.strata
		CombatText:SetScale(scale)
		CombatText:SetFrameStrata(strata)
		--moving the combat text
		local xOffset = E.db.ElvUI_EltreumUI.loottext.xOffset
		local yOffset = E.db.ElvUI_EltreumUI.loottext.yOffset

		--have to hook the function to move it, pretty much a whole copy just adding the offsets
		CombatText_AddMessage = function (message, scrollFunction, r, g, b, displayType, isStaggered)
			local string, noStringsAvailable = CombatText_GetAvailableString()
			if ( noStringsAvailable ) then
				return
			end

			--use elvui general font
			if E.db.ElvUI_EltreumUI.loottext.fontsetting then
				string:SetFont(E.media.normFont, 24, E.db.general.fontStyle)
		 	end
			string:SetText(message)
			string:SetTextColor(r, g, b)
			string.scrollTime = 0
			if ( displayType == "crit" ) then
				string.scrollFunction = CombatText_StandardScroll
			else
				string.scrollFunction = scrollFunction
			end

			-- See which direction the message should flow
			--local yDir
			local lowestMessage
			local useXadjustment = 0
			if ( COMBAT_TEXT_LOCATIONS.startY < COMBAT_TEXT_LOCATIONS.endY ) then
				-- Flowing up
				lowestMessage = string:GetBottom()
				-- Find lowest message to anchor to
				--for index, value in pairs(COMBAT_TEXT_TO_ANIMATE) do
				for _, value in pairs(COMBAT_TEXT_TO_ANIMATE) do
					if ( lowestMessage >= value.yPos - 16 - COMBAT_TEXT_SPACING) then
						lowestMessage = value.yPos - 16 - COMBAT_TEXT_SPACING
					end
				end
				if ( lowestMessage < (COMBAT_TEXT_LOCATIONS.startY - COMBAT_TEXT_MAX_OFFSET) ) then
					if ( displayType == "crit" ) then
						lowestMessage = string:GetBottom()
					else
						COMBAT_TEXT_X_ADJUSTMENT = COMBAT_TEXT_X_ADJUSTMENT * -1
						useXadjustment = 1
						lowestMessage = COMBAT_TEXT_LOCATIONS.startY - COMBAT_TEXT_MAX_OFFSET
					end
				end
			else
				-- Flowing down
				lowestMessage = string:GetTop()
				-- Find lowest message to anchor to
				--for index, value in pairs(COMBAT_TEXT_TO_ANIMATE) do
				for _, value in pairs(COMBAT_TEXT_TO_ANIMATE) do
					if ( lowestMessage <= value.yPos + 16 + COMBAT_TEXT_SPACING) then
						lowestMessage = value.yPos + 16 + COMBAT_TEXT_SPACING
					end
				end
				if ( lowestMessage > (COMBAT_TEXT_LOCATIONS.startY + COMBAT_TEXT_MAX_OFFSET) ) then
					if ( displayType == "crit" ) then
						lowestMessage = string:GetTop()
					else
						COMBAT_TEXT_X_ADJUSTMENT = COMBAT_TEXT_X_ADJUSTMENT * -1
						useXadjustment = 1
						lowestMessage = COMBAT_TEXT_LOCATIONS.startY + COMBAT_TEXT_MAX_OFFSET
					end
				end
			end

			-- Handle crits
			if ( displayType == "crit" ) then
				string.endY = COMBAT_TEXT_LOCATIONS.startY
				string.isCrit = 1
				string:SetTextHeight(COMBAT_TEXT_CRIT_MINHEIGHT)
			elseif ( displayType == "sticky" ) then
				string.endY = COMBAT_TEXT_LOCATIONS.startY
				string:SetTextHeight(COMBAT_TEXT_HEIGHT)
			else
				string.endY = COMBAT_TEXT_LOCATIONS.endY
				string:SetTextHeight(COMBAT_TEXT_HEIGHT)
			end

			-- Stagger the text if flagged
			local staggerAmount = 0
			if ( isStaggered ) then
				staggerAmount = fastrandom(0, COMBAT_TEXT_STAGGER_RANGE) - COMBAT_TEXT_STAGGER_RANGE/2
			end

			-- Alternate x direction
			CombatText.xDir = CombatText.xDir * -1
			if ( useXadjustment == 1 ) then
				if ( COMBAT_TEXT_X_ADJUSTMENT > 0 ) then
					CombatText.xDir = -1
				else
					CombatText.xDir = 1
				end
			end
			string.xDir = CombatText.xDir
			string.startX = COMBAT_TEXT_LOCATIONS.startX + staggerAmount + (useXadjustment * COMBAT_TEXT_X_ADJUSTMENT) + xOffset
			string.startY = lowestMessage + yOffset
			string.yPos = lowestMessage
			string:ClearAllPoints()
			string:SetPoint("TOP", WorldFrame, "BOTTOM", string.startX, lowestMessage)
			string:SetAlpha(1)
			string:Show()
			tinsert(COMBAT_TEXT_TO_ANIMATE, string)
		end
		--end of CombatText_AddMessage hook

		local itemLink = nil
		local amount = 0
		--local YOU_LOOT_MONEY = YOU_LOOT_MONEY
		--local ERR_AUTOLOOT_MONEY_S = ERR_AUTOLOOT_MONEY_S
		--local LOOT_MONEY_SPLIT = LOOT_MONEY_SPLIT
		--local LOOT_ITEM_SELF_MULTIPLE = LOOT_ITEM_SELF_MULTIPLE
		--local LOOT_ITEM_SELF = LOOT_ITEM_SELF
		--local CURRENCY_GAINED_MULTIPLE = CURRENCY_GAINED_MULTIPLE
		--local CURRENCY_GAINED_MULTIPLE_BONUS = CURRENCY_GAINED_MULTIPLE_BONUS
		--local CURRENCY_GAINED = CURRENCY_GAINED
		--local CombatText_AddMessage = CombatText_AddMessage
		--local CombatText_StandardScroll = CombatText_StandardScroll
		--local GetItemInfo = GetItemInfo
		--local GetItemQualityColor = GetItemQualityColor
		--local C_CurrencyInfo = C_CurrencyInfo
		--local getLoot = getLoot
		--local LOOT_ITEM_PUSHED_SELF_MULTIPLE = LOOT_ITEM_PUSHED_SELF_MULTIPLE
		--local LOOT_ITEM_PUSHED_SELF = LOOT_ITEM_PUSHED_SELF

		function LootTextframe.OnEvent(self, event, arg1, arg2)
			if E.db.ElvUI_EltreumUI.loottext.combatindicator then
				if event == "PLAYER_REGEN_ENABLED" then
						CombatText_AddMessage("|cffFFFFFF-COMBAT|r", CombatText_StandardScroll, 1, 0, 0)
				end
				if event == "PLAYER_REGEN_DISABLED" then
						CombatText_AddMessage("|cffFF0000+COMBAT|r", CombatText_StandardScroll, 1, 0, 0)
				end
			end
			if event == "UI_ERROR_MESSAGE" and arg2 == ERR_INV_FULL then
					CombatText_AddMessage(L["INVENTORY IS FULL"], CombatText_StandardScroll, 1, 0, 0)
			end
			if (event == "CHAT_MSG_LOOT") then
				itemLink, amount = getLoot(arg1)
				if E.db.ElvUI_EltreumUI.loottext.pet then
					if itemLink and itemLink:match("|Hbattlepet:") then
						CombatText_AddMessage("|T ".. 132599 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..itemLink, CombatText_StandardScroll, 255, 255, 255)
					end
				end
				if itemLink and not itemLink:match("|Hbattlepet:") then
					local lootName, _, rarity, _, _, _, _, _, _, lootTexture, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
					local lootQuantity = amount
					local r, g, b, _ = GetItemQualityColor(rarity)
					if lootQuantity >= 2 then
						CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, CombatText_StandardScroll, r, g, b)
					else
						CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, CombatText_StandardScroll, r, g, b)
					end
				end
			end
			if E.db.ElvUI_EltreumUI.loottext.currency then
				if (event == "CHAT_MSG_MONEY") then
					local moneystring = Deformat(arg1, LOOT_MONEY_SPLIT) or Deformat(arg1, YOU_LOOT_MONEY)
					if moneystring:match(SILVER_AMOUNT) and not moneystring:match(GOLD_AMOUNT) then
						CombatText_AddMessage("|T ".. 133786 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, CombatText_StandardScroll, 255, 255, 255)
					elseif moneystring:match(COPPER_AMOUNT) and not moneystring:match(SILVER_AMOUNT) and not moneystring:match(GOLD_AMOUNT) then
						CombatText_AddMessage("|T ".. 133788 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, CombatText_StandardScroll, 255, 255, 255)
					elseif moneystring:match(GOLD_AMOUNT) then
						CombatText_AddMessage("|T ".. 133784 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, CombatText_StandardScroll, 255, 255, 255)
					else
						CombatText_AddMessage("|T ".. 133784 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, CombatText_StandardScroll, 255, 255, 255)
					end
				end
				if E.Retail then
					if (event == "CHAT_MSG_CURRENCY") then
						itemLink, amount = Deformat(arg1, CURRENCY_GAINED_MULTIPLE_BONUS)
						if not amount then
							itemLink, amount = Deformat(arg1, CURRENCY_GAINED_MULTIPLE)
						end
						if not amount then
							itemLink = Deformat(arg1, CURRENCY_GAINED)
							amount = 1
						end
						if itemLink then
							local info = C_CurrencyInfo.GetCurrencyInfoFromLink(itemLink)
							local lootTexture = info["iconFileID"]
							local lootName = info["name"]
							local lootQuantity = amount
							if itemLink:match(L["Soul Ash"]) then
								CombatText_AddMessage("|T ".. 3743738 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..lootQuantity.." x "..itemLink, CombatText_StandardScroll, 255, 255, 255)
							end
							if not itemLink:match(L["Soul Ash"]) then
								if lootQuantity >= 2 then
									CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, CombatText_StandardScroll, 255, 255, 255)
								else
									CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, CombatText_StandardScroll, 255, 255, 255)
								end
							end
						end
					end
				end
			end
			if E.db.ElvUI_EltreumUI.loottext.honor then
				if (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
					itemLink, amount = Deformat(arg1, CURRENCY_GAINED_MULTIPLE_BONUS)
					if not amount then
						itemLink, amount = Deformat(arg1, CURRENCY_GAINED_MULTIPLE)
					end
					if not amount then
						itemLink = Deformat(arg1, CURRENCY_GAINED)
						amount = 1
					end
					if itemLink then
						if not amount then
						amount = 1
						end
						local info = C_CurrencyInfo.GetCurrencyInfoFromLink(itemLink)
						local lootTexture = info["iconFileID"]
						local lootName = info["name"]
						local lootQuantity = amount
						if lootQuantity >= 2 then
							CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, CombatText_StandardScroll, 255, 255, 255)
						else
							CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, CombatText_StandardScroll, 255, 255, 255)
						end
					end
				end
			end
		end

		function getLoot(chatmsg)
			-- check for multiple-item-loot
			local itemLink, amount = Deformat(chatmsg, LOOT_ITEM_SELF_MULTIPLE)
			if not itemLink then
				itemLink, amount = Deformat(chatmsg, LOOT_ITEM_PUSHED_SELF_MULTIPLE)
			end
			-- check for single-itemloot
			if not itemLink then
				itemLink = Deformat(chatmsg, LOOT_ITEM_SELF)
			end
			if not itemLink then
				itemLink, amount = Deformat(chatmsg, LOOT_ITEM_PUSHED_SELF)
			end
			-- if something has been looted
			if itemLink then
				if not amount then
					amount = 1
				end
				return itemLink, amount
			end
		end
		LootTextframe:SetScript("OnEvent", LootTextframe.OnEvent)
	end
end
