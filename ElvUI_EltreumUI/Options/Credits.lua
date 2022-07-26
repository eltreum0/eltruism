local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local tinsert = _G.table.insert
local tconcat = _G.table.concat
local unpack = _G.unpack
local select = _G.select
local sort = _G.sort
local pairs = _G.pairs
local table = _G.table
local format = _G.format
local MINIMAP_LABEL = _G.MINIMAP_LABEL
local AURAS = _G.AURAS
local BINDING_HEADER_CHAT = _G.BINDING_HEADER_CHAT
local HONOR = _G.HONOR
local CURRENCY = _G.CURRENCY
local tostring = _G.tostring
local PlaySoundFile = _G.PlaySoundFile
local tonumber = _G.tonumber
local SetCVar = _G.SetCVar
local C_CVar = _G.C_CVar
local OKAY = _G.OKAY
local Item = _G.Item
local tremove = _G.tremove

--Author list
local AUTHORS = {
	'|cff82B4ffEltreum|r',
}

-- Credits and Thank yous list
local THANKYOU = {
	'|cff0070DEAzilroka|r',
	'|cffC41F3BKringel|r',
	'|cFF99CCFFAftermathh|r',
	'|cffF58CBARepooc|r Especially for the huge helps',
	'Blazeflack',
	'Botanica',
	'|cffFFC44DHydra|r',
	'|T134297:15:15:0:0:64:64:5:59:5:59|t |cffff7d0aMerathilis|r',
	'|cff9482c9Darth Predator|r',
	'Caedis',
	'Elv',
	E:TextGradient('Simpy but his name might be shorter sometimes even though he fixes a lot of things', 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43),
	'Shrom',
	'Pat',
	'|cff00c0faBenik|r',
	'|T136012:15:15:0:0:64:64:5:59:5:59|t |cff006fdcRubgrsch|r',
	'|cff8788EENihilistzsche|r',
	'|TInterface/AddOns/ElvUI/Core/Media/ChatLogos/Clover:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0ALuckyone|r Especially for allowing the usage of his installer/plugin as a model',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/releaf:15:15:0:0:64:64:5:59:5:59|t |cffFF7D0AReleaf|r for the alternate class icons',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/tukuidiscord:15:15:0:0:64:64:5:59:5:59|t Tukui Community for all the help and motivation',
	'|TInterface/AddOns/ElvUI_EltreumUI/Media/Textures/addonsdiscord:15:15:0:0:64:64:5:59:5:59|t WoW AddOns; for answering a lot of questions',
	'AcidWeb |TInterface/AddOns/ElvUI/Core/Media/ChatLogos/Gem:15:15:-1:2:64:64:6:60:8:60|t',
	'|cff8E44ADB|r|cff2ECC71lin|r|cff3498DBkii|r',
}

local SUPPORTER = {
	'|cffB50909Artan|r',
	'|cffB50909Brovenn|r',
	'|cffB50909Dreandor|r',
	'|cffB50909Morthart|r',
	'|cffB50909Nekator|r',
}

local TRANSLATORS = {
	'|cffCC3333Khornan|r - German Translation',
	'|cffCC3333Dlarge|r - German Translation',
	'|cffCC3333Neo|r - Chinese Translation',
	'Spanish translation by DeepL',
}

-- SortList
local function SortList(a, b)
	return E:StripString(a) < E:StripString(b)
end

sort(AUTHORS, SortList)
sort(THANKYOU, SortList)
sort(SUPPORTER, SortList)
sort(TRANSLATORS, SortList)

-- Author table
for _, name in pairs(AUTHORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local AUTHORS_STRING = tconcat(AUTHORS, '|n')

-- Thank you table
for _, name in pairs(THANKYOU) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local THANKYOU_STRING = tconcat(THANKYOU, '|n')

-- Supporter table
for _, name in pairs(SUPPORTER) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local SUPPORTER_STRING = tconcat(SUPPORTER, '|n')

-- Translators table
for _, name in pairs(TRANSLATORS) do
	tinsert(ElvUI_EltreumUI.CreditsList, name)
end
local TRANSLATORS_STRING = tconcat(TRANSLATORS, '|n')


function ElvUI_EltreumUI:CreditsOptions()
	local credits = {
		type = 'group',
		name = L["Credits"],
		icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\credits',
		order = 97,
		args = {
			author = {
				order = 1,
				type = 'group',
				inline = true,
				name = L["Author"],
				args = {
					desc = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = AUTHORS_STRING,
					},
				},
			},
			thankyou = {
				order = 2,
				type = 'group',
				inline = true,
				name = L["Credits and Thank yous"],
				args = {
					desc = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = THANKYOU_STRING,
					},
				},
			},
			supporters = {
				order = 3,
				type = 'group',
				inline = true,
				name = "Supporters",
				args = {
					desc = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = SUPPORTER_STRING,
					},
				},
			},
			translators = {
				order = 4,
				type = 'group',
				inline = true,
				name = "Translators",
				args = {
					desc = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = TRANSLATORS_STRING,
					},
				},
			},
			licensewarning = {
				order = 99,
				type = 'group',
				inline = true,
				name = L["License"],
				args = {
					desc = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = 'Cursor is a fork of CastCursor by michaelsp which licensed under GNU GPLv3\nCursor Cooldowns is a fork of CooldownToGo by mitchnull which is licensed under Public Domain\nExpand Hunter Stables is merged from Improved Stable Frame by Cybeloras which is licensed under GNU GPLv3\nIcons8 (www.icons8.com) for some of the icons. List in license.txt\nLootText is a fork of SLoTe from xavjer which is licensed under GNU GPLv3\nRogue Door Opener is a fork of Rogue Door Opener by Burzolog which licensed under GNU GPLv3\nLoot Icons are merged from Chat Loot Icons by Stanzilla which is licensed under Public Domain\nThe Item Level shown on the Character Panel Skin uses code from Simple Item level by Kemayo, licensed under BSD\nQuest Items is a merge of QBar by Aezay, which is licensed under GNU GPLv3\nSockets and Enchants is a fork of Kibs Item Levels by Kibsgaard which is licensed under Public Domain',
					},
				},
			},
		},
	}
	return credits
end
