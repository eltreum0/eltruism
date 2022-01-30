local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInGroup = _G.IsInGroup
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local IsAddOnLoaded = _G.IsAddOnLoaded
local GetRaidRosterInfo = _G.GetRaidRosterInfo

-- Conversion of the party/raid death weakaura into an addon option
--local name = {}
local _, deaththrottle
function ElvUI_EltreumUI:GroupRoster()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if IsInGroup() == true then
			deaththrottle = 1
			ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
			--for i=1, GetNumGroupMembers() do
				--name[i], _, _, _, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
			--end
		elseif IsInGroup() == false then
			--wipe(name)-- = {}
			deaththrottle = 0
			ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath() to not fire when not in a group
		end
	end
end

local deathsound
function ElvUI_EltreumUI:DeathSound()
	if E.db.ElvUI_EltreumUI.partyraiddeath.bruh then
		deathsound = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\bruh.ogg"
	end
	if E.db.ElvUI_EltreumUI.partyraiddeath.robloxoof then
		deathsound = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.ogg"
	end
	if E.db.ElvUI_EltreumUI.partyraiddeath.shame then
		deathsound = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\shame.ogg"
	end
	if E.db.ElvUI_EltreumUI.partyraiddeath.wow then
		deathsound = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wow.ogg"
	end
	if E.db.ElvUI_EltreumUI.partyraiddeath.mario then
		deathsound = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\mariodeath.ogg"
	end
	if E.db.ElvUI_EltreumUI.partyraiddeath.ion then
		deathsound = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\ionskillissue.ogg"
	end
end

function ElvUI_EltreumUI:RaidDeath(destFlags)
	--print(destFlags.. "destflag")
	-- 1298 destflag party
	--1297 destflag raid
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if deaththrottle == 1 then
			--local _, eventType, _, _, _, _, _, _, destName, _, _ = CombatLogGetCurrentEventInfo()
			--local _, eventType, _, _, _, 	sourceFlags, raidFlags, GUID, destName, _, _ = CombatLogGetCurrentEventInfo()

			--if destFlags == 1298 or destFlags == 1297 then
				--local c = bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID)  --(2 for party) (0 for raid)
				--print(c.." raid affiliation")

				if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
					if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 then
						PlaySoundFile(deathsound, "Master")
						print("working!")
					end
				end
			--end

			--if eventType ~= "UNIT_DIED" then
			--	return
			--elseif eventType == "UNIT_DIED" then
				--for i=1,#name do
					--if name[i] == destName then
						--bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0



						--local flag1, flag2 = CombatLog_Object_IsA(destFlags, filter)
						--print(flag1)
						--print(flag2)
						--[[
						local a = bit.band(destFlags, 0x00000400)  --(1024)
						local b = bit.band(destFlags, 0x00000004)  --(0 for party AND raid)
						local c = bit.band(destFlags, 0x00000002)  --(2 for party) (0 for raid)
						print(a)
						print(b)
						print(c)
						if bit.band(destFlags, 0x00000400) == 1024 then
							if ( bit.band(destFlags, 0x00000004) ~= 0) or (bit.band(destFlags, 0x00000002) == 2) then
								PlaySoundFile(deathsound, "Master")
							end
						end
						]]
						--local a = bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER)  --(1024)
						--local b = bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID)  --(0 for party AND raid)
						--local c = bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY)  --(2 for party) (0 for raid)
						--print(a)
						--print(b)
						--print(c)




				--end
			--end
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
