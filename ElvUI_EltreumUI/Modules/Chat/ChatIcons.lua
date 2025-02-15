local E = unpack(ElvUI)
local _G = _G
local CH = E:GetModule("Chat")
local hooksecurefunc = _G.hooksecurefunc
local format = _G.string.format

--Add Icons to chat messages
function ElvUI_EltreumUI:AuthorMVPDonatorIcons()
	if E.db.ElvUI_EltreumUI.chat.AuthorMVPDonatorIcons and E.db.ElvUI_EltreumUI.chat.enable then

		--Eltreum
		--|Tpath:height[:width[:offsetX:offsetY:[textureWidth:textureHeight:leftTexel:rightTexel:topTexel:bottomTexel[:rVertexColor:gVertexColor:bVertexColor]]]]|t
		local EltreumIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogodev.tga:0:0:0:0|t"
		local EltreumCharacters = {

			--Retail Alliance
			["Player-60-0B62BF9C"] = EltreumIcon,
			["Player-60-0BBBFF11"] = EltreumIcon,
			["Player-60-0CDCC518"] = EltreumIcon,
			["Player-60-0D00D78E"] = EltreumIcon,
			["Player-60-0DBEDC14"] = EltreumIcon,
			["Player-60-0DEBE0B7"] = EltreumIcon,
			["Player-60-0DEC3E9C"] = EltreumIcon,
			["Player-60-0DECCECB"] = EltreumIcon,
			["Player-60-0DEDEAAD"] = EltreumIcon,
			["Player-60-0DEDFB0A"] = EltreumIcon,
			["Player-60-0DFAC76D"] = EltreumIcon,
			["Player-60-0DFAC842"] = EltreumIcon,
			["Player-60-0DFAC92E"] = EltreumIcon,
			["Player-60-0DFD7A01"] = EltreumIcon,
			["Player-60-0E06D642"] = EltreumIcon,
			["Player-60-0EDC440B"] = EltreumIcon,

			--Retail Horde
			["Player-3676-09816781"] = EltreumIcon,
			["Player-3676-0984E6B5"] = EltreumIcon,
			["Player-3676-0987AC00"] = EltreumIcon,
			["Player-3676-099EF991"] = EltreumIcon,
			["Player-3676-0DF62D9C"] = EltreumIcon,

			--other
			["Player-100-0DED4208"] = EltreumIcon,

			--Cata
			["Player-4408-03A87F8F"] = EltreumIcon,
			["Player-4408-03E923CC"] = EltreumIcon,
			["Player-4408-03F14DE7"] = EltreumIcon,
			["Player-4408-04531453"] = EltreumIcon,

			--Era Hardcore
			["Eltreum-DefiasPillager"] = EltreumIcon,

			--Era Season of Discovery
			["Player-5815-029B0939"] = EltreumIcon,
			["Player-5815-02ABCE57"] = EltreumIcon,
			["Player-5815-02ABCED4"] = EltreumIcon,
			["Player-5815-02ABD315"] = EltreumIcon,
			["Player-5815-02ABD3B9"] = EltreumIcon,
			["Player-5815-02ABDC2E"] = EltreumIcon,
			["Player-5815-02ABDDBF"] = EltreumIcon,
		}

		--Donators
		local DonatorsIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogodonator.tga:0:0:0:0|t"
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

			--Dlarge
			["Âlysiâ-Alleria"] = DonatorsIcon,
			["Xâvius-Alleria"] = DonatorsIcon,
			["Dractyron-Alleria"] = DonatorsIcon,
			["Xândos-Alleria"] = DonatorsIcon,
			["Môrphos-Alleria"] = DonatorsIcon,
			["Âllandir-Alleria"] = DonatorsIcon,
			["Xâdrilâ-Alleria"] = DonatorsIcon,
			["Shiôla-Alleria"] = DonatorsIcon,
			["Shâolîn-Alleria"] = DonatorsIcon,
			["Gnomico-Alleria"] = DonatorsIcon,
			["Sârâphyn-Alleria"] = DonatorsIcon,
			["Xentario-Alleria"] = DonatorsIcon,
			["Xântios-Alleria"] = DonatorsIcon,

			--madlampy
			["Vonbek-TarrenMill"] = DonatorsIcon,
			["Vonhellzing-TarrenMill"] = DonatorsIcon,
			["Raarmoo-TarrenMill"] = DonatorsIcon,
			["Rosavonbek-TarrenMill"] = DonatorsIcon,

			--greevir
			["Greevir-Skywall"] = DonatorsIcon,
			["Greebur-Skywall"] = DonatorsIcon,
			["Greevir-Westfall"] = DonatorsIcon,
			["Greebur-Westfall"] = DonatorsIcon,
			["Greevur-Westfall"] = DonatorsIcon,
			["Analrexia-Westfall"] = DonatorsIcon,
			["Verstedruide-Westfall"] = DonatorsIcon,
			["Verstekriger-Westfall"] = DonatorsIcon,
			["Greevir-Bloodsail Buccaneers"] = DonatorsIcon,
			["Slaehretaw-Maladath"] = DonatorsIcon,
			["Greevir-Maladath"] = DonatorsIcon,

			--necator
			["Necator-Benediction"] = DonatorsIcon,

			--biovenom
			["Bòóbs-Bloodsail Buccaneers"] = DonatorsIcon,
			["Bôôbs-Bloodsail Buccaneers"] = DonatorsIcon,
			["Bôôm-Bloodsail Buccaneers"] = DonatorsIcon,
			["Bóòbs-Bloodsail Buccaneers"] = DonatorsIcon,
			["Bõõbs-Bloodsail Buccaneers"] = DonatorsIcon,
			["Bööbs-Bloodsail Buccaneers"] = DonatorsIcon,
			["NÏpples-Bloodsail Buccaneers"] = DonatorsIcon,
			["Biovenom-Bloodsail Buccaneers"] = DonatorsIcon,

			--Ante
			["Boss-TarrenMill"] = DonatorsIcon,
			["Viper-TarrenMill"] = DonatorsIcon,
			["Teddy-TarrenMill"] = DonatorsIcon,
			["Soap-TarrenMill"] = DonatorsIcon,
			["Snail-TarrenMill"] = DonatorsIcon,
			["Pizza-TarrenMill"] = DonatorsIcon,
			["Bee-TarrenMill"] = DonatorsIcon,
			["Zeus-TarrenMill"] = DonatorsIcon,
			["Demik-TarrenMill"] = DonatorsIcon,
			["Stormer-TarrenMill"] = DonatorsIcon,
			["Antitankie-TarrenMill"] = DonatorsIcon,
			["Tarrenmonka-TarrenMill"] = DonatorsIcon,
			["Vanishe-TarrenMill"] = DonatorsIcon,
			["Angelina-TarrenMill"] = DonatorsIcon,
			["Gigadudu-TarrenMill"] = DonatorsIcon,
			["Tyrant-TarrenMill"] = DonatorsIcon,

			--Spectated
			["Spectated-Benediction"] = DonatorsIcon,

			--Volo
			["Völo-Benediction"] = DonatorsIcon,

			--Jaraxal
			["Grymley-Scilla"] = DonatorsIcon,

			--Marynia
			["Sarmyte-Azralon"] = DonatorsIcon,
		}

		--Discord MVPs
		local MVPIcon = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogomvp.tga:0:0:0:0|t"
		local MVPCharacters = {
			--Atwood
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

			--Blinkii
			["Raeldan-Thrall"] = MVPIcon,
			["Blinkii-Thrall"] = MVPIcon,
			["Flinkii-Thrall"] = MVPIcon,
			["Zwerglii-Thrall"] = MVPIcon,
			["Raeldan-Arygos"] = MVPIcon,
			["Blinkii-Arygos"] = MVPIcon,
			["Flinkii-Arygos"] = MVPIcon,
			["Zwerglii-Arygos"] = MVPIcon,

			--roxanne
			["Roxanne-Blackrock"] = DonatorsIcon,
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
	if not arg2 then return end -- guild deaths is called here with no arg2
	if not E.private.chat.enable then return end

	local chatType = strsub(event, 10)
	local subType = strsub(chatType, 1, 7)
	if subType == 'WHISPER' then
		chatType = 'WHISPER'
	elseif subType == 'CHANNEL' then
		chatType = 'CHANNEL'..arg8
	end

	-- ambiguate guild chat names
	local name = Ambiguate(arg2, (chatType == 'GUILD' and 'guild') or 'none')

	local info = name and arg12 and _G.ChatTypeInfo[chatType]
	if info and _G.Chat_ShouldColorChatByClass(info) then
		local data = CH:GetPlayerInfoByGUID(arg12)
		local classColor = data and data.classColor
		if classColor and data.englishClass then
			if E.db.ElvUI_EltreumUI.chat.chaticonenable and E.db.ElvUI_EltreumUI.chat.chatgradient then
				return ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.chat.chaticontype,data.englishClass,false,"32")..ElvUI_EltreumUI:GradientName(name, data.englishClass)
			elseif E.db.ElvUI_EltreumUI.chat.chaticonenable and not E.db.ElvUI_EltreumUI.chat.chatgradient then
				return ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.chat.chaticontype,data.englishClass,false,"32")..format('|cff%.2x%.2x%.2x%s|r', classColor.r*255, classColor.g*255, classColor.b*255, name)
			elseif not E.db.ElvUI_EltreumUI.chat.chaticonenable and E.db.ElvUI_EltreumUI.chat.chatgradient then
				return ElvUI_EltreumUI:GradientName(name, data.englishClass)
			else
				return format('|cff%.2x%.2x%.2x%s|r', classColor.r*255, classColor.g*255, classColor.b*255, name)
			end
		end
	end

	return name
