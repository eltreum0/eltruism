local E, L = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local strsplit = _G.strsplit
local ipairs = _G.ipairs
local tonumber = _G.tonumber
local hooksecurefunc = _G.hooksecurefunc
local pairs = _G.pairs
local setmetatable = _G.setmetatable
local GetPetActionInfo = _G.GetPetActionInfo
local GetTime = _G.GetTime
local tinsert = _G.tinsert
local tremove = _G.tremove
local unpack = _G.unpack
local GetSpellCooldown = _G.C_Spell and _G.C_Spell.GetSpellCooldown or _G.GetSpellCooldown
local GetSpellInfo = _G.C_Spell and _G.C_Spell.GetSpellInfo or _G.GetSpellInfo
local GetItemCooldown = _G.C_Container.GetItemCooldown or _G.C_Item and _G.C_Item.GetItemCooldown
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local GetPetActionCooldown = _G.GetPetActionCooldown
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local select = _G.select
local IsInInstance = _G.IsInInstance
local wipe = _G.wipe
local GetActionInfo = _G.GetActionInfo
local GetActionTexture = _G.GetActionTexture
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local wasPreviewing = false
local listedSpells
local cooldowns, animating, watching = { }, { }, { }
local petOverlay = {1,1,1}
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local C_VoiceChat = _G.C_VoiceChat

--createframes
local DCP = CreateFrame("FRAME","EltruismDoomCDPulse")
DCP:SetPoint("CENTER",UIParent,"CENTER", 0, 350)
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

-- preview function
function ElvUI_EltreumUI:PreviewDoom()
	if not E.Classic then
		DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Earthbind")
	else
		DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Cyclone")
	end

	DCPT:SetTexCoord(0.08,0.92,0.08,0.92)
	local scale = E.db.ElvUI_EltreumUI.skins.doom.iconSize+(E.db.ElvUI_EltreumUI.skins.doom.iconSize*((E.db.ElvUI_EltreumUI.skins.doom.animScale-1)))
	DCP:SetWidth(scale)
	DCP:SetHeight(scale)

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

	if DCP:GetAlpha() == 1 and E.db.ElvUI_EltreumUI.skins.doom.ttsvoice ~= nil then
		local tts = GetSpellInfo(33786)
		C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, tts.name, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.skins.doom.ttsvolume)
	end

	wasPreviewing = true
end

