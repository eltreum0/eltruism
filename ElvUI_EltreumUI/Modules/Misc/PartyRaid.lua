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
local GetSpellTexture = _G.GetSpellTexture
local GetSpellCharges = _G.GetSpellCharges
local InCombatLockdown = _G.InCombatLockdown
local _, instanceType
local DifficultyID
local ingroup
local difficultyok
local instanceok
local currentCharges, cooldownStart, cooldownDuration
local cooldown
local GetPartyAssignment = _G.GetPartyAssignment

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
local bresframe = CreateFrame("Frame")
local spellicon = bresframe:CreateTexture()
local spellcount = bresframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local spellcd = bresframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
bresframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 342, -28)
if E.Retail then
	E:CreateMover(bresframe, "MoverEltruismBRES", "EltruismBattleRes", nil, nil, nil, "ALL,PARTY,RAID,ELTREUMUI", nil, 'ElvUI_EltreumUI,partyraidsettings')
end
bresframe:SetParent(UIParent)
bresframe:SetAlpha(0)
--bresframe:RegisterEvent("PLAYER_REGEN_DISABLED")
bresframe:SetSize(97, 30)
S:HandleFrame(bresframe)

local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 1
function ElvUI_EltreumUI:BattleRes()
	if E.Retail and E.db.ElvUI_EltreumUI.otherstuff.bres then
		_, instanceType = IsInInstance()
		DifficultyID = select(3, GetInstanceInfo())
		ingroup = IsInGroup()
		if (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16) then
			difficultyok = true
		end
		if instanceType == 'raid' or instanceType == 'party' then
			instanceok = true
		end

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

		--if ingroup and (instanceType == 'raid' or instanceType == 'party') and (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16) then
		if ingroup and instanceok and difficultyok then
			bresframe:SetAlpha(1)
			spellicon:SetSize(30, 30)
			spellicon:SetPoint("LEFT", bresframe)
			spellicon:SetTexture(GetSpellTexture(20484))
			if E.myclass == "DEATHKNIGHT" then
				spellicon:SetTexture(GetSpellTexture(61999))
			elseif E.myclass == "WARLOCK" then
				spellicon:SetTexture(GetSpellTexture(20707))
			elseif E.myclass == "PALADIN" then
				spellicon:SetTexture(GetSpellTexture(391054))
			end
			spellicon:SetTexCoord(0.08,0.92,0.08,0.92)

			spellcount:SetParent(bresframe)
			spellcount:SetPoint("CENTER", spellicon)
			spellcount:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, E.db.general.fontStyle)
			spellcount:SetTextColor(1, 1, 1)

			spellcd:SetParent(bresframe)
			spellcd:SetPoint("LEFT", spellicon, "RIGHT", 10, 0)
			spellcd:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, E.db.general.fontStyle)
			spellcd:SetTextColor(1, 1, 1)
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

--set correct role for wrath
function ElvUI_EltreumUI:SetGroupRoleWrath()
	if E.Wrath and IsInGroup() and not InCombatLockdown() then
		local _, _, spent1 = _G.GetTalentTabInfo(1)
		local _, _, spent2 = _G.GetTalentTabInfo(2)
		local _, _, spent3 = _G.GetTalentTabInfo(3)

		if E.myclass == 'WARLOCK' or E.myclass == 'MAGE' or E.myclass == 'HUNTER' or E.myclass == 'ROGUE' then
			SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
		else
			if E.myclass == 'SHAMAN' then
				if spent3 < spent1 and spent3 < spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
				elseif spent3 > spent1 and spent3 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"HEALER")
				end
			elseif E.myclass == 'PRIEST' then
				if spent3 < spent1 and spent3 < spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"HEALER")
				elseif spent3 > spent1 and spent3 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
				end
			elseif E.myclass == 'DRUID' then
				if spent3 > spent1 and spent3 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"HEALER")
				elseif spent1 > spent3 and spent1 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
				end
			elseif E.myclass == 'WARRIOR' then
				if spent3 > spent1 and spent3 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"TANK")
				elseif spent3 < spent1 and spent3 < spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
				end
			elseif E.myclass == 'PALADIN' then
				if spent1 > spent3 and spent1 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"HEALER")
				elseif spent2 > spent1 and spent2 > spent3 then
					SetTalentGroupRole(GetActiveTalentGroup(),"TANK")
				elseif spent3 > spent1 and spent3 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
				end
			--[[elseif E.myclass == 'DEATHKNIGHT' then --too many variables since dk doesnt even need specific talents and just needs gear
				if spent3 > spent1 and spent3 > spent2 then
					SetTalentGroupRole(GetActiveTalentGroup(),"DAMAGER")
				end]]
			end
		end
	end
