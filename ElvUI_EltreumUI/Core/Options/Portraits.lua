local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local pairs = _G.pairs

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




local form = {
	SQ = L["Old"] .. " " .. L["Drop"],
	RO = L["Old"] .. " " .. L["Drop round"],
	CI = L["Old"] .. " " .. L["Circle"],
	PI = L["Old"] .. " " .. L["Pad"],
	RA = L["Old"] .. " " .. L["Diamond"],
	QA = L["Old"] .. " " .. L["Square"],
	MO = L["Old"] .. " " .. L["Moon"],
	SQT = L["Old"] .. " " .. L["Drop flipped"],
	ROT = L["Old"] .. " " .. L["Drop round flipped"],
	TH = L["Old"] .. " " .. L["Thin"],
	circle = L["Circle"],
	thincircle = L["Thin Circle"],
	diamond = L["Diamond"],
	thindiamond = L["Thin Diamond"],
	drop = L["Drop round"],
	dropsharp = L["Drop"],
	dropflip = L["Drop round flipped"],
	dropsharpflip = L["Drop flipped"],
	octagon = L["Octagon"],
	pad = L["Pad"],
	pure = L["Pure round"],
	puresharp = L["Pure"],
	shield = L["Shield"],
	square = L["Square"],
	thin = L["Thin"],
}

local style = {
	a = "FLAT",
	b = "SMOOTH",
	c = "METALLIC",
}

local extraStyle = {
	a = L["Style"] .. " A",
	b = L["Style"] .. " B",
	c = L["Style"] .. " C",
	d = L["Style"] .. " D",
	e = L["Style"] .. " E",
}

local ClassIconStyle = {}

local frameStrata = {
	BACKGROUND = "BACKGROUND",
	LOW = "LOW",
	MEDIUM = "MEDIUM",
	HIGH = "HIGH",
	DIALOG = "DIALOG",
	TOOLTIP = "TOOLTIP",
	AUTO = "Auto",
}

local function BuildIconStylesTable()
	for iconStyle, value in pairs(ElvUI_EltreumUI.ClassIcons.mMT) do
		ClassIconStyle[iconStyle] = value.name
	end

	for iconStyle, value in pairs(ElvUI_EltreumUI.ClassIcons.Custom) do
		ClassIconStyle[iconStyle] = value.name
	end
end

local function BuildCustomTexturesTable()
	for textureStyle, value in pairs(ElvUI_EltreumUI.Media.CustomPortraits) do
		form[textureStyle] = value.name
	end
end

