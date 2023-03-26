local E, L, V, P, G = unpack(ElvUI)
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
		if IsInGroup() == true then
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
		elseif IsInGroup() == false then
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
			end
		end

		--if ingroup == true and (instanceType == 'raid' or instanceType == 'party') and (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16) then
		if ingroup == true and instanceok == true and difficultyok == true then
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
		local _, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then
			LoggingCombat(true)
			--ElvUI_EltreumUI:Print(COMBATLOGENABLED)
		else
			LoggingCombat(false)
			--ElvUI_EltreumUI:Print(COMBATLOGDISABLED)
		end
	end
end


function ElvUI_EltreumUI:GetRoleIcon(role)
		if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" then
			if role == "TANK" then
				return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga'
			elseif role == "HEALER" then
				return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga'
			elseif role == "DAMAGER" then
				return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga'
			end
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
			if role == "TANK" then
				return [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank
			elseif role == "HEALER" then
				return [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer
			elseif role == "DAMAGER" then
				return [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps
			end
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
			if role == "TANK" then
				return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga'
			elseif role == "HEALER" then
				return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga'
			elseif role == "DAMAGER" then
				return 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga'
			end
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga', sizeString),
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga', sizeString),
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga', sizeString),
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga', sizeString),
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
			local roleIcons = {
				TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga', sizeString),
				HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga', sizeString),
				DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga', sizeString),
			}
		end
end
