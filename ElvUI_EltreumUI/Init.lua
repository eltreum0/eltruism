-- This whole plugin started based in LuckyoneUI, which was the simplest to understand. Full thanks to him for making it and allowing its use!
-- It wouldn't be possible without the ElvUI community after all
local E = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local addon = ...
local _G = _G
ElvUI_EltreumUI = E:NewModule(addon, 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0', 'AceConsole-3.0')
local GetAddOnMetadata = _G.C_AddOns and _G.C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata

--Binding
_G.BINDING_HEADER_ELTRUISM = GetAddOnMetadata(..., 'Title')
_G["BINDING_NAME_CLICK EltruismQuestItem1:LeftButton"] = "Quest Item 1"
_G["BINDING_NAME_CLICK EltruismQuestItem2:LeftButton"] = "Quest Item 2"
_G["BINDING_NAME_CLICK EltruismQuestItem3:LeftButton"] = "Quest Item 3"
_G["BINDING_NAME_CLICK EltruismQuestItem4:LeftButton"] = "Quest Item 4"
_G["BINDING_NAME_CLICK EltruismQuestItem5:LeftButton"] = "Quest Item 5"
_G["BINDING_NAME_CLICK EltruismQuestItem6:LeftButton"] = "Quest Item 6"
_G["BINDING_NAME_CLICK EltruismQuestItem7:LeftButton"] = "Quest Item 7"
_G["BINDING_NAME_CLICK EltruismQuestItem8:LeftButton"] = "Quest Item 8"
_G["BINDING_NAME_CLICK EltruismQuestItem9:LeftButton"] = "Quest Item 9"
_G["BINDING_NAME_CLICK EltruismQuestItem10:LeftButton"] = "Quest Item 10"
_G["BINDING_NAME_CLICK EltruismQuestItem11:LeftButton"] = "Quest Item 11"
_G["BINDING_NAME_CLICK EltruismQuestItem12:LeftButton"] = "Quest Item 12"

--Constants
ElvUI_EltreumUI.Version = GetAddOnMetadata(addon, 'Version')
ElvUI_EltreumUI.CreditsList = {}
ElvUI_EltreumUI.Config = {}
--ElvUI_EltreumUI.Name = '|cff82B4ffEltruism|r'
ElvUI_EltreumUI.Name = E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1)
ElvUI_EltreumUI.Spec = 0

