local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local IsAddOnLoaded = IsAddOnLoaded

function ElvUI_EltreumUI:VersionCheckInit()
	ElvUI_EltreumUI:PluginCheck()
	ElvUI_EltreumUI:OldVersionCheck()
	ElvUI_EltreumUI:NewVersionCheck()
	ElvUI_EltreumUI:ElvUIVersionCheck()
	if E.private.ElvUI_EltreumUI.install_version < "2.7.3" then
		ElvUI_EltreumUI:DatabaseConversions()
	end
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

--Based on ElvUI's and SLE's db convert
function ElvUI_EltreumUI:DatabaseConversions()
	if E.private.ElvUI_EltreumUI.install_version ~= nil and E.private.ElvUI_EltreumUI.install_version < "2.7.3" then
		local ProfileNames = "NONE"
		local CharacterNames = "NONE"
		--Profile options conversion
		for profile, data in pairs(ElvDB.profiles) do
			local profileChanged = false
			if data then
				if data.ElvUI_EltreumUI then
					if data.ElvUI_EltreumUI.nameplatepower then
						if data.ElvUI_EltreumUI.nameplatepower.autoadjustposition == nil then
							E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
						elseif data.ElvUI_EltreumUI.nameplatepower.autoadjustposition == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition, data.ElvUI_EltreumUI.nameplatepower.autoadjustposition)
						end
					elseif data.ElvUI_EltreumUI.nameplatepower == nil then
						--if data.ElvUI_EltreumUI.nameplatepower.autoadjustposition == nil then
							E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
						--end
					end
					if data.ElvUI_EltreumUI.chat.enable then
						if data.ElvUI_EltreumUI.chat.enable == nil then
							E.db.ElvUI_EltreumUI.chat.enable = true
						elseif data.ElvUI_EltreumUI.chat.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.enable, data.ElvUI_EltreumUI.chat.enable)
						end
						if data.ElvUI_EltreumUI.chat.leftcombathide == nil then
							E.db.ElvUI_EltreumUI.chat.leftcombathide = true
						elseif data.ElvUI_EltreumUI.chat.leftcombathide == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.leftcombathide, data.ElvUI_EltreumUI.chat.leftcombathide)
						end
						if data.ElvUI_EltreumUI.chat.colorsysmsg == nil then
							E.db.ElvUI_EltreumUI.chat.colorsysmsg = true
						elseif data.ElvUI_EltreumUI.chat.colorsysmsg == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.colorsysmsg, data.ElvUI_EltreumUI.chat.colorsysmsg)
						end
						if data.ElvUI_EltreumUI.chat.looticons == nil then
							E.db.ElvUI_EltreumUI.chat.looticons = true
						elseif data.ElvUI_EltreumUI.chat.looticons == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.looticons, data.ElvUI_EltreumUI.chat.looticons)
						end
					elseif data.ElvUI_EltreumUI.chat.enable == nil then
						E.db.ElvUI_EltreumUI.chat.enable = true
						E.db.ElvUI_EltreumUI.chat.leftcombathide = true
						E.db.ElvUI_EltreumUI.chat.colorsysmsg = true
						E.db.ElvUI_EltreumUI.chat.looticons = true
					end
					if data.ElvUI_EltreumUI.cvars then
						if data.ElvUI_EltreumUI.cvars.autohidenpcname == nil then
							E.db.ElvUI_EltreumUI.cvars.autohidenpcname = true
						elseif data.ElvUI_EltreumUI.cvars.autohidenpcname == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cvars.autohidenpcname, data.ElvUI_EltreumUI.cvars.autohidenpcname)
						end
					elseif data.ElvUI_EltreumUI.cvars == nil then
						E.db.ElvUI_EltreumUI.cvars.autohidenpcname = true
					end
					if data.ElvUI_EltreumUI.skins then
						if data.ElvUI_EltreumUI.skins.enable == nil then
							E.db.ElvUI_EltreumUI.skins.enable = true
						elseif data.ElvUI_EltreumUI.skins.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.enable, data.ElvUI_EltreumUI.skins.enable)
						end
						if data.ElvUI_EltreumUI.skins.widertransmog == nil then
							E.db.ElvUI_EltreumUI.skins.widertransmog = true
						elseif data.ElvUI_EltreumUI.skins.widertransmog == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.widertransmog, data.ElvUI_EltreumUI.skins.widertransmog)
						end
						if data.ElvUI_EltreumUI.skins.expandedstable == nil then
							E.db.ElvUI_EltreumUI.skins.expandedstable = true
						elseif data.ElvUI_EltreumUI.skins.expandedstable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandedstable, data.ElvUI_EltreumUI.skins.expandedstable)
						end
						if data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel == nil then
							E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
						elseif data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel, data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel)
						end
						if data.ElvUI_EltreumUI.skins.classiconsreleaf == nil then
							E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
						elseif data.ElvUI_EltreumUI.skins.classiconsreleaf == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsreleaf, data.ElvUI_EltreumUI.skins.classiconsreleaf)
						end
						if data.ElvUI_EltreumUI.skins.classicarmory == nil then
							E.db.ElvUI_EltreumUI.skins.classicarmory = true
						elseif data.ElvUI_EltreumUI.skins.classicarmory == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmory, data.ElvUI_EltreumUI.skins.classicarmory)
						end
						if data.ElvUI_EltreumUI.skins.classicarmoryautostats == nil then
							E.db.ElvUI_EltreumUI.skins.classicarmoryautostats = true
						elseif data.ElvUI_EltreumUI.skins.classicarmoryautostats == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmoryautostats, data.ElvUI_EltreumUI.skins.classicarmoryautostats)
						end
						if data.ElvUI_EltreumUI.skins.ilvls == nil then
							E.db.ElvUI_EltreumUI.skins.ilvls = true
						elseif data.ElvUI_EltreumUI.skins.ilvls == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.ilvls, data.ElvUI_EltreumUI.skins.ilvls)
						end
						if data.ElvUI_EltreumUI.skins.expandarmorybg == nil then
							E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
						elseif data.ElvUI_EltreumUI.skins.expandarmorybg == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandarmorybg, data.ElvUI_EltreumUI.skins.expandarmorybg)
						end
						if data.ElvUI_EltreumUI.skins.bossemote == nil then
							E.db.ElvUI_EltreumUI.skins.bossemote = true
						elseif data.ElvUI_EltreumUI.skins.bossemote == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.bossemote, data.ElvUI_EltreumUI.skins.bossemote)
						end
						if data.ElvUI_EltreumUI.skins.quests == nil then
							E.db.ElvUI_EltreumUI.skins.quests = true
						elseif data.ElvUI_EltreumUI.skins.quests == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.quests, data.ElvUI_EltreumUI.skins.quests)
						end
						if data.ElvUI_EltreumUI.skins.zones == nil then
							E.db.ElvUI_EltreumUI.skins.zones = true
						elseif data.ElvUI_EltreumUI.skins.zones == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.zones, data.ElvUI_EltreumUI.skins.zones)
						end
						if data.ElvUI_EltreumUI.skins.shadows == nil then
							E.db.ElvUI_EltreumUI.skins.shadows = true
						elseif data.ElvUI_EltreumUI.skins.shadows == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadows, data.ElvUI_EltreumUI.skins.shadows)
						end
					elseif data.ElvUI_EltreumUI.skins == nil then
						E.db.ElvUI_EltreumUI.skins.enable = true
						E.db.ElvUI_EltreumUI.skins.widertransmog = true
						E.db.ElvUI_EltreumUI.skins.expandedstable = true
						E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
						E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
						E.db.ElvUI_EltreumUI.skins.classicarmory = true
						E.db.ElvUI_EltreumUI.skins.classicarmoryautostats = true
						E.db.ElvUI_EltreumUI.skins.ilvls = true
						E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
						E.db.ElvUI_EltreumUI.skins.bossemote = true
						E.db.ElvUI_EltreumUI.skins.quests = true
						E.db.ElvUI_EltreumUI.skins.zones = true
						E.db.ElvUI_EltreumUI.skins.shadows = true
					end
					if data.ElvUI_EltreumUI.shadows then
						if data.ElvUI_EltreumUI.shadows.aura == nil then
							E.db.ElvUI_EltreumUI.shadows.aura = true
						elseif data.ElvUI_EltreumUI.shadows.aura == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.aura, data.ElvUI_EltreumUI.shadows.aura)
						end
						if data.ElvUI_EltreumUI.shadows.ufaura == nil then
							E.db.ElvUI_EltreumUI.shadows.ufaura = true
						elseif data.ElvUI_EltreumUI.shadows.ufaura == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.ufaura, data.ElvUI_EltreumUI.shadows.ufaura)
						end
						if data.ElvUI_EltreumUI.shadows.actionbars == nil then
							E.db.ElvUI_EltreumUI.shadows.actionbars = true
						elseif data.ElvUI_EltreumUI.shadows.actionbars == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.actionbars, data.ElvUI_EltreumUI.shadows.actionbars)
						end
					elseif data.ElvUI_EltreumUI.shadows == nil then
						E.db.ElvUI_EltreumUI.shadows.aura = true
						E.db.ElvUI_EltreumUI.shadows.ufaura = true
						E.db.ElvUI_EltreumUI.shadows.actionbars = true
					end
					if data.ElvUI_EltreumUI.tbctalents then
						if data.ElvUI_EltreumUI.tbctalents.enable == nil then
							E.db.ElvUI_EltreumUI.tbctalents.enable = true
						elseif data.ElvUI_EltreumUI.tbctalents.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.tbctalents.enable, data.ElvUI_EltreumUI.tbctalents.enable)
						end
					elseif data.ElvUI_EltreumUI.tbctalents == nil then
						E.db.ElvUI_EltreumUI.tbctalents.enable = true
					end
					if data.ElvUI_EltreumUI.dynamicdatatext then
						if data.ElvUI_EltreumUI.dynamicdatatext.enable == nil then
							E.db.ElvUI_EltreumUI.dynamicdatatext.enable = true
						elseif data.ElvUI_EltreumUI.dynamicdatatext.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.dynamicdatatext.enable, data.ElvUI_EltreumUI.dynamicdatatext.enable)
						end
					elseif data.ElvUI_EltreumUI.dynamicdatatext == nil then
						E.db.ElvUI_EltreumUI.dynamicdatatext.enable = true
					end
					if data.ElvUI_EltreumUI.nameplatelevel then
						if data.ElvUI_EltreumUI.nameplatelevel.enable == nil then
							E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
						elseif data.ElvUI_EltreumUI.nameplatelevel.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatelevel.enable, data.ElvUI_EltreumUI.nameplatelevel.enable)
						end
					elseif data.ElvUI_EltreumUI.nameplatelevel == nil then
						E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
					end
					if data.ElvUI_EltreumUI.cursor then
						if data.ElvUI_EltreumUI.cursor.enable == nil then
							E.db.ElvUI_EltreumUI.cursor.enable = true
						elseif data.ElvUI_EltreumUI.cursor.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.enable, data.ElvUI_EltreumUI.cursor.enable)
						end
						if data.ElvUI_EltreumUI.cursor.cooldown == nil then
							E.db.ElvUI_EltreumUI.cursor.cooldown = true
						elseif data.ElvUI_EltreumUI.cursor.cooldown == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.cooldown, data.ElvUI_EltreumUI.cursor.cooldown)
						end
						if data.ElvUI_EltreumUI.cursor.combat == nil then
							E.db.ElvUI_EltreumUI.cursor.combat = true
						elseif data.ElvUI_EltreumUI.cursor.combat == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.combat, data.ElvUI_EltreumUI.cursor.combat)
						end
					elseif data.ElvUI_EltreumUI.cursor == nil then
						E.db.ElvUI_EltreumUI.cursor.enable = true
						E.db.ElvUI_EltreumUI.cursor.cooldown = true
						E.db.ElvUI_EltreumUI.cursor.combat = true
					end
					if data.ElvUI_EltreumUI.nameplateOptions then
						if data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
						elseif data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow, data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow)
						end
						if data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
						elseif data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate, data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate)
						end
						if data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
						elseif data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture, data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture)
						end
						if data.ElvUI_EltreumUI.nameplateOptions.classbarautohide == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
						elseif data.ElvUI_EltreumUI.nameplateOptions.classbarautohide == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide, data.ElvUI_EltreumUI.nameplateOptions.classbarautohide)
						end
					elseif data.ElvUI_EltreumUI.nameplateOptions == nil then
						E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
						E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
						E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
						E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
					end
					if data.ElvUI_EltreumUI.stealthOptions then
						if data.ElvUI_EltreumUI.stealthOptions.stealtheffect == nil then
							E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
						elseif data.ElvUI_EltreumUI.stealthOptions.stealtheffect == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect, data.ElvUI_EltreumUI.stealthOptions.stealtheffect)
						end
					elseif data.ElvUI_EltreumUI.stealthOptions then
						E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
					end
					if data.ElvUI_EltreumUI.glow then
						if data.ElvUI_EltreumUI.glow.enable == nil then
							E.db.ElvUI_EltreumUI.glow.enable = true
						elseif data.ElvUI_EltreumUI.glow.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.enable, data.ElvUI_EltreumUI.glow.enable)
						end
						if data.ElvUI_EltreumUI.glow.enablepet == nil then
							E.db.ElvUI_EltreumUI.glow.enablepet = true
						elseif data.ElvUI_EltreumUI.glow.enablepet == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.enablepet, data.ElvUI_EltreumUI.glow.enablepet)
						end
					elseif data.ElvUI_EltreumUI.glow == nil then
						E.db.ElvUI_EltreumUI.glow.enable = true
						E.db.ElvUI_EltreumUI.glow.enablepet = true
					end
					if data.ElvUI_EltreumUI.partyraiddeath then
						if data.ElvUI_EltreumUI.partyraiddeath.enable == nil then
							E.db.ElvUI_EltreumUI.partyraiddeath.enable = true
						elseif data.ElvUI_EltreumUI.partyraiddeath.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.partyraiddeath.enable, data.ElvUI_EltreumUI.partyraiddeath.enable)
						end
					elseif data.ElvUI_EltreumUI.partyraiddeath == nil then
						E.db.ElvUI_EltreumUI.partyraiddeath.enable = true
					end
					if data.ElvUI_EltreumUI.friendlynameplatetoggle then
						if data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames and data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames == nil then
							E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = true
						elseif data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames, data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames)
						end
					elseif data.ElvUI_EltreumUI.friendlynameplatetoggle == nil then
						E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = true
					end
					if data.ElvUI_EltreumUI.afkmusic then
						if data.ElvUI_EltreumUI.afkmusic.enable == nil then
							E.db.ElvUI_EltreumUI.afkmusic.enable = true
						elseif data.ElvUI_EltreumUI.afkmusic.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.enable, data.ElvUI_EltreumUI.afkmusic.enable)
						end
					elseif data.ElvUI_EltreumUI.afkmusic == nil then
						E.db.ElvUI_EltreumUI.afkmusic.enable = true
					end
					if data.ElvUI_EltreumUI.waypointetasetting then
						if data.ElvUI_EltreumUI.waypointetasetting.enable == nil then
							E.db.ElvUI_EltreumUI.waypointetasetting.enable = true
						elseif data.ElvUI_EltreumUI.waypointetasetting.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.enable, data.ElvUI_EltreumUI.waypointetasetting.enable)
						end
						if data.ElvUI_EltreumUI.waypointetasetting.autopin == nil then
							E.db.ElvUI_EltreumUI.waypointetasetting.autopin = true
						elseif data.ElvUI_EltreumUI.waypointetasetting.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.autopin, data.ElvUI_EltreumUI.waypointetasetting.autopin)
						end
					elseif data.ElvUI_EltreumUI.waypointetasetting == nil then
						E.db.ElvUI_EltreumUI.waypointetasetting.enable = true
						E.db.ElvUI_EltreumUI.waypointetasetting.autopin = true
					end
					if data.ElvUI_EltreumUI.waytext then
						if data.ElvUI_EltreumUI.waytext.enable == nil then
							E.db.ElvUI_EltreumUI.waytext.enable = true
						elseif data.ElvUI_EltreumUI.waytext.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.waytext.enable, data.ElvUI_EltreumUI.waytext.enable)
						end
					elseif data.ElvUI_EltreumUI.waytext == nil then
						E.db.ElvUI_EltreumUI.waytext.enable = true
					end
					if data.ElvUI_EltreumUI.widenameplate then
						if data.ElvUI_EltreumUI.widenameplate.enable == nil then
							E.db.ElvUI_EltreumUI.widenameplate.enable = true
						elseif data.ElvUI_EltreumUI.widenameplate.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.enable, data.ElvUI_EltreumUI.widenameplate.enable)
						end
						if data.ElvUI_EltreumUI.widenameplate.npglow == nil then
							E.db.ElvUI_EltreumUI.widenameplate.npglow = true
						elseif data.ElvUI_EltreumUI.widenameplate.npglow == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.npglow, data.ElvUI_EltreumUI.widenameplate.npglow)
						end
					elseif data.ElvUI_EltreumUI.widenameplate == nil then
						E.db.ElvUI_EltreumUI.widenameplate.enable = true
						E.db.ElvUI_EltreumUI.widenameplate.npglow = true
					end
					if data.ElvUI_EltreumUI.questsettings then
						if data.ElvUI_EltreumUI.questsettings.enable == nil then
							E.db.ElvUI_EltreumUI.questsettings.enable = true
						elseif data.ElvUI_EltreumUI.questsettings.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.enable, data.ElvUI_EltreumUI.questsettings.enable)
						end
						if data.ElvUI_EltreumUI.questsettings.rogueopen == nil then
							E.db.ElvUI_EltreumUI.questsettings.rogueopen = true
						elseif data.ElvUI_EltreumUI.questsettings.rogueopen == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.rogueopen, data.ElvUI_EltreumUI.questsettings.rogueopen)
						end
						if data.ElvUI_EltreumUI.questsettings.arena == nil then
							E.db.ElvUI_EltreumUI.questsettings.arena = true
						elseif data.ElvUI_EltreumUI.questsettings.arena == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.arena, data.ElvUI_EltreumUI.questsettings.arena)
						end
						if data.ElvUI_EltreumUI.questsettings.questitemsbar1 == nil then
							E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
						elseif data.ElvUI_EltreumUI.questsettings.questitemsbar1 == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.questitemsbar1, data.ElvUI_EltreumUI.questsettings.questitemsbar1)
						end
					elseif data.ElvUI_EltreumUI.questsettings == nil then
						E.db.ElvUI_EltreumUI.questsettings.enable = true
						E.db.ElvUI_EltreumUI.questsettings.rogueopen = true
						E.db.ElvUI_EltreumUI.questsettings.arena = true
						E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
					end
					if data.ElvUI_EltreumUI.loottext then
						if data.ElvUI_EltreumUI.loottext.enable == nil then
							E.db.ElvUI_EltreumUI.loottext.enable = true
						elseif data.ElvUI_EltreumUI.loottext.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.enable, data.ElvUI_EltreumUI.loottext.enable)
						end
						if data.ElvUI_EltreumUI.loottext.fontsetting == nil then
							E.db.ElvUI_EltreumUI.loottext.fontsetting = true
						elseif data.ElvUI_EltreumUI.loottext.fontsetting == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.fontsetting, data.ElvUI_EltreumUI.loottext.fontsetting)
						end
					elseif data.ElvUI_EltreumUI.loottext == nil then
						E.db.ElvUI_EltreumUI.loottext.enable = true
						E.db.ElvUI_EltreumUI.loottext.fontsetting = true
					end
					if data.ElvUI_EltreumUI.modetexture then
						if data.ElvUI_EltreumUI.modetexture == nil then
							E.db.ElvUI_EltreumUI.modetexture = true
						elseif data.ElvUI_EltreumUI.modetexture == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.modetexture, data.ElvUI_EltreumUI.modetexture)
						end
					elseif data.ElvUI_EltreumUI.modetexture == nil then
						E.db.ElvUI_EltreumUI.modetexture = true
					end
					if data.ElvUI_EltreumUI.sparkcustomcolor then
						if data.ElvUI_EltreumUI.sparkcustomcolor.enable == nil then
							E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = true
						elseif data.ElvUI_EltreumUI.sparkcustomcolor.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.sparkcustomcolor.enable, data.ElvUI_EltreumUI.sparkcustomcolor.enable)
						end
					elseif data.ElvUI_EltreumUI.sparkcustomcolor == nil then
						E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = true
					end
					if data.ElvUI_EltreumUI.otherstuff then
						if data.ElvUI_EltreumUI.otherstuff.fastloot == nil then
							E.db.ElvUI_EltreumUI.otherstuff.fastloot = true
						elseif data.ElvUI_EltreumUI.otherstuff.fastloot == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
						end
						if data.ElvUI_EltreumUI.otherstuff.screenshot == nil then
							E.db.ElvUI_EltreumUI.otherstuff.screenshot = true
						elseif data.ElvUI_EltreumUI.otherstuff.screenshot == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.screenshot, data.ElvUI_EltreumUI.otherstuff.screenshot)
						end
						if data.ElvUI_EltreumUI.otherstuff.hidetalkinghead == nil then
							E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
						elseif data.ElvUI_EltreumUI.otherstuff.hidetalkinghead == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead, data.ElvUI_EltreumUI.otherstuff.hidetalkinghead)
						end
						if data.ElvUI_EltreumUI.otherstuff.blizzcombattext == nil then
							E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
						elseif data.ElvUI_EltreumUI.otherstuff.blizzcombattext == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext, data.ElvUI_EltreumUI.otherstuff.blizzcombattext)
						end
						if data.ElvUI_EltreumUI.otherstuff.dynamicxpbar == nil then
							E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
						elseif data.ElvUI_EltreumUI.otherstuff.dynamicxpbar == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar, data.ElvUI_EltreumUI.otherstuff.dynamicxpbar)
						end
					elseif data.ElvUI_EltreumUI.otherstuff == nil then
						E.db.ElvUI_EltreumUI.otherstuff.fastloot = true
						E.db.ElvUI_EltreumUI.otherstuff.screenshot = true
						E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
						E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
						E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
					end
					--E:CopyTable(E.db.ElvUI_EltreumUI, data.ElvUI_EltreumUI)
					--data.ElvUI_EltreumUI = nil
					profileChanged = true
				end
				if profileChanged then
					if ProfileNames == "NONE" then
						ProfileNames = profile
					else
						ProfileNames = ProfileNames..', '..profile
					end
				end
			end
		end

		--Private options convert
		for private, data in pairs(ElvPrivateDB.profiles) do
			local privateChanged = false
			if data then
				if data.ElvUI_EltreumUI then
					if data.ElvUI_EltreumUI.nameplatepower then
						if data.ElvUI_EltreumUI.nameplatepower.enable == nil or data.ElvUI_EltreumUI.nameplatepower.enable == true then
							E.private.ElvUI_EltreumUI.nameplatepower.enable = true
						elseif data.ElvUI_EltreumUI.nameplatepower.enable == false then
							E.private.ElvUI_EltreumUI.nameplatepower.enable = false
							--E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.enable, data.ElvUI_EltreumUI.nameplatepower.enable)
						end
					elseif data.ElvUI_EltreumUI.nameplatepower == nil or data.ElvUI_EltreumUI.nameplatepower == true then
						E.private.ElvUI_EltreumUI.nameplatepower.enable = true
					end
					if data.ElvUI_EltreumUI.combatmusic then
						if data.ElvUI_EltreumUI.combatmusic.enable == nil or data.ElvUI_EltreumUI.combatmusic.enable == true then
							E.private.ElvUI_EltreumUI.combatmusic.enable = true
						elseif data.ElvUI_EltreumUI.combatmusic.enable == false then
							E.private.ElvUI_EltreumUI.combatmusic.enable = false
							--E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.enable, data.ElvUI_EltreumUI.combatmusic.enable)
						end
						if data.ElvUI_EltreumUI.combatmusic.disableinstance == nil or data.ElvUI_EltreumUI.combatmusic.disableinstance == true then
							E.private.ElvUI_EltreumUI.combatmusic.disableinstance = true
						elseif data.ElvUI_EltreumUI.combatmusic.disableinstance == false then
							E.private.ElvUI_EltreumUI.combatmusic.disableinstance = false
							--E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.disableinstance, data.ElvUI_EltreumUI.combatmusic.disableinstance)
						end
					elseif data.ElvUI_EltreumUI.combatmusic == nil or data.ElvUI_EltreumUI.combatmusic == true then
							E.private.ElvUI_EltreumUI.combatmusic.enable = true
							E.private.ElvUI_EltreumUI.combatmusic.disableinstance = true
					end
					--E:CopyTable(E.private.ElvUI_EltreumUI, data.ElvUI_EltreumUI)
					--data.ElvUI_EltreumUI = nil
					privateChanged = true
				end
				if privateChanged then
					if CharacterNames == "NONE" then
						CharacterNames = private
					else
						CharacterNames = CharacterNames..', '..private
					end
				end
			end
		end

		E:StaggeredUpdateAll(nil, true)

		E.PopupDialogs['ELTRUISMDBCONVERT'] = {
			text = L["Eltruism database was converted.\n|cff82B4ffThe Following profiles were updated:|r\n%s\n\n|cff82B4ffPrivate settings were updated for the following characters:|r\n%s\n\n|cff82B4ffIf you have any issues please report in Discord or open a ticket|r"],
			--button1 = OKAY,
			button1 = RELOADUI,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}

		E:StaticPopup_Show('ELTRUISMDBCONVERT', ProfileNames, CharacterNames)

		E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	end
end
