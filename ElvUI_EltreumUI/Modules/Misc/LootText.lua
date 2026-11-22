--scrolling loot text and combat indicator (originally inspired by Scrolling Loot Text / SLoTe by xavjer)
local E, L = unpack(ElvUI)
local _G = _G

local tonumber = _G.tonumber
local ipairs = _G.ipairs
local type = _G.type
local tIndexOf = _G.tIndexOf
local string = _G.string
local stringfind = string.find
local stringgsub = string.gsub
local stringmatch = string.match
local stringsub = string.sub
local stringupper = string.upper
local table = _G.table
local tinsert = table.insert
local tremove = table.remove
local tconcat = table.concat
local fastrandom = _G.fastrandom

local CreateFrame = _G.CreateFrame
local CreateFontStringPool = _G.CreateFontStringPool
local C_Item = _G.C_Item
local GetItemInfo = C_Item.GetItemInfo
local GetItemQualityColor = C_Item.GetItemQualityColor
local Item = _G.Item
local C_CurrencyInfo = _G.C_CurrencyInfo
local GetCurrencyInfoFromLink = C_CurrencyInfo.GetCurrencyInfoFromLink
local GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local CurrencyConsts = _G.Constants.CurrencyConsts
local UnitFactionGroup = _G.UnitFactionGroup

local COMBAT = _G.COMBAT
local ERR_INV_FULL = _G.ERR_INV_FULL
local INVENTORY_FULL = _G.INVENTORY_FULL
local HONOR = _G.HONOR

local defaultScrollSpeed = 1.9
local defaultFadeOutTime = 1.3
local defaultStaggerRange = 20
local defaultTextLocations = {startX = 0, startY = 0, endX = 0, endY = 160}

local iconGold = 133784
local iconSilver = 133786
local iconCopper = 133788
local iconPet = 132599
local iconHordeHonor = 132485
local iconAllianceHonor = 132486
local iconSuffix = ":18:18:0:0:64:64:5:59:5:59|t  "

local specifierPatterns = {
	s = ".+",
	c = ".",
	d = "%-?%d+",
	i = "%-?%d+",
	u = "%-?%d+",
	f = "%-?%d+%.?%d*",
	g = "%-?%d+%.?%d*"
}

--Create the loottext frame
local LootTextframe = CreateFrame("Frame", "EltruismLoot")
local combatindicatorframe = CreateFrame("Frame")
local errorthrottle = false
local patternsCompiled = false
local lootPatterns, moneyPatterns, currencyPatterns, honorPatterns = {}, {}, {}, {}
local goldPattern, silverPattern, copperPattern
local cachedHonorIcon, cachedHonorName
local skillQueue = {}

--recreate blizzard combat text (somewhat) to get it working again
local EltruismCombatText = CreateFrame("Frame", "EltruismCombatText", _G.UIParent)
EltruismCombatText:SetSize(250, 40)
EltruismCombatText:SetPoint("BOTTOM", _G.UIParent, "BOTTOM", 0, 277)
EltruismCombatText.fontStringPool = CreateFontStringPool(EltruismCombatText, "ARTWORK", 0, "CombatTextFont")
EltruismCombatText.activeFontStrings = {}
EltruismCombatText.textLocations = {
	startX = 0,
	startY = 0,
	endX = 0,
	endY = 160
}
EltruismCombatText.xDir = 1
EltruismCombatText.textSpacing = 10
EltruismCombatText.textOffsetAdjustment = 40
EltruismCombatText.textOffsetMax = 60

local function EltruismScroll(frame, value)
	local scrollSpeed = _G.CombatTextConstants and _G.CombatTextConstants.MessageScrollSpeed or defaultScrollSpeed
	local textLocations = frame.textLocations or defaultTextLocations
	local xPos = value.startX + (((textLocations.endX or 0) - (textLocations.startX or 0)) * value.scrollTime / scrollSpeed)
	local yPos = value.startY + (((value.endY or 160) - (textLocations.startY or 0)) * value.scrollTime / scrollSpeed)
	return xPos, yPos
end
EltruismCombatText.StandardScroll = EltruismScroll

--CombatTextMixin:EnumerateActiveFontStrings()
function EltruismCombatText:EnumerateActiveFontStrings()
	return ipairs(self.activeFontStrings)
end

