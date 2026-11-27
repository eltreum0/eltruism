local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local select = _G.select
local CreateFrame = _G.CreateFrame
local IsInGroup = _G.IsInGroup
local PlaySoundFile = _G.PlaySoundFile
local GetInstanceInfo = _G.GetInstanceInfo
local GetSpellTexture = _G.C_Spell and _G.C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetSpellCharges = _G.C_Spell and _G.C_Spell.GetSpellCharges or _G.GetSpellCharges
local InCombatLockdown = _G.InCombatLockdown
local GetPartyAssignment = _G.GetPartyAssignment
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local hooksecurefunc = _G.hooksecurefunc
local ipairs = _G.ipairs
local pairs = _G.pairs
local LoggingCombat = _G.LoggingCombat
--local UnitSetRole = _G.UnitSetRole
local bit = _G.bit
--local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
local math = _G.math
local GetTime = _G.GetTime
local COMBATLOG_OBJECT_TYPE_PLAYER = _G.COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_AFFILIATION_PARTY = _G.COMBATLOG_OBJECT_AFFILIATION_PARTY
local COMBATLOG_OBJECT_AFFILIATION_RAID = _G.COMBATLOG_OBJECT_AFFILIATION_RAID
local type = _G.type

--PlaySound(61850)
--PlaySound(61851)
--PlaySound(61852)
--PlaySound(61853)
--PlaySound(61854)

-- Conversion of the party/raid death weakaura into an addon option
local deaththrottle
function ElvUI_EltreumUI:RaidDeathGroupCheck()
	local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
	if E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable then
		if IsInGroup() then
			if E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.bgdisable then --to disable it in arena/bg
				if instanceType == "arena" or instanceType == "pvp" then
					if E.Modern then
						ElvUI_EltreumUI:UnregisterEvent('UNIT_DIED')
					else
						ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
					end
				else
					deaththrottle = 1
					if E.Modern then
						ElvUI_EltreumUI:RegisterEvent('UNIT_DIED')
					else
						ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
					end
				end
			else
				deaththrottle = 1
				if E.Modern then
					ElvUI_EltreumUI:RegisterEvent('UNIT_DIED')
				else
					ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
				end
			end
		elseif not IsInGroup() then
			deaththrottle = 0
			if E.Modern then
				ElvUI_EltreumUI:UnregisterEvent('UNIT_DIED')
			else
				ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath() to not fire when not in a group
			end
		end
	end
end

local deathsound
function ElvUI_EltreumUI:DeathSound()
	deathsound = E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.playerdeathsound)
end

function ElvUI_EltreumUI:RaidDeath(destFlags)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable then
		if deaththrottle == 1 then
			if E.Modern then
				PlaySoundFile(deathsound , "Master")
			else
				if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
					if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 then
						PlaySoundFile(deathsound , "Master")
					end
				end
			end
		end
	end
end

--bres
local bresframe, spellicon, spellcount, spellcd
local function CreateBattleResFrame()
	bresframe = CreateFrame("Frame", "EltruismBattleResFrame")
	spellicon = bresframe:CreateTexture("EltruismBattleResFrameTexture")
	spellicon:SetParent(bresframe)
	spellicon:SetSize(30, 30)
	spellicon:SetPoint("LEFT", bresframe)
	spellcount = bresframe:CreateFontString("EltruismBattleResFrameCount", "OVERLAY", "GameFontNormal")
	spellcount:SetParent(bresframe)
	spellcount:SetPoint("CENTER", spellicon)
	spellcount:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	spellcount:SetTextColor(1, 1, 1)
	spellcd = bresframe:CreateFontString("EltruismBattleResText", "OVERLAY", "GameFontNormal")
	spellcd:SetParent(bresframe)
	spellcd:SetPoint("LEFT", spellicon, "RIGHT", 10, 0)
	spellcd:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	spellcd:SetTextColor(1, 1, 1)
	spellcd:SetText(_G.READY)
	bresframe:SetPoint("TOPLEFT", E.UIParent, "TOPLEFT", 342, -28)
	if E.Modern then
		E:CreateMover(bresframe, "MoverEltruismBRES", "EltruismBattleRes", nil, nil, nil, "ALL,PARTY,RAID,ELTREUMUI", nil, 'ElvUI_EltreumUI,party')
	end
	bresframe:SetParent(E.UIParent)
	bresframe:SetAlpha(0)
	--bresframe:RegisterEvent("PLAYER_REGEN_DISABLED")
	bresframe:SetSize(97, 30)
	S:HandleFrame(bresframe)
