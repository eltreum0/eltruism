local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local PlaySoundFile = _G.PlaySoundFile
local GetNumGroupMembers = _G.GetNumGroupMembers
local IsInGroup = _G.IsInGroup
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo
--local format = _G.format
--local hooksecurefunc = _G.hooksecurefunc
--local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
--local IsInRaid = _G.IsInRaid
--local UnitExists = _G.UnitExists
--local UnitIsUnit = _G.UnitIsUnit
--local UnitName = _G.UnitName
--local UF = E:GetModule("UnitFrames")
--local CH = E:GetModule('Chat')

function ElvUI_EltreumUI:PartyRaidInit()
	ElvUI_EltreumUI:ChatRoleSwapIcons() --icons on role swap
	--[[
	ElvUI_EltreumUI:RoleIcons()  --unit frame role icons
	ElvUI_EltreumUI:ChatIcons()  --chat role icons
	ElvUI_EltreumUI:CheckLFGRoles() --lfg role icons
	ElvUI_EltreumUI:UpdateRoleIcon()

	]]--
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
		local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)
		SLE.rolePaths["Eltruism"] = {
			TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga"
		}
	end
end

--[[


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

	  local hide = _G.LFGList()
		local function lfg(self)
			TankIcon = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.blp'
			HealerIcon = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.blp'
			DamagerIcon = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.blp'
			_G.TankIcon = roleIcons.TANK
	    _G.DamagerIcon = roleIcons.DAMAGER
	    _G.HealerIcon = roleIcons.HEALER
	    _G.TankIcon = roleIcons.TANK
		end
		hooksecurefunc(hide, "RoleCount_Update", lfg)

	local W = E.Libs.AceAddon:GetAddon("ElvUI_WindTools", true)
	local CT = W:GetModule("ChatText")

	function ElvUI_EltreumUI:CheckLFGRoles()
		local rolePaths = {
			TANK = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga:15:15:0:0:64:64:2:56:2:56'),
			HEALER = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga:15:15:0:0:64:64:2:56:2:56'),
			DAMAGER = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga:15:15'),
		}
		hooksecurefunc(rolePaths, "CH", ElvUI_EltreumUI.CheckLFGRoles)
	end

	function ElvUI_EltreumUI:ChatIcons()
	    CT.cache.blizzardRoleIcons.Tank = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga:15:15:0:0:64:64:2:56:2:56')
	    CT.cache.blizzardRoleIcons.Healer = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga:15:15:0:0:64:64:2:56:2:56')
	    CT.cache.blizzardRoleIcons.DPS = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga:15:15')
	    CT.cache.elvuiRoleIconsPath.Tank = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\shield.tga:15:15:0:0:64:64:2:56:2:56')
	    CT.cache.elvuiRoleIconsPath.Healer = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\pharmacy.tga:15:15:0:0:64:64:2:56:2:56')
	    CT.cache.elvuiRoleIconsPath.DPS = ('Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\RoleIcons\\sword.tga:15:15')
	    hooksecurefunc(CT, "UpdateRoleIcons", ElvUI_EltreumUI.ChatIcons)
	end

	/run LFGListSearchPanelScrollFrameButton1.DataDisplay.RoleCount.DamagerIcon:Hide()
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
