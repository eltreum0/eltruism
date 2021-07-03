local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:VersionCheckInit()
	ElvUI_EltreumUI:NewVersionCheck()
	ElvUI_EltreumUI:OldVersionCheck()
	ElvUI_EltreumUI:ElvUIVersionCheck()
end

function ElvUI_EltreumUI:NewVersionCheck()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif E.private.ElvUI_EltreumUI.install_version >= "2.3.0" and E.private.ElvUI_EltreumUI.install_version < ElvUI_EltreumUI.Version then
		E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
		ElvUI_EltreumUI:Print(L["updated to "]..ElvUI_EltreumUI.Version..' version')
		ElvUI_EltreumUI:Print('Borders released, you can test this feature in Eltruism > Borders. You might need to adjust settings to fit your action bars')
		ElvUI_EltreumUI:Print('Cooldowns were added to Cursor with this version, thats why you see icons when you try to use a skill again')
	end
end

function ElvUI_EltreumUI:ElvUIVersionCheck()
	if ElvUI_EltreumUI.Retail then
		if E.version < 12.31 then
			ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
		end
	end
	if ElvUI_EltreumUI.TBC then
		if E.version < 2.10 then
			ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
		end
	end
	if ElvUI_EltreumUI.Classic then
		if E.version < 1.44 then
			ElvUI_EltreumUI:Print("Your ElvUI version is out of date, please update to avoid issues!")
		end
	end
end

function ElvUI_EltreumUI:OldVersionCheck()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	elseif E.private.ElvUI_EltreumUI.install_version > "0" and E.private.ElvUI_EltreumUI.install_version < "2.1.3" then
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			if not E.db.movers then E.db.movers = {} end
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[namecolor][name:eltruism:abbreviate]"
			ElvUI_EltreumUI:Print('Nameplate Filters were changed, please remove |cffff0000EnemyCasting, ExecuteRange, StealThisBuff and HideThis filters|r')
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
			ElvUI_EltreumUI:Print('Please go to: |cffff0000ElvUI > Unitframes > Group Units > Party/Raid/Raid40 > Aura Indicator >|r Set them to |cffff0000Textured Icon with Display Timer|r')
			ElvUI_EltreumUI:Print('This setting cannot be set through the plugin without causing errors. It will improve your experience making it easier to see which buffs/debuffs your party/raid/raid40 has. This message will only be displayed once.')
		end
	elseif E.private.ElvUI_EltreumUI.install_version < "2.3.0" then
		E.private.ElvUI_EltreumUI.install_version = "2.3.0"
		ElvUI_EltreumUI:Print('Chat modifications were recently added, please check Eltruism > Chat if you want to turn them off. You can Left click on a Chat Panel enable them (reloading will reset this)')
		ElvUI_EltreumUI:Print('More options were added to Nameplate Power Bar, such as the ability to change its size, position and texture. Configure it in Eltruism > Nameplates')
	end
end
