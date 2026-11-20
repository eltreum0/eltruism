local E, L = unpack(ElvUI)
local AB = E:GetModule('ActionBars', true)
local _G = _G

--Fixes Blizzard's Press and Hold Casting (ActionButtonUseKeyHeldSpell) on ElvUI action bars by routing keybinds to Blizzard's native ActionButton commands
--Based on HoldToCastFix by JulianNorton (https://github.com/JulianNorton/HoldToCastFix) and ElvUI-HoldToCastFix by danielbehrens (https://github.com/danielbehrens/ElvUI-HoldToCastFix) - thank you both and the contributors!
--HoldToCastFix portions licensed under the MIT License (see ElvUI_EltreumUI/Licenses/HoldToCastFix License.txt)

local CreateFrame, InCombatLockdown, hooksecurefunc = _G.CreateFrame, _G.InCombatLockdown, _G.hooksecurefunc
local RegisterStateDriver, UnregisterStateDriver = _G.RegisterStateDriver, _G.UnregisterStateDriver
local GetBindingKey, GetBindingAction = _G.GetBindingKey, _G.GetBindingAction
local SetOverrideBinding, SetOverrideBindingMacro, ClearOverrideBindings = _G.SetOverrideBinding, _G.SetOverrideBindingMacro, _G.ClearOverrideBindings
local GetActionInfo, GetMacroInfo, GetNumMacros = _G.GetActionInfo, _G.GetMacroInfo, _G.GetNumMacros
local GetCursorInfo, ClearCursor, PlaceAction = _G.GetCursorInfo, _G.ClearCursor, _G.PlaceAction
local PickupMacro = _G.PickupMacro
local C_Spell = _G.C_Spell
local PickupSpell = C_Spell.PickupSpell
local GetSpellName = C_Spell.GetSpellName
local GetSpellSubtext = C_Spell.GetSpellSubtext
local C_SpellBook = _G.C_SpellBook
local IsSpellKnown = C_SpellBook.IsSpellKnown
local GetNumSkillLines = C_SpellBook.GetNumSpellBookSkillLines
local GetSkillLineInfo = C_SpellBook.GetSpellBookSkillLineInfo
local GetSpellBookItemInfo = C_SpellBook.GetSpellBookItemInfo
local GetBuildInfo, C_Timer = _G.GetBuildInfo, _G.C_Timer
local IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded
local playerBank = _G.Enum.SpellBookSpellBank.Player
local spellItemType = _G.Enum.SpellBookItemType.Spell
local maxAccountMacros = _G.Constants.MacroConsts.MAX_ACCOUNT_MACROS
local C_ActionBar = _G.C_ActionBar
local GetActionText = C_ActionBar.GetActionText
local GetTempShapeshiftBarIndex = C_ActionBar.GetTempShapeshiftBarIndex
local ActionBarController = _G.ActionBarController
local IsHouseEditorActive = _G.C_HouseEditor.IsHouseEditorActive
local IsInsidePlot = _G.C_Housing.IsInsidePlot
local C_CVar = _G.C_CVar
local GetCVar = C_CVar.GetCVar
local SetCVar = C_CVar.SetCVar

local pairs, ipairs, next, select = _G.pairs, _G.ipairs, _G.next, _G.select
local tonumber, tostring, print, pcall, wipe = _G.tonumber, _G.tostring, _G.print, _G.pcall, _G.wipe
local bor, mathabs, format, tconcat = _G.bit.bor, _G.math.abs, _G.format, _G.table.concat
local strtrim = _G.strtrim

local supportedBars = { 1, 3, 4, 5, 6, 13, 14, 15 }
local BAR_INFO = {
	[1]  = { key = "bar1",  bind = "ACTIONBUTTON",          offset = 1,   blizz = "ActionButton1" },
	[3]  = { key = "bar3",  bind = "MULTIACTIONBAR3BUTTON", offset = 25,  blizz = "MultiBarRightButton1" },
	[4]  = { key = "bar4",  bind = "MULTIACTIONBAR4BUTTON", offset = 37,  blizz = "MultiBarLeftButton1" },
	[5]  = { key = "bar5",  bind = "MULTIACTIONBAR2BUTTON", offset = 49,  blizz = "MultiBarBottomRightButton1" },
	[6]  = { key = "bar6",  bind = "MULTIACTIONBAR1BUTTON", offset = 61,  blizz = "MultiBarBottomLeftButton1" },
	[13] = { key = "bar13", bind = "MULTIACTIONBAR5BUTTON", offset = 145, blizz = "MultiBar5Button1", alt = "ELVUIBAR13BUTTON" },
	[14] = { key = "bar14", bind = "MULTIACTIONBAR6BUTTON", offset = 157, blizz = "MultiBar6Button1", alt = "ELVUIBAR14BUTTON" },
	[15] = { key = "bar15", bind = "MULTIACTIONBAR7BUTTON", offset = 169, blizz = "MultiBar7Button1", alt = "ELVUIBAR15BUTTON" },
}
local barKeyToNum = {}
for barNum, info in pairs(BAR_INFO) do
	barKeyToNum[info.key] = barNum
end
local multiBarToElvUIBar = {
	MultiBarRight = 3, MultiBarLeft = 4, MultiBarBottomRight = 5, MultiBarBottomLeft = 6,
	MultiBar5 = 13, MultiBar6 = 14, MultiBar7 = 15,
}
local macroEvents = { "LEARNED_SPELL_IN_SKILL_LINE", "SPELLS_CHANGED", "ACTIONBAR_SLOT_CHANGED", "UPDATE_MACROS" }

--3-bit modifier masks: 1=ALT, 2=CTRL, 4=SHIFT
local modBits = { alt = 1, ctrl = 2, shift = 4 }
local maskToMod = { "ALT", "CTRL", "ALT-CTRL", "SHIFT", "ALT-SHIFT", "CTRL-SHIFT", "ALT-CTRL-SHIFT" }
local maskToPrefix = { "ALT-", "CTRL-", "ALT-CTRL-", "SHIFT-", "ALT-SHIFT-", "CTRL-SHIFT-", "ALT-CTRL-SHIFT-" }
local modSpecToBit = {
	ALT = 1, CTRL = 2, ["ALT-CTRL"] = 3, SHIFT = 4,
	["ALT-SHIFT"] = 5, ["CTRL-SHIFT"] = 6, ["ALT-CTRL-SHIFT"] = 7,
}

--Frames are created lazily on first enable, reusable caches avoid allocations in hot paths
local bindingFrameOthers, eventFrame
local pagedBars, barSnap = {}, {}
local barBoundMap, activeBarMap, actionButtonOwnerBars, barButtons = {}, {}, {}, {}
local boundKeys, spellCache, macroByName, activeBarsTmp, modCombos, modNextCombos = {}, {}, {}, {}, {}, {}
local diagState = {}

local initialized, hooked, isApplying, isSyncing = false, false, false, false
local pendingUpdate, pendingSlotSync, pendingDisable, macroEventsRegistered = false, false, false, false
local bindingsActive, othersBound, housingMode, spellbookDeferred = false, false, false, false
local spellbookRetries = 0
local zoneTimer, slotSyncTimer, spellbookRetryTimer, configSyncTimer

local ApplyBindings, SyncMacrosAndRanks

local BONUS_STATE_CONDITIONS = "[bonusbar:1] 7; [bonusbar:2] 8; [bonusbar:3] 9; [bonusbar:4] 10; [bonusbar:5] 11; [shapeshift] 12; [bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6; 1"

local SECURE_UPDATE = [[
	local isBar1, newstate, bf = self:GetAttribute("htc-isbar1"), self:GetAttribute("state-htcpage"), self:GetFrameRef("bindingFrame")
	local curMode, targetMode, mismatch = self:GetAttribute("htc-mode") or "home", "cleared", false

	if not isBar1 and newstate == "home" then
		targetMode = "home"
	else
		local page = tonumber(newstate)
		if page and page > 0 then
			local enginePage
			if HasBonusActionBar() then
				enginePage = GetBonusBarIndex()
			elseif HasTempShapeshiftActionBar() then
				enginePage = GetTempShapeshiftBarIndex()
			else
				enginePage = GetActionBarPage()
			end
			if enginePage == page then
				targetMode = isBar1 and "home" or "paged-ab"
			else
				mismatch = true
			end
		end
	end

	self:SetAttribute("htc-mismatch", mismatch)

	if bf and targetMode ~= curMode then
		bf:ClearBindings()
		local count = tonumber(self:GetAttribute("htc-bind-count")) or 0
		if targetMode == "home" then
			for i = 1, count do
				local key, macro, cmd = self:GetAttribute("htc-key-" .. i), self:GetAttribute("htc-macro-" .. i), self:GetAttribute("htc-cmd-" .. i)
				if key then
					if macro then
						bf:SetBindingMacro(true, key, macro)
					elseif cmd then
						bf:SetBinding(true, key, cmd)
					end
				end
			end
		elseif targetMode == "paged-ab" then
			for i = 1, count do
				local key, abcmd = self:GetAttribute("htc-key-" .. i), self:GetAttribute("htc-abcmd-" .. i)
				if key and abcmd then bf:SetBinding(true, key, abcmd) end
			end
		end
		self:SetAttribute("htc-mode", targetMode)
	end

	self:CallMethod("OnSecureStateChanged")
]]

local function DebugPrint(msg)
	if E.db.ElvUI_EltreumUI.dev then
		ElvUI_EltreumUI:Print("[HoldToCast] " .. tostring(msg))
	end
end

local function GetDB()
	return E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.otherstuff and E.db.ElvUI_EltreumUI.otherstuff.holdtocast
end

local function GetMacroSlotTable()
	if not E.private.ElvUI_EltreumUI.holdtocastMacroSlots then
		E.private.ElvUI_EltreumUI.holdtocastMacroSlots = {}
	end
	return E.private.ElvUI_EltreumUI.holdtocastMacroSlots
end

local function IsStandaloneHoldToCastLoaded()
	return IsAddOnLoaded("HoldToCastFix") or IsAddOnLoaded("ElvUI_HoldToCastFix") or IsAddOnLoaded("ElvUI-HoldToCastFix")
end

local function IsBarEnabled(barNum, db)
	local info = BAR_INFO[barNum]
	if not info or not db or not db.enable or not db.bars or not db.bars[barNum] then
		return false
	end
	if info.blizz and not _G[info.blizz] then
		return false
	end
	local barDB = E.db.actionbar and E.db.actionbar[info.key]
	return not barDB or barDB.enabled ~= false
end

local function GetBarButtonCount(barNum)
	local info = BAR_INFO[barNum]
	local barDB = info and E.db.actionbar and E.db.actionbar[info.key]
	local count = barDB and barDB.buttons
	if count == nil then return 12 end
	return (count < 0 and 0) or (count > 12 and 12) or count
end

local function GetBarClassPaging(barNum)
	local info = BAR_INFO[barNum]
	local barDB = info and E.db.actionbar and E.db.actionbar[info.key]
	local p = barDB and barDB.paging and barDB.paging[E.myclass]
	p = p and p ~= "" and strtrim(p:gsub("[\n\r]", "")) or nil
	return p ~= "" and p or nil
end

local function OnSecureStateChanged(self)
	local barNum = self.eltruismBarNum
	local pb = pagedBars[barNum]
	if not pb then return end

	local rawState = self:GetAttribute("state-htcpage")
	local mode = self:GetAttribute("htc-mode") or "cleared"
	pb.mode = mode
	pb.page = (rawState == "home") and 0 or mathabs(tonumber(rawState) or 0)
	if barBoundMap[barNum] and ((barNum == 1 and mode == "home") or (barNum ~= 1 and mode == "paged-ab")) then
		actionButtonOwnerBars[barNum] = true
	else
		actionButtonOwnerBars[barNum] = nil
	end

	local anyActive = othersBound
	if not anyActive then
		for b, isBound in pairs(barBoundMap) do
			local bpb = isBound and pagedBars[b]
			if bpb and (bpb.mode == "home" or bpb.mode == "paged-ab") then
				anyActive = true
				break
			end
		end
	end
	bindingsActive = anyActive

	DebugPrint("StateChanged bar" .. tostring(barNum) .. ": state=" .. tostring(rawState) .. " mode=" .. tostring(mode) .. " active=" .. tostring(bindingsActive))
end

local function EnsurePagedBarFrames(barNum)
	local pb = pagedBars[barNum]
	if pb then return pb end
	local bf = CreateFrame("Frame", "EltruismHoldToCastBindingBar" .. barNum, E.UIParent, "SecureFrameTemplate")
	local sf = CreateFrame("Frame", "EltruismHoldToCastStateDriverBar" .. barNum, E.UIParent, "SecureHandlerStateTemplate")
	sf.eltruismBarNum = barNum
	sf:SetFrameRef("bindingFrame", bf)
	sf:SetAttribute("htc-isbar1", barNum == 1)
	sf:SetAttribute("htc-update", SECURE_UPDATE)
	sf:SetAttribute("_onstate-htcpage", "self:RunAttribute('htc-update')")
	sf:SetAttribute("_onstate-htcbonus", "self:RunAttribute('htc-update')")
	sf.OnSecureStateChanged = OnSecureStateChanged
	pb = { bf = bf, sf = sf, active = false, count = 0, lastCount = 0, mode = "cleared", page = 0 }
	pagedBars[barNum] = pb
	return pb
end

--Negates modifier-only paging conditions so the secure handler pauses overrides for modifier pages
local function NegateModifierPages(paging)
	return paging:gsub("(%[([^%]]-)%])%s*(%d+)", function(bracket, inner, pageStr)
		local lower = inner:lower()
		local hasMod = false
		for token in lower:gmatch("[^,]+") do
			token = strtrim(token)
			if token == "mod" or token == "modifier" or token:find("^mod:") or token:find("^modifier:") then
				hasMod = true
				break
			end
		end
		if hasMod and not lower:find("bonusbar", 1, true) and not lower:find("bar:", 1, true)
			and not lower:find("shapeshift", 1, true) and not lower:find("overridebar", 1, true)
			and not lower:find("vehicleui", 1, true) and not lower:find("possessbar", 1, true) then
			return bracket .. " -" .. pageStr
		end
	end)
end

local function GetBarPagingConditions(barNum, classPaging)
	wipe(activeBarsTmp)
	activeBarsTmp[1] = "[overridebar] 0; [vehicleui] 0; [possessbar] 0; [petbattle] 0;"
	if classPaging then
		local negated = NegateModifierPages(classPaging)
		activeBarsTmp[#activeBarsTmp + 1] = negated:find(";%s*$") and negated or (negated .. ";")
	end
	if barNum == 1 then
		activeBarsTmp[#activeBarsTmp + 1] = classPaging and format("[shapeshift] %d;", GetTempShapeshiftBarIndex()) or "[shapeshift] 0;"
		activeBarsTmp[#activeBarsTmp + 1] = "[bar:2] 2; [bar:3] 3; [bar:4] 4; [bar:5] 5; [bar:6] 6;"
		activeBarsTmp[#activeBarsTmp + 1] = "[bonusbar:1] 0; [bonusbar:2] 0; [bonusbar:3] 0; [bonusbar:4] 0; [bonusbar:5] 0; 1"
	else
		activeBarsTmp[#activeBarsTmp + 1] = "home"
	end
	local conditions = tconcat(activeBarsTmp, " ")
	DebugPrint("PagingConditions bar" .. barNum .. ": " .. conditions)
	return conditions
end

--Combines a macro modifier spec with an existing WoW keybind in canonical ALT-CTRL-SHIFT-KEY order
local function BuildModifiedKey(modSpec, baseKey)
	local addBit = modSpec and modSpecToBit[modSpec]
	if not addBit or not baseKey or baseKey == "" then return nil end

	local baseMask, key = 0, baseKey
	while true do
		if key:sub(1, 4) == "ALT-" then
			baseMask, key = bor(baseMask, 1), key:sub(5)
		elseif key:sub(1, 5) == "CTRL-" then
			baseMask, key = bor(baseMask, 2), key:sub(6)
		elseif key:sub(1, 6) == "SHIFT-" then
			baseMask, key = bor(baseMask, 4), key:sub(7)
		else
			break
		end
	end

	local fullMask = bor(baseMask, addBit)
	if key == "" or fullMask == 0 or fullMask == baseMask then return nil end
	return maskToPrefix[fullMask] .. key
end

local function RecordPagedBinding(pb, key, cmd, macro, abcmd)
	local idx = pb.count + 1
	pb.count = idx
	pb.sf:SetAttribute("htc-key-" .. idx, key)
	pb.sf:SetAttribute("htc-cmd-" .. idx, cmd)
	pb.sf:SetAttribute("htc-macro-" .. idx, macro)
	pb.sf:SetAttribute("htc-abcmd-" .. idx, abcmd)
end

local function BindSlotKey(bf, pb, key, bindCommand, mInfo, abCmd)
	SetOverrideBinding(bf, true, key, bindCommand)
	boundKeys[key] = true
	if pb then
		RecordPagedBinding(pb, key, bindCommand, nil, abCmd)
	end
	if mInfo and mInfo.modifiers and mInfo.macroName then
		for modSpec in pairs(mInfo.modifiers) do
			local modKey = BuildModifiedKey(modSpec, key)
			if modKey then
				local existing = GetBindingAction(modKey, true)
				if not existing or existing == "" then
					SetOverrideBindingMacro(bf, true, modKey, mInfo.macroName)
					if pb then
						RecordPagedBinding(pb, modKey, nil, mInfo.macroName, nil)
					end
				end
			end
		end
	end
end

local function BindKeys(bf, pb, bindCommand, mInfo, abCmd, ...)
	local boundAny = false
	for i = 1, select('#', ...) do
		local key = select(i, ...)
		if key and key ~= "" and not boundKeys[key] then
			BindSlotKey(bf, pb, key, bindCommand, mInfo, abCmd)
			boundAny = true
		end
	end
	return boundAny
end

local function SetBarBindings(barNum, macroSlots, convertMacros, pb, btnCount)
	local info = BAR_INFO[barNum]
	local bf = pb and pb.bf or bindingFrameOthers
	local abPrefix = pb and BAR_INFO[1].bind or nil
	local boundAny = false

	for i = 1, btnCount do
		local bindCommand = info.bind .. i
		local abCmd = abPrefix and (abPrefix .. i) or nil
		local mInfo = convertMacros and macroSlots[info.offset + i - 1]
		wipe(boundKeys)

		if BindKeys(bf, pb, bindCommand, mInfo, abCmd, GetBindingKey(bindCommand)) then
			boundAny = true
		end
		if info.alt and BindKeys(bf, pb, bindCommand, mInfo, abCmd, GetBindingKey(info.alt .. i)) then
			boundAny = true
		end
	end
	return boundAny
end

local function ClearTrailingAttrs(sf, fromIdx, lastCount)
	for i = fromIdx, lastCount do
		sf:SetAttribute("htc-key-" .. i, nil)
		sf:SetAttribute("htc-cmd-" .. i, nil)
		sf:SetAttribute("htc-macro-" .. i, nil)
		sf:SetAttribute("htc-abcmd-" .. i, nil)
	end
end

local function ClearAllBindings(clearAttrs)
	if bindingFrameOthers then ClearOverrideBindings(bindingFrameOthers) end
	for _, pb in pairs(pagedBars) do
		ClearOverrideBindings(pb.bf)
		if pb.active then
			UnregisterStateDriver(pb.sf, "htcpage")
			UnregisterStateDriver(pb.sf, "htcbonus")
			pb.active = false
		end
		pb.mode, pb.page = "cleared", 0
		if clearAttrs then
			pb.sf:SetAttribute("htc-bind-count", 0)
			pb.sf:SetAttribute("htc-mode", "cleared")
			ClearTrailingAttrs(pb.sf, 1, pb.lastCount)
			pb.lastCount = 0
		end
	end
	if clearAttrs then
		for _, snap in pairs(barSnap) do
			snap.enabled, snap.buttons, snap.paging = nil, nil, nil
		end
	end
	wipe(activeBarMap)
	wipe(barBoundMap)
	wipe(actionButtonOwnerBars)
	bindingsActive, othersBound = false, false
end

local function SetAllBindings(db)
	local macroSlots = GetMacroSlotTable()
	local anyPagedActive, sharedBound = false, false

	for _, barNum in ipairs(supportedBars) do
		local enabled = IsBarEnabled(barNum, db)
		local btnCount = GetBarButtonCount(barNum)
		local classPaging = GetBarClassPaging(barNum)
		local snap = barSnap[barNum]
		if not snap then
			snap = {}
			barSnap[barNum] = snap
		end
		snap.enabled, snap.buttons, snap.paging = enabled, btnCount, classPaging or ""

		if enabled then
			activeBarMap[barNum] = true
			if barNum == 1 or classPaging ~= nil then
				local pb = EnsurePagedBarFrames(barNum)
				pb.count = 0
				local boundAny = SetBarBindings(barNum, macroSlots, db.convertMacros, pb, btnCount)
				pb.sf:SetAttribute("htc-bind-count", pb.count)
				ClearTrailingAttrs(pb.sf, pb.count + 1, pb.lastCount)
				pb.lastCount = pb.count
				pb.sf:SetAttribute("htc-mode", "home")
				pb.mode = "home"
				barBoundMap[barNum] = boundAny
				if boundAny then
					anyPagedActive = true
					if barNum == 1 then actionButtonOwnerBars[1] = true end
				end
			else
				local boundAny = SetBarBindings(barNum, macroSlots, db.convertMacros, nil, btnCount)
				barBoundMap[barNum] = boundAny
				if boundAny then sharedBound = true end
			end
		end
	end

	othersBound = sharedBound
	bindingsActive = anyPagedActive or sharedBound
end

-- =============================================================
-- Macro Conversion & Spell Rank Upgrading
-- =============================================================

local function NormalizeBody(body)
	return strtrim((body or ""):gsub("\r", ""))
end

local function GetBaseSpellLower(spellName)
	return strtrim((spellName:match("^(.-)%s*%(") or spellName):lower())
end

local function BuildMacroCache()
	wipe(macroByName)
	local account, character = GetNumMacros()
	local accCount = account or 0
	for i = 1, accCount + (character or 0) do
		local idx = (i <= accCount) and i or (maxAccountMacros + i - accCount)
		local name = GetMacroInfo(idx)
		if name and not macroByName[name] then
			macroByName[name] = idx
		end
	end
end

local function GetActionSlotMacro(slot, actionId, subType)
	local label = GetActionText(slot)
	if label and label ~= "" and macroByName[label] then
		local name, icon, body = GetMacroInfo(macroByName[label])
		if name == label and body then return name, icon, body end
	end
	if actionId and (not subType or subType == "") then
		local name, icon, body = GetMacroInfo(actionId)
		if name and body then return name, icon, body end
	end
end

--Parses simple or modifier-downrank spell macros into (spellName, modifiers)
--Returns nil for complex macros (@mouseover, @cursor, /castsequence, multiple /cast lines, etc.)
local function ParseConvertibleMacro(body)
	if not body or body == "" then return nil end
	local defaultSpell, modifiers

	for line in NormalizeBody(body):gmatch("[^\n]+") do
		line = strtrim(line)
		if line ~= "" and not line:match("^#") then
			local cmd, rest = line:match("^/(%a+)%s+(.+)$")
			if not cmd or defaultSpell then return nil end
			cmd = cmd:lower()
			if cmd ~= "cast" and cmd ~= "use" then return nil end

			for clause in rest:gmatch("[^;]+") do
				clause = strtrim(clause)
				if clause ~= "" then
					local condBlock, targetSpell = clause:match("^(%b[])%s*(.*)$")
					if condBlock then
						local hasMod = false
						wipe(modCombos)
						modCombos[1] = 0
						for part in condBlock:sub(2, -2):lower():gmatch("[^,]+") do
							part = strtrim(part)
							local modListStr = part:match("^mod:(.+)$") or part:match("^modifier:(.+)$")
							if modListStr then
								hasMod = true
								wipe(modNextCombos)
								for m in modListStr:gmatch("[^/]+") do
									local bitVal = modBits[strtrim(m)]
									if not bitVal then return nil end
									for _, existing in ipairs(modCombos) do
										modNextCombos[#modNextCombos + 1] = bor(existing, bitVal)
									end
								end
								if #modNextCombos == 0 then return nil end
								modCombos, modNextCombos = modNextCombos, modCombos
							elseif part == "mod" or part == "modifier" then
								hasMod = true
								wipe(modNextCombos)
								for _, existing in ipairs(modCombos) do
									modNextCombos[#modNextCombos + 1] = bor(existing, 1)
									modNextCombos[#modNextCombos + 1] = bor(existing, 2)
									modNextCombos[#modNextCombos + 1] = bor(existing, 4)
								end
								modCombos, modNextCombos = modNextCombos, modCombos
							elseif not (part == "nomod" or part == "nomodifier" or part == "harm" or part == "nodead" or part == "exists") then
								return nil
							end
						end
						if hasMod then
							modifiers = modifiers or {}
							for _, mask in ipairs(modCombos) do
								if mask > 0 then modifiers[maskToMod[mask]] = true end
							end
						else
							targetSpell = strtrim(targetSpell)
							if targetSpell == "" or defaultSpell then return nil end
							defaultSpell = targetSpell
						end
					elseif not defaultSpell then
						defaultSpell = clause
					else
						return nil
					end
				end
			end
		end
	end

	defaultSpell = defaultSpell and strtrim(defaultSpell:gsub("^!", "")) or ""
	if defaultSpell == "" or tonumber(defaultSpell) then return nil end
	return defaultSpell, modifiers
end

local function AddSpellCandidate(spellID, name, subName)
	if not spellID or not name or name == "" then return end
	if not IsSpellKnown(spellID, playerBank) then return end

	local lowerName = strtrim(name:lower())
	local entry = spellCache[lowerName]
	if not entry then
		entry = { highestRank = -1 }
		spellCache[lowerName] = entry
	end

	local rankNum = tonumber((subName or ""):match("(%d+)")) or 0
	if rankNum > 0 then
		entry.ranksByNum = entry.ranksByNum or {}
		entry.ranksByNum[rankNum] = spellID
	end
	if subName and subName ~= "" then
		entry.ranksBySub = entry.ranksBySub or {}
		entry.ranksBySub[strtrim(subName:lower())] = spellID
	end
	if rankNum > entry.highestRank or (rankNum == entry.highestRank and (not entry.highestID or spellID > entry.highestID)) then
		entry.highestRank, entry.highestID = rankNum, spellID
	end
end

local function BuildSpellBookCache()
	wipe(spellCache)
	for lineIdx = 1, (GetNumSkillLines() or 0) do
		local skillInfo = GetSkillLineInfo(lineIdx)
		if skillInfo and skillInfo.numSpellBookItems and skillInfo.numSpellBookItems > 0 then
			for offset = 1, skillInfo.numSpellBookItems do
				local slotIndex = skillInfo.itemIndexOffset + offset
				local itemInfo = GetSpellBookItemInfo(slotIndex, playerBank)
				if itemInfo and not itemInfo.isPassive and not itemInfo.isOffSpec and itemInfo.spellID and itemInfo.itemType == spellItemType then
					local sID = itemInfo.spellID
					AddSpellCandidate(sID, itemInfo.name or GetSpellName(sID), itemInfo.subName or GetSpellSubtext(sID))
				end
			end
		end
	end
end

local function ResolveSpellFromCache(spellName)
	if not spellName or spellName == "" then return nil end
	local baseName, reqRank = spellName:match("^(.-)%s*%(([^%)]+)%)$")
	local entry = spellCache[strtrim((baseName or spellName):lower())]
	if not entry then return nil end
	if reqRank then
		local bySub = entry.ranksBySub and entry.ranksBySub[strtrim(reqRank:lower())]
		if bySub then return bySub end
		local reqRankNum = entry.ranksByNum and tonumber(reqRank:match("(%d+)"))
		return reqRankNum and entry.ranksByNum[reqRankNum] or nil
	end
	return entry.highestID
end

local function PlaceOnSlot(pickupFn, arg, slot)
	ClearCursor()
	pickupFn(arg)
	if not GetCursorInfo() then
		ClearCursor()
		return false
	end
	PlaceAction(slot)
	ClearCursor()
	return true
end

local function PlaceSpellInSlot(slot, spellID)
	if InCombatLockdown() or GetCursorInfo() or not PlaceOnSlot(PickupSpell, spellID, slot) then return false end
	local kind, id = GetActionInfo(slot)
	return kind == "spell" and id == spellID
end

local function UpdateMacroEvents(db)
	if not eventFrame then return end
	local need = (db and db.enable and (db.convertMacros or next(GetMacroSlotTable()) ~= nil)) and true or false
	if need == macroEventsRegistered then return end
	macroEventsRegistered = need
	for _, ev in ipairs(macroEvents) do
		if need then
			eventFrame:RegisterEvent(ev)
		else
			eventFrame:UnregisterEvent(ev)
		end
	end
end

local function RunSpellbookRetry()
	spellbookRetryTimer = nil
	if not InCombatLockdown() then
		local conv, upg = SyncMacrosAndRanks()
		if conv > 0 or upg > 0 then
			ApplyBindings(true)
		end
	end
end

local function SyncMacrosAndRanksInner(db, macroSlots)
	local convertedCount, upgradedCount = 0, 0
	local spellCacheBuilt, macroCacheBuilt = false, false

	for _, barNum in ipairs(supportedBars) do
		if IsBarEnabled(barNum, db) then
			local startSlot = BAR_INFO[barNum].offset
			for i = 1, GetBarButtonCount(barNum) do
				local slot = startSlot + i - 1
				local kind, id, subType = GetActionInfo(slot)
				local savedMacro = macroSlots[slot]
				local macroName, macroIcon, macroBody

				--Clean up stale macroSlot records if the player manually replaced or cleared the slot
				if savedMacro then
					if kind == "spell" and id then
						local currentName = GetSpellName(id)
						if id ~= savedMacro.spellID and (not currentName or strtrim(currentName:lower()) ~= GetBaseSpellLower(savedMacro.spellName)) then
							macroSlots[slot], savedMacro = nil, nil
						end
					elseif kind == "macro" then
						if not macroCacheBuilt then
							BuildMacroCache()
							macroCacheBuilt = true
						end
						macroName, macroIcon, macroBody = GetActionSlotMacro(slot, id, subType)
						if not macroName or macroName ~= savedMacro.macroName then
							macroSlots[slot], savedMacro = nil, nil
						end
					else
						macroSlots[slot], savedMacro = nil, nil
					end
				end

				if kind == "macro" and db.convertMacros then
					if not macroCacheBuilt then
						BuildMacroCache()
						macroCacheBuilt = true
					end
					if not macroBody then macroName, macroIcon, macroBody = GetActionSlotMacro(slot, id, subType) end
					if macroBody then
						local spellName, modifiers = ParseConvertibleMacro(macroBody)
						if spellName then
							if not spellCacheBuilt then
								BuildSpellBookCache()
								spellCacheBuilt = true
								if not next(spellCache) then spellbookDeferred = true end
							end
							local targetSpellID = ResolveSpellFromCache(spellName)
							if targetSpellID and PlaceSpellInSlot(slot, targetSpellID) then
								macroSlots[slot] = {
									macroName = macroName, macroBody = macroBody, macroIcon = macroIcon,
									spellName = spellName, spellID = targetSpellID, modifiers = modifiers,
								}
								convertedCount = convertedCount + 1
								DebugPrint("Converted slot " .. slot .. " macro '" .. tostring(macroName) .. "' -> " .. tostring(spellName))
							end
						end
					end
				elseif kind == "spell" and db.autoUpgradeRanks and id and savedMacro and savedMacro.spellName and not savedMacro.spellName:find("%(") then
					--Only upgrade slots originally converted from macros by HoldToCast
					if not spellCacheBuilt then
						BuildSpellBookCache()
						spellCacheBuilt = true
						if not next(spellCache) then spellbookDeferred = true end
					end
					local highestID = ResolveSpellFromCache(savedMacro.spellName)
					if highestID and highestID ~= id and PlaceSpellInSlot(slot, highestID) then
						savedMacro.spellID = highestID
						upgradedCount = upgradedCount + 1
						DebugPrint("Upgraded converted slot " .. slot .. " '" .. tostring(savedMacro.spellName) .. "' -> " .. tostring(highestID))
					end
				end
			end
		end
	end

	return convertedCount, upgradedCount
end

SyncMacrosAndRanks = function()
	if InCombatLockdown() or GetCursorInfo() then return 0, 0 end
	local db = GetDB()
	if not db or not db.enable then return 0, 0 end

	local macroSlots = GetMacroSlotTable()
	if not db.convertMacros and not next(macroSlots) then
		UpdateMacroEvents(db)
		return 0, 0
	end

	spellbookDeferred = false
	isSyncing = true
	local ok, conv, upg = pcall(SyncMacrosAndRanksInner, db, macroSlots)
	isSyncing = false
	wipe(spellCache)
	wipe(macroByName)
	UpdateMacroEvents(db)

	if spellbookDeferred then
		if spellbookRetries < 5 then
			spellbookRetries = spellbookRetries + 1
			if not spellbookRetryTimer then
				spellbookRetryTimer = C_Timer.NewTimer(1, RunSpellbookRetry)
			end
		end
	else
		spellbookRetries = 0
	end

	if ok then return conv or 0, upg or 0 end
	DebugPrint("SyncMacrosAndRanks error: " .. tostring(conv))
	return 0, 0
end

local function EnableBlizzardBarEvents()
	ActionBarController:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
	ActionBarController:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	ActionBarController:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	ActionBarController:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR")
end

ApplyBindings = function(skipSync)
	if isApplying then return end
	if InCombatLockdown() then
		pendingUpdate = true
		DebugPrint("ApplyBindings: deferred (combat)")
		return
	end

	isApplying = true
	ClearAllBindings(false)

	local db = GetDB()
	if not db or not db.enable or not (E.private.actionbar and E.private.actionbar.enable) or IsStandaloneHoldToCastLoaded() then
		ClearAllBindings(true)
		isApplying = false
		return
	end

	if IsHouseEditorActive() or IsInsidePlot() then
		housingMode = true
		ClearAllBindings(true)
		isApplying = false
		DebugPrint("ApplyBindings: housing mode, paused")
		return
	end
	housingMode = false

	if not skipSync then SyncMacrosAndRanks() end

	SetAllBindings(db)
	for _, barNum in ipairs(supportedBars) do
		local snap = barSnap[barNum]
		if snap and snap.enabled and (barNum == 1 or snap.paging ~= "") then
			local pb = pagedBars[barNum]
			pb.active = true
			RegisterStateDriver(pb.sf, "htcpage", GetBarPagingConditions(barNum, snap.paging ~= "" and snap.paging or nil))
			RegisterStateDriver(pb.sf, "htcbonus", BONUS_STATE_CONDITIONS)
		end
	end

	isApplying = false
	DebugPrint("ApplyBindings: done, active=" .. tostring(bindingsActive))
end

local function RunZoneReapply()
	zoneTimer = nil
	local db = GetDB()
	if db and db.enable then
		EnableBlizzardBarEvents()
		ApplyBindings()
	end
end

local function RunSlotSync()
	slotSyncTimer = nil
	local db = GetDB()
	if not db or not db.enable then return end
	if InCombatLockdown() then
		pendingSlotSync = true
		return
	end
	if GetCursorInfo() then
		slotSyncTimer = C_Timer.NewTimer(0.3, RunSlotSync)
		return
	end
	local conv, upg = SyncMacrosAndRanks()
	if conv > 0 or upg > 0 then
		ApplyBindings(true)
	end
end

local function RunConfigSync()
	configSyncTimer = nil
	local db = GetDB()
	if not db or not db.enable then return end
	if InCombatLockdown() then
		pendingUpdate = true
		return
	end
	ApplyBindings()
end

local function CancelPendingTimers()
	if zoneTimer then
		zoneTimer:Cancel()
		zoneTimer = nil
	end
	if slotSyncTimer then
		slotSyncTimer:Cancel()
		slotSyncTimer = nil
	end
	if spellbookRetryTimer then
		spellbookRetryTimer:Cancel()
		spellbookRetryTimer = nil
	end
	if configSyncTimer then
		configSyncTimer:Cancel()
		configSyncTimer = nil
	end
end

local function SetElvUIButtonPushed(barNum, slot, isPushed)
	if isPushed and (not bindingsActive or housingMode or not activeBarMap[barNum]) then return end
	if E.db.ElvUI_EltreumUI.skins.hideABkeypress then return end

	local barTable = barButtons[barNum]
	if not barTable then
		barTable = {}
		barButtons[barNum] = barTable
	end
	local btn = barTable[slot]
	if btn == nil then
		btn = _G["ElvUI_Bar" .. barNum .. "Button" .. slot] or false
		barTable[slot] = btn
	end
	if not btn or not btn.SetButtonState then return end

	local btnState = btn:GetButtonState()
	if isPushed then
		if btnState == "NORMAL" then btn:SetButtonState("PUSHED") end
	elseif btnState == "PUSHED" then
		btn:SetButtonState("NORMAL")
	end
end

local function InstallHooks()
	if hooked then return end

	if AB and AB.HandleBinds then
		hooksecurefunc(AB, "HandleBinds", function()
			local db = GetDB()
			if db and db.enable then
				DebugPrint("Hook: AB:HandleBinds")
				ApplyBindings()
			end
		end)
	end
	if AB and AB.PositionAndSizeBar then
		hooksecurefunc(AB, "PositionAndSizeBar", function(_, barName)
			local barNum = barKeyToNum[barName]
			local db = barNum and GetDB()
			if not db or not db.enable then return end
			local snap = barSnap[barNum]
			if snap and snap.enabled == IsBarEnabled(barNum, db)
				and snap.buttons == GetBarButtonCount(barNum)
				and snap.paging == (GetBarClassPaging(barNum) or "") then
				return
			end
			DebugPrint("Hook: AB:PositionAndSizeBar (" .. tostring(barName) .. ")")
			if InCombatLockdown() then
				pendingUpdate = true
			else
				if configSyncTimer then configSyncTimer:Cancel() end
				configSyncTimer = C_Timer.NewTimer(0.2, RunConfigSync)
			end
		end)
	end

	hooksecurefunc("ActionButtonDown", function(id)
		for barNum in pairs(actionButtonOwnerBars) do
			SetElvUIButtonPushed(barNum, id, true)
		end
	end)
	hooksecurefunc("ActionButtonUp", function(id)
		for barNum in pairs(pagedBars) do
			SetElvUIButtonPushed(barNum, id, false)
		end
	end)
	hooksecurefunc("MultiActionButtonDown", function(bar, id)
		local barNum = multiBarToElvUIBar[bar]
		if barNum then
			local pb = pagedBars[barNum]
			if not pb or not pb.active or pb.mode == "home" then
				SetElvUIButtonPushed(barNum, id, true)
			end
		end
	end)
	hooksecurefunc("MultiActionButtonUp", function(bar, id)
		local barNum = multiBarToElvUIBar[bar]
		if barNum then SetElvUIButtonPushed(barNum, id, false) end
	end)

	hooked = true
end

local function OnEvent(_, event)
	if event == "PLAYER_REGEN_ENABLED" then
		if pendingDisable then
			pendingDisable, pendingUpdate, pendingSlotSync, macroEventsRegistered = false, false, false, false
			if eventFrame then eventFrame:UnregisterAllEvents() end
			ClearAllBindings(true)
			return
		end
		if pendingUpdate then
			pendingUpdate, pendingSlotSync = false, false
			ApplyBindings()
		elseif pendingSlotSync then
			pendingSlotSync = false
			RunSlotSync()
		end
		return
	end

	local db = GetDB()
	if not db or not db.enable then return end

	if event == "HOUSE_PLOT_ENTERED" or event == "HOUSE_PLOT_EXITED" then
		ApplyBindings()
	elseif not isSyncing then
		--Coalesce spellbook/macro/slot updates so combat procs never tear down keybinds
		if InCombatLockdown() then
			pendingSlotSync = true
		else
			if slotSyncTimer then slotSyncTimer:Cancel() end
			slotSyncTimer = C_Timer.NewTimer(0.25, RunSlotSync)
		end
	end
end

--Restores macros that were converted to direct spells back onto their action bar slots
function ElvUI_EltreumUI:RestoreHoldToCastMacros()
	if InCombatLockdown() or GetCursorInfo() then
		ElvUI_EltreumUI:Print(L["Cannot restore macros while in combat or holding something on the cursor."])
		return 0
	end

	local macroSlots = GetMacroSlotTable()
	if not next(macroSlots) then return 0 end

	BuildMacroCache()
	local restored, bodyToIdx = 0, nil
	for slot, info in pairs(macroSlots) do
		local kind, id = GetActionInfo(slot)
		local currentName = (kind == "spell" and id) and GetSpellName(id)
		local slotMatches = (kind == nil) or (kind == "spell" and (id == info.spellID or (currentName and info.spellName and strtrim(currentName:lower()) == GetBaseSpellLower(info.spellName))))

		if slotMatches then
			local foundIdx = info.macroName and macroByName[info.macroName]
			if not foundIdx and info.macroBody then
				if not bodyToIdx then
					bodyToIdx = {}
					local account, character = GetNumMacros()
					local accCount = account or 0
					for i = 1, accCount + (character or 0) do
						local idx = (i <= accCount) and i or (maxAccountMacros + i - accCount)
						local _, _, body = GetMacroInfo(idx)
						local norm = body and NormalizeBody(body)
						if norm and norm ~= "" and not bodyToIdx[norm] then
							bodyToIdx[norm] = idx
						end
					end
				end
				foundIdx = bodyToIdx[NormalizeBody(info.macroBody)]
			end
			if foundIdx and PlaceOnSlot(PickupMacro, foundIdx, slot) then
				restored = restored + 1
				macroSlots[slot] = nil
				DebugPrint("Restored slot " .. slot .. " macro '" .. tostring(info.macroName) .. "'")
			end
		else
			macroSlots[slot] = nil
		end
	end
	wipe(macroByName)

	local db = GetDB()
	UpdateMacroEvents(db)
	if db and db.enable then ApplyBindings(true) end
	return restored
end

--Returns a compact status line for the Eltruism options panel
function ElvUI_EltreumUI:GetHoldToCastStatusText()
	local db = GetDB()
	if IsStandaloneHoldToCastLoaded() then
		return "|cffffaa00" .. L["Paused (standalone HoldToCastFix addon is loaded)"] .. "|r"
	elseif not db or not db.enable then
		return "|cffff4444" .. _G.DISABLE .. "|r"
	elseif not (E.private.actionbar and E.private.actionbar.enable) then
		return "|cffffaa00" .. L["Inactive (ElvUI ActionBars disabled)"] .. "|r"
	elseif housingMode then
		return "|cffffaa00" .. L["Paused (housing plot)"] .. "|r"
	elseif pendingUpdate then
		return "|cffffaa00" .. L["Pending (restoring after combat)"] .. "|r"
	elseif bindingsActive then
		wipe(activeBarsTmp)
		for _, barNum in ipairs(supportedBars) do
			if IsBarEnabled(barNum, db) then activeBarsTmp[#activeBarsTmp + 1] = tostring(barNum) end
		end
		local barStr = #activeBarsTmp > 0 and tconcat(activeBarsTmp, ", ") or _G.NONE
		wipe(activeBarsTmp)
		for _, barNum in ipairs(supportedBars) do
			local pb = barBoundMap[barNum] and pagedBars[barNum]
			if pb and pb.mode == "cleared" then activeBarsTmp[#activeBarsTmp + 1] = tostring(barNum) end
		end
		if #activeBarsTmp > 0 then
			return "|cff00ff00" .. L["Active"] .. "|r - " .. L["Bars"] .. ": " .. barStr .. " |cffffaa00(" .. L["Paused"] .. ": " .. tconcat(activeBarsTmp, ", ") .. ")|r"
		end
		return "|cff00ff00" .. L["Active"] .. "|r - " .. L["Bars"] .. ": " .. barStr
	else
		for _, pb in pairs(pagedBars) do
			if pb.active and pb.mode == "cleared" then
				return "|cffffaa00" .. L["Paused (actionbar paged)"] .. "|r"
			end
		end
		return "|cffffaa00" .. L["Inactive"] .. "|r"
	end
end

local function FormatBool(val, warnIfTrue)
	if warnIfTrue then return val and "|cffffaa00true|r" or "|cff888888false|r" end
	return val and "|cff00ff00true|r" or "|cffff4444false|r"
end

local function FormatCVar(name)
	local val = GetCVar(name)
	if val == "1" then return "|cff00ff001 (OK)|r" end
	if val ~= nil then return "|cffff4444" .. tostring(val) .. " (Disabled)|r" end
	return "|cff888888n/a|r"
end

local function CollectDiagKeys(cmd, expectedCmd, slot, isExpectedActive, ...)
	for k = 1, select('#', ...) do
		local key = select(k, ...)
		if key and key ~= "" and not boundKeys[key] then
			boundKeys[key] = true
			diagState.totalBinds = diagState.totalBinds + 1
			local eff = GetBindingAction(key, true) or ""
			if eff == expectedCmd then
				diagState.okBinds = diagState.okBinds + 1
			elseif isExpectedActive then
				diagState.mismatches = diagState.mismatches or {}
				diagState.mismatches[#diagState.mismatches + 1] = "      |cffff4444Mismatch:|r " .. cmd .. " [" .. key .. "] -> " .. (eff ~= "" and eff or "unbound")
			end
			if not diagState.slotCounted then
				diagState.slotCounted = true
				local kind = GetActionInfo(slot)
				if kind == "spell" then
					diagState.spellSlots = diagState.spellSlots + 1
				elseif kind == "macro" then
					diagState.macroSlots = diagState.macroSlots + 1
				end
			end
		end
	end
end

local function PrintBarDiagnostics(barNum)
	local info, pb = BAR_INFO[barNum], pagedBars[barNum]
	local mode = pb and pb.mode
	local isPagedAB = (barNum ~= 1 and mode == "paged-ab")
	local isCleared = (mode == "cleared")
	local isExpectedActive = bindingsActive and not housingMode and not isCleared
	local page = pb and pb.page or 0
	local slotBase = (barNum == 1 or isPagedAB) and (((page > 0 and page or 1) - 1) * 12) or (info.offset - 1)
	local abPrefix = BAR_INFO[1].bind

	diagState.totalBinds, diagState.okBinds, diagState.spellSlots, diagState.macroSlots, diagState.mismatches = 0, 0, 0, 0, nil

	for i = 1, GetBarButtonCount(barNum) do
		local cmd = info.bind .. i
		local expectedCmd = isPagedAB and (abPrefix .. i) or cmd
		local slot = slotBase + i
		wipe(boundKeys)
		diagState.slotCounted = false

		CollectDiagKeys(cmd, expectedCmd, slot, isExpectedActive, GetBindingKey(cmd))
		if info.alt then
			CollectDiagKeys(cmd, expectedCmd, slot, isExpectedActive, GetBindingKey(info.alt .. i))
		end
	end

	if diagState.totalBinds == 0 then
		print("    Bar " .. barNum .. ": |cff8888880 binds|r")
	else
		local bindText
		if isCleared then
			bindText = "|cffffaa00" .. diagState.okBinds .. "/" .. diagState.totalBinds .. " binds (paused - paged to ElvUI)|r"
		elseif not isExpectedActive then
			bindText = "|cffffaa00" .. diagState.okBinds .. "/" .. diagState.totalBinds .. " binds (paused/inactive)|r"
		elseif diagState.okBinds == diagState.totalBinds then
			bindText = "|cff00ff00" .. diagState.okBinds .. "/" .. diagState.totalBinds .. " binds OK|r"
		else
			bindText = "|cffff4444" .. diagState.okBinds .. "/" .. diagState.totalBinds .. " binds OK|r"
		end
		local pagedTag = isPagedAB and (" |cff00ccff[paged -> page " .. tostring(page > 0 and page or 1) .. "]|r") or ""
		local contents = diagState.spellSlots .. " spells" .. (diagState.macroSlots > 0 and (", |cffffaa00" .. diagState.macroSlots .. " macro(s)|r") or "")
		print("    Bar " .. barNum .. ": " .. bindText .. pagedTag .. " (" .. contents .. ")")
	end

	if diagState.mismatches then
		for i = 1, #diagState.mismatches do print(diagState.mismatches[i]) end
		diagState.mismatches = nil
	end
	return diagState.macroSlots
end

--Prints Hold to Cast diagnostic info to chat
function ElvUI_EltreumUI:HoldToCastDiagnostics()
	local db = GetDB()
	local statusText = ElvUI_EltreumUI:GetHoldToCastStatusText()

	ElvUI_EltreumUI:Print("|cff82B4ffHold to Cast Diagnostics|r (Eltruism " .. tostring(ElvUI_EltreumUI.Version) .. " | ElvUI " .. tostring(E.version) .. " | TOC " .. tostring(select(4, GetBuildInfo())) .. ")")

	local extra = ""
	if IsStandaloneHoldToCastLoaded() then
		extra = " | |cffff4444Standalone HoldToCastFix conflict|r"
	elseif not (E.private.actionbar and E.private.actionbar.enable) then
		extra = " | |cffffaa00ElvUI ActionBars disabled|r"
	end
	print("  |cff82B4ffStatus:|r " .. statusText
		.. " | Enabled=" .. FormatBool(db and db.enable)
		.. " | Combat=" .. FormatBool(InCombatLockdown(), true)
		.. (E.Retail and (" | Housing=" .. FormatBool(housingMode, true)) or "")
		.. " | Pending=" .. FormatBool(pendingUpdate, true)
		.. extra)

	print("  |cff82B4ffCVars:|r HoldToCast=" .. FormatCVar("ActionButtonUseKeyHeldSpell")
		.. " | KeyDown=" .. FormatCVar("ActionButtonUseKeyDown"))

	local anyDriver = false
	for _, barNum in ipairs(supportedBars) do
		local pb = pagedBars[barNum]
		if pb and pb.active then
			anyDriver = true
			print("  |cff82B4ffStateDriver Bar " .. barNum .. ":|r state=" .. tostring(pb.sf:GetAttribute("state-htcpage"))
				.. " | mode=" .. tostring(pb.mode or pb.sf:GetAttribute("htc-mode"))
				.. " | page=" .. tostring(pb.page or 0)
				.. " | mismatch=" .. FormatBool(pb.sf:GetAttribute("htc-mismatch"), true)
				.. " | binds=" .. tostring(pb.sf:GetAttribute("htc-bind-count") or 0))
		end
	end
	if not anyDriver then
		print("  |cff82B4ffStateDriver:|r |cff888888not initialized|r")
	end

	local macroSlots = GetMacroSlotTable()
	wipe(activeBarsTmp)
	for slot, info in pairs(macroSlots) do
		local modTag = (info.modifiers and next(info.modifiers)) and " [MODS]" or ""
		activeBarsTmp[#activeBarsTmp + 1] = "Slot " .. tostring(slot) .. ": '" .. tostring(info.macroName) .. "' -> " .. tostring(info.spellName) .. modTag
	end
	print("  |cff82B4ffMacros:|r Convert=" .. FormatBool(db and db.convertMacros)
		.. " | AutoUpgrade=" .. FormatBool(db and db.autoUpgradeRanks)
		.. " | Converted=" .. tostring(#activeBarsTmp))
	if #activeBarsTmp > 0 then
		print("    " .. tconcat(activeBarsTmp, ", "))
	end

	print("  |cff82B4ffActionBars:|r")
	local enabledBarCount, totalBoundMacros = 0, 0
	for _, barNum in ipairs(supportedBars) do
		if IsBarEnabled(barNum, db) then
			enabledBarCount = enabledBarCount + 1
			totalBoundMacros = totalBoundMacros + PrintBarDiagnostics(barNum)
		end
	end
	if enabledBarCount == 0 then
		print("    |cff888888(none enabled)|r")
	elseif totalBoundMacros > 0 then
		print("  |cffffaa00Note:|r Unconverted macros on bound slots cannot Hold to Cast")
	end
end

--Initialize or update Hold to Cast module
function ElvUI_EltreumUI:HoldToCast(isZoning)
	if IsStandaloneHoldToCastLoaded() or not (E.private.actionbar and E.private.actionbar.enable) then return end

	local db = GetDB()
	if not db or not db.enable then
		if initialized then
			CancelPendingTimers()
			macroEventsRegistered = false
			if InCombatLockdown() then
				pendingDisable = true
				eventFrame:UnregisterAllEvents()
				eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
				eventFrame:SetScript("OnEvent", OnEvent)
			else
				eventFrame:UnregisterAllEvents()
				ClearAllBindings(true)
				pendingDisable, pendingSlotSync = false, false
			end
		end
		return
	end

	if not bindingFrameOthers then
		bindingFrameOthers = CreateFrame("Frame", "EltruismHoldToCastBindingOthers", E.UIParent)
		eventFrame = CreateFrame("Frame", "EltruismHoldToCastEvents")
	end
	pendingDisable, spellbookRetries = false, 0
	InstallHooks()

	--Ensure Blizzard's Press and Hold Casting CVars are enabled when the fix is active
	if GetCVar("ActionButtonUseKeyHeldSpell") ~= "1" then
		SetCVar("ActionButtonUseKeyHeldSpell", "1")
	end
	if GetCVar("ActionButtonUseKeyDown") ~= "1" then
		SetCVar("ActionButtonUseKeyDown", "1")
	end

	eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	eventFrame:RegisterEvent("HOUSE_PLOT_ENTERED")
	eventFrame:RegisterEvent("HOUSE_PLOT_EXITED")
	macroEventsRegistered = false
	UpdateMacroEvents(db)
	eventFrame:SetScript("OnEvent", OnEvent)

	EnableBlizzardBarEvents()
	ApplyBindings()
	initialized = true

	--Safety net re-apply after zoning to catch late skyriding/override transitions
	if isZoning then
		if zoneTimer then zoneTimer:Cancel() end
		zoneTimer = C_Timer.NewTimer(1, RunZoneReapply)
	end
end
