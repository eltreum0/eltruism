local E, L = unpack(ElvUI)
local _G = _G
local pairs = _G.pairs

--Based on ElvUI's and SLE's db convert
function ElvUI_EltreumUI:DatabaseConversions(forced)
	if E.private.ElvUI_EltreumUI.install_version ~= nil then
		E.PopupDialogs["ELTRUISMDBCONVERT"] = {
			text = L["Eltruism database was converted.\n|cff82B4ffThe Following profiles were updated:|r\n%s\n\n|cff82B4ffPrivate settings were updated for the following private profiles:|r\n%s\n\n|cff82B4ffIf you have any issues please report in Discord or open a ticket.|r\n|cffff0000A Reload is necessary to save this conversion and fix variables|r"],
			OnAccept = ReloadUI,
			button1 = ACCEPT,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}
		local NONE = _G.NONE

		if E.private.ElvUI_EltreumUI.install_version < "3.7.5" or forced then
			--making sure it only runs on the current char's profile
			local currentprofile
			if ElvDB.profileKeys[E.mynameRealm] then
				currentprofile = ElvDB.profileKeys[E.mynameRealm]
			else
				currentprofile = false
			end
			local ProfileNames = NONE
			local CharacterNames = NONE
			for profile, data in pairs(ElvDB.profiles) do
				local profileChanged = false
				if profile == currentprofile then
					if data then
						if data.ElvUI_EltreumUI then
							if data.ElvUI_EltreumUI.nameplates then
								if data.ElvUI_EltreumUI.nameplates.widenameplate then
									if data.ElvUI_EltreumUI.nameplates.widenameplate.enable then
										E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.timerposition = data.ElvUI_EltreumUI.nameplates.widenameplate.enable
										E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.timerposition, data.ElvUI_EltreumUI.nameplates.widenameplate.enable)
										profileChanged = true
									end
									if data.ElvUI_EltreumUI.nameplates.widenameplate.npglow then
										E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow = data.ElvUI_EltreumUI.nameplates.widenameplate.npglow
										E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow, data.ElvUI_EltreumUI.nameplates.widenameplate.npglow)
										profileChanged = true
									end
									data.ElvUI_EltreumUI.nameplates.widenameplate = nil
								end
							end
							if data.ElvUI_EltreumUI.shadows then
								local temp = data.ElvUI_EltreumUI.skins.shadows
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.shadow, data.ElvUI_EltreumUI.shadows)
								E.db.ElvUI_EltreumUI.skins.shadow.enable = temp
								data.ElvUI_EltreumUI.shadows = nil
								data.ElvUI_EltreumUI.skins.shadows = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.skins then
								if db.ElvUI_EltreumUI.skins.classiconsblizz then
									db.ElvUI_EltreumUI.skins.classiconsblizz = nil
									db.ElvUI_EltreumUI.skins.classiconsstyle = "BLIZZARD"
								end
								if db.ElvUI_EltreumUI.skins.classiconsreleaf then
									db.ElvUI_EltreumUI.skins.classiconsreleaf = nil
									db.ElvUI_EltreumUI.skins.classiconsstyle = "RELEAF"
								end
							end
							if data.ElvUI_EltreumUI.instances then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.instances, data.ElvUI_EltreumUI.instances)
								data.ElvUI_EltreumUI.instances = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.blizzframes then
								E:CopyTable(E.db.ElvUI_EltreumUI.skins.blizzframes, data.ElvUI_EltreumUI.blizzframes)
								data.ElvUI_EltreumUI.blizzframes = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.cursor then
								E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursor, data.ElvUI_EltreumUI.cursor)
								data.ElvUI_EltreumUI.cursor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.cursorcast then
								E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorcast, data.ElvUI_EltreumUI.cursorcast)
								data.ElvUI_EltreumUI.cursorcast = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.cursorgcd then
								E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorgcd, data.ElvUI_EltreumUI.cursorgcd)
								data.ElvUI_EltreumUI.cursorgcd = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.cursorcursor then
								E:CopyTable(E.db.ElvUI_EltreumUI.cursors.cursorcursor, data.ElvUI_EltreumUI.cursorcursor)
								data.ElvUI_EltreumUI.cursorcursor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.nameplateOptions then
								E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions, data.ElvUI_EltreumUI.nameplateOptions)
								data.ElvUI_EltreumUI.nameplateOptions = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.nameplatelevel then
								E.db.ElvUI_EltreumUI.nameplates.nameplatelevel = data.ElvUI_EltreumUI.nameplatelevel
								E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplatelevel, data.ElvUI_EltreumUI.nameplatelevel)
								data.ElvUI_EltreumUI.nameplatelevel = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.nptextureversion then
								E.db.ElvUI_EltreumUI.nameplates.nptextureversion = data.ElvUI_EltreumUI.nptextureversion
								E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nptextureversion, data.ElvUI_EltreumUI.nptextureversion)
								data.ElvUI_EltreumUI.nptextureversion = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.nameplatepower then
								E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.nameplatepower, data.ElvUI_EltreumUI.nameplatepower)
								data.ElvUI_EltreumUI.nameplatepower = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.friendlynameplatetoggle then
								E:CopyTable(E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle, data.ElvUI_EltreumUI.friendlynameplatetoggle)
								data.ElvUI_EltreumUI.friendlynameplatetoggle = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.glowcustomcolor then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolor, data.ElvUI_EltreumUI.glowcustomcolor)
								data.ElvUI_EltreumUI.glowcustomcolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.tbctalents then
								if data.ElvUI_EltreumUI.tbctalents.enable then
									E.db.ElvUI_EltreumUI.skins.tbctalents = data.ElvUI_EltreumUI.tbctalents.enable
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.tbctalents, data.ElvUI_EltreumUI.tbctalents.enable)
									data.ElvUI_EltreumUI.tbctalents = nil
									profileChanged = true
								end
							end
							if data.ElvUI_EltreumUI.stealthOptions then
								if data.ElvUI_EltreumUI.stealthOptions.stealtheffect then
									E.db.ElvUI_EltreumUI.skins.stealtheffect = data.ElvUI_EltreumUI.stealthOptions.stealtheffect
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.stealtheffect, data.ElvUI_EltreumUI.stealthOptions.stealtheffect)
									data.ElvUI_EltreumUI.stealthOptions = nil
									profileChanged = true
								end
							end
							if data.ElvUI_EltreumUI.glowcustomcolorpet then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolorpet, data.ElvUI_EltreumUI.glowcustomcolorpet)
								data.ElvUI_EltreumUI.glowcustomcolorpet = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.glowcustomcolornp then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowcustomcolornp, data.ElvUI_EltreumUI.glowcustomcolornp)
								data.ElvUI_EltreumUI.glowcustomcolornp = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.glowtotem1customcolor then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem1customcolor, data.ElvUI_EltreumUI.glowtotem1customcolor)
								data.ElvUI_EltreumUI.glowtotem1customcolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.glowtotem2customcolor then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem2customcolor, data.ElvUI_EltreumUI.glowtotem2customcolor)
								data.ElvUI_EltreumUI.glowtotem2customcolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.glowtotem3customcolor then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem3customcolor, data.ElvUI_EltreumUI.glowtotem3customcolor)
								data.ElvUI_EltreumUI.glowtotem3customcolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.glowtotem4customcolor then
								E:CopyTable(E.db.ElvUI_EltreumUI.glow.glowtotem4customcolor, data.ElvUI_EltreumUI.glowtotem4customcolor)
								data.ElvUI_EltreumUI.glowtotem4customcolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.waypointetasetting then
								E:CopyTable(E.db.ElvUI_EltreumUI.waypoints.waypointetasetting, data.ElvUI_EltreumUI.waypointetasetting)
								data.ElvUI_EltreumUI.waypointetasetting = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.waytext then
								E:CopyTable(E.db.ElvUI_EltreumUI.waypoints.waytext, data.ElvUI_EltreumUI.waytext)
								data.ElvUI_EltreumUI.waytext = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.dynamicdatatext then
								E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext = data.ElvUI_EltreumUI.dynamicdatatext
								E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext, data.ElvUI_EltreumUI.dynamicdatatext)
								data.ElvUI_EltreumUI.dynamicdatatext = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.partyraiddeath then
								E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath, data.ElvUI_EltreumUI.partyraiddeath)
								data.ElvUI_EltreumUI.partyraiddeath = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.afkmusic then
								E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.afkmusic, data.ElvUI_EltreumUI.afkmusic)
								data.ElvUI_EltreumUI.afkmusic = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.fonts then
								E:CopyTable(E.db.ElvUI_EltreumUI.otherstuff.fonts, data.ElvUI_EltreumUI.fonts)
								data.ElvUI_EltreumUI.fonts = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.loottext then
								E:CopyTable(E.db.ElvUI_EltreumUI.loot.loottext, data.ElvUI_EltreumUI.loottext)
								data.ElvUI_EltreumUI.loottext = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.otherstuff then
								if data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext then
									E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext = data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext, data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext)
									data.ElvUI_EltreumUI.otherstuff.playerdeathcustomtext = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.playerdeath then
									E.db.ElvUI_EltreumUI.skins.playerdeath = data.ElvUI_EltreumUI.otherstuff.playerdeath
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeath, data.ElvUI_EltreumUI.otherstuff.playerdeath)
									data.ElvUI_EltreumUI.otherstuff.playerdeath = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.playerdeathgta then
									E.db.ElvUI_EltreumUI.skins.playerdeathgta = data.ElvUI_EltreumUI.otherstuff.playerdeathgta
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathgta, data.ElvUI_EltreumUI.otherstuff.playerdeathgta)
									data.ElvUI_EltreumUI.otherstuff.playerdeathgta = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.playerdeathcustom then
									E.db.ElvUI_EltreumUI.skins.playerdeathcustom = data.ElvUI_EltreumUI.otherstuff.playerdeathcustom
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.playerdeathcustom, data.ElvUI_EltreumUI.otherstuff.playerdeathcustom)
									data.ElvUI_EltreumUI.otherstuff.playerdeathcustom = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.hidetalkinghead then
									E.db.ElvUI_EltreumUI.skins.hidetalkinghead = data.ElvUI_EltreumUI.otherstuff.hidetalkinghead
									E:CopyTable(E.db.ElvUI_EltreumUI.skins.hidetalkinghead, data.ElvUI_EltreumUI.otherstuff.hidetalkinghead)
									data.ElvUI_EltreumUI.otherstuff.hidetalkinghead = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.fastloot then
									E.db.ElvUI_EltreumUI.loot.fastloot = data.ElvUI_EltreumUI.otherstuff.fastloot
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastloot, data.ElvUI_EltreumUI.otherstuff.fastloot)
									data.ElvUI_EltreumUI.otherstuff.fastloot = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.fastlootfilter then
									E.db.ElvUI_EltreumUI.loot.fastlootfilter = data.ElvUI_EltreumUI.otherstuff.fastlootfilter
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastlootfilter, data.ElvUI_EltreumUI.otherstuff.fastlootfilter)
									data.ElvUI_EltreumUI.otherstuff.fastlootfilter = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.fastlootquality then
									E.db.ElvUI_EltreumUI.loot.fastlootquality = data.ElvUI_EltreumUI.otherstuff.fastlootquality
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.fastlootquality, data.ElvUI_EltreumUI.otherstuff.fastlootquality)
									data.ElvUI_EltreumUI.otherstuff.fastlootquality = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning then
									E.db.ElvUI_EltreumUI.loot.lootwishlistwarning = data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistwarning, data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning)
									data.ElvUI_EltreumUI.otherstuff.lootwishlistwarning = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter then
									E.db.ElvUI_EltreumUI.loot.lootwishlistfilter = data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistfilter, data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter)
									data.ElvUI_EltreumUI.otherstuff.lootwishlistfilter = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot then
									E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot = data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistscreenshot, data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot)
									data.ElvUI_EltreumUI.otherstuff.lootwishlistscreenshot = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable then
									E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable = data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistsoundenable, data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable)
									data.ElvUI_EltreumUI.otherstuff.lootwishlistsoundenable = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.lootautoclose then
									E.db.ElvUI_EltreumUI.loot.lootautoclose = data.ElvUI_EltreumUI.otherstuff.lootautoclose
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootautoclose, data.ElvUI_EltreumUI.otherstuff.lootautoclose)
									data.ElvUI_EltreumUI.otherstuff.lootautoclose = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.lootwishlistsound then
									E.db.ElvUI_EltreumUI.loot.lootwishlistsound = data.ElvUI_EltreumUI.otherstuff.lootwishlistsound
									E:CopyTable(E.db.ElvUI_EltreumUI.loot.lootwishlistsound, data.ElvUI_EltreumUI.otherstuff.lootwishlistsound)
									data.ElvUI_EltreumUI.otherstuff.lootwishlistsound = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.arenabuffs then
									E.db.ElvUI_EltreumUI.unitframes.arenabuffs = data.ElvUI_EltreumUI.otherstuff.arenabuffs
									E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.arenabuffs, data.ElvUI_EltreumUI.otherstuff.arenabuffs)
									data.ElvUI_EltreumUI.otherstuff.arenabuffs = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.bgunitframes then
									E.db.ElvUI_EltreumUI.unitframes.bgunitframes = data.ElvUI_EltreumUI.otherstuff.bgunitframes
									E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.bgunitframes, data.ElvUI_EltreumUI.otherstuff.bgunitframes)
									data.ElvUI_EltreumUI.otherstuff.bgunitframes = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.arenaunitframes then
									E.db.ElvUI_EltreumUI.unitframes.arenaunitframes = data.ElvUI_EltreumUI.otherstuff.arenaunitframes
									E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.arenaunitframes, data.ElvUI_EltreumUI.otherstuff.arenaunitframes)
									data.ElvUI_EltreumUI.otherstuff.arenaunitframes = nil
									profileChanged = true
								end
								if data.ElvUI_EltreumUI.otherstuff.portraitfix then
									E.db.ElvUI_EltreumUI.unitframes.portraitfix = data.ElvUI_EltreumUI.otherstuff.portraitfix
									E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.portraitfix, data.ElvUI_EltreumUI.otherstuff.portraitfix)
									data.ElvUI_EltreumUI.otherstuff.portraitfix = nil
									profileChanged = true
								end
							end
							if data.ElvUI_EltreumUI.UFmodifications then
								E.db.ElvUI_EltreumUI.unitframes.UFmodifications = data.ElvUI_EltreumUI.UFmodifications
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.UFmodifications, data.ElvUI_EltreumUI.UFmodifications)
								data.ElvUI_EltreumUI.UFmodifications = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.UForientation then
								E.db.ElvUI_EltreumUI.unitframes.UForientation = data.ElvUI_EltreumUI.UForientation
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.UForientation, data.ElvUI_EltreumUI.UForientation)
								data.ElvUI_EltreumUI.UForientation = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.uftextureversion then
								E.db.ElvUI_EltreumUI.unitframes.uftextureversion = data.ElvUI_EltreumUI.uftextureversion
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.uftextureversion, data.ElvUI_EltreumUI.uftextureversion)
								data.ElvUI_EltreumUI.uftextureversion = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.darkmode then
								E.db.ElvUI_EltreumUI.unitframes.darkmode = data.ElvUI_EltreumUI.darkmode
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkmode, data.ElvUI_EltreumUI.darkmode)
								data.ElvUI_EltreumUI.darkmode = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.lightmode then
								E.db.ElvUI_EltreumUI.unitframes.lightmode = data.ElvUI_EltreumUI.lightmode
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.lightmode, data.ElvUI_EltreumUI.lightmode)
								data.ElvUI_EltreumUI.lightmode = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.darkpowercolor then
								E.db.ElvUI_EltreumUI.unitframes.darkpowercolor = data.ElvUI_EltreumUI.darkpowercolor
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.darkpowercolor, data.ElvUI_EltreumUI.darkpowercolor)
								data.ElvUI_EltreumUI.darkpowercolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.greybackground then
								E.db.ElvUI_EltreumUI.unitframes.greybackground = data.ElvUI_EltreumUI.greybackground
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.greybackground, data.ElvUI_EltreumUI.greybackground)
								data.ElvUI_EltreumUI.greybackground = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.gradientmode then
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.gradientmode, data.ElvUI_EltreumUI.gradientmode)
								data.ElvUI_EltreumUI.gradientmode = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.ufcustomtexture then
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture, data.ElvUI_EltreumUI.ufcustomtexture)
								data.ElvUI_EltreumUI.ufcustomtexture = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.sparkcustomcolor then
								E:CopyTable(E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor, data.ElvUI_EltreumUI.sparkcustomcolor)
								data.ElvUI_EltreumUI.sparkcustomcolor = nil
								profileChanged = true
							end
							if data.ElvUI_EltreumUI.questsettings then
								E:CopyTable(E.db.ElvUI_EltreumUI.quests, data.ElvUI_EltreumUI.questsettings)
								data.ElvUI_EltreumUI.questsettings = nil
								profileChanged = true
							end
						end
						if data.unitframe then
							if data.unitframe.units then
								if data.unitframe.units.raid1 then
									if data.unitframe.units.raid1.customTexts then
										if data.unitframe.units.raid1.customTexts.EltreumGroup then
											data.unitframe.units.raid1.customTexts.EltreumGroup.text_format = "[eltruism:groupnumber]"
											profileChanged = true
										end
										if data.unitframe.units.raid1.customTexts.EltreumRaidHealth then
											data.unitframe.units.raid1.customTexts.EltreumRaid1Health = data.unitframe.units.raid1.customTexts.EltreumRaidHealth
											E:CopyTable(data.unitframe.units.raid1.customTexts.EltreumRaid1Health, data.unitframe.units.raid1.customTexts.EltreumRaidHealth)
											data.unitframe.units.raid1.customTexts.EltreumRaidHealth = nil
											profileChanged = true
										end
										if data.unitframe.units.raid1.customTexts.EltreumRaidAbsorb then
											data.unitframe.units.raid1.customTexts.EltreumRaid1Absorb = data.unitframe.units.raid1.customTexts.EltreumRaidAbsorb
											E:CopyTable(data.unitframe.units.raid1.customTexts.EltreumRaid1Absorb, data.unitframe.units.raid1.customTexts.EltreumRaidAbsorb)
											data.unitframe.units.raid1.customTexts.EltreumRaidAbsorb = nil
											profileChanged = true
										end
										if data.unitframe.units.raid1.customTexts.EltreumRaidName then
											data.unitframe.units.raid1.customTexts.EltreumRaid1Name = data.unitframe.units.raid1.customTexts.EltreumRaidName
											E:CopyTable(data.unitframe.units.raid1.customTexts.EltreumRaid1Name, data.unitframe.units.raid1.customTexts.EltreumRaidName)
											data.unitframe.units.raid1.customTexts.EltreumRaidName = nil
											profileChanged = true
										end
									end
								end
								if data.unitframe.units.raid2 then
									if data.unitframe.units.raid2.customTexts then
										if data.unitframe.units.raid2.customTexts.EltreumRaid1Health then
											data.unitframe.units.raid2.customTexts.EltreumRaid2Health = data.unitframe.units.raid2.customTexts.EltreumRaid1Health
											E:CopyTable(data.unitframe.units.raid2.customTexts.EltreumRaid2Health, data.unitframe.units.raid2.customTexts.EltreumRaid1Health)
											data.unitframe.units.raid2.customTexts.EltreumRaid1Health = nil
											profileChanged = true
										end
										if data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb then
											data.unitframe.units.raid2.customTexts.EltreumRaid2Absorb = data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb
											E:CopyTable(data.unitframe.units.raid2.customTexts.EltreumRaid2Absorb, data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb)
											data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb = nil
											profileChanged = true
										end
										if data.unitframe.units.raid2.customTexts.EltreumRaid1Name then
											data.unitframe.units.raid2.customTexts.EltreumRaid2Name = data.unitframe.units.raid2.customTexts.EltreumRaid1Name
											E:CopyTable(data.unitframe.units.raid2.customTexts.EltreumRaid2Name, data.unitframe.units.raid2.customTexts.EltreumRaid1Name)
											data.unitframe.units.raid2.customTexts.EltreumRaid1Name = nil
											profileChanged = true
										end
									end
									if not data.unitframe.units.raid2.customTexts then
										data.unitframe.units.raid2.customTexts = {}
										E:CopyTable(data.unitframe.units.raid2.customTexts, data.unitframe.units.raid1.customTexts)
										if data.unitframe.units.raid2.customTexts.EltreumRaid1Health then
											data.unitframe.units.raid2.customTexts.EltreumRaid2Health = data.unitframe.units.raid2.customTexts.EltreumRaid1Health
											E:CopyTable(data.unitframe.units.raid2.customTexts.EltreumRaid2Health, data.unitframe.units.raid2.customTexts.EltreumRaid1Health)
											data.unitframe.units.raid2.customTexts.EltreumRaid1Health = nil
											profileChanged = true
										end
										if data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb then
											data.unitframe.units.raid2.customTexts.EltreumRaid2Absorb = data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb
											E:CopyTable(data.unitframe.units.raid2.customTexts.EltreumRaid2Absorb, data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb)
											data.unitframe.units.raid2.customTexts.EltreumRaid1Absorb = nil
											profileChanged = true
										end
										if data.unitframe.units.raid2.customTexts.EltreumRaid1Name then
											data.unitframe.units.raid2.customTexts.EltreumRaid2Name = data.unitframe.units.raid2.customTexts.EltreumRaid1Name
											E:CopyTable(data.unitframe.units.raid2.customTexts.EltreumRaid2Name, data.unitframe.units.raid2.customTexts.EltreumRaid1Name)
											data.unitframe.units.raid2.customTexts.EltreumRaid1Name = nil
											profileChanged = true
										end
									end
								end
								if data.unitframe.units.raid3 then
									if data.unitframe.units.raid3.name.text_format == '[namecolor][name]' then
										data.unitframe.units.raid3.name.text_format = ''
										profileChanged = true
									end
									if data.unitframe.units.raid3.customTexts then
										if data.unitframe.units.raid3.customTexts.EltreumRaid40Health then
											data.unitframe.units.raid3.customTexts.EltreumRaid3Health = data.unitframe.units.raid3.customTexts.EltreumRaid40Health
											E:CopyTable(data.unitframe.units.raid3.customTexts.EltreumRaid3Health, data.unitframe.units.raid3.customTexts.EltreumRaid40Health)
											data.unitframe.units.raid3.customTexts.EltreumRaid40Health = nil
											profileChanged = true
										end
										if data.unitframe.units.raid3.customTexts.EltreumRaid40Absorb then
											data.unitframe.units.raid3.customTexts.EltreumRaid3Absorb = data.unitframe.units.raid3.customTexts.EltreumRaid40Absorb
											E:CopyTable(data.unitframe.units.raid3.customTexts.EltreumRaid3Absorb, data.unitframe.units.raid3.customTexts.EltreumRaid40Absorb)
											data.unitframe.units.raid3.customTexts.EltreumRaid40Absorb = nil
											profileChanged = true
										end
										if data.unitframe.units.raid3.customTexts.EltreumRaid40Name then
											data.unitframe.units.raid3.customTexts.EltreumRaid3Name = data.unitframe.units.raid3.customTexts.EltreumRaid40Name
											E:CopyTable(data.unitframe.units.raid3.customTexts.EltreumRaid3Name, data.unitframe.units.raid3.customTexts.EltreumRaid40Name)
											data.unitframe.units.raid3.customTexts.EltreumRaid40Name = nil
											profileChanged = true
										end
										if data.unitframe.units.raid3.customTexts.EltreumRaid40Group then
											data.unitframe.units.raid3.customTexts.EltreumGroup = data.unitframe.units.raid3.customTexts.EltreumRaid40Group
											E:CopyTable(data.unitframe.units.raid3.customTexts.EltreumGroup, data.unitframe.units.raid3.customTexts.EltreumRaid40Group)
											data.unitframe.units.raid3.customTexts.EltreumRaid40Group = nil
											profileChanged = true
										end
										if not data.unitframe.units.raid3.customTexts.EltreumRaid3Name then
											data.unitframe.units.raid3.customTexts.EltreumRaid3Name = {}
											E:CopyTable(data.unitframe.units.raid3.customTexts.EltreumRaid3Name, data.unitframe.units.raid2.customTexts.EltreumRaid2Name)
											data.unitframe.units.raid3.customTexts.EltreumRaid3Name.text_format = "[namecolor][name:eltruism:abbreviateshort]"
											profileChanged = true
										end
										if data.unitframe.units.raid3.customTexts.EltreumGroup then
											data.unitframe.units.raid3.customTexts.EltreumGroup.text_format = "[eltruism:groupnumber]"
											profileChanged = true
										end
									end
								end
							end
						end
						if profileChanged then
							if ProfileNames == NONE then
								ProfileNames = profile
							else
								ProfileNames = ProfileNames..', '..profile
							end
						end
					end
				end
			end

			E:Delay(1, function()
				E:StaggeredUpdateAll()
			end)
			E:StaticPopup_Show('ELTRUISMDBCONVERT', ProfileNames, CharacterNames)
			E.private.ElvUI_EltreumUI.install_version = ElvUI_EltreumUI.Version
		end
	end
end