function ElvUI_EltreumUI:PLAYER_ENTERING_WORLD(_, initLogin)
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	end
	if initLogin or not ElvDB.EltruismDisabledAddOns then
		ElvDB.EltruismDisabledAddOns = {}
	end
	if E.db.ElvUI_EltreumUI.deepLwarning then
		if E.global.general.locale == "esMX" or E.global.general.locale == "esES" then
			ElvUI_EltreumUI:Print("Spanish Translation is from DeepL and is in testing, feedback is welcome. - La traducción al español es de DeepL y está en pruebas, los comentarios son bienvenidos.\n Type /eltruism translate to turn this message off")
		elseif E.global.general.locale == "frFR" then
			ElvUI_EltreumUI:Print("French Translation is from DeepL and is in testing, feedback is welcome. - La traduction française provient de DeepL et est en cours de test, les commentaires sont les bienvenus.\n Type /eltruism translate to turn this message off")
		end
	end
	ElvUI_EltreumUI:OriginalClassColors() --original mage and warlock class colors, also shaman blue in classic
	ElvUI_EltreumUI:CheckCompatibility() -- check for other stuff that might conflict
	ElvUI_EltreumUI:VersionCheckInit() --checks for old versions
	ElvUI_EltreumUI:LoadCommands() --loads chat commands
	ElvUI_EltreumUI:AuthorMVPDonatorIcons() -- add author/donator/mvp icons
	ElvUI_EltreumUI:SetTemplateSkin() -- hook settemplate elvui skin
	ElvUI_EltreumUI:Ace3Skin() --Ace3 Skin hook setup
	ElvUI_EltreumUI:BorderAdjust() --auto adjust actionbar/border if option is enabled
	ElvUI_EltreumUI:Borders() --creates borders if option is enabled
	ElvUI_EltreumUI:GroupBorderColorUpdate()
	ElvUI_EltreumUI:GradientColorTableUpdate() -- should load table on init
	ElvUI_EltreumUI:ClassIconsOnCharacterPanel() --adds class icons to character panel
	ElvUI_EltreumUI:CursorInit() --starts cursor modules
	ElvUI_EltreumUI:SkinMailZone() --skins zone change messages and mail font
	ElvUI_EltreumUI:RaidShadows() --adds shadows to raid groups
	ElvUI_EltreumUI:AutoScreenshot() --takes screenshots when certain events are fired
	ElvUI_EltreumUI:FriendlyNameplates() -- controls hiding healthbar from friendly nameplates inside instances
	ElvUI_EltreumUI:ShamanTextureMode() -- applies the dark color to shaman powers in TBC/Classic
	ElvUI_EltreumUI:Anchors() --creates anchors for error frame and weakaura that can be used to attack weakauras to elvui's unitframe visibility settings
	ElvUI_EltreumUI:UnitframeRoleIcons() --adds custom role icons in chat when swapping roles
	ElvUI_EltreumUI:DynamicChatFade() --adds chat fade/hide functions
	ElvUI_EltreumUI:LootText() -- gets the combat text going if not enabled
	ElvUI_EltreumUI:StealthOptions() --adds an overlay when in stealth
	ElvUI_EltreumUI:DynamicSpellStealStyleFilter() -- toggles spellsteal filter for mages based on their level
	ElvUI_EltreumUI:DynamicExperienceDatabar() --makes experience bar mouseover or not depending on current player level
	ElvUI_EltreumUI:BlizzCombatText() --enables or disables blizzard's combat text depending on player setting in eltruism
	ElvUI_EltreumUI:ArenaBattlegroundGroupUnitframes() --hides elvui unitframes in bgs/arenas
	ElvUI_EltreumUI:DynamicBuffs() --shows enemy player buffs on nameplates/unitframes if in arena/bgs, hides otherwise
	ElvUI_EltreumUI:EnteringWorldCVars() --set cvars at the start
	ElvUI_EltreumUI:RaidDeathGroupCheck() -- attempt at prevent CLEU tracking
	ElvUI_EltreumUI:AutoAcceptQuests() -- yet another auto accept quest thing
	ElvUI_EltreumUI:QuestItem() -- quest item bar merged from QBar by Aezay with edits to work in TBC/Classic
	ElvUI_EltreumUI:SkinQuests() --skins quest objective frame to be class colored
	ElvUI_EltreumUI:ExpandedCharacterStats() --attempt at improving the character panel
	ElvUI_EltreumUI:DeathSound() -- set the party/raid death sound
	ElvUI_EltreumUI:PlayerDeathAnimation() -- death animation
	ElvUI_EltreumUI:DeleteItem() -- automatically type delete
	ElvUI_EltreumUI:SkillGlow() --makes skill glow using libcustomglow
	ElvUI_EltreumUI:BattleRes() --bres count/cd
	ElvUI_EltreumUI:HideABKeyPress() -- hide keypress if user wants
	ElvUI_EltreumUI:NameplateRestedOverlaps() -- sets overlaps depending if rested/not
	ElvUI_EltreumUI:PlayerUFEffects() -- model effect on player/target
	ElvUI_EltreumUI:Doom() -- fork of Doom's Cooldown Pulse
	ElvUI_EltreumUI:FixChatToggles() --attach left/right chat toggle to the new datatext
	ElvUI_EltreumUI:ArenaQuest() --hides quests when in arena/bgs
	ElvUI_EltreumUI:SkinLevelUp() --skins level up toast
	ElvUI_EltreumUI:ExpandedTalents() --makes talents fit in one window without scroll in classic, scale in retail
	if E.Retail then
		ElvUI_EltreumUI:WaypointTimeToArrive() --adds an ETA below waypoints
		ElvUI_EltreumUI:EltruismHideTalkingHead() --hides talking head from world quests
		if E.myclass == 'HUNTER' then
			ElvUI_EltreumUI:ExpandedStable() --expands pet stable for hunters
		end
		ElvUI_EltreumUI:ObjectiveTrackerAnchor()
		ElvUI_EltreumUI.Spec = GetSpecializationInfo(GetSpecialization())
	elseif E.Wrath or E.Classic then
		ElvUI_EltreumUI:ClassicSockets() --adds sockets and enchants into the character panel, based on Kibs Item Level by Kibsgaard
		if not E.Cata then
			ElvUI_EltreumUI:DynamicClassicDatatext() --toggles datatext for warlocks/hunters to show soulshards/ammo
		end
		ElvUI_EltreumUI:UpdateAvgIlvl() --updates the ilvl of the character at login so its not 0
		ElvUI_EltreumUI:SkinProfessions() --makes professions wider
	end
	if not E.Classic then
		ElvUI_EltreumUI:DungeonRoleIcons() -- add spec icons to the lfg frame
	end
	ElvUI_EltreumUI:WorldMapScale() -- set world map scale
	if E.private.nameplates.enable then
		ElvUI_EltreumUI:NamePlateOptions() --adds dynamic class based color filters to elvui nameplates
		ElvUI_EltreumUI:DynamicLevelStyleFilter() --shows or hides level filter on np based on player level
		ElvUI_EltreumUI:UpdateNPwithoutBar() --updates buffs/debuffs positions on np based on powerbar settings
	end
	if E.db.ElvUI_EltreumUI.dev then --load dev tools if user enables
		ElvUI_EltreumUI:DevTools()
	end
	ElvUI_EltreumUI:Shadows() --adds shadows to frames
	ElvUI_EltreumUI:PlayerItemQuality("player") --add item quality texture to character panel skin
	ElvUI_EltreumUI:CooldownColors() --changes cooldown colors to be class colored
	ElvUI_EltreumUI:GradientMirrorLoot() --gradient misc frames like breath/lootroll
	ElvUI_EltreumUI:MinimapCardinalDirections() -- minimap cardinal directions
	ElvUI_EltreumUI:AutoCombatLog() -- automatic combat logging inside instances + advanced log for warcraftlogs
	ElvUI_EltreumUI:FrameScales() --misc frames scales
	ElvUI_EltreumUI:NPClassificatioNIcon() -- add different elite/rare icons to np
	if not E.private.unitframe.disabledBlizzardFrames.raid then -- blizzard raid textures/gradient
		ElvUI_EltreumUI:BlizzardTexturesGradient()
	end
	if E.db.ElvUI_EltreumUI.skins.cell then --Cell gradient/custom textures/shadows
		ElvUI_EltreumUI:EltruismCell()
	end
	ElvUI_EltreumUI:HardcoreDeath() -- hardcore death sound/animation
	ElvUI_EltreumUI:BagProfessions() -- add profession buttons to bags
