local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local CH = E:GetModule("Chat")
local hooksecurefunc = _G.hooksecurefunc
local format = _G.string.format

--Add Icons to chat messages
function ElvUI_EltreumUI:AuthorMVPDonatorIcons()
	if E.db.ElvUI_EltreumUI.chat.AuthorMVPDonatorIcons then

		--Eltreum
		--|Tpath:height[:width[:offsetX:offsetY:[textureWidth:textureHeight:leftTexel:rightTexel:topTexel:bottomTexel[:rVertexColor:gVertexColor:bVertexColor]]]]|t
		local EltreumIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga:0:0:0:0:64:64:0:64:0:64:69:128:179|t"
		local EltreumCharacters = {

			--Retail Alliance
			["Missiles-Stormrage"] = EltreumIcon,
			["Eltreum-Stormrage"] = EltreumIcon,
			["Effecta-Stormrage"] = EltreumIcon,
			["Deci-Stormrage"] = EltreumIcon,
			["Kuriatas-Stormrage"] = EltreumIcon,
			["Tyriendal-Stormrage"] = EltreumIcon,
			["Lastwill-Stormrage"] = EltreumIcon,
			["Auramaster-Stormrage"] = EltreumIcon,
			["Futuria-Stormrage"] = EltreumIcon,
			["Repairs-Stormrage"] = EltreumIcon,
			["Brihtnes-Stormrage"] = EltreumIcon,
			["Insidium-Stormrage"] = EltreumIcon,
			["Chromatus-Stormrage"] = EltreumIcon,

			--Retail Horde
			["Antarcticus-Area 52"] = EltreumIcon,
			["Eltreum-Area 52"] = EltreumIcon,

			--Wrath
			["Antarcticus-Faerlina"] = EltreumIcon,
			["Atrophos-Faerlina"] = EltreumIcon,
			["Kuriatas-Faerlina"] = EltreumIcon,
			["Tartharus-Faerlina"] = EltreumIcon,
			["Futuria-Faerlina"] = EltreumIcon,
			["Repairs-Faerlina"] = EltreumIcon,
			["Durtram-Faerlina"] = EltreumIcon,
			["Auramaster-Faerlina"] = EltreumIcon,
			["Eltreum-Faerlina"] = EltreumIcon,
			["Effecta-Faerlina"] = EltreumIcon,
			["Brihtnes-Faerlina"] = EltreumIcon,
		}

		--Donators
		local DonatorsIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga:0:0:0:0:64:64:0:64:0:64:181:9:9|t"
		local DonatorsCharacters = {
			--jiberish
			["Jiberish-Illidan"] = DonatorsIcon,
			["Jiberishaman-Illidan"] = DonatorsIcon,
			["Jiberishift-Illidan"] = DonatorsIcon,
			["Jiberishadow-Illidan"] = DonatorsIcon,
			["Jiberisheep-Illidan"] = DonatorsIcon,

			--trenchy
			["Grunchy-Thrall"] = DonatorsIcon,
			["Trenchey-Thrall"] = DonatorsIcon,
			["Trenchay-Thrall"] = DonatorsIcon,
			["Trenchy-Thrall"] = DonatorsIcon,
			["Trenchee-Thrall"] = DonatorsIcon,
			["Trenchae-Thrall"] = DonatorsIcon,
			["Trenchai-Thrall"] = DonatorsIcon,
		}

		--Discord MVPs
		local MVPIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga:0:0:0:0:64:64:0:64:0:64:255:115:0|t"
		local MVPCharacters = {
			--["Kuriatas-Stormrage"] = MVPIcon, --test
			["Evowøød-Blackhand"] = MVPIcon,
			["Evowøød-Antonidas"] = MVPIcon,

			["Lockwøød-Blackhand"] = MVPIcon,
			["Drwøød-Blackhand"] = MVPIcon,
			["Shawøød-Blackhand"] = MVPIcon,
			["Rowøød-Blackhand"] = MVPIcon,
			["Prwøød-Blackhand"] = MVPIcon,
			["Mawøød-Blackhand"] = MVPIcon,
			["Huwøød-Blackhand"] = MVPIcon,
			["Mokwøød-Blackhand"] = MVPIcon,
			["Dawøød-Blackhand"] = MVPIcon,
			["Palwøød-Blackhand"] = MVPIcon,
			["Warwøød-Blackhand"] = MVPIcon,
			["Dewøød-Blackhand"] = MVPIcon,
			["Farmwøød-Blackhand"] = MVPIcon,

			["Lockwøød-Antonidas"] = MVPIcon,
			["Rowøød-Antonidas"] = MVPIcon,
			["Warwøød-Antonidas"] = MVPIcon,
			["Drwøød-Antonidas"] = MVPIcon,
			["Mokwøød-Antonidas"] = MVPIcon,
			["Palwøød-Antonidas"] = MVPIcon,
			["Prwøød-Antonidas"] = MVPIcon,
			["Mawøød-Antonidas"] = MVPIcon,
			["Dawøød-Antonidas"] = MVPIcon,
			["Huwøød-Antonidas"] = MVPIcon,
			["Shawøød-Antonidas"] = MVPIcon,
			["Dewøød-Antonidas"] = MVPIcon,
			["Farmwøød-Antonidas"] = MVPIcon,
		}

		CH:AddPluginIcons(function(unit)
			if EltreumCharacters[unit] then
				return EltreumCharacters[unit]
			elseif DonatorsCharacters[unit] then
				return DonatorsCharacters[unit]
			elseif MVPCharacters[unit] then
				return MVPCharacters[unit]
			end
		end)
	end