--CombatTextMixin:ReleaseFontString(fontString)
function EltruismCombatText:ReleaseFontString(fontString)
	local index = tIndexOf(self.activeFontStrings, fontString)
	if index then
		self.fontStringPool:Release(fontString)
		tremove(self.activeFontStrings, index)
	end
	if #self.activeFontStrings == 0 then
		self:SetScript("OnUpdate", nil)
	end
end

--CombatTextMixin:AcquireFontString() but with my font options
function EltruismCombatText:InitializeFontString(fontString)
	fontString:SetFontObject(_G.CombatTextFont)
	fontString:SetAlpha(0)
	fontString:ClearAllPoints()
	fontString:SetPoint("CENTER", self, "CENTER", self.textLocations.startX or 0, self.textLocations.startY or 0)

	local lootdb = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.loot and E.db.ElvUI_EltreumUI.loot.loottext
	if lootdb then
		if lootdb.fontsetting then
			fontString:SetFont(E.media.normFont, lootdb.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		elseif lootdb.fontsettingdmg then
			fontString:SetFont(E.private.general.dmgfont, lootdb.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		elseif lootdb.fontLSMenable then
			fontString:SetFont(E.LSM:Fetch("font", lootdb.fontLSM), lootdb.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
		end
	end
	fontString:SetShadowColor(0, 0, 0, 0)
end

--CombatTextMixin:AcquireFontString()
function EltruismCombatText:AcquireFontString()
	local fontString = self.fontStringPool:Acquire()
	if fontString then
		self:InitializeFontString(fontString)
		return fontString
	end
end

--CombatTextMixin:ClearAnimationList()
function EltruismCombatText:ClearAnimationList()
	for _, fontString in self:EnumerateActiveFontStrings() do
		fontString:SetAlpha(0)
		fontString:Hide()
		fontString:ClearAllPoints()
		fontString:SetPoint("CENTER", self, "CENTER", self.textLocations.startX or 0, self.textLocations.startY or 0)
	end
end

--CombatTextMixin:UpdateDisplayedMessages
function EltruismCombatText:UpdateDisplayedMessages()
	-- do nothing so blizzard doesnt change stuff
end

--CombatTextMixin:OnUpdate
function EltruismCombatText:OnUpdate(elapsed)
	local constants = _G.CombatTextConstants
	local scrollSpeed = constants and constants.MessageScrollSpeed or defaultScrollSpeed
	local fadeOutTime = constants and constants.MessageFadeOutTime or defaultFadeOutTime
	local fadeDuration = scrollSpeed - fadeOutTime
	local active = self.activeFontStrings

	--iterate backwards so removing items doesnt skip anything
	for i = #active, 1, -1 do
		local fontString = active[i]
		local scrollTime = fontString.scrollTime + elapsed
		if scrollTime >= scrollSpeed then
			tremove(active, i)
			self.fontStringPool:Release(fontString)
		else
			fontString.scrollTime = scrollTime
			local xPos, yPos = (fontString.scrollFunction or EltruismScroll)(self, fontString)
			fontString.yPos = yPos
			fontString:SetPoint("CENTER", self, "CENTER", xPos, yPos)

			if scrollTime >= fadeOutTime and fadeDuration > 0 then
				local alpha = 1 - ((scrollTime - fadeOutTime) / fadeDuration)
				fontString:SetAlpha(alpha > 0 and alpha or 0)
			end
		end
	end

	if #active == 0 then
		self:SetScript("OnUpdate", nil)
	end
end

--Blizzard_CombatText, but with custom stuff
function EltruismCombatText:AddMessage(message, scrollFunction, r, g, b, _, isStaggered)
	local fontString = self:AcquireFontString()
	if not fontString then return end

	fontString:SetText(message)
	fontString:SetTextColor(r or 1, g or 1, b or 1)
	fontString.scrollTime = 0
	if scrollFunction and scrollFunction ~= EltruismScroll and (not _G.CombatTextUtil or scrollFunction ~= _G.CombatTextUtil.StandardScroll) then
		fontString.scrollFunction = scrollFunction
	else
		fontString.scrollFunction = EltruismScroll
	end

	local startY = self.textLocations.startY or 0
	local lowestMessage = startY
	local active = self.activeFontStrings
	for i = 1, #active do
		local value = active[i]
		if value ~= fontString and value.yPos and (lowestMessage >= value.yPos - 16 - self.textSpacing) then
			lowestMessage = value.yPos - 16 - self.textSpacing
		end
	end

	local useXadjustment = 0
	if lowestMessage < (startY - self.textOffsetMax) then
		self.textOffsetAdjustment = self.textOffsetAdjustment * -1
		useXadjustment = 1
		lowestMessage = startY - self.textOffsetMax
	end

	fontString.endY = self.textLocations.endY or 160

	-- Stagger the text if flagged
	local staggerRange = _G.CombatTextConstants and _G.CombatTextConstants.StaggerRange or defaultStaggerRange
	local staggerAmount = 0
	if isStaggered then
		staggerAmount = fastrandom(0, staggerRange) - staggerRange / 2
	end

	-- Alternate x direction
	self.xDir = (self.xDir or 1) * -1
	if useXadjustment == 1 then
		self.xDir = (self.textOffsetAdjustment > 0) and -1 or 1
	end
	fontString.xDir = self.xDir
	fontString.startX = (self.textLocations.startX or 0) + staggerAmount + (useXadjustment * self.textOffsetAdjustment)
	fontString.startY = lowestMessage
	fontString.yPos = lowestMessage
	fontString:ClearAllPoints()
	fontString:SetPoint("CENTER", self, "CENTER", fontString.startX, lowestMessage)
	fontString:SetAlpha(1)
	fontString:Show()
	tinsert(active, fontString)

	if not self:GetScript("OnUpdate") then
		self:SetScript("OnUpdate", self.OnUpdate)
	end
end

local function isSafeString(val)
	if not E:NotSecretValue(val) then return false end
	return type(val) == "string"
end

local function escapeLuaPattern(text)
	return stringgsub(text, "([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
end

--compile blizzard format string into a lua pattern with capture positions
local function compileFormatPattern(template, anchored)
	if type(template) ~= "string" or template == "" then return nil end

	local out = anchored and {"^"} or {}
	local argToCapture = anchored and {} or nil
	local capIndex = 0
	local implicitArg = 0
	local pos = 1
	local len = #template

	while pos <= len do
		local nextPct = stringfind(template, "%", pos, true)
		local nextPlural = stringfind(template, "|4", pos, true)

		if nextPlural and (not nextPct or nextPlural < nextPct) then
			if nextPlural > pos then
				out[#out + 1] = escapeLuaPattern(stringsub(template, pos, nextPlural - 1))
			end
			local semiPos = stringfind(template, ";", nextPlural + 2, true)
			if semiPos then
				out[#out + 1] = ".-"
				pos = semiPos + 1
			else
				out[#out + 1] = escapeLuaPattern("|4")
				pos = nextPlural + 2
			end
		elseif nextPct then
			if nextPct > pos then
				out[#out + 1] = escapeLuaPattern(stringsub(template, pos, nextPct - 1))
			end

			if stringsub(template, nextPct, nextPct + 1) == "%%" then
				out[#out + 1] = "%%"
				pos = nextPct + 2
			else
				--check positional form like %2$s before width modifiers like %2d
				local _, matchEnd, posArg, spec = stringfind(template, "^%%(%d+)%$[%-%+%s#0]*%d*%.?%d*([sdiufgc])", nextPct)
				if not spec then
					_, matchEnd, spec = stringfind(template, "^%%[%-%+%s#0]*%d*%.?%d*([sdiufgc])", nextPct)
					posArg = nil
				end

				local specPat = spec and specifierPatterns[spec]
				if specPat then
					if anchored then
						capIndex = capIndex + 1
						local argIndex
						if posArg then
							argIndex = tonumber(posArg)
						else
							implicitArg = implicitArg + 1
							argIndex = implicitArg
						end
						argToCapture[argIndex] = capIndex
						out[#out + 1] = "("..specPat..")"
					else
						out[#out + 1] = specPat
					end
					pos = matchEnd + 1
				else
					out[#out + 1] = "%%"
					pos = nextPct + 1
				end
			end
		else
			out[#out + 1] = escapeLuaPattern(stringsub(template, pos, len))
			break
		end
	end

	if anchored then
		if capIndex == 0 then return nil end
		out[#out + 1] = "$"
	end

	return tconcat(out), argToCapture
end

local function addPattern(list, globalName, firstArg, secondArg)
	local pat, argMap = compileFormatPattern(_G[globalName], true)
	if pat and argMap[firstArg] then
		tinsert(list, {
			pattern = pat,
			firstSlot = argMap[firstArg],
			secondSlot = secondArg and argMap[secondArg] or nil
		})
	end
end

local function pickCapture(slot, c1, c2, c3, c4)
	if slot == 1 then
		return c1
	elseif slot == 2 then
		return c2
	elseif slot == 3 then
		return c3
	elseif slot == 4 then
		return c4
	end
end

local function ensurePatternsCompiled()
	if patternsCompiled then return end
	patternsCompiled = true

	--multiple item patterns need to run before single item ones so (.+) doesnt eat x%d
	addPattern(lootPatterns, "LOOT_ITEM_SELF_MULTIPLE", 1, 2)
	addPattern(lootPatterns, "LOOT_ITEM_PUSHED_SELF_MULTIPLE", 1, 2)
	addPattern(lootPatterns, "LOOT_ITEM_CREATED_SELF_MULTIPLE", 1, 2)
	addPattern(lootPatterns, "LOOT_ITEM_SELF", 1)
	addPattern(lootPatterns, "LOOT_ITEM_PUSHED_SELF", 1)
	addPattern(lootPatterns, "LOOT_ITEM_CREATED_SELF", 1)
	addPattern(lootPatterns, "TRADESKILL_LOG_FIRSTPERSON", 1, 2)

	addPattern(moneyPatterns, "LOOT_MONEY_SPLIT", 1)
	addPattern(moneyPatterns, "YOU_LOOT_MONEY", 1)
	addPattern(moneyPatterns, "LOOT_CURRENCY_REFUND", 1)
	addPattern(moneyPatterns, "LOOT_MONEY_REFUND", 1)

	goldPattern = compileFormatPattern(_G.GOLD_AMOUNT, false)
	silverPattern = compileFormatPattern(_G.SILVER_AMOUNT, false)
	copperPattern = compileFormatPattern(_G.COPPER_AMOUNT, false)

	addPattern(currencyPatterns, "CURRENCY_GAINED_MULTIPLE_BONUS", 1, 2)
	addPattern(currencyPatterns, "CURRENCY_GAINED_MULTIPLE", 1, 2)
	addPattern(currencyPatterns, "CURRENCY_GAINED", 1)

	addPattern(honorPatterns, "COMBATLOG_HONORAWARD", 1)
	addPattern(honorPatterns, "COMBATLOG_HONORGAIN", 3)
	addPattern(honorPatterns, "COMBATLOG_HONORGAIN_NO_RANK", 2)
end

local function formatIconMessage(icon, label, count)
	if count and count >= 2 then
		return "|T"..icon..iconSuffix..count.." x "..label
	end
	return "|T"..icon..iconSuffix..label
end

local function displayLootItem(itemName, rarity, itemTexture, count, db)
	if not db then return end
	local minQuality = tonumber(db.quality) or 0
	if rarity >= minQuality then
		local r, g, b = GetItemQualityColor(rarity)
		EltruismCombatText:AddMessage(formatIconMessage(itemTexture, itemName, count), EltruismScroll, r, g, b, nil, true)
	end
end

local function handleLootMessage(msg, db)
	if not stringfind(msg, "|H", 1, true) then return end

	local itemLink
	local count = 1
	for i = 1, #lootPatterns do
		local entry = lootPatterns[i]
		local c1, c2, c3, c4 = stringmatch(msg, entry.pattern)
		if c1 then
			itemLink = pickCapture(entry.firstSlot, c1, c2, c3, c4)
			if entry.secondSlot then
				count = tonumber(pickCapture(entry.secondSlot, c1, c2, c3, c4)) or 1
			end
			break
		end
	end
	if not itemLink then return end

	if stringfind(itemLink, "|Hbattlepet:", 1, true) then
		if db.pet then
			EltruismCombatText:AddMessage(formatIconMessage(iconPet, itemLink, 1), EltruismScroll, 1, 1, 1, nil, true)
		end
		return
	end

	local itemName, _, rarity, _, _, _, _, _, _, itemTexture = GetItemInfo(itemLink)
	if itemName and rarity and itemTexture then
		displayLootItem(itemName, rarity, itemTexture, count, db)
	else
		local item = Item:CreateFromItemLink(itemLink)
		if item and not item:IsItemEmpty() then
			item:ContinueOnItemLoad(function()
				local loadedName, _, loadedRarity, _, _, _, _, _, _, loadedTexture = GetItemInfo(itemLink)
				if loadedName and loadedRarity and loadedTexture then
					displayLootItem(loadedName, loadedRarity, loadedTexture, count, db)
				end
			end)
		end
	end
end

local function handleMoneyMessage(msg)
	local moneyText
	for i = 1, #moneyPatterns do
		local entry = moneyPatterns[i]
		local c1, c2, c3, c4 = stringmatch(msg, entry.pattern)
		if c1 then
			moneyText = pickCapture(entry.firstSlot, c1, c2, c3, c4)
			break
		end
	end
	if not moneyText then return end

	local coinIcon
	if goldPattern and stringfind(moneyText, goldPattern) then
		coinIcon = iconGold
	elseif silverPattern and stringfind(moneyText, silverPattern) then
		coinIcon = iconSilver
	elseif copperPattern and stringfind(moneyText, copperPattern) then
		coinIcon = iconCopper
	else
		coinIcon = iconGold
	end
	EltruismCombatText:AddMessage(formatIconMessage(coinIcon, moneyText, 1), EltruismScroll, 1, 1, 1, nil, true)
end

local function handleCurrencyMessage(msg)
	if not stringfind(msg, "|H", 1, true) then return end

	local currencyLink
	local count = 1
	for i = 1, #currencyPatterns do
		local entry = currencyPatterns[i]
		local c1, c2, c3, c4 = stringmatch(msg, entry.pattern)
		if c1 then
			currencyLink = pickCapture(entry.firstSlot, c1, c2, c3, c4)
			if entry.secondSlot then
				count = tonumber(pickCapture(entry.secondSlot, c1, c2, c3, c4)) or 1
			end
			break
		end
	end
	if not currencyLink then return end

	local info = GetCurrencyInfoFromLink(currencyLink)
	if info and info.iconFileID and info.name then
		EltruismCombatText:AddMessage(formatIconMessage(info.iconFileID, info.name, count), EltruismScroll, 1, 1, 1, nil, true)
	end
end

local function getHonorDisplayInfo()
	if cachedHonorIcon and cachedHonorName then
		return cachedHonorIcon, cachedHonorName
	end

	local honorCurrencyID = E.Modern and CurrencyConsts.HONOR_CURRENCY_ID or CurrencyConsts.CLASSIC_HONOR_CURRENCY_ID
	local info = GetCurrencyInfo(honorCurrencyID)
	if info and info.iconFileID and info.name then
		cachedHonorIcon = info.iconFileID
		cachedHonorName = info.name
		return cachedHonorIcon, cachedHonorName
	end

	local faction = UnitFactionGroup("player")
	cachedHonorIcon = (faction == "Horde") and iconHordeHonor or iconAllianceHonor
	cachedHonorName = HONOR
	return cachedHonorIcon, cachedHonorName
end

local function handleHonorMessage(msg)
	for i = 1, #honorPatterns do
		local entry = honorPatterns[i]
		local c1, c2, c3, c4 = stringmatch(msg, entry.pattern)
		if c1 then
			local amount = tonumber(pickCapture(entry.firstSlot, c1, c2, c3, c4))
			if amount and amount > 0 then
				local icon, name = getHonorDisplayInfo()
				EltruismCombatText:AddMessage(formatIconMessage(icon, name, amount), EltruismScroll, 1, 1, 1, nil, true)
			end
			return
		end
	end

	if stringfind(msg, "|Hcurrency:", 1, true) then
		handleCurrencyMessage(msg)
	end
end

local function printSkillMsg()
	if #skillQueue > 0 then
		local msg = tremove(skillQueue, 1)
		EltruismCombatText:AddMessage(msg, EltruismScroll, 1, 1, 1, nil, true)
	end
end

local function handleSkillMessage(msg)
	skillQueue[#skillQueue + 1] = msg
	E:Delay(0.5, printSkillMsg)
end

local function resetErrorThrottle()
	errorthrottle = false
end

local function handleErrorMessage(msg)
	if msg == ERR_INV_FULL and not errorthrottle then
		EltruismCombatText:AddMessage(INVENTORY_FULL, EltruismScroll, 1, 0, 0, nil, true) --apparently it spams for some people
		errorthrottle = true
		E:Delay(3, resetErrorThrottle)
	end
end

local function onLootEvent(_, event, arg1, arg2)
	local db = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.loot and E.db.ElvUI_EltreumUI.loot.loottext
	if not db or not db.enable then return end

	if event == "CHAT_MSG_LOOT" then
		if isSafeString(arg1) then
			handleLootMessage(arg1, db)
		end
	elseif event == "CHAT_MSG_MONEY" then
		if db.currency and isSafeString(arg1) then
			handleMoneyMessage(arg1)
		end
	elseif event == "CHAT_MSG_CURRENCY" then
		if db.currency and isSafeString(arg1) then
			handleCurrencyMessage(arg1)
		end
	elseif event == "CHAT_MSG_COMBAT_HONOR_GAIN" then
		if db.honor and isSafeString(arg1) then
			handleHonorMessage(arg1)
		end
	elseif event == "CHAT_MSG_SKILL" then
		if db.skill and type(arg1) == "string" then
			handleSkillMessage(arg1)
		end
	elseif event == "UI_ERROR_MESSAGE" then
		if isSafeString(arg2) then
			handleErrorMessage(arg2)
		end
	end
end

local function onCombatIndicatorEvent(_, event)
	local db = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.loot and E.db.ElvUI_EltreumUI.loot.loottext
	if not db or not db.combatindicator then return end

	local custom = db.combatindicatorcustom
	if event == "PLAYER_REGEN_DISABLED" then
		if custom and custom.enable then
			EltruismCombatText:AddMessage(custom.enter, EltruismScroll, custom.entercolor.r, custom.entercolor.g, custom.entercolor.b, nil, true)
		else
			EltruismCombatText:AddMessage("|cffFF0000+"..stringupper(COMBAT).."|r", EltruismScroll, 1, 0, 0, nil, true)
		end
	elseif event == "PLAYER_REGEN_ENABLED" then
		if custom and custom.enable then
			EltruismCombatText:AddMessage(custom.leave, EltruismScroll, custom.leavecolor.r, custom.leavecolor.g, custom.leavecolor.b, nil, true)
		else
			EltruismCombatText:AddMessage("|cffFFFFFF-"..stringupper(COMBAT).."|r", EltruismScroll, 1, 1, 1, nil, true)
		end
	end
end

function ElvUI_EltreumUI:UpdateLootText()
	if not EltruismCombatText then return end
	local db = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.loot and E.db.ElvUI_EltreumUI.loot.loottext
	EltruismCombatText:SetScale(db and db.scale or 0.65)
	EltruismCombatText:SetFrameStrata(db and db.strata or "BACKGROUND")
end

function ElvUI_EltreumUI:LootText()
	--moving the combat text
	if not EltruismCombatText.IsInitialized then
		E:CreateMover(EltruismCombatText, "MoverEltruismLootText", L["LootText"] or "LootText", nil, nil, nil, "ALL,SOLO,ELTREUMUI", nil, 'ElvUI_EltreumUI,loot,loottext')
		EltruismCombatText.IsInitialized = true
	end

	ElvUI_EltreumUI:UpdateLootText()

	local db = E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.loot and E.db.ElvUI_EltreumUI.loot.loottext
	if db and db.combatindicator then
		combatindicatorframe:RegisterEvent("PLAYER_REGEN_ENABLED")
		combatindicatorframe:RegisterEvent("PLAYER_REGEN_DISABLED")
		combatindicatorframe:SetScript("OnEvent", onCombatIndicatorEvent)
	else
		combatindicatorframe:UnregisterAllEvents()
		combatindicatorframe:SetScript("OnEvent", nil)
	end

	if db and db.enable then
		ensurePatternsCompiled()
		LootTextframe:RegisterEvent("UI_ERROR_MESSAGE")
		LootTextframe:RegisterEvent("CHAT_MSG_LOOT")
		LootTextframe:RegisterEvent("CHAT_MSG_MONEY")
		LootTextframe:RegisterEvent("CHAT_MSG_CURRENCY")
		LootTextframe:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
		LootTextframe:RegisterEvent("CHAT_MSG_SKILL") --profession level up
		LootTextframe:SetScript("OnEvent", onLootEvent)
	else
		LootTextframe:UnregisterAllEvents()
		LootTextframe:SetScript("OnEvent", nil)
	end
end