end

function ElvUI_EltreumUI:Initialize()
	--since now Eltruism has both ElvUI Cvars and ElvUI Chat setup builtin we can skip elvui setup
	if not E.private.ElvUI_EltreumUI.install_version then
		if not E.private.install_complete then --check if they didnt install elvui bc eltruism will do the install things that elvui does
			E.private.install_complete = E.version
			E.private.ElvUI_EltreumUI.skippedcheck = true --this is case they skip during install, when they'll need elvui install to popup again
		end
		ElvUI_EltreumUI:HidePopups(5)
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
		return
	end
	--register the plugin config
	EP:RegisterPlugin(addon, ElvUI_EltreumUI.Configtable)
	--Register Events
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_START') --for quests and combat music
	ElvUI_EltreumUI:RegisterEvent('ENCOUNTER_END') --for quests and combat music
	ElvUI_EltreumUI:RegisterEvent('GROUP_ROSTER_UPDATE') --to store group roster in order to compare in party/raid death
	ElvUI_EltreumUI:RegisterEvent('PLAYER_ENTERING_WORLD') --for most of the addon
	ElvUI_EltreumUI:RegisterEvent('PLAYER_FLAGS_CHANGED') -- for afk music
	ElvUI_EltreumUI:RegisterEvent('PLAYER_LEVEL_UP') --for the level up skin
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_ENABLED') --for combat music/chat hide/unitframe hide
	ElvUI_EltreumUI:RegisterEvent('PLAYER_REGEN_DISABLED') --for combat music/chat hide/unitframe hide
	ElvUI_EltreumUI:RegisterEvent('UPDATE_STEALTH') --for stealth overlay
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_INDOORS') --for hiding healthbar in friendly np
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED') --for hiding healthbar in friendly np
	ElvUI_EltreumUI:RegisterEvent('ZONE_CHANGED_NEW_AREA') --for hiding healthbar in friendly np
	ElvUI_EltreumUI:RegisterEvent('PLAYER_TARGET_CHANGED') --for power bar and light mode texture
	ElvUI_EltreumUI:RegisterEvent('INSPECT_READY')
	if E.Retail then
		ElvUI_EltreumUI:RegisterEvent('GOSSIP_SHOW') --for rogue order hall
		ElvUI_EltreumUI:RegisterEvent('CHALLENGE_MODE_COMPLETED') --for auto screenshot
		ElvUI_EltreumUI:RegisterEvent('ACHIEVEMENT_EARNED') --for auto screenshot
		ElvUI_EltreumUI:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	end
	if E.Wrath then
		ElvUI_EltreumUI:RegisterEvent('ACHIEVEMENT_EARNED') --for auto screenshot
		ElvUI_EltreumUI:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		ElvUI_EltreumUI:RegisterEvent('PLAYER_AVG_ITEM_LEVEL_UPDATE')
	end
	if E.ClassicSOD then
		ElvUI_EltreumUI:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	end
	if E.Classic then
		ElvUI_EltreumUI:RegisterEvent('PLAYER_AVG_ITEM_LEVEL_UPDATE')
	end
	--because some cvars keep resetting for some reason
	ElvUI_EltreumUI:RegisterEvent('PLAYER_LEAVING_WORLD')
	ElvUI_EltreumUI:RegisterEvent('PLAYER_LOGOUT')
	ElvUI_EltreumUI:RegisterEvent("UPDATE_PENDING_MAIL") --for mail sound/icon
