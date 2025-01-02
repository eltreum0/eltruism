local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local select = _G.select
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local IsInGroup = _G.IsInGroup
local PlaySoundFile = _G.PlaySoundFile
local GetInstanceInfo = _G.GetInstanceInfo
local GetSpellTexture = _G.C_Spell and _G.C_Spell.GetSpellTexture or _G.GetSpellTexture
local GetSpellCharges = _G.C_Spell and _G.C_Spell.GetSpellCharges or _G.GetSpellCharges
local InCombatLockdown = _G.InCombatLockdown
local _, instanceType
local DifficultyID
local ingroup
local difficultyok
local instanceok
local currentCharges, cooldownStart, cooldownDuration
local cooldown
local GetPartyAssignment = _G.GetPartyAssignment
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local hooksecurefunc = _G.hooksecurefunc
local LoggingCombat = _G.LoggingCombat
local UnitSetRole = _G.UnitSetRole
local bit = _G.bit
local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
local math = _G.math
local GetTime = _G.GetTime

--PlaySound(61850)
--PlaySound(61851)
--PlaySound(61852)
--PlaySound(61853)
--PlaySound(61854)

-- Conversion of the party/raid death weakaura into an addon option
local deaththrottle
function ElvUI_EltreumUI:RaidDeathGroupCheck()
	_, instanceType = IsInInstance()
	if E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable then
		if IsInGroup() then
			if E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.bgdisable then --to disable it in arena/bg
				if instanceType == "arena" or instanceType == "pvp" then
					ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
				else
					deaththrottle = 1
					ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
				end
			else
				deaththrottle = 1
				ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
			end
		elseif not IsInGroup() then
			deaththrottle = 0
			ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath() to not fire when not in a group
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
			if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
				if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 then
					PlaySoundFile(deathsound , "Master")
				end
			end
		end
	end
end

--bres
local bresframe = CreateFrame("Frame", "EltruismBattleResFrame")
local spellicon = bresframe:CreateTexture("EltruismBattleResFrameTexture")
spellicon:SetParent(bresframe)
spellicon:SetSize(30, 30)
spellicon:SetPoint("LEFT", bresframe)
local spellcount = bresframe:CreateFontString("EltruismBattleResFrameCount", "OVERLAY", "GameFontNormal")
spellcount:SetParent(bresframe)
spellcount:SetPoint("CENTER", spellicon)
spellcount:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
spellcount:SetTextColor(1, 1, 1)
local spellcd = bresframe:CreateFontString("EltruismBattleResText", "OVERLAY", "GameFontNormal")
spellcd:SetParent(bresframe)
spellcd:SetPoint("LEFT", spellicon, "RIGHT", 10, 0)
spellcd:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
spellcd:SetTextColor(1, 1, 1)
spellcd:SetText(READY)
bresframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 342, -28)
if E.Retail then
	E:CreateMover(bresframe, "MoverEltruismBRES", "EltruismBattleRes", nil, nil, nil, "ALL,PARTY,RAID,ELTREUMUI", nil, 'ElvUI_EltreumUI,party')
end
bresframe:SetParent(UIParent)
bresframe:SetAlpha(0)
--bresframe:RegisterEvent("PLAYER_REGEN_DISABLED")
bresframe:SetSize(97, 30)
S:HandleFrame(bresframe)

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