--Fork of discoteq's Doom Cooldown Pulse
function ElvUI_EltreumUI:Doom()
	if IsAddOnLoaded("Doom_CooldownPulse") then return end
	if E.db.ElvUI_EltreumUI.skins.doom.enable then

		--set the general elvui font
		DCP.TextFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.doom.iconSize/5, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

		--create shadow
		if not DCP.shadow then
			DCP:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(DCP.shadow)
		end

		--load in the ignored spells
		listedSpells = {}
		if E.db.ElvUI_EltreumUI.skins.doom.ignoring then
			local list = {strsplit("," ,E.private.ElvUI_EltreumUI.doomignored)}
			for _,v in ipairs(list) do
				listedSpells[v] = true
			end
		elseif E.db.ElvUI_EltreumUI.skins.doom.allowing then
			local list = {strsplit("," ,E.private.ElvUI_EltreumUI.doomallowed)}
			for _,v in ipairs(list) do
				listedSpells[v] = true
			end
		end

		---set the main script
		DCP:SetScript("OnEvent", function(selftable, event, ...) selftable[event](selftable, ...) end)

		-----------------------
		-- Utility Functions --
		-----------------------
		local function tcount(tab)
			local n = 0
			for _ in pairs(tab) do
				n = n + 1
			end
			return n
		end

		local function memorize(f)
			local cache = nil
			local memorized = {}

			local function get()
				if (cache == nil) then
					cache = f()
				end

				return cache
			end

			memorized.resetCache = function()
				cache = nil
			end

			setmetatable(memorized, {__call = get})

			return memorized
		end

		local function GetPetActionIndexByName(name)
			for i=1, NUM_PET_ACTION_SLOTS, 1 do
				if (GetPetActionInfo(i) == name) then
					return i
				end
			end
			return nil
		end

		--------------------------
		-- Cooldown / Animation --
		--------------------------
		local elapsed = 0
		local runtimer = 0
		local function OnUpdate(_,update)
			elapsed = elapsed + update
			if wasPreviewing then
				wasPreviewing = false
				DCPT:SetTexture(nil)
				DCP.shadow:SetAlpha(0)
			end

			if (elapsed > 0.05) then
				elapsed = 0
				for i,v in pairs(watching) do
					if (GetTime() >= v[1] + 0.5) then
						local getCooldownDetails
						if (v[2] == "spell") then
							getCooldownDetails = memorize(function()
								if E.Retail then
									local cooldowntable = GetSpellCooldown(v[3])
									local spelltable = GetSpellInfo(v[3])
									return {
										name = spelltable.name,
										texture = spelltable.iconID,
										start = cooldowntable.startTime,
										duration = cooldowntable.duration,
										enabled = cooldowntable.isEnabled
									}
								else
									local start, duration, enabled = GetSpellCooldown(v[3])
									local spelltable = GetSpellInfo(v[3])
									return {
										name = spelltable.name,
										texture = spelltable.iconID,
										start = start,
										duration = duration,
										enabled = enabled
									}
								end
							end)
						elseif (v[2] == "item") then
							getCooldownDetails = memorize(function()
								local start, duration, enabled = GetItemCooldown(i)
								return {
									name = GetItemInfo(i),
									texture = v[3],
									start = start,
									duration = duration,
									enabled = enabled
								}
							end)
						elseif (v[2] == "pet") then
							getCooldownDetails = memorize(function()
								local name, texture = GetPetActionInfo(v[3])
								local start, duration, enabled = GetPetActionCooldown(v[3])
								return {
									name = name,
									texture = texture,
									isPet = true,
									start = start,
									duration = duration,
									enabled = enabled
								}
							end)
						end

						local cooldown = getCooldownDetails()
						if E.db.ElvUI_EltreumUI.skins.doom.allowing then
							if not listedSpells[tostring(i)] then
								watching[i] = nil
							else
								if (cooldown.enabled ~= 0) then
									if E.db.ElvUI_EltreumUI.skins.doom.gracelimit ~= 0 then
										if cooldown.duration and cooldown.texture then
											if (cooldown.duration > E.db.ElvUI_EltreumUI.skins.doom.graceperiod) and (cooldown.duration <= E.db.ElvUI_EltreumUI.skins.doom.gracelimit) then --controls grace period
												cooldowns[i] = getCooldownDetails
											end
										end
									else
										if (cooldown.duration and cooldown.duration > E.db.ElvUI_EltreumUI.skins.doom.graceperiod and cooldown.texture) then --controls grace period
											cooldowns[i] = getCooldownDetails
										end
									end
								end
								if (not (cooldown.enabled == 0 and v[2] == "spell")) then
									watching[i] = nil
								end
							end
						elseif E.db.ElvUI_EltreumUI.skins.doom.ignoring then
							if listedSpells[tostring(i)] then
								watching[i] = nil
							else
								if (cooldown.enabled ~= 0) then
									if E.db.ElvUI_EltreumUI.skins.doom.gracelimit ~= 0 then
										if cooldown.duration and cooldown.texture then
											if (cooldown.duration > E.db.ElvUI_EltreumUI.skins.doom.graceperiod) and (cooldown.duration <= E.db.ElvUI_EltreumUI.skins.doom.gracelimit) then --controls grace period
												cooldowns[i] = getCooldownDetails
											end
										end
									else
										if (cooldown.duration and cooldown.duration > E.db.ElvUI_EltreumUI.skins.doom.graceperiod and cooldown.texture) then --controls grace period
											cooldowns[i] = getCooldownDetails
										end
									end
								end
								if (not (cooldown.enabled == 0 and v[2] == "spell")) then
									watching[i] = nil
								end
							end
						end
					end
				end
				for i,getCooldownDetails in pairs(cooldowns) do
					local cooldown = getCooldownDetails()
					if not cooldown.start then return end
					local remaining = cooldown.duration-(GetTime()-cooldown.start)
					if (remaining <= 0) then
						tinsert(animating, {cooldown.texture,cooldown.isPet,cooldown.name})
						cooldowns[i] = nil
					end
				end
				if (#animating == 0 and tcount(watching) == 0 and tcount(cooldowns) == 0) then
					DCP:SetScript("OnUpdate", nil)
					return
				end
			end

			if (#animating > 0) and not IsInCinematicScene() then
				runtimer = runtimer + update
				if (runtimer > (E.db.ElvUI_EltreumUI.skins.doom.fadeInTime + E.db.ElvUI_EltreumUI.skins.doom.holdTime + E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime)) then
					tremove(animating,1)
					runtimer = 0
					DCP.TextFrame:SetText(nil)
					DCPT:SetTexture(nil)
					DCP.shadow:SetAlpha(0)
					DCPT:SetVertexColor(1,1,1)
				else
					if (not DCPT:GetTexture()) then
						if (animating[1][3] ~= nil and E.db.ElvUI_EltreumUI.skins.doom.showSpellName) then
							DCP.TextFrame:SetText(animating[1][3])
						end
						if E.db.ElvUI_EltreumUI.skins.doom.tts and animating[1][3] then --and animating[1][3] ~= nil then
							if E.Cata then --cata on 29/10/2024 seems to not have fully migrated like classic era
								if E.db.ElvUI_EltreumUI.skins.doom.ttsvoice ~= nil then
									C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, animating[1][3], Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.skins.doom.ttsvolume)
								end
							else
								local tts = GetSpellInfo(animating[1][3])
								if E.db.ElvUI_EltreumUI.skins.doom.ttsvoice ~= nil and tts ~= nil then
									C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, tts.name, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.skins.doom.ttsvolume)
								end
							end
						end
						DCPT:SetTexture(animating[1][1])
						DCPT:SetTexCoord(0.08,0.92,0.08,0.92)
						if animating[1][2] then
							DCPT:SetVertexColor(unpack(petOverlay))
						end
					end

					--weird dlarge issue with alpha
					local alpha, alphaHolder
					if E.db.ElvUI_EltreumUI.skins.doom.maxAlpha then
						alphaHolder = tonumber(E.db.ElvUI_EltreumUI.skins.doom.maxAlpha)
					else
						alphaHolder = 0.7
					end
					alpha = alphaHolder
					if (runtimer < E.db.ElvUI_EltreumUI.skins.doom.fadeInTime) then
						alpha = alphaHolder * (runtimer / E.db.ElvUI_EltreumUI.skins.doom.fadeInTime)
						if alpha < 0 then alpha = 0 end
						if alpha > 1 then alpha = 1 end
					elseif (runtimer >= E.db.ElvUI_EltreumUI.skins.doom.fadeInTime + E.db.ElvUI_EltreumUI.skins.doom.holdTime) then
						alpha = alphaHolder - ( alphaHolder * ((runtimer - E.db.ElvUI_EltreumUI.skins.doom.holdTime - E.db.ElvUI_EltreumUI.skins.doom.fadeInTime) / E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime))
						if alpha < 0 then alpha = 0 end
						if alpha > 1 then alpha = 1 end
					end
					DCP:SetAlpha(alpha)
					DCP.shadow:SetAlpha(alpha)
					local scale = E.db.ElvUI_EltreumUI.skins.doom.iconSize+(E.db.ElvUI_EltreumUI.skins.doom.iconSize*((E.db.ElvUI_EltreumUI.skins.doom.animScale-1)*(runtimer/(E.db.ElvUI_EltreumUI.skins.doom.fadeInTime+E.db.ElvUI_EltreumUI.skins.doom.holdTime+E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime))))
					DCP:SetWidth(scale)
					DCP:SetHeight(scale)
				end
			end
		end

		--------------------
		-- Event Handlers --
		--------------------

		function DCP:SPELL_UPDATE_COOLDOWN()
			for _, getCooldownDetails in pairs(cooldowns) do
				getCooldownDetails.resetCache()
			end
		end
		DCP:RegisterEvent("SPELL_UPDATE_COOLDOWN")

		function DCP:UNIT_SPELLCAST_SUCCEEDED(unit,_,spellID)
			if (unit == "player") then
				watching[spellID] = {GetTime(),"spell",spellID}
				self:SetScript("OnUpdate", OnUpdate)
			end
		end
		DCP:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")

		function DCP:COMBAT_LOG_EVENT_UNFILTERED()
			local _,event,_,_,_,sourceFlags,_,_,_,_,_,spellID = CombatLogGetCurrentEventInfo()
			if (event == "SPELL_CAST_SUCCESS") then
				if (bit.band(sourceFlags,COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags,COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
					local name
					local spelltable = GetSpellInfo(spellID)
					name = spelltable.name
					local index = GetPetActionIndexByName(name)
					if index then
						watching[spellID] = {GetTime(),"pet",index}
					elseif spellID then
						watching[spellID] = {GetTime(),"spell",spellID}
					else
						return
					end
					self:SetScript("OnUpdate", OnUpdate)
				end
			end
		end
		if E.db.ElvUI_EltreumUI.skins.doom.pet then
			DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end

		function DCP:PLAYER_ENTERING_WORLD() --todo: maybe make an option for it in arena
			local inInstance,instanceType = IsInInstance()
			if (inInstance and instanceType == "arena") then
				self:SetScript("OnUpdate", nil)
				wipe(cooldowns)
				wipe(watching)
			end
		end
		DCP:RegisterEvent("PLAYER_ENTERING_WORLD")

		hooksecurefunc("UseAction", function(slot)
			local actionType,itemID = GetActionInfo(slot)
			if (actionType == "item") then
				local texture = GetActionTexture(slot)
				watching[itemID] = {GetTime(),"item",texture}
			end
		end)

		hooksecurefunc("UseInventoryItem", function(slot)
			local itemID = GetInventoryItemID("player", slot)
			if (itemID) then
				local texture = GetInventoryItemTexture("player", slot)
				watching[itemID] = {GetTime(),"item",texture}
			end
		end)

		hooksecurefunc(C_Container, "UseContainerItem", function(bag,slot)
			local itemID = C_Container.GetContainerItemID(bag, slot)

			if (itemID) then
				local texture = select(10, GetItemInfo(itemID))
				watching[itemID] = {GetTime(),"item",texture}
			end
		end)
	end
end