end

function ElvUI_EltreumUI:COMBAT_LOG_EVENT_UNFILTERED()
	local _, eventType, _, _, _, _, _, _, _, destFlags = CombatLogGetCurrentEventInfo()
	if eventType == "UNIT_DIED" and E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable then
		ElvUI_EltreumUI:RaidDeath(destFlags)
	end
end

function ElvUI_EltreumUI:ENCOUNTER_START(event)
	local event2 = event
	ElvUI_EltreumUI:QuestEncounter()
	ElvUI_EltreumUI:CombatMusic(event2)
	ElvUI_EltreumUI:BossMusic(event)
	ElvUI_EltreumUI:BattleRes()
end

function ElvUI_EltreumUI:ENCOUNTER_END(event)
	local event2 = event
	ElvUI_EltreumUI:QuestEncounterEnd()
	ElvUI_EltreumUI:StopBossMusic(event)
	ElvUI_EltreumUI:StopCombatMusic(event2)
	ElvUI_EltreumUI:BattleRes()
end

function ElvUI_EltreumUI:GROUP_ROSTER_UPDATE()
	ElvUI_EltreumUI:RaidDeathGroupCheck()
	--ElvUI_EltreumUI:Shadows()
	if IsInRaid() then
		ElvUI_EltreumUI:RaidShadows()
	end
	if E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		ElvUI_EltreumUI:GradientUF()
		ElvUI_EltreumUI:CustomTexture()
	end
	if E.db.ElvUI_EltreumUI.borders.borders then
		ElvUI_EltreumUI:GroupBorderColorUpdate()
	end
	if not E.private.unitframe.disabledBlizzardFrames.raid then -- blizzard raid textures/gradient
		ElvUI_EltreumUI:BlizzardTexturesGradient()
	end
	if E.db.ElvUI_EltreumUI.skins.cell then --Cell gradient/custom textures/shadows
		ElvUI_EltreumUI:EltruismCell()
	end