function ElvUI_EltreumUI:BattleRes()
	if E.Retail and E.db.ElvUI_EltreumUI.otherstuff.bres then
		_, instanceType = IsInInstance()
		DifficultyID = select(3, GetInstanceInfo())
		ingroup = IsInGroup()

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

		spellicon:SetTexture(GetSpellTexture(20484))
		if E.myclass == "DEATHKNIGHT" then
			spellicon:SetTexture(GetSpellTexture(61999))
		elseif E.myclass == "WARLOCK" then
			spellicon:SetTexture(GetSpellTexture(20707))
		elseif E.myclass == "PALADIN" then
			spellicon:SetTexture(GetSpellTexture(391054))
		end
		spellicon:SetTexCoord(0.08,0.92,0.08,0.92)

		if E.db.ElvUI_EltreumUI.skins.shadow.enable then
			if not bresframe.shadow then
				bresframe:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:ClearAllPoints()
				bresframe.shadow:SetPoint("BOTTOMLEFT", spellicon,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:SetPoint("BOTTOMRIGHT", bresframe,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:SetPoint("TOPLEFT", spellicon,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
				bresframe.shadow:SetPoint("TOPRIGHT", bresframe,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(bresframe.shadow)
			end
		end

		if ingroup and instanceok and difficultyok then
			bresframe:SetAlpha(1)
			bresframe:SetScript('OnUpdate', function(_, elapsed)
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0
					--currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(spellId or spellName)
					currentCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(20484)
					if currentCharges ~= nil and cooldownStart ~= nil and cooldownDuration ~= nil then
						bresframe:SetAlpha(1)
						cooldown = math.floor(cooldownDuration - (GetTime() - cooldownStart))
						if cooldown <= 0 then
							spellcd:SetText(READY)
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
			end)
		else
			bresframe:SetScript('OnUpdate', nil)
		end
	end
end

--set correct role for classic
local isTank, isHealer, isDPS = false,false,false
function ElvUI_EltreumUI:SetGroupRoleClassic()
	if E.Cata and not InCombatLockdown() then
		if UnitGroupRolesAssigned("player") == "DAMAGER" then
			isDPS = true
			isTank = false
			isHealer = false
		elseif UnitGroupRolesAssigned("player") == "TANK" then
			isTank = true
			isDPS = false
			isHealer = false
		elseif UnitGroupRolesAssigned("player") == "HEALER" then
			isHealer = true
			isTank = false
			isDPS = false
		end
		if E.myclass == 'WARLOCK' or E.myclass == 'MAGE' or E.myclass == 'HUNTER' or E.myclass == 'ROGUE' then
			if not isDPS then
				UnitSetRole("player","DAMAGER")
			end
		else
			local _, _, _, _, spent1 = _G.GetTalentTabInfo(1)
			local _, _, _, _, spent2 = _G.GetTalentTabInfo(2)
			local _, _, _, _, spent3 = _G.GetTalentTabInfo(3)
			--print(isDPS,isTank,isHealer,E.myclass,spent1,spent2,spent3)
			if E.myclass == 'SHAMAN' then
				if spent3 < spent1 and spent3 < spent2 then
					if not isDPS then
						UnitSetRole("player","DAMAGER")
					end
				elseif spent3 > spent1 and spent3 > spent2 then
					if not isHealer then
						UnitSetRole("player","HEALER")
					end
				end
			elseif E.myclass == 'PRIEST' then
				if spent1 > spent3 and spent2 > spent3 then
					if not isHealer then
						UnitSetRole("player","HEALER")
					end
				elseif spent3 > spent1 and spent3 > spent2 then
					if not isDPS then
						UnitSetRole("player","DAMAGER")
					end
				end
			elseif E.myclass == 'DRUID' then
				if spent3 > spent1 and spent3 > spent2 then
					if not isHealer then
						UnitSetRole("player","HEALER")
					end
				elseif spent1 > spent3 and spent1 > spent2 then
					if not isDPS then
						UnitSetRole("player","DAMAGER")
					end
				end
			elseif E.myclass == 'WARRIOR' then
				if spent3 > spent1 and spent3 > spent2 then
					if not isTank then
						UnitSetRole("player","TANK")
					end
				elseif spent3 < spent1 and spent3 < spent2 then
					if not isDPS then
						UnitSetRole("player","DAMAGER")
					end
				end
			elseif E.myclass == 'PALADIN' then
				if spent1 > spent3 and spent1 > spent2 then
					if not isHealer then
						UnitSetRole("player","HEALER")
					end
				elseif spent2 > spent1 and spent2 > spent3 then
					if not isTank then
						UnitSetRole("player","TANK")
					end
				elseif spent3 > spent1 and spent3 > spent2 then
					if not isDPS then
						UnitSetRole("player","DAMAGER")
					end
				end
			--[[elseif E.myclass == 'DEATHKNIGHT' then --only check for the blade barrier talent
				if select(5, GetTalentInfo(1, 21)) > 0 then
					if not isTank then
						UnitSetRole("player","TANK")
					end
				else
					if not isDPS then
						UnitSetRole("player","DAMAGER")
					end
				end]]
			end
		end
	end
end

local roleframe = CreateFrame("FRAME")
roleframe:RegisterEvent("GROUP_JOINED")
roleframe:RegisterEvent("GROUP_ROSTER_UPDATE")
roleframe:RegisterEvent("PLAYER_ENTERING_WORLD")
--roleframe:RegisterEvent("PLAYER_ROLES_ASSIGNED")
--roleframe:RegisterEvent("GROUP_LEFT")
roleframe:SetScript("OnEvent", function()
	if E.Cata then
		ElvUI_EltreumUI:SetGroupRoleClassic()
	else
		roleframe:UnregisterAllEvents()
	end
end)

--automatic combat logging
function ElvUI_EltreumUI:AutoCombatLog()
	if E.db.ElvUI_EltreumUI.cvars.combatlog then
		if not InCombatLockdown() then
			SetCVar("advancedCombatLogging", 1)
		end
		local _, instanceType2 = IsInInstance()
		if instanceType2 == "raid" or instanceType2 == "party" or instanceType2 == "scenario" then
			LoggingCombat(true)
			--ElvUI_EltreumUI:Print(COMBATLOGENABLED)
		else
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
function ElvUI_EltreumUI:LeaderIcon()
	if not E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericons and not E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticons and not E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericons then return end
	local anchor = self:GetParent()
	local frame = anchor and anchor:GetParent():GetParent()
	if not frame then return end
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericons and frame.LeaderIndicator then
		frame.LeaderIndicator:SetTexCoord(0,1,0,1)
		if E.db.ElvUI_EltreumUI.otherstuff.leadericonstype ~= "CUSTOM" then
			frame.LeaderIndicator:SetTexture('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Leader\\Leader'..E.db.ElvUI_EltreumUI.otherstuff.leadericonstype..'.tga')
		else
			frame.LeaderIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismleadericonscustom)
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticons and frame.AssistantIndicator then
		frame.AssistantIndicator:SetTexCoord(0,1,0,1)
		if E.db.ElvUI_EltreumUI.otherstuff.assisticonstype ~= "CUSTOM" then
			frame.AssistantIndicator:SetTexture('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Assist\\Assist'..E.db.ElvUI_EltreumUI.otherstuff.assisticonstype..'.tga')
		else
			frame.AssistantIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismassisticonscustom)
		end
	end
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericons and frame.MasterLooterIndicator then
		frame.MasterLooterIndicator:SetTexCoord(0,1,0,1)
		if E.db.ElvUI_EltreumUI.otherstuff.lootericonstype ~= "CUSTOM" then
			frame.MasterLooterIndicator:SetTexture('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\MasterLooter\\Looter'..E.db.ElvUI_EltreumUI.otherstuff.lootericonstype..'.tga')
		else
			frame.MasterLooterIndicator:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismlootericonscustom)
		end
	end
	if frame.RaidRoleIndicator then
		frame.RaidRoleIndicator:SetTexCoord(0,1,0,1)
		if(GetPartyAssignment('MAINTANK', frame.unit)) then
			frame.RaidRoleIndicator:SetTexture(ElvUI_EltreumUI:GetRoleIcon("TANK"))
			frame.RaidRoleIndicator:SetDesaturated(true)
		elseif(GetPartyAssignment('MAINASSIST', frame.unit)) then
			frame.RaidRoleIndicator:SetTexture('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Assist\\MainAssist1.tga')
		end
	end
end
hooksecurefunc(UF,"RaidRoleUpdate", ElvUI_EltreumUI.LeaderIcon)

--use new flipbook animation to recreate the blizzard resting animation
function ElvUI_EltreumUI:RestIcon(frame)
	if not frame then return end
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
			hooksecurefunc(frame.RestingIndicator, 'PostUpdate', function()
				if frame.RestingIndicator:IsShown() then
					_G["EltruismPlayerRestLoop"]:Show()
					_G["EltruismPlayerRestLoop"].PlayerRestLoopAnim:Play()
				else
					_G["EltruismPlayerRestLoop"]:Hide()
					_G["EltruismPlayerRestLoop"].PlayerRestLoopAnim:Stop()
				end
				if E.db.ElvUI_EltreumUI.unitframes.blizzardresticongradient then
					if not _G["EltruismPlayerRestLoopRestTexture"].Gradient then
						if (E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor) then
							_G["EltruismPlayerRestLoopRestTexture"]:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
						else
							_G["EltruismPlayerRestLoopRestTexture"]:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(E.myclass))
						end
						_G["EltruismPlayerRestLoopRestTexture"].Gradient = true
					end
				else
					local r,g,b,a = frame.RestingIndicator:GetVertexColor()
					_G["EltruismPlayerRestLoopRestTexture"]:SetVertexColor(r,g,b,a)
				end
			end)

			frame.RestingIndicator.EltruismHook = true
		end
		frame.RestingIndicator:SetTexture()
		_G["EltruismPlayerRestLoop"]:SetScale(E.db.unitframe.units.player.RestIcon.size/10)
	end
end
hooksecurefunc(UF,"Configure_RestingIndicator", ElvUI_EltreumUI.RestIcon)
