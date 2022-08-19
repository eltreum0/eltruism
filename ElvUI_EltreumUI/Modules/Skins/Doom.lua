local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local ignoredSpells, invertIgnored
local cooldowns, animating, watching = { }, { }, { }
local petOverlay = {1,1,1}
local GetTime = GetTime
local DCP = CreateFrame("FRAME","EltruismDoomCDPulse")
DCP.TextFrame = DCP:CreateFontString(nil, "ARTWORK")
DCP.TextFrame:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE")
DCP.TextFrame:SetShadowOffset(2,-2)
DCP.TextFrame:SetPoint("CENTER",DCP,"CENTER")
DCP.TextFrame:SetWidth(185)
DCP.TextFrame:SetJustifyH("CENTER")
DCP.TextFrame:SetTextColor(1,1,1)
DCP:SetPoint("CENTER",UIParent,"CENTER", 0, 250)
local DCPT = DCP:CreateTexture(nil,"BACKGROUND")
DCPT:SetAllPoints(DCP)


function ElvUI_EltreumUI:PreviewDoom()
	DCPT:SetTexture("Interface\\Icons\\Spell_Nature_Earthbind")
	DCPT:SetTexCoord(0.08,0.92,0.08,0.92)
	local scale = E.db.ElvUI_EltreumUI.skins.doom.iconSize+(E.db.ElvUI_EltreumUI.skins.doom.iconSize*((E.db.ElvUI_EltreumUI.skins.doom.animScale-1) ))
	DCP:SetWidth(scale)
	DCP:SetHeight(scale)

	if not DCP:IsVisible() then
		DCP:Show()
		DCP:SetAlpha(1)
	else
		DCP:Hide()
		DCP:SetAlpha(0)
	end
end


--Fork of Doom's Cooldown Pulse
function ElvUI_EltreumUI:Doom() --todo, setup options
	if E.db.ElvUI_EltreumUI.skins.doom.enable then

		ignoredSpells = { }  --todo: confirm ignore list is working once options are worked in
		local list = {strsplit("," ,E.private.ElvUI_EltreumUI.doomignored)}
		for _,v in ipairs(list) do
			ignoredSpells[v] = true
		end

		invertIgnored = false


		---create frames

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
			if not DCP:IsShown() then
				DCP:Show()
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
						if ((ignoredSpells[cooldown.name] ~= nil) ~= invertIgnored) then
							watching[i] = nil
						else
							if (cooldown.enabled ~= 0) then
								if (cooldown.duration and cooldown.duration > 2.0 and cooldown.texture) then
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
					DCPT:SetVertexColor(1,1,1)
				else
					if (not DCPT:GetTexture()) then
						if (animating[1][3] ~= nil and E.db.ElvUI_EltreumUI.skins.doom.showSpellName) then
							DCP.TextFrame:SetText(animating[1][3])
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
			for i,getCooldownDetails in pairs(cooldowns) do
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
			local itemID = GetInventoryItemID("player", slot);
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
