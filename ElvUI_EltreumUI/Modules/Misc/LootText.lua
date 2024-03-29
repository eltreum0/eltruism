local E, L = unpack(ElvUI)
local _G = _G
local Deformat = _G.LibStub("LibDeformat-3.0")
local CreateFrame = _G.CreateFrame
local pairs = _G.pairs
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo

-- LootText is a fork of Scrolling Loot Text (SLoTe) by xavjer using fixes by Eltreum for pet caging and other things
-- SLoTE uses GNU GPLv3 and as such this module of Eltruism also uses GNU GPLv3

--Create the loottext frame
local LootTextframe = CreateFrame("Frame", "EltruismLoot")
LootTextframe:RegisterEvent("UI_ERROR_MESSAGE")
LootTextframe:RegisterEvent("CHAT_MSG_LOOT")
LootTextframe:RegisterEvent("CHAT_MSG_MONEY")
LootTextframe:RegisterEvent("CHAT_MSG_CURRENCY")
LootTextframe:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
LootTextframe:RegisterEvent("CHAT_MSG_SKILL") --profession level up
--LootTextframe:RegisterEvent("CHAT_MSG_TRADESKILLS")
LootTextframe:RegisterEvent("LOOT_OPENED")

local combatindicatorframe = CreateFrame("Frame")
combatindicatorframe:RegisterEvent("PLAYER_REGEN_ENABLED")
combatindicatorframe:RegisterEvent("PLAYER_REGEN_DISABLED")
local errorthrottle = false

