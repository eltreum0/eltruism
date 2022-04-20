local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')

--PlaySound(61850)
--PlaySound(61851)
--PlaySound(61852)
--PlaySound(61853)
--PlaySound(61854)

-- Conversion of the party/raid death weakaura into an addon option
local deaththrottle
function ElvUI_EltreumUI:RaidDeathGroupCheck()
	local _, instanceType = IsInInstance()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if IsInGroup() == true then
			if E.db.ElvUI_EltreumUI.partyraiddeath.bgdisable then --to disable it in arena/bg
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
	deathsound = E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.partyraiddeath.playerdeathsound)
end

function ElvUI_EltreumUI:RaidDeath(destFlags)
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if deaththrottle == 1 then
			if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
				if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 then
					PlaySoundFile(deathsound , "Master")
				end
			end
		end
	end
end

-- Role icons, ty a lot Darth Predator for the help!
if E.Retail then
	if IsAddOnLoaded("ElvUI_SLE") then
		local SLE = unpack(ElvUI_SLE)
		SLE.rolePaths["Eltruism"] = {
			TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
		}
	else
		local UF = E:GetModule('UnitFrames')
			UF.RoleIconTextures = {
			TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
		}
	end
end

--bres
local bresframe = CreateFrame("Frame")
local spellicon = bresframe:CreateTexture()
local spellcount = bresframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local spellcd = bresframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
bresframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 342, -28)
if E.Retail then
	E:CreateMover(bresframe, "MoverEltruismBRES", "EltruismBattleRes", nil, nil, nil, "ALL,PARTY,RAID")
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
		local _, instanceType = IsInInstance()
		local DifficultyID = select(3, GetInstanceInfo())
		local ingroup = IsInGroup()

		local difficultyok
		if (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16 or DifficultyID == 7 or DifficultyID == 17) then
			difficultyok = true
		end
		local instanceok
		if instanceType == 'raid' or instanceType == 'party' then
			instanceok = true
		end

		--if ingroup == true and (instanceType == 'raid' or instanceType == 'party') and (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16) then
		if ingroup == true and instanceok == true and difficultyok == true then
			bresframe:SetAlpha(1)
			spellicon:SetSize(30, 30)
			spellicon:SetPoint("LEFT", bresframe)
			spellicon:SetTexture(GetSpellTexture(20484))
			if E.myclass == "DEATHKNIGHT" then
				spellicon:SetTexture(GetSpellTexture(61999))
			elseif E.myclas == "WARLOCK" then
				spellicon:SetTexture(GetSpellTexture(20707))
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
						--spellcd:SetText(_G.READY)
						--spellicon:SetDesaturated(true)
					end
				end
			end)
		else
			bresframe:SetScript('OnUpdate', nil)
		end
	end
end
