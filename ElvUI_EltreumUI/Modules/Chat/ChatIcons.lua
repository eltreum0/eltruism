local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local CH = E:GetModule("Chat")

--Eltreum
local EltreumIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga:0:0:0:0:32:32:0:32:0:32:69:128:179|t"
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
local DonatorsIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga:0:0:0:0:32:32:0:32:0:32:181:9:9|t"
local DonatorsCharacters = {
	--["Kuriatas-Stormrage"] = DonatorsIcon, --test
}

--Discord MVPs
local MVPIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogowhite.tga:0:0:0:0:32:32:0:32:0:32:255:115:0|t"
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

--Add Icons to chat messages
CH:AddPluginIcons(function(unit)
	if EltreumCharacters[unit] then
		return EltreumCharacters[unit]
	elseif DonatorsCharacters[unit] then
		return DonatorsCharacters[unit]
	elseif MVPCharacters[unit] then
		return MVPCharacters[unit]
	end
end)


local classIcons = {
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

function CH:GetColoredName(event, _, arg2, _, _, _, _, _, arg8, _, _, _, arg12)
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
			return classIcons[data.englishClass]..format('|cff%.2x%.2x%.2x%s|r', classColor.r*255, classColor.g*255, classColor.b*255, arg2)
		end
	end

	return arg2
end
