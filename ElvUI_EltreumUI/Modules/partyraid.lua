local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local IsInGroup = _G.IsInGroup
local IsAddOnLoaded = _G.IsAddOnLoaded

-- Conversion of the party/raid death weakaura into an addon option
local deaththrottle
function ElvUI_EltreumUI:RaidDeathGroupCheck()
	local _, instanceType = IsInInstance()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if IsInGroup() == true then
			if E.db.ElvUI_EltreumUI.partyraiddeath.bgdisable then  --to disable it in arena/bg
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
if ElvUI_EltreumUI.Retail then
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