end

local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 1

local workingIDs = {
	[3] = true, --10man
	[4] = true, --25 man
	[5] = true, --10man heroic
	[6] = true, --25man heroic
	[7] = true, --lfr (before soo)
	[8] = true, --m+
	[9] = true, --40man
	[14] = true, --normal
	[15] = true, --heroic
	[16] = true, --mythic
	[17] = true, --lfr
	[148] = true, --heroic (warfront)
	[151] = true, --lfr (timewalking)
	[173] = true, --normal (classic)
	[174] = true, --heroic (classic)
	[175] = true, --10man (classic)
	[176] = true, --25man (classic)
}
local difficultyok = false
local instanceok = false

function ElvUI_EltreumUI:BattleResOnUpdate(elapsed)
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
		TimeSinceLastUpdate = 0
		--currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(spellId or spellName)
		local currentCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(20484)
		if currentCharges ~= nil and cooldownStart ~= nil and cooldownDuration ~= nil then
			bresframe:SetAlpha(1)
			local cooldown = math.floor(cooldownDuration - (GetTime() - cooldownStart))
			if cooldown <= 0 then
				spellcd:SetText(_G.READY)
			else
				if cooldown > 60 then
					--from https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/LFGList.lua#L2551, https://www.wowinterface.com/forums/showthread.php?t=36884
					spellcd:SetFormattedText("%d:%.2d", cooldown/60, cooldown%60)
				elseif cooldown < 60 then
					spellcd:SetText(cooldown)
				end
			end
			spellcount:SetText(currentCharges)
			if currentCharges == 0 then
				spellcount:SetTextColor(1, 0, 0)
				spellicon:SetDesaturated(true)
			else
				spellcount:SetTextColor(1, 1, 1)
				spellicon:SetDesaturated(false)
			end
		elseif currentCharges == nil then
			bresframe:SetAlpha(0)
			--spellcd:SetText(READY)
			--spellicon:SetDesaturated(true)
		end
	end
end

