local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:DarkMode()
	if E.private.unitframe.enable then
		if not E.db.movers then E.db.movers = {} end

		--setup colors
		E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["a"] = 0.25
		E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["a"] = 0.25
		E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["a"] = 0.25
		E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["a"] = 0.5
		E.db["unitframe"]["colors"]["healPrediction"]["maxOverflow"] = 0.01
		E.db["unitframe"]["colors"]["healPrediction"]["personal"]["a"] = 0.25
		E.db["unitframe"]["colors"]["healPrediction"]["personal"]["b"] = 0.50196078431373
		E.db["unitframe"]["colors"]["healPrediction"]["others"]["a"] = 0.25
		E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
		E.db["unitframe"]["colors"]["classbackdrop"] = true
		E.db["unitframe"]["colors"]["healthclass"] = false
		E.db["unitframe"]["colors"]["customhealthbackdrop"] = false
		E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
		E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false
		E.db["unitframe"]["units"]["player"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["pet"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["boss"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["raid"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["raid40"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["target"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["colors"]["transparentAurabars"] = true
		E.db["unitframe"]["colors"]["transparentCastbar"] = true
		E.db["unitframe"]["colors"]["transparentHealth"] = true
		E.db["unitframe"]["colors"]["transparentPower"] = true
		E.db["auras"]["buffs"]["barTexture"] = "Eltreum-Blank"
		E.db["auras"]["debuffs"]["barTexture"] = "Eltreum-Blank"
		E.db["unitframe"]["statusbar"] = "Eltreum-Blank"
		E.db["unitframe"]["units"]["player"]["portrait"]["overlayAlpha"] = 0.3
		E.db["unitframe"]["units"]["target"]["portrait"]["overlayAlpha"] = 0.3

		--setup namecolors
		if E.Classic or E.TBC then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name][happiness:discord]"
		elseif E.Retail then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name]"
		end
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[namecolor][name] [eltruism:class:player] [eltruism:raidmarker]"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [namecolor][eltruism:difficulty][name:eltruism:abbreviate]"
			E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[namecolor][name:long:status]"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[namecolor][name:abbrev]"
		if E.Retail or E.TBC then
			E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[namecolor][name:medium]"
		end
		E.db.ElvUI_EltreumUI.lightmode = false
		E.db.ElvUI_EltreumUI.darkmode = true
		E.db.ElvUI_EltreumUI.UFmodifications = true
		--E.db.ElvUI_EltreumUI.gradientmode.enable = false

		E:UpdateMediaItems()
		E:UpdateUnitFrames()
		ElvUI_EltreumUI:Print("Unitframes set to Dark Mode")
	end
end

function ElvUI_EltreumUI:LightMode()
	if E.private.unitframe.enable then
		if not E.db.movers then E.db.movers = {} end
		--setup colors
		E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["a"] = 0.5
		E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["a"] = 0.5
		E.db["unitframe"]["colors"]["healPrediction"]["maxOverflow"] = 0.01
		E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["a"] = 0.5
		E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["a"] = 0.5
		E.db["unitframe"]["colors"]["healPrediction"]["personal"]["a"] = 0.5
		E.db["unitframe"]["colors"]["healPrediction"]["personal"]["b"] = 0.50196078431373
		E.db["unitframe"]["colors"]["healPrediction"]["others"]["a"] = 0.5
		E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
		E.db["unitframe"]["colors"]["classbackdrop"] = false
		E.db["unitframe"]["colors"]["healthclass"] = true
		E.db["unitframe"]["colors"]["customhealthbackdrop"] = true
		E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
		E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
		E.db["unitframe"]["units"]["player"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["party"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["pet"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["raid"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["raid40"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["tank"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["assist"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["target"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["units"]["boss"]["colorOverride"] = "USE_DEFAULT"
		E.db["unitframe"]["colors"]["transparentAurabars"] = true
		E.db["unitframe"]["colors"]["transparentCastbar"] = true
		E.db["unitframe"]["colors"]["transparentHealth"] = false
		E.db["unitframe"]["colors"]["transparentPower"] = false
		E.db["unitframe"]["units"]["player"]["portrait"]["overlayAlpha"] = 0.6
		E.db["unitframe"]["units"]["target"]["portrait"]["overlayAlpha"] = 0.6

		E.db["auras"]["buffs"]["barTexture"] = "Eltreum-Blank"
		E.db["auras"]["debuffs"]["barTexture"] = "Eltreum-Blank"
		E.db["unitframe"]["statusbar"] = "Eltreum-Blank"
		--setup namecolors
		if E.Classic or E.TBC then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name][happiness:discord]"
		elseif E.Retail then
			E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name]"
		end
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
			E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[name] [eltruism:IconOutline:player] [eltruism:raidmarker]"
			E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:IconOutline:player] [eltruism:difficulty][name:eltruism:abbreviate]"
			E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[name:long:status]"
			E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
		if E.Retail or E.TBC then
			E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:medium]"
		end
		E.db.ElvUI_EltreumUI.lightmode = true
		E.db.ElvUI_EltreumUI.darkmode = false
		--E.db.ElvUI_EltreumUI.gradientmode.enable = false
		E.db.ElvUI_EltreumUI.UFmodifications = true

		E:UpdateMediaItems()
		E:UpdateUnitFrames()
		ElvUI_EltreumUI:ChangePlayerTexture()
		ElvUI_EltreumUI:Print("Unitframes set to Light Mode")
	end
end

function ElvUI_EltreumUI:GradientMode()
	if E.private.unitframe.enable then
		if not E.db.movers then E.db.movers = {} end

		if E.db.ElvUI_EltreumUI.darkmode then
			--setup colors
			E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["a"] = 0.25
			E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["a"] = 0.25
			E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["a"] = 0.25
			E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["a"] = 0.5
			E.db["unitframe"]["colors"]["healPrediction"]["maxOverflow"] = 0.01
			E.db["unitframe"]["colors"]["healPrediction"]["personal"]["a"] = 0.25
			E.db["unitframe"]["colors"]["healPrediction"]["personal"]["b"] = 0.50196078431373
			E.db["unitframe"]["colors"]["healPrediction"]["others"]["a"] = 0.25
			E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
			E.db["unitframe"]["colors"]["classbackdrop"] = true
			E.db["unitframe"]["colors"]["healthclass"] = false
			E.db["unitframe"]["colors"]["customhealthbackdrop"] = false
			E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
			E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
			E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
			E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false
			E.db["unitframe"]["units"]["player"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["pet"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["boss"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["raid"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["raid40"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["target"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "FORCE_OFF"
			E.db["unitframe"]["colors"]["transparentAurabars"] = true
			E.db["unitframe"]["colors"]["transparentCastbar"] = true
			E.db["unitframe"]["colors"]["transparentHealth"] = true
			E.db["unitframe"]["colors"]["transparentPower"] = true
			E.db["auras"]["buffs"]["barTexture"] = "Eltreum-Blank"
			E.db["auras"]["debuffs"]["barTexture"] = "Eltreum-Blank"
			E.db["unitframe"]["statusbar"] = "Eltreum-Blank"
			E.db["unitframe"]["units"]["player"]["portrait"]["overlayAlpha"] = 0.3
			E.db["unitframe"]["units"]["target"]["portrait"]["overlayAlpha"] = 0.3

			--setup namecolors
			if E.Classic or E.TBC then
				E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name][happiness:discord]"
			elseif E.Retail then
				E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[namecolor][name]"
			end
				E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[namecolor][name] [eltruism:class:player] [eltruism:raidmarker]"
				E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:class:player] [namecolor][eltruism:difficulty][name:eltruism:abbreviate]"
				E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[namecolor][name:long:status]"
				E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[namecolor][name:abbrev]"
			if E.Retail or E.TBC then
				E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[namecolor][name:medium]"
			end
		elseif E.db.ElvUI_EltreumUI.lightmode then
			--setup colors
			E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["a"] = 0.5
			E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["a"] = 0.5
			E.db["unitframe"]["colors"]["healPrediction"]["maxOverflow"] = 0.01
			E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["a"] = 0.5
			E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["a"] = 0.5
			E.db["unitframe"]["colors"]["healPrediction"]["personal"]["a"] = 0.5
			E.db["unitframe"]["colors"]["healPrediction"]["personal"]["b"] = 0.50196078431373
			E.db["unitframe"]["colors"]["healPrediction"]["others"]["a"] = 0.5
			E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
			E.db["unitframe"]["colors"]["classbackdrop"] = false
			E.db["unitframe"]["colors"]["healthclass"] = true
			E.db["unitframe"]["colors"]["customhealthbackdrop"] = true
			E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0
			E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
			E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0
			E.db["unitframe"]["units"]["player"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["player"]["forcehealthreaction"] = false
			E.db["unitframe"]["units"]["assist"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["party"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["pet"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["raid"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["raid40"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["tank"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["assist"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["target"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["units"]["boss"]["colorOverride"] = "USE_DEFAULT"
			E.db["unitframe"]["colors"]["transparentAurabars"] = true
			E.db["unitframe"]["colors"]["transparentCastbar"] = true
			E.db["unitframe"]["colors"]["transparentHealth"] = false
			E.db["unitframe"]["colors"]["transparentPower"] = false
			E.db["unitframe"]["units"]["player"]["portrait"]["overlayAlpha"] = 0.6
			E.db["unitframe"]["units"]["target"]["portrait"]["overlayAlpha"] = 0.6

			E.db["auras"]["buffs"]["barTexture"] = "Eltreum-Blank"
			E.db["auras"]["debuffs"]["barTexture"] = "Eltreum-Blank"
			E.db["unitframe"]["statusbar"] = "Eltreum-Blank"
			--setup namecolors
			if E.Classic or E.TBC then
				E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name][happiness:discord]"
			elseif E.Retail then
				E.db["unitframe"]["units"]["pet"]["customTexts"]["EltreumPetName"]["text_format"] = "[name]"
			end
				E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
				E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumName"]["text_format"] = "[name] [eltruism:IconOutline:player] [eltruism:raidmarker]"
				E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetName"]["text_format"] = "[eltruism:raidmarker] [eltruism:IconOutline:player] [eltruism:difficulty][name:eltruism:abbreviate]"
				E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = "[name:long:status]"
				E.db["unitframe"]["units"]["targettarget"]["customTexts"]["EltreumTargetTargetName"]["text_format"] = "[name:abbrev]"
			if E.Retail or E.TBC then
				E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:medium]"
			end
		end

		E.db.ElvUI_EltreumUI.gradientmode.enable = true
		E.db.ElvUI_EltreumUI.gradientmode.enableplayertarget = true
		E.db.ElvUI_EltreumUI.gradientmode.enablegroupunits = true
		E.db.ElvUI_EltreumUI.UFmodifications = true

		E:UpdateMediaItems()
		E:UpdateUnitFrames()
		ElvUI_EltreumUI:ChangePlayerTexture()
		ElvUI_EltreumUI:Print("Unitframes set to Gradient Mode")
	end
end

local NP = E:GetModule('NamePlates')
hooksecurefunc(NP, 'Initialize', function()
	if E.db.ElvUI_EltreumUI.darkpowercolor then
		NP.multiplier = 0
	end
end)
if E.Retail then
	hooksecurefunc(NP, 'Construct_Runes', function()
		if E.db.ElvUI_EltreumUI.darkpowercolor then
			NP.multiplier = 0
		end
	end)
end

function ElvUI_EltreumUI:ShamanTextureMode()
	if (E.TBC or E.Classic) and E.myclass == 'SHAMAN' then
		if E.db.ElvUI_EltreumUI.darkpowercolor and E.private.unitframe.enable then
			local UF = E:GetModule('UnitFrames') --only classpower that is actually in UF instead of NP
			local function TotemBackground()
				local header = _G['ElvUF_Player']
				for i = 1, header:GetNumChildren() do
					local group = select(i, header:GetChildren())
					for j = 1, group:GetNumChildren() do
						local unitbutton = select(j, group:GetChildren())
						if unitbutton and unitbutton.bg then
							unitbutton.bg:SetVertexColor(0, 0, 0)
						end
					end
				end
			end
			hooksecurefunc(UF, 'Construct_Totems', TotemBackground)
			TotemBackground()
		end
	end
end

--a more grey and less dark background
function ElvUI_EltreumUI:GreyBg()
	E.db["general"]["backdropcolor"]["b"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["g"] = 0.098039215686275
	E.db["general"]["backdropcolor"]["r"] = 0.098039215686275
	E.db["general"]["backdropfadecolor"]["a"] = 0.80000001192093
	E.db["general"]["backdropfadecolor"]["b"] = 0.13725490196078
	E.db["general"]["backdropfadecolor"]["g"] = 0.13725490196078
	E.db["general"]["backdropfadecolor"]["r"] = 0.13725490196078

	E.db.ElvUI_EltreumUI.greybackground = true
	E:UpdateMediaItems()
	ElvUI_EltreumUI:Print("ElvUI set to Grey Background")
end

--the traditional black/dark background
function ElvUI_EltreumUI:BlackBg()
	E.db["general"]["backdropcolor"]["b"] = 0
	E.db["general"]["backdropcolor"]["g"] = 0
	E.db["general"]["backdropcolor"]["r"] = 0
	E.db["general"]["backdropfadecolor"]["a"] = 0.70000001788139
	E.db["general"]["backdropfadecolor"]["b"] = 0
	E.db["general"]["backdropfadecolor"]["g"] = 0
	E.db["general"]["backdropfadecolor"]["r"] = 0

	E.db.ElvUI_EltreumUI.greybackground = false
	E:UpdateMediaItems()
	ElvUI_EltreumUI:Print("ElvUI set to Black Background")
end
