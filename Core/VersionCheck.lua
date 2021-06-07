local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:NewVersionCheck()
	if E.private.ElvUI_EltreumUI.install_version >= "2.1.3" and E.private.ElvUI_EltreumUI.install_version < "2.2.0" then
		E.private.ElvUI_EltreumUI.install_version = "2.2.0"
		ElvUI_EltreumUI:SetupNamePlates('ElvUI')
		ElvUI_EltreumUI:Print('Please go to: |cffff0000ElvUI > Unitframes > Group Units > Party/Raid/Raid40 > Aura Indicator > Set them to Textured Icon with Display Timer|r')
		ElvUI_EltreumUI:Print('Since this setting cannot be set through the plugin without causing errors, and it will improve your experience making it easier to see which buffs/debuffs your party/raid/raid40 has')
	end
end

function ElvUI_EltreumUI:OldVersionCheck()
	if E.private.ElvUI_EltreumUI.install_version > "0" and E.private.ElvUI_EltreumUI.install_version < "2.1.3" then
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			if not E.db.movers then E.db.movers = {} end
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[namecolor][name:eltruism:abbreviate]"
			ElvUI_EltreumUI:ResolutionOutline()
			ElvUI_EltreumUI:SetupStyleFilters()
			ElvUI_EltreumUI:Print('Nameplate Filters were changed, please remove |cffff0000EnemyCasting, ExecuteRange, StealThisBuff and HideThis filters|r')
			if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
				if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
					if not E.db.movers then E.db.movers = {} end
					E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true
					E.private.ElvUI_EltreumUI.install_version = "2.1.3"
					ElvUI_EltreumUI:Print('profile has been automatically updated to enable mana and energy ticks')
				end
			end
		else
			ElvUI_EltreumUI:Print('Not using an Eltruism profile, please switch to it and reload in order to update it')
		end
	end
end