function ElvUI_EltreumUI:BattleRes()
	if E.Modern and E.db.ElvUI_EltreumUI.otherstuff.bres then
		if not bresframe then CreateBattleResFrame() end
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
		local DifficultyID = select(3, GetInstanceInfo())

		if workingIDs[DifficultyID] then
			difficultyok = true
		else
			difficultyok = false
		end
		if instanceType == 'raid' or instanceType == 'party' then
			instanceok = true
		else
			instanceok = false
		end

		if E.myclass == "DEATHKNIGHT" then
			spellicon:SetTexture(GetSpellTexture(61999))
		elseif E.myclass == "WARLOCK" then
			spellicon:SetTexture(GetSpellTexture(20707))
		elseif E.myclass == "PALADIN" then
			spellicon:SetTexture(GetSpellTexture(391054))
		else
			spellicon:SetTexture(GetSpellTexture(20484))
		end
		spellicon:SetTexCoord(0.08,0.92,0.08,0.92)

		if E.db.ElvUI_EltreumUI.skins.shadow.enable then
			if not bresframe.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
				ElvUI_EltreumUI:CreateFastShadow(bresframe, E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:ClearAllPoints()
				bresframe.shadow:SetPoint("BOTTOMLEFT", spellicon,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:SetPoint("BOTTOMRIGHT", bresframe,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:SetPoint("TOPLEFT", spellicon,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:SetPoint("TOPRIGHT", bresframe,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
			end
		end

		if IsInGroup() and instanceok and difficultyok then
			bresframe:SetAlpha(1)
			bresframe:SetScript('OnUpdate', ElvUI_EltreumUI.BattleResOnUpdate)
		else
			bresframe:SetScript('OnUpdate', nil)
		end
	end
end

--automatic combat logging
function ElvUI_EltreumUI:AutoCombatLog()
	if E.db.ElvUI_EltreumUI.cvars.combatlog then
		local instanceType = ElvUI_EltreumUI:IsInInstance(nil,nil,nil,true)
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then
			if not InCombatLockdown() then
				SetCVar("advancedCombatLogging", 1)
			end
			LoggingCombat(true)
			--ElvUI_EltreumUI:Print(COMBATLOGENABLED)
		else
			if not InCombatLockdown() then
				SetCVar("advancedCombatLogging", 0)
			end
			LoggingCombat(false)
			--ElvUI_EltreumUI:Print(COMBATLOGDISABLED)
		end
	end
end

--returns role icons to blizzard raids
function ElvUI_EltreumUI:GetRoleIcon(role)
	if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
		if role == "TANK" then
			return [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank
		elseif role == "HEALER" then
			return [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer
		elseif role == "DAMAGER" then
			return [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps
		end
	else
		if role == "TANK" then
			return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\'..E.db.ElvUI_EltreumUI.otherstuff.roleiconstype..'\\Tank.tga'
		elseif role == "HEALER" then
			return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\'..E.db.ElvUI_EltreumUI.otherstuff.roleiconstype..'\\Healer.tga'
		elseif role == "DAMAGER" then
			return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\'..E.db.ElvUI_EltreumUI.otherstuff.roleiconstype..'\\DPS.tga'
		end
	end
end

--replace the leader/assist/master looter icons in frames
local UF = E:GetModule('UnitFrames')
local function HasRoleIndicator(frame)
	return type(frame) == "table" and (frame.LeaderIndicator or frame.AssistantIndicator or frame.MasterLooterIndicator or frame.RaidRoleIndicator)
end

--accept either the unitframe or the indicator widget (from PostUpdate / SetTexture / UF hooks)
local function ResolveLeaderFrame(arg1, arg2)
	for i = 1, 2 do
		local obj = (i == 1) and arg1 or arg2
		if type(obj) == "table" then
			if HasRoleIndicator(obj) then
				return obj
			end
			if HasRoleIndicator(obj.__owner) then
				return obj.__owner, obj
			end
			local parent = obj.GetParent and obj:GetParent()
			for _ = 1, 3 do
				if not parent then break end
				if HasRoleIndicator(parent) then
					return parent, obj
				end
				parent = parent.GetParent and parent:GetParent()
			end
		end
	end
end

local function SetIndicatorTexture(indicator, icontype, prefix, custompath)
	if indicator.EltruismUpdating then return end --avoid re-triggering our SetTexture hook
	indicator.EltruismUpdating = true
	if icontype ~= "CUSTOM" then
		indicator:SetTexture(prefix..(icontype or "1")..'.tga')
	else
		indicator:SetTexture([[Interface\AddOns\]]..(custompath or ""))
	end
	indicator:SetTexCoord(0,1,0,1)
	indicator.EltruismUpdating = false
end

local function OnIndicatorTextureChanged(indicator, value)
	if value and value ~= "" and not indicator.EltruismUpdating then
		ElvUI_EltreumUI:LeaderIcon(indicator)
	end
end

local function OnIndicatorPostUpdate(indicator)
	if not indicator.EltruismUpdating then
		ElvUI_EltreumUI:LeaderIcon(indicator)
	end
end

--hook the texture itself so ElvUI/oUF cannot overwrite it via cached callbacks
local function HookRoleIndicator(indicator)
	if not indicator or indicator.EltruismHook then return end
	indicator.EltruismHook = true
	if indicator.SetTexture then
		hooksecurefunc(indicator, "SetTexture", OnIndicatorTextureChanged)
	end
	if indicator.SetAtlas then
		hooksecurefunc(indicator, "SetAtlas", OnIndicatorTextureChanged)
	end
	if indicator.PostUpdate and indicator.PostUpdate ~= UF.RaidRoleUpdate then
		hooksecurefunc(indicator, "PostUpdate", OnIndicatorPostUpdate)
	end
end

local function UpdateRoleIndicator(frame, indicator)
	if not indicator then return end
	if indicator == frame.LeaderIndicator then
		if E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericons then
			SetIndicatorTexture(indicator, E.db.ElvUI_EltreumUI.otherstuff.leadericonstype, 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Leader\\Leader', E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericonscustom)
			HookRoleIndicator(indicator)
		end
	elseif indicator == frame.AssistantIndicator then
		if E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticons then
			SetIndicatorTexture(indicator, E.db.ElvUI_EltreumUI.otherstuff.assisticonstype, 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Assist\\Assist', E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticonscustom)
			HookRoleIndicator(indicator)
		end
	elseif indicator == frame.MasterLooterIndicator then
		if E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericons then
			SetIndicatorTexture(indicator, E.db.ElvUI_EltreumUI.otherstuff.lootericonstype, 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\MasterLooter\\Looter', E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericonscustom)
			HookRoleIndicator(indicator)
		end
	elseif indicator == frame.RaidRoleIndicator and not indicator.EltruismUpdating then
		local unit = frame.__unit or frame.unit
		if unit and E:NotSecretValue(unit) then
			local isTank = GetPartyAssignment('MAINTANK', unit)
			local isAssist = GetPartyAssignment('MAINASSIST', unit)
			if E:NotSecretValue(isTank) and isTank then
				indicator.EltruismUpdating = true
				indicator:SetTexture(ElvUI_EltreumUI:GetRoleIcon("TANK"))
				indicator:SetTexCoord(0,1,0,1)
				indicator:SetDesaturated(true)
				indicator.EltruismUpdating = false
			elseif E:NotSecretValue(isAssist) and isAssist then
				indicator.EltruismUpdating = true
				indicator:SetTexture('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Assist\\MainAssist1.tga')
				indicator:SetTexCoord(0,1,0,1)
				indicator.EltruismUpdating = false
			end
		end
		HookRoleIndicator(indicator)
	end
end

function ElvUI_EltreumUI:LeaderIcon(arg1, arg2)
	if not E.db or not E.db.ElvUI_EltreumUI or not E.db.ElvUI_EltreumUI.otherstuff then return end
	if not E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericons and not E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticons and not E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericons then return end
	local frame, indicator = ResolveLeaderFrame(arg1, arg2)
	if not frame then return end
	if indicator then
		UpdateRoleIndicator(frame, indicator)
	else
		UpdateRoleIndicator(frame, frame.LeaderIndicator)
		UpdateRoleIndicator(frame, frame.AssistantIndicator)
		UpdateRoleIndicator(frame, frame.MasterLooterIndicator)
		UpdateRoleIndicator(frame, frame.RaidRoleIndicator)
	end
end

local function SkinHeaderChildren(...)
	for i = 1, select('#', ...) do
		local frame = select(i, ...)
		if HasRoleIndicator(frame) then
			ElvUI_EltreumUI:LeaderIcon(frame)
		end
	end
end

local function CheckHeaderChildren(header)
	if header and header.GetChildren then
		SkinHeaderChildren(header:GetChildren())
	end
end

--skin already-created frames (needed when ElvUI finishes initializing before EltreumUI loads)
function ElvUI_EltreumUI:UpdateAllLeaderIcons()
	if not E.db or not E.db.ElvUI_EltreumUI or not E.db.ElvUI_EltreumUI.otherstuff then return end
	if not E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericons and not E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticons and not E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericons then return end
	if _G["ElvUF_Player"] then
		ElvUI_EltreumUI:LeaderIcon(_G["ElvUF_Player"])
	end
	if _G["ElvUF_Target"] then
		ElvUI_EltreumUI:LeaderIcon(_G["ElvUF_Target"])
	end
	CheckHeaderChildren(_G["ElvUF_Party"])
	CheckHeaderChildren(_G["ElvUF_PartyGroup1"])
	for raid = 1, 3 do
		if _G["ElvUF_Raid"..raid] then
			for group = 1, 8 do
				CheckHeaderChildren(_G["ElvUF_Raid"..raid.."Group"..group])
			end
		end
	end
	if _G["ElvUF_TankUnitButton1"] then
		for i = 1, 8 do
			if _G["ElvUF_TankUnitButton"..i] then
				ElvUI_EltreumUI:LeaderIcon(_G["ElvUF_TankUnitButton"..i])
			end
		end
	end
	if _G["ElvUF_AssistUnitButton1"] then
		for i = 1, 8 do
			if _G["ElvUF_AssistUnitButton"..i] then
				ElvUI_EltreumUI:LeaderIcon(_G["ElvUF_AssistUnitButton"..i])
			end
		end
	end
	if type(UF.units) == "table" then
		for _, frame in pairs(UF.units) do
			if HasRoleIndicator(frame) then
				ElvUI_EltreumUI:LeaderIcon(frame)
			end
		end
	end
end

local function OnLeaderHook(arg1, arg2)
	ElvUI_EltreumUI:LeaderIcon(arg1, arg2)
end

local function OnGroupConfigHook()
	ElvUI_EltreumUI:UpdateAllLeaderIcons()
end

--use hooksecurefunc instead of AceHook SecureHook so shared UF hooks in other modules do not collide
local leaderFuncs = {
	"RaidRoleUpdate",
	"Configure_RaidRoleIcon",
	"Configure_RaidRoleIcons",
	"Construct_RaidRoleFrames",
	"Update_RaidRole",
	"Update_PartyFrames",
	"Update_RaidFrames",
}
for _, method in ipairs(leaderFuncs) do
	if UF[method] then
		hooksecurefunc(UF, method, OnLeaderHook)
	end
end
local groupFuncs = {
	"ToggleForceShowGroupFrames",
	"HeaderConfig",
}
for _, method in ipairs(groupFuncs) do
	if UF[method] then
		hooksecurefunc(UF, method, OnGroupConfigHook)
	end
end

local function OnRestingIndicatorPostUpdate(restingIndicator)
	local restLoop = _G["EltruismPlayerRestLoop"]
	if not restLoop then return end
	if restingIndicator:IsShown() then
		restLoop:Show()
		restLoop.PlayerRestLoopAnim:Play()
	else
		restLoop:Hide()
		restLoop.PlayerRestLoopAnim:Stop()
	end
	if E.db.ElvUI_EltreumUI.unitframes.blizzardresticongradient then
		if (E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor) then
			_G["EltruismPlayerRestLoopRestTexture"]:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
		else
			_G["EltruismPlayerRestLoopRestTexture"]:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
		end
	else
		local r,g,b,a = restingIndicator:GetVertexColor()
		_G["EltruismPlayerRestLoopRestTexture"]:SetVertexColor(r,g,b,a)
	end
end

--use new flipbook animation to recreate the blizzard resting animation
function ElvUI_EltreumUI:RestIcon(_, frame)
	if not frame or type(frame) ~= "table" then return end
	if frame.RestingIndicator and E.db.unitframe.units.player.enable and E.db.unitframe.units.player.RestIcon.enable and E.db.ElvUI_EltreumUI.unitframes.blizzardresticon then
		if not frame.RestingIndicator.EltruismHook then
			if not _G["EltruismPlayerRestLoop"] then
				local EltruismPlayerRestLoop = CreateFrame("FRAME","EltruismPlayerRestLoop")
				EltruismPlayerRestLoop:SetSize(20,20)
				EltruismPlayerRestLoop.RestTexture = EltruismPlayerRestLoop:CreateTexture("EltruismPlayerRestLoopRestTexture", "ARTWORK")
				EltruismPlayerRestLoop.RestTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Rest\\UIUnitFrameRestingFlipBook.tga")
				EltruismPlayerRestLoop.RestTexture:SetSize(512, 512)
				EltruismPlayerRestLoop.RestTexture:SetAllPoints(EltruismPlayerRestLoop)
				EltruismPlayerRestLoop.RestTexture:SetParentKey("EltruismPlayerRestLoopFlipBook")
				EltruismPlayerRestLoop.PlayerRestLoopAnim = EltruismPlayerRestLoop:CreateAnimationGroup()
				EltruismPlayerRestLoop.PlayerRestLoopAnim:SetLooping("REPEAT")
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook = EltruismPlayerRestLoop.PlayerRestLoopAnim:CreateAnimation("FlipBook")
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetFlipBookColumns(6)
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetFlipBookRows(7)
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetFlipBookFrames(42)
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetFlipBookFrameHeight(60)
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetFlipBookFrameWidth(60)
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetChildKey("EltruismPlayerRestLoopFlipBook")
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetOrder(1)
				EltruismPlayerRestLoop.PlayerRestLoopFlipBook:SetDuration(1.5)
			end

			_G["EltruismPlayerRestLoop"]:ClearAllPoints()
			_G["EltruismPlayerRestLoop"]:SetParent(frame) --this can crash the game, and also show/hide calls can (during cinematic) --seems fixed now
			_G["EltruismPlayerRestLoop"]:SetPoint("CENTER", frame.RestingIndicator, "CENTER", 0, 0)
			--_G["EltruismPlayerRestLoop"]:SetFrameStrata('HIGH')
			_G["EltruismPlayerRestLoop"]:SetFrameLevel(frame:GetFrameLevel()+50)
			_G["EltruismPlayerRestLoop"]:SetScale(E.db.unitframe.units.player.RestIcon.size/10)
			hooksecurefunc(frame.RestingIndicator, 'PostUpdate', OnRestingIndicatorPostUpdate)

			frame.RestingIndicator.EltruismHook = true
		end
		frame.RestingIndicator:SetTexture()
		_G["EltruismPlayerRestLoop"]:SetScale(E.db.unitframe.units.player.RestIcon.size/10)
	end
end
ElvUI_EltreumUI:SecureHook(UF,"Configure_RestingIndicator", "RestIcon")
