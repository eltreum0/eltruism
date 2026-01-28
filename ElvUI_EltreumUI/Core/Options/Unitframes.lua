local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local tostring = _G.tostring
local tonumber = _G.tonumber
local OKAY = _G.OKAY

local PortraitStyles = {
	["RELEAF"] = "Releaf",
	["OUTLINE"] = L["Outline"],
	["BLIZZARD"] = L["Blizzard"],
	["BORDER"] = L["Border"],
	["SHADOW"] = L["Shadow"],
	["ORIGINAL"] = L["Original"],
	["GRADIENT"] = L["Gradient"],
	["SYMBOLS"] = L["Symbols"],
	["UGG"] = L["U.GG"],
	["UGGGREY"] = L["U.GG Grey"],
}

local function PortraitWasToggled(portrait, value)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if portrait == "all" then
			E.db.unitframe.units.player.portrait.enable = value
			E.db.unitframe.units.target.portrait.enable = value
			E.db.unitframe.units.focus.portrait.enable = value
			E.db.unitframe.units.focustarget.portrait.enable = value
			E.db.unitframe.units.targettarget.portrait.enable = value
			E.db.unitframe.units.boss.portrait.enable = value
			E.db.unitframe.units.party.portrait.enable = value
			E.db.unitframe.units.pet.portrait.enable = value

			if value == true then
				E.db.unitframe.units.player.portrait.overlay = value
				E.db.unitframe.units.target.portrait.overlay = value
				E.db.unitframe.units.focus.portrait.overlay = value
				E.db.unitframe.units.focustarget.portrait.overlay = value
				E.db.unitframe.units.targettarget.portrait.overlay = value
				E.db.unitframe.units.boss.portrait.overlay = value
				E.db.unitframe.units.party.portrait.overlay = value
				E.db.unitframe.units.pet.portrait.overlay = value
			end

			E:StaticPopup_Show('CONFIG_RL')
		else
			if portrait == "player" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable then
					E.db.unitframe.units.player.portrait.enable = value
					if value == true then
						E.db.unitframe.units.player.portrait.overlay = value
					end
				end
			elseif portrait == "target" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable then
					E.db.unitframe.units.target.portrait.enable = value
					if value == true then
						E.db.unitframe.units.target.portrait.overlay = value
					end
				end
			elseif portrait == "focus" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable then
					E.db.unitframe.units.focus.portrait.enable = value
					if value == true then
					E.db.unitframe.units.focus.portrait.overlay = value
					end
				end
			elseif portrait == "focustarget" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable then
					E.db.unitframe.units.focustarget.portrait.enable = value
					if value == true then
						E.db.unitframe.units.focustarget.portrait.overlay = value
					end
				end
			elseif portrait == "targettarget" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable then
					E.db.unitframe.units.targettarget.portrait.enable = value
					if value == true then
						E.db.unitframe.units.targettarget.portrait.overlay = value
					end
				end
			elseif portrait == "boss" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable then
					E.db.unitframe.units.boss.portrait.enable = value
					if value == true then
						E.db.unitframe.units.boss.portrait.overlay = value
					end
				end
			elseif portrait == "party" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable then
					E.db.unitframe.units.party.portrait.enable = value
					if value == true then
						E.db.unitframe.units.party.portrait.overlay = value
					end
				end
			elseif portrait == "pet" then
				if E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable then
					E.db.unitframe.units.pet.portrait.enable = value
					if value == true then
						E.db.unitframe.units.pet.portrait.overlay = value
					end
				end
			end
		end
	end
end

