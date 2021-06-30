local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInGroup = _G.IsInGroup
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local IsAddOnLoaded = _G.IsAddOnLoaded
local GetRaidRosterInfo = _G.GetRaidRosterInfo

function ElvUI_EltreumUI:PartyRaidInit()
	ElvUI_EltreumUI:ChatRoleSwapIcons() --icons on role swap
end

-- Conversion of the party/raid death weakaura into an addon option
local name
function ElvUI_EltreumUI:GroupRoster()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
			for ii=1, GetNumGroupMembers() do
				name = GetRaidRosterInfo(ii)
			end
		if not IsInGroup() then
			name = name
		end
	end
end

function ElvUI_EltreumUI:RaidDeath()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		local _, eventType, _, _, _, _, _, _, destName, _, _ = CombatLogGetCurrentEventInfo()
		if eventType == "UNIT_DIED" then
			if destName == name then
				if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
					if E.db.ElvUI_EltreumUI.partyraiddeath.bruh then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\bruh.mp3", "Master")
					end
					if E.db.ElvUI_EltreumUI.partyraiddeath.robloxoof then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.mp3", "Master")
					end
					if E.db.ElvUI_EltreumUI.partyraiddeath.shame then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\shame.mp3", "Master")
					end
					if E.db.ElvUI_EltreumUI.partyraiddeath.wow then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wow.mp3", "Master")
					end
					if E.db.ElvUI_EltreumUI.partyraiddeath.mario then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\mariodeath.mp3", "Master")
					end
					if E.db.ElvUI_EltreumUI.partyraiddeath.ion then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\ionskillissue.mp3", "Master")
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
			TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga"
		}
	end
end

--icons in chat when party member swaps roles
function ElvUI_EltreumUI:ChatRoleSwapIcons()
	local sizeString = ":12:12"
	local roleIcons = {
		TANK = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga', sizeString),
		HEALER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga', sizeString),
		DAMAGER = E:TextureString('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga', sizeString),
	}
	_G.INLINE_TANK_ICON = roleIcons.TANK
	_G.INLINE_HEALER_ICON = roleIcons.HEALER
	_G.INLINE_DAMAGER_ICON = roleIcons.DAMAGER
end
