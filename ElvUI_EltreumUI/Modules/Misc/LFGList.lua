local E = unpack(ElvUI)
local _G = _G
local select = _G.select

--region table adapted from https://wago.io/JhmeKOgMw
local REGION_COLORED = {
	["DE"] = "|cFF000000D|r|cFFDD0000E|r|cFFFFCE00U|r",
	["FR"] = "|cFF002654F|r|cFFFFFFFFR|r|cFFED2939A|r",
	["GB"] = "|cFFFFFFFFG|r|cFFC8102EB|r|cFF012169R|r",
	["IT"] = "|cFF008C45I|r|cFFF4F9FFT|r|cFFCD212AA|r",
	["ES"] = "|cFF8B0D11E|r|cFFFCB507S|r|cFF8B0D11P|r",
	["RU"] = "|cFFFFFFFFR|r|cFF1C3578U|r|cFFE4181CS|r",
	["PT"] = "|cFF046A38P|r|cFFDA291CR|r|cFFFFE900T|r",
	["OCE"] = "|cFF012169O|r|cFFE4002BC|r|cFFFFFFFFE|r",
	["US-P"] = "|cFF3C3B6EU|r|cFFB22234S|r-|cFFFFFFFFP|r",
	["US-M"] = "|cFF3C3B6EU|r|cFFB22234S|r-|cFFFFFFFFM|r",
	["US-C"] = "|cFF3C3B6EU|r|cFFB22234S|r-|cFFFFFFFFC|r",
	["US-E"] = "|cFF3C3B6EU|r|cFFB22234S|r-|cFFFFFFFFE|r",
	["MEX"] = "|cFF006341M|r|cFFFFFFFFE|r|cFFC8102EX|r",
	["BR"] = "|cFF009739B|r|cFFFEDD00Z|r|cFF012169L|r"
}
local REGION_REALMS
local REGION_REALMS_EU = {
	["DE"] = {
		"Aegwynn", "Alexstrasza", "Alleria", "Aman’Thul", "Aman'Thul", "Ambossar",
		"Anetheron", "Antonidas", "Anub'arak", "Area52", "Arthas",
		"Arygos", "Azshara", "Baelgun", "Blackhand", "Blackmoore",
		"Blackrock", "Blutkessel", "Dalvengyr", "DasKonsortium",
		"DasSyndikat", "DerMithrilorden", "DerRatvonDalaran",
		"DerAbyssischeRat", "Destromath", "Dethecus", "DieAldor",
		"DieArguswacht", "DieNachtwache", "DieSilberneHand", "DieTodeskrallen",
		"DieewigeWacht", "DunMorogh", "Durotan", "Echsenkessel", "Eredar",
		"FestungderStürme", "Forscherliga", "Frostmourne", "Frostwolf",
		"Garrosh", "Gilneas", "Gorgonnash", "Gul'dan", "Kargath", "Kel'Thuzad",
		"Khaz'goroth", "Kil'jaeden", "Krag'jin", "KultderVerdammten", "Lordaeron",
		"Lothar", "Madmortem", "Mal'Ganis", "Malfurion", "Malorne", "Malygos", "Mannoroth",
		"Mug'thol", "Nathrezim", "Nazjatar", "Nefarian", "Nera'thor", "Nethersturm",
		"Norgannon", "Nozdormu", "Onyxia", "Perenolde", "Proudmoore", "Rajaxx", "Rexxar",
		"Sen'jin", "Shattrath", "Taerar", "Teldrassil", "Terrordar", "Theradras", "Thrall",
		"Tichondrius", "Tirion", "Todeswache", "Ulduar", "Un'Goro", "Vek'lor", "Wrathbringer",
		"Ysera", "ZirkeldesCenarius", "Zuluhed"
	},
	["FR"] = {
		"Arakarahm", "Arathi", "Archimonde", "Chantséternels", "Cho’gall", "Cho'gall",
		"ConfrérieduThorium", "ConseildesOmbres", "Dalaran", "Drek’Thar", "Drek'Thar",
		"Eitrigg", "Eldre’Thalas", "Eldre'Thalas", "Elune", "Garona", "Hyjal", "Illidan",
		"Kael’thas", "Kael'thas", "KhazModan", "KirinTor", "Krasus", "LaCroisadeécarlate",
		"LesClairvoyants", "LesSentinelles", "MarécagedeZangar", "Medivh", "Naxxramas",
		"Ner’zhul", "Ner'zhul", "Rashgarroth", "Sargeras", "Sinstralis", "Suramar",
		"Templenoir", "Throk’Feroth", "Throk'Feroth", "Uldaman", "Varimathras", "Vol’jin",
		"Vol'jin", "Ysondre"
	},
	["GB"] = {
		"AeriePeak", "Agamaggan", "Aggramar", "Ahn'Qiraj", "Al'Akir", "Alonsus", "Anachronos",
		"Arathor", "ArenaPass", "ArenaPass1", "ArgentDawn", "Aszune", "Auchindoun", "AzjolNerub",
		"Azuremyst", "Balnazzar", "Blade'sEdge", "Bladefist", "Bloodfeather", "Bloodhoof", "Bloodscalp",
		"Boulderfist", "BronzeDragonflight", "Bronzebeard", "BurningBlade", "BurningLegion", "BurningSteppes",
		"C'Thun", "ChamberofAspects", "Chromaggus", "ColinasPardas", "Crushridge", "CultedelaRivenoire",
		"Daggerspine", "DarkmoonFaire", "Darksorrow", "Darkspear", "Deathwing", "DefiasBrotherhood",
		"Dentarg", "Doomhammer", "Draenor", "Dragonblight", "Dragonmaw", "Drak'thul", "Dunemaul",
		"EarthenRing", "EmeraldDream", "Emeriss", "Eonar", "Executus", "Frostmane", "Frostwhisper",
		"Genjuros", "Ghostlands", "GrimBatol", "Hakkar", "Haomarush", "Hellfire", "Hellscream",
		"Jaedenar", "Karazhan", "Kazzak", "Khadgar", "Kilrogg", "Kor'gall", "KulTiras", "LaughingSkull",
		"Lightbringer", "Lightning'sBlade", "Magtheridon", "Mazrigos", "Moonglade", "Nagrand",
		"Neptulon" , "Nordrassil", "Outland", "Quel'Thalas", "Ragnaros", "Ravencrest", "Ravenholdt",
		"Runetotem", "Saurfang", "ScarshieldLegion", "Shadowsong", "ShatteredHalls", "ShatteredHand",
		"Silvermoon", "Skullcrusher", "Spinebreaker", "Sporeggar", "SteamwheedleCartel", "Stormrage",
		"Stormreaver", "Stormscale", "Sunstrider", "Sylvanas", "Talnivarr", "TarrenMill", "Terenas",
		"Terokkar", "TheMaelstrom", "TheSha'tar", "TheVentureCo", "Thunderhorn", "Trollbane", "Turalyon",
		"Twilight'sHammer", "TwistingNether", "Vashj", "Vek'nilash", "Wildhammer", "Xavius", "Zenedar"
	},
	["IT"] = {
		"Nemesis", "Pozzodell'Eternità"
	},
	["ES"] = {
		"DunModr", "EuskalEncounter", "Exodar", "LosErrantes", "Minahonda", "Sanguino", "Shen'dralar",
		"Tyrande", "Uldum", "Zul'jin"
	},
	["RU"] = {
		"Азурегос", "Борейскаятундра", "ВечнаяПесня", "Галакронд", "Голдринн", "Гордунни",
		"Гордунни", "Гром", "Дракономор", "Корольлич", "Пиратскаябухта", "Подземье", "ПропускнаАрену1",
		"Разувий", "Ревущийфьорд", "СвежевательДуш", "Седогрив", "СтражСмерти", "Термоштепсель",
		"ТкачСмерти", "ЧерныйШрам", "Ясеневыйлес"
	},
	["PT"] = {"Aggra(Português)"}
}
local REGION_REALMS_US = {
	["OCE"] = {
		"Aman'Thul", "Barthilas", "Caelestrasz", "Dath'Remar", "Dreadmaul",
		"Frostmourne", "Gundrak", "Jubei'Thos", "Khaz'goroth", "Nagrand",
		"Saurfang", "Thaurissan"
	},
	["US-P"] = {
		"Aerie Peak", "Anvilmar", "Arathor", "Antonidas", "Azuremyst",
		"Baelgun", "Blade's Edge", "Bladefist", "Bronzebeard", "Cenarius",
		"Darrowmere", "Draenor", "Dragonblight", "Echo Isles", "Galakrond",
		"Gnomeregan", "Hyjal", "Kilrogg", "Korialstrasz", "Lightbringer",
		"Misha", "Moonrunner", "Nordrassil", "Proudmoore", "Shadowsong",
		"Shu'Halo", "Silvermoon", "Skywall", "Suramar", "Uldum", "Uther",
		"Velen", "Windrunner", "Blackrock", "Blackwing Lair", "Bonechewer",
		"Boulderfist", "Coilfang", "Crushridge", "Daggerspine", "Dark Iron",
		"Destromath", "Dethecus", "Dragonmaw", "Dunemaul", "Frostwolf",
		"Gorgonnash", "Gurubashi", "Kalecgos", "Kil'Jaeden", "Lethon", "Maiev",
		"Nazjatar", "Ner'zhul", "Onyxia", "Rivendare", "Shattered Halls",
		"Spinebreaker", "Spirestone", "Stonemaul", "Stormscale", "Tichondrius",
		"Ursin", "Vashj", "Blackwater Raiders", "Cenarion Circle",
		"Feathermoon", "Sentinels", "Silver Hand", "The Scryers",
		"Wyrmrest Accord", "The Venture Co"
	},
	["US-M"] = {
		"Azjol-Nerub", "AzjolNerub", "Doomhammer", "Icecrown", "Perenolde",
		"Terenas", "Zangarmarsh", "Kel'Thuzad", "Darkspear", "Deathwing",
		"Bloodscalp", "Nathrezim", "Shadow Council"
	},
	["US-C"] = {
		"Aegwynn", "Agamaggan", "Aggramar", "Akama", "Alexstrasza", "Alleria",
		"Archimonde", "Azgalor", "Azshara", "Balnazzar", "Blackhand",
		"Blood Furnace", "Borean Tundra", "Burning Legion", "Cairne",
		"Cho'gall", "Chromaggus", "Dawnbringer", "Dentarg", "Detheroc",
		"Drak'tharon", "Drak'thul", "Draka", "Eitrigg", "Emerald Dream",
		"Farstriders", "Fizzcrank", "Frostmane", "Garithos", "Garona",
		"Ghostlands", "Greymane", "Grizzly Hills", "Gul'dan", "Hakkar",
		"Hellscream", "Hydraxis", "Illidan", "Kael'thas", "Khaz Modan",
		"Kirin Tor", "Korgath", "Kul Tiras", "Laughing Skull", "Lightninghoof",
		"Madoran", "Maelstrom", "Mal'Ganis", "Malfurion", "Malorne", "Malygos",
		"Mok'Nathal", "Moon Guard", "Mug'thol", "Muradin", "Nesingwary",
		"Quel'Dorei", "Ravencrest", "Rexxar", "Runetotem", "Sargeras",
		"Scarlet Crusade", "Sen'Jin", "Sisters of Elune", "Staghelm",
		"Stormreaver", "Terokkar", "The Underbog", "Thorium Brotherhood",
		"Thunderhorn", "Thunderlord", "Twisting Nether", "Vek'nilash",
		"Whisperwind", "Wildhammer", "Winterhoof"
	},
	["US-E"] = {
		"Altar of Storms", "Alterac Mountains", "Andorhal", "Anetheron",
		"Anub'arak", "Area 52", "Argent Dawn", "Arthas", "Arygos", "Auchindoun",
		"Black Dragonflight", "Bleeding Hollow", "Bloodhoof", "Burning Blade",
		"Dalaran", "Dalvengyr", "Demon Soul", "Drenden", "Durotan", "Duskwood",
		"Earthen Ring", "Eldre'Thalas", "Elune", "Eonar", "Eredar", "Executus",
		"Exodar", "Fenris", "Firetree", "Garrosh", "Gilneas", "Gorefiend",
		"Grizzly Hills", "Haomarush", "Jaedenar", "Kargath", "Khadgar",
		"Lightning's Blade", "Llane", "Lothar", "Magtheridon", "Mannoroth",
		"Medivh", "Nazgrel", "Norgannon", "Ravenholdt", "Scilla", "Shadowmoon",
		"Shandris", "Shattered Hand", "Skullcrusher", "Smolderthorn",
		"Steamwheedle Cartel", "Stormrage", "Tanaris", "The Forgotten Coast",
		"Thrall", "Tortheldrin", "Trollbane", "Turalyon", "Uldaman",
		"Undermine", "Warsong", "Ysera", "Ysondre", "Zul'jin", "Zuluhed"
	},
	["MEX"] = {"Drakkari", "Quel'Thalas", "Ragnaros"},
	["BR"] = {"Azralon", "Gallywix", "Goldrinn", "Nemesis", "Tol Barad"}
}
if GetCurrentRegion() == 3 then
	REGION_REALMS = REGION_REALMS_EU
