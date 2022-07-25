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
	if E.version < (E.Retail and 12.81 or E.Wrath and 0.12 or E.TBC and 2.48 or E.Classic and 1.73) then
		E:StaticPopup_Show('ELVUIVERSIONCHECK')
		ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
	end
	if E.Wrath then
		ElvUI_EltreumUI:Print("Eltruism for WOTLK is in development, if you have issues please report in |TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinydisc.tga:0:0:0:0|t Discord")
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
	elseif E.private.ElvUI_EltreumUI.install_version > "0" and E.private.ElvUI_EltreumUI.install_version < "2.1.3" then
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			if not E.db.movers then E.db.movers = {} end
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [namecolor][eltruism:difficulty][name:eltruism:abbreviate]"
			ElvUI_EltreumUI:Print('Nameplate Filters were changed, please remove |cffff0000EnemyCasting, ExecuteRange, StealThisBuff and HideThis filters|r')
			if E.Retail then
				E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
			end
			if E.Classic or E.TBC then
				if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
					if not E.db.movers then E.db.movers = {} end
					E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true
					E.private.ElvUI_EltreumUI.install_version = "2.1.3"
					ElvUI_EltreumUI:Print('profile has been automatically updated to enable mana and energy ticks')
				end
			end
		end
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.1.3" and E.private.ElvUI_EltreumUI.install_version <= "2.2.1" then
		E.private.ElvUI_EltreumUI.install_version = "2.2.2"
		if E.private["nameplates"]["enable"] == true then
			ElvUI_EltreumUI:SetupNamePlates('ElvUI')
			if E.Retail then
				E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
			end
			ElvUI_EltreumUI:Print('Please go to: |cffff0000ElvUI > Unitframes > Group Units > Party/Raid/Raid40 > Aura Indicator >|r Set them to |cffff0000Textured Icon with Display Timer|r')
			ElvUI_EltreumUI:Print('This setting cannot be set through the plugin without causing errors. It will improve your experience making it easier to see which buffs/debuffs your party/raid/raid40 has. This message will only be displayed once.')
		end
	elseif E.private.ElvUI_EltreumUI.install_version > "2.2.1" and E.private.ElvUI_EltreumUI.install_version < "2.3.0" then
		E.private.ElvUI_EltreumUI.install_version = "2.3.0"
		if E.Retail then
			E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
		end
		ElvUI_EltreumUI:Print('Chat modifications were recently added, please check Eltruism > Chat if you want to turn them off. You can Left click on a Chat Panel enable them (reloading will reset this)')
		ElvUI_EltreumUI:Print('More options were added to Nameplate Power Bar, such as the ability to change its size, position and texture. Configure it in Eltruism > Nameplates')
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.3.0" and E.private.ElvUI_EltreumUI.install_version < "2.4.0" then
		E.private.ElvUI_EltreumUI.install_version = "2.4.0"
		if E.Retail then
			E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
		end
		ElvUI_EltreumUI:Print('Chat modifications were recently added, please check Eltruism > Chat if you want to turn them off. You can Left click on a Chat Panel enable them (reloading will reset this)')
		ElvUI_EltreumUI:Print('More options were added to Nameplate Power Bar, such as the ability to change its size, position and texture. Configure it in Eltruism > Nameplates')
		ElvUI_EltreumUI:Print('Borders released, you can test this feature in Eltruism > Borders. You might need to adjust settings to fit your action bars')
		ElvUI_EltreumUI:Print('Cooldowns were added to Cursor recently, thats why you see icons when you try to use a skill again')
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.0" and E.private.ElvUI_EltreumUI.install_version < "2.4.5" then
		if E.Retail then
			E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "2.4.6" then
		if E.Retail then
			--E.db["sle"]["loot"]["looticons"]["enable"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar1"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar10"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar2"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar3"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar4"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar5"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar6"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar7"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar8"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["bar9"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["microbar"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["petbar"]["backdrop"] = false
			E.db["sle"]["shadows"]["actionbars"]["petbar"]["buttons"] = false
			E.db["sle"]["shadows"]["actionbars"]["stancebar"]["buttons"] = false
			E.db["sle"]["shadows"]["chat"]["LeftChatPanel"]["backdrop"] = false
			E.db["sle"]["shadows"]["chat"]["RightChatPanel"]["backdrop"] = false
			E.db["sle"]["shadows"]["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
			E.db["sle"]["shadows"]["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
			E.db["sle"]["shadows"]["minimap"]["backdrop"] = false
			E.db["sle"]["shadows"]["unitframes"]["arena"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["arena"]["power"] = true
			E.db["sle"]["shadows"]["unitframes"]["boss"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["boss"]["power"] = false
			E.db["sle"]["shadows"]["unitframes"]["focus"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["focus"]["power"] = false
			E.db["sle"]["shadows"]["unitframes"]["party"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["party"]["power"] = false
			E.db["sle"]["shadows"]["unitframes"]["pet"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["pet"]["power"] = false
			E.db["sle"]["shadows"]["unitframes"]["player"]["classbar"] = false
			E.db["sle"]["shadows"]["unitframes"]["player"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["player"]["power"] = false
			E.db["sle"]["shadows"]["unitframes"]["target"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["target"]["power"] = false
			E.db["sle"]["shadows"]["unitframes"]["targettarget"]["health"] = false
			E.db["sle"]["shadows"]["unitframes"]["targettarget"]["power"] = false
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "2.5.2" then
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 28
			E.db["unitframe"]["units"]["player"]["castbar"]["iconAttached"] = false
			E.db["unitframe"]["units"]["player"]["castbar"]["iconAttachedTo"] = "Castbar"
			E.db["unitframe"]["units"]["player"]["castbar"]["iconSize"] = 27
			E.db["unitframe"]["units"]["player"]["castbar"]["iconXOffset"] = 0
			E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
			E.db["unitframe"]["units"]["player"]["castbar"]["timeToHold"] = 0.6
			E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 267
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "2.7.5" then
		ElvUI_EltreumUI:Print('version 2.7.3 changed the database. In version 2.7.5 a button has been added in Eltruism > Installer to reset Eltruism settings if you wish')
	elseif E.private.ElvUI_EltreumUI.install_version < "2.9.2" then
		if E.db.ElvUI_EltreumUI.modetexture == true then
			E.db.ElvUI_EltreumUI.darkpowercolor = true
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "2.9.3" then
		if E.db.ElvUI_EltreumUI.lightmode == true or E.db.ElvUI_EltreumUI.gradientmode.enable == true then --convert the option
			E.db.ElvUI_EltreumUI.UFmodifications = true
		end
		if E.db.ElvUI_EltreumUI.ufcustomtexture.enable == true and E.db.ElvUI_EltreumUI.gradientmode.enable == true then --prevent blocking each other
			E.db.ElvUI_EltreumUI.ufcustomtexture.enable = false
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "3.1.6" then --fix name change since the setting doesnt make sense otherwise
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
	elseif E.private.ElvUI_EltreumUI.install_version < "3.1.7" then -- add EltreumTarget, to make it so when options are disabled ElvUI_Target is not still changing colors
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
	end


	--more long term checks, in case somehow people enable 2 settings when its not possible to do so. Maybe its a shared profile from another person? No idea how they manage to do this
	if E.db.ElvUI_EltreumUI.lightmode == true and E.db.ElvUI_EltreumUI.darkmode == true then --convert the option
		E.db.ElvUI_EltreumUI.darkmode = false
	end
	if E.db.ElvUI_EltreumUI.gradientmode.enable == true and E.db.ElvUI_EltreumUI.ufcustomtexture.enable == true then --convert the option
		E.db.ElvUI_EltreumUI.ufcustomtexture.enable = false
	end
	if E.db.ElvUI_EltreumUI.nameplateOptions.targetclasstexture == true and E.db.ElvUI_EltreumUI.nameplateOptions.playerclass == true then
		E.db.ElvUI_EltreumUI.nameplateOptions.targetclasstexture = false
	end
	if E.db.ElvUI_EltreumUI.afkmusic.racial == true and E.db.ElvUI_EltreumUI.afkmusic.racial == true then
		E.db.ElvUI_EltreumUI.afkmusic.racial = false
	end
	if E.db.ElvUI_EltreumUI.glow.blizzard == true and E.db.ElvUI_EltreumUI.glow.pixel == true then
		E.db.ElvUI_EltreumUI.glow.blizzard = false
	elseif E.db.ElvUI_EltreumUI.glow.blizzard == true and E.db.ElvUI_EltreumUI.glow.autocast == true then
		E.db.ElvUI_EltreumUI.glow.blizzard = false
	elseif E.db.ElvUI_EltreumUI.glow.autocast == true and E.db.ElvUI_EltreumUI.glow.pixel == true then
		E.db.ElvUI_EltreumUI.glow.autocast = false
	elseif E.db.ElvUI_EltreumUI.glow.autocast == true and E.db.ElvUI_EltreumUI.glow.pixel == true and E.db.ElvUI_EltreumUI.glow.blizzard == true then
		E.db.ElvUI_EltreumUI.glow.autocast = false
		E.db.ElvUI_EltreumUI.glow.blizzard = false
	end
	if E.db.ElvUI_EltreumUI.skins.classiconsblizz == true and E.db.ElvUI_EltreumUI.skins.classiconsreleaf == true then
		E.db.ElvUI_EltreumUI.skins.classiconsblizz = false
	end
end
