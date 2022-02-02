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
							data.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
							E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition, data.ElvUI_EltreumUI.nameplatepower.autoadjustposition)
						elseif data.ElvUI_EltreumUI.nameplatepower.autoadjustposition == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition, data.ElvUI_EltreumUI.nameplatepower.autoadjustposition)
						end
					elseif data.ElvUI_EltreumUI.nameplatepower == nil then
							data.ElvUI_EltreumUI.nameplatepower = {
								autoadjustposition = false,
								sizex = 132,
								sizey = 6,
								posy = 16,
								texture = "Eltreum-Elvui-Norm",
								r = 0,
								g = 0,
								b = 0,
							}
							data.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
							E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition, data.ElvUI_EltreumUI.nameplatepower.autoadjustposition)
					end
					if data.ElvUI_EltreumUI.chat then
						if data.ElvUI_EltreumUI.chat.enable == nil then
							E.db.ElvUI_EltreumUI.chat.enable = true
							data.ElvUI_EltreumUI.chat.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.enable, data.ElvUI_EltreumUI.chat.enable)
						elseif data.ElvUI_EltreumUI.chat.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.enable, data.ElvUI_EltreumUI.chat.enable)
						end
						if data.ElvUI_EltreumUI.chat.leftcombathide == nil then
							E.db.ElvUI_EltreumUI.chat.leftcombathide = true
							data.ElvUI_EltreumUI.chat.leftcombathide = true
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.leftcombathide, data.ElvUI_EltreumUI.chat.leftcombathide)
						elseif data.ElvUI_EltreumUI.chat.leftcombathide == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.leftcombathide, data.ElvUI_EltreumUI.chat.leftcombathide)
						end
						if data.ElvUI_EltreumUI.chat.colorsysmsg == nil then
							E.db.ElvUI_EltreumUI.chat.colorsysmsg = true
							data.ElvUI_EltreumUI.chat.colorsysmsg = true
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.colorsysmsg, data.ElvUI_EltreumUI.chat.colorsysmsg)
						elseif data.ElvUI_EltreumUI.chat.colorsysmsg == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.colorsysmsg, data.ElvUI_EltreumUI.chat.colorsysmsg)
						end
						if data.ElvUI_EltreumUI.chat.looticons == nil then
							E.db.ElvUI_EltreumUI.chat.looticons = true
							data.ElvUI_EltreumUI.chat.looticons = true
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.looticons, data.ElvUI_EltreumUI.chat.looticons)
						elseif data.ElvUI_EltreumUI.chat.looticons == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.chat.looticons, data.ElvUI_EltreumUI.chat.looticons)
						end
					elseif data.ElvUI_EltreumUI.chat == nil then
						data.ElvUI_EltreumUI.chat = {
							enable = false,
							leftmouseover = false,
							rightmouseover = false,
							leftfader = false,
							rightfader = false,
							leftcombathide = false,
							rightcombathide = false,
							invertclick = false,
							colorsysmsg = false,
							rollsound = false,
							looticons = false,
						}
						E.db.ElvUI_EltreumUI.chat.enable = true
						E.db.ElvUI_EltreumUI.chat.leftcombathide = true
						E.db.ElvUI_EltreumUI.chat.colorsysmsg = true
						E.db.ElvUI_EltreumUI.chat.looticons = true
						data.ElvUI_EltreumUI.chat.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.chat.enable, data.ElvUI_EltreumUI.chat.enable)
						data.ElvUI_EltreumUI.chat.leftcombathide = true
						E:CopyTable(E.db.ElvUI_EltreumUI.chat.leftcombathide, data.ElvUI_EltreumUI.chat.leftcombathide)
						data.ElvUI_EltreumUI.chat.colorsysmsg = true
						E:CopyTable(E.db.ElvUI_EltreumUI.chat.colorsysmsg, data.ElvUI_EltreumUI.chat.colorsysmsg)
						data.ElvUI_EltreumUI.chat.looticons = true
						E:CopyTable(E.db.ElvUI_EltreumUI.chat.looticons, data.ElvUI_EltreumUI.chat.looticons)
					end
					if data.ElvUI_EltreumUI.skins then
						if data.ElvUI_EltreumUI.skins.enable == nil then
							E.db.ElvUI_EltreumUI.skins.enable = true
							data.ElvUI_EltreumUI.skins.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.enable, data.ElvUI_EltreumUI.skins.enable)
						elseif data.ElvUI_EltreumUI.skins.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.enable, data.ElvUI_EltreumUI.skins.enable)
						end
						if data.ElvUI_EltreumUI.skins.widertransmog == nil then
							E.db.ElvUI_EltreumUI.skins.widertransmog = true
							data.ElvUI_EltreumUI.skins.widertransmog = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.widertransmog, data.ElvUI_EltreumUI.skins.widertransmog)
						elseif data.ElvUI_EltreumUI.skins.widertransmog == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.widertransmog, data.ElvUI_EltreumUI.skins.widertransmog)
						end
						if data.ElvUI_EltreumUI.skins.expandedstable == nil then
							E.db.ElvUI_EltreumUI.skins.expandedstable = true
							data.ElvUI_EltreumUI.skins.expandedstable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandedstable, data.ElvUI_EltreumUI.skins.expandedstable)
						elseif data.ElvUI_EltreumUI.skins.expandedstable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandedstable, data.ElvUI_EltreumUI.skins.expandedstable)
						end
						if data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel == nil then
							E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
							data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel, data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel)
						elseif data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel, data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel)
						end
						if data.ElvUI_EltreumUI.skins.classiconsreleaf == nil then
							E.db.ElvUI_EltreumUI.skins.classiconsreleaf = true
							data.ElvUI_EltreumUI.skins.classiconsreleaf = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsreleaf, data.ElvUI_EltreumUI.skins.classiconsreleaf)
						elseif data.ElvUI_EltreumUI.skins.classiconsreleaf == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsreleaf, data.ElvUI_EltreumUI.skins.classiconsreleaf)
						end
						if data.ElvUI_EltreumUI.skins.classicarmory == nil then
							E.db.ElvUI_EltreumUI.skins.classicarmory = true
							data.ElvUI_EltreumUI.skins.classicarmory = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmory, data.ElvUI_EltreumUI.skins.classicarmory)
						elseif data.ElvUI_EltreumUI.skins.classicarmory == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmory, data.ElvUI_EltreumUI.skins.classicarmory)
						end
						if data.ElvUI_EltreumUI.skins.classicarmoryautostats == nil then
							E.db.ElvUI_EltreumUI.skins.classicarmoryautostats = true
							data.ElvUI_EltreumUI.skins.classicarmoryautostats = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmoryautostats, data.ElvUI_EltreumUI.skins.classicarmoryautostats)
						elseif data.ElvUI_EltreumUI.skins.classicarmoryautostats == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmoryautostats, data.ElvUI_EltreumUI.skins.classicarmoryautostats)
						end
						if data.ElvUI_EltreumUI.skins.ilvls == nil then
							E.db.ElvUI_EltreumUI.skins.ilvls = true
							data.ElvUI_EltreumUI.skins.ilvls = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.ilvls, data.ElvUI_EltreumUI.skins.ilvls)
						elseif data.ElvUI_EltreumUI.skins.ilvls == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.ilvls, data.ElvUI_EltreumUI.skins.ilvls)
						end
						if data.ElvUI_EltreumUI.skins.expandarmorybg == nil then
							E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
							data.ElvUI_EltreumUI.skins.expandarmorybg = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandarmorybg, data.ElvUI_EltreumUI.skins.expandarmorybg)
						elseif data.ElvUI_EltreumUI.skins.expandarmorybg == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandarmorybg, data.ElvUI_EltreumUI.skins.expandarmorybg)
						end
						if data.ElvUI_EltreumUI.skins.bossemote == nil then
							E.db.ElvUI_EltreumUI.skins.bossemote = true
							data.ElvUI_EltreumUI.skins.bossemote = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.bossemote, data.ElvUI_EltreumUI.skins.bossemote)
						elseif data.ElvUI_EltreumUI.skins.bossemote == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.bossemote, data.ElvUI_EltreumUI.skins.bossemote)
						end
						if data.ElvUI_EltreumUI.skins.quests == nil then
							E.db.ElvUI_EltreumUI.skins.quests = true
							data.ElvUI_EltreumUI.skins.quests = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.quests, data.ElvUI_EltreumUI.skins.quests)
						elseif data.ElvUI_EltreumUI.skins.quests == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.quests, data.ElvUI_EltreumUI.skins.quests)
						end
						if data.ElvUI_EltreumUI.skins.zones == nil then
							E.db.ElvUI_EltreumUI.skins.zones = true
							data.ElvUI_EltreumUI.skins.zones = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.zones, data.ElvUI_EltreumUI.skins.zones)
						elseif data.ElvUI_EltreumUI.skins.zones == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.zones, data.ElvUI_EltreumUI.skins.zones)
						end
						if data.ElvUI_EltreumUI.skins.shadows == nil then
							E.db.ElvUI_EltreumUI.skins.shadows = true
							data.ElvUI_EltreumUI.skins.shadows = true
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadows, data.ElvUI_EltreumUI.skins.shadows)
						elseif data.ElvUI_EltreumUI.skins.shadows == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadows, data.ElvUI_EltreumUI.skins.shadows)
						end
					elseif data.ElvUI_EltreumUI.skins == nil then
						data.ElvUI_EltreumUI.skins = {
							enable = false,
							widertransmog = false,
							expandedstable = false,
							classiconsoncharacterpanel = false,
							classiconsblizz = false,
							classiconsreleaf = false,
							classicarmory = false,
							classicarmoryautostats = false,
							ilvls = false,
							sockets = false,
							ilvlanchor = "CENTER",
							ilvlfontsize = 16,
							ilvlfontweight = "THICKOUTLINE",
							expandarmorybg = false,
							expandarmorybgalpha = 0.3,
							bossemote = false,
							quests = false,
							zones = false,
							shadows = false,
						}
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

						data.ElvUI_EltreumUI.skins.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.enable, data.ElvUI_EltreumUI.skins.enable)
						data.ElvUI_EltreumUI.skins.widertransmog = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.widertransmog, data.ElvUI_EltreumUI.skins.widertransmog)
						data.ElvUI_EltreumUI.skins.expandedstable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandedstable, data.ElvUI_EltreumUI.skins.expandedstable)
						data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel, data.ElvUI_EltreumUI.skins.classiconsoncharacterpanel)
						data.ElvUI_EltreumUI.skins.classiconsreleaf = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.classiconsreleaf, data.ElvUI_EltreumUI.skins.classiconsreleaf)
						data.ElvUI_EltreumUI.skins.classicarmory = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmory, data.ElvUI_EltreumUI.skins.classicarmory)
						data.ElvUI_EltreumUI.skins.classicarmoryautostats = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.classicarmoryautostats, data.ElvUI_EltreumUI.skins.classicarmoryautostats)
						data.ElvUI_EltreumUI.skins.ilvls = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.ilvls, data.ElvUI_EltreumUI.skins.ilvls)
						data.ElvUI_EltreumUI.skins.expandarmorybg = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.expandarmorybg, data.ElvUI_EltreumUI.skins.expandarmorybg)
						data.ElvUI_EltreumUI.skins.bossemote = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.bossemote, data.ElvUI_EltreumUI.skins.bossemote)
						data.ElvUI_EltreumUI.skins.quests = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.quests, data.ElvUI_EltreumUI.skins.quests)
						data.ElvUI_EltreumUI.skins.zones = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.zones, data.ElvUI_EltreumUI.skins.zones)
						data.ElvUI_EltreumUI.skins.shadows = true
						E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadows, data.ElvUI_EltreumUI.skins.shadows)
					end
					if data.ElvUI_EltreumUI.shadows then
						if data.ElvUI_EltreumUI.shadows.aura == nil then
							E.db.ElvUI_EltreumUI.shadows.aura = true
							data.ElvUI_EltreumUI.shadows.aura = true
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.aura, data.ElvUI_EltreumUI.shadows.aura)
						elseif data.ElvUI_EltreumUI.shadows.aura == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.aura, data.ElvUI_EltreumUI.shadows.aura)
						end
						if data.ElvUI_EltreumUI.shadows.ufaura == nil then
							E.db.ElvUI_EltreumUI.shadows.ufaura = true
							data.ElvUI_EltreumUI.shadows.ufaura = true
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.ufaura, data.ElvUI_EltreumUI.shadows.ufaura)
						elseif data.ElvUI_EltreumUI.shadows.ufaura == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.ufaura, data.ElvUI_EltreumUI.shadows.ufaura)
						end
						if data.ElvUI_EltreumUI.shadows.actionbars == nil then
							E.db.ElvUI_EltreumUI.shadows.actionbars = true
							data.ElvUI_EltreumUI.shadows.actionbars = true
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.actionbars, data.ElvUI_EltreumUI.shadows.actionbars)
						elseif data.ElvUI_EltreumUI.shadows.actionbars == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.shadows.actionbars, data.ElvUI_EltreumUI.shadows.actionbars)
						end
					elseif data.ElvUI_EltreumUI.shadows == nil then
						data.ElvUI_EltreumUI.shadows = {
							aura = false,
							ufaura = false,
							actionbars = false,
							nameplates = false, --healthbars
							npauras = false,
							npportraits = false,
							nppower = false,
							npcastbar = false,
						}
						E.db.ElvUI_EltreumUI.shadows.aura = true
						E.db.ElvUI_EltreumUI.shadows.ufaura = true
						E.db.ElvUI_EltreumUI.shadows.actionbars = true

						data.ElvUI_EltreumUI.shadows.aura = true
						E:CopyTable(E.db.ElvUI_EltreumUI.shadows.aura, data.ElvUI_EltreumUI.shadows.aura)
						data.ElvUI_EltreumUI.shadows.ufaura = true
						E:CopyTable(E.db.ElvUI_EltreumUI.shadows.ufaura, data.ElvUI_EltreumUI.shadows.ufaura)
						data.ElvUI_EltreumUI.shadows.actionbars = true
						E:CopyTable(E.db.ElvUI_EltreumUI.shadows.actionbars, data.ElvUI_EltreumUI.shadows.actionbars)
					end
					if data.ElvUI_EltreumUI.tbctalents then
						if data.ElvUI_EltreumUI.tbctalents.enable == nil then
							E.db.ElvUI_EltreumUI.tbctalents.enable = true
							data.ElvUI_EltreumUI.tbctalents.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.tbctalents.enable, data.ElvUI_EltreumUI.tbctalents.enable)
						elseif data.ElvUI_EltreumUI.tbctalents.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.tbctalents.enable, data.ElvUI_EltreumUI.tbctalents.enable)
						end
					elseif data.ElvUI_EltreumUI.tbctalents == nil then
						data.ElvUI_EltreumUI.tbctalents = {
							enable = false,
						}
						E.db.ElvUI_EltreumUI.tbctalents.enable = true
						data.ElvUI_EltreumUI.tbctalents.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.tbctalents.enable, data.ElvUI_EltreumUI.tbctalents.enable)
					end
					if data.ElvUI_EltreumUI.dynamicdatatext then
						if data.ElvUI_EltreumUI.dynamicdatatext.enable == nil then
							E.db.ElvUI_EltreumUI.dynamicdatatext.enable = true
							data.ElvUI_EltreumUI.dynamicdatatext.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.dynamicdatatext.enable, data.ElvUI_EltreumUI.dynamicdatatext.enable)
						elseif data.ElvUI_EltreumUI.dynamicdatatext.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.dynamicdatatext.enable, data.ElvUI_EltreumUI.dynamicdatatext.enable)
						end
					elseif data.ElvUI_EltreumUI.dynamicdatatext == nil then
						data.ElvUI_EltreumUI.dynamicdatatext = {
							enable = false,
						}
						E.db.ElvUI_EltreumUI.dynamicdatatext.enable = true
						data.ElvUI_EltreumUI.dynamicdatatext.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.dynamicdatatext.enable, data.ElvUI_EltreumUI.dynamicdatatext.enable)
					end
					if data.ElvUI_EltreumUI.nameplatelevel then
						if data.ElvUI_EltreumUI.nameplatelevel.enable == nil then
							E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
							data.ElvUI_EltreumUI.nameplatelevel.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatelevel.enable, data.ElvUI_EltreumUI.nameplatelevel.enable)
						elseif data.ElvUI_EltreumUI.nameplatelevel.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplatelevel.enable, data.ElvUI_EltreumUI.nameplatelevel.enable)
						end
					elseif data.ElvUI_EltreumUI.nameplatelevel == nil then
						data.ElvUI_EltreumUI.nameplatelevel = {
							enable = false,
						}
						E.db.ElvUI_EltreumUI.nameplatelevel.enable = true
						data.ElvUI_EltreumUI.nameplatelevel.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.nameplatelevel.enable, data.ElvUI_EltreumUI.nameplatelevel.enable)
					end
					if data.ElvUI_EltreumUI.cursor then
						if data.ElvUI_EltreumUI.cursor.enable == nil then
							E.db.ElvUI_EltreumUI.cursor.enable = true
							data.ElvUI_EltreumUI.cursor.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.enable, data.ElvUI_EltreumUI.cursor.enable)
						elseif data.ElvUI_EltreumUI.cursor.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.enable, data.ElvUI_EltreumUI.cursor.enable)
						end
						if data.ElvUI_EltreumUI.cursor.cooldown == nil then
							E.db.ElvUI_EltreumUI.cursor.cooldown = true
							data.ElvUI_EltreumUI.cursor.cooldown = true
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.cooldown, data.ElvUI_EltreumUI.cursor.cooldown)
						elseif data.ElvUI_EltreumUI.cursor.cooldown == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.cooldown, data.ElvUI_EltreumUI.cursor.cooldown)
						end
						if data.ElvUI_EltreumUI.cursor.combat == nil then
							E.db.ElvUI_EltreumUI.cursor.combat = true
							data.ElvUI_EltreumUI.cursor.combat = true
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.combat, data.ElvUI_EltreumUI.cursor.combat)
						elseif data.ElvUI_EltreumUI.cursor.combat == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursor.combat, data.ElvUI_EltreumUI.cursor.combat)
						end
					elseif data.ElvUI_EltreumUI.cursor == nil then
						data.ElvUI_EltreumUI.cursor = {
							enable = false,
							ring = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga',
							size = '-1',
							cooldown = false,
							fixlag = false,
							combat = true,
						}
						E.db.ElvUI_EltreumUI.cursor.enable = true
						E.db.ElvUI_EltreumUI.cursor.cooldown = true
						E.db.ElvUI_EltreumUI.cursor.combat = true

						data.ElvUI_EltreumUI.cursor.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.cursor.enable, data.ElvUI_EltreumUI.cursor.enable)
						data.ElvUI_EltreumUI.cursor.cooldown = true
						E:CopyTable(E.db.ElvUI_EltreumUI.cursor.cooldown, data.ElvUI_EltreumUI.cursor.cooldown)
						data.ElvUI_EltreumUI.cursor.combat = true
						E:CopyTable(E.db.ElvUI_EltreumUI.cursor.combat, data.ElvUI_EltreumUI.cursor.combat)
					end
					if data.ElvUI_EltreumUI.nameplateOptions then
						if data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
							data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow, data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow)
						elseif data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow, data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow)
						end
						if data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
							data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate, data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate)
						elseif data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate, data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate)
						end
						if data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
							data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture, data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture)
						elseif data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture, data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture)
						end
						if data.ElvUI_EltreumUI.nameplateOptions.classbarautohide == nil then
							E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
							data.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide, data.ElvUI_EltreumUI.nameplateOptions.classbarautohide)
						elseif data.ElvUI_EltreumUI.nameplateOptions.classbarautohide == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide, data.ElvUI_EltreumUI.nameplateOptions.classbarautohide)
						end
					elseif data.ElvUI_EltreumUI.nameplateOptions == nil then
						data.ElvUI_EltreumUI.nameplateOptions = {
							ClassColorGlow = false,
							ClassBorderNameplate = false,
							nameplatetexture = false,
							classbarautohide = false,
							targetclasstexture = false,
						}
						E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
						E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
						E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
						E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true

						data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow = true
						E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow, data.ElvUI_EltreumUI.nameplateOptions.ClassColorGlow)
						data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate = true
						E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate, data.ElvUI_EltreumUI.nameplateOptions.ClassBorderNameplate)
						data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture = true
						E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.nameplatetexture, data.ElvUI_EltreumUI.nameplateOptions.nameplatetexture)
						data.ElvUI_EltreumUI.nameplateOptions.classbarautohide = true
						E:CopyTable(E.db.ElvUI_EltreumUI.nameplateOptions.classbarautohide, data.ElvUI_EltreumUI.nameplateOptions.classbarautohide)
					end
					if data.ElvUI_EltreumUI.stealthOptions then
						if data.ElvUI_EltreumUI.stealthOptions.stealtheffect == nil then
							E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
							data.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
							E:CopyTable(E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect, data.ElvUI_EltreumUI.stealthOptions.stealtheffect)
						elseif data.ElvUI_EltreumUI.stealthOptions.stealtheffect == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect, data.ElvUI_EltreumUI.stealthOptions.stealtheffect)
						end
					elseif data.ElvUI_EltreumUI.stealthOptions == nil then
						data.ElvUI_EltreumUI.stealthOptions = {
							stealtheffect = false,
						}
						E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
						data.ElvUI_EltreumUI.stealthOptions.stealtheffect = true
						E:CopyTable(E.db.ElvUI_EltreumUI.stealthOptions.stealtheffect, data.ElvUI_EltreumUI.stealthOptions.stealtheffect)
					end
					if data.ElvUI_EltreumUI.glow then
						if data.ElvUI_EltreumUI.glow.enable == nil then
							E.db.ElvUI_EltreumUI.glow.enable = true
							data.ElvUI_EltreumUI.glow.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.enable, data.ElvUI_EltreumUI.glow.enable)
						elseif data.ElvUI_EltreumUI.glow.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.enable, data.ElvUI_EltreumUI.glow.enable)
						end
						if data.ElvUI_EltreumUI.glow.enablepet == nil then
							E.db.ElvUI_EltreumUI.glow.enablepet = true
							data.ElvUI_EltreumUI.glow.enablepet = true
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.enablepet, data.ElvUI_EltreumUI.glow.enablepet)
						elseif data.ElvUI_EltreumUI.glow.enablepet == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.enablepet, data.ElvUI_EltreumUI.glow.enablepet)
						end
						if data.ElvUI_EltreumUI.glow.pixel == nil then
							E.db.ElvUI_EltreumUI.glow.pixel = true
							data.ElvUI_EltreumUI.glow.pixel = true
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.pixel, data.ElvUI_EltreumUI.glow.pixel)
						elseif data.ElvUI_EltreumUI.glow.pixel == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.pixel, data.ElvUI_EltreumUI.glow.pixel)
						end
					elseif data.ElvUI_EltreumUI.glow == nil then
						data.ElvUI_EltreumUI.glow = {
							enable = false,
							enablepet = false,
							blizzard = false,
							pixel = false,
							autocast = false,
							colorclass = true,
							colorclasspet = true,
							colorclassnp = true,
							numberpixel = 9,
							frequencypixel = 1,
							lengthpixel = 3,
							thicknesspixel = 5,
							pixelxOffset = 5,
							pixelyOffset = 5,
							borderpixel = false,
							numberauto = 8,
							frequencyauto = 0.8,
							autoscale = 2,
							autoxOffset = 5,
							autoyOffset = 5,
							frequencyblizz = 0.5,
						}
						E.db.ElvUI_EltreumUI.glow.enable = true
						E.db.ElvUI_EltreumUI.glow.enablepet = true
						E.db.ElvUI_EltreumUI.glow.pixel = true

						data.ElvUI_EltreumUI.glow.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.glow.enable, data.ElvUI_EltreumUI.glow.enable)
						data.ElvUI_EltreumUI.glow.enablepet = true
						E:CopyTable(E.db.ElvUI_EltreumUI.glow.enablepet, data.ElvUI_EltreumUI.glow.enablepet)
						data.ElvUI_EltreumUI.glow.pixel = true
						E:CopyTable(E.db.ElvUI_EltreumUI.glow.pixel, data.ElvUI_EltreumUI.glow.pixel)
					end
					if data.ElvUI_EltreumUI.partyraiddeath then
						if data.ElvUI_EltreumUI.partyraiddeath.enable == nil then
							E.db.ElvUI_EltreumUI.partyraiddeath.enable = true
							data.ElvUI_EltreumUI.partyraiddeath.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.partyraiddeath.enable, data.ElvUI_EltreumUI.partyraiddeath.enable)
						elseif data.ElvUI_EltreumUI.partyraiddeath.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.partyraiddeath.enable, data.ElvUI_EltreumUI.partyraiddeath.enable)
						end
					elseif data.ElvUI_EltreumUI.partyraiddeath == nil then
						data.ElvUI_EltreumUI.partyraiddeath = {
							enable = false,
							bgdisable = false,
							playerdeathsound = "bruh",
						}
						E.db.ElvUI_EltreumUI.partyraiddeath.enable = true
						data.ElvUI_EltreumUI.partyraiddeath.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.partyraiddeath.enable, data.ElvUI_EltreumUI.partyraiddeath.enable)
					end
					if data.ElvUI_EltreumUI.friendlynameplatetoggle then
						if data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames == nil then
							E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = true
							data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = true
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames, data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames)
						elseif data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames, data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames)
						end
						if data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly == nil then
							E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendlys = false
							data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendlys = false
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly, data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly)
						elseif data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly, data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly)
						end
						if data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly == nil then
							E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false
							data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly, data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly)
						elseif data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly, data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly)
						end
					elseif data.ElvUI_EltreumUI.friendlynameplatetoggle == nil then
						data.ElvUI_EltreumUI.friendlynameplatetoggle = {
							disablefriendly = false,
							friendlynames = false,
							hidefriendly = false,
						}
						E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = true
						E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly = false
						E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false

						data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames = true
						E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames, data.ElvUI_EltreumUI.friendlynameplatetoggle.friendlynames)
						data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly = false
						E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly, data.ElvUI_EltreumUI.friendlynameplatetoggle.disablefriendly)
						data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly = false
						E:CopyTable(E.db.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly, data.ElvUI_EltreumUI.friendlynameplatetoggle.hidefriendly)
					end
					if data.ElvUI_EltreumUI.afkmusic then
						if data.ElvUI_EltreumUI.afkmusic.enable == nil then
							E.db.ElvUI_EltreumUI.afkmusic.enable = true
							data.ElvUI_EltreumUI.afkmusic.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.enable, data.ElvUI_EltreumUI.afkmusic.enable)
						elseif data.ElvUI_EltreumUI.afkmusic.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.enable, data.ElvUI_EltreumUI.afkmusic.enable)
						end
						if data.ElvUI_EltreumUI.afkmusic.racial == nil then
							E.db.ElvUI_EltreumUI.afkmusic.racial = true
							data.ElvUI_EltreumUI.afkmusic.racial = true
							E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.racial, data.ElvUI_EltreumUI.afkmusic.racial)
						elseif data.ElvUI_EltreumUI.afkmusic.racial == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.racial, data.ElvUI_EltreumUI.afkmusic.racial)
						end
					elseif data.ElvUI_EltreumUI.afkmusic == nil then
						data.ElvUI_EltreumUI.afkmusic = {
							enable = false,
							racial = true,
							playerclass = false,
						}
						E.db.ElvUI_EltreumUI.afkmusic.enable = true
						data.ElvUI_EltreumUI.afkmusic.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.enable, data.ElvUI_EltreumUI.afkmusic.enable)
						E.db.ElvUI_EltreumUI.afkmusic.racial = true
						data.ElvUI_EltreumUI.afkmusic.racial = true
						E:CopyTable(E.db.ElvUI_EltreumUI.afkmusic.racial, data.ElvUI_EltreumUI.afkmusic.racial)
					end
					if data.ElvUI_EltreumUI.waypointetasetting then
						if data.ElvUI_EltreumUI.waypointetasetting.enable == nil then
							E.db.ElvUI_EltreumUI.waypointetasetting.enable = true
							data.ElvUI_EltreumUI.waypointetasetting.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.enable, data.ElvUI_EltreumUI.waypointetasetting.enable)
						elseif data.ElvUI_EltreumUI.waypointetasetting.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.enable, data.ElvUI_EltreumUI.waypointetasetting.enable)
						end
						if data.ElvUI_EltreumUI.waypointetasetting.autopin == nil then
							E.db.ElvUI_EltreumUI.waypointetasetting.autopin = true
							data.ElvUI_EltreumUI.waypointetasetting.autopin = true
							E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.autopin, data.ElvUI_EltreumUI.waypointetasetting.autopin)
						elseif data.ElvUI_EltreumUI.waypointetasetting.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.autopin, data.ElvUI_EltreumUI.waypointetasetting.autopin)
						end
					elseif data.ElvUI_EltreumUI.waypointetasetting == nil then
						data.ElvUI_EltreumUI.waypointetasetting = {
							enable = false,
							autopin = false,
						}
						E.db.ElvUI_EltreumUI.waypointetasetting.enable = true
						E.db.ElvUI_EltreumUI.waypointetasetting.autopin = true

						data.ElvUI_EltreumUI.waypointetasetting.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.enable, data.ElvUI_EltreumUI.waypointetasetting.enable)
						data.ElvUI_EltreumUI.waypointetasetting.autopin = true
						E:CopyTable(E.db.ElvUI_EltreumUI.waypointetasetting.autopin, data.ElvUI_EltreumUI.waypointetasetting.autopin)
					end
					if data.ElvUI_EltreumUI.waytext then
						if data.ElvUI_EltreumUI.waytext.enable == nil then
							E.db.ElvUI_EltreumUI.waytext.enable = true
							data.ElvUI_EltreumUI.waytext.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.waytext.enable, data.ElvUI_EltreumUI.waytext.enable)
						elseif data.ElvUI_EltreumUI.waytext.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.waytext.enable, data.ElvUI_EltreumUI.waytext.enable)
						end
					elseif data.ElvUI_EltreumUI.waytext == nil then
						data.ElvUI_EltreumUI.waytext = {
							enable = false,
						}
						E.db.ElvUI_EltreumUI.waytext.enable = true
						data.ElvUI_EltreumUI.waytext.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.waytext.enable, data.ElvUI_EltreumUI.waytext.enable)
					end
					if data.ElvUI_EltreumUI.widenameplate then
						if data.ElvUI_EltreumUI.widenameplate.enable == nil then
							E.db.ElvUI_EltreumUI.widenameplate.enable = true
							data.ElvUI_EltreumUI.widenameplate.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.enable, data.ElvUI_EltreumUI.widenameplate.enable)
						elseif data.ElvUI_EltreumUI.widenameplate.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.enable, data.ElvUI_EltreumUI.widenameplate.enable)
						end
						if data.ElvUI_EltreumUI.widenameplate.npglow == nil then
							E.db.ElvUI_EltreumUI.widenameplate.npglow = true
							data.ElvUI_EltreumUI.widenameplate.npglow = true
							E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.npglow, data.ElvUI_EltreumUI.widenameplate.npglow)
						elseif data.ElvUI_EltreumUI.widenameplate.npglow == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.npglow, data.ElvUI_EltreumUI.widenameplate.npglow)
						end
					elseif data.ElvUI_EltreumUI.widenameplate == nil then
						data.ElvUI_EltreumUI.widenameplate = {
							enable = false,
							npglow = false,
						}
						E.db.ElvUI_EltreumUI.widenameplate.enable = true
						E.db.ElvUI_EltreumUI.widenameplate.npglow = true

						data.ElvUI_EltreumUI.widenameplate.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.enable, data.ElvUI_EltreumUI.widenameplate.enable)
						data.ElvUI_EltreumUI.widenameplate.npglow = true
						E:CopyTable(E.db.ElvUI_EltreumUI.widenameplate.npglow, data.ElvUI_EltreumUI.widenameplate.npglow)
					end
					if data.ElvUI_EltreumUI.questsettings then
						if data.ElvUI_EltreumUI.questsettings.enable == nil then
							E.db.ElvUI_EltreumUI.questsettings.enable = true
							data.ElvUI_EltreumUI.questsettings.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.enable, data.ElvUI_EltreumUI.questsettings.enable)
						elseif data.ElvUI_EltreumUI.questsettings.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.enable, data.ElvUI_EltreumUI.questsettings.enable)
						end
						if data.ElvUI_EltreumUI.questsettings.rogueopen == nil then
							E.db.ElvUI_EltreumUI.questsettings.rogueopen = true
							data.ElvUI_EltreumUI.questsettings.rogueopen = true
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.rogueopen, data.ElvUI_EltreumUI.questsettings.rogueopen)
						elseif data.ElvUI_EltreumUI.questsettings.rogueopen == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.rogueopen, data.ElvUI_EltreumUI.questsettings.rogueopen)
						end
						if data.ElvUI_EltreumUI.questsettings.arena == nil then
							E.db.ElvUI_EltreumUI.questsettings.arena = true
							data.ElvUI_EltreumUI.questsettings.arena = true
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.arena, data.ElvUI_EltreumUI.questsettings.arena)
						elseif data.ElvUI_EltreumUI.questsettings.arena == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.arena, data.ElvUI_EltreumUI.questsettings.arena)
						end
						if data.ElvUI_EltreumUI.questsettings.questitemsbar1 == nil then
							E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
							data.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.questitemsbar1, data.ElvUI_EltreumUI.questsettings.questitemsbar1)
						elseif data.ElvUI_EltreumUI.questsettings.questitemsbar1 == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.questitemsbar1, data.ElvUI_EltreumUI.questsettings.questitemsbar1)
						end
					elseif data.ElvUI_EltreumUI.questsettings == nil then
						data.ElvUI_EltreumUI.questsettings = {
							enable = false,
							rogueopen = false,
							arena = false,
							combatenable = false,
							autoaccept = false,
							autoacceptinvert = false,
							questitems = false,
							questitemsbar1 = false,
							questitemsize = 36,
							questitemsfade = false,
						}
						E.db.ElvUI_EltreumUI.questsettings.enable = true
						E.db.ElvUI_EltreumUI.questsettings.rogueopen = true
						E.db.ElvUI_EltreumUI.questsettings.arena = true
						E.db.ElvUI_EltreumUI.questsettings.questitemsbar1 = true

						data.ElvUI_EltreumUI.questsettings.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.enable, data.ElvUI_EltreumUI.questsettings.enable)
						data.ElvUI_EltreumUI.questsettings.rogueopen = true
						E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.rogueopen, data.ElvUI_EltreumUI.questsettings.rogueopen)
						data.ElvUI_EltreumUI.questsettings.arena = true
						E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.arena, data.ElvUI_EltreumUI.questsettings.arena)
						data.ElvUI_EltreumUI.questsettings.questitemsbar1 = true
						E:CopyTable(E.db.ElvUI_EltreumUI.questsettings.questitemsbar1, data.ElvUI_EltreumUI.questsettings.questitemsbar1)
					end
					if data.ElvUI_EltreumUI.loottext then
						if data.ElvUI_EltreumUI.loottext.enable == nil then
							E.db.ElvUI_EltreumUI.loottext.enable = true
							data.ElvUI_EltreumUI.loottext.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.enable, data.ElvUI_EltreumUI.loottext.enable)
						elseif data.ElvUI_EltreumUI.loottext.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.enable, data.ElvUI_EltreumUI.loottext.enable)
						end
						if data.ElvUI_EltreumUI.loottext.fontsetting == nil then
							E.db.ElvUI_EltreumUI.loottext.fontsetting = true
							data.ElvUI_EltreumUI.loottext.fontsetting = true
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.fontsetting, data.ElvUI_EltreumUI.loottext.fontsetting)
						elseif data.ElvUI_EltreumUI.loottext.fontsetting == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.fontsetting, data.ElvUI_EltreumUI.loottext.fontsetting)
						end
						if data.ElvUI_EltreumUI.loottext.combatindicator == nil then
							E.db.ElvUI_EltreumUI.loottext.combatindicator = true
							data.ElvUI_EltreumUI.loottext.combatindicator = true
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.combatindicator, data.ElvUI_EltreumUI.loottext.combatindicator)
						elseif data.ElvUI_EltreumUI.loottext.combatindicator == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.loottext.combatindicator, data.ElvUI_EltreumUI.loottext.combatindicator)
						end
					elseif data.ElvUI_EltreumUI.loottext == nil then
						data.ElvUI_EltreumUI.loottext = {
							enable = false,
							honor = true,
							currency = true,
							pet = true,
							scale = 0.65,
							strata = "BACKGROUND",
							xOffset = 0,
							yOffset = 200,
							fontsetting = true,
							combatindicator = false,
						}
						E.db.ElvUI_EltreumUI.loottext.enable = true
						E.db.ElvUI_EltreumUI.loottext.fontsetting = true
						E.db.ElvUI_EltreumUI.loottext.combatindicator = true

						data.ElvUI_EltreumUI.loottext.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.loottext.enable, data.ElvUI_EltreumUI.loottext.enable)
						data.ElvUI_EltreumUI.loottext.fontsetting = true
						E:CopyTable(E.db.ElvUI_EltreumUI.loottext.fontsetting, data.ElvUI_EltreumUI.loottext.fontsetting)
						data.ElvUI_EltreumUI.loottext.combatindicator = true
						E:CopyTable(E.db.ElvUI_EltreumUI.loottext.combatindicator, data.ElvUI_EltreumUI.loottext.combatindicator)
					end
					if data.ElvUI_EltreumUI.modetexture then
						if data.ElvUI_EltreumUI.modetexture == nil then
							E.db.ElvUI_EltreumUI.modetexture = true
							data.ElvUI_EltreumUI.modetexture = true
							E:CopyTable(E.db.ElvUI_EltreumUI.modetexture, data.ElvUI_EltreumUI.modetexture)
						elseif data.ElvUI_EltreumUI.modetexture == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.modetexture, data.ElvUI_EltreumUI.modetexture)
						end
					elseif data.ElvUI_EltreumUI.modetexture == nil then
						E.db.ElvUI_EltreumUI.modetexture = true
						data.ElvUI_EltreumUI.modetexture = true
						E:CopyTable(E.db.ElvUI_EltreumUI.modetexture, data.ElvUI_EltreumUI.modetexture)
					end
					if data.ElvUI_EltreumUI.sparkcustomcolor then
						if data.ElvUI_EltreumUI.sparkcustomcolor.enable == nil then
							E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = true
							data.ElvUI_EltreumUI.sparkcustomcolor.enable = true
							E:CopyTable(E.db.ElvUI_EltreumUI.sparkcustomcolor.enable, data.ElvUI_EltreumUI.sparkcustomcolor.enable)
						elseif data.ElvUI_EltreumUI.sparkcustomcolor.enable == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.sparkcustomcolor.enable, data.ElvUI_EltreumUI.sparkcustomcolor.enable)
						end
					elseif data.ElvUI_EltreumUI.sparkcustomcolor == nil then
						data.ElvUI_EltreumUI.sparkcustomcolor ={
							enable = false,
							texture = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Statusbar\\Eltreum-Blank.tga',
							r = 0.80,
							g = 0.80,
							b = 0.10,
							a = 1,
							width = 3,
						}
						E.db.ElvUI_EltreumUI.sparkcustomcolor.enable = true
						data.ElvUI_EltreumUI.sparkcustomcolor.enable = true
						E:CopyTable(E.db.ElvUI_EltreumUI.sparkcustomcolor.enable, data.ElvUI_EltreumUI.sparkcustomcolor.enable)
					end
					--[[if data.ElvUI_EltreumUI.media then
						if data.ElvUI_EltreumUI.media.font == nil then
							E.db.ElvUI_EltreumUI.media.font = true
							data.ElvUI_EltreumUI.media.font = true
							E:CopyTable(E.db.ElvUI_EltreumUI.media.font, data.ElvUI_EltreumUI.media.font)
						elseif data.ElvUI_EltreumUI.media.font == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.media.font, data.ElvUI_EltreumUI.media.font)
						end
						if data.ElvUI_EltreumUI.media.border == nil then
							E.db.ElvUI_EltreumUI.media.border = true
							data.ElvUI_EltreumUI.media.border = true
							E:CopyTable(E.db.ElvUI_EltreumUI.media.border, data.ElvUI_EltreumUI.media.border)
						elseif data.ElvUI_EltreumUI.media.border == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.media.border, data.ElvUI_EltreumUI.media.border)
						end
						if data.ElvUI_EltreumUI.media.statusbar == nil then
							E.db.ElvUI_EltreumUI.media.statusbar = true
							data.ElvUI_EltreumUI.media.statusbar = true
							E:CopyTable(E.db.ElvUI_EltreumUI.media.statusbar, data.ElvUI_EltreumUI.media.statusbar)
						elseif data.ElvUI_EltreumUI.media.statusbar == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.media.statusbar, data.ElvUI_EltreumUI.media.statusbar)
						end
						if data.ElvUI_EltreumUI.media.texture == nil then
							E.db.ElvUI_EltreumUI.media.texture = true
							data.ElvUI_EltreumUI.media.texture = true
							E:CopyTable(E.db.ElvUI_EltreumUI.media.texture, data.ElvUI_EltreumUI.media.texture)
						elseif data.ElvUI_EltreumUI.media.texture == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.media.texture, data.ElvUI_EltreumUI.media.texture)
						end
						if data.ElvUI_EltreumUI.media.sound == nil then
							E.db.ElvUI_EltreumUI.media.sound = true
							data.ElvUI_EltreumUI.media.sound = true
							E:CopyTable(E.db.ElvUI_EltreumUI.media.sound, data.ElvUI_EltreumUI.media.sound)
						elseif data.ElvUI_EltreumUI.media.sound == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.media.sound, data.ElvUI_EltreumUI.media.sound)
						end
					elseif data.ElvUI_EltreumUI.media == nil then
						data.ElvUI_EltreumUI.media ={
							font = false,
							border = false,
							statusbar = false,
							texture = false,
							sound = false,
						}
						E.db.ElvUI_EltreumUI.media.font = true
						data.ElvUI_EltreumUI.media.font = true
						E:CopyTable(E.db.ElvUI_EltreumUI.media.font, data.ElvUI_EltreumUI.media.font)
						E.db.ElvUI_EltreumUI.media.border = true
						data.ElvUI_EltreumUI.media.border = true
						E:CopyTable(E.db.ElvUI_EltreumUI.media.border, data.ElvUI_EltreumUI.media.border)
						E.db.ElvUI_EltreumUI.media.statusbar = true
						data.ElvUI_EltreumUI.media.statusbar = true
						E:CopyTable(E.db.ElvUI_EltreumUI.media.statusbar, data.ElvUI_EltreumUI.media.statusbar)
						E.db.ElvUI_EltreumUI.media.texture = true
						data.ElvUI_EltreumUI.media.texture = true
						E:CopyTable(E.db.ElvUI_EltreumUI.media.texture, data.ElvUI_EltreumUI.media.texture)
						E.db.ElvUI_EltreumUI.media.sound = true
						data.ElvUI_EltreumUI.media.sound = true
						E:CopyTable(E.db.ElvUI_EltreumUI.media.sound, data.ElvUI_EltreumUI.media.sound)
					end]]
					if data.ElvUI_EltreumUI.otherstuff then
						if data.ElvUI_EltreumUI.otherstuff.fastloot == nil then
							E.db.ElvUI_EltreumUI.otherstuff.fastloot = true
							data.ElvUI_EltreumUI.otherstuff.fastloot = true
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
						elseif data.ElvUI_EltreumUI.otherstuff.fastloot == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
						end
						if data.ElvUI_EltreumUI.otherstuff.screenshot == nil then
							E.db.ElvUI_EltreumUI.otherstuff.screenshot = true
							data.ElvUI_EltreumUI.otherstuff.screenshot = true
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.screenshot, data.ElvUI_EltreumUI.otherstuff.screenshot)
						elseif data.ElvUI_EltreumUI.otherstuff.screenshot == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.screenshot, data.ElvUI_EltreumUI.otherstuff.screenshot)
						end
						if data.ElvUI_EltreumUI.otherstuff.hidetalkinghead == nil then
							E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
							data.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead, data.ElvUI_EltreumUI.otherstuff.hidetalkinghead)
						elseif data.ElvUI_EltreumUI.otherstuff.hidetalkinghead == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead, data.ElvUI_EltreumUI.otherstuff.hidetalkinghead)
						end
						if data.ElvUI_EltreumUI.otherstuff.blizzcombattext == nil then
							E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
							data.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext, data.ElvUI_EltreumUI.otherstuff.blizzcombattext)
						elseif data.ElvUI_EltreumUI.otherstuff.blizzcombattext == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext, data.ElvUI_EltreumUI.otherstuff.blizzcombattext)
						end
						if data.ElvUI_EltreumUI.otherstuff.dynamicxpbar == nil then
							E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
							data.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar, data.ElvUI_EltreumUI.otherstuff.dynamicxpbar)
						elseif data.ElvUI_EltreumUI.otherstuff.dynamicxpbar == false then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar, data.ElvUI_EltreumUI.otherstuff.dynamicxpbar)
						end
					elseif data.ElvUI_EltreumUI.otherstuff == nil then
						data.ElvUI_EltreumUI.otherstuff ={
							worldtextscale = 1,
							arenabuffs = false,
							bgunitframes = false,
							arenaunitframes = false,
							fastloot = false,
							screenshot = false,
							hidetalkinghead = false,
							blizzcombattext = false,
							blizzcombatmana = false,
							mapcombathide = false,
							dynamicxpbar = false,
							delete = false,
							--floatingrep = false,
						}
						E.db.ElvUI_EltreumUI.otherstuff.fastloot = true
						E.db.ElvUI_EltreumUI.otherstuff.screenshot = true
						E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
						E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
						E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true

						data.ElvUI_EltreumUI.otherstuff.fastloot = true
						E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
						data.ElvUI_EltreumUI.otherstuff.screenshot = true
						E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.screenshot, data.ElvUI_EltreumUI.otherstuff.screenshot)
						data.ElvUI_EltreumUI.otherstuff.hidetalkinghead = true
						E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.hidetalkinghead, data.ElvUI_EltreumUI.otherstuff.hidetalkinghead)
						data.ElvUI_EltreumUI.otherstuff.blizzcombattext = true
						E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.blizzcombattext, data.ElvUI_EltreumUI.otherstuff.blizzcombattext)
						data.ElvUI_EltreumUI.otherstuff.dynamicxpbar = true
						E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar, data.ElvUI_EltreumUI.otherstuff.dynamicxpbar)
					end
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
							data.ElvUI_EltreumUI.nameplatepower.enable = true
							E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.enable, data.ElvUI_EltreumUI.nameplatepower.enable)
						elseif data.ElvUI_EltreumUI.nameplatepower.enable == false then
							E.private.ElvUI_EltreumUI.nameplatepower.enable = false
							data.ElvUI_EltreumUI.nameplatepower.enable = false
							E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.enable, data.ElvUI_EltreumUI.nameplatepower.enable)
						end
						if data.ElvUI_EltreumUI.nameplatepower.adjust == nil or data.ElvUI_EltreumUI.nameplatepower.adjust == true then
							E.private.ElvUI_EltreumUI.nameplatepower.adjust = true
							data.ElvUI_EltreumUI.nameplatepower.adjust = true
							E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.adjust, data.ElvUI_EltreumUI.nameplatepower.adjust)
						elseif data.ElvUI_EltreumUI.nameplatepower.adjust == false then
							E.private.ElvUI_EltreumUI.nameplatepower.adjust = false
							data.ElvUI_EltreumUI.nameplatepower.adjust = false
							E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.adjust, data.ElvUI_EltreumUI.nameplatepower.adjust)
						end
					elseif data.ElvUI_EltreumUI.nameplatepower == nil then
						data.ElvUI_EltreumUI.nameplatepower = {
							enable = false,
							adjust = false,
							mana = true,
							insanity = true,
							maelstrom = true,
							rage = true,
							energy = true,
							astral = true,
							runic = true,
							fury = true,
							focus = true,
						}
						E.private.ElvUI_EltreumUI.nameplatepower.enable = true
						E.private.ElvUI_EltreumUI.nameplatepower.adjust = true

						data.ElvUI_EltreumUI.nameplatepower.enable = true
						E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.enable, data.ElvUI_EltreumUI.nameplatepower.enable)
						data.ElvUI_EltreumUI.nameplatepower.adjust = true
						E:CopyTable(E.private.ElvUI_EltreumUI.nameplatepower.adjust, data.ElvUI_EltreumUI.nameplatepower.adjust)
					end
					if data.ElvUI_EltreumUI.combatmusic then
						if data.ElvUI_EltreumUI.combatmusic.enable == nil or data.ElvUI_EltreumUI.combatmusic.enable == true then
							E.private.ElvUI_EltreumUI.combatmusic.enable = true
							data.ElvUI_EltreumUI.combatmusic.enable = true
							E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.enable, data.ElvUI_EltreumUI.combatmusic.enable)
						elseif data.ElvUI_EltreumUI.combatmusic.enable == false then
							E.private.ElvUI_EltreumUI.combatmusic.enable = false
							data.ElvUI_EltreumUI.combatmusic.enable = false
							E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.enable, data.ElvUI_EltreumUI.combatmusic.enable)
						end
						if data.ElvUI_EltreumUI.combatmusic.disableinstance == nil or data.ElvUI_EltreumUI.combatmusic.disableinstance == true then
							E.private.ElvUI_EltreumUI.combatmusic.disableinstance = true
							data.ElvUI_EltreumUI.combatmusic.disableinstance = true
							E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.disableinstance, data.ElvUI_EltreumUI.combatmusic.disableinstance)
						elseif data.ElvUI_EltreumUI.combatmusic.disableinstance == false then
							E.private.ElvUI_EltreumUI.combatmusic.disableinstance = false
							data.ElvUI_EltreumUI.combatmusic.disableinstance = false
							E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.disableinstance, data.ElvUI_EltreumUI.combatmusic.disableinstance)
						end
						if data.ElvUI_EltreumUI.combatmusic.bossmusic == nil or data.ElvUI_EltreumUI.combatmusic.bossmusic == true then
							E.private.ElvUI_EltreumUI.combatmusic.bossmusic = true
							data.ElvUI_EltreumUI.combatmusic.bossmusic = true
							E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.bossmusic, data.ElvUI_EltreumUI.combatmusic.bossmusic)
						elseif data.ElvUI_EltreumUI.combatmusic.bossmusic == false then
							E.private.ElvUI_EltreumUI.combatmusic.bossmusic = false
							data.ElvUI_EltreumUI.combatmusic.bossmusic = false
							E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.bossmusic, data.ElvUI_EltreumUI.combatmusic.bossmusic)
						end
					elseif data.ElvUI_EltreumUI.combatmusic == nil then
						data.ElvUI_EltreumUI.combatmusic = {
							enable = false,
							musicfile = "None",
							bossmusic = false,
							bossfile = "None",
							disableinstance = true,
						}
						E.private.ElvUI_EltreumUI.combatmusic.enable = true
						E.private.ElvUI_EltreumUI.combatmusic.disableinstance = true
						E.private.ElvUI_EltreumUI.combatmusic.bossmusic = true

						data.ElvUI_EltreumUI.combatmusic.enable = true
						E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.enable, data.ElvUI_EltreumUI.combatmusic.enable)
						data.ElvUI_EltreumUI.combatmusic.disableinstance = true
						E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.disableinstance, data.ElvUI_EltreumUI.combatmusic.disableinstance)
						data.ElvUI_EltreumUI.combatmusic.bossmusic = true
						E:CopyTable(E.private.ElvUI_EltreumUI.combatmusic.bossmusic, data.ElvUI_EltreumUI.combatmusic.bossmusic)
					end
					if data.ElvUI_EltreumUI.install_version then
						E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
						data.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
						E:CopyTable(E.private.ElvUI_EltreumUI.install_version, data.ElvUI_EltreumUI.install_version)
					end
					E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
					data.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
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

		--E:StaggeredUpdateAll(nil, true)

		E.PopupDialogs['ELTRUISMDBCONVERT'] = {
			text = L["Eltruism database was converted.\n|cff82B4ffThe Following profiles were updated:|r\n%s\n\n|cff82B4ffPrivate settings were updated for the following private profiles:|r\n%s\n\n|cff82B4ffIf you have any issues please report in Discord or open a ticket|r\n|cffff0000A Reload is necessary to save this conversion|r"],
			button1 = OKAY,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}

		E:StaticPopup_Show('ELTRUISMDBCONVERT', ProfileNames, CharacterNames)

		E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
	end
end