-- Eltruism unitframe options
function ElvUI_EltreumUI:UnitframeOptions()
	ElvUI_EltreumUI.Options.args.unitframes = E.Libs.ACH:Group(E:TextGradient(L["Unitframes"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Add Gradient, Custom Textures, Models, change fill orientation and more"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.unitframes.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\unitframes'
	ElvUI_EltreumUI.Options.args.unitframes.args.enableufmods = E.Libs.ACH:Toggle(L["Enable Unitframe Modifications"], L["Enable changing textures and gradients for ElvUI unitframes"], 1, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.UFmodifications end,function(_, value) E.db.ElvUI_EltreumUI.unitframes.UFmodifications = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general = E.Libs.ACH:Group(L["General"], nil, 2, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description1 = E.Libs.ACH:Description(L["Change the look of frames to Dark or Light mode"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.darkmode = E.Libs.ACH:Toggle(L["Dark Mode"], L["This will set colors to black with class colors when losing health"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.darkmode end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.darkmode = value end, function() return E.db.ElvUI_EltreumUI.unitframes.lightmode or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.lightmode = E.Libs.ACH:Toggle(L["Light Mode"], L["This will set colors to class based with black backgrounds when losing health"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.lightmode end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.lightmode = value end, function() return E.db.ElvUI_EltreumUI.unitframes.darkmode or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.apply = E.Libs.ACH:Execute(L["Apply"], L["Apply the mode selected"], 3, function()
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			ElvUI_EltreumUI:LightMode()

			E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.unitframes.darkmode then
			ElvUI_EltreumUI:DarkMode()

			E:StaticPopup_Show('CONFIG_RL')
		else
			ElvUI_EltreumUI:LightMode()

			E:StaticPopup_Show('CONFIG_RL')
		end
	end, nil, false, nil, nil, nil, function() return (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description2 = E.Libs.ACH:Description(L["Light Mode Texture Version"], 4, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.textureselect = E.Libs.ACH:Select("", nil, 5, {
		["V1"] = L["Version 1"],
		["V2"] = L["Version 2"],
		["V3"] = L["Version 3"],
		["NONE"] = L["None"],
	}, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.uftextureversion end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.uftextureversion = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.lightmode end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.textureselect.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description3 = E.Libs.ACH:Description(L["Change the Class Power background"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.darkpower = E.Libs.ACH:Toggle(L["Dark Power Background"], L["Sets Class Power backgrounds to be black"], 7, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.darkpowercolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.darkpowercolor = value end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description4 = E.Libs.ACH:Description(L["Rest Icon"], 8, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.restingicon = E.Libs.ACH:Toggle(L["Replace ElvUI Rest Icon with Blizzard's Animated one"], nil, 9, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.blizzardresticon end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.blizzardresticon = value E:StaticPopup_Show('CONFIG_RL') end, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.restingiconclasscolor = E.Libs.ACH:Toggle(L["Use Class Colors"], nil, 10, nil, false,nil, function() return E.db.ElvUI_EltreumUI.unitframes.blizzardresticonclasscolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.blizzardresticonclasscolor = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.blizzardresticon or E.db.ElvUI_EltreumUI.unitframes.blizzardresticongradient end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.restingicongradient = E.Libs.ACH:Toggle(L["Gradient Mode"], nil, 11, nil, false,nil, function() return E.db.ElvUI_EltreumUI.unitframes.blizzardresticongradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.blizzardresticongradient = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.blizzardresticon or E.db.ElvUI_EltreumUI.unitframes.blizzardresticonclasscolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description5 = E.Libs.ACH:Description(L["Blizzard"], 12, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.skinblizzraid = E.Libs.ACH:Toggle(L["Skin Blizzard Raid Frames"], L["Adds Gradient, Custom Textures, Shadows, Font and Role Icons to Blizzard Raid Frames"], 13, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.blizzardraidframes end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.blizzardraidframes = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description6 = E.Libs.ACH:Description(L["Combat Indicator"], 14, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.skincombaticons = E.Libs.ACH:Toggle(L["Change Combat Indicators to be class based"], nil, 15, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.classcombaticons end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.classcombaticons = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description7 = E.Libs.ACH:Description(L["Heal Prediction"], 16, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.healpredictionskin = E.Libs.ACH:Toggle(L["Use ElvUI Unitframe Texture"], nil, 17, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealComm end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealComm = value end, function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealCommCustom or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.healpredictionskincustom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 18, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealCommCustom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealCommCustom = value end, function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealComm or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.healpredictionskincustomtexture = E.Libs.ACH:SharedMediaStatusbar(L["Texture"], L["Select a Texture"], 19, "full", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealCommTexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealCommTexture = key end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enableHealCommCustom or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.description8 = E.Libs.ACH:Description(L["Aura Bars"], 118, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.general.args.thinaurabars = E.Libs.ACH:Toggle(L["Thin Aura Bars"], nil, 119, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.thinmodeaurabars = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.orientation = E.Libs.ACH:Group(L["Fill Orientation"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.orientation.args.description1 = E.Libs.ACH:Description(L["Unitframe Fill Orientation"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.orientation.args.setorientation = E.Libs.ACH:Select("", nil, 4, {
		["HORIZONTAL"] = L["Horizontal"],
		["VERTICAL"] = L["Vertical"],
	}, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.UForientation end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.UForientation = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.orientation.args.setorientation.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop = E.Libs.ACH:Group(L["Health"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.hide = E.Libs.ACH:Toggle(L["Hide Backdrop"], L["Sets the Backdrop as Transparent/Hidden"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdrophidden = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.description11 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.texture = E.Libs.ACH:SharedMediaStatusbar(L["Backdrop Texture"], L["Select a Texture"], 4, "full", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexture = key end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.staticbackdropdesc = E.Libs.ACH:Description(L["Backdrop Texture Behavior"], 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.staticbackdrop = E.Libs.ACH:Toggle(E.NewSign..L["Enable static backdrop texture size"], L["Backdrop Texture will not adjust to the missing health"], 6, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexturestaticsize end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdroptexturestaticsize = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.lightmode or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.fliptarget = E.Libs.ACH:Toggle(E.NewSign..L["Invert Target Backdrop"], nil, 6, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.fliptargetbackdrop end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.fliptargetbackdrop = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.lightmode or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.description2 = E.Libs.ACH:Description(" ", 14, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.backdropalpha = E.Libs.ACH:Range(L["Backdrop Alpha"], L["Change the transparency of the backdrop"], 15, { min = 0, max = 1, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.backdrop.args.healthalpha = E.Libs.ACH:Range(L["Health Alpha"], L["Change the transparency of the health"], 15, { min = 0, max = 1, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.healthalpha = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.infopanel = E.Libs.ACH:Group(L["Information Panel"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.infopanel.args.description1 = E.Libs.ACH:Description(L["Information Panel"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.infopanel.args.infoPanelOnTop = E.Libs.ACH:Toggle(L["Enable Information Panel on Top"], L["Sets Information panel to be on Top instead of Bottom of the unitframe"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.infopanelontop end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.infopanelontop = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.infopanel.args.infoPanelOnTopAll = E.Libs.ACH:Toggle(L["Enable on All Unitframes"], nil, 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.infopanelontop end)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark = E.Libs.ACH:Group(L["Castbar Spark"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.description1 = E.Libs.ACH:Description(L["Customize the player castbar spark"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.enable = E.Libs.ACH:Toggle(L["Enable"], L["Customize Player CastBar Spark"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.enableaurabars = E.Libs.ACH:Toggle(L["Enable on Aura Bars"], nil, 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.description2 = E.Libs.ACH:Description(" ", 4, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.color = E.Libs.ACH:Color(L["Custom Color"], nil, 5, false, nil, function()
		local glowcustomcolor = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
		local d = P.ElvUI_EltreumUI.unitframes.sparkcustomcolor
		return glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b, glowcustomcolor.a, d.r, d.g, d.b, d.a
	end, function(_, r, g, b)
		local glowcustomcolor = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
		glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b = r, g, b
	end, function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.colorsparkempowering = E.Libs.ACH:Color(L["Empowering Color"], nil, 6, false, nil, function()
		local glowcustomcolor = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
		local d = P.ElvUI_EltreumUI.unitframes.sparkcustomcolor
		return glowcustomcolor.empoweringr, glowcustomcolor.empoweringg, glowcustomcolor.empoweringb, glowcustomcolor.a, d.empoweringr, d.empoweringg, d.empoweringb, d.a
	end, function(_, r, g, b)
		local glowcustomcolor = E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor
		glowcustomcolor.empoweringr, glowcustomcolor.empoweringg, glowcustomcolor.empoweringb = r, g, b
	end, function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable end, not E.Retail)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.description3 = E.Libs.ACH:Description(" ", 7, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.texture = E.Libs.ACH:SharedMediaStatusbar(L["Spark Texture"], L["Select a Texture"], 8, nil, function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.texture = key end, function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable or not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars end)
	ElvUI_EltreumUI.Options.args.unitframes.args.spark.args.width = E.Libs.ACH:Range(L["Width"], L["Set Width of the Spark (Default 3)"], 9, { min = 1, max = 20, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.width = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable or not E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture = E.Libs.ACH:Group(L["Textures"], L["Choose custom textures for some unitframes"], 4, "tab", nil, nil, function() return (not E.db.ElvUI_EltreumUI.unitframes.lightmode and not E.db.ElvUI_EltreumUI.unitframes.darkmode) or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.enable = E.Libs.ACH:Group("", nil, 2, "tab")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.enable.inline = true
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.enable.args.description1 = E.Libs.ACH:Description(L["Customize Unitframe textures"], 1, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.enable.args.customtexturesenable = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable = value end, function() return (not E.db.ElvUI_EltreumUI.unitframes.lightmode and not E.db.ElvUI_EltreumUI.unitframes.darkmode) or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.enable.args.classdetect = E.Libs.ACH:Toggle(L["Automatically Detect Classes for Player, Target, Target of Target and Focus"], L["Use the custom texture based on it's class instead of general texture for Player, Target, Target of Target and Focus"], 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect = value end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.enable.args.disableclass = E.Libs.ACH:Toggle(L["Disable Class Textures"], L["Use only textures sets for specific frames and not class specific textures"], 4, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture = value end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.classdetect end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes = E.Libs.ACH:Group(L["UnitFrames"], nil, 2, "tab")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.player = E.Libs.ACH:SharedMediaStatusbar(L["Player Texture"], L["Select a Texture"], 1, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall1 = E.Libs.ACH:Execute(L["Apply To All"], nil, 2, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap1 = E.Libs.ACH:Description('', 3, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.playercastbar = E.Libs.ACH:SharedMediaStatusbar(L["Player Castbar Texture"], L["Select a Texture"], 4, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall2 = E.Libs.ACH:Execute(L["Apply To All"], nil, 5, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap2 = E.Libs.ACH:Description('', 6, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.target = E.Libs.ACH:SharedMediaStatusbar(L["Target Texture"], L["Select a Texture"], 7, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall3 = E.Libs.ACH:Execute(L["Apply To All"], nil, 8, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap3 = E.Libs.ACH:Description('', 9, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.targettarget = E.Libs.ACH:SharedMediaStatusbar(L["Target of Target Texture"], L["Select a Texture"], 10, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall4 = E.Libs.ACH:Execute(L["Apply To All"], nil, 11, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture= E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap4 = E.Libs.ACH:Description('', 12, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.targettargettarget = E.Libs.ACH:SharedMediaStatusbar(L["Target of Target of Target Texture"], L["Select a Texture"], 13, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall5 = E.Libs.ACH:Execute(L["Apply To All"], nil, 14, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap5 = E.Libs.ACH:Description('', 15, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.focus = E.Libs.ACH:SharedMediaStatusbar(L["Focus Texture"], L["Select a Texture"], 16, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall6 = E.Libs.ACH:Execute(L["Apply To All"], nil, 17, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap6 = E.Libs.ACH:Description('', 18, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.pet = E.Libs.ACH:SharedMediaStatusbar(L["Pet Texture"], L["Select a Texture"], 19, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall7 = E.Libs.ACH:Execute(L["Apply To All"], nil, 20, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap7 = E.Libs.ACH:Description('', 21, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.boss = E.Libs.ACH:SharedMediaStatusbar(L["Boss Texture"], L["Select a Texture"], 22, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end, E.Classic)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall8 = E.Libs.ACH:Execute(L["Apply To All"], nil, 23, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true, nil, nil, nil, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap8 = E.Libs.ACH:Description('', 24, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.party = E.Libs.ACH:SharedMediaStatusbar(L["Party"], L["Select a Texture"], 25, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall9 = E.Libs.ACH:Execute(L["Apply To All"], nil, 26, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap9 = E.Libs.ACH:Description('', 27, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.raid = E.Libs.ACH:SharedMediaStatusbar(L["Raid"], L["Select a Texture"], 28, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall11 = E.Libs.ACH:Execute(L["Apply To All"], nil, 29, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.gap10 = E.Libs.ACH:Description('', 30, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.arena = E.Libs.ACH:SharedMediaStatusbar(E.NewSign..L["Arena"], L["Select a Texture"], 31, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.unitframes.args.applytoall12 = E.Libs.ACH:Execute(L["Apply To All"], nil, 32, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.playertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.targettargettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.focustexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.bosstexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.pettexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.partytexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.raidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.arenatexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes = E.Libs.ACH:Group(L["Classes"], nil, 3, "tab")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.description1 = E.Libs.ACH:Description(L["Class Textures"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.dk = E.Libs.ACH:SharedMediaStatusbar(L["Death Knight"], L["Select a Texture"], 2, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end, E.Classic)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall1 = E.Libs.ACH:Execute(L["Apply To All"], nil, 3, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true, nil, nil, nil, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap1 = E.Libs.ACH:Description('', 4, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.dh = E.Libs.ACH:SharedMediaStatusbar(L["Demon Hunter"], L["Select a Texture"], 5, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end, not E.Retail)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall2 = E.Libs.ACH:Execute(L["Apply To All"], nil, 6, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap2 = E.Libs.ACH:Description('', 7, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.druid = E.Libs.ACH:SharedMediaStatusbar(L["Druid"], L["Select a Texture"], 8, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall3 = E.Libs.ACH:Execute(L["Apply To All"], nil, 9, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap3 = E.Libs.ACH:Description('', 10, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.hunter = E.Libs.ACH:SharedMediaStatusbar(L["Hunter"], L["Select a Texture"], 11, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall4 = E.Libs.ACH:Execute(L["Apply To All"], nil, 12, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap4 = E.Libs.ACH:Description('', 13, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.mage = E.Libs.ACH:SharedMediaStatusbar(L["Mage"], L["Select a Texture"], 14, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall5 = E.Libs.ACH:Execute(L["Apply To All"], nil, 15, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap5 = E.Libs.ACH:Description('', 16, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.monk = E.Libs.ACH:SharedMediaStatusbar(L["Monk"], L["Select a Texture"], 17, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end, E.Classic)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall6 = E.Libs.ACH:Execute(L["Apply To All"], nil, 18, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true, nil, nil, nil, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap6 = E.Libs.ACH:Description('', 19, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.evoker = E.Libs.ACH:SharedMediaStatusbar(L["Evoker"], L["Select a Texture"], 20, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end, not E.Retail)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall7 = E.Libs.ACH:Execute(L["Apply To All"], nil, 21, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap7 = E.Libs.ACH:Description('', 22, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.paladin = E.Libs.ACH:SharedMediaStatusbar(L["Paladin"], L["Select a Texture"], 23, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall8 = E.Libs.ACH:Execute(L["Apply To All"], nil, 24, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap8 = E.Libs.ACH:Description('', 25, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.priest = E.Libs.ACH:SharedMediaStatusbar(L["Priest"], L["Select a Texture"], 26, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall9 = E.Libs.ACH:Execute(L["Apply To All"], nil, 27, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap9 = E.Libs.ACH:Description('', 28, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.rogue = E.Libs.ACH:SharedMediaStatusbar(L["Rogue"], L["Select a Texture"], 29, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall10 = E.Libs.ACH:Execute(L["Apply To All"], nil, 30, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap10 = E.Libs.ACH:Description('', 31, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.shaman = E.Libs.ACH:SharedMediaStatusbar(L["Shaman"], L["Select a Texture"], 32, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall11 = E.Libs.ACH:Execute(L["Apply To All"], nil, 33, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap11 = E.Libs.ACH:Description('', 34, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.warlock = E.Libs.ACH:SharedMediaStatusbar(L["Warlock"], L["Select a Texture"], 35, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall12 = E.Libs.ACH:Execute(L["Apply To All"], nil, 36, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap12 = E.Libs.ACH:Description('', 37, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.warrior = E.Libs.ACH:SharedMediaStatusbar(L["Warrior"], L["Select a Texture"], 38, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.applytoall13 = E.Libs.ACH:Execute(L["Apply To All"], nil, 39, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.classes.args.gap13 = E.Libs.ACH:Description('', 40, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs = E.Libs.ACH:Group(L["NPC"], nil, 3, "tab")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.description1 = E.Libs.ACH:Description(L["NPC Textures"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.npcfriendly = E.Libs.ACH:SharedMediaStatusbar(L["Friendly NPC"], L["Select a Texture"], 2, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.applytoall14 = E.Libs.ACH:Execute(L["Apply To All"], nil, 3, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.gap1 = E.Libs.ACH:Description('', 4, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.npcneutral = E.Libs.ACH:SharedMediaStatusbar(L["Neutral NPC"], L["Select a Texture"], 5, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.applytoall15 = E.Libs.ACH:Execute(L["Apply To All"], nil, 6, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.gap2 = E.Libs.ACH:Description('', 7, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.npcunfriendly = E.Libs.ACH:SharedMediaStatusbar(L["Unfriendly NPC"], L["Select a Texture"], 8, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.applytoall16 = E.Libs.ACH:Execute(L["Apply To All"], nil, 9, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.gap3 = E.Libs.ACH:Description('', 10, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.npchostile = E.Libs.ACH:SharedMediaStatusbar(L["Hostile NPC"], L["Select a Texture"], 11, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.applytoall17 = E.Libs.ACH:Execute(L["Apply To All"], nil, 12, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.gap4 = E.Libs.ACH:Description('', 13, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.tappedtexture = E.Libs.ACH:SharedMediaStatusbar(L["Tapped NPC"], L["Select a Texture"], 14, "double", function() return E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture end, function(_,key) E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture = key ElvUI_EltreumUI:GradientColorTableUpdate() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.enable) or E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.noclasstexture end)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.applytoall18 = E.Libs.ACH:Execute(L["Apply To All"], nil, 15, function()
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.deathknighttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.demonhuntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.evokertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.druidtexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.huntertexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.magetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.monktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.paladintexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.priesttexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.roguetexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.shamantexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warlocktexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.warriortexture = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcneutral = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npcunfriendly = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.npchostile = E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.tappedtexture
		ElvUI_EltreumUI:GradientColorTableUpdate()
	end, nil, true)
	ElvUI_EltreumUI.Options.args.unitframes.args.texture.args.npcs.args.gap5 = E.Libs.ACH:Description('', 16, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait = E.Libs.ACH:Group(L["Portrait"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general = E.Libs.ACH:Group(L["General"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.description1 = E.Libs.ACH:Description(L["Target Portrait Fix"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.enableportraitfix = E.Libs.ACH:Toggle(L["Automatically rotate Target Portrait"], L["Detects target's species and uses it to fix the rotation of the Target's 3D Portrait"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraitfix end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitfix = value end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.offset = E.Libs.ACH:Toggle(L["Automatically offset Player/Target Portrait"], L["Detects player and target's species and uses it to fix the offset of the 3D Portrait"], 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraitfixoffset end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitfixoffset = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.portraitfix end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.enableportraitdead = E.Libs.ACH:Toggle(L["Pause and Desaturate Portrait if Dead"], nil, 4, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraitdead end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitdead = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.portraitfix end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.description2 = E.Libs.ACH:Description(L["Portrait Skin"], 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.enableportraitskin = E.Libs.ACH:Toggle(L["Enable Portrait Skin"], nil, 8, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.enable = value PortraitWasToggled("all", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.gradient = E.Libs.ACH:Toggle(L["Enable Gradient"], nil, 9, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.gradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.gradient = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.general.args.shadow = E.Libs.ACH:Toggle(L["Enable Shadows"], nil, 10, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.shadow end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.shadow = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player = E.Libs.ACH:Group(L["Player"], nil, 20, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") PortraitWasToggled("player", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 6, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 7, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.player.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.player.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.player.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.description1 = E.Libs.ACH:Description(" ", 8, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.player.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.player.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.player.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target = E.Libs.ACH:Group(L["Target"], nil, 21, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") PortraitWasToggled("target", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.target.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.target.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.target.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.target.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.target.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.target.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus = E.Libs.ACH:Group(L["Focus"], nil, 22, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end, E.Classic or E.ClassicHC)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") PortraitWasToggled("focus", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focus.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focus.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focus.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focus.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget = E.Libs.ACH:Group(L["FocusTarget"], nil, 22, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end, E.Classic or E.ClassicHC)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") PortraitWasToggled("focustarget", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.focustarget.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget = E.Libs.ACH:Group(L["TargetTarget"], nil, 22, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") PortraitWasToggled("targettarget", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.targettarget.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party = E.Libs.ACH:Group(L["Party"], nil, 23, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") PortraitWasToggled("party", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.party.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.party.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.party.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.party.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.party.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.party.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet = E.Libs.ACH:Group(E.NewSign..L["Pet"], nil, 24, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") PortraitWasToggled("pet", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 6, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.pet.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 7, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.pet.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.pet.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.pet.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss = E.Libs.ACH:Group(L["Boss"], nil, 23, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") PortraitWasToggled("boss", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.boss.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.boss.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.boss.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args.boss.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.models = E.Libs.ACH:Group(L["Models"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.warning = E.Libs.ACH:Description("|cffFF0000WARNING:|r"..L[" This can be a very demanding feature, it's not recommended to use models for performance."], 1, nil, nil, nil, nil, nil, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes = E.Libs.ACH:Group(L["UnitFrames"], nil, 2, "tab", nil, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.description1 = E.Libs.ACH:Description(L["Unitframe Models"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.enable = E.Libs.ACH:Toggle(L["Enable Models/Effects"], L["Enable adding models as effects on unitframes"], 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.unitframe end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.unitframe = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() E.db.unitframe.colors.transparentHealth = true E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.insideHP = E.Libs.ACH:Toggle(L["Model Inside Health"], L["Model will be set inside health instead of over whole frame"], 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.insideHP end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.insideHP = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() E.db.unitframe.colors.transparentHealth = true E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.selectmodel = E.Libs.ACH:Select(L["Choose between Class Based Models or a Custom Model"], nil, 4, { ["CLASS"] = _G.CLASS, ["CUSTOM"] = _G.CUSTOM, }, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltype end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.modeltype = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end, function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.selectmodel.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.custommodelpath = E.Libs.ACH:Input(function() if E.Retail then return L["Type the Model ID, such as 165575"] else return L["Type the Model Path, such as spells/arcanebreath.m2"] end end, nil, 5, nil, "full", function() if E.Retail then return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodel) else return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic) end end, function(_, value) if E.Retail then E.db.ElvUI_EltreumUI.unitframes.models.custommodel = tonumber(value) else E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassic = tostring(value) end ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end, function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltype == 'CLASS' or not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end, nil, function(_, value)
		E.PopupDialogs["ELTRUISMINVALIDMODEL"] = {
			text = L["Invalid Model, you need to add a Model ID/Path"],
			button1 = OKAY,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = true,
		}
		if E.Retail then if tonumber(value) ~= nil then return true else return E:StaticPopup_Show('ELTRUISMINVALIDMODEL') and false end else return true end end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.modelalphalight = E.Libs.ACH:Range(L["Light Mode Alpha"], nil, 6, { min = 0, max = 1, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.ufalpha end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.ufalpha = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end, function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.modelalphadark = E.Libs.ACH:Range(L["Dark Mode Alpha"], nil, 6, { min = 0, max = 1, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end, function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.unitframes.args.modeldesaturation = E.Libs.ACH:Range(L["Desaturation"], nil, 7, { min = 0, max = 1, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.ufdesaturation = value ElvUI_EltreumUI:PlayerUFEffects() ElvUI_EltreumUI:TargetUFEffects() ElvUI_EltreumUI:TargetTargetUFEffects() end, function() return not E.db.ElvUI_EltreumUI.unitframes.models.unitframe or not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.castbar = E.Libs.ACH:Group(L["Cast Bar"], nil, 2, "tab", nil, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.castbar.args.description1 = E.Libs.ACH:Description(L["Castbar Models"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.castbar.args.enable = E.Libs.ACH:Toggle(L["Enable Models/Effects"], L["Enable adding models as effects on Castbars"], 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.castbar end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.castbar = value ElvUI_EltreumUI:CastbarEffects() end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.castbar.args.selectmodel = E.Libs.ACH:Select(L["Choose between a Default Model or a Custom Model"], nil, 3, { ["DEFAULT"] = L["Default"], ["CUSTOM"] = _G.CUSTOM, }, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast = value ElvUI_EltreumUI:CastbarEffects() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.castbar) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.castbar.args.selectmodel.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.castbar.args.custommodelpath = E.Libs.ACH:Input(function() if E.Retail then return L["Type the Model ID, such as 165821"] else return L["Type the Model Path, such as spells/corruption_impactdot_med_base.m2"] end end, nil, 4, nil, "full", function() if E.Retail then return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelcast) else return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassiccast) end end, function(_, value) if E.Retail then E.db.ElvUI_EltreumUI.unitframes.models.custommodelcast = tonumber(value) else E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassiccast = tostring(value) end ElvUI_EltreumUI:CastbarEffects() end, function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypecast == "DEFAULT" or (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.castbar) end, nil, function(_, value)
		E.PopupDialogs["ELTRUISMINVALIDMODELCAST"] = {
			text = L["Invalid Model, you need to add a Model ID/Path"],
			button1 = OKAY,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = true,
		}
		if E.Retail then if tonumber(value) ~= nil then return true else return E:StaticPopup_Show('ELTRUISMINVALIDMODELCAST') and false end else return true end end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.power = E.Libs.ACH:Group(L["Power Bar"], nil, 2, "tab", nil, nil)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.power.args.description1 = E.Libs.ACH:Description(L["Power Bar Models"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.power.args.enable = E.Libs.ACH:Toggle(L["Enable Models/Effects"], nil, 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.models.powerbar end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.powerbar = value ElvUI_EltreumUI:PlayerUFEffects() end, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.power.args.select = E.Libs.ACH:Select(L["Choose between a Default Model or a Custom Model"], nil, 3, {
		["DEFAULT"] = L["Default"],
		["CUSTOM"] = _G.CUSTOM,
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower = value ElvUI_EltreumUI:PlayerUFEffects() end, function() return (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.powerbar) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.power.args.select.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.models.args.power.args.custommodelpath = E.Libs.ACH:Input(function() if E.Retail then return L["Type the Model ID, such as 165821"] else return L["Type the Model Path, such as spells/corruption_impactdot_med_base.m2"] end end, nil, 5, nil, "full", function() if E.Retail then return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower) else return tostring(E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower) end end, function(_, value) if E.Retail then E.db.ElvUI_EltreumUI.unitframes.models.custommodelpower = tonumber(value) else E.db.ElvUI_EltreumUI.unitframes.models.custommodelclassicpower = tostring(value) end ElvUI_EltreumUI:PlayerUFEffects() end, function() return E.db.ElvUI_EltreumUI.unitframes.models.modeltypepower == "DEFAULT" or (not E.db.ElvUI_EltreumUI.unitframes.UFmodifications or not E.db.ElvUI_EltreumUI.unitframes.models.powerbar) end, nil, function(_, value)
		E.PopupDialogs["ELTRUISMINVALIDMODELPOWER"] = {
			text = L["Invalid Model, you need to add a Model ID/Path"],
			button1 = OKAY,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = true,
		}
		if E.Retail then if tonumber(value) ~= nil then return true else return E:StaticPopup_Show('ELTRUISMINVALIDMODELPOWER') and false end else return true end end)

	--[[
	E.Libs.ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	E.Libs.ACH:Description(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)

	E.Libs.ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Execute(name, desc, order, func, image, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Select(name, desc, order, values, confirm, width, get, set, disabled, hidden)
	E.Libs.ACH:Input(name, desc, order, multiline, width, get, set, disabled, hidden, validate)
	E.Libs.ACH:Color(name, desc, order, alpha, width, get, set, disabled, hidden)
	E.Libs.ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)

	E.Libs.ACH:SharedMediaFont(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaSound(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaStatusbar(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaBackground(name, desc, order, width, get, set, disabled, hidden)
	E.Libs.ACH:SharedMediaBorder(name, desc, order, width, get, set, disabled, hidden)
	]]--

	E.Options.args.ElvUI_EltreumUI = ElvUI_EltreumUI.Options
end