end

function ElvUI_EltreumUI:PLAYER_FLAGS_CHANGED(_,unit)
	if unit == "player" then
		ElvUI_EltreumUI:NameplateRestedOverlaps()
		ElvUI_EltreumUI:AFKmusic()
		if UnitIsAFK("player") then
			if E.db.general.afk then
				ElvUI_EltreumUI:AFKLogo()
			end
		end
	end
end

function ElvUI_EltreumUI:PLAYER_LEVEL_UP()
	ElvUI_EltreumUI:DynamicLevelStyleFilter()
	ElvUI_EltreumUI:DynamicExperienceDatabar()
	ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	ElvUI_EltreumUI:AutoScreenshot()
end

function ElvUI_EltreumUI:PLAYER_REGEN_ENABLED(event)
	ElvUI_EltreumUI:StopCombatMusic(event)
	ElvUI_EltreumUI:BlizzCombatText()
	ElvUI_EltreumUI:QuestCombatEnd()
	ElvUI_EltreumUI:MinimapHide(event)
	ElvUI_EltreumUI:DatatextHide(event)
end

function ElvUI_EltreumUI:PLAYER_REGEN_DISABLED(event)
	ElvUI_EltreumUI:CombatMusic(event)
	ElvUI_EltreumUI:QuestCombat()
	ElvUI_EltreumUI:MinimapHide(event)
	ElvUI_EltreumUI:DatatextHide(event)
end

function ElvUI_EltreumUI:UPDATE_STEALTH()
	ElvUI_EltreumUI:StealthOptions()
end

function ElvUI_EltreumUI:ZONE_CHANGED()
	ElvUI_EltreumUI:FriendlyNameplates()
	ElvUI_EltreumUI:SkinMailZone()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
	end
end

function ElvUI_EltreumUI:ZONE_CHANGED_INDOORS()
	ElvUI_EltreumUI:FriendlyNameplates()
	ElvUI_EltreumUI:BattleRes()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
	end
end

function ElvUI_EltreumUI:ZONE_CHANGED_NEW_AREA()
	E:Delay(5,function() ElvUI_EltreumUI:FriendlyNameplates() end)
	ElvUI_EltreumUI:QuestItem()
	if E.db.ElvUI_EltreumUI.otherstuff.minimapcardinaldirections.rotate then
		ElvUI_EltreumUI:MinimapCardinalDirectionsRotateInstance()
	end
end

function ElvUI_EltreumUI:PLAYER_TARGET_CHANGED()
	ElvUI_EltreumUI:NamePlateOptions()
	ElvUI_EltreumUI:NameplatePower()
	ElvUI_EltreumUI:NameplateModel()
	ElvUI_EltreumUI:TargetUFEffects()
	ElvUI_EltreumUI:TargetCombatIconClass()
	if E.db.ElvUI_EltreumUI.borders.borders and E.db.ElvUI_EltreumUI.borders.classcolor then
		ElvUI_EltreumUI:BordersTargetChanged()
	end
end