end

--Add class icons next to player names in chat
function ElvUI_EltreumUI:ChatClassIcons(event, _, arg2, _, _, _, _, _, arg8, _, _, _, arg12)
	local chatType = strsub(event, 10)

	local subType = strsub(chatType, 1, 7)
	if subType == 'WHISPER' then
		chatType = 'WHISPER'
	elseif subType == 'CHANNEL' then
		chatType = 'CHANNEL'..arg8
	end

	--ambiguate guild chat names
	arg2 = Ambiguate(arg2, (chatType == 'GUILD' and 'guild') or 'none')

	local info = arg12 and _G.ChatTypeInfo[chatType]
	if info and _G.Chat_ShouldColorChatByClass(info) then
		local data = CH:GetPlayerInfoByGUID(arg12)
		local classColor = data and data.classColor
		if classColor then
			if E.db.ElvUI_EltreumUI.chat.chaticonenable then
				return ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.chat.chaticontype,data.englishClass)..format('|cff%.2x%.2x%.2x%s|r', classColor.r*255, classColor.g*255, classColor.b*255, arg2)
			else
				return format('|cff%.2x%.2x%.2x%s|r', classColor.r*255, classColor.g*255, classColor.b*255, arg2)
			end
		end
	end

	return arg2
end
hooksecurefunc(CH, "ChatFrame_MessageEventHandler", function()
	if E.db.ElvUI_EltreumUI.chat.chaticonenable then
		CH.GetColoredName = ElvUI_EltreumUI.ChatClassIcons
	end
end)

