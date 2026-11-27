local E, L = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local strsplit = _G.strsplit
local strtrim = _G.strtrim
local ipairs = _G.ipairs
local tonumber = _G.tonumber
local tostring = _G.tostring
local hooksecurefunc = _G.hooksecurefunc
local pairs = _G.pairs
local next = _G.next
local GetPetActionInfo = _G.GetPetActionInfo
local GetTime = _G.GetTime
local tinsert = _G.tinsert
local tremove = _G.tremove
local unpack = _G.unpack
local C_Item = _G.C_Item
local C_Container = _G.C_Container
local GetItemSpell = C_Item.GetItemSpell
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local wipe = _G.wipe
local GetActionInfo = _G.GetActionInfo
local GetActionTexture = _G.GetActionTexture
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetMacroItem = _G.GetMacroItem
local IsInCinematicScene = _G.IsInCinematicScene
local wasPreviewing = false
local cooldowns, animating, watching, waitingEnableSpells = { }, { }, { }, { }
local listedSpells = { }
local tablePool = { }
local equippedUsableItems = { }
local petOverlay = {1,1,1}
local IsAddOnLoaded = _G.C_AddOns.IsAddOnLoaded
local C_VoiceChat = _G.C_VoiceChat
local doomdb
local elapsed = 0
local runtimer = 0

local function AcquireTable()
	local tbl = tremove(tablePool)
	if tbl then
		return tbl
	end
	return {}
end

local function ReleaseTable(tbl)
	if tbl then
		wipe(tbl)
		if #tablePool < 32 then
			tinsert(tablePool, tbl)
		end
	end
end

local function IsEntryListed(key, altID, name)
	if key and E:NotSecretValue(key) and listedSpells[tostring(key)] then return true end
	if altID and E:NotSecretValue(altID) and listedSpells[tostring(altID)] then return true end
	if name and E:NotSecretValue(name) and listedSpells[name] then return true end
	return false
end

local function PassesFilter(key, altID, name)
	if doomdb.allowing then
		if not next(listedSpells) then return false end
		return IsEntryListed(key, altID, name)
	elseif doomdb.ignoring then
		if not next(listedSpells) then return true end
		return not IsEntryListed(key, altID, name)
	end
	return true
end

local function PassesDurationFilter(duration)
	if not duration then return false end
	local minCD = doomdb.graceperiod
	local maxCD = doomdb.gracelimit
	if duration <= minCD then return false end
	if maxCD ~= 0 and duration > maxCD then return false end
	return true
end

local function RefreshEquippedUsableItems()
	wipe(equippedUsableItems)
	for slot = 1, 19 do
		local itemID = GetInventoryItemID("player", slot)
		if itemID and E:NotSecretValue(itemID) and GetItemSpell(itemID) then
			equippedUsableItems[slot] = itemID
		end
	end
end

local function QueryEntryCooldown(entry)
	local id = (entry.cooldownType == "spell" and entry.spellID) or (entry.cooldownType == "pet" and entry.petIndex) or entry.id
	return ElvUI_EltreumUI:EltruismCooldownQuery(entry.cooldownType, id, entry.spellID, nil, 0, false, entry.overrideResolved)
end

local function PromoteEntryToCooldown(i, v, status, start, duration)
	if status == "EXACT" then
		if v.texture and PassesDurationFilter(duration) then
			v.start = start
			v.duration = duration
			v.startEst = start
			v.secret = false
			v.dirty = false
			ReleaseTable(cooldowns[i])
			cooldowns[i] = v
			return true
		end
		ReleaseTable(v)
		return false
	elseif status == "SECRET" then
		if v.texture then
			v.start = nil
			v.duration = nil
			v.startEst = v.castTime
			v.secret = true
			v.dirty = false
			v.lastCheck = GetTime()
			ReleaseTable(cooldowns[i])
			cooldowns[i] = v
			return true
		end
		ReleaseTable(v)
		return false
	end
	ReleaseTable(v)
	return false