end

if GetCurrentRegion() == 1 then
	REGION_REALMS = REGION_REALMS_US
end

--LFG Spec Icons, based on https://wago.io/cFpgwuLe0
function ElvUI_EltreumUI:DungeonRoleIcons()
	if E.db.ElvUI_EltreumUI.skins.groupfinderSpecIcons then
		local role_order = _G.LFG_LIST_GROUP_DATA_ROLE_ORDER
		local class_order = _G.LFG_LIST_GROUP_DATA_CLASS_ORDER
		local raidClassColors = _G.RAID_CLASS_COLORS

		local roleIndex = {}
		local classIndex = {}

		for i=1, #role_order do
			roleIndex[role_order[i]] = i
		end

		for i=1, #class_order do
			classIndex[class_order[i]] = i
		end

		--C_LFGList.GetSearchResultMemberInfo returns a localized name for the spec, which would fail in other languages, so get the localized name and icon for the spec before running
		local GetSpecializationInfoForClassID = _G.GetSpecializationInfoForClassID
		local iconTable = {}
		for classID = 1, 13 do --13 classes in retail
			if GetClassInfo(classID) then --nil check for classic
				local className = select(2, GetClassInfo(classID))
				iconTable[className] = {}
				for i = 1, 4 do --druids have 4 in retail
					--local id, name, description, icon, role, isRecommended, isAllowed = GetSpecializationInfoForClassID(classID, specIndex)
					local _, name, _, icon = GetSpecializationInfoForClassID(classID, i)
					if name and icon then --nil check for classic
						iconTable[className][name] = icon
					end
				end
			end
		end

		local function SearchEntry_Update(entry)
			if not _G.LFGListFrame.SearchPanel:IsShown() then return end
			local resultInfo = C_LFGList.GetSearchResultInfo(entry.resultID)
			local activityTable = C_LFGList.GetActivityInfoTable(resultInfo.activityID)
			local categoryID = activityTable.categoryID

			--start of the io/region thing
			if E.Retail then
				if GetCurrentRegion() == 3 or GetCurrentRegion() == 1 then
					local function GetRegion(name)
						if not name then return nil end
						local leaderRealm = name:match("%-(.+)")
						if leaderRealm then
							leaderRealm = leaderRealm:lower():gsub(" ", "")
						else
							leaderRealm = GetRealmName():lower():gsub(" ", "")
						end
						for region, regionRealms in pairs(REGION_REALMS) do
							for _, realm in pairs(regionRealms) do
								if realm:lower():gsub(" ", "") == leaderRealm then
									return region
								end
							end
						end
					end
					local region
					if REGION_COLORED[GetRegion(resultInfo.leaderName)] then
						region = REGION_COLORED[GetRegion(resultInfo.leaderName)]
					else
						region = "???"
					end
					if entry.ActivityName:GetText() ~= nil and entry.ActivityName:GetText() ~= "" then
						entry.ActivityName:SetFormattedText("%s %s", region,entry.ActivityName:GetText())
					end
					if entry.Name:GetText() ~= nil then
						local score = resultInfo.leaderOverallDungeonScore or 0
						local name = entry.Name:GetText() or ""
						local r, g, b = C_ChallengeMode.GetDungeonScoreRarityColor(score):GetRGB()
						local hex = E:RGBToHex(r, g, b, 'ff')
						entry.Name:SetText("|c"..hex..score.."|r "..name)
						entry.Name:SetWidth(176)
					end
				end
			end
			--end of the io/region thing

			-- reset textures
			for i = 1, 5 do
				if entry.DataDisplay.Enumerate[i] then
					entry.DataDisplay.Enumerate[i]:Hide()
					entry.DataDisplay.Enumerate[i.."b"]:Hide()
				end
			end

			--only in dungeon or arena listings
			if categoryID == 2 or categoryID == 4 or categoryID == 7 then
				local maxNumPlayers = activityTable.maxNumPlayers
				local numMembers = resultInfo.numMembers
				local partymembers = {}

				for i=1, numMembers do
					local role, class, _, specLocalized = C_LFGList.GetSearchResultMemberInfo(entry.resultID, i)
					local icon = iconTable[class][specLocalized]
					partymembers[#partymembers+1] = {roleIndex[role], classIndex[class], raidClassColors[class],icon}
				end

				if categoryID == 2 then --sort dungeon members
					table.sort(partymembers, function(a,b)
						if a[1] ~= b[1] then
							return a[1] < b[1]
						else
							return a[2] < b[2]
						end
					end)
				else
					table.sort(partymembers, function(a,b)
						return a[2] < b[2]
					end)
				end

				entry.DataDisplay:SetPoint("RIGHT", entry.DataDisplay:GetParent(), "RIGHT", 0, -5)

				for i = 1, numMembers do
					if not entry.DataDisplay.Enumerate[i] then
						entry.DataDisplay.Enumerate[i] = entry.DataDisplay:CreateTexture(nil, "BORDER")
						entry.DataDisplay.Enumerate[i]:SetSize(17, 17)
						entry.DataDisplay.Enumerate[i.."b"] = entry.DataDisplay:CreateTexture(nil, "BACKGROUND")
						entry.DataDisplay.Enumerate[i.."b"]:SetSize(20, 20)
					end

					entry.DataDisplay.Enumerate[i]:SetPoint("RIGHT", entry.DataDisplay.Enumerate, "RIGHT", -13 - 21*(maxNumPlayers-i), -1)
					entry.DataDisplay.Enumerate[i]:Show()
					entry.DataDisplay.Enumerate[i]:SetTexture(partymembers[i][4])
					entry.DataDisplay.Enumerate[i]:SetTexCoord(0.08,0.92,0.08,0.92)

					local r, g, b, _ = partymembers[i][3]:GetRGBA()
					entry.DataDisplay.Enumerate[i.."b"]:SetPoint("CENTER", entry.DataDisplay.Enumerate[i], "CENTER", 0, 0)
					entry.DataDisplay.Enumerate[i.."b"]:Show()
					entry.DataDisplay.Enumerate[i.."b"]:SetColorTexture(r, g, b, 0.75)
					entry.DataDisplay.Enumerate:Hide()
				end
			end
		end
		hooksecurefunc("LFGListSearchEntry_Update", SearchEntry_Update)
	end
end

--fix taint by replacing the function with the same function https://github.com/0xbs/premade-groups-filter/issues/64#issuecomment-1001230231
local function LFMPlus_GetPlaystyleString(playstyle,activityInfo)
	if activityInfo and playstyle ~= (0 or nil) and C_LFGList.GetLfgCategoryInfo(activityInfo.categoryID).showPlaystyleDropdown then
		local typeStr
		if activityInfo.isMythicPlusActivity then
			typeStr = "GROUP_FINDER_PVE_PLAYSTYLE"
		elseif activityInfo.isRatedPvpActivity then
			typeStr = "GROUP_FINDER_PVP_PLAYSTYLE"
		elseif activityInfo.isCurrentRaidActivity then
			typeStr = "GROUP_FINDER_PVE_RAID_PLAYSTYLE"
		elseif activityInfo.isMythicActivity then
			typeStr = "GROUP_FINDER_PVE_MYTHICZERO_PLAYSTYLE"
		end

		return typeStr and _G[typeStr .. tostring(playstyle)] or nil
	else
		return nil
	end
end

C_LFGList.GetPlaystyleString = function(playstyle,activityInfo)
	return LFMPlus_GetPlaystyleString(playstyle, activityInfo)
end