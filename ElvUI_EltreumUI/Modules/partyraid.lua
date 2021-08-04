local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInGroup = _G.IsInGroup
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local IsAddOnLoaded = _G.IsAddOnLoaded
local GetRaidRosterInfo = _G.GetRaidRosterInfo

-- Conversion of the party/raid death weakaura into an addon option
local name = {}
local _
local deaththrottle
function ElvUI_EltreumUI:GroupRoster()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if IsInGroup() == true then
			for i=1, GetNumGroupMembers() do
				name[i], _, _, _, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
			end
			deaththrottle = 1
		elseif IsInGroup() == false then
			name = {}
			deaththrottle = 0
			--name = {E.myname}
		end
	end
end

function ElvUI_EltreumUI:RaidDeath()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		local _, eventType, _, _, _, _, _, _, destName, _, _ = CombatLogGetCurrentEventInfo()
		--if eventType ~= "UNIT_DIED" then
		--	return
		--elseif eventType == "UNIT_DIED"  and deaththrottle == 1 then
		if deaththrottle == 1 then
			for i=1,#name do
				if name[i] == destName then
					if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
						if E.db.ElvUI_EltreumUI.partyraiddeath.bruh then
							PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\bruh.ogg", "Master")
						end
						if E.db.ElvUI_EltreumUI.partyraiddeath.robloxoof then
							PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.ogg", "Master")
						end
						if E.db.ElvUI_EltreumUI.partyraiddeath.shame then
							PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\shame.ogg", "Master")
						end
						if E.db.ElvUI_EltreumUI.partyraiddeath.wow then
							PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wow.ogg", "Master")
						end
						if E.db.ElvUI_EltreumUI.partyraiddeath.mario then
							PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\mariodeath.ogg", "Master")
						end
						if E.db.ElvUI_EltreumUI.partyraiddeath.ion then
							PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\ionskillissue.ogg", "Master")
						end
					end
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