-- Eltruism portrait options, using code from mmediatag with authorization from Blinkii
function ElvUI_EltreumUI:PortraitOptions()
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits = E.Libs.ACH:Group(L["Portrait"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism = E.Libs.ACH:Group(E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1), nil, 4, "tab", nil, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general = E.Libs.ACH:Group(L["General"], nil, 1, "tab")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.description1 = E.Libs.ACH:Description(L["Target Portrait Fix"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.enableportraitfix = E.Libs.ACH:Toggle(L["Automatically rotate Target Portrait"], L["Detects target's species and uses it to fix the rotation of the Target's 3D Portrait"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraitfix end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitfix = value end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.offset = E.Libs.ACH:Toggle(L["Automatically offset Player/Target Portrait"], L["Detects player and target's species and uses it to fix the offset of the 3D Portrait"], 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraitfixoffset end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitfixoffset = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.portraitfix end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.enableportraitdead = E.Libs.ACH:Toggle(L["Pause and Desaturate Portrait if Dead"], nil, 4, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraitdead end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraitdead = value end, function() return not E.db.ElvUI_EltreumUI.unitframes.portraitfix end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.description2 = E.Libs.ACH:Description(L["Portrait Skin"], 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.enableportraitskin = E.Libs.ACH:Toggle(L["Enable Portrait Skin"], nil, 8, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.enable = value PortraitWasToggled("all", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.gradient = E.Libs.ACH:Toggle(L["Enable Gradient"], nil, 9, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.gradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.gradient = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.general.args.shadow = E.Libs.ACH:Toggle(L["Enable Shadows"], nil, 10, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.shadow end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.shadow = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player = E.Libs.ACH:Group(L["Player"], nil, 20, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") PortraitWasToggled("player", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 6, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 7, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.player.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.player.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.player.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.description1 = E.Libs.ACH:Description(" ", 8, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.player.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.player.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.player.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.player.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.player.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("player") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.player.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.player.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.player.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target = E.Libs.ACH:Group(L["Target"], nil, 21, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") PortraitWasToggled("target", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.target.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.target.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.target.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.target.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.target.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.target.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.target.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.target.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("target") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.target.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.target.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.target.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus = E.Libs.ACH:Group(L["Focus"], nil, 22, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end, E.Classic or E.ClassicHC)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") PortraitWasToggled("focus", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focus.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focus.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focus.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.focus.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focus.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focus.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focus.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focus") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focus.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focus.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget = E.Libs.ACH:Group(L["FocusTarget"], nil, 22, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end, E.Classic or E.ClassicHC)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") PortraitWasToggled("focustarget", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("focustarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.focustarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.focustarget.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget = E.Libs.ACH:Group(L["TargetTarget"], nil, 22, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") PortraitWasToggled("targettarget", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("targettarget") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.targettarget.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.targettarget.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party = E.Libs.ACH:Group(L["Party"], nil, 23, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") PortraitWasToggled("party", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.party.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.party.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.party.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.party.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.party.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.party.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.party.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.party.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("party") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.party.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.party.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.party.args.texture.style = "radio"
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet = E.Libs.ACH:Group(E.NewSign..L["Pet"], nil, 24, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") PortraitWasToggled("pet", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 6, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.pet.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 7, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.pet.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.pet.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.pet.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.pet.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("pet") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.pet.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss = E.Libs.ACH:Group(L["Boss"], nil, 23, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.enable = E.Libs.ACH:Toggle(L["Enable"], nil, 0, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") PortraitWasToggled("boss", value) end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.portraittype = E.Libs.ACH:Select(L["Type"], L["Choose Portrait Type"], 1, {
		["CIRCLE"] = L["Circle"],
		["BLIZZARD"] = L["Blizzard"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 8, max = 128, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.size end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.size = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.anchor = E.Libs.ACH:Select(L["Anchor Point"], L["What point to anchor to the frame you set to attach to."], 2, {
		LEFT = L["Left"],
		CENTER = L["Middle"],
		RIGHT = L["Right"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.align end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.align = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.xoffset = E.Libs.ACH:Range(L["X-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.x end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.x = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.yoffset = E.Libs.ACH:Range(L["Y-Offset"], nil, 2, { min = -300, max = 300, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.y end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.position.y = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.scale = E.Libs.ACH:Range(L["Scale"], nil, 2, { min = -0.15, max = 0.29, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.scale end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.scale = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.edge = E.Libs.ACH:Toggle(L["Edge"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.edge end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.edge = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type ~= "BLIZZARD" or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.rare = E.Libs.ACH:Toggle(L["Rare"], nil, 3, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.rare end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.rare = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.reversegradient = E.Libs.ACH:Toggle(L["Reverse Gradient"], nil, 3, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.reversegradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.reversegradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.defaultgradient = E.Libs.ACH:Toggle(L["Default Gradient Colors"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.defaultgradient end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.defaultgradient = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.enablecustomcolor = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 5, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.customcolor = E.Libs.ACH:Color(L["Custom Color"], nil, 6, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.boss.color.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.boss.color.g local db = P.ElvUI_EltreumUI.unitframes.portrait.boss.color.b return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.color.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcolor end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.description1 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.custom = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 9, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom = value if value == true and E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle then E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.customcircle = E.Libs.ACH:Toggle(L["RAID_TARGET_2"], nil, 10, nil, false, 'full', function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle = value if value == true then E.db.ElvUI_EltreumUI.unitframes.portrait.boss.type = "CIRCLE" end ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.custombg = E.Libs.ACH:Toggle(L["Background"], nil, 11, nil, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.background end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.background = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.custombgcolor = E.Libs.ACH:Color(L["Background Color"], nil, 12, false, nil, function() local dr = P.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.r local dg = P.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.g local db = P.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.b return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.r, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.g, E.db.ElvUI_EltreumUI.unitframes.portrait.boss.backgroundcolor.b = r, g, b ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.background or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.customcircle end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.texture = E.Libs.ACH:Select(L["Texture"], L["Choose the texture type"], 13, PortraitStyles, false, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.boss.style end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portrait.boss.style = value ElvUI_EltreumUI:BlizzPortraitSettingUpdate("boss") end, function() return not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.enable or not E.db.ElvUI_EltreumUI.unitframes.portrait.boss.custom end)
	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraiteltruism.args.boss.args.texture.style = "radio"

	local sizeString = ":16:16:0:0:64:64:4:60:4:60"

	BuildIconStylesTable()
	BuildCustomTexturesTable()

	ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraitmmt = E.Libs.ACH:Group("|CFF6559F1m|r|CFF7A4DEFM|r|CFF8845ECe|r|CFFA037E9d|r|CFFA435E8i|r|CFFB32DE6a|r|CFFBC26E5T|r|CFFCB1EE3a|r|CFFDD14E0g|r"..E.NewSign, nil, 4, "tab", nil, nil, function() return E.db.ElvUI_EltreumUI.unitframes.portrait.enable end)
	local Args = ElvUI_EltreumUI.Options.args.unitframes.args.portraits.args.portraitmmt.args

	Args.toggle_enable = E.Libs.ACH:Toggle(L["Enable Portrait Skin"], nil, 1, nil, false,'full', function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.enable end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.general.enable = value ElvUI_EltreumUI:InitializePortraits() E:StaticPopup_Show("CONFIG_RL") end)

	Args.header_general = E.Libs.ACH:Group(L["General"], nil, 2)
	local InnerGen = Args.header_general.args

	-- Class Icons
	InnerGen.class_icons = E.Libs.ACH:Group(L["Class Icons"], nil, 1)
	InnerGen.class_icons.inline = true
	InnerGen.class_icons.args.toggle_classicon = E.Libs.ACH:Toggle(L["Use Class Icons"], nil, 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.classicons end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.classicons = value
			E:StaticPopup_Show("CONFIG_RL")
		end
	)

	InnerGen.class_icons.args.select_classicon_style = E.Libs.ACH:Select(L["Class Icons Style"], nil, 2, ClassIconStyle, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.classiconstyle end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.classiconstyle = value
			ElvUI_EltreumUI:InitializePortraits()
			E:StaticPopup_Show("CONFIG_RL")
		end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.general.classicons end
	)

	-- Gradient
	InnerGen.gradient = E.Libs.ACH:Group(L["Gradient"], nil, 2)
	InnerGen.gradient.inline = true
	InnerGen.gradient.args.toggle_gradient = E.Libs.ACH:Toggle(L["Gradient"], nil, 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.gradient end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.gradient = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	InnerGen.gradient.args.select_gradient = E.Libs.ACH:Select(L["Gradient Orientation"], nil, 2, { HORIZONTAL = "HORIZONTAL", VERTICAL = "VERTICAL" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.ori end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.ori = value
			ElvUI_EltreumUI:InitializePortraits()
		end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.general.gradient end
	)

	InnerGen.gradient.args.spacer_texture1 = E.Libs.ACH:Description("\n\n", 3)

	InnerGen.gradient.args.toggle_gradien_eltr = E.Libs.ACH:Toggle(L["Use Eltruism colors"], nil, 4, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.eltruism end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.eltruism = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	-- Misc
	InnerGen.misc = E.Libs.ACH:Group(L["Misc"], nil, 3)
	InnerGen.misc.inline = true
	InnerGen.misc.args.trilinear = E.Libs.ACH:Toggle(L["Trilinear Filtering"], nil, 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.trilinear end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.trilinear = value
			ElvUI_EltreumUI:InitializePortraits()
			E:StaticPopup_Show("CONFIG_RL")
		end
	)

	InnerGen.misc.args.desaturation = E.Libs.ACH:Toggle(L["Dead desaturation"], nil, 2, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.desaturation end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.desaturation = value
			ElvUI_EltreumUI:InitializePortraits()
			E:StaticPopup_Show("CONFIG_RL")
		end
	)

	Args.header_style = E.Libs.ACH:Group(L["Textures & Styles"], nil, 2)
	local StyleArgs = Args.header_style.args

	-- Portrait Texture
	StyleArgs.header_portrait_texture = E.Libs.ACH:Group(L["Portrait Texture"], nil, 1)
	StyleArgs.header_portrait_texture.inline = true
	local PortraitTexArgs = StyleArgs.header_portrait_texture.args

	PortraitTexArgs.desc_note = E.Libs.ACH:Description(L["This works only with the mMT Textures for Portraits."], 1)

	PortraitTexArgs.select_style = E.Libs.ACH:Select(L["Texture Style"], nil, 2, style, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.style end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.style = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	PortraitTexArgs.toggle_corner = E.Libs.ACH:Toggle(L["Enable Corner"], nil, 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.corner end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.corner = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	-- Extra Texture Style
	StyleArgs.header_rare_texture = E.Libs.ACH:Group(L["Extra Texture Style"], nil, 2)
	StyleArgs.header_rare_texture.inline = true
	local ExtraArgs = StyleArgs.header_rare_texture.args

	ExtraArgs.desc_note = E.Libs.ACH:Description(L["Info! These styles are only available for the new textures."], 1)
	ExtraArgs.desc_note2 = E.Libs.ACH:Description(L["This works only with the mMT Textures for Portraits."], 2)
	ExtraArgs.desc_space = E.Libs.ACH:Description("\n\n", 3)

	ExtraArgs.select_style_rare = E.Libs.ACH:Select(L["Rare Texture Style"], nil, 4, extraStyle, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.extra.rare end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.extra.rare = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	ExtraArgs.select_style_elite = E.Libs.ACH:Select(L["Elite/ Rare Elite Texture Style"], nil, 5, extraStyle, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.extra.elite end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.extra.elite = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	ExtraArgs.select_style_boss = E.Libs.ACH:Select(L["Boss Texture Style"], nil, 6, extraStyle, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.extra.boss end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.extra.boss = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	ExtraArgs.toggle_color = E.Libs.ACH:Toggle(L["Use Texture Color"], nil, 7, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.usetexturecolor end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.usetexturecolor = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	-- Background Texture
	StyleArgs.header_bgtexture = E.Libs.ACH:Group(L["Background Texture"], nil, 4)
	StyleArgs.header_bgtexture.inline = true
	StyleArgs.header_bgtexture.args.select_texture = E.Libs.ACH:Select(L["Background Texture"], nil, 3, {
		[1] = L["Style"] .. " 1", [2] = L["Style"] .. " 2", [3] = L["Style"] .. " 3", [4] = L["Style"] .. " 4", [5] = L["Style"] .. " 5",
	}, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.bgstyle end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.general.bgstyle = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	-- Custom Portrait Textures
	StyleArgs.custom = E.Libs.ACH:Group(L["Custom Portrait Textures"], nil, 5)
	StyleArgs.custom.inline = true
	local CustomArgs = StyleArgs.custom.args

	CustomArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable Custom Textures"], nil, 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable = value
			ElvUI_EltreumUI:InitializePortraits()
		end
	)

	CustomArgs.spacer_texture1 = E.Libs.ACH:Description("\n\n", 2)
	CustomArgs.desc_important = E.Libs.ACH:Description(L["Info! To achieve an optimal result with the portraits, a texture should be set for the texture, border and mask.\nThe mask is always required and no portrait will be visible without it.\n\n"], 3)
	CustomArgs.desc_note1 = E.Libs.ACH:Description(L["If your texture or the cutout for the portrait is not symmetrical in the middle, you need a 2nd mask texture, which must be exactly mirror-inverted. Use the 2nd mask texture for this."], 4)

	-- Main Textures
	CustomArgs.main = E.Libs.ACH:Group(L["Main Textures"], nil, 5)
	CustomArgs.main.inline = true

	local nameFuncTexture = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.texture and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.texture ~= "") then
			return L["Texture"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.texture, sizeString)
		else
			return L["Texture"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.main.args.texture = E.Libs.ACH:Input(nameFuncTexture, L["This is the main texture for the portraits."], 1, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.texture = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncMask = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask ~= "") then
			return L["Mask"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask, sizeString)
		else
			return L["Mask"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.main.args.mask = E.Libs.ACH:Input(nameFuncMask, L["This is the Mask texture for the portraits. This texture is used to cut out the portrait of the Unit."], 2, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	CustomArgs.desc_note2 = E.Libs.ACH:Description(L["Optional textures, these textures are not mandatory, but improve the appearance of the portraits."], 6)
	CustomArgs.spacer_texture2 = E.Libs.ACH:Description("\n\n", 7)

	-- Optional Textures
	CustomArgs.optional = E.Libs.ACH:Group(L["Optional Textures"], nil, 8)
	CustomArgs.optional.inline = true

	local nameFuncBorder = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.border and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.border ~= "") then
			return L["Border"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.border, sizeString)
		else
			return L["Border"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.optional.args.border = E.Libs.ACH:Input(nameFuncBorder, L["This is the Border texture for the portraits."], 1, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.border end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.border = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncShadow = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.shadow and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.shadow ~= "") then
			return L["Shadow"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.shadow, sizeString)
		else
			return L["Shadow"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.optional.args.shadow = E.Libs.ACH:Input(nameFuncShadow, L["This is the shadow texture for the portraits."], 2, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.shadow end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.shadow = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncInner = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.inner and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.inner ~= "") then
			return L["Inner Shadow"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.inner, sizeString)
		else
			return L["Inner Shadow"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.optional.args.inner = E.Libs.ACH:Input(nameFuncInner, L["This is the inner shadow texture for the portraits."], 3, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.inner end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.inner = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	-- Rare Textures
	CustomArgs.rare = E.Libs.ACH:Group(L["Rare Textures"], nil, 9)
	CustomArgs.rare.inline = true

	local nameFuncRare = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extra and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extra ~= "") then
			return L["Rare"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extra, sizeString)
		else
			return L["Rare"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.rare.args.rare = E.Libs.ACH:Input(nameFuncRare, L["This is the Rare texture for the portraits."], 1, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extra end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extra = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncRareBorder = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extraborder and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extraborder ~= "") then
			return L["Rare - Border"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extraborder, sizeString)
		else
			return L["Rare - Border"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.rare.args.rare_border = E.Libs.ACH:Input(nameFuncRareBorder, L["This is the Border texture for the Rare texture."], 2, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extraborder end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extraborder = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncRareShadow = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extrashadow and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extrashadow ~= "") then
			return L["Rare - Shadow"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extrashadow, sizeString)
		else
			return L["Rare - Shadow"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.rare.args.rare_shadow = E.Libs.ACH:Input(nameFuncRareShadow, L["This is the shadow texture for the Rare texture."], 3, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extrashadow end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.extrashadow = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	-- Elite Textures
	CustomArgs.elite = E.Libs.ACH:Group(L["Elite Textures"], nil, 10)
	CustomArgs.elite.inline = true

	local nameFuncElite = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.elite and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.elite ~= "") then
			return L["Elite"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.elite, sizeString)
		else
			return L["Elite"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.elite.args.elite = E.Libs.ACH:Input(nameFuncElite, L["This is the Elite texture for the portraits."], 1, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.elite end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.elite = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncEliteBorder = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteborder and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteborder ~= "") then
			return L["Elite - Border"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteborder, sizeString)
		else
			return L["Elite - Border"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.elite.args.elite_border = E.Libs.ACH:Input(nameFuncEliteBorder, L["This is the Border texture for the Elite texture."], 2, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteborder end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteborder = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncEliteShadow = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteshadow and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteshadow ~= "") then
			return L["Elite - Shadow"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteshadow, sizeString)
		else
			return L["Elite - Shadow"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.elite.args.elite_shadow = E.Libs.ACH:Input(nameFuncEliteShadow, L["This is the shadow texture for the Elite texture."], 3, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteshadow end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.eliteshadow = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	-- Boss Textures
	CustomArgs.boss = E.Libs.ACH:Group(L["Boss Textures"], nil, 12)
	CustomArgs.boss.inline = true

	local nameFuncBoss = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.boss and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.boss ~= "") then
			return L["Boss"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.boss, sizeString)
		else
			return L["Boss"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.boss.args.rare = E.Libs.ACH:Input(nameFuncBoss, L["This is the Boss texture for the portraits."], 1, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.boss end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.boss = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncBossBorder = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossborder and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossborder ~= "") then
			return L["Boss - Border"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossborder, sizeString)
		else
			return L["Boss - Border"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.boss.args.boss_border = E.Libs.ACH:Input(nameFuncBossBorder, L["This is the Border texture for the Boss texture."], 2, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossborder end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossborder = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	local nameFuncBossShadow = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossshadow and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossshadow ~= "") then
			return L["Boss - Shadow"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossshadow, sizeString)
		else
			return L["Boss - Shadow"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.boss.args.boss_shadow = E.Libs.ACH:Input(nameFuncBossShadow, L["This is the shadow texture for the Boss texture."], 3, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossshadow end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.bossshadow = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	-- Mask B
	CustomArgs.mask_b = E.Libs.ACH:Group(L["Second Mask Texture"], nil, 13)
	CustomArgs.mask_b.inline = true

	local nameFuncMaskB = function()
		if E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb ~= "") then
			return L["Mirrored Mask"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb, sizeString)
		elseif E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask and (E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask ~= "") then
			return L["Mirrored Mask"] .. "  > " .. E:TextureString(E.db.ElvUI_EltreumUI.unitframes.portraits.custom.mask, sizeString)
		else
			return L["Mirrored Mask"] .. "  > " .. L["No Texture found"]
		end
	end
	CustomArgs.mask_b.args.maskb = E.Libs.ACH:Input(nameFuncMaskB, L["This is the mirrored Mask texture for the portraits. This texture is used to cut out the portrait of the Unit."], 1, nil, "smal",
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.custom.maskb = value; E:StaticPopup_Show("CONFIG_RL") end,
		function() return not E.db.ElvUI_EltreumUI.unitframes.portraits.custom.enable end
	)

	-- Portrait Offset / Zoom
	Args.header_offset = E.Libs.ACH:Group(L["Portrait Offset/ Zoom"], nil, 3)
	Args.header_offset.args.zoom = E.Libs.ACH:Range(L["Zoom"], nil, 1, { min = 0, max = 5, step = 0.001 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.zoom end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.zoom = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_player = E.Libs.ACH:Group(L["Player"], nil, 3)
	local PlayerArgs = Args.header_player.args

	PlayerArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Player Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PlayerArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	PlayerArgs.general.inline = true
	PlayerArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PlayerArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PlayerArgs.general.args.toggle_cast = E.Libs.ACH:Toggle(L["Cast Icon"], L["Enable Cast Icons"], 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.cast end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.cast = value; ElvUI_EltreumUI:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
	)

	PlayerArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	PlayerArgs.anchor.inline = true
	PlayerArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.player.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.player.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.player.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.player.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.player.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.player.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.player.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	PlayerArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PlayerArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PlayerArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	PlayerArgs.level.inline = true
	PlayerArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PlayerArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.player.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_target = E.Libs.ACH:Group(L["Target"], nil, 4)
	local TargetArgs = Args.header_target.args

	TargetArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Target Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	TargetArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	TargetArgs.general.inline = true
	TargetArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	TargetArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	TargetArgs.general.args.toggle_extra = E.Libs.ACH:Toggle(L["Enable Rare/Elite Border"], nil, 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.extraEnable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.extraEnable = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	TargetArgs.general.args.toggle_cast = E.Libs.ACH:Toggle(L["Cast Icon"], L["Enable Cast Icons"], 4, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.cast end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.cast = value; ElvUI_EltreumUI:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
	)

	TargetArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	TargetArgs.anchor.inline = true
	TargetArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.target.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.target.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.target.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.target.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.target.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.target.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.target.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	TargetArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	TargetArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	TargetArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	TargetArgs.level.inline = true
	TargetArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 9, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	TargetArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 10, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.target.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_targettarget = E.Libs.ACH:Group(L["Target of Target"], nil, 5)
	local ToTArgs = Args.header_targettarget.args

	ToTArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Target of Target Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	ToTArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	ToTArgs.general.inline = true
	ToTArgs.general.args.toggle_extra = E.Libs.ACH:Toggle(L["Enable Rare/Elite Border"], nil, 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.extraEnable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.extraEnable = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ToTArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 2, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ToTArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 3, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	ToTArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	ToTArgs.anchor.inline = true
	ToTArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	ToTArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ToTArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	ToTArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	ToTArgs.level.inline = true
	ToTArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ToTArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.targettarget.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_pet = E.Libs.ACH:Group(L["Pet"], nil, 6)
	local PetArgs = Args.header_pet.args

	PetArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Pet Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PetArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	PetArgs.general.inline = true
	PetArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PetArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PetArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	PetArgs.anchor.inline = true
	PetArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.pet.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.pet.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.pet.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.pet.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.pet.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.pet.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.pet.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	PetArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PetArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PetArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	PetArgs.level.inline = true
	PetArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PetArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.pet.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.pet.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_focus = E.Libs.ACH:Group(L["Focus"], nil, 7)
	local FocusArgs = Args.header_focus.args

	FocusArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Focus Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	FocusArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	FocusArgs.general.inline = true
	FocusArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	FocusArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	FocusArgs.general.args.toggle_extra = E.Libs.ACH:Toggle(L["Enable Rare/Elite Border"], nil, 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.extraEnable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.extraEnable = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	FocusArgs.general.args.toggle_cast = E.Libs.ACH:Toggle(L["Cast Icon"], L["Enable Cast Icons"], 4, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.cast end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.cast = value; ElvUI_EltreumUI:InitializePortraits(true) end
	)

	FocusArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	FocusArgs.anchor.inline = true
	FocusArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.focus.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.focus.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.focus.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.focus.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.focus.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.focus.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.focus.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	FocusArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	FocusArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	FocusArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	FocusArgs.level.inline = true
	FocusArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	FocusArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.focus.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_party = E.Libs.ACH:Group(L["Party"], nil, 8)
	local PartyArgs = Args.header_party.args

	PartyArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Party Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PartyArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	PartyArgs.general.inline = true
	PartyArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PartyArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PartyArgs.general.args.toggle_cast = E.Libs.ACH:Toggle(L["Cast Icon"], L["Enable Cast Icons"], 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.cast end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.cast = value; ElvUI_EltreumUI:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
	)

	PartyArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	PartyArgs.anchor.inline = true
	PartyArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.party.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.party.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.party.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.party.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.party.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.party.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.party.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	PartyArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PartyArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	PartyArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	PartyArgs.level.inline = true
	PartyArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	PartyArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.party.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_boss = E.Libs.ACH:Group(L["Boss"], nil, 9)
	local BossArgs = Args.header_boss.args

	BossArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Boss Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	BossArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	BossArgs.general.inline = true
	BossArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	BossArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	BossArgs.general.args.toggle_cast = E.Libs.ACH:Toggle(L["Cast Icon"], L["Enable Cast Icons"], 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.cast end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.cast = value; ElvUI_EltreumUI:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
	)

	BossArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	BossArgs.anchor.inline = true
	BossArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.boss.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.boss.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.boss.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.boss.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.boss.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.boss.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.boss.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	BossArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	BossArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	BossArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	BossArgs.level.inline = true
	BossArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	BossArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.boss.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_arena = E.Libs.ACH:Group(L["Arena"], nil, 10)
	local ArenaArgs = Args.header_arena.args

	ArenaArgs.toggle_enable = E.Libs.ACH:Toggle(L["Enable"], L["Enable Arena Portraits"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	ArenaArgs.general = E.Libs.ACH:Group(L["General"], nil, 2)
	ArenaArgs.general.inline = true
	ArenaArgs.general.args.select_style = E.Libs.ACH:Select(L["Texture Form"], nil, 1, form, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.texture end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.texture = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ArenaArgs.general.args.range_size = E.Libs.ACH:Range(L["Size"], nil, 2, { min = 16, max = 512, step = 1, softMin = 16, softMax = 512 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.size end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.size = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ArenaArgs.general.args.toggle_cast = E.Libs.ACH:Toggle(L["Cast Icon"], L["Enable Cast Icons"], 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.cast end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.cast = value; ElvUI_EltreumUI:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
	)

	ArenaArgs.anchor = E.Libs.ACH:Group(L["Anchor"], nil, 3)
	ArenaArgs.anchor.inline = true
	ArenaArgs.anchor.args.select_anchor = E.Libs.ACH:Select(L["Anchor Point"], nil, 1, { LEFT = "LEFT", RIGHT = "RIGHT", CENTER = "CENTER" }, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.relativePoint end,
		function(_, value)
			E.db.ElvUI_EltreumUI.unitframes.portraits.arena.relativePoint = value
			if value == "LEFT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.arena.point = "RIGHT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.arena.mirror = false
			elseif value == "RIGHT" then
				E.db.ElvUI_EltreumUI.unitframes.portraits.arena.point = "LEFT"
				E.db.ElvUI_EltreumUI.unitframes.portraits.arena.mirror = true
			else
				E.db.ElvUI_EltreumUI.unitframes.portraits.arena.point = value
				E.db.ElvUI_EltreumUI.unitframes.portraits.arena.mirror = false
			end
			ElvUI_EltreumUI:InitializePortraits()
		end
	)
	ArenaArgs.anchor.args.range_ofsX = E.Libs.ACH:Range(L["X offset"], nil, 2, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.x end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.x = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ArenaArgs.anchor.args.range_ofsY = E.Libs.ACH:Range(L["Y offset"], nil, 3, { min = -256, max = 256, step = 1, softMin = -256, softMax = 256 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.y end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.y = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	ArenaArgs.level = E.Libs.ACH:Group(L["Frame Level"], nil, 4)
	ArenaArgs.level.inline = true
	ArenaArgs.level.args.select_strata = E.Libs.ACH:Select(L["Frame Strata"], nil, 1, frameStrata, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.strata end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.strata = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ArenaArgs.level.args.range_level = E.Libs.ACH:Range(L["Frame Level"], nil, 2, { min = 0, max = 1000, step = 1, softMin = 0, softMax = 1000 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.arena.level end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.level = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_shadow = E.Libs.ACH:Group(L["Shadow"], nil, 11)
	local ShadowArgs = Args.header_shadow.args

	ShadowArgs.shadow = E.Libs.ACH:Group(L["Shadow"], nil, 0)
	ShadowArgs.shadow.inline = true
	ShadowArgs.shadow.args.toggle_shadow = E.Libs.ACH:Toggle(L["Shadow"], L["Enable Shadow"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.enable = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ShadowArgs.shadow.args.color_shadow = E.Libs.ACH:Color(L["Shadow Color"], nil, 2, true, nil,
		function() local t = E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.color; return t.r, t.g, t.b, t.a end,
		function(_, r, g, b, a) local t = E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.color; t.r, t.g, t.b, t.a = r, g, b, a; ElvUI_EltreumUI:InitializePortraits() end
	)

	ShadowArgs.innershadow = E.Libs.ACH:Group(L["Inner Shadow"], nil, 3)
	ShadowArgs.innershadow.inline = true
	ShadowArgs.innershadow.args.toggle_inner = E.Libs.ACH:Toggle(L["Inner Shadow"], L["Enable Inner Shadow"], 4, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.inner end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.inner = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ShadowArgs.innershadow.args.color_inner = E.Libs.ACH:Color(L["Inner Shadow Color"], nil, 5, true, nil,
		function() local t = E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.innerColor; return t.r, t.g, t.b, t.a end,
		function(_, r, g, b, a) local t = E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.innerColor; t.r, t.g, t.b, t.a = r, g, b, a; ElvUI_EltreumUI:InitializePortraits() end
	)

	Args.header_colors = E.Libs.ACH:Group(L["Colors"], nil, 12)
	local ColorsArgs = Args.header_colors.args

	-- Settings
	ColorsArgs.settings = E.Libs.ACH:Group(L["Settings"], nil, 1)
	ColorsArgs.settings.inline = true
	ColorsArgs.settings.args.execute_apply = E.Libs.ACH:Execute(L["Apply"], nil, 1, function() ElvUI_EltreumUI:InitializePortraits() end)

	ColorsArgs.settings.args.toggle_default = E.Libs.ACH:Toggle(L["Use only Default Color"], L["Uses the Default Color for every Unit."], 2, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.default end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.general.default = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	ColorsArgs.settings.args.toggle_reaction = E.Libs.ACH:Toggle(L["Force reaction color"], L["Forces reaction color for all Units."], 3, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.reaction end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.general.reaction = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	-- General Colors
	ColorsArgs.general_colors = E.Libs.ACH:Group(L["General"], nil, 2)
	local GeneralColors = ColorsArgs.general_colors.args

	-- Helper function to generate color pairs (A and B)
	local function CreateColorPair(groupName, order, dbTable)
		local group = E.Libs.ACH:Group(L[groupName] or groupName, nil, order)
		group.inline = true
		group.args.color_a = E.Libs.ACH:Color("A", nil, 1, true, nil,
			function() local t = dbTable.a; return t.r, t.g, t.b, t.a end,
			function(_, r, g, b, a) local t = dbTable.a; t.r, t.g, t.b, t.a = r, g, b, a end
		)
		group.args.color_b = E.Libs.ACH:Color("B", nil, 2, true, nil,
			function() local t = dbTable.b; return t.r, t.g, t.b, t.a end,
			function(_, r, g, b, a) local t = dbTable.b; t.r, t.g, t.b, t.a = r, g, b, a end
		)
		return group
	end

	GeneralColors.default = CreateColorPair(L["Default"], 1, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.default)

	-- Class Colors
	ColorsArgs.class_colors = E.Libs.ACH:Group(L["Class"], nil, 3)
	local ClassColors = ColorsArgs.class_colors.args

	ClassColors.DEATHKNIGHT = CreateColorPair("DEATHKNIGHT", 3, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.DEATHKNIGHT)
	ClassColors.DEMONHUNTER = CreateColorPair("DEMONHUNTER", 4, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.DEMONHUNTER)
	ClassColors.DRUID = CreateColorPair("DRUID", 5, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.DRUID)
	ClassColors.EVOKER = CreateColorPair("EVOKER", 6, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.EVOKER)
	ClassColors.HUNTER = CreateColorPair("HUNTER", 7, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.HUNTER)
	ClassColors.MAGE = CreateColorPair("MAGE", 8, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.MAGE)
	ClassColors.MONK = CreateColorPair("MONK", 9, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.MONK)
	ClassColors.PALADIN = CreateColorPair("PALADIN", 10, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.PALADIN)
	ClassColors.PRIEST = CreateColorPair("PRIEST", 11, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.PRIEST)
	ClassColors.ROGUE = CreateColorPair("ROGUE", 12, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.ROGUE)
	ClassColors.SHAMAN = CreateColorPair("SHAMAN", 13, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.SHAMAN)
	ClassColors.WARLOCK = CreateColorPair("WARLOCK", 14, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.WARLOCK)
	ClassColors.WARRIOR = CreateColorPair("WARRIOR", 15, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.WARRIOR)

	-- Classification Colors
	ColorsArgs.clasification_colors = E.Libs.ACH:Group(L["Classification"], nil, 4)
	local ClassifColors = ColorsArgs.clasification_colors.args

	ClassifColors.rare = CreateColorPair("RARE", 17, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.rare)
	ClassifColors.rareelite = CreateColorPair("RARE ELITE", 18, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.rareelite)
	ClassifColors.elite = CreateColorPair("ELITE", 19, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.elite)
	ClassifColors.boss = CreateColorPair("Boss", 20, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.boss)

	-- Reaction Colors
	ColorsArgs.reaction_colors = E.Libs.ACH:Group(L["Reaction"], nil, 5)
	local ReactionColors = ColorsArgs.reaction_colors.args

	ReactionColors.enemy = CreateColorPair("ENEMY", 21, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.enemy)
	ReactionColors.neutral = CreateColorPair("NEUTRAL", 22, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.neutral)
	ReactionColors.friendly = CreateColorPair("FRIENDLY", 23, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.friendly)

	-- Death Colors
	ColorsArgs.death_colors = E.Libs.ACH:Group(L["Death"], nil, 6)
	local DeathColors = ColorsArgs.death_colors.args

	DeathColors.toggle_death = E.Libs.ACH:Toggle(L["Enable"], L["Enable Death color"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.general.deathcolor end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.general.deathcolor = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	DeathColors.dead_color = CreateColorPair("Death", 2, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.death)

	-- Border Colors
	ColorsArgs.border_colors = E.Libs.ACH:Group(L["Border"], nil, 7)
	local BorderColors = ColorsArgs.border_colors.args

	BorderColors.toggle_border = E.Libs.ACH:Toggle(L["Border"], L["Enable Borders"], 1, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.border = value; ElvUI_EltreumUI:InitializePortraits() end
	)

	BorderColors.default_color = E.Libs.ACH:Group(L["Default"], nil, 2)
	BorderColors.default_color.inline = true
	BorderColors.default_color.args.color_default = E.Libs.ACH:Color(L["Default"], nil, 2, true, nil,
		function() local t = E.db.ElvUI_EltreumUI.unitframes.portraits.colors.border.default; return t.r, t.g, t.b, t.a end,
		function(_, r, g, b, a) local t = E.db.ElvUI_EltreumUI.unitframes.portraits.colors.border.default; t.r, t.g, t.b, t.a = r, g, b, a end
	)

	BorderColors.classification_color = E.Libs.ACH:Group(L["Classification"], nil, 3)
	BorderColors.classification_color.inline = true
	local ClassifBorderColors = BorderColors.classification_color.args

	local function CreateBorderColor(name, order, dbTable)
		return E.Libs.ACH:Color(name, nil, order, true, nil,
			function() local t = dbTable; return t.r, t.g, t.b, t.a end,
			function(_, r, g, b, a) local t = dbTable; t.r, t.g, t.b, t.a = r, g, b, a end
		)
	end

	ClassifBorderColors.color_rare = CreateBorderColor(L["Rare"], 1, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.border.rare)
	ClassifBorderColors.color_elite = CreateBorderColor(L["Elite"], 2, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.border.elite)
	ClassifBorderColors.color_rareelite = CreateBorderColor(L["Rare Elite"], 3, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.border.rareelite)
	ClassifBorderColors.color_boss = CreateBorderColor(L["Boss"], 4, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.border.boss)

	-- Background Colors
	ColorsArgs.background_colors = E.Libs.ACH:Group(L["Background"], nil, 8)
	local BgColors = ColorsArgs.background_colors.args

	BgColors.color_background = E.Libs.ACH:Color(L["Background color for Icons"], nil, 11, true, nil,
		function() local t = E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.background; return t.r, t.g, t.b, t.a end,
		function(_, r, g, b, a) local t = E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.background; t.r, t.g, t.b, t.a = r, g, b, a; ElvUI_EltreumUI:InitializePortraits() end
	)
	BgColors.toggle_classbg = E.Libs.ACH:Toggle(L["Class colored Background"], L["Enable Class colored Background"], 12, nil, nil, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.classBG end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.classBG = value; ElvUI_EltreumUI:InitializePortraits() end
	)
	BgColors.range_bgColorShift = E.Libs.ACH:Range(L["Background color shift"], nil, 14, { min = 0, max = 1, step = 0.01, softMin = 0, softMax = 1 }, nil,
		function() return E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.bgColorShift end,
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.shadow.bgColorShift = value; ElvUI_EltreumUI:InitializePortraits() end
	)
end
