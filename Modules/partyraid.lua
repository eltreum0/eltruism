local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local format = _G.format
local hooksecurefunc = _G.hooksecurefunc
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInGroup = _G.IsInGroup
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
local IsInRaid = _G.IsInRaid
local UnitExists = _G.UnitExists
local UnitIsUnit = _G.UnitIsUnit
local UnitName = _G.UnitName
local UF = E:GetModule("UnitFrames")
local CH = E:GetModule('Chat')

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
	local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)
	SLE.rolePaths["Eltruism"] = {
		TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga",
		HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga",
		DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga"
	}
end

--[[
--unitframe role icons
function ElvUI_EltreumUI:RoleIcons()
		if ElvUI_EltreumUI.Retail then
	UF.RoleIconTextures = {
	      	TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga"
	    }
	UF.RoleIconTextures = UF.RoleIconTextures
	end
end
hooksecurefunc(UF, "UpdateRoleIcon", ElvUI_EltreumUI.RoleIcons)

-- chat role icons
function ElvUI_EltreumUI:ChatIcons()
	local rolePaths = {
		TANK = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga'),
		HEALER = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga'),
		DAMAGER = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga')
	}

end
hooksecurefunc(CH, "AddPluginIcons", ElvUI_EltreumUI.ChatIcons)

local PLAYER_REALM = E:ShortenRealm(E.myrealm)
local PLAYER_NAME = format('%s-%s', E.myname, PLAYER_REALM)
function ElvUI_EltreumUI:CheckLFGRoles()
	local lfgRoles = {}
	local rolePaths = {
	  	TANK = E:TextureString("Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga", ':15:15:0:0:64:64:2:56:2:56'),
		HEALER = E:TextureString("Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga", ':15:15:0:0:64:64:2:56:2:56'),
		DAMAGER = E:TextureString("Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga", ':15:15')
	}

	local playerRole = UnitGroupRolesAssigned('player')
	if playerRole then
		lfgRoles[PLAYER_NAME] = rolePaths[playerRole]
	end

	local unit = (IsInRaid() and 'raid' or 'party')
	for i = 1, GetNumGroupMembers() do
		if UnitExists(unit..i) and not UnitIsUnit(unit..i, 'player') then
			local role = UnitGroupRolesAssigned(unit..i)
			local name, realm = UnitName(unit..i)

			if role and name then
				name = (realm and realm ~= '' and name..'-'..realm) or name..'-'..PLAYER_REALM
				lfgRoles[name] = rolePaths[role]
			end
		end
	end
end
hooksecurefunc(CH, "CheckLFGRoles", ElvUI_EltreumUI.CheckLFGRoles)

function ElvUI_EltreumUI:UpdateRoleIcon()
	UF.RoleIconTextures = {
	        TANK = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga'),
			HEALER = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga'),
			DAMAGER = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga')
	 }
end
hooksecurefunc(UF, "UpdateRoleIcon", ElvUI_EltreumUI.UpdateRoleIcon)


]]--






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

function ElvUI_EltreumUI:AlternativeGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,228,-322"
		E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,47,-337"
		E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,229,-327"
		E.db["unitframe"]["units"]["raid"]["groupSpacing"] = 7
		E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 25
		E.db["unitframe"]["units"]["raid"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 0
		E.db["unitframe"]["units"]["raid"]["width"] = 120
		E.db["unitframe"]["units"]["raid40"]["groupSpacing"] = 7
		E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 2
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid40"]["height"] = 30
		E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid40"]["width"] = 120
		ElvUI_EltreumUI:Print('Alternative Group, Raid and Raid40 layout has been set')
		--ReloadUI()
	else
		ElvUI_EltreumUI:Print('The alternative layout was made for the Eltruism DPS/Tank profile, please switch to it to use it')
	end
end

function ElvUI_EltreumUI:OriginalGroupsDPS()
	if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" then
		if not E.db.movers then E.db.movers = {} end
		E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-247"
		E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,1"
		E.db["unitframe"]["units"]["raid"]["groupSpacing"] = 7
		E.db["unitframe"]["units"]["raid"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid"]["horizontalSpacing"] = 0
		E.db["unitframe"]["units"]["raid"]["numGroups"] = 4
		E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 0
		E.db["unitframe"]["units"]["raid"]["width"] = 120
		E.db["unitframe"]["units"]["raid40"]["groupSpacing"] = 7
		E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid40"]["height"] = 32
		E.db["unitframe"]["units"]["raid40"]["horizontalSpacing"] = 2
		E.db["unitframe"]["units"]["raid40"]["width"] = 120
		ElvUI_EltreumUI:Print('Alternative Group, Raid and Raid40 layout has been set')
		--ReloadUI()
	else
		ElvUI_EltreumUI:Print('The original layout was made for the Eltruism DPS/Tank profile, please switch to it to use it')
	end
end
