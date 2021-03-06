local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local string = _G.string
local OKAY = _G.OKAY
local IsAddOnLoaded = _G.IsAddOnLoaded

function ElvUI_EltreumUI:VersionCheckInit()
	if E.private.ElvUI_EltreumUI.install_version < "2.7.3" then
		ElvUI_EltreumUI:DatabaseConversions()
	end
	ElvUI_EltreumUI:PluginCheck()
	ElvUI_EltreumUI:OldVersionCheck()
	ElvUI_EltreumUI:NewVersionCheck()
	ElvUI_EltreumUI:ElvUIVersionCheck()
end

function ElvUI_EltreumUI:NewVersionCheck()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.0" and E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version then
		E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
		local version = (string.format("|cff82B4ff"..ElvUI_EltreumUI.Version.."|r"))
		ElvUI_EltreumUI:Print("Welcome to version "..version..". If you have any issues please join the |TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinydisc.tga:0:0:0:0|t Discord for help")
	end
end

function ElvUI_EltreumUI:ElvUIVersionCheck()
	E.PopupDialogs["ELVUIVERSIONCHECK"] = {
		text = L["Your ElvUI version is out of date, please update to avoid issues!"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}
	if E.version < (E.Retail and 12.81 or E.Wrath and 0.19 or E.TBC and 2.48 or E.Classic and 1.73) then
		E:StaticPopup_Show('ELVUIVERSIONCHECK')
		ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
	end
end

function ElvUI_EltreumUI:PluginCheck()
	if E.private.ElvUI_EltreumUI.install_version < "2.4.7" then
		E.private.ElvUI_EltreumUI.isInstalled.sle = true
		E.private.ElvUI_EltreumUI.isInstalled.windtools = true
		E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.7" then
		if IsAddOnLoaded("ElvUI_SLE") and not IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded('ProjectAzilroka') then
			if E.private.ElvUI_EltreumUI.isInstalled.sle == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0).." installed but not setup, it is highly recommended to install Shadow and Light's profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		elseif IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded("ElvUI_SLE") and not IsAddOnLoaded('ProjectAzilroka') then
			if E.private.ElvUI_EltreumUI.isInstalled.windtools == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." installed but not setup, it is highly recommended to install Windtools profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		elseif IsAddOnLoaded("ElvUI_WindTools") and IsAddOnLoaded("ElvUI_SLE") and not IsAddOnLoaded('ProjectAzilroka') then
			if E.private.ElvUI_EltreumUI.isInstalled.windtools == false and E.private.ElvUI_EltreumUI.isInstalled.sle == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0).." and "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.windtools == false and E.private.ElvUI_EltreumUI.isInstalled.sle == true then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." installed but not setup, it is highly recommended to install Windtools profile for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.sle == false and E.private.ElvUI_EltreumUI.isInstalled.windtools == true then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0).." installed but not setup, it is highly recommended to install Shadow and Light's profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		elseif IsAddOnLoaded('ProjectAzilroka') and not IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded("ElvUI_SLE") then
			if E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false then
				ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		elseif IsAddOnLoaded('ProjectAzilroka') and IsAddOnLoaded("ElvUI_WindTools") and not IsAddOnLoaded("ElvUI_SLE") then
			if E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false and E.private.ElvUI_EltreumUI.isInstalled.windtools == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false and E.private.ElvUI_EltreumUI.isInstalled.windtools == true then
				ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		elseif IsAddOnLoaded('ProjectAzilroka') and not IsAddOnLoaded("ElvUI_WindTools") and IsAddOnLoaded("ElvUI_SLE") then
			if E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false and E.private.ElvUI_EltreumUI.isInstalled.sle == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0).." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false and E.private.ElvUI_EltreumUI.isInstalled.sle == true then
				ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		elseif IsAddOnLoaded('ProjectAzilroka') and IsAddOnLoaded("ElvUI_WindTools") and IsAddOnLoaded("ElvUI_SLE") then
			if E.private.ElvUI_EltreumUI.isInstalled.windtools == false and E.private.ElvUI_EltreumUI.isInstalled.sle == false and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0)..", "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.windtools == true and E.private.ElvUI_EltreumUI.isInstalled.sle == false and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0).." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.windtools == true and E.private.ElvUI_EltreumUI.isInstalled.sle == true and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false then
				ElvUI_EltreumUI:Print("You have ProjectAzilroka installed but not setup, it is highly recommended to install its profile for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.windtools == false and E.private.ElvUI_EltreumUI.isInstalled.sle == true and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == false then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." and ProjectAzilroka installed but not setup, it is highly recommended to install their profiles for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.windtools == false and E.private.ElvUI_EltreumUI.isInstalled.sle == true and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == true then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["WindTools"], 0.000, 0.592, 0.902, 0.000, 0.659, 1.000).." installed but not setup, it is highly recommended to install Windtools profile for Eltruism, found in Eltruism > Addons, before continuing")
			elseif E.private.ElvUI_EltreumUI.isInstalled.windtools == true and E.private.ElvUI_EltreumUI.isInstalled.sle == false and E.private.ElvUI_EltreumUI.isInstalled.projectazilroka == true then
				ElvUI_EltreumUI:Print("You have "..E:TextGradient(L["Shadow and Light"], 0.2,0,0.6,0.2,0.2,0.8,0.2,1,0).." installed but not setup, it is highly recommended to install Shadow and Light's profile for Eltruism, found in Eltruism > Addons, before continuing")
			end
		end
	end
end