local currenttalentretail = E.Retail and GetSpecialization()
local currenttalentwrath = E.Wrath and GetActiveTalentGroup()
function ElvUI_EltreumUI:ACTIVE_TALENT_GROUP_CHANGED()
	local newtalentretail = E.Retail and GetSpecialization()
	local newtalentwrath = (E.Wrath or E.ClassicSOD) and GetActiveTalentGroup()
	if E.Retail then
		ElvUI_EltreumUI.Spec = GetSpecializationInfo(GetSpecialization())
	end
	if (E.Retail and currenttalentretail ~= newtalentretail) or ((E.Wrath or E.ClassicSOD) and currenttalentwrath ~= newtalentwrath) then
		currenttalentretail = newtalentretail
		currenttalentwrath = newtalentwrath
		ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
		ElvUI_EltreumUI:FixChatToggles()
		if E.Retail or (E.Wrath or E.ClassicSOD) then
			ElvUI_EltreumUI:NamePlateOptions()
			ElvUI_EltreumUI:Shadows()
			if E.private.nameplates.enable then
				ElvUI_EltreumUI:UpdateNPwithoutBar()
			end
			if E.db.ElvUI_EltreumUI.borders.borders then
				E:Delay(2, function() ElvUI_EltreumUI:BorderAdjust() end)
				E:Delay(2, function() ElvUI_EltreumUI:Borders() end)
			end
			E:Delay(2, function() ElvUI_EltreumUI:ShowHideBorders() end)
			E:Delay(0.5, function() ElvUI_EltreumUI:ExpandedCharacterStats() end)
		end
	end
end

function ElvUI_EltreumUI:GOSSIP_SHOW()
	if E.Retail and E.myclass == 'ROGUE' then
		ElvUI_EltreumUI:RogueAutoOpen()
	end
end

function ElvUI_EltreumUI:ACHIEVEMENT_EARNED()
	ElvUI_EltreumUI:AutoScreenshot()
end

function ElvUI_EltreumUI:CHALLENGE_MODE_COMPLETED()
	ElvUI_EltreumUI:AutoScreenshot()
end

function ElvUI_EltreumUI:PLAYER_AVG_ITEM_LEVEL_UPDATE()
	ElvUI_EltreumUI:UpdateAvgIlvl()
end

function ElvUI_EltreumUI:INSPECT_READY(_,unit)
	E:Delay(0, function()
		if _G.InspectFrame and _G.InspectFrame:IsVisible() then
			ElvUI_EltreumUI:InspectBg(unit)
		end
	end)
end

function ElvUI_EltreumUI:UPDATE_PENDING_MAIL()
	ElvUI_EltreumUI:BlizzMail()
end

function ElvUI_EltreumUI:PLAYER_LEAVING_WORLD()
	ElvUI_EltreumUI:BlizzCombatText()
end

function ElvUI_EltreumUI:PLAYER_LOGOUT()
	if _G.ElvUF_PlayerMover then
		_G.ElvUF_PlayerMover:ClearAllPoints()
	end
	if _G.ElvUF_PlayerCastbarMover then
		_G.ElvUF_PlayerCastbarMover:ClearAllPoints()
	end
	if _G.ElvUF_TargetCastbarMover then
		_G.ElvUF_TargetCastbarMover:ClearAllPoints()
	end
	if _G.ElvUF_TargetMover then
		_G.ElvUF_TargetMover:ClearAllPoints()
	end
	ElvUI_EltreumUI:BlizzCombatText()
end

local function CallbackInitialize()
	ElvUI_EltreumUI:Initialize()
end
E:RegisterModule(addon, CallbackInitialize)

--blizzard removed the cpu functions, rip ElvUI_CPU
--[[if IsAddOnLoaded("ElvUI_CPU") then
	ElvUI_CPU:RegisterPlugin(ElvUI_EltreumUI)
	--ElvUIDev:RegisterPluginModule("ElvUI_EltreumUI", moduleName, module)
end]]
