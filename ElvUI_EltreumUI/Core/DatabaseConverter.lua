local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

--Based on ElvUI's and SLE's db convert
function ElvUI_EltreumUI:DatabaseConversions(forced)
	if E.private.ElvUI_EltreumUI.install_version ~= nil then
		E.PopupDialogs["ELTRUISMDBCONVERT"] = {
			text = L["Eltruism database was converted.\n|cff82B4ffThe Following profiles were updated:|r\n%s\n\n|cff82B4ffPrivate settings were updated for the following private profiles:|r\n%s\n\n|cff82B4ffIf you have any issues please report in Discord or open a ticket|r\n|cffff0000A Reload is necessary to save this conversion|r"],
			OnAccept = ReloadUI,
			button1 = ACCEPT,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}

		--[[if E.private.ElvUI_EltreumUI.install_version < "2.7.3" then
			local ProfileNames = "NONE"
			local CharacterNames = "NONE"

			--Profile options conversion
			for profile, data in pairs(ElvDB.profiles) do
				local profileChanged = false
				if data then
					if data.ElvUI_EltreumUI then
						profileChanged = true
					end
					if profileChanged then
						if ProfileNames == "NONE" then
							ProfileNames = profile
						else
							ProfileNames = ProfileNames..', '..profile
						end
					end
				end
			end

			--Private options convert
			for private, data in pairs(ElvPrivateDB.profiles) do
				local privateChanged = false
				if data then
					if data.ElvUI_EltreumUI then
						privateChanged = true
					end
					if privateChanged then
						if CharacterNames == "NONE" then
							CharacterNames = private
						else
							CharacterNames = CharacterNames..', '..private
						end
					end
				end
			end

			--E:StaggeredUpdateAll(nil, true)
			E:StaticPopup_Show('ELTRUISMDBCONVERT', ProfileNames, CharacterNames)
			E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version]]

		if E.private.ElvUI_EltreumUI.install_version < "3.2.5" or forced then

			--Profile options conversion
			local ProfileNames = "NONE"
			local CharacterNames = "NONE"
			for profile, data in pairs(ElvDB.profiles) do
				local profileChanged = false
				if data then
					if data.ElvUI_EltreumUI then
						if data.ElvUI_EltreumUI.skins then
							if data.ElvUI_EltreumUI.instances then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.instances, data.ElvUI_EltreumUI.instances)
							else
								data.ElvUI_EltreumUI.instances = {
									enable = false,
									fontsize = 12,
									r = 0.90,
									g = 0.72,
									b = 0,
									DungeonNormal = "N.Dungeon",
									DungeonHeroic = "H.Dungeon",
									Raid = "Raid",
									MythicRaid = "Mythic Raid",
									RaidHeroic = "Heroic Raid",
									RaidLFR = "LFR",
									DungeonMythic = "Mythic 0",
									DungeonMythicPlus = "Mythic+",
									DungeonTimewalker = "TW.Dungeon",
									RaidTimewalker = "TW.Raid",
									guild = "Guild",
								}
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.instances, data.ElvUI_EltreumUI.instances)
							end
							if data.ElvUI_EltreumUI.shadows then
								local temp = E.db.ElvUI_EltreumUI.skins.shadows
								E.db.ElvUI_EltreumUI.skins.shadows = {}
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadows, data.ElvUI_EltreumUI.shadows)
								E.db.ElvUI_EltreumUI.skins.shadows.enable =  temp
							else
								data.ElvUI_EltreumUI.shadows = {
									enable = false,
									raid = true,
									aura = false,
									ufaura = false,
									actionbars = false,
									nameplates = false, --healthbars
									npauras = false,
									npportraits = false,
									nppower = false,
									npcastbar = false,
								}
								E.db.ElvUI_EltreumUI.skins.shadows = {}
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadows, data.ElvUI_EltreumUI.shadows)
							end

							if data.ElvUI_EltreumUI.blizzframes then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.blizzframes, data.ElvUI_EltreumUI.blizzframes)
							else
								data.ElvUI_EltreumUI.skins.blizzframes = {
									errorframe = true,
									errorframefontsize = 14,
									hideerrorframe = false,
									raidbossframe = true,
									raidbossframefontsize = 14,
								}
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.blizzframes, data.ElvUI_EltreumUI.blizzframes)
							end
							if data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext == nil then
								data.ElvUI_EltreumUI.skins.playerdeathcustomtext = "YOU DIED"
								E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext = "YOU DIED"
								E:CopyTable(data.ElvUI_EltreumUI.skins.playerdeathcustomtext, E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext)
							elseif data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext ~= nil then
								E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext = data.ElvUI_EltreumUI.playerdeathcustomtext
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext, data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext)
							end
							if data.ElvUI_EltreumUI.otherstuff.playerdeath then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeath, data.ElvUI_EltreumUI.skins.playerdeath)
							elseif data.ElvUI_EltreumUI.otherstuff.playerdeath == nil then
								data.ElvUI_EltreumUI.skins.playerdeath = false
								E.db.ElvUI_EltreumUI.skins.playerdeath = false
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeath, data.ElvUI_EltreumUI.skins.playerdeath)
							end
							if data.ElvUI_EltreumUI.otherstuff.playerdeathgta then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathgta, data.ElvUI_EltreumUI.skins.playerdeathgta)
							elseif data.ElvUI_EltreumUI.otherstuff.playerdeathgta == nil then
								data.ElvUI_EltreumUI.skins.playerdeathgta = false
								E.db.ElvUI_EltreumUI.skins.playerdeathgta = false
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathgta, data.ElvUI_EltreumUI.skins.playerdeathgta)
							end
							if data.ElvUI_EltreumUI.otherstuff.playerdeathcustom then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathcustom, data.ElvUI_EltreumUI.skins.playerdeathcustom)
							elseif data.ElvUI_EltreumUI.otherstuff.playerdeathcustom == nil then
								data.ElvUI_EltreumUI.skins.playerdeathcustom = false
								E.db.ElvUI_EltreumUI.skins.playerdeathcustom = false
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathcustom, data.ElvUI_EltreumUI.skins.playerdeathcustom)
							end
							if data.ElvUI_EltreumUI.otherstuff.hidetalkinghead then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.hidetalkinghead, data.ElvUI_EltreumUI.skins.hidetalkinghead)
							elseif data.ElvUI_EltreumUI.otherstuff.hidetalkinghead == nil then
								data.ElvUI_EltreumUI.skins.hidetalkinghead = false
								E.db.ElvUI_EltreumUI.skins.hidetalkinghead = false
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.hidetalkinghead, data.ElvUI_EltreumUI.skins.hidetalkinghead)
							end
							if data.ElvUI_EltreumUI.tbctalents.enable then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.tbctalents, data.ElvUI_EltreumUI.skins.tbctalents)
							elseif data.ElvUI_EltreumUI.tbctalents.enable == nil then
								data.ElvUI_EltreumUI.skins.tbctalents = false
								E.db.ElvUI_EltreumUI.skins.tbctalents = false
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.tbctalents, data.ElvUI_EltreumUI.skins.tbctalents)
							end
							if data.ElvUI_EltreumUI.stealthOptions.stealtheffect then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.stealtheffect, data.ElvUI_EltreumUI.skins.stealtheffect)
							elseif data.ElvUI_EltreumUI.stealthOptions.stealtheffect == nil then
								data.ElvUI_EltreumUI.skins.stealtheffec = false
								E.db.ElvUI_EltreumUI.skins.stealtheffec = false
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.stealtheffec, data.ElvUI_EltreumUI.skins.stealtheffec)
							end
						elseif data.ElvUI_EltreumUI.skins == nil then
							data.ElvUI_EltreumUI.skins = {
								levelbossinstance = false,
								widertransmog = false,
								expandedstable = false,
								characterpanelscale = 1,
								classiconsoncharacterpanel = false,
								classiconsblizz = false,
								classiconsreleaf = false,
								classicarmory = false,
								classicarmoryautostats = false,
								ilvls = false,
								ilvlsinspect = true,
								sockets = false,
								socketsinspect = false,
								ilvlanchor = "CENTER",
								ilvlfontsize = 16,
								ilvlfontweight = "THICKOUTLINE",
								expandarmorybg = false,
								itemquality = false,
								armorybgtype = "CLASS",
								armoryvignette = true,
								armoryvignettealpha = 1,
								expandarmorybgalpha = 0.3,
								expandarmorycrest = false,
								statcolors = false,
								bossemote = false,
								quests = false,
								queststatusbartexture = "Asphyxia-Norm",
								questswowhead = false,
								professions = false,
								zones = false,
								shadows = false,
								meetinghorn = false,
								hideABkeypress = false,
								tbctalents = false,
								stealtheffect = false,
								blizzframes = {
									errorframe = true,
									errorframefontsize = 14,
									hideerrorframe = false,
									raidbossframe = true,
									raidbossframefontsize = 14,
								},
								instances = {
									enable = false,
									fontsize = 12,
									r = 0.90,
									g = 0.72,
									b = 0,
									DungeonNormal = "N.Dungeon",
									DungeonHeroic = "H.Dungeon",
									Raid = "Raid",
									MythicRaid = "Mythic Raid",
									RaidHeroic = "Heroic Raid",
									RaidLFR = "LFR",
									DungeonMythic = "Mythic 0",
									DungeonMythicPlus = "Mythic+",
									DungeonTimewalker = "TW.Dungeon",
									RaidTimewalker = "TW.Raid",
									guild = "Guild",
								},
								hidetalkinghead = false,
								playerdeath = false,
								playerdeathgta = false,
								playerdeathcustom = false,
								playerdeathcustomtext = "YOU DIED",
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.skins, data.ElvUI_EltreumUI.skins)
						end
						if data.ElvUI_EltreumUI.cursor then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursor, data.ElvUI_EltreumUI.cursor)
						elseif data.ElvUI_EltreumUI.cursor == nil then
							data.ElvUI_EltreumUI.cursor = {
								enable = false,
								ring = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga',
								size = '-1',
								cooldown = false,
								cooldownsound = false,
								cooldownfile = "! - Metal Gear Solid",
								petcooldown = false,
								fixlag = 1,
								combat = true,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursor, data.ElvUI_EltreumUI.cursor)
						end
						if data.ElvUI_EltreumUI.cursorcast then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorcast, data.ElvUI_EltreumUI.cursorcast)
						elseif data.ElvUI_EltreumUI.cursorcast == nil then
							data.ElvUI_EltreumUI.cursorcast = {
								radius = 25,
								sublayer = 1,
								thickness = 5,
								classcolor = true,
								r = 0.27,
								g = 0.50,
								b = 0.70,
								a = 1,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorcast, data.ElvUI_EltreumUI.cursorcast)
						end
						if data.ElvUI_EltreumUI.cursorgcd then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorgcd, data.ElvUI_EltreumUI.cursorgcd)
						elseif data.ElvUI_EltreumUI.cursorgcd == nil then
							data.ElvUI_EltreumUI.cursorgcd = {
								radius = 20,
								sublayer = 0,
								thickness = 5,
								classcolor = false,
								r = 1,
								g = 1,
								b = 1,
								a = 1,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorgcd, data.ElvUI_EltreumUI.cursorgcd)
						end
						if data.ElvUI_EltreumUI.cursorcursor then
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorcursor, data.ElvUI_EltreumUI.cursorcursor)
						elseif data.ElvUI_EltreumUI.cursorcursor == nil then
							data.ElvUI_EltreumUI.cursorcursor = {
								radius = 15,
								sublayer = 0,
								thickness = 5,
								combat = true,
								classcolor = false,
								r = 0.5,
								g = 0.5,
								b = 0.5,
								a = 1,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorcursor, data.ElvUI_EltreumUI.cursorcursor)
						end
						if data.ElvUI_EltreumUI.nameplateOptions then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions, data.ElvUI_EltreumUI.nameplateOptions)
						elseif data.ElvUI_EltreumUI.nameplateOptions == nil then
							data.ElvUI_EltreumUI.nameplateOptions = {
								ClassColorGlow = false,
								ClassBorderNameplate = false,
								nameplatetexture = false,
								classbarautohide = false,
								targetclasstexture = false,
								enableHealthHeight = false,
								outofcombatHeight = 4,
								incombatHeight = 14,
								useelvuinpheight = false,
								targetmodel = false,
								CamDistanceScale = 2,
								ViewTranslationx = 0,
								ViewTranslationy = 0,
								Rotation = 0,
								modelalpha = 0.5,
								desaturation = 0,
								paused = false,
								restedoverlap = false,
								hideSwipe = false,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions, data.ElvUI_EltreumUI.nameplateOptions)
						end
						if data.ElvUI_EltreumUI.nameplatelevel then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplatelevel, data.ElvUI_EltreumUI.nameplatelevel)
						elseif data.ElvUI_EltreumUI.nameplatelevel == nil then
							data.ElvUI_EltreumUI.nameplatelevel = {
								enable = false,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplatelevel, data.ElvUI_EltreumUI.nameplatelevel)
						end
						if data.ElvUI_EltreumUI.nptextureversion then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nptextureversion, data.ElvUI_EltreumUI.nptextureversion)
						elseif data.ElvUI_EltreumUI.nptextureversion == nil then
							E.db.ElvUI_EltreumUI.nameplates.nptextureversion = "V1"
							data.ElvUI_EltreumUI.nptextureversion = "V1"
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nptextureversion, data.ElvUI_EltreumUI.nptextureversion)
						end
						if data.ElvUI_EltreumUI.nameplatepower then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplatepower, data.ElvUI_EltreumUI.nameplatepower)
						elseif data.ElvUI_EltreumUI.nameplatepower == nil then
							data.ElvUI_EltreumUI.nameplatepower = {
								autoadjustposition = false,
								modeleffect = false,
								sizex = 131.8,
								sizey = 6,
								posy = 16,
								texture = "Eltreum-Elvui-Norm",
								font = "Kimberley",
								fontsize = 10,
								r = 0,
								g = 0,
								b = 0,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplatepower, data.ElvUI_EltreumUI.nameplatepower)
						end
						if data.ElvUI_EltreumUI.friendlynameplatetoggle then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle, data.ElvUI_EltreumUI.friendlynameplatetoggle)
						elseif data.ElvUI_EltreumUI.nameplatepower == nil then
							data.ElvUI_EltreumUI.friendlynameplatetoggle = {
								disablefriendly = false,
								friendlynames = false,
								hidefriendly = false,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle, data.ElvUI_EltreumUI.friendlynameplatetoggle)
						end
						if data.ElvUI_EltreumUI.widenameplate then
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.widenameplate, data.ElvUI_EltreumUI.widenameplate)
						elseif data.ElvUI_EltreumUI.widenameplate == nil then
							data.ElvUI_EltreumUI.widenameplate = {
								enable = false,
								npglow = false,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.widenameplate, data.ElvUI_EltreumUI.widenameplate)
						end
						if data.ElvUI_EltreumUI.glowcustomcolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolor, data.ElvUI_EltreumUI.glowcustomcolor)
						elseif data.ElvUI_EltreumUI.glowcustomcolor == nil then
							data.ElvUI_EltreumUI.glowcustomcolor = {
								r = 0.27,
								g = 0.50,
								b = 0.70,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolor, data.ElvUI_EltreumUI.glowcustomcolor)
						end

						if data.ElvUI_EltreumUI.glowcustomcolorpet then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet, data.ElvUI_EltreumUI.glowcustomcolorpet)
						elseif data.ElvUI_EltreumUI.glowcustomcolorpet == nil then
							data.ElvUI_EltreumUI.glowcustomcolorpet = {
								r = 0.27,
								g = 0.50,
								b = 0.70,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet, data.ElvUI_EltreumUI.glowcustomcolorpet)
						end
						if data.ElvUI_EltreumUI.glowcustomcolornp then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolornp, data.ElvUI_EltreumUI.glowcustomcolornp)
						elseif data.ElvUI_EltreumUI.glowcustomcolornp == nil then
							data.ElvUI_EltreumUI.glowcustomcolornp = {
								r = 0.27,
								g = 0.50,
								b = 0.70,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolornp, data.ElvUI_EltreumUI.glowcustomcolornp)
						end
						if data.ElvUI_EltreumUI.glowtotem1customcolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor, data.ElvUI_EltreumUI.glowtotem1customcolor)
						elseif data.ElvUI_EltreumUI.glowtotem1customcolor == nil then
							data.ElvUI_EltreumUI.glowtotem1customcolor = {
								r = 0.78,
								g = 0.43,
								b = 0.30,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor, data.ElvUI_EltreumUI.glowtotem1customcolor)
						end
						if data.ElvUI_EltreumUI.glowtotem2customcolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor, data.ElvUI_EltreumUI.glowtotem2customcolor)
						elseif data.ElvUI_EltreumUI.glowtotem2customcolor == nil then
							data.ElvUI_EltreumUI.glowtotem2customcolor = {
								r = 0.43,
								g = 0.65,
								b = 0.33,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor, data.ElvUI_EltreumUI.glowtotem2customcolor)
						end
						if data.ElvUI_EltreumUI.glowtotem3customcolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor, data.ElvUI_EltreumUI.glowtotem3customcolor)
						elseif data.ElvUI_EltreumUI.glowtotem3customcolor == nil then
							data.ElvUI_EltreumUI.glowtotem3customcolor = {
								r = 0.39,
								g = 0.68,
								b = 0.80,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor, data.ElvUI_EltreumUI.glowtotem3customcolor)
						end
						if data.ElvUI_EltreumUI.glowtotem4customcolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor, data.ElvUI_EltreumUI.glowtotem4customcolor)
						elseif data.ElvUI_EltreumUI.glowtotem4customcolor == nil then
							data.ElvUI_EltreumUI.glowtotem4customcolor = {
								r = 0.62,
								g = 0.38,
								b = 0.94,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor, data.ElvUI_EltreumUI.glowtotem4customcolor)
						end
						if data.ElvUI_EltreumUI.waypointetasetting then
							E:CopyTable(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting, data.ElvUI_EltreumUI.waypointetasetting)
						elseif data.ElvUI_EltreumUI.waypointetasetting == nil then
							data.ElvUI_EltreumUI.waypointetasetting = {
									enable = false,
									autopin = false,
									limitmaxdistance = false,
									distance = 700,
									textcolorR = 1,
									textcolorG = 1,
									textcolorB = 1,
								}
							E:CopyTable(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting, data.ElvUI_EltreumUI.waypointetasetting)
						end
						if data.ElvUI_EltreumUI.waytext then
							E:CopyTable(E.db.ElvUI_EltreumUI.waypoints.waytext, data.ElvUI_EltreumUI.waytext)
						elseif data.ElvUI_EltreumUI.waytext == nil then
							data.ElvUI_EltreumUI.waytext = {
									enable = false,
								}
							E:CopyTable(E.db.ElvUI_EltreumUI.waypoints.waytext, data.ElvUI_EltreumUI.waytext)
						end
						if data.ElvUI_EltreumUI.dynamicdatatext then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext, data.ElvUI_EltreumUI.dynamicdatatext)
						elseif data.ElvUI_EltreumUI.dynamicdatatext == nil then
							data.ElvUI_EltreumUI.dynamicdatatext = {
									enable = false,
								}
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext, data.ElvUI_EltreumUI.dynamicdatatext)
						end
						if data.ElvUI_EltreumUI.partyraiddeath then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath, data.ElvUI_EltreumUI.partyraiddeath)
						elseif data.ElvUI_EltreumUI.partyraiddeath == nil then
							data.ElvUI_EltreumUI.partyraiddeath = {
								enable = false,
								bgdisable = false,
								playerdeathsound = "bruh",
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath, data.ElvUI_EltreumUI.partyraiddeath)
						end
						if data.ElvUI_EltreumUI.afkmusic then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.afkmusic, data.ElvUI_EltreumUI.afkmusic)
						elseif data.ElvUI_EltreumUI.afkmusic == nil then
							data.ElvUI_EltreumUI.afkmusic = {
								enable = false,
								racial = true,
								playerclass = false,
							},
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.afkmusic, data.ElvUI_EltreumUI.afkmusic)
						end
						if data.ElvUI_EltreumUI.fonts then
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fonts, data.ElvUI_EltreumUI.fonts)
						elseif data.ElvUI_EltreumUI.afkmusic == nil then
							data.ElvUI_EltreumUI.fonts = {
								playerfont = "Kimberley"
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fonts, data.ElvUI_EltreumUI.fonts)
						end
						if data.ElvUI_EltreumUI.loottext then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.loottext, data.ElvUI_EltreumUI.loottext)
						elseif data.ElvUI_EltreumUI.loottext == nil then
							data.ElvUI_EltreumUI.loottext = {
								enable = false,
								honor = true,
								currency = true,
								pet = true,
								scale = 0.65,
								strata = "BACKGROUND",
								xOffset = 0,
								yOffset = 200,
								fontsetting = true,
								fontsettingdmg = false,
								combatindicator = false,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.loottext, data.ElvUI_EltreumUI.loottext)
						end
						if data.ElvUI_EltreumUI.otherstuff.fastloot then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
						elseif data.ElvUI_EltreumUI.otherstuff.fastloot == nil then
							data.ElvUI_EltreumUI.otherstuff.fastloot = false
							E.db.ElvUI_EltreumUI.loot.fastloot = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
						end
						if data.ElvUI_EltreumUI.otherstuff.fastlootfilter then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastlootfilter, data.ElvUI_EltreumUI.otherstuff.fastlootfilter)
						elseif data.ElvUI_EltreumUI.otherstuff.fastlootfilter == nil then
							data.ElvUI_EltreumUI.otherstuff.fastlootfilter = false
							E.db.ElvUI_EltreumUI.loot.fastlootfilter = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastlootfilter, data.ElvUI_EltreumUI.otherstuff.fastlootfilter)
						end
						if data.ElvUI_EltreumUI.otherstuff.fastlootquality then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastlootquality, data.ElvUI_EltreumUI.otherstuff.fastlootquality)
						elseif data.ElvUI_EltreumUI.otherstuff.fastlootquality == nil then
							data.ElvUI_EltreumUI.otherstuff.fastlootquality = false
							E.db.ElvUI_EltreumUI.loot.fastlootquality = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastlootquality, data.ElvUI_EltreumUI.otherstuff.fastlootquality)
						end
						if data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistwarning, data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning)
						elseif data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning == nil then
							data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning = false
							E.db.ElvUI_EltreumUI.loot.lootwishlistwarning = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistwarning, data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning)
						end
						if data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistfilter, data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter)
						elseif data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter == nil then
							data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter = false
							E.db.ElvUI_EltreumUI.loot.lootwishlistfilter = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistfilter, data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter)
						end
						if data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot, data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot)
						elseif data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot == nil then
							data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot = false
							E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot, data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot)
						end
						if data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable, data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable)
						elseif data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable == nil then
							data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable = false
							E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable, data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable)
						end
						if data.ElvUI_EltreumUI.otherstuff.lootautoclose then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootautoclose, data.ElvUI_EltreumUI.otherstuff.lootautoclose)
						elseif data.ElvUI_EltreumUI.otherstuff.lootautoclose == nil then
							data.ElvUI_EltreumUI.otherstuff.lootautoclose = false
							E.db.ElvUI_EltreumUI.loot.lootautoclose = false
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootautoclose, data.ElvUI_EltreumUI.otherstuff.lootautoclose)
						end
						if data.ElvUI_EltreumUI.otherstuff.lootwishlistsound then
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistsound, data.ElvUI_EltreumUI.otherstuff.lootwishlistsound)
						elseif data.ElvUI_EltreumUI.otherstuff.lootwishlistsound == nil then
							data.ElvUI_EltreumUI.otherstuff.lootwishlistsound = "Warcraft 3 - Rokhan Be Happy"
							E.db.ElvUI_EltreumUI.loot.lootwishlistsound = "Warcraft 3 - Rokhan Be Happy"
							E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistsound, data.ElvUI_EltreumUI.otherstuff.lootwishlistsound)
						end
						if data.ElvUI_EltreumUI.UFmodifications then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.UFmodifications, data.ElvUI_EltreumUI.UFmodifications)
						elseif data.ElvUI_EltreumUI.UFmodifications == nil then
							data.ElvUI_EltreumUI.UFmodifications = true
							E.db.ElvUI_EltreumUI.unitframes.UFmodifications = true
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.UFmodifications, data.ElvUI_EltreumUI.UFmodifications)
						end
						if data.ElvUI_EltreumUI.UForientation then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.UForientation, data.ElvUI_EltreumUI.UForientation)
						elseif data.ElvUI_EltreumUI.UForientation == nil then
							data.ElvUI_EltreumUI.UForientation = "HORIZONTAL"
							E.db.ElvUI_EltreumUI.unitframes.UForientation = "HORIZONTAL"
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.UForientation, data.ElvUI_EltreumUI.UForientation)
						end
						if data.ElvUI_EltreumUI.uftextureversion then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.uftextureversion, data.ElvUI_EltreumUI.uftextureversion)
						elseif data.ElvUI_EltreumUI.uftextureversion == nil then
							data.ElvUI_EltreumUI.uftextureversion = "V1"
							E.db.ElvUI_EltreumUI.unitframes.uftextureversion = "V1"
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.uftextureversion, data.ElvUI_EltreumUI.uftextureversion)
						end
						--dark mode/light mode is special
						if data.ElvUI_EltreumUI.darkmode and data.ElvUI_EltreumUI.lightmode then
							data.ElvUI_EltreumUI.lightmode = false
							E.db.ElvUI_EltreumUI.unitframes.lightmode = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.lightmode, data.ElvUI_EltreumUI.lightmode)
							data.ElvUI_EltreumUI.darkmode = true
							E.db.ElvUI_EltreumUI.unitframes.darkmode = true
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkmode, data.ElvUI_EltreumUI.darkmode)
						elseif data.ElvUI_EltreumUI.lightmode and not data.ElvUI_EltreumUI.darkmode then
							data.ElvUI_EltreumUI.lightmode = true
							E.db.ElvUI_EltreumUI.unitframes.lightmode = true
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.lightmode, data.ElvUI_EltreumUI.lightmode)
							data.ElvUI_EltreumUI.darkmode = false
							E.db.ElvUI_EltreumUI.unitframes.darkmode = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkmode, data.ElvUI_EltreumUI.darkmode)
						elseif data.ElvUI_EltreumUI.darkmode and not data.ElvUI_EltreumUI.lightmode then
							data.ElvUI_EltreumUI.lightmode = false
							E.db.ElvUI_EltreumUI.unitframes.lightmode = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.lightmode, data.ElvUI_EltreumUI.lightmode)
							data.ElvUI_EltreumUI.darkmode = true
							E.db.ElvUI_EltreumUI.unitframes.darkmode = true
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkmode, data.ElvUI_EltreumUI.darkmode)
						end
						if data.ElvUI_EltreumUI.darkpowercolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkpowercolor, data.ElvUI_EltreumUI.darkpowercolor)
						elseif data.ElvUI_EltreumUI.darkpowercolor == nil then
							data.ElvUI_EltreumUI.darkpowercolor = false
							E.db.ElvUI_EltreumUI.unitframes.darkpowercolor = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkpowercolor, data.ElvUI_EltreumUI.darkpowercolor)
						end
						if data.ElvUI_EltreumUI.greybackground then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.greybackground, data.ElvUI_EltreumUI.greybackground)
						elseif data.ElvUI_EltreumUI.greybackground == nil then
							data.ElvUI_EltreumUI.greybackground = false
							E.db.ElvUI_EltreumUI.unitframes.greybackground = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.greybackground, data.ElvUI_EltreumUI.greybackground)
						end
						if data.ElvUI_EltreumUI.gradientmode then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.gradientmode, data.ElvUI_EltreumUI.gradientmode)
						elseif data.ElvUI_EltreumUI.gradientmode == nil then
							data.ElvUI_EltreumUI.gradientmode = {
								enable = false,

								orientation = "HORIZONTAL",
								texture = "Eltreum-Blank",
								customcolor = false,

								classcolorplayercastbar = false,
								classcolortargetcastbar = false,

								gradientXP = false,

								enableplayer = true,
								enabletarget = true,
								enabletargettarget = true,
								enabletargettargettarget = true,
								enablefocus = true,
								enableboss = true,
								enablearena = true,
								enablegroupunits = true,

								--extra for new function
								enablepet = true,
								enablearena1 = true,
								enablearena2 = true,
								enablearena3 = true,
								enablearena4 = true,
								enablearena5 = true,
								enableboss1 = true,
								enableboss2 = true,
								enableboss3 = true,
								enableboss4 = true,
								enableboss5 = true,
								enableboss6 = true,
								enableboss7 = true,
								enableboss8 = true,

								enableplayercastbar = false,
								enableplayercastbarnoninterruptible = false,
								enableplayercastbarinterrupted = false,

								playercastbarR1 = 0,
								playercastbarR2 = 0.67,
								playercastbarG1 = 0.6,
								playercastbarG2 = 0.94,
								playercastbarB1 = 1,
								playercastbarB2 = 1,

								playercastbarR1noninterruptible = 1,
								playercastbarR2noninterruptible = 1,
								playercastbarB1noninterruptible = 0,
								playercastbarB2noninterruptible = 0,
								playercastbarG1noninterruptible = 0,
								playercastbarG2noninterruptible = 0.19607843137255,

								playercastbarR1noninterruptiblecustom = 1,
								playercastbarR2noninterruptiblecustom = 1,
								playercastbarB1noninterruptiblecustom = 0,
								playercastbarB2noninterruptiblecustom = 0.29019607843137,
								playercastbarG1noninterruptiblecustom = 0.34901960784314,
								playercastbarG2noninterruptiblecustom = 0,

								playercastbarR1interrupted = 0.6,
								playercastbarR2interrupted = 0.2,
								playercastbarB1interrupted = 0.6,
								playercastbarB2interrupted = 0.2,
								playercastbarG1interrupted = 0.6,
								playercastbarG2interrupted = 0.2,

								playercastbarR1interruptedcustom = 0.6,
								playercastbarR2interruptedcustom = 0.2,
								playercastbarB1interruptedcustom = 0.6,
								playercastbarB2interruptedcustom = 0.2,
								playercastbarG1interruptedcustom = 0.6,
								playercastbarG2interruptedcustom = 0.2,

								enabletargetcastbar = false,
								enabletargetcastbarnoninterruptible = false,
								enabletargetcastbarinterrupted = false,

								targetcastbarR1 = 0,
								targetcastbarR2 = 0.67,
								targetcastbarG1 = 0.6,
								targetcastbarG2 = 0.94,
								targetcastbarB1 = 1,
								targetcastbarB2 = 1,

								targetcastbarR1custom = 0,
								targetcastbarR2custom = 0.67,
								targetcastbarG1custom = 0.6,
								targetcastbarG2custom = 0.94,
								targetcastbarB1custom = 1,
								targetcastbarB2custom = 1,

								targetcastbarR1noninterruptible = 1,
								targetcastbarR2noninterruptible = 1,
								targetcastbarB1noninterruptible = 0,
								targetcastbarB2noninterruptible = 0,
								targetcastbarG1noninterruptible = 0,
								targetcastbarG2noninterruptible = 0.19607843137255,

								targetcastbarR1noninterruptiblecustom = 1,
								targetcastbarR2noninterruptiblecustom = 1,
								targetcastbarB1noninterruptiblecustom = 0,
								targetcastbarB2noninterruptiblecustom = 0.29019607843137,
								targetcastbarG1noninterruptiblecustom = 0.34901960784314,
								targetcastbarG2noninterruptiblecustom = 0,

								targetcastbarR1interrupted = 0.6,
								targetcastbarR2interrupted = 0.2,
								targetcastbarB1interrupted = 0.6,
								targetcastbarB2interrupted = 0.2,
								targetcastbarG1interrupted = 0.6,
								targetcastbarG2interrupted = 0.2,

								targetcastbarR1interruptedcustom = 0.6,
								targetcastbarR2interruptedcustom = 0.2,
								targetcastbarB1interruptedcustom = 0.6,
								targetcastbarB2interruptedcustom = 0.2,
								targetcastbarG1interruptedcustom = 0.6,
								targetcastbarG2interruptedcustom = 0.2,

								druidcustomcolorR1 = 1,
								druidcustomcolorR2 = 1,
								druidcustomcolorG1 = 0.23921568627451,
								druidcustomcolorG2 = 0.48627450980392,
								druidcustomcolorB1 = 0.007843137254902,
								druidcustomcolorB2 = 0.03921568627451,

								--[[huntercustomcolorR1 = 0.45490196078431,
								huntercustomcolorR2 = 0.43921568627451,
								huntercustomcolorG1 = 0.59607843137255,
								huntercustomcolorG2 = 0.87843137254902,
								huntercustomcolorB1 = 0.25490196078431,
								huntercustomcolorB2 = 0,]]

								huntercustomcolorR1 = 0.40392156862745,
								huntercustomcolorR2 = 0.67058823529412,
								huntercustomcolorG1 = 0.53725490196078,
								huntercustomcolorG2 = 0.92941176470588,
								huntercustomcolorB1 = 0.22352941176471,
								huntercustomcolorB2 = 0.30980392156863,

								paladincustomcolorR1 = 1,
								paladincustomcolorR2 = 0.95686274509804,
								paladincustomcolorG1 = 0.26666666666667,
								paladincustomcolorG2 = 0.54901960784314,
								paladincustomcolorB1 = 0.53725490196078,
								paladincustomcolorB2 = 0.72941176470588,

								magecustomcolorR1 = 0,
								magecustomcolorR2 = 0.49019607843137,
								magecustomcolorG1 = 0.33333333333333,
								magecustomcolorG2 = 0.87058823529412,
								magecustomcolorB1 = 0.53725490196078,
								magecustomcolorB2 = 1,

								roguecustomcolorR1 = 1,
								roguecustomcolorR2 = 1,
								roguecustomcolorG1 = 0.68627450980392,
								roguecustomcolorG2 = 0.83137254901961,
								roguecustomcolorB1 = 0,
								roguecustomcolorB2 = 0.25490196078431,

								priestcustomcolorR1 = 0.3568627450980392,
								priestcustomcolorR2 = 0.98823529411765,
								priestcustomcolorG1 = 0.3568627450980392,
								priestcustomcolorG2 = 0.98823529411765,
								priestcustomcolorB1 = 0.3568627450980392,
								priestcustomcolorB2 = 0.98823529411765,

								deathknightcustomcolorR1 = 0.49803921568627,
								deathknightcustomcolorR2 = 1,
								deathknightcustomcolorG1 = 0.074509803921569,
								deathknightcustomcolorG2= 0.1843137254902,
								deathknightcustomcolorB1 = 0.14901960784314,
								deathknightcustomcolorB2 = 0.23921568627451,

								demonhuntercustomcolorR1 = 0.36470588235294,
								demonhuntercustomcolorR2 = 0.74509803921569,
								demonhuntercustomcolorG1 = 0.13725490196078,
								demonhuntercustomcolorG2 = 0.1921568627451,
								demonhuntercustomcolorB1 = 0.57254901960784,
								demonhuntercustomcolorB2 = 1,

								shamancustomcolorR1 = 0,
								shamancustomcolorR2 = 0,
								shamancustomcolorG1 = 0.25882352941176,
								shamancustomcolorG2 = 0.43921568627451,
								shamancustomcolorB1 = 0.50980392156863,
								shamancustomcolorB2 = 0.87058823529412,

								warlockcustomcolorR1 = 0.26274509803922,
								warlockcustomcolorR2 = 0.66274509803922,
								warlockcustomcolorG1 = 0.26666666666667,
								warlockcustomcolorG2 = 0.3921568627451,
								warlockcustomcolorB1 = 0.46666666666667,
								warlockcustomcolorB2 = 0.7843137254902,

								warriorcustomcolorR1 = 0.42745098039216,
								warriorcustomcolorR2 = 0.56470588235294,
								warriorcustomcolorG1 = 0.13725490196078,
								warriorcustomcolorG2 = 0.43137254901961,
								warriorcustomcolorB1 = 0.090196078431373,
								warriorcustomcolorB2 = 0.24705882352941,

								--[[
								monkcustomcolorR1 = 0,
								monkcustomcolorR2 = 0,
								monkcustomcolorG1 = 0.77254901960784,
								monkcustomcolorG2 = 0.76078431372549,
								monkcustomcolorB1 = 0.45882352941176,
								monkcustomcolorB2 = 0.24313725490196,]]

								monkcustomcolorR1 = 0.015686274509804,
								monkcustomcolorR2 = 0,
								monkcustomcolorG1 = 0.6078431372549,
								monkcustomcolorG2 = 1,
								monkcustomcolorB1 = 0.36862745098039,
								monkcustomcolorB2 = 0.58823529411765,

								npcfriendlyR1 = 0.30980392156863,
								npcfriendlyR2 = 0.34117647058824,
								npcfriendlyG1 = 0.85098039215686,
								npcfriendlyG2 = 0.62745098039216,
								npcfriendlyB1 = 0.2,
								npcfriendlyB2 = 0.4078431372549,

								npcneutralR1 = 0.8156862745098,
								npcneutralG1 = 1,
								npcneutralB1 = 0,
								npcneutralR2 = 1,
								npcneutralG2 = 0.85882352941176,
								npcneutralB2 = 0.2078431372549,

								npcunfriendlyR1 = 0.84313725490196,
								npcunfriendlyG1 = 0.30196078431373,
								npcunfriendlyB1 = 0,
								npcunfriendlyR2 = 0.83137254901961,
								npcunfriendlyG2 = 0.45882352941176,
								npcunfriendlyB2 = 0,

								npchostileR1 = 1,
								npchostileR2 = 1,
								npchostileG1 = 0.090196078431373,
								npchostileG2 = 0,
								npchostileB1 = 0,
								npchostileB2 = 0.54901960784314,

								--threat stuff for np
								npenable = false,
								nporientation = "VERTICAL",
								npcustomcolor = false,

								goodthreatR1 = 0.27843075990677,
								goodthreatR2 = 0.95294117647059,
								goodthreatG1 = 1,
								goodthreatG2 = 0.99999779462814,
								goodthreatB1 = 0,
								goodthreatB2 = 0,

								badthreatR1 = 1,
								badthreatR2 = 0.82352941176471,
								badthreatG1 = 0.17647058823529,
								badthreatG2 = 0,
								badthreatB1 = 0.17647058823529,
								badthreatB2 = 0.34901960784314,

								goodthreattransitionR1 = 1,
								goodthreattransitionR2 = 1,
								goodthreattransitionG1 = 0.99607843137255,
								goodthreattransitionG2 = 0.73333333333333,
								goodthreattransitionB1 = 0.2,
								goodthreattransitionB2 = 0,

								badthreattransitionR1 = 1,
								badthreattransitionR2 = 1,
								badthreattransitionG1 = 0.3921568627451,
								badthreattransitionG2 = 0.9843137254902,
								badthreattransitionB1 = 0.2,
								badthreattransitionB2 = 0,

								offtankR1 = 0.72941176470588,
								offtankR2 = 0.34117647058824,
								offtankG1 = 0.2,
								offtankG2 = 0,
								offtankB1 = 1,
								offtankB2 = 1,

								badthreattransitionofftankR1 = 0.70980392156863,
								badthreattransitionofftankG1 = 0.43137254901961,
								badthreattransitionofftankB1 = 0.27058823529412,
								badthreattransitionofftankR2 = 0.90196078431373,
								badthreattransitionofftankG2 = 0.15294117647059,
								badthreattransitionofftankB2 = 0,

								goodthreattransitionofftankR1 = 0.30980392156863,
								goodthreattransitionofftankR2 = 0,
								goodthreattransitionofftankG1 = 0.45098039215686,
								goodthreattransitionofftankG2 = 1,
								goodthreattransitionofftankB1 = 0.63137254901961,
								goodthreattransitionofftankB2 = 0.70980392156863,

								tappedR1 = 1,
								tappedG1 = 1,
								tappedB1 = 1,
								tappedR2 = 0,
								tappedG2 = 0,
								tappedB2 = 0,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.gradientmode, data.ElvUI_EltreumUI.gradientmode)
						end
						if data.ElvUI_EltreumUI.ufcustomtexture then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture, data.ElvUI_EltreumUI.ufcustomtexture)
						elseif data.ElvUI_EltreumUI.ufcustomtexture == nil then
							data.ElvUI_EltreumUI.ufcustomtexture = {
								enable = false,
								classdetect = false,
								castbartexture = "Eltreum-Blank",
								backdroptexture = "Eltreum-Blank",
								backdropalpha = 1,
								backdrophidden = false,
								targettexture = "Eltreum-Blank",
								playertexture = "Eltreum-Blank",
								targettargettexture = "Eltreum-Blank",

								targettargettargettexture = "Eltreum-Blank",

								focustexture = "Eltreum-Blank",
								deathknighttexture = "Eltreum-Class-DeathKnight",
								demonhuntertexture = "Eltreum-Class-DemonHunter",
								druidtexture = "Eltreum-Class-Druid",
								huntertexture = "Eltreum-Class-Hunter",
								magetexture = "Eltreum-Class-Mage",
								monktexture = "Eltreum-Class-Monk",
								paladintexture = "Eltreum-Class-Paladin",
								priesttexture = "Eltreum-Class-Priest",
								roguetexture = "Eltreum-Class-Rogue",
								shamantexture = "Eltreum-Class-Shaman",
								warlocktexture = "Eltreum-Class-Warlock",
								warriortexture = "Eltreum-Class-Warrior",
								npcfriendly = "Eltreum-Class-Hunter",
								npcneutral = "Eltreum-Class-Rogue",
								npcunfriendly = "Eltreum-Class-Druid",
								npchostile = "Eltreum-Class-DeathKnight",
								tappedtexture = "Eltreum-Tapped",
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture, data.ElvUI_EltreumUI.ufcustomtexture)
						end
						if data.ElvUI_EltreumUI.sparkcustomcolor then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor, data.ElvUI_EltreumUI.sparkcustomcolor)
						elseif data.ElvUI_EltreumUI.sparkcustomcolor == nil then
							data.ElvUI_EltreumUI.sparkcustomcolor ={
								enable = false,
								texture = 'Eltreum-Blank',
								--texture = 'Eltreum-Fade',
								r = 0.80,
								g = 0.80,
								b = 0.10,
								a = 1,
								--width = 20,
								width = 3,
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor, data.ElvUI_EltreumUI.sparkcustomcolor)
						end
						if data.ElvUI_EltreumUI.models then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.models, data.ElvUI_EltreumUI.models)
						elseif data.ElvUI_EltreumUI.models == nil then
							data.ElvUI_EltreumUI.models = {
								castbar = false,
								unitframe = false,
								ufalpha = 0.3,
								ufalphadark = 0.3,
								ufdesaturation = 0,
								modeltype = "CLASS",
								custommodel = 165575,
								custommodelclassic = "spells/arcanebreath.m2",
								modeltypecast = "DEFAULT",
								custommodelcast = 165821,
								custommodelclassiccast = "spells/corruption_impactdot_med_base.m2",
							}
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.models, data.ElvUI_EltreumUI.models)
						end
						if data.ElvUI_EltreumUI.otherstuff.arenabuffs then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.arenabuffs, data.ElvUI_EltreumUI.otherstuff.arenabuffs)
						elseif data.ElvUI_EltreumUI.otherstuff.arenabuffs == nil then
							data.ElvUI_EltreumUI.otherstuff.arenabuffs = false
							E.db.ElvUI_EltreumUI.unitframes.arenabuffs = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.arenabuffs, data.ElvUI_EltreumUI.otherstuff.arenabuffs)
						end
						if data.ElvUI_EltreumUI.otherstuff.bgunitframes then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.bgunitframes, data.ElvUI_EltreumUI.otherstuff.bgunitframes)
						elseif data.ElvUI_EltreumUI.otherstuff.bgunitframes == nil then
							data.ElvUI_EltreumUI.otherstuff.bgunitframes = false
							E.db.ElvUI_EltreumUI.unitframes.bgunitframes = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.bgunitframes, data.ElvUI_EltreumUI.otherstuff.bgunitframes)
						end
						if data.ElvUI_EltreumUI.otherstuff.arenaunitframes then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.arenaunitframes, data.ElvUI_EltreumUI.otherstuff.arenaunitframes)
						elseif data.ElvUI_EltreumUI.otherstuff.arenaunitframes == nil then
							data.ElvUI_EltreumUI.otherstuff.arenaunitframes = false
							E.db.ElvUI_EltreumUI.unitframes.arenaunitframes = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.arenaunitframes, data.ElvUI_EltreumUI.otherstuff.arenaunitframes)
						end
						if data.ElvUI_EltreumUI.otherstuff.portraitfix then
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.portraitfix, data.ElvUI_EltreumUI.otherstuff.portraitfix)
						elseif data.ElvUI_EltreumUI.otherstuff.portraitfix == nil then
							data.ElvUI_EltreumUI.otherstuff.portraitfix = false
							E.db.ElvUI_EltreumUI.unitframes.portraitfix = false
							E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.portraitfix, data.ElvUI_EltreumUI.otherstuff.portraitfix)
						end

						profileChanged = true
					end
					if profileChanged then
						if ProfileNames == "NONE" then
							ProfileNames = profile
						else
							ProfileNames = ProfileNames..', '..profile
						end
					end
				end
			end
			E:StaticPopup_Show('ELTRUISMDBCONVERT', ProfileNames, CharacterNames)
			E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
		end
	end
end