end

--createframes
local DCP = CreateFrame("FRAME","EltruismDoomCDPulse")
local DCP_EventFrame = CreateFrame("FRAME")
DCP:SetPoint("CENTER",E.UIParent,"CENTER", 0, 350)
DCP:SetSize(80,80)
DCP:SetAlpha(0)

DCP.TextFrame = DCP:CreateFontString("EltruismDoomCDPulseText", "ARTWORK")
DCP.TextFrame:SetShadowOffset(1,-1)
DCP.TextFrame:SetPoint("CENTER",DCP,"CENTER")
DCP.TextFrame:SetWidth(300)
DCP.TextFrame:SetJustifyH("CENTER")
DCP.TextFrame:SetTextColor(1,1,1)

local DCPT = DCP:CreateTexture("EltruismDoomCDPulseTexture","BACKGROUND")
DCPT:SetAllPoints(DCP)

-- create mover
E:CreateMover(DCP, "EltruismDoomMover", L["EltruismDoom"], nil, nil, nil, 'ALL,SOLO,ELTREUMUI', nil, 'ElvUI_EltreumUI,cooldown')

local function OnUpdate(_,update)
	elapsed = elapsed + update
	if wasPreviewing then
		wasPreviewing = false
		DCPT:SetTexture(nil)
		if DCP.shadow then
			DCP.shadow:SetAlpha(0)
		end
	end

	--poll fast (0.05s) while promoting new casts, slower (0.15s) when only tracking active cooldowns
	local pollInterval = next(watching) and 0.05 or 0.15
	if (elapsed > pollInterval) then
		elapsed = 0
		local now = GetTime()
		for i, v in pairs(watching) do
			if (now >= v.castTime + 0.5) then
				if not v.infoResolved then
					v.infoResolved = true
					if v.cooldownType == "spell" then
						local name, resolvedID, texture = ElvUI_EltreumUI:EltruismSpellInfo(v.spellID)
						v.name = name
						v.spellID = resolvedID or v.spellID
						v.texture = texture
						v.overrideResolved = true
					elseif v.cooldownType == "item" then
						local itemName, _, itemTex = ElvUI_EltreumUI:EltruismItemInfo(v.id, true)
						v.name = itemName
						v.texture = v.texture or itemTex
					elseif v.cooldownType == "pet" then
						local petName, petTex, _, _, _, _, petSpellID = GetPetActionInfo(v.petIndex)
						if petName and E:NotSecretValue(petName) then
							v.name = petName
						end
						v.texture = petTex or v.texture
						if petSpellID and E:NotSecretValue(petSpellID) then
							v.spellID = petSpellID
						end
					end
				end

				if not PassesFilter(i, v.spellID, v.name) then
					watching[i] = nil
					ReleaseTable(v)
				else
					local status, start, duration = QueryEntryCooldown(v)
					if status == "DISABLED" and v.cooldownType == "spell" then
						--park disabled spells (e.g. Stealth/Prowl) until SPELL_UPDATE_COOLDOWN wakes them
						watching[i] = nil
						ReleaseTable(waitingEnableSpells[i])
						waitingEnableSpells[i] = v
					else
						watching[i] = nil
						PromoteEntryToCooldown(i, v, status, start, duration)
					end
				end
			end
		end

		for i, cd in pairs(cooldowns) do
			if cd.dirty or not cd.start or not cd.duration then
				--throttle secret fallback checks to 1s
				if cd.dirty or not cd.secret or (now - (cd.lastCheck or 0) >= 1) then
					cd.dirty = false
					cd.lastCheck = now
					local status, start, duration = QueryEntryCooldown(cd)
					if status == "EXACT" then
						cd.secret = false
						cd.start = start
						cd.duration = duration
					elseif status == "SECRET" then
						cd.secret = true
					else
						--cooldown finished or reset
						local effectiveDuration = cd.duration
						if not effectiveDuration then
							effectiveDuration = now - (cd.startEst or now)
							local minCD = doomdb.graceperiod
							if effectiveDuration <= minCD then
								local baseSec = ElvUI_EltreumUI:EltruismSpellBaseCooldown(cd.spellID)
								if baseSec > minCD then
									effectiveDuration = baseSec
								end
							end
						end
						if cd.texture and PassesDurationFilter(effectiveDuration) then
							local anim = AcquireTable()
							anim[1], anim[2], anim[3] = cd.texture, cd.isPet, cd.name
							tinsert(animating, anim)
						end
						cooldowns[i] = nil
						ReleaseTable(cd)
					end
				end
			end
			if cooldowns[i] and not cd.secret and cd.start and cd.duration then
				local remaining = cd.duration - (now - cd.start)
				if remaining <= 0 then
					if cd.texture and PassesDurationFilter(cd.duration) then
						local anim = AcquireTable()
						anim[1], anim[2], anim[3] = cd.texture, cd.isPet, cd.name
						tinsert(animating, anim)
					end
					cooldowns[i] = nil
					ReleaseTable(cd)
				end
			end
		end

		if (#animating == 0 and not next(watching) and not next(cooldowns)) then
			DCP_EventFrame:SetScript("OnUpdate", nil)
			return
		end
	end

	if (#animating > 0) and not IsInCinematicScene() then
		local fadeInTime = doomdb.fadeInTime
		local holdTime = doomdb.holdTime
		local fadeOutTime = doomdb.fadeOutTime
		local totalTime = fadeInTime + holdTime + fadeOutTime
		runtimer = runtimer + update
		if (runtimer > totalTime) then
			ReleaseTable(tremove(animating,1))
			runtimer = 0
			DCP.TextFrame:SetText(nil)
			DCPT:SetTexture(nil)
			if DCP.shadow then
				DCP.shadow:SetAlpha(0)
			end
			DCPT:SetVertexColor(1,1,1)
		else
			local currentAnim = animating[1]
			if (not DCPT:GetTexture()) then
				if (currentAnim[3] ~= nil and doomdb.showSpellName) then
					DCP.TextFrame:SetText(currentAnim[3])
				end
				if doomdb.tts and currentAnim[3] and E:NotSecretValue(currentAnim[3]) then
					if doomdb.ttsvoice ~= nil then
						C_VoiceChat.SpeakText(doomdb.ttsvoice, currentAnim[3], 1, doomdb.ttsvolume, true)
					end
				end
				DCPT:SetTexture(currentAnim[1])
				DCPT:SetTexCoord(0.08,0.92,0.08,0.92)
				if currentAnim[2] then
					DCPT:SetVertexColor(unpack(petOverlay))
				end
			end

			--weird dlarge issue with alpha
			local alpha, alphaHolder
			if doomdb.maxAlpha then
				alphaHolder = tonumber(doomdb.maxAlpha)
			else
				alphaHolder = 0.7
			end
			alpha = alphaHolder
			if (runtimer < fadeInTime) then
				alpha = alphaHolder * (runtimer / fadeInTime)
				if alpha < 0 then alpha = 0 end
				if alpha > 1 then alpha = 1 end
			elseif (runtimer >= fadeInTime + holdTime) then
				alpha = alphaHolder - ( alphaHolder * ((runtimer - holdTime - fadeInTime) / fadeOutTime))
				if alpha < 0 then alpha = 0 end
				if alpha > 1 then alpha = 1 end
			end
			DCP:SetAlpha(alpha)
			if DCP.shadow then
				DCP.shadow:SetAlpha(alpha)
			end
			local iconSize = doomdb.iconSize
			local scale = iconSize+(iconSize*((doomdb.animScale-1)*(runtimer/totalTime)))
			DCP:SetSize(scale, scale)
		end
	end
end

local function StartOnUpdate()
	if not DCP_EventFrame:GetScript("OnUpdate") then
		DCP_EventFrame:SetScript("OnUpdate", OnUpdate)
	end
end

-- preview function
function ElvUI_EltreumUI:PreviewDoom()
	if not E.Classic then
		DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Earthbind")
	else
		DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Cyclone")
	end

	DCPT:SetTexCoord(0.08,0.92,0.08,0.92)
	local db = E.db.ElvUI_EltreumUI.skins.doom
	local scale = db.iconSize+(db.iconSize*((db.animScale-1)))
	DCP:SetSize(scale, scale)

	if DCP:GetAlpha() == 0 then
		DCP:SetAlpha(1)
		if DCP.shadow then
			DCP.shadow:SetAlpha(1)
		end
	else
		DCP:SetAlpha(0)
		if DCP.shadow then
			DCP.shadow:SetAlpha(0)
		end
	end

	if DCP:GetAlpha() == 1 and db.ttsvoice ~= nil then
		local tts = ElvUI_EltreumUI:EltruismSpellInfo(33786) or ElvUI_EltreumUI:EltruismSpellInfo(5197)
		if tts then
			C_VoiceChat.SpeakText(db.ttsvoice, tts, 1, db.ttsvolume, true)
		end
	end

	wasPreviewing = true
end

--Includes portions from Doom Cooldown Pulse by discoteq (MIT License; see ElvUI_EltreumUI/Licenses/Doom Cooldown Pulse.txt). Eltruism modifications are All Rights Reserved.
function ElvUI_EltreumUI:Doom()
	if IsAddOnLoaded("Doom_CooldownPulse") then return end
	doomdb = E.db.ElvUI_EltreumUI.skins.doom
	if doomdb.enable then

		--set the general elvui font
		DCP.TextFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), doomdb.iconSize/5, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

		--create shadow
		if not DCP.shadow then
			ElvUI_EltreumUI:CreateFastShadow(DCP, E.db.ElvUI_EltreumUI.skins.shadow.length)
		end

		--load in the ignored/allowed spells
		wipe(listedSpells)
		if doomdb.ignoring then
			local list = {strsplit("," ,E.private.ElvUI_EltreumUI.doomignored)}
			for _,v in ipairs(list) do
				local trimmed = strtrim(v)
				if trimmed ~= "" then
					listedSpells[trimmed] = true
				end
			end
		elseif doomdb.allowing then
			local list = {strsplit("," ,E.private.ElvUI_EltreumUI.doomallowed)}
			for _,v in ipairs(list) do
				local trimmed = strtrim(v)
				if trimmed ~= "" then
					listedSpells[trimmed] = true
				end
			end
		end

		RefreshEquippedUsableItems()

		if E.Modern and doomdb.pet then
			DCP_EventFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player", "pet")
		else
			DCP_EventFrame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
		end

		if not E.Modern then
			if doomdb.pet then
				DCP_EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			else
				DCP_EventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			end
		end

		if not self.DoomInitialized then
			DCP_EventFrame:SetScript("OnEvent", function(selftable, event, ...) selftable[event](selftable, ...) end)

			function DCP_EventFrame:SPELL_UPDATE_COOLDOWN()
				if next(waitingEnableSpells) then
					local now = GetTime()
					for i, v in pairs(waitingEnableSpells) do
						if (now - v.castTime) > 300 then
							waitingEnableSpells[i] = nil
							ReleaseTable(v)
						else
							local status, start, duration = QueryEntryCooldown(v)
							if status ~= "DISABLED" then
								waitingEnableSpells[i] = nil
								if PromoteEntryToCooldown(i, v, status, start, duration) then
									StartOnUpdate()
								end
							end
						end
					end
				end
				if not next(cooldowns) then return end
				for _, cd in pairs(cooldowns) do
					cd.dirty = true
				end
			end
			DCP_EventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")

			function DCP_EventFrame:PET_BAR_UPDATE_COOLDOWN()
				if not next(cooldowns) then return end
				for _, cd in pairs(cooldowns) do
					if cd.isPet then
						cd.dirty = true
					end
				end
			end
			DCP_EventFrame:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")

			function DCP_EventFrame:PLAYER_EQUIPMENT_CHANGED()
				RefreshEquippedUsableItems()
			end
			DCP_EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

			function DCP_EventFrame:BAG_UPDATE_COOLDOWN()
				for _, cd in pairs(cooldowns) do
					if cd.cooldownType == "item" then
						cd.dirty = true
					end
				end
				if doomdb.allowing and not next(listedSpells) then return end
				--only scan cached slots that actually hold usable items (trinkets, engineering tinkers, etc.)
				for _, itemID in pairs(equippedUsableItems) do
					if not watching[itemID] and not cooldowns[itemID] then
						local status, start, duration = ElvUI_EltreumUI:EltruismItemCooldown(itemID)
						if (status == "EXACT" and duration > 1.5 and (GetTime() - start) < 1.5) or status == "SECRET" then
							local name, _, texture = ElvUI_EltreumUI:EltruismItemInfo(itemID, true)
							if name and texture and PassesFilter(itemID, nil, name) then
								local entry = AcquireTable()
								entry.castTime = GetTime()
								entry.cooldownType = "item"
								entry.id = itemID
								entry.texture = texture
								entry.infoResolved = false
								entry.overrideResolved = false
								entry.isPet = false
								watching[itemID] = entry
								StartOnUpdate()
							end
						end
					end
				end
			end
			DCP_EventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")

			function DCP_EventFrame:UNIT_SPELLCAST_SUCCEEDED(unit,_,spellID)
				if not spellID or not E:NotSecretValue(spellID) then return end
				if (unit == "player") then
					local entry = watching[spellID] or AcquireTable()
					entry.castTime = GetTime()
					entry.cooldownType = "spell"
					entry.id = spellID
					entry.spellID = spellID
					entry.infoResolved = false
					entry.overrideResolved = false
					entry.isPet = false
					watching[spellID] = entry
					StartOnUpdate()
				elseif (unit == "pet") and doomdb.pet then
					local name, _, texture = ElvUI_EltreumUI:EltruismSpellInfo(spellID)
					local index = ElvUI_EltreumUI:EltruismPetActionIndex(name)
					local entry = watching[spellID] or AcquireTable()
					entry.castTime = GetTime()
					entry.id = spellID
					entry.spellID = spellID
					entry.infoResolved = false
					entry.overrideResolved = false
					entry.isPet = true
					if index then
						entry.cooldownType = "pet"
						entry.petIndex = index
						entry.name = name
						entry.texture = texture
					else
						entry.cooldownType = "spell"
					end
					watching[spellID] = entry
					StartOnUpdate()
				end
			end

			function DCP_EventFrame:COMBAT_LOG_EVENT_UNFILTERED()
				local _,event,_,_,_,sourceFlags,_,_,_,_,_,spellID = CombatLogGetCurrentEventInfo()
				if (event == "SPELL_CAST_SUCCESS") then
					if (_G.bit.band(sourceFlags,_G.COMBATLOG_OBJECT_TYPE_PET) == _G.COMBATLOG_OBJECT_TYPE_PET and _G.bit.band(sourceFlags,_G.COMBATLOG_OBJECT_AFFILIATION_MINE) == _G.COMBATLOG_OBJECT_AFFILIATION_MINE) then
						local name = ElvUI_EltreumUI:EltruismSpellInfo(spellID)
						local index = ElvUI_EltreumUI:EltruismPetActionIndex(name)
						if index then
							local entry = watching[spellID] or AcquireTable()
							entry.castTime = GetTime()
							entry.cooldownType = "pet"
							entry.id = spellID
							entry.spellID = spellID
							entry.infoResolved = false
							entry.overrideResolved = false
							entry.petIndex = index
							entry.isPet = true
							watching[spellID] = entry
						elseif spellID then
							local entry = watching[spellID] or AcquireTable()
							entry.castTime = GetTime()
							entry.cooldownType = "spell"
							entry.id = spellID
							entry.spellID = spellID
							entry.infoResolved = false
							entry.overrideResolved = false
							entry.isPet = true
							watching[spellID] = entry
						else
							return
						end
						StartOnUpdate()
					end
				end
			end

			function DCP_EventFrame:PLAYER_ENTERING_WORLD()
				RefreshEquippedUsableItems()
				local inInstance,instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,nil,true)
				if (inInstance and instanceType == "arena") then
					self:SetScript("OnUpdate", nil)
					for k, v in pairs(cooldowns) do
						cooldowns[k] = nil
						ReleaseTable(v)
					end
					for k, v in pairs(watching) do
						watching[k] = nil
						ReleaseTable(v)
					end
					for k, v in pairs(waitingEnableSpells) do
						waitingEnableSpells[k] = nil
						ReleaseTable(v)
					end
					for i = #animating, 1, -1 do
						ReleaseTable(tremove(animating, i))
					end
				end
			end
			DCP_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

			self.DoomInitialized = true
		end

		if not self.DoomHooksRegistered then
			local function WatchItem(item, fallbackTexture)
				local _, itemID, texture = ElvUI_EltreumUI:EltruismItemInfo(item)
				if itemID then
					local entry = watching[itemID] or AcquireTable()
					entry.castTime = GetTime()
					entry.cooldownType = "item"
					entry.id = itemID
					entry.texture = texture or fallbackTexture
					entry.infoResolved = false
					entry.overrideResolved = false
					entry.isPet = false
					watching[itemID] = entry
					StartOnUpdate()
				end
			end

			hooksecurefunc("UseAction", function(slot)
				local actionType,itemID = GetActionInfo(slot)
				if (actionType == "item") then
					WatchItem(itemID, GetActionTexture(slot))
				elseif (actionType == "macro") then
					local _, macroItemLink = GetMacroItem(itemID)
					if macroItemLink then
						WatchItem(macroItemLink, GetActionTexture(slot))
					end
				end
			end)

			hooksecurefunc("UseInventoryItem", function(slot)
				local itemID = GetInventoryItemID("player", slot)
				if (itemID) then
					WatchItem(itemID, GetInventoryItemTexture("player", slot))
				end
			end)

			hooksecurefunc(C_Container, "UseContainerItem", function(bag,slot)
				local itemID = C_Container.GetContainerItemID(bag, slot)
				if (itemID) then
					WatchItem(itemID)
				end
			end)

			if C_Item.UseItemByName then
				hooksecurefunc(C_Item, "UseItemByName", function(item)
					WatchItem(item)
				end)
			elseif _G.UseItemByName then
				hooksecurefunc("UseItemByName", function(item)
					WatchItem(item)
				end)
			end

			hooksecurefunc("CastPetAction", function(index)
				if E.db.ElvUI_EltreumUI.skins.doom.pet and index then
					local name, texture, _, _, _, _, petSpellID = GetPetActionInfo(index)
					local safePetSpellID = (petSpellID and E:NotSecretValue(petSpellID)) and petSpellID or nil
					local key = safePetSpellID or ("pet"..index)
					local entry = watching[key] or AcquireTable()
					entry.castTime = GetTime()
					entry.cooldownType = "pet"
					entry.id = key
					entry.spellID = safePetSpellID
					entry.infoResolved = false
					entry.overrideResolved = false
					entry.petIndex = index
					entry.name = (name and E:NotSecretValue(name)) and name or nil
					entry.texture = texture
					entry.isPet = true
					watching[key] = entry
					StartOnUpdate()
				end
			end)

			self.DoomHooksRegistered = true
		end
	end
end
