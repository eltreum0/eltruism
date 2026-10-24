local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G

-- Eltruism Custom Glow options
function ElvUI_EltreumUI:CustomGlowOptions()
	ElvUI_EltreumUI.Options.args.customglow = E.Libs.ACH:Group(E:TextGradient(L["Custom Glow"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Fully customize how action bars glow and add glows to debuffs on unitframes"], 3, 'tab')
	ElvUI_EltreumUI.Options.args.customglow.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\customglow'
	ElvUI_EltreumUI.Options.args.customglow.args.previewdesc = E.Libs.ACH:Description(L["Preview the Glow"], 1)
	ElvUI_EltreumUI.Options.args.customglow.args.preview = E.Libs.ACH:Execute(_G.PREVIEW or "", L["Preview the Glow, you will need to toggle it off and on to update the glow"], 2, function() ElvUI_EltreumUI:PreviewGlow() end,nil,false,'full')
	ElvUI_EltreumUI.Options.args.customglow.args.general = E.Libs.ACH:Group(L["General"], nil, 1)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.description1 = E.Libs.ACH:Description(L["Replace Blizzards Default Glow with a Custom Glow"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableab = E.Libs.ACH:Toggle(L["Enable on Action Bars"], nil, 4, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.enable end,function(_, value) E.db.ElvUI_EltreumUI.glow.enable = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enablepet = E.Libs.ACH:Toggle(L["Enable on Pet Bar"], nil, 4, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.enablepet end,function(_, value) E.db.ElvUI_EltreumUI.glow.enablepet = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableuf = E.Libs.ACH:Toggle(L["Enable on Unitframes"], L["Add a glow when Unitframes have a debuff"], 4, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.enableUFs end,function(_, value) E.db.ElvUI_EltreumUI.glow.enableUFs = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enablenp = E.Libs.ACH:Toggle(L["Enable on Nameplate"], L["Add a glow when buffs or debuffs are expiring on nameplates"], 5, nil, false,"full",function() return E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow end,function(_, value) E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.debufftimer = E.Libs.ACH:Range(L["Debuff Timer"], L["Time at which the glow will start"], 6, { min = 1, max = 30, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.numberdebuff end, function(_, value) E.db.ElvUI_EltreumUI.glow.numberdebuff = value end, function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow end)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.description2 = E.Libs.ACH:Description(L["Shaman Totems"], 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableshamantotem = E.Libs.ACH:Toggle(L["Enable on Shaman Totems"], nil, 8, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.enabletotem end,function(_, value) E.db.ElvUI_EltreumUI.glow.enabletotem = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableshamantotem1 = E.Libs.ACH:Toggle(L["Enable on Shaman Fire Totem"], nil, 9, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.totem1 end,function(_, value) E.db.ElvUI_EltreumUI.glow.totem1 = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableshamantotem2 = E.Libs.ACH:Toggle(L["Enable on Shaman Earth Totem"], nil, 9, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.totem2 end,function(_, value) E.db.ElvUI_EltreumUI.glow.totem2 = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableshamantotem3 = E.Libs.ACH:Toggle(L["Enable on Shaman Water Totem"], nil, 9, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.totem3 end,function(_, value) E.db.ElvUI_EltreumUI.glow.totem3 = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.enableshamantotem4 = E.Libs.ACH:Toggle(L["Enable on Shaman Air Totem"], nil, 9, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.totem4 end,function(_, value) E.db.ElvUI_EltreumUI.glow.totem4 = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.description3 = E.Libs.ACH:Description(" ", 10, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")

	local procoptions = {
		["autocast"] = L["Autocast"],
		["pixel"] = L["Pixel"],
		["blizzard"] = L["Blizzard"],
		["borderpulse"] = L["Border Pulse"],
		["bling"] = L["Bling"],
	}
	if E.Modern then
		procoptions["proc"] = L["Proc"]
	end

	ElvUI_EltreumUI.Options.args.customglow.args.general.args.customselection = E.Libs.ACH:Select(L["Select a Type"], nil, 10, procoptions, false, nil, function()
		if E.db.ElvUI_EltreumUI.glow.autocast then
			return "autocast"
		elseif E.db.ElvUI_EltreumUI.glow.pixel then
			return "pixel"
		elseif E.db.ElvUI_EltreumUI.glow.blizzard then
			return "blizzard"
		elseif E.db.ElvUI_EltreumUI.glow.procglow then
			return "proc"
		elseif E.db.ElvUI_EltreumUI.glow.borderpulseglow then
			return "borderpulse"
		elseif E.db.ElvUI_EltreumUI.glow.blingglow then
			return "bling"
		end
	end,
	function(_,value)
		E.db.ElvUI_EltreumUI.glow.autocast = (value == "autocast")
		E.db.ElvUI_EltreumUI.glow.pixel = (value == "pixel")
		E.db.ElvUI_EltreumUI.glow.blizzard = (value == "blizzard")
		E.db.ElvUI_EltreumUI.glow.procglow = (value == "proc")
		E.db.ElvUI_EltreumUI.glow.borderpulseglow = (value == "borderpulse")
		E.db.ElvUI_EltreumUI.glow.blingglow = (value == "bling")
		ElvUI_EltreumUI:UpdateActiveGlows()
	end, function() return not (E.db.ElvUI_EltreumUI.glow.enable or E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow or E.db.ElvUI_EltreumUI.glow.enablepet or E.db.ElvUI_EltreumUI.glow.enableUFs) end)
	ElvUI_EltreumUI.Options.args.customglow.args.general.args.customselection.style = "radio"

	local startPoints = {
		["TOPLEFT"] = L["TOPLEFT"],
		["TOP"] = L["TOP"],
		["TOPRIGHT"] = L["TOPRIGHT"],
		["RIGHT"] = L["RIGHT"],
		["BOTTOMRIGHT"] = L["BOTTOMRIGHT"],
		["BOTTOM"] = L["BOTTOM"],
		["BOTTOMLEFT"] = L["BOTTOMLEFT"],
		["LEFT"] = L["LEFT"],
	}

	-- Colors Tab
	ElvUI_EltreumUI.Options.args.customglow.args.colors = E.Libs.ACH:Group(L["Glow Colors"], nil, 2,"tab",nil,nil,function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.description1 = E.Libs.ACH:Description(_G.ACTIONBARS_LABEL, 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.classcolorab = E.Libs.ACH:Toggle(L["Use Class Colors"], L["Toggle Class Colored glows"], 2, nil, false,nil,function() return E.db.ElvUI_EltreumUI.glow.colorclass end,function(_, value) E.db.ElvUI_EltreumUI.glow.colorclass = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.customcolorab = E.Libs.ACH:Color(L["Custom Color"], nil, 3, false, nil, function()
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glow.glowcustomcolor
		local d = P.ElvUI_EltreumUI.glow.glowcustomcolor
		return glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b, glowcustomcolor.a, d.r, d.g, d.b, d.a
	end,
	function(_, r, g, b)
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glow.glowcustomcolor
		glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL') end,
	function() return E.db.ElvUI_EltreumUI.glow.colorclass or not E.db.ElvUI_EltreumUI.glow.enable end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.description2 = E.Libs.ACH:Description(L["Pet Bar"], 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.classcolorpet = E.Libs.ACH:Toggle(L["Use Class Colors"], L["Toggle Class Colored glows"], 5, nil, false,nil,function() return E.db.ElvUI_EltreumUI.glow.colorclasspet end,function(_, value) E.db.ElvUI_EltreumUI.glow.colorclasspet = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enablepet end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.customcolorpet = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function()
		local glowcustomcolorpet = E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet
		local d = P.ElvUI_EltreumUI.glow.glowcustomcolorpet
		return glowcustomcolorpet.r, glowcustomcolorpet.g, glowcustomcolorpet.b, glowcustomcolorpet.a, d.r, d.g, d.b, d.a
	end,
		function(_, r, g, b)
			local glowcustomcolorpet = E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet
			glowcustomcolorpet.r, glowcustomcolorpet.g, glowcustomcolorpet.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
		end, function() return E.db.ElvUI_EltreumUI.glow.colorclasspet or not E.db.ElvUI_EltreumUI.glow.enablepet end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.description3 = E.Libs.ACH:Description(L["Nameplate Buff/Debuff"], 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.classcolornp = E.Libs.ACH:Toggle(L["Use Class Colors"], L["Toggle Class Colored glows"], 8, nil, false,nil,function() return E.db.ElvUI_EltreumUI.glow.colorclassnp end,function(_, value) E.db.ElvUI_EltreumUI.glow.colorclassnp = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.customcolornp = E.Libs.ACH:Color(L["Custom Color"], nil, 9, false, nil, function()
		local glowcustomcolornp = E.db.ElvUI_EltreumUI.glow.glowcustomcolornp
		local d = P.ElvUI_EltreumUI.glow.glowcustomcolornp
		return glowcustomcolornp.r, glowcustomcolornp.g, glowcustomcolornp.b, glowcustomcolornp.a, d.r, d.g, d.b, d.a
	end,
		function(_, r, g, b)
			local glowcustomcolornp = E.db.ElvUI_EltreumUI.glow.glowcustomcolornp
			glowcustomcolornp.r, glowcustomcolornp.g, glowcustomcolornp.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
		end, function() return E.db.ElvUI_EltreumUI.glow.colorclassnp or not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totemtypecolordesc = E.Libs.ACH:Description(L["Totem Colors"], 10, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totemtypecolors = E.Libs.ACH:Toggle(L["Use Type Colors"], L["Toggle Totem to use it's own Type Colors"], 11, nil, false,nil,function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor end,function(_, value) E.db.ElvUI_EltreumUI.glow.totemtypecolor = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem1 = E.Libs.ACH:Description(L["Shaman Fire Totem"], 12, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem1customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 13, false, nil, function()
		local glowtotem1customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor
		local d = P.ElvUI_EltreumUI.glow.glowtotem1customcolor
		return glowtotem1customcolor.r, glowtotem1customcolor.g, glowtotem1customcolor.b, glowtotem1customcolor.a, d.r, d.g, d.b, d.a
	end,
		function(_, r, g, b)
			local glowtotem1customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor
			glowtotem1customcolor.r, glowtotem1customcolor.g, glowtotem1customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
		end, function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem2 = E.Libs.ACH:Description(L["Shaman Earth Totem"], 14, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem2customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 15, false, nil, function()
		local glowtotem2customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor
		local d = P.ElvUI_EltreumUI.glow.glowtotem2customcolor
		return glowtotem2customcolor.r, glowtotem2customcolor.g, glowtotem2customcolor.b, glowtotem2customcolor.a, d.r, d.g, d.b, d.a
	end,
		function(_, r, g, b)
			local glowtotem2customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor
			glowtotem2customcolor.r, glowtotem2customcolor.g, glowtotem2customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
		end, function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem3 = E.Libs.ACH:Description(L["Shaman Water Totem"], 16, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem3customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 18, false, nil, function()
		local glowtotem3customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor
		local d = P.ElvUI_EltreumUI.glow.glowtotem3customcolor
		return glowtotem3customcolor.r, glowtotem3customcolor.g, glowtotem3customcolor.b, glowtotem3customcolor.a, d.r, d.g, d.b, d.a
	end,
		function(_, r, g, b)
			local glowtotem3customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor
			glowtotem3customcolor.r, glowtotem3customcolor.g, glowtotem3customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
		end, function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem4 = E.Libs.ACH:Description(L["Shaman Air Totem"], 19, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.totem4customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 21, false, nil, function()
		local glowtotem4customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor
		local d = P.ElvUI_EltreumUI.glow.glowtotem4customcolor
		return glowtotem4customcolor.r, glowtotem4customcolor.g, glowtotem4customcolor.b, glowtotem4customcolor.a, d.r, d.g, d.b, d.a
	end,
		function(_, r, g, b)
			local glowtotem4customcolor = E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor
			glowtotem4customcolor.r, glowtotem4customcolor.g, glowtotem4customcolor.b = r, g, b E:StaticPopup_Show('CONFIG_RL')
		end, function() return E.db.ElvUI_EltreumUI.glow.totemtypecolor or not E.db.ElvUI_EltreumUI.glow.enable or not E.db.ElvUI_EltreumUI.glow.enabletotem end, E.Modern)

	-- Gradient Settings
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradientdesc = E.Libs.ACH:Description(L["Color Gradient"], 22, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradient = E.Libs.ACH:Toggle(L["Enable Gradient Glow"], nil, 23, nil, false,"full",function() return E.db.ElvUI_EltreumUI.glow.gradient end,function(_, value) E.db.ElvUI_EltreumUI.glow.gradient = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradientmode = E.Libs.ACH:Select(_G.MODE or L["Mode"], nil, 24, { ["class"] = _G.CLASS or L["Class"], ["custom"] = _G.CUSTOM or L["Custom"] }, false, nil, function() return E.db.ElvUI_EltreumUI.glow.gradientmode end, function(_, value) E.db.ElvUI_EltreumUI.glow.gradientmode = value end, function() return not E.db.ElvUI_EltreumUI.glow.gradient end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradientfrequency = E.Libs.ACH:Range(L["Gradient Frequency"], L["Frequency of gradient rotation"], 25, { min = -3, max = 3, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.glow.gradientfrequency end, function(_, value) E.db.ElvUI_EltreumUI.glow.gradientfrequency = value end, function() return not E.db.ElvUI_EltreumUI.glow.gradient end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradientcolor1 = E.Libs.ACH:Color((_G.COLOR or L["Color"]) .. " 1", nil, 26, true, nil, function()
		local c = E.db.ElvUI_EltreumUI.glow.gradientcolor1
		local d = P.ElvUI_EltreumUI.glow.gradientcolor1
		return c.r, c.g, c.b, c.a, d.r, d.g, d.b, d.a
	end,
	function(_, r, g, b, a)
		local c = E.db.ElvUI_EltreumUI.glow.gradientcolor1
		c.r, c.g, c.b, c.a = r, g, b, a
	end, function() return not E.db.ElvUI_EltreumUI.glow.gradient or E.db.ElvUI_EltreumUI.glow.gradientmode == "class" end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradientcolor2 = E.Libs.ACH:Color((_G.COLOR or L["Color"]) .. " 2", nil, 27, true, nil, function()
		local c = E.db.ElvUI_EltreumUI.glow.gradientcolor2
		local d = P.ElvUI_EltreumUI.glow.gradientcolor2
		return c.r, c.g, c.b, c.a, d.r, d.g, d.b, d.a
	end,
	function(_, r, g, b, a)
		local c = E.db.ElvUI_EltreumUI.glow.gradientcolor2
		c.r, c.g, c.b, c.a = r, g, b, a
	end, function() return not E.db.ElvUI_EltreumUI.glow.gradient or E.db.ElvUI_EltreumUI.glow.gradientmode == "class" end)
	ElvUI_EltreumUI.Options.args.customglow.args.colors.args.gradientcolor3 = E.Libs.ACH:Color((_G.COLOR or L["Color"]) .. " 3", nil, 28, true, nil, function()
		local c = E.db.ElvUI_EltreumUI.glow.gradientcolor3
		local d = P.ElvUI_EltreumUI.glow.gradientcolor3
		return c.r, c.g, c.b, c.a, d.r, d.g, d.b, d.a
	end,
	function(_, r, g, b, a)
		local c = E.db.ElvUI_EltreumUI.glow.gradientcolor3
		c.r, c.g, c.b, c.a = r, g, b, a
	end, function() return not E.db.ElvUI_EltreumUI.glow.gradient or E.db.ElvUI_EltreumUI.glow.gradientmode == "class" end)

	-- Pixel Glow Tab
	ElvUI_EltreumUI.Options.args.customglow.args.pixel = E.Libs.ACH:Group(L["Pixel Glow"], nil, 3, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelborder = E.Libs.ACH:Toggle(L["Enable Pixel Border"], L["Enable a border for the Pixel Glow"], 2, nil, false,nil,function() return E.db.ElvUI_EltreumUI.glow.borderpixel end,function(_, value) E.db.ElvUI_EltreumUI.glow.borderpixel = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.numberpixel = E.Libs.ACH:Range(L["Number of Pixels (Default is 4)"], L["Set the number of pixels in pixel glow"], 4, { min = 1, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.numberpixel end, function(_, value) E.db.ElvUI_EltreumUI.glow.numberpixel = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description3 = E.Libs.ACH:Description(" ", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelfrequency = E.Libs.ACH:Range(L["Pixel Frequency (Default is 1)"], L["Set the frequency pixel glow"], 6, { min = -10, max = 10, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.glow.frequencypixel end, function(_, value) E.db.ElvUI_EltreumUI.glow.frequencypixel = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description4 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixellength = E.Libs.ACH:Range(L["Pixel Length (Default is 15)"], L["Set the length of pixels"], 8, { min = 1, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.lengthpixel end, function(_, value) E.db.ElvUI_EltreumUI.glow.lengthpixel = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description5 = E.Libs.ACH:Description(" ", 9, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelthickness = E.Libs.ACH:Range(L["Pixel Thickness (Default is 3)"], L["Set the thickness of pixels"], 10, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.thicknesspixel end, function(_, value) E.db.ElvUI_EltreumUI.glow.thicknesspixel = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description6 = E.Libs.ACH:Description(" ", 11, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelxoffset = E.Libs.ACH:Range(L["Pixel Horizontal Offset (Default is 3)"], L["Set the horizontal offset of pixels"], 12, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.pixelxOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelxOffset = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.description7 = E.Libs.ACH:Description(" ", 13, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelyoffset = E.Libs.ACH:Range(L["Pixel Vertical Offset (Default is 3)"], L["Set the vertical offset of pixels"], 14, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.pixelyOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelyOffset = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelfadeduration = E.Libs.ACH:Range(L["Fade Duration"], L["Duration of fade animation"], 15, { min = 0, max = 2, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.glow.pixelfadeDuration end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelfadeDuration = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelforcestop = E.Libs.ACH:Toggle(L["Force Stop"], L["Stops glow immediately without waiting for fade"], 16, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.pixelforceStop end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelforceStop = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelstartbling = E.Libs.ACH:Toggle(L["Start Bling"], L["Show Bling on first application of glow"], 17, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.pixelstartBling end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelstartBling = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelrepeatbling = E.Libs.ACH:Toggle(L["Repeat Bling"], L["Show Bling on reapplication of glow"], 18, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.pixelrepeatBling end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelrepeatBling = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelannoy = E.Libs.ACH:Toggle(L["Annoy"], L["Repeat bling periodically while glow is active"], 19, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.pixelannoy end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelannoy = value ElvUI_EltreumUI:UpdateActiveGlows() end)
	ElvUI_EltreumUI.Options.args.customglow.args.pixel.args.pixelannoyfrequency = E.Libs.ACH:Range(L["Annoy Frequency"], L["Frequency of annoy bling"], 20, { min = 0.05, max = 2, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.glow.pixelannoyFrequency end, function(_, value) E.db.ElvUI_EltreumUI.glow.pixelannoyFrequency = value ElvUI_EltreumUI:UpdateActiveGlows() end, function() return not E.db.ElvUI_EltreumUI.glow.pixelannoy end)

	-- Autocast Glow Tab
	ElvUI_EltreumUI.Options.args.customglow.args.autocast = E.Libs.ACH:Group(L["Autocast Glow"], nil, 3, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end)
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.numberautocast = E.Libs.ACH:Range(L["Autocast Particle Groups (Default is 8)"], L["Set the number of groups for autocast, for each group you get 4 particles"], 2, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.numberauto end, function(_, value) E.db.ElvUI_EltreumUI.glow.numberauto = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.autofrequency = E.Libs.ACH:Range(L["Autocast Frequency (Default is 0.8)"], L["Speed for Autocast, set to negative to inverse direction of rotation"], 4, { min = -3, max = 3, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.frequencyauto end, function(_, value) E.db.ElvUI_EltreumUI.glow.frequencyauto = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.description3 = E.Libs.ACH:Description(" ", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.autoscale = E.Libs.ACH:Range(L["Autocast Scale (Default is 2)"], L["Change the size of Autocast"], 6, { min = -3, max = 3, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.autoscale end, function(_, value) E.db.ElvUI_EltreumUI.glow.autoscale = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.description4 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.autooffsetx = E.Libs.ACH:Range(L["Autocast Horizontal Offset (Default is 5)"], L["Set the horizontal offset of autocast"], 8, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.autoxOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.autoxOffset = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.description5 = E.Libs.ACH:Description(" ", 9, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.autocast.args.autooffsety = E.Libs.ACH:Range(L["Autocast Vertical Offset (Default is 5)"], L["Set the vertical offset of autocast"], 10, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.autoyOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.autoyOffset = value end)

	-- Blizzard Glow Tab
	ElvUI_EltreumUI.Options.args.customglow.args.blizzard = E.Libs.ACH:Group(L["Blizzard Glow"], nil, 3, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end)
	ElvUI_EltreumUI.Options.args.customglow.args.blizzard.args.description1 = E.Libs.ACH:Description(L["Blizzard Glow"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.blizzard.args.frequencyblizz = E.Libs.ACH:Range(L["Blizzard Frequency (Default is 0.5)"], L["Speed for Blizzard glow"], 2, { min = 0.1, max = 3, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.frequencyblizz end, function(_, value) E.db.ElvUI_EltreumUI.glow.frequencyblizz = value end)

	-- Proc Glow Tab
	ElvUI_EltreumUI.Options.args.customglow.args.proc = E.Libs.ACH:Group(L["Proc Glow"], nil, 3, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end, not E.Modern)
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.startAnimation = E.Libs.ACH:Toggle(L["Start Animation"], L["Enable a start animation"], 1, nil, false,nil,function() return E.db.ElvUI_EltreumUI.glow.proc.startAnimation end,function(_, value) E.db.ElvUI_EltreumUI.glow.proc.startAnimation = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.description1 = E.Libs.ACH:Description(L["Proc Glow"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.duration = E.Libs.ACH:Range(_G.SPEED or L["Speed"], L["Speed for Proc Glow"], 3, { min = 0.5, max = 3, step = 0.1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.proc.duration end, function(_, value) E.db.ElvUI_EltreumUI.glow.proc.duration = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.description6 = E.Libs.ACH:Description(" ", 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.procxoffset = E.Libs.ACH:Range(L["X-Offset"], L["Set the horizontal offset of pixels"], 5, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.proc.xOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.proc.xOffset = value end)
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.description7 = E.Libs.ACH:Description(" ", 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.customglow.args.proc.args.procyoffset = E.Libs.ACH:Range(L["Y-Offset"], L["Set the vertical offset of pixels"], 7, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.proc.yOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.proc.yOffset = value end)

	-- Border Pulse Glow Tab
	ElvUI_EltreumUI.Options.args.customglow.args.borderpulse = E.Libs.ACH:Group(L["Border Pulse"], nil, 3, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end)
	local bpArgs = ElvUI_EltreumUI.Options.args.customglow.args.borderpulse.args
	bpArgs.header = E.Libs.ACH:Description(L["Border Pulse"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	bpArgs.number = E.Libs.ACH:Select(L["Number of Lines"], L["Number of tail lines"], 2, { [1] = "1", [2] = "2", [4] = "4" }, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.number end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.number = tonumber(value) end)
	bpArgs.startPoint = E.Libs.ACH:Select(L["Start Point"], L["Starting point of lines"], 3, startPoints, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.startPoint end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.startPoint = value end)
	bpArgs.thickness = E.Libs.ACH:Range(L["Line Thickness"], L["Thickness of lines"], 4, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.borderpulse.thickness end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.thickness = value end)
	bpArgs.frequency = E.Libs.ACH:Range(L["Frequency"], L["Frequency of glow pulses"], 5, { min = -10, max = 10, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.glow.borderpulse.frequency end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.frequency = value end)
	bpArgs.sine = E.Libs.ACH:Toggle(L["Sine"], L["Use sinusoidal progress instead of linear"], 6, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.sine end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.sine = value end)
	bpArgs.clockwise = E.Libs.ACH:Toggle(L["Clockwise"], L["Direction of pulses"], 7, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.clockwise end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.clockwise = value end)
	bpArgs.mirror = E.Libs.ACH:Toggle(L["Mirror"], L["Mirror line progress"], 8, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.mirror end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.mirror = value end)
	bpArgs.startBling = E.Libs.ACH:Toggle(L["Start Bling"], L["Show Bling on first application of glow"], 9, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.startBling end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.startBling = value end)
	bpArgs.repeatBling = E.Libs.ACH:Toggle(L["Repeat Bling"], L["Show Bling on reapplication of glow"], 10, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.repeatBling end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.repeatBling = value end)
	bpArgs.annoy = E.Libs.ACH:Toggle(L["Annoy"], L["Repeat bling periodically while glow is active"], 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.annoy end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.annoy = value end)
	bpArgs.annoyFrequency = E.Libs.ACH:Range(L["Annoy Frequency"], L["Frequency of annoy bling"], 12, { min = 0.05, max = 2, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.glow.borderpulse.annoyFrequency end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.annoyFrequency = value end, function() return not E.db.ElvUI_EltreumUI.glow.borderpulse.annoy end)
	bpArgs.forceStop = E.Libs.ACH:Toggle(L["Force Stop"], L["Stops glow immediately without waiting for period end"], 13, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.borderpulse.forceStop end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.forceStop = value end)
	bpArgs.xoffset = E.Libs.ACH:Range(L["X-Offset"], L["Set the horizontal offset of pixels"], 14, { min = -20, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.borderpulse.xOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.xOffset = value end)
	bpArgs.yoffset = E.Libs.ACH:Range(L["Y-Offset"], L["Set the vertical offset of pixels"], 15, { min = -20, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.borderpulse.yOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.borderpulse.yOffset = value end)

	-- Bling Glow Tab
	ElvUI_EltreumUI.Options.args.customglow.args.bling = E.Libs.ACH:Group(L["Bling"], nil, 3, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.glow.enable and not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow and not E.db.ElvUI_EltreumUI.glow.enablepet and not E.db.ElvUI_EltreumUI.glow.enableUFs end)
	local blArgs = ElvUI_EltreumUI.Options.args.customglow.args.bling.args
	blArgs.header = E.Libs.ACH:Description(L["Bling"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	local flashTypes = {
		["split"] = L["Split"],
		["shutter"] = L["Shutter"],
		["square"] = L["Square"],
	}
	blArgs.flash = E.Libs.ACH:Select(L["Flash"], L["Type of flash"], 2, flashTypes, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.flash end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.flash = value end)
	blArgs.startPoint = E.Libs.ACH:Select(L["Start Point"], L["Starting point of flash"], 3, startPoints, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.startPoint end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.startPoint = value end)
	blArgs.duration = E.Libs.ACH:Range(_G.DURATION or L["Duration"], L["Bling duration in seconds"], 4, { min = 0.1, max = 3, step = 0.05 }, "full", function() return E.db.ElvUI_EltreumUI.glow.bling.duration end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.duration = value end)
	blArgs.sine = E.Libs.ACH:Toggle(L["Sine"], L["Use sinusoidal progress instead of linear"], 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.sine end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.sine = value end)
	blArgs.reverse = E.Libs.ACH:Toggle(L["Reverse"], L["Reverses Bling progress"], 6, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.reverse end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.reverse = value end)
	blArgs.noTails = E.Libs.ACH:Toggle(L["Disable Tails"], L["Bling will not show lines, only flash"], 7, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.noTails end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.noTails = value end)
	blArgs.thickness = E.Libs.ACH:Range(L["Tail Thickness"], L["Thickness of tails"], 8, { min = 1, max = 10, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.bling.thickness end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.thickness = value end, function() return E.db.ElvUI_EltreumUI.glow.bling.noTails end)
	blArgs.tailN = E.Libs.ACH:Select(L["Tail Lines"], L["Number of tail lines"], 9, { [1] = "1", [2] = "2", [4] = "4" }, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.tailN end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.tailN = tonumber(value) end, function() return E.db.ElvUI_EltreumUI.glow.bling.noTails end)
	blArgs.tailStartPoint = E.Libs.ACH:Select(L["Tail Start Point"], L["Starting point of tail lines"], 10, startPoints, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.tailStartPoint end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.tailStartPoint = value end, function() return E.db.ElvUI_EltreumUI.glow.bling.noTails end)
	blArgs.tailClockwise = E.Libs.ACH:Toggle(L["Clockwise"], L["Clockwise direction"], 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.tailClockwise end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.tailClockwise = value end, function() return E.db.ElvUI_EltreumUI.glow.bling.noTails end)
	blArgs.tailMirror = E.Libs.ACH:Toggle(L["Mirror"], L["Mirror line progress"], 12, nil, false, nil, function() return E.db.ElvUI_EltreumUI.glow.bling.tailMirror end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.tailMirror = value end, function() return E.db.ElvUI_EltreumUI.glow.bling.noTails end)
	blArgs.xoffset = E.Libs.ACH:Range(L["X-Offset"], L["Set the horizontal offset of pixels"], 13, { min = -20, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.bling.xOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.xOffset = value end)
	blArgs.yoffset = E.Libs.ACH:Range(L["Y-Offset"], L["Set the vertical offset of pixels"], 14, { min = -20, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.glow.bling.yOffset end, function(_, value) E.db.ElvUI_EltreumUI.glow.bling.yOffset = value end)
end
