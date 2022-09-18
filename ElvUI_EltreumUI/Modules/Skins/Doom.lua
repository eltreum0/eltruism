local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local strsplit = _G.strsplit
local ipairs = _G.ipairs
local hooksecurefunc = _G.hooksecurefunc
local pairs = _G.pairs
local setmetatable = _G.setmetatable
local GetPetActionInfo = _G.GetPetActionInfo
local GetTime = _G.GetTime
local tinsert = _G.tinsert
local tremove = _G.tremove
local unpack = _G.unpack
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellInfo = _G.GetSpellInfo
local GetSpellTexture = _G.GetSpellTexture
local GetItemCooldown = _G.GetItemCooldown
local GetItemInfo = _G.GetItemInfo
local GetPetActionCooldown = _G.GetPetActionCooldown
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local select = _G.select
local IsInInstance = _G.IsInInstance
local wipe = _G.wipe
local GetActionInfo = _G.GetActionInfo
local GetActionTexture = _G.GetActionTexture
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventoryItemTexture = _G.GetInventoryItemTexture
local GetContainerItemID = _G.GetContainerItemID
local wasPreviewing = false
local ignoredSpells
local cooldowns, animating, watching = { }, { }, { }
local petOverlay = {1,1,1}

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
	DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Earthbind")
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
	wasPreviewing = true
end

--Fork of discoteq's Doom Cooldown Pulse
function ElvUI_EltreumUI:Doom() --todo, setup options
	if E.db.ElvUI_EltreumUI.skins.doom.enable then

		--set the general elvui font
		DCP.TextFrame:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.ElvUI_EltreumUI.skins.doom.iconSize/5, E.db.general.fontStyle)

		--create shadow
		if not DCP.shadow then
			DCP:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
		end

		--load in the ignored spells
		ignoredSpells = { }
		local list = {strsplit("," ,E.private.ElvUI_EltreumUI.doomignored)}
		for _,v in ipairs(list) do
			ignoredSpells[v] = true
		end

		---set the main script
		DCP:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)

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
		local function OnUpdate(_,update) --todo: confirm this onupdate is good, afterall onupdate has a history of issues...
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
								local start, duration, enabled = GetSpellCooldown(v[3])
								return {
									name = GetSpellInfo(v[3]),
									texture = GetSpellTexture(v[3]),
									start = start,
									duration = duration,
									enabled = enabled
								}
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
						if ((ignoredSpells[cooldown.name] ~= nil)) then
							watching[i] = nil
						else
							if (cooldown.enabled ~= 0) then
								if (cooldown.duration and cooldown.duration > E.db.ElvUI_EltreumUI.skins.doom.graceperiod and cooldown.texture) then --controls grace period
									cooldowns[i] = getCooldownDetails
								end
							end
							if (not (cooldown.enabled == 0 and v[2] == "spell")) then
								watching[i] = nil
							end
						end
					end
				end
				for i,getCooldownDetails in pairs(cooldowns) do
					local cooldown = getCooldownDetails()
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

			if (#animating > 0) then
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
						if E.db.ElvUI_EltreumUI.skins.doom.tts then
							local tts = GetSpellInfo(animating[1][3])
							if E.db.ElvUI_EltreumUI.skins.doom.ttsvoice ~= nil and tts ~= nil then
								C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, tts, Enum.VoiceTtsDestination.LocalPlayback, 0, 100)
							end
						end
						DCPT:SetTexture(animating[1][1])
						DCPT:SetTexCoord(0.08,0.92,0.08,0.92)
						if animating[1][2] then
							DCPT:SetVertexColor(unpack(petOverlay))
						end
					end
					local alpha = E.db.ElvUI_EltreumUI.skins.doom.maxAlpha
					if (runtimer < E.db.ElvUI_EltreumUI.skins.doom.fadeInTime) then
						alpha = E.db.ElvUI_EltreumUI.skins.doom.maxAlpha * (runtimer / E.db.ElvUI_EltreumUI.skins.doom.fadeInTime)
					elseif (runtimer >= E.db.ElvUI_EltreumUI.skins.doom.fadeInTime + E.db.ElvUI_EltreumUI.skins.doom.holdTime) then
						alpha = E.db.ElvUI_EltreumUI.skins.doom.maxAlpha - ( E.db.ElvUI_EltreumUI.skins.doom.maxAlpha * ((runtimer - E.db.ElvUI_EltreumUI.skins.doom.holdTime - E.db.ElvUI_EltreumUI.skins.doom.fadeInTime) / E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime))
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

		function DCP:UNIT_SPELLCAST_SUCCEEDED(unit,lineID,spellID)
			if (unit == "player") then
				watching[spellID] = {GetTime(),"spell",spellID}
				if (not self:IsMouseEnabled()) then
					self:SetScript("OnUpdate", OnUpdate)
				end
			end
		end
		DCP:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

		function DCP:COMBAT_LOG_EVENT_UNFILTERED()
			local _,event,_,_,_,sourceFlags,_,_,_,_,_,spellID = CombatLogGetCurrentEventInfo()
			if (event == "SPELL_CAST_SUCCESS") then
				if (bit.band(sourceFlags,COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags,COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
					local name = GetSpellInfo(spellID)
					local index = GetPetActionIndexByName(name)
					if (index and not select(7,GetPetActionInfo(index))) then
						watching[spellID] = {GetTime(),"pet",index}
					elseif (not index and spellID) then
						watching[spellID] = {GetTime(),"spell",spellID}
					else
						return
					end
					if (not self:IsMouseEnabled()) then
						self:SetScript("OnUpdate", OnUpdate)
					end
				end
			end
		end
		DCP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

		function DCP:PLAYER_ENTERING_WORLD() --todo: investigate, why disable in arena? maybe make an option for it
			local inInstance,instanceType = IsInInstance()
			if (inInstance and instanceType == "arena") then
				self:SetScript("OnUpdate", nil)
				wipe(cooldowns)
				wipe(watching)
			end
		end
		DCP:RegisterEvent("PLAYER_ENTERING_WORLD")


		--todo: test these hooks and if they are needed
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
		hooksecurefunc("UseContainerItem", function(bag,slot)
			local itemID = GetContainerItemID(bag, slot)
			if (itemID) then
				local texture = select(10, GetItemInfo(itemID))
				watching[itemID] = {GetTime(),"item",texture}
			end
		end)
	end
end
