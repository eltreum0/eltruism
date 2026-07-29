local E = unpack(ElvUI)
local _G = _G
local Deformat = _G.LibStub("LibDeformat-3.0")
local CreateFrame = _G.CreateFrame
local pairs = _G.pairs
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local COMBAT = _G.COMBAT
local CombatText_GetAvailableString = _G.CombatText_GetAvailableString
local COMBAT_TEXT_LOCATIONS = _G.COMBAT_TEXT_LOCATIONS
local COMBAT_TEXT_TO_ANIMATE = _G.COMBAT_TEXT_TO_ANIMATE
local COMBAT_TEXT_SPACING = _G.COMBAT_TEXT_SPACING
local COMBAT_TEXT_MAX_OFFSET = _G.COMBAT_TEXT_MAX_OFFSET
local COMBAT_TEXT_X_ADJUSTMENT = _G.COMBAT_TEXT_X_ADJUSTMENT
local COMBAT_TEXT_STAGGER_RANGE = _G.COMBAT_TEXT_STAGGER_RANGE
local CombatText = _G.CombatText
local WorldFrame = _G.WorldFrame
local LOOT_ITEM_SELF_MULTIPLE = _G.LOOT_ITEM_SELF_MULTIPLE
local tinsert = _G.tinsert
local LOOT_ITEM_PUSHED_SELF_MULTIPLE = _G.LOOT_ITEM_PUSHED_SELF_MULTIPLE
local LOOT_ITEM_SELF = _G.LOOT_ITEM_SELF
local LOOT_ITEM_PUSHED_SELF = _G.LOOT_ITEM_PUSHED_SELF
local LOOT_ITEM_CREATED_SELF_MULTIPLE = _G.LOOT_ITEM_CREATED_SELF_MULTIPLE
local LOOT_ITEM_CREATED_SELF = _G.LOOT_ITEM_CREATED_SELF
local TRADESKILL_LOG_FIRSTPERSON = _G.TRADESKILL_LOG_FIRSTPERSON
local ERR_INV_FULL = _G.ERR_INV_FULL
local INVENTORY_FULL = _G.INVENTORY_FULL
local LOOT_MONEY_SPLIT = _G.LOOT_MONEY_SPLIT
local YOU_LOOT_MONEY = _G.YOU_LOOT_MONEY
local LOOT_CURRENCY_REFUND = _G.LOOT_CURRENCY_REFUND
local LOOT_MONEY_REFUND = _G.LOOT_MONEY_REFUND
local SILVER_AMOUNT = _G.SILVER_AMOUNT
local GOLD_AMOUNT = _G.GOLD_AMOUNT
local COPPER_AMOUNT = _G.COPPER_AMOUNT
local CURRENCY_GAINED_MULTIPLE_BONUS = _G.CURRENCY_GAINED_MULTIPLE_BONUS
local CURRENCY_GAINED_MULTIPLE = _G.CURRENCY_GAINED_MULTIPLE
local CURRENCY_GAINED = _G.CURRENCY_GAINED
local C_CurrencyInfo = _G.C_CurrencyInfo

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

--recreate blizzard combat text (somewhat) to get it working again
local EltruismCombatText = CreateFrame("Frame", "EltruismCombatText", _G.UIParent)
_G.Mixin(EltruismCombatText, CombatTextMixin)
EltruismCombatText:SetScript("OnUpdate", EltruismCombatText.OnUpdate)
_G.hooksecurefunc(EltruismCombatText, "AddMessage", function(self)
	if not self:GetScript("OnUpdate") then
		self:SetScript("OnUpdate", self.OnUpdate)
	end
end)
_G.hooksecurefunc(EltruismCombatText, "ReleaseFontString", function(self)
	if #self.activeFontStrings == 0 then
		self:SetScript("OnUpdate", nil)
	end
end)
EltruismCombatText.fontStringPool = _G.CreateFontStringPool(EltruismCombatText, "ARTWORK", 0, "CombatTextFont")
EltruismCombatText.activeFontStrings = {}
EltruismCombatText.textLocations = {
	startX = 0,
	startY = 400,
	endX = 0,
	endY = 650
}
EltruismCombatText.xDir = 1
EltruismCombatText.textSpacing = 10
EltruismCombatText.textOffsetAdjustment = 130
EltruismCombatText.textOffsetMax = 130