local classIconsReleaf = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorReleaf.tga:0:0:0:0|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinReleaf.tga:0:0:0:0|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterReleaf.tga:0:0:0:0|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueReleaf.tga:0:0:0:0|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestReleaf.tga:0:0:0:0|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightReleaf.tga:0:0:0:0|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanReleaf.tga:0:0:0:0|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageReleaf.tga:0:0:0:0|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockReleaf.tga:0:0:0:0|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkReleaf.tga:0:0:0:0|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidReleaf.tga:0:0:0:0|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterReleaf.tga:0:0:0:0|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerReleaf.tga:0:0:0:0|t",
}
local classIconsBlizzard = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga:0:0:0:0|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga:0:0:0:0|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga:0:0:0:0|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga:0:0:0:0|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga:0:0:0:0|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight.tga:0:0:0:0|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga:0:0:0:0|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga:0:0:0:0|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga:0:0:0:0|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk.tga:0:0:0:0|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga:0:0:0:0|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter.tga:0:0:0:0|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Evoker.tga:0:0:0:0|t",
}
local classIconsBorder = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorIconReleaf.tga:0:0:0:0|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinIconReleaf.tga:0:0:0:0|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterIconReleaf.tga:0:0:0:0|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueIconReleaf.tga:0:0:0:0|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestIconReleaf.tga:0:0:0:0|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightIconReleaf.tga:0:0:0:0|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanIconReleaf.tga:0:0:0:0|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageIconReleaf.tga:0:0:0:0|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockIconReleaf.tga:0:0:0:0|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkIconReleaf.tga:0:0:0:0|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidIconReleaf.tga:0:0:0:0|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterIconReleaf.tga:0:0:0:0|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerIconReleaf.tga:0:0:0:0|t",
}
local classIconsShadow = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga:0:0:0:0|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga:0:0:0:0|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga:0:0:0:0|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga:0:0:0:0|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga:0:0:0:0|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightShadow.tga:0:0:0:0|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga:0:0:0:0|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga:0:0:0:0|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga:0:0:0:0|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkShadow.tga:0:0:0:0|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga:0:0:0:0|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterShadow.tga:0:0:0:0|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerShadow.tga:0:0:0:0|t",
}
local classIconsOutline = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga:0:0:0:0|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga:0:0:0:0|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga:0:0:0:0|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga:0:0:0:0|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga:0:0:0:0|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight1.tga:0:0:0:0|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga:0:0:0:0|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga:0:0:0:0|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga:0:0:0:0|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk1.tga:0:0:0:0|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga:0:0:0:0|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter1.tga:0:0:0:0|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Evoker1.tga:0:0:0:0|t",
}
local reverseclassIconsReleaf = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
}
local reverseclassIconsBlizzard = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga:0:0:0:0:64:64:64:0:0:64|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga:0:0:0:0:64:64:64:0:0:64|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight.tga:0:0:0:0:64:64:64:0:0:64|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga:0:0:0:0:64:64:64:0:0:64|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter.tga:0:0:0:0:64:64:64:0:0:64|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Evoker.tga:0:0:0:0:64:64:64:0:0:64|t",
}
local reverseclassIconsBorder = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerIconReleaf.tga:0:0:0:0:64:64:64:0:0:64|t",
}
local reverseclassIconsShadow = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerShadow.tga:0:0:0:0:64:64:64:0:0:64|t",
}
local reverseclassIconsOutline = {
	["WARRIOR"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PALADIN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["HUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["ROGUE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["PRIEST"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEATHKNIGHT"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["SHAMAN"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MAGE"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["WARLOCK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["MONK"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DRUID"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["DEMONHUNTER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter1.tga:0:0:0:0:64:64:64:0:0:64|t",
	["EVOKER"] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Evoker1.tga:0:0:0:0:64:64:64:0:0:64|t",
}

--return icons for other functions
function ElvUI_EltreumUI:GetClassIcons(icon,unitclass,invert)
	if not invert then
		if icon == "RELEAF" then
			return classIconsReleaf[unitclass]
		elseif icon == "OUTLINE" then
			return classIconsOutline[unitclass]
		elseif icon == "BLIZZARD" then
			return classIconsBlizzard[unitclass]
		elseif icon == "BORDER" then
			return classIconsBorder[unitclass]
		elseif icon == "SHADOW" then
			return classIconsShadow[unitclass]
		end
	else
		if icon == "RELEAF" then
			return reverseclassIconsReleaf[unitclass]
		elseif icon == "OUTLINE" then
			return reverseclassIconsOutline[unitclass]
		elseif icon == "BLIZZARD" then
			return reverseclassIconsBlizzard[unitclass]
		elseif icon == "BORDER" then
			return reverseclassIconsBorder[unitclass]
		elseif icon == "SHADOW" then
			return reverseclassIconsShadow[unitclass]
		end
	end
end