function ElvUI_EltreumUI:OldVersionCheck()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif E.private.ElvUI_EltreumUI.install_version < "2.7.5" then
		ElvUI_EltreumUI:Print('version 2.7.3 changed the database. In version 2.7.5 a button has been added in Eltruism > Installer to reset Eltruism settings if you wish')
	elseif E.private.ElvUI_EltreumUI.install_version < "2.9.3" then
		if E.db.ElvUI_EltreumUI.lightmode == true or E.db.ElvUI_EltreumUI.gradientmode.enable == true then --convert the option
			E.db.ElvUI_EltreumUI.UFmodifications = true
		end
		E.private.ElvUI_EltreumUI.install_version = "2.9.3"
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.9.3" and E.private.ElvUI_EltreumUI.install_version < "3.1.6" then --fix name change since the setting doesnt make sense otherwise
		if E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar == nil then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolorplayercastbar == nil then
				E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar = true
			elseif E.db.ElvUI_EltreumUI.gradientmode.customcolorplayercastbar == true then
				E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar = true
			elseif E.db.ElvUI_EltreumUI.gradientmode.customcolorplayercastbar == false then
				E.db.ElvUI_EltreumUI.gradientmode.classcolorplayercastbar = false
			end
		end
		if E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar == nil then
			if E.db.ElvUI_EltreumUI.gradientmode.customcolortargetcastbar == nil then
				E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar = true
			elseif E.db.ElvUI_EltreumUI.gradientmode.customcolortargetcastbar == true then
				E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar = true
			elseif E.db.ElvUI_EltreumUI.gradientmode.customcolortargetcastbar == false then
				E.db.ElvUI_EltreumUI.gradientmode.classcolortargetcastbar = false
			end
		end
		E.private.ElvUI_EltreumUI.install_version = "3.1.6"
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
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["health"] = true
		E.global["nameplates"]["filters"]["EltreumTarget"]["actions"]["color"]["healthClass"] = true
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
	elseif E.private.ElvUI_EltreumUI.install_version < "3.1.8" then
		if E.db["unitframe"]["units"]["player"]["customTexts"] and E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumHealth"] and not E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumStatus"] then
			local text = {
				["attachTextTo"] = "Health",
				["enable"] = true,
				["font"] = "Kimberley",
				["fontOutline"] = "NONE",
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
	end

	--more long term checks, in case somehow people enable 2 settings when its not possible to do so. Maybe its a shared profile from another person? No idea how they manage to do this
	if E.db.ElvUI_EltreumUI.modetexture == true then
		E.db.ElvUI_EltreumUI.darkpowercolor = true
	end
	if E.db.ElvUI_EltreumUI.lightmode == true and E.db.ElvUI_EltreumUI.darkmode == true then --convert the option
		E.db.ElvUI_EltreumUI.darkmode = false
		E.db.ElvUI_EltreumUI.darkmode = true
	end
	if E.db.ElvUI_EltreumUI.gradientmode.enable == true and E.db.ElvUI_EltreumUI.ufcustomtexture.enable == true then --convert the option
		E.db.ElvUI_EltreumUI.ufcustomtexture.enable = false
		E.db.ElvUI_EltreumUI.ufcustomtexture.enable = true
	end
	if E.db.ElvUI_EltreumUI.nameplateOptions.targetclasstexture == true and E.db.ElvUI_EltreumUI.nameplateOptions.playerclass == true then
		E.db.ElvUI_EltreumUI.nameplateOptions.targetclasstexture = false
		E.db.ElvUI_EltreumUI.nameplateOptions.playerclass = true
	end
	if E.db.ElvUI_EltreumUI.afkmusic.racial == true and E.db.ElvUI_EltreumUI.afkmusic.racial == true then
		E.db.ElvUI_EltreumUI.afkmusic.racial = false
		E.db.ElvUI_EltreumUI.afkmusic.racial = true
	end
	if E.db.ElvUI_EltreumUI.glow.blizzard == true and E.db.ElvUI_EltreumUI.glow.pixel == true then
		E.db.ElvUI_EltreumUI.glow.blizzard = false
		E.db.ElvUI_EltreumUI.glow.pixel = true
	elseif E.db.ElvUI_EltreumUI.glow.blizzard == true and E.db.ElvUI_EltreumUI.glow.autocast == true then
		E.db.ElvUI_EltreumUI.glow.blizzard = false
		E.db.ElvUI_EltreumUI.glow.autocast = true
	elseif E.db.ElvUI_EltreumUI.glow.autocast == true and E.db.ElvUI_EltreumUI.glow.pixel == true then
		E.db.ElvUI_EltreumUI.glow.autocast = false
		E.db.ElvUI_EltreumUI.glow.pixel = true
	elseif E.db.ElvUI_EltreumUI.glow.autocast == true and E.db.ElvUI_EltreumUI.glow.pixel == true and E.db.ElvUI_EltreumUI.glow.blizzard == true then
		E.db.ElvUI_EltreumUI.glow.autocast = false
		E.db.ElvUI_EltreumUI.glow.blizzard = false
		E.db.ElvUI_EltreumUI.glow.pixel = true
	end
	if E.db.ElvUI_EltreumUI.skins.classiconsblizz == true and E.db.ElvUI_EltreumUI.skins.classiconsreleaf == true then
		E.db.ElvUI_EltreumUI.skins.classiconsblizz = false
		E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
	end
	if E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly == true and E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly == true then
		E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false
		E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly = true
	end
	if E.db.ElvUI_EltreumUI.otherstuff.playerdeath == true and (E.db.ElvUI_EltreumUI.otherstuff.playerdeathgta == true or E.db.ElvUI_EltreumUI.otherstuff.playerdeathcustom == true) then
		E.db.ElvUI_EltreumUI.otherstuff.playerdeath = false
		E.db.ElvUI_EltreumUI.otherstuff.playerdeathcustom = false
	end
end
