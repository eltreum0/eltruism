local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn

function ElvUI_EltreumUI:NewVersionCheck()
	if E.private.ElvUI_EltreumUI.install_version >= "2.1.3" and E.private.ElvUI_EltreumUI.install_version < "2.1.9" then
		E.private.ElvUI_EltreumUI.install_version = "2.1.9"
		ElvUI_EltreumUI:Print('has been updated to 2.1.9')
	end
end

function ElvUI_EltreumUI:OldVersionCheck()
	if E.private.ElvUI_EltreumUI.install_version > "0" and E.private.ElvUI_EltreumUI.install_version < "2.1.0" then
		if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
			if not E.db.movers then E.db.movers = {} end
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[namecolor][name:eltruism:abbreviate]"
			ElvUI_EltreumUI:ResolutionOutline()
			ElvUI_EltreumUI:SetupStyleFilters()
			E.private.ElvUI_EltreumUI.install_version = "2.1.0"
			ElvUI_EltreumUI:Print('Nameplate Filters were changed, please remove |cffff0000EnemyCasting, ExecuteRange, StealThisBuff and HideThis filters|r')
		else
			ElvUI_EltreumUI:Print('Not using an Eltruism profile, please switch to it and reload in order to update it')
		end
	end
	if E.private.ElvUI_EltreumUI.install_version > "2.1.0" and E.private.ElvUI_EltreumUI.install_version < "2.1.3" then
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
			if ElvDB.profileKeys[E.mynameRealm] == "Eltreum DPS/Tank" or ElvDB.profileKeys[E.mynameRealm] == "Eltreum Healer" then
				if not E.db.movers then E.db.movers = {} end
				E.db["unitframe"]["units"]["player"]["power"]["EnergyManaRegen"] = true
				E.private.ElvUI_EltreumUI.install_version = "2.1.3"
				ElvUI_EltreumUI:Print('profile has been automatically updated to enable mana and energy ticks')
			end
		end
		if ElvUI_EltreumUI.Retail then
			E.private.ElvUI_EltreumUI.install_version = "2.1.3"
			ElvUI_EltreumUI:Print('has been updated to 2.1.3')
		end
	end
end
