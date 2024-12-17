local E, L = unpack(ElvUI)
local _G = _G
local string = _G.string
local OKAY = _G.OKAY
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local GetAddOnMetadata = _G.C_AddOns and _G.C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata
local tonumber = _G.tonumber
local select = _G.select
local GetBuildInfo = _G.GetBuildInfo

function ElvUI_EltreumUI:VersionCheckInit()
	if E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version then
		ElvUI_EltreumUI:DatabaseConversions()
	end
	ElvUI_EltreumUI:PluginCheck()
	if E.private.ElvUI_EltreumUI.install_version and E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version then
		ElvUI_EltreumUI:OldVersionCheck()
		ElvUI_EltreumUI:NewVersionCheck()
	end
	ElvUI_EltreumUI:ElvUIVersionCheck()
end

function ElvUI_EltreumUI:ElvUIVersionCheck()
	E.PopupDialogs["ELVUIVERSIONCHECK"] = {
		text = L["Your ElvUI version is out of date, please update to avoid issues!"],
		--button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}
	E.PopupDialogs["ELVUIVERSIONCHECK2"] = {
		text = L["Your ElvUI version is higher than expected for Eltruism, please update Eltruism or you might run into issues.\n|cffFF0000(You are likely having errors right now!)|r"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}
	E.PopupDialogs["GAMEVERSIONCHECKHIGHER"] = {
		text = L["Your World of Warcraft version is higher than expected for Eltruism, please update Eltruism or you might run into issues.\n|cffFF0000(You are likely having errors right now!)|r"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}
	E.PopupDialogs["GAMEVERSIONCHECKLOWER"] = {
		text = L["Your World of Warcraft version is older than Eltruism, you might run into issues!"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}
	E.PopupDialogs["PRIVATESERVER"] = {
		text = L["|cffff0000Private Servers are unsupported!"],
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}

	--elvui check
	if E.version < 99999 then
		if E.version < tonumber(GetAddOnMetadata("ElvUI_EltreumUI", 'X-ElvUI')) then
			E:StaticPopup_Show('ELVUIVERSIONCHECK')
			ElvUI_EltreumUI:Print(L["Your ElvUI version is out of date, please update to avoid issues!"])
		elseif E.version > (tonumber(GetAddOnMetadata("ElvUI_EltreumUI", 'X-ElvUI')) + 0.03) then
			E:StaticPopup_Show('ELVUIVERSIONCHECK2')
			ElvUI_EltreumUI:Print(L["Your ElvUI version is higher than expected for Eltruism, please update Eltruism or you might run into issues.\n|cffFF0000(You are likely having errors right now!)|r"])
		end
	end

	--game version check
	local requiredversion = tonumber(GetAddOnMetadata("ElvUI_EltreumUI", 'X-Interface'))
	local currentversion = select(4,GetBuildInfo())
	local privateserver = 30300
	if requiredversion < tonumber(currentversion) then
		E:StaticPopup_Show('GAMEVERSIONCHECKHIGHER')
		ElvUI_EltreumUI:Print(L["Your World of Warcraft version is higher than expected for Eltruism, please update Eltruism or you might run into issues.\n|cffFF0000(You are likely having errors right now!)|r"])
	elseif tonumber(currentversion) == privateserver then
		E:StaticPopup_Show('PRIVATESERVER')
	elseif requiredversion > tonumber(currentversion) then
		E:StaticPopup_Show('GAMEVERSIONCHECKLOWER')
		ElvUI_EltreumUI:Print(L["Your World of Warcraft version is older than Eltruism, you might run into issues!"])
	end
end

function ElvUI_EltreumUI:PluginCheck()
	if E.private.ElvUI_EltreumUI.install_version and (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
		if E.private.ElvUI_EltreumUI.install_version < "2.4.7" then
			E.private.ElvUI_EltreumUI.isInstalled.sle = true
			E.private.ElvUI_EltreumUI.isInstalled.windtools = true
			E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
		elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.7" then
			if IsAddOnLoaded("ElvUI_SLE") and not IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded('ProjectAzilroka') then
				if not E.private.ElvUI_EltreumUI.isInstalled.sle then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r".." installed but not setup, it is highly recommended to install Shadow and Light's profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			elseif IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded("ElvUI_SLE") and not IsAddOnLoaded('ProjectAzilroka') then
				if not E.private.ElvUI_EltreumUI.isInstalled.windtools then
					ElvUI_EltreumUI:Print("You have ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." installed but not setup, it is highly recommended to install Windtools profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			elseif IsAddOnLoaded("ElvUI_WindTools") and IsAddOnLoaded("ElvUI_SLE") and not IsAddOnLoaded('ProjectAzilroka') then
				if not E.private.ElvUI_EltreumUI.isInstalled.windtools and not E.private.ElvUI_EltreumUI.isInstalled.sle then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r".." and ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
				elseif not E.private.ElvUI_EltreumUI.isInstalled.windtools and E.private.ElvUI_EltreumUI.isInstalled.sle then
					ElvUI_EltreumUI:Print("You have ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." installed but not setup, it is highly recommended to install Windtools profile for Eltruism, found in Eltruism > Addons, before continuing")
				elseif not E.private.ElvUI_EltreumUI.isInstalled.sle and E.private.ElvUI_EltreumUI.isInstalled.windtools then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r".." installed but not setup, it is highly recommended to install Shadow and Light's profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			elseif IsAddOnLoaded('ProjectAzilroka') and not IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded("ElvUI_SLE") then
				if not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			elseif IsAddOnLoaded('ProjectAzilroka') and IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded("ElvUI_SLE") then
				if not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka and not E.private.ElvUI_EltreumUI.isInstalled.windtools then
					ElvUI_EltreumUI:Print("You have ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
				elseif not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka and E.private.ElvUI_EltreumUI.isInstalled.windtools then
					ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			elseif IsAddOnLoaded('ProjectAzilroka') and not IsAddOnLoaded("ElvUI_WindTools") and IsAddOnLoaded("ElvUI_SLE") then
				if not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka and not E.private.ElvUI_EltreumUI.isInstalled.sle then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r".." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
				elseif not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka and E.private.ElvUI_EltreumUI.isInstalled.sle then
					ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			elseif IsAddOnLoaded('ProjectAzilroka') and IsAddOnLoaded("ElvUI_WindTools") and IsAddOnLoaded("ElvUI_SLE") then
				if not E.private.ElvUI_EltreumUI.isInstalled.windtools and not E.private.ElvUI_EltreumUI.isInstalled.sle and not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r"..", ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
				elseif E.private.ElvUI_EltreumUI.isInstalled.windtools and not E.private.ElvUI_EltreumUI.isInstalled.sle and not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r".." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
				elseif E.private.ElvUI_EltreumUI.isInstalled.windtools and E.private.ElvUI_EltreumUI.isInstalled.sle and not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
				elseif not E.private.ElvUI_EltreumUI.isInstalled.windtools and E.private.ElvUI_EltreumUI.isInstalled.sle and not E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
				elseif not E.private.ElvUI_EltreumUI.isInstalled.windtools and E.private.ElvUI_EltreumUI.isInstalled.sle and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ".."|cff5385edW|r|cff5094eai|r|cff4da4e7n|r|cff4ab4e4d|r|cff47c0e1T|r|cff44cbdfo|r|cff41d7ddo|r|cff41d7ddl|r|cff41d7dds|r".." installed but not setup, it is highly recommended to install Windtools profile for Eltruism, found in Eltruism > Addons, before continuing")
				elseif E.private.ElvUI_EltreumUI.isInstalled.windtools and not E.private.ElvUI_EltreumUI.isInstalled.sle and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka then
					ElvUI_EltreumUI:Print("You have ".."|cff9482c9S|r|cff8c8ac9h|r|cff8591c9a|r|cff809bc9d|r|cff7fa6c9o|r|cff7eb2c9w|r |cff6fcac1a|r|cff5de7b8n|r|cff4bfdaed|r |cff3cfda2L|r|cff2cfd97i|r|cff20fd7bg|r|cff16fd55h|r|cff0cfd2ft|r".." installed but not setup, it is highly recommended to install Shadow and Light's profile for Eltruism, found in Eltruism > Addons, before continuing")
				end
			end
		end
	end
end

function ElvUI_EltreumUI:OldVersionCheck()
	if E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
		ElvUI_EltreumUI:Print("You are using WeakAuras mode for ActionBars. If you wish to stop using it, make sure to disable by typing /eltruism weakauras or disabling it in the options, failing to do can cause errors")
	end

	if E.db.ElvUI_EltreumUI.skins.doom.maxAlpha > 1 then --fix alpha values
		E.db.ElvUI_EltreumUI.skins.doom.maxAlpha = (E.db.ElvUI_EltreumUI.skins.doom.maxAlpha/100)
	end

	--remove entries no longer used
	if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
		E.db.ElvUI_EltreumUI.skins.classiconsblizz = nil
		E.db.ElvUI_EltreumUI.skins.classiconsstyle = "BLIZZARD"
	end
	if E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
		E.db.ElvUI_EltreumUI.skins.classiconsreleaf = nil
		E.db.ElvUI_EltreumUI.skins.classiconsstyle = "RELEAF"
	end

	--changes only for my profiles
	--if not (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
	--	return
	--elseif E.private.ElvUI_EltreumUI.install_version >= "4.1.2" and E.private.ElvUI_EltreumUI.install_version < "4.1.3" then --fix era priest paging shadowform
	--end
end

function ElvUI_EltreumUI:NewVersionCheck()
	E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	local version = (string.format("|cff82B4ff"..ElvUI_EltreumUI.Version.."|r"))
	ElvUI_EltreumUI:Print("Welcome to version "..version..". If you have any issues please join the |TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinydisc.tga:0:0:0:0|t Discord for help")
	if E.db.ElvUI_EltreumUI.autoupdate then
		ElvUI_EltreumUI:UpdateEltruismSettings(true)
		ElvUI_EltreumUI:UpdateElvUISettings(true)
	end
end
