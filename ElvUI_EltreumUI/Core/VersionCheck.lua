local E, L = unpack(ElvUI)
local _G = _G
local string = _G.string
local OKAY = _G.OKAY
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local fixingold = false
local GetAddOnMetadata = _G.C_AddOns and _G.C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata
local tonumber = _G.tonumber
local select = _G.select
local GetBuildInfo = _G.GetBuildInfo

function ElvUI_EltreumUI:VersionCheckInit()
	if E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version then
		ElvUI_EltreumUI:DatabaseConversions()
	end
	ElvUI_EltreumUI:PluginCheck()
	ElvUI_EltreumUI:OldVersionCheck()
	ElvUI_EltreumUI:NewVersionCheck()
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
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	end

	if E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
		ElvUI_EltreumUI:Print("You are using WeakAuras mode for ActionBars. If you wish to stop using it, make sure to disable by typing /eltruism weakauras or disabling it in the options, failing to do can cause errors")
	end

	if E.db.ElvUI_EltreumUI.skins.doom.maxAlpha > 1 then --fix alpha values
		E.db.ElvUI_EltreumUI.skins.doom.maxAlpha = (E.db.ElvUI_EltreumUI.skins.doom.maxAlpha/100)
	end

	--more long term checks, in case somehow people enable 2 settings when its not possible to do so. Maybe its a shared profile from another person? No idea how they manage to do this
	if E.db.ElvUI_EltreumUI.modetexture then
		E.db.ElvUI_EltreumUI.unitframes.darkpowercolor = true
	end
	if E.db.ElvUI_EltreumUI.unitframes.lightmode and E.db.ElvUI_EltreumUI.unitframes.darkmode then --convert the option
		E.db.ElvUI_EltreumUI.unitframes.lightmode = false
		E.db.ElvUI_EltreumUI.unitframes.darkmode = true
	end
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture and E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.playerclass then
		E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture = false
		E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.playerclass = true
	end
	if E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial and E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial then
		E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial = false
		E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial = true
	end
	if E.db.ElvUI_EltreumUI.glow.blizzard and E.db.ElvUI_EltreumUI.glow.pixel then
		E.db.ElvUI_EltreumUI.glow.blizzard = false
		E.db.ElvUI_EltreumUI.glow.pixel = true
	elseif E.db.ElvUI_EltreumUI.glow.blizzard and E.db.ElvUI_EltreumUI.glow.autocast then
		E.db.ElvUI_EltreumUI.glow.blizzard = false
		E.db.ElvUI_EltreumUI.glow.autocast = true
	elseif E.db.ElvUI_EltreumUI.glow.autocast and E.db.ElvUI_EltreumUI.glow.pixel then
		E.db.ElvUI_EltreumUI.glow.autocast = false
		E.db.ElvUI_EltreumUI.glow.pixel = true
	elseif E.db.ElvUI_EltreumUI.glow.autocast and E.db.ElvUI_EltreumUI.glow.pixel and E.db.ElvUI_EltreumUI.glow.blizzard then
		E.db.ElvUI_EltreumUI.glow.autocast = false
		E.db.ElvUI_EltreumUI.glow.blizzard = false
		E.db.ElvUI_EltreumUI.glow.pixel = true
	end
	if E.db.ElvUI_EltreumUI.skins.classiconsblizz and E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
		E.db.ElvUI_EltreumUI.skins.classiconsblizz = false
		E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
	end
	if E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly and E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly then
		E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.hidefriendly = false
		E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly = true
	end
	if E.db.ElvUI_EltreumUI.skins.playerdeath and (E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeathcustom) then
		E.db.ElvUI_EltreumUI.skins.playerdeath = false
		E.db.ElvUI_EltreumUI.skins.playerdeathcustom = false
	end
	if E.db.ElvUI_EltreumUI.quests.questitemsbar1 and E.db.ElvUI_EltreumUI.quests.questitemsfade then
		E.db.ElvUI_EltreumUI.quests.questitemsfade = false
		E.db.ElvUI_EltreumUI.quests.questitemsbar1 = true
	end
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture and E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture then
		E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetclasstexture = false
		E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture = true
	end
	if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect and E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture then
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect = true
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture = false
	end
	if E.db.ElvUI_EltreumUI.skins.stealtheffect and E.db.ElvUI_EltreumUI.skins.screenvignette then
		E.db.ElvUI_EltreumUI.skins.screenvignette = false
		E.db.ElvUI_EltreumUI.skins.stealtheffect = true
	end

	--fix in case the typo in the config caused this to be a file name instead
	if (E.private.ElvUI_EltreumUI.combatmusic.bossmusic ~= nil and E.private.ElvUI_EltreumUI.combatmusic.bossmusic ~= false and E.private.ElvUI_EltreumUI.combatmusic.bossmusic ~= true) then
		E.private.ElvUI_EltreumUI.combatmusic.bossmusic = false
	end

	--changes only for my profiles
	if E.private.ElvUI_EltreumUI.install_version and not (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
		return
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.7.3" and E.private.ElvUI_EltreumUI.install_version < "4.0.5" then
		if E.Classic then --fix priest mind control paging
			if E.db.actionbar.bar1.visibility == "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;" then
				E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 16;[bonusbar:5] 11; [bonusbar:1] 7;"
			elseif E.db.actionbar.bar4.visibility == "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;" then
				E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 16;[bonusbar:5] 11; [bonusbar:1] 7;"
			end
		end
		E.db["unitframe"]["units"]["target"]["aurabar"]["priority"] = "Blacklist,blockNoDuration,Personal,Boss,RaidDebuffs,PlayerBuffs,RaidBuffsElvUI,TurtleBuffs"
		--fixingold = true
		--E.private.ElvUI_EltreumUI.install_version = "4.0.5"
	elseif E.private.ElvUI_EltreumUI.install_version >= "4.0.5" and E.private.ElvUI_EltreumUI.install_version < "4.0.7" then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower then
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableclassbar = true
		end
	elseif E.private.ElvUI_EltreumUI.install_version >= "4.0.7" and E.private.ElvUI_EltreumUI.install_version < "4.1.2" then --fix blizzard macro conditional
		if E.db["unitframe"]["units"]["party"]["visibility"] == "[@raid6,exists][nogroup] hide;show" then
			E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][@party1,noexists] hide;show"
		end
	end
end

function ElvUI_EltreumUI:NewVersionCheck()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.0" and E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version and not fixingold then
		E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
		local version = (string.format("|cff82B4ff"..ElvUI_EltreumUI.Version.."|r"))
		ElvUI_EltreumUI:Print("Welcome to version "..version..". If you have any issues please join the |TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinydisc.tga:0:0:0:0|t Discord for help")
		if E.db.ElvUI_EltreumUI.autoupdate then
			ElvUI_EltreumUI:UpdateEltruismSettings(true)
			ElvUI_EltreumUI:UpdateElvUISettings(true)
		end
	end
end
