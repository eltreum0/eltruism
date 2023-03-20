local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local string = _G.string
local OKAY = _G.OKAY
local IsAddOnLoaded = _G.IsAddOnLoaded
local fixingold = false
local pairs = _G.pairs

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
	if E.version < 13.27 then
		E:StaticPopup_Show('ELVUIVERSIONCHECK')
		ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
	elseif E.version > 13.35 then
		E:StaticPopup_Show('ELVUIVERSIONCHECK2')
		ElvUI_EltreumUI:Print("Your ElvUI version is newer than Eltruism, you might run into issues unless you update Eltruism!")
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

	--changes only for my profiles
	if E.private.ElvUI_EltreumUI.install_version and not (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
		return
	elseif E.private.ElvUI_EltreumUI.install_version < "2.9.3" then
		if E.db.ElvUI_EltreumUI.unitframes.lightmode or E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable then --convert the option
			E.db.ElvUI_EltreumUI.unitframes.UFmodifications = true
		end
		E.private.ElvUI_EltreumUI.install_version = "2.9.3"
		fixingold = true
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.9.3" and E.private.ElvUI_EltreumUI.install_version < "3.1.6" then --fix name change since the setting doesnt make sense otherwise
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar == nil then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolorplayercastbar == nil then
				E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar = true
			elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolorplayercastbar == true then
				E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar = true
			elseif not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolorplayercastbar then
				E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolorplayercastbar = false
			end
		end
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar == nil then
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolortargetcastbar == nil then
				E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar = true
			elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolortargetcastbar == true then
				E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar = true
			elseif not E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolortargetcastbar then
				E.db.ElvUI_EltreumUI.unitframes.gradientmode.classcolortargetcastbar = false
			end
		end
		E.private.ElvUI_EltreumUI.install_version = "3.1.6"
		fixingold = true
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.1.6" and E.private.ElvUI_EltreumUI.install_version < "3.1.7" then -- add EltreumTarget, to make it so when options are disabled ElvUI_Target is not still changing colors
		for _, filterName in pairs({'ElvUI_Target', 'EltreumTarget'}) do
			E.global["nameplates"]["filters"][filterName] = {}
			E.NamePlates:StyleFilterCopyDefaults(E.global["nameplates"]["filters"][filterName])
			E.db["nameplates"]["filters"][filterName] = { triggers = { enable = true } }
		end
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["priority"] = 1
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["requireTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["health"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["healthClass"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "ElvUI Blank"
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["elite"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["minus"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["normal"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["trivial"] = true

		E.private.ElvUI_EltreumUI.install_version = "3.1.7"
		fixingold = true
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.1.7" and E.private.ElvUI_EltreumUI.install_version < "3.1.8" then
		if E.db["unitframe"]["units"]["player"]["customTexts"] and E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] and not E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			local text = {
				["attachTextTo"] = "Health",
				["enable"] = false,
				["font"] = E.db.general.font,
				["fontOutline"] = E.db.general.fontStyle,
				["justifyH"] = "CENTER",
				["size"] = 40,
				["text_format"] = "[eltruism:dead{5}][eltruism:dc{2}]",
				["xOffset"] = 0,
				["yOffset"] = 0
			}

			E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumStatus"] = text
			E.db["unitframe"]["units"]["raid"]["customTexts"]["EltreumStatus"] = text
			E.db["unitframe"]["units"]["raid40"]["customTexts"]["EltreumStatus"] = text
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] = text
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumStatus"] = text
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumStatus"] = text
		end
		E.private.ElvUI_EltreumUI.install_version = "3.1.8"
		fixingold = true
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.1.8" and E.private.ElvUI_EltreumUI.install_version < "3.2.2" then
		--confirm eltreum power for target of target exists
		E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
		if not E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] then
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumPower"] = {
				["attachTextTo"] = "Power",
				["enable"] = true,
				["font"] = E.db.general.font,
				["fontOutline"] = E.db.general.fontStyle,
				["justifyH"] = "RIGHT",
				["size"] = 9,
				["text_format"] = "[powercolor][power:current:shortvalue]",
				["xOffset"] = 0,
				["yOffset"] = -1
			}
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.2.2"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.2.2" and E.private.ElvUI_EltreumUI.install_version < "3.2.4" then
		if not E.Retail and E.global["nameplates"]["filters"]["ElvUI_Boss"] then --in classic for some reason bosses are not affected by ElvUI_Target/EltreumTarget
			E.global["nameplates"]["filters"]['ElvUI_Boss'] = {}
			E.NamePlates:StyleFilterCopyDefaults(E.global["nameplates"]["filters"]['ElvUI_Boss'])
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["health"] = true
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["color"]["healthClass"] = true
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["scale"] = 1.25
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["usePortrait"] = false
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["triggers"]["isTarget"] = true
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["triggers"]["requireTarget"] = true
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["actions"]["texture"]["enable"] = true
			E.global["nameplates"]["filters"]["ElvUI_Boss"]["triggers"]["classification"]["worldboss"] = true
		end

		--reset eltreum name with lower priority
		E.global["nameplates"]["filters"]['EltreumTarget'] = {}
		E.NamePlates:StyleFilterCopyDefaults(E.global["nameplates"]["filters"]['EltreumTarget'])
		E.db["nameplates"]["filters"]['EltreumTarget'] = { triggers = { enable = true } }
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["enable"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["priority"] = 2
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["isTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["requireTarget"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["health"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["healthClass"] = false
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["b"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["g"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["borderColor"]["r"] = 0
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["scale"] = 1.25
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["enable"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["texture"]["texture"] = "ElvUI Blank"
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["elite"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["minus"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["normal"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["classification"]["trivial"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["triggers"]["priority"] = 2

		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.2.4"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.2.5" and E.private.ElvUI_EltreumUI.install_version < "3.3.2" then
		--force disable the name only since it causes issues still
		if E.global["nameplates"]["filters"]["EltreumHideNP"] then
			for _, filterName in pairs({'EltreumHideNP', 'EltreumRestedNP'}) do
				E.global["nameplates"]["filters"][filterName] = {}
				E.NamePlates:StyleFilterCopyDefaults(E.global["nameplates"]["filters"][filterName])
				E.db["nameplates"]["filters"][filterName] = { triggers = { enable = true } }
			end
			E.global["nameplates"]["filters"]["EltreumHideNP"]["actions"]["nameOnly"] = true
			E.global["nameplates"]["filters"]["EltreumHideNP"]["actions"]["tags"]["name"] = "[namecolor][name]"
			E.global["nameplates"]["filters"]["EltreumHideNP"]["actions"]["tags"]["title"] = "[namecolor][npctitle:brackets]"
			E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["nameplateType"]["enable"] = true
			E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["nameplateType"]["enemyNPC"] = true
			E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["playerCanNotAttack"] = true
			E.global["nameplates"]["filters"]["EltreumHideNP"]["triggers"]["priority"] = 15
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["alpha"] = 100
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["nameOnly"] = true
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["tags"]["name"] = "[namecolor][name:title][realm:dash]"
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["actions"]["tags"]["title"] = "[namecolor][npctitle:brackets][guild:brackets]"
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["isResting"] = true
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["outOfCombat"] = true
			E.global["nameplates"]["filters"]["EltreumRestedNP"]["triggers"]["playerCanNotAttack"] = true
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.3.2"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.3.3" and E.private.ElvUI_EltreumUI.install_version < "3.4.4" then
		--fix the demonhunter paging
		if E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] == "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;;" then
			E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
		end
		if E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] == "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;;" then
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.4.4"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.4.4" and E.private.ElvUI_EltreumUI.install_version < "3.6.5" then
		if E.db.actionbar.bar4.visibility == "[vehicleui] show; [overridebar] show; [possessbar] show; show;" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"
			E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar3"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar5"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar7"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar8"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar9"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
		elseif E.db.actionbar.bar1.visibility == "[vehicleui] show; [overridebar] show; [possessbar] show; show;" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar3"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar5"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar7"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar8"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar9"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.6.5"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.6.5" and E.private.ElvUI_EltreumUI.install_version < "3.6.8" then
		--disable interrupt style filter inside raids due to the number of nameplates possibly causing issues, detected in razaghet fight during intermission where many adds spawn and cast, disabling solved the issue
		if E.global["nameplates"]["filters"]["EltreumInterrupt"] and E.private.nameplates.enable then
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["heroic"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["mythic+"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["normal"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceDifficulty"]["dungeon"]["timewalking"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["arena"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["none"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["party"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["pvp"] = true
			E.global["nameplates"]["filters"]["EltreumInterrupt"]["triggers"]["instanceType"]["scenario"] = true
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.6.8"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.6.8" and E.private.ElvUI_EltreumUI.install_version < "3.6.9" then
		if E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable then
			E.db.ElvUI_EltreumUI.nameplates.auras.enable = true
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.6.9"
	elseif E.private.ElvUI_EltreumUI.install_version >= "3.6.9" and E.private.ElvUI_EltreumUI.install_version < "3.7.3" then
		if E.Wrath then --long term paging fix due to ulduar changes
			if E.db.actionbar.bar1.visibility == "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
				E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 16; [overridebar] 18; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
				E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"

				E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"
				E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar3"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar5"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar7"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar8"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar9"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["stanceBar"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["totemBar"]["visibility"] = "[combat] show;[@target, noexists] hide; [vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			elseif E.db.actionbar.bar4.visibility == "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
				E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16; [bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 16; [overridebar] 18; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
				E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[vehicleui] 16; [overridebar] 18; [possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"
				E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 16; [overridebar] 18;[possessbar] 16;[bonusbar:5] 11;"

				E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; [petbattle] hide; show;"
				E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar2"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar3"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar5"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar7"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar8"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["bar9"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["stanceBar"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
				E.db["actionbar"]["totemBar"]["visibility"] = "[combat] show;[@target, noexists] hide; [vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			end
		end
		fixingold = true
		E.private.ElvUI_EltreumUI.install_version = "3.7.3"
	end
end

function ElvUI_EltreumUI:NewVersionCheck()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.0" and E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version and not fixingold then
		E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
		local version = (string.format("|cff82B4ff"..ElvUI_EltreumUI.Version.."|r"))
		ElvUI_EltreumUI:Print("Welcome to version "..version..". If you have any issues please join the |TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinydisc.tga:0:0:0:0|t Discord for help")
	end
end