end

--hook GetPFlag to add race/sex to the player names in chat
local IsTimerunningPlayer = C_ChatInfo.IsTimerunningPlayer
local GetChannelRulesetForChannelID = C_ChatInfo.GetChannelRulesetForChannelID
local PLAYERMENTORSHIPSTATUS_NEWCOMER = Enum.PlayerMentorshipStatus and Enum.PlayerMentorshipStatus.Newcomer
local CHATCHANNELRULESET_MENTOR = Enum.ChatChannelRuleset and Enum.ChatChannelRuleset.Mentor
local NPEV2_CHAT_USER_TAG_GUIDE = gsub(NPEV2_CHAT_USER_TAG_GUIDE or '', '(|A.-|a).+', '%1') -- we only want the icon

function ElvUI_EltreumUI:GetPFlag(specialFlag, zoneChannelID, unitGUID)
	local flag = ''

	if specialFlag ~= '' then
		if specialFlag == 'GM' or specialFlag == 'DEV' then
			-- Add Blizzard Icon if this was sent by a GM/DEV
			flag = [[|TInterface\ChatFrame\UI-ChatIcon-Blizz:12:20:0:0:32:16:4:28:0:16|t ]]
		elseif specialFlag == 'GUIDE' then
			if CH.db.mentorshipIcon and _G.ChatFrame_GetMentorChannelStatus(CHATCHANNELRULESET_MENTOR, GetChannelRulesetForChannelID(zoneChannelID)) == CHATCHANNELRULESET_MENTOR then
				flag = NPEV2_CHAT_USER_TAG_GUIDE
			end
		elseif specialFlag == 'NEWCOMER' then
			if CH.db.mentorshipIcon and _G.ChatFrame_GetMentorChannelStatus(PLAYERMENTORSHIPSTATUS_NEWCOMER, GetChannelRulesetForChannelID(zoneChannelID)) == PLAYERMENTORSHIPSTATUS_NEWCOMER then
				flag = _G.NPEV2_CHAT_USER_TAG_NEWCOMER
			end
		else
			flag = _G['CHAT_FLAG_'..specialFlag]
		end
	end

	if E.Retail and E.db.chat.timerunningIcon and unitGUID and IsTimerunningPlayer(unitGUID) then
		flag = flag .. TIMERUNNING_SMALL
	end

	--get the data to add the race/sex icons and then add it
	if unitGUID then
		local data = CH:GetPlayerInfoByGUID(unitGUID)
		--some nil checks
		if not data.englishRace then data.englishRace = "Human" end
		if not data.sex or data.sex == 1 then data.sex = 2 end
		if E.Retail then
			flag = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Retail\\"..data.englishRace..data.sex..".tga:0:0:0:0|t"..flag
		else
			flag = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Races\\Classic\\"..data.englishRace..data.sex..".tga:0:0:0:0|t"..flag
		end
	end

	return flag
end

hooksecurefunc(CH, "ChatFrame_MessageEventHandler", function()
	if E.db.ElvUI_EltreumUI.chat.enable then
		if (E.db.ElvUI_EltreumUI.chat.chaticonenable or E.db.ElvUI_EltreumUI.chat.chatgradient) then
			CH.GetColoredName = ElvUI_EltreumUI.ChatClassIcons
		end
		if E.db.ElvUI_EltreumUI.chat.chatraceicon then
			CH.GetPFlag = ElvUI_EltreumUI.GetPFlag
		end
	end
end)

