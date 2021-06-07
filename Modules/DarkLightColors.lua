local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:DarkMode()
	if not E.db.movers then E.db.movers = {} end
		--setup colors
		E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
		E.db["unitframe"]["colors"]["classbackdrop"] = true
		E.db["unitframe"]["colors"]["healthclass"] = false
		E.db["unitframe"]["colors"]["customhealthbackdrop"] = false
		E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
		E.db["unitframe"]["units"]["player"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["pet"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["raid"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["raid40"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["target"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "FORCE_OFF"

		--setup namecolors
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name][happiness:discord]"
		elseif ElvUI_EltreumUI.Retail then
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name]"
		end
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[namecolor][name]"
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[namecolor][name:eltruism:abbreviate]"
		E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[namecolor][name:long:status]"
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[namecolor][name:abbrev]"
		if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
			E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[namecolor][name:medium]"
		end
		--E:StaggeredUpdateAll(nil, true)
end

function ElvUI_EltreumUI:LightMode()
	if not E.db.movers then E.db.movers = {} end
		--setup colors
		E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
		E.db["unitframe"]["colors"]["classbackdrop"] = false
		E.db["unitframe"]["colors"]["healthclass"] = true
		E.db["unitframe"]["colors"]["customhealthbackdrop"] = true
		E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
		E.db["unitframe"]["units"]["player"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["party"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["pet"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["raid"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["raid40"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["tank"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["target"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "USE_DEFAULT"

		--setup namecolors
		if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name][happiness:discord]"
		elseif ElvUI_EltreumUI.Retail then
		E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name]"
		end
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[name]"
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[name:eltruism:abbreviate]"
		E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[name:long:status]"
		E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
		if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
			E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:medium]"
		end
		--E:StaggeredUpdateAll(nil, true)
end