end

local roleframe = CreateFrame("FRAME")
roleframe:RegisterEvent("GROUP_JOINED")
roleframe:RegisterEvent("GROUP_ROSTER_UPDATE")
roleframe:RegisterEvent("PLAYER_ENTERING_WORLD")
roleframe:SetScript("OnEvent", function()
	if E.Wrath then
		ElvUI_EltreumUI:SetGroupRoleWrath()
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
			--_G["EltruismPlayerRestLoop"]:SetParent(frame)
			_G["EltruismPlayerRestLoop"]:SetPoint("CENTER", frame.RestingIndicator, "CENTER", 0, 0)
			_G["EltruismPlayerRestLoop"]:SetFrameStrata('MEDIUM')
			_G["EltruismPlayerRestLoop"]:SetScale(E.db.unitframe.units.player.RestIcon.size/15)
			hooksecurefunc(frame.RestingIndicator, 'PostUpdate', function()
				if frame.RestingIndicator:IsShown() then
					_G["EltruismPlayerRestLoop"]:Show()
					_G["EltruismPlayerRestLoop"].PlayerRestLoopAnim:Play()
				else
					_G["EltruismPlayerRestLoop"]:Hide()
					_G["EltruismPlayerRestLoop"].PlayerRestLoopAnim:Stop()
				end
				--_G["EltruismPlayerRestLoopRestTexture"]:SetDesaturated(true)
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

			--basically if i use SetParent the game crashes, have to hook the alpha and set it on the frame instead
			hooksecurefunc(frame,'SetAlpha', function(_,alpha)
				_G["EltruismPlayerRestLoop"]:SetAlpha(alpha)
			end)

			--hook afk to hide it while afk, needs a delay
			if _G.ElvUIAFKFrame then
				_G.ElvUIAFKFrame:HookScript("OnShow", function()
					E:Delay(0.05, function()
						_G["EltruismPlayerRestLoop"]:SetAlpha(0)
					end)
				end)
				_G.ElvUIAFKFrame:HookScript("OnHide", function()
					E:Delay(0.05, function()
						if IsResting() and _G["ElvUF_Player"] and _G["ElvUF_Player"]:GetAlpha() == 1 then
							_G["EltruismPlayerRestLoop"]:SetAlpha(1)
						end
					end)
				end)
			end

			frame.RestingIndicator.EltruismHook = true
		end
		frame.RestingIndicator:SetTexture()
		_G["EltruismPlayerRestLoop"]:SetScale(E.db.unitframe.units.player.RestIcon.size/15)
	end
end
hooksecurefunc(UF,"Configure_RestingIndicator", ElvUI_EltreumUI.RestIcon)

--LFG Spec Icons, based on https://wago.io/cFpgwuLe0
function ElvUI_EltreumUI:DungeonRoleIcons()
	if E.db.ElvUI_EltreumUI.skins.groupfinderSpecIcons then
		local role_order = _G.LFG_LIST_GROUP_DATA_ROLE_ORDER
		local class_order = _G.LFG_LIST_GROUP_DATA_CLASS_ORDER
		local raidClassColors = _G.RAID_CLASS_COLORS

		local roleIndex = {}
		local classIndex = {}

		for i=1, #role_order do
			roleIndex[role_order[i]] = i
		end

		for i=1, #class_order do
			classIndex[class_order[i]] = i
		end

		--C_LFGList.GetSearchResultMemberInfo returns a localized name for the spec, which would fail in other languages, so get the localized name and icon for the spec before running
		local GetSpecializationInfoForClassID = _G.GetSpecializationInfoForClassID
		local iconTable = {}
		for classID = 1, 13 do --13 classes in retail
			if GetClassInfo(classID) then --nil check for classic
				local className = select(2, GetClassInfo(classID))
				iconTable[className] = {}
				for i = 1, 4 do --druids have 4 in retail
					--local id, name, description, icon, role, isRecommended, isAllowed  = GetSpecializationInfoForClassID(classID, specIndex)
					local _, name, _, icon = GetSpecializationInfoForClassID(classID, i)
					if name and icon then --nil check for classic
						iconTable[className][name] = icon
					end
				end
			end
		end

		local function SearchEntry_Update(entry)
			if not _G.LFGListFrame.SearchPanel:IsShown() then return end
			local resultInfo = C_LFGList.GetSearchResultInfo(entry.resultID)
			local activityTable = C_LFGList.GetActivityInfoTable(resultInfo.activityID)
			local categoryID = activityTable.categoryID

			-- reset textures
			for i = 1, 5 do
				if entry.DataDisplay.Enumerate[i] then
					entry.DataDisplay.Enumerate[i]:Hide()
					entry.DataDisplay.Enumerate[i.."b"]:Hide()
				end
			end

			--only in dungeon or arena listings
			if categoryID == 2 or categoryID == 4 or categoryID == 7 then
				local maxNumPlayers = activityTable.maxNumPlayers
				local numMembers = resultInfo.numMembers
				local partymembers = {}

				for i=1, numMembers do
					local role, class, _, specLocalized = C_LFGList.GetSearchResultMemberInfo(entry.resultID, i)
					local icon = iconTable[class][specLocalized]
					partymembers[#partymembers+1] = {roleIndex[role], classIndex[class], raidClassColors[class],icon}
				end

				if categoryID == 2 then --sort dungeon members
					table.sort(partymembers, function(a,b)
						if a[1] ~= b[1] then
							return a[1] < b[1]
						else
							return a[2] < b[2]
						end
					end)
				else
					table.sort(partymembers, function(a,b)
						return a[2] < b[2]
					end)
				end

				entry.DataDisplay:SetPoint("RIGHT", entry.DataDisplay:GetParent(), "RIGHT", 0, -5)

				for i = 1, numMembers do
					if not entry.DataDisplay.Enumerate[i] then
						entry.DataDisplay.Enumerate[i] = entry.DataDisplay:CreateTexture(nil, "BORDER")
						entry.DataDisplay.Enumerate[i]:SetSize(17, 17)
						entry.DataDisplay.Enumerate[i.."b"] = entry.DataDisplay:CreateTexture(nil, "BACKGROUND")
						entry.DataDisplay.Enumerate[i.."b"]:SetSize(20, 20)
					end

					entry.DataDisplay.Enumerate[i]:SetPoint("RIGHT", entry.DataDisplay.Enumerate, "RIGHT", -13 - 21*(maxNumPlayers-i), -1)
					entry.DataDisplay.Enumerate[i]:Show()
					entry.DataDisplay.Enumerate[i]:SetTexture(partymembers[i][4])
					entry.DataDisplay.Enumerate[i]:SetTexCoord(0.08,0.92,0.08,0.92)

					local r, g, b, _ = partymembers[i][3]:GetRGBA()
					entry.DataDisplay.Enumerate[i.."b"]:SetPoint("CENTER", entry.DataDisplay.Enumerate[i], "CENTER", 0, 0)
					entry.DataDisplay.Enumerate[i.."b"]:Show()
					entry.DataDisplay.Enumerate[i.."b"]:SetColorTexture(r, g, b, 0.75)
					entry.DataDisplay.Enumerate:Hide()
				end
			end
		end
		hooksecurefunc("LFGListSearchEntry_Update", SearchEntry_Update)
	end
end

--fix taint by replacing the function with the same function https://github.com/0xbs/premade-groups-filter/issues/64#issuecomment-1001230231
local function LFMPlus_GetPlaystyleString(playstyle,activityInfo)
	if activityInfo and playstyle ~= (0 or nil) and C_LFGList.GetLfgCategoryInfo(activityInfo.categoryID).showPlaystyleDropdown then
		local typeStr
		if activityInfo.isMythicPlusActivity then
			typeStr = "GROUP_FINDER_PVE_PLAYSTYLE"
		elseif activityInfo.isRatedPvpActivity then
			typeStr = "GROUP_FINDER_PVP_PLAYSTYLE"
		elseif activityInfo.isCurrentRaidActivity then
			typeStr = "GROUP_FINDER_PVE_RAID_PLAYSTYLE"
		elseif activityInfo.isMythicActivity then
			typeStr = "GROUP_FINDER_PVE_MYTHICZERO_PLAYSTYLE"
		end

		return typeStr and _G[typeStr .. tostring(playstyle)] or nil
	else
		return nil
	end
end

C_LFGList.GetPlaystyleString = function(playstyle,activityInfo)
	return LFMPlus_GetPlaystyleString(playstyle, activityInfo)
end