--use elvui general font
_G.hooksecurefunc(EltruismCombatText, "InitializeFontString", function(_, fontString)
	if E.db.ElvUI_EltreumUI.loot.loottext.fontsetting then
		fontString:SetFont(E.media.normFont, E.db.ElvUI_EltreumUI.loot.loottext.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	elseif E.db.ElvUI_EltreumUI.loot.loottext.fontsettingdmg then
		fontString:SetFont(E.private.general.dmgfont, E.db.ElvUI_EltreumUI.loot.loottext.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	elseif E.db.ElvUI_EltreumUI.loot.loottext.fontLSMenable then
		fontString:SetFont(E.LSM:Fetch("font", E.db.ElvUI_EltreumUI.loot.loottext.fontLSM), E.db.ElvUI_EltreumUI.loot.loottext.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	end
	fontString:SetShadowColor(0, 0, 0, 0)
end)

function ElvUI_EltreumUI:LootText()
	EltruismCombatText:SetScale(E.db.ElvUI_EltreumUI.loot.loottext.scale)
	EltruismCombatText:SetFrameStrata(E.db.ElvUI_EltreumUI.loot.loottext.strata)
	--moving the combat text
	local itemLink = nil
	local amount = 0

	--_G.CombatText:AddMessage(message, scrollFunction, r, g, b, displayType, isStaggered)

	combatindicatorframe:SetScript("OnEvent", function(_,event)
		if E.db.ElvUI_EltreumUI.loot.loottext.combatindicator then
			if event == "PLAYER_REGEN_DISABLED" then
				if E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable then
					EltruismCombatText:AddMessage(E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enter, _G.CombatTextUtil.StandardScroll, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor.r, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor.g, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor.b, nil, true)
				else
					EltruismCombatText:AddMessage("|cffFF0000+"..string.upper(COMBAT).."|r", _G.CombatTextUtil.StandardScroll, 1, 0, 0, nil, true)
				end
			end
			if event == "PLAYER_REGEN_ENABLED" then
				if E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable then
					EltruismCombatText:AddMessage(E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leave, _G.CombatTextUtil.StandardScroll, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor.r, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor.g, E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor.b, nil, true)
				else
					EltruismCombatText:AddMessage("|cffFFFFFF-"..string.upper(COMBAT).."|r", _G.CombatTextUtil.StandardScroll, 1, 0, 0, nil, true)
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
				itemLink2,amount2 = Deformat(chatmsg, LOOT_ITEM_CREATED_SELF_MULTIPLE)
			end
			if not itemLink2 then
				itemLink2,amount2 = Deformat(chatmsg, LOOT_ITEM_CREATED_SELF)
			end
			if not itemLink2 then
				itemLink2,amount2 = Deformat(chatmsg, TRADESKILL_LOG_FIRSTPERSON)
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
					EltruismCombatText:AddMessage(INVENTORY_FULL, _G.CombatTextUtil.StandardScroll, 1, 0, 0, nil, true) --apparently it spams for some people
					errorthrottle = true
					E:Delay(3, function() errorthrottle = false end)
				end
			end
			if (event == "CHAT_MSG_LOOT") then
				itemLink, amount = getLoot(arg1)
				if E.db.ElvUI_EltreumUI.loot.loottext.pet then
					if itemLink and itemLink:match("|Hbattlepet:") then
						EltruismCombatText:AddMessage("|T ".. 132599 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..itemLink, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
					end
				end
				if itemLink and not itemLink:match("|Hbattlepet:") then
					local lootName, _, rarity, _, _, _, _, _, _, lootTexture, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
					local lootQuantity = amount
					if not rarity then return end
					local r, g, b, _ = GetItemQualityColor(rarity)
					if rarity >= tonumber(E.db.ElvUI_EltreumUI.loot.loottext.quality) then
						if lootQuantity >= 2 then
							EltruismCombatText:AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, _G.CombatTextUtil.StandardScroll, r, g, b, nil, true)
						else
							EltruismCombatText:AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, _G.CombatTextUtil.StandardScroll, r, g, b, nil, true)
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
							EltruismCombatText:AddMessage("|T ".. 133786 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
						elseif moneystring:match(COPPER_AMOUNT) and not moneystring:match(SILVER_AMOUNT) and not moneystring:match(GOLD_AMOUNT) then
							EltruismCombatText:AddMessage("|T ".. 133788 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
						elseif moneystring:match(GOLD_AMOUNT) then
							EltruismCombatText:AddMessage("|T ".. 133784 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
						else
							EltruismCombatText:AddMessage("|T ".. 133784 ..":18:18:0:0:64:64:5:59:5:59|t|t  "..moneystring, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
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
								EltruismCombatText:AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
							else
								EltruismCombatText:AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
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
							EltruismCombatText:AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootQuantity.." x "..lootName, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
						else
							EltruismCombatText:AddMessage("|T ".. lootTexture ..":18:18:0:0:64:64:5:59:5:59|t|t".."  "..lootName, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
						end
					end
				end
			end
			if E.db.ElvUI_EltreumUI.loot.loottext.skill then
				if event == 'CHAT_MSG_SKILL' and arg2 == "" then
					E:Delay(0.5, function()
						EltruismCombatText:AddMessage(arg1, _G.CombatTextUtil.StandardScroll, 255, 255, 255, nil, true)
					end)
				end
			end
		end)
	end
end
