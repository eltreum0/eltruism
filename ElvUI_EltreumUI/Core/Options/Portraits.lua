local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local pairs = _G.pairs

--this file is a conversion of mmediatag portraits options, as authorized by blinkii

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
	local sizeString = ":16:16:0:0:64:64:4:60:4:60"

	BuildIconStylesTable()
	BuildCustomTexturesTable()

	ElvUI_EltreumUI.Options.args.unitframes.args.portrait = E.Libs.ACH:Group(L["Portrait"], nil, 4, "tab", nil, nil, function() return not E.db.ElvUI_EltreumUI.unitframes.UFmodifications end)
	local Args = ElvUI_EltreumUI.Options.args.unitframes.args.portrait.args

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
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.player.cast = value; ElvUI_EltreumUI.Portraits:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
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
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.target.cast = value; ElvUI_EltreumUI.Portraits:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
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
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.focus.cast = value; ElvUI_EltreumUI.Portraits:InitializePortraits(true) end
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
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.party.cast = value; ElvUI_EltreumUI.Portraits:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
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
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.boss.cast = value; ElvUI_EltreumUI.Portraits:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
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
		function(_, value) E.db.ElvUI_EltreumUI.unitframes.portraits.arena.cast = value; ElvUI_EltreumUI.Portraits:InitializePortraits(true); E:StaticPopup_Show("CONFIG_RL") end
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

	ColorsArgs.settings.args.toggle_default = E.Libs.ACH:Toggle(L["Use only Default Color"], L["Uses for every Unit the Default Color."], 2, nil, nil, nil,
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

	GeneralColors.default = CreateColorPair("Deafault", 1, E.db.ElvUI_EltreumUI.unitframes.portraits.colors.default)

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
	ColorsArgs.clasification_colors = E.Libs.ACH:Group(L["Clasification"], nil, 4)
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
