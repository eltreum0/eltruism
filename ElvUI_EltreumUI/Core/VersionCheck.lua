local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local IsAddOnLoaded = IsAddOnLoaded

function ElvUI_EltreumUI:VersionCheckInit()
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
	if ElvUI_EltreumUI.Retail then
		if E.version < 12.62 then
			ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
		end
	end
	if ElvUI_EltreumUI.TBC then
		if E.version < 2.34 then
			ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
		end
	end
	if ElvUI_EltreumUI.Classic then
		if E.version < 1.60 then
			ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
		end
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
			if ElvUI_EltreumUI.Retail then
				E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
			end
			if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
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
			if ElvUI_EltreumUI.Retail then
				E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
			end
			ElvUI_EltreumUI:Print('Please go to: |cffff0000ElvUI > Unitframes > Group Units > Party/Raid/Raid40 > Aura Indicator >|r Set them to |cffff0000Textured Icon with Display Timer|r')
			ElvUI_EltreumUI:Print('This setting cannot be set through the plugin without causing errors. It will improve your experience making it easier to see which buffs/debuffs your party/raid/raid40 has. This message will only be displayed once.')
		end
	elseif E.private.ElvUI_EltreumUI.install_version > "2.2.1" and E.private.ElvUI_EltreumUI.install_version < "2.3.0" then
		E.private.ElvUI_EltreumUI.install_version = "2.3.0"
		if ElvUI_EltreumUI.Retail then
			E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
		end
		ElvUI_EltreumUI:Print('Chat modifications were recently added, please check Eltruism > Chat if you want to turn them off. You can Left click on a Chat Panel enable them (reloading will reset this)')
		ElvUI_EltreumUI:Print('More options were added to Nameplate Power Bar, such as the ability to change its size, position and texture. Configure it in Eltruism > Nameplates')
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.3.0" and E.private.ElvUI_EltreumUI.install_version < "2.4.0" then
		E.private.ElvUI_EltreumUI.install_version = "2.4.0"
		if ElvUI_EltreumUI.Retail then
			E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
		end
		ElvUI_EltreumUI:Print('Chat modifications were recently added, please check Eltruism > Chat if you want to turn them off. You can Left click on a Chat Panel enable them (reloading will reset this)')
		ElvUI_EltreumUI:Print('More options were added to Nameplate Power Bar, such as the ability to change its size, position and texture. Configure it in Eltruism > Nameplates')
		ElvUI_EltreumUI:Print('Borders released, you can test this feature in Eltruism > Borders. You might need to adjust settings to fit your action bars')
		ElvUI_EltreumUI:Print('Cooldowns were added to Cursor recently, thats why you see icons when you try to use a skill again')
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.4.0" and E.private.ElvUI_EltreumUI.install_version < "2.4.5" then
		if ElvUI_EltreumUI.Retail then
			E.db["WT"]["social"]["chatText"]["roleIconStyle"] = "BLIZZARD" --update role icons
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "2.4.6" then
		if ElvUI_EltreumUI.Retail then
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
	end
end
