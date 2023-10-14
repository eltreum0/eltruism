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

			--Era Hardcore
			["Eltreum-DefiasPillager"] = EltreumIcon,
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
			["BioVenom-Bloodsail Buccaneers"] = DonatorsIcon,

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
			--print(data.englishClass)
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
hooksecurefunc(CH, "ChatFrame_MessageEventHandler", function()
	if (E.db.ElvUI_EltreumUI.chat.chaticonenable or E.db.ElvUI_EltreumUI.chat.chatgradient) and E.db.ElvUI_EltreumUI.chat.enable then
		CH.GetColoredName = ElvUI_EltreumUI.ChatClassIcons
	end
end)