function ElvUI_EltreumUI:LootText()
	_G.CombatText:SetScale(E.db.ElvUI_EltreumUI.loot.loottext.scale)
	_G.CombatText:SetFrameStrata(E.db.ElvUI_EltreumUI.loot.loottext.strata)
	--moving the combat text
	local itemLink = nil
	local amount = 0
	--have to hook the function to move it, pretty much a whole copy just adding the offsets
	CombatText_AddMessage = function (message, scrollFunction, r, g, b, displayType, isStaggered)
		local string, noStringsAvailable = CombatText_GetAvailableString()
		if ( noStringsAvailable ) then
			return
		end

		--use elvui general font
		if E.db.ElvUI_EltreumUI.loot.loottext.fontsetting then
			string:SetFont(E.media.normFont, E.db.ElvUI_EltreumUI.loot.loottext.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		elseif E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg then
			string:SetFont(E.private.general.dmgfont, E.db.ElvUI_EltreumUI.loot.loottext.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		elseif E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable then
			string:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.loot.loottext.fontLSM), E.db.ElvUI_EltreumUI.loot.loottext.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
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
		local lowestMessage
		local useXadjustment = 0

		if not COMBAT_TEXT_LOCATIONS.startY then
			COMBAT_TEXT_LOCATIONS.startY = 384
		end
		if not COMBAT_TEXT_LOCATIONS.endY then
			COMBAT_TEXT_LOCATIONS.endY = 609
		end
		if not COMBAT_TEXT_LOCATIONS.startX then
			COMBAT_TEXT_LOCATIONS.startX = 0
		end
		if not COMBAT_TEXT_LOCATIONS.endX then
			COMBAT_TEXT_LOCATIONS.endX = 0
		end

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
			--string:SetTextHeight(COMBAT_TEXT_CRIT_MINHEIGHT)
			string:SetTextHeight(E.db.ElvUI_EltreumUI.loot.loottext.fontsize * 1.3)
		elseif ( displayType == "sticky" ) then
			string.endY = COMBAT_TEXT_LOCATIONS.startY
			--string:SetTextHeight(COMBAT_TEXT_HEIGHT)
			string:SetTextHeight(E.db.ElvUI_EltreumUI.loot.loottext.fontsize)
		else
			string.endY = COMBAT_TEXT_LOCATIONS.endY
			--string:SetTextHeight(COMBAT_TEXT_HEIGHT)
			string:SetTextHeight(E.db.ElvUI_EltreumUI.loot.loottext.fontsize)
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
		string.startX = COMBAT_TEXT_LOCATIONS.startX + staggerAmount + (useXadjustment * COMBAT_TEXT_X_ADJUSTMENT) + E.db.ElvUI_EltreumUI.loot.loottext.xOffset
		string.startY = lowestMessage + E.db.ElvUI_EltreumUI.loot.loottext.yOffset
		string.yPos = lowestMessage
		string:ClearAllPoints()
		string:SetPoint("TOP", WorldFrame, "BOTTOM", string.startX, lowestMessage)
		string:SetAlpha(1)
		string:Show()
		tinsert(COMBAT_TEXT_TO_ANIMATE, string)
	end
	--end of CombatText_AddMessage hook

	combatindicatorframe:SetScript("OnEvent", function(_,event)
		if E.db.ElvUI_EltreumUI.loot.loottext.combatindicator then
			if event == "PLAYER_REGEN_DISABLED" then
				if E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable then
					CombatText_AddMessage(E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enter, CombatText_StandardScroll, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor.r, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor.g, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor.b)
				else
					CombatText_AddMessage("|cffFF0000+"..string.upper(COMBAT).."|r", CombatText_StandardScroll, 1, 0, 0)
				end
			end
			if event == "PLAYER_REGEN_ENABLED" then
				if E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable then
					CombatText_AddMessage(E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leave, CombatText_StandardScroll, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor.r, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor.g, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor.b)
				else
					CombatText_AddMessage("|cffFFFFFF-"..string.upper(COMBAT).."|r", CombatText_StandardScroll, 1, 0, 0)
				end
			end
		end
	end)

	if E.db.ElvUI_EltreumUI.loot.loottext.enable then
		local function getLoot(chatmsg)
			-- check for multiple-item-loot
			local itemLink2, amount2 = Deformat(chatmsg, LOOT_ITEM_SELF_MULTIPLE)
			if not itemLink2 then
				itemLink2, amount2 = Deformat(chatmsg, LOOT_ITEM_PUSHED_SELF_MULTIPLE)
			end
			-- check for single-itemloot
			if not itemLink2 then
				itemLink2 = Deformat(chatmsg, LOOT_ITEM_SELF)
			end
			if not itemLink2 then
				itemLink2, amount2 = Deformat(chatmsg, LOOT_ITEM_PUSHED_SELF)
			end
			--check for created item
			if not itemLink2 then
				itemLink2,amount2 = Deformat(chatmsg, LOOT_ITEM_CREATED_SELF)
			end
			if not itemLink2 then
				itemLink2,amount2 = Deformat(chatmsg, TRADESKILL_LOG_FIRSTPERSON)
			end
			if not itemLink2 then
				itemLink2,amount2 = Deformat(chatmsg, LOOT_ITEM_CREATED_SELF_MULTIPLE)
			end
			-- if something has been looted
			if itemLink2 then
				if not amount2 then
					amount2 = 1
				end
				return itemLink2, amount2
			end
		end

		LootTextframe:SetScript("OnEvent",function(_, event, arg1, arg2)
			if event == "UI_ERROR_MESSAGE" and arg2 == ERR_INV_FULL then
				if not errorthrottle then
					CombatText_AddMessage(INVENTORY_FULL, CombatText_StandardScroll, 1, 0, 0) --apparently it spams for some people
					errorthrottle = true
					E:Delay(3, function() errorthrottle = false end)
				end
			end
			if (event == "CHAT_MSG_LOOT") then
				itemLink, amount = getLoot(arg1)
				if E.db.ElvUI_EltreumUI.loot.loottext.pet then
					if itemLink and itemLink:match("|Hbattlepet:") then
						CombatText_AddMessage("|T ".. 132599 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..itemLink, CombatText_StandardScroll, 255, 255, 255)
					end
				end
				if itemLink and not itemLink:match("|Hbattlepet:") then
					local lootName, _, rarity, _, _, _, _, _, _, lootTexture, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
					local lootQuantity = amount
					if not rarity then return end
					local r, g, b, _ = GetItemQualityColor(rarity)
					if rarity >= tonumber(E.db.ElvUI_EltreumUI.loot.loottext.quality) then
						if lootQuantity >= 2 then
							CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, CombatText_StandardScroll, r, g, b)
						else
							CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, CombatText_StandardScroll, r, g, b)
						end
					end
				end
			end
			if E.db.ElvUI_EltreumUI.loot.loottext.currency then
				if (event == "CHAT_MSG_MONEY") then
					local moneystring = Deformat(arg1, LOOT_MONEY_SPLIT) or Deformat(arg1, YOU_LOOT_MONEY)
					if not moneystring then
						moneystring = Deformat(arg1, LOOT_CURRENCY_REFUND) or Deformat(arg1, LOOT_MONEY_REFUND)
					end
					if moneystring then
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
							if lootQuantity >= 2 then
								CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, CombatText_StandardScroll, 255, 255, 255)
							else
								CombatText_AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, CombatText_StandardScroll, 255, 255, 255)
							end
						end
					end
				end
			end
			if E.db.ElvUI_EltreumUI.loot.loottext.honor then
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
			if E.db.ElvUI_EltreumUI.loot.loottext.skill then
				if event == 'CHAT_MSG_SKILL' and arg2 == "" then
					E:Delay(0.5, function()
						CombatText_AddMessage(arg1, CombatText_StandardScroll, 255, 255, 255)
					end)
				end
			end
		end)
	end
end
