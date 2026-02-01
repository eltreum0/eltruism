local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local C_ToyBox = _G.C_ToyBox
local PlayerHasToy = _G.PlayerHasToy
local GetItemCount = _G.C_Item and _G.C_Item.GetItemCount or _G.GetItemCount
local IsUsableItem = _G.C_Item and _G.C_Item.IsUsableItem or _G.IsUsableItem
local IsSpellKnown = _G.C_SpellBook and _G.C_SpellBook.IsSpellKnown or _G.IsSpellKnown
local TEXT_TO_SPEECH = _G.TEXT_TO_SPEECH
local C_VoiceChat = _G.C_VoiceChat
local PlaySoundFile = _G.PlaySoundFile

local function voiceplayback(text)
	if E.Retail then
		C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, _G.tostring(text), 1, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume, true)
	else
		C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, _G.tostring(text), _G.Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume)
	end
end

-- Eltruism other options
function ElvUI_EltreumUI:MiscOptions()
	ElvUI_EltreumUI.Options.args.misc = E.Libs.ACH:Group(E:TextGradient(L["Misc"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Various miscellaneous features such as death animations, stealth texture, mail sound, /roll sounds and more"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.misc.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\misc'
	ElvUI_EltreumUI.Options.args.misc.args.general = E.Libs.ACH:Group(L["General"], nil, 1)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description1 = E.Libs.ACH:Description(L["Show Eltruism Game Menu Button"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.gamemenu = E.Libs.ACH:Toggle(L["Enable"], nil, 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.gamemenu end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.gamemenu = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description2 = E.Libs.ACH:Description(L["Auto open the Rogue Order Hall, to avoid opening hold CTRL or SHIFT or ALT while talking to the NPC"], 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.rogueorderhall = E.Libs.ACH:Toggle(L["Enable"], L["Enable the Rogue Order Hall Auto Open"], 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.quests.rogueopen end, function(_, value) E.db.ElvUI_EltreumUI.quests.rogueopen = value E:StaticPopup_Show('CONFIG_RL') end, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description3 = E.Libs.ACH:Description("", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.rollsound = E.Libs.ACH:Toggle(L["Add Sounds to /roll when someone gets a 1 or a 100"], L["Plays a sound if someone rolls 1 or 100 out 100"], 6, nil, false, "full", function() return E.db.ElvUI_EltreumUI.chat.rollsound end, function(_, value) E.db.ElvUI_EltreumUI.chat.rollsound = value PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\WillSmith-Ahaha.ogg", "Master") E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description4 = E.Libs.ACH:Description(L["Hide Talking Head"], 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.talkinghead = E.Libs.ACH:Toggle(L["Enable"], L["Prevent Blizzard's Talking Head from appearing"], 8, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.hidetalkinghead end, function(_, value) E.db.ElvUI_EltreumUI.skins.hidetalkinghead = value E:StaticPopup_Show('CONFIG_RL') end, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description5 = E.Libs.ACH:Description(L["Automatically take Screenshots"], 9, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.autoscreenshot = E.Libs.ACH:Toggle(L["Enable"], L["Automatically take Screenshots such as when leveling up"], 10, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.screenshot end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.screenshot = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description6 = E.Libs.ACH:Description(L["Vignette"], 11, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.stealthvignette = E.Libs.ACH:Toggle(L["Add a vignette effect while in stealth"], L["Turn the effect on"], 12, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.stealtheffect end, function(_, value) E.db.ElvUI_EltreumUI.skins.stealtheffect = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.skins.screenvignette end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.everywherevignette = E.Libs.ACH:Toggle(L["Add a vignette effect always"], L["Turn the effect on"], 13, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.screenvignette end, function(_, value) E.db.ElvUI_EltreumUI.skins.screenvignette = value E:StaticPopup_Show('CONFIG_RL') end, function() return E.db.ElvUI_EltreumUI.skins.stealtheffect end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.everywherevignettealpha = E.Libs.ACH:Range(L["Alpha"], nil, 14, { min = 0, max = 1, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.skins.screenvignettealpha end, function(_, value) E.db.ElvUI_EltreumUI.skins.screenvignettealpha = value ElvUI_EltreumUI:StealthOptions() end, function() return not E.db.ElvUI_EltreumUI.skins.screenvignette end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description7 = E.Libs.ACH:Description(L["Item Deletion"], 15, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.delete = E.Libs.ACH:Toggle(L["Automatically type DELETE on the popup"], L["Will not delete the item, will simply type DELETE instead you needing to type it"], 16, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.delete end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.delete = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description8 = E.Libs.ACH:Description(L["Play a Sound when receiving mail"], 17, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundenable = E.Libs.ACH:Toggle(L["Enable"], nil, 18, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundselect = E.Libs.ACH:Select(_G.SOUND or "", nil, 19, { ["tts"] = L["Text to Speech"], ["sharedmedia"] = _G.CUSTOM or "", }, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundselect.style = "radio"
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundLSM = E.Libs.ACH:SharedMediaSound(L["Select a Sound"], L["Choose a Sound from SharedMedia files"], 20, "double", function() return E.db.ElvUI_EltreumUI.otherstuff.mailsound end, function(_,key) E.db.ElvUI_EltreumUI.otherstuff.mailsound = key E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "tts" end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundTTS = E.Libs.ACH:Input(L["Text to Speech announcement"], nil, 21, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext end, function(_, value)
		E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext = _G.tostring(value)
		if E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice ~= nil then
			voiceplayback(value)
		end
	end, function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "sharedmedia" end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundTTSconfig = E.Libs.ACH:Select(L["Text to Speech Config"], nil, 22, function()
		local Voices = {}
		for _, v in _G.pairs(C_VoiceChat.GetTtsVoices()) do
			--Voices[i] = v.voiceID
			Voices[v.voiceID] = v.name
		end
		return Voices
	end, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice = _G.tonumber(value) voiceplayback(TEXT_TO_SPEECH) end, function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype ~= "tts" end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailsoundTTSvolume = E.Libs.ACH:Range(_G.VOLUME or "", nil, 23, { min = 1, max = 100, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable or E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype ~= "tts" end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description9 = E.Libs.ACH:Description(L["Mail Animation"], 24, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.mailAnimation = E.Libs.ACH:Toggle(L["Enable Mail Animation"], L["Play a Blizzard animation when receiving mail or when new mail exists"], 25, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.mailAnimation end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.mailAnimation = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description10 = E.Libs.ACH:Description(_G.TRADE_SKILLS, 26, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.general.args.bagProfessionIcons = E.Libs.ACH:Toggle(L["Add Profession Buttons to Bags"], nil, 27, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.bagProfessionIcons end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.bagProfessionIcons = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.description11 = E.Libs.ACH:Description(L["Click Casting Button"], 30, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.general.args.ClickCastingShortcut = E.Libs.ACH:Toggle(E.NewSign..L["Add a shortcut to open the Click Casting menu on the Spellbook"], nil, 31, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.ClickCastingShortcut end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.ClickCastingShortcut = value E:StaticPopup_Show('CONFIG_RL') end, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat = E.Libs.ACH:Group(L["Combat"], nil, 2)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.description1 = E.Libs.ACH:Description(L["Show Buffs in Arena and hide them outside (will overwrite Eltruism default settings)"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.arenabuffs = E.Libs.ACH:Toggle(L["Enable"], nil, 2, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.arenabuffs end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.arenabuffs = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.description2 = E.Libs.ACH:Description(function() if E.Retail then return L["Hide Arena Frames in Arena due to Gladius/GladiusEX or another addon"] else return L["Hide Arena Frames in Arena due to Gladius/Gladdy or another addon"] end end, 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Classic)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.arenaUF = E.Libs.ACH:Toggle(L["Enable"], nil, 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.arenaunitframes end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.arenaunitframes = value E:StaticPopup_Show('CONFIG_RL') end, nil, E.Classic)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.description3 = E.Libs.ACH:Description(L["Hide Raid Unitframes in battlegrounds due to addons like Battleground Enemies"], 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.battlegroundUF = E.Libs.ACH:Toggle(L["Enable"], nil, 6, nil, false, "full", function() return E.db.ElvUI_EltreumUI.unitframes.bgunitframes end, function(_, value) E.db.ElvUI_EltreumUI.unitframes.bgunitframes = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.description4 = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.combattextindicator = E.Libs.ACH:Toggle(L["Enable Entering/Leaving Combat Indicator Texts"], L["Adds a +Combat and -Combat for when entering and leaving combat"], 8, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicator end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicator = value E:StaticPopup_Show('CONFIG_RL') end, nil, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.combattextindicatorcustom = E.Libs.ACH:Toggle(L["Custom Texts"], L["Adds a +Combat and -Combat for when entering and leaving combat"], 9, nil, false, "full", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable = value end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator end, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.combattextenter = E.Libs.ACH:Input(_G.ENTERING_COMBAT or "", nil, 10, false, "double", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enter end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enter = _G.tostring(value) end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.combattextentercolor = E.Libs.ACH:Color(L["Color"], nil, 11, false, nil, function()
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor
		local d = P.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor
		return color.r, color.g, color.b, 1, d.r, d.g, d.b,1
	end, function(_, r, g, b)
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.entercolor
		color.r, color.g, color.b = r, g, b
	end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.combattextleave = E.Libs.ACH:Input(_G.LEAVING_COMBAT or "", nil, 12, false, "double", function() return E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leave end, function(_, value) E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leave = _G.tostring(value) end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.combattextleavecolor = E.Libs.ACH:Color(L["Color"], nil, 13, false, nil, function()
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor
		local d = P.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor
		return color.r, color.g, color.b, 1, d.r, d.g, d.b, 1
	end, function(_, r, g, b)
		local color = E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.leavecolor
		color.r, color.g, color.b = r, g, b
	end, function() return not E.db.ElvUI_EltreumUI.loot.loottext.combatindicator or not E.db.ElvUI_EltreumUI.loot.loottext.combatindicatorcustom.enable end, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.description5 = E.Libs.ACH:Description(" ", 14, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.darksouls = E.Libs.ACH:Toggle(L["Enable a Dark Souls death animation"], L["Plays an animation when you die"], 15, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeath end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeath = value end, function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeathcustom end)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.gta = E.Libs.ACH:Toggle(L["Enable a GTA death animation"], L["Plays an animation when you die"], 15, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathgta = value end, function() return E.db.ElvUI_EltreumUI.skins.playerdeath or E.db.ElvUI_EltreumUI.skins.playerdeathcustom end)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.customdeath = E.Libs.ACH:Toggle(L["Enable a Custom death animation"], L["Plays an animation when you die"], 16, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeathcustom end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathcustom = value end, function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeath end)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.customdeathtext = E.Libs.ACH:Input(L["Custom Death Text"], L["The text displayed when you die using the custom text option"], 17, false, nil, function() return E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext = _G.tostring(value) E:StaticPopup_Show('PRIVATE_RL') end, function() return E.db.ElvUI_EltreumUI.skins.playerdeathgta or E.db.ElvUI_EltreumUI.skins.playerdeath or (not E.db.ElvUI_EltreumUI.skins.playerdeathcustom) end)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.description6 = E.Libs.ACH:Description(" ", 18, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.ClassicHC)
	ElvUI_EltreumUI.Options.args.misc.args.combat.args.playerdeathhardcore = E.Libs.ACH:Toggle(L["Play a sound when you Die in Hardcore"], nil, 19, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.playerdeathhardcore end, function(_, value) E.db.ElvUI_EltreumUI.skins.playerdeathhardcore = value end, nil, not E.ClassicHC)
	--ElvUI_EltreumUI.Options.args.misc.args.combat.args.guildmemberdeathhardcore = E.Libs.ACH:Toggle(L["Enable Animation and Sound when Guild Member Dies"], nil, 20, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore end, function(_, value) E.db.ElvUI_EltreumUI.skins.guildmemberdeathhardcore = value end, nil, not E.ClassicHC)
	ElvUI_EltreumUI.Options.args.misc.args.afk = E.Libs.ACH:Group(L["A.F.K"], nil, 2)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.description1 = E.Libs.ACH:Description(L["Play music while you are AFK"], 2, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.enable = E.Libs.ACH:Toggle(L["Enable"], L["Enhance the AFK screen"], 3, nil, false,"full",function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable = value end)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.description2 = E.Libs.ACH:Description(L["Select a type of music"], 4, nil, nil, nil, nil, nil, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.racialmusic = E.Libs.ACH:Toggle(L["Racial Music"], nil, 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end, not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.classmusic = E.Libs.ACH:Toggle(L["Class Music"], nil, 5, nil, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afkmusic.playerclass = value end, function() return not E.db.ElvUI_EltreumUI.otherstuff.afkmusic.enable or E.db.ElvUI_EltreumUI.otherstuff.afkmusic.racial end, not E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.description3 = E.Libs.ACH:Description(L["Skin"], 6, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.afkskin = E.Libs.ACH:Toggle(L["Enable"], nil, 7, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.afklogo end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afklogo = value end)
	ElvUI_EltreumUI.Options.args.misc.args.afk.args.eltruismlogo = E.Libs.ACH:Toggle(L["Eltruism Logo"], nil, 8, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.afklogoeltruism end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.afklogoeltruism = value end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext = E.Libs.ACH:Group(L["DataTexts"], nil, 2)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.description1 = E.Libs.ACH:Description(L["Dynamic Datatext that changes according to class to show Ammo or Soul Shards when playing Hunter, Warrior, Rogue or Warlock"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.dynamicdatatext = E.Libs.ACH:Toggle(L["Enable"], L["Enable the Dynamic Datatext"], 2, nil, false,'full',function() return E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext end,function(_, value) E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext = value end, nil, E.Retail)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.xp = E.Libs.ACH:Toggle(L["Dynamically toggle the mouseover of the Experience Bar"], L["Shows XP bar when below max level, makes it mouseover when max level"], 4, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.description3 = E.Libs.ACH:Description(" ", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.bottomclasstexture = E.Libs.ACH:Toggle(L["Class Color Texture with Eltruism Datatext"], nil, 6, nil, false, "double", function() return E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar = value ElvUI_EltreumUI:BottomDatabarTexture() end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.bottomclasstexturealpha = E.Libs.ACH:Range(L["Alpha"], nil, 7, { min = 0, max = 1, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbaralpha = value ElvUI_EltreumUI:BottomDatabarTexture() end, function() return not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.enablecustomcolorbottomclasstexture = E.Libs.ACH:Toggle(L["Enable Custom Colors"], nil, 8, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.custom end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.custom = value ElvUI_EltreumUI:BottomDatabarTexture() end, function() return not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.customcolorbottomclasstexture = E.Libs.ACH:Color(L["Custom Color"], nil, 9, false, nil, function() local dr = P.ElvUI_EltreumUI.otherstuff.datatextclasscolor.r local dg = P.ElvUI_EltreumUI.otherstuff.datatextclasscolor.g local db = P.ElvUI_EltreumUI.otherstuff.datatextclasscolor.b return E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.r, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.g, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.b, 1, dr, dg, db, 1 end, function(_, r, g, b) E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.r, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.g, E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.b = r, g, b ElvUI_EltreumUI:BottomDatabarTexture() end, function() return not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolor.custom or not E.db.ElvUI_EltreumUI.otherstuff.datatextclasscolorbar end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.description4 = E.Libs.ACH:Description(L["Datatext Hiding"], 10, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.leftdatatexthide = E.Libs.ACH:Toggle(L["Hide Left Chat Datatext out of Combat"], nil, 11, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.leftdatatextcombatshow end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.leftdatatextcombatshow = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.datatexts.panels.LeftChatDataPanel.enable end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.rightdatatexthide = E.Libs.ACH:Toggle(L["Hide Right Chat Datatext out of Combat"], nil, 11, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.rightdatatextcombatshow end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.rightdatatextcombatshow = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.datatexts.panels.RightChatDataPanel.enable end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.description5 = E.Libs.ACH:Description(L["Eltruism Hearthstones/Teleports"], 12, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.teleporttype = E.Libs.ACH:Select(L["Select which type of teleports to use on double click"], nil, 13, {
		["ITEM"] = _G.ITEMS,
		["SPELL"] = _G.SPELLS,
	}, false, nil, function() return E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype = value end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.teleporttype.style = "radio"
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.teleport = E.Libs.ACH:Select(L["Select Spell/Item"], nil, 14, function()
		local tpspellsitems = {}
		for _, v in _G.pairs(ElvUI_EltreumUI:GetTeleportSpells()) do
			if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
				local spellName = ElvUI_EltreumUI:EltruismSpellInfo(v)
				local hasSpell
				if _G.C_SpellBook and _G.C_SpellBook.IsSpellKnown then
					hasSpell = _G.C_SpellBook.IsSpellKnown(v)
				else
					hasSpell = IsSpellKnown(v)
				end
				if v == 1233637 then hasSpell = true end
				if hasSpell then
					tpspellsitems[v] = spellName
				end
			else
				local name, itemLink = GetItemInfo(v)
				local hasItem = GetItemCount(v)
				if name and ((hasItem > 0 and IsUsableItem(v)) or (not E.Classic and PlayerHasToy(v) and C_ToyBox.IsToyUsable(v))) then
					local itemid = itemLink:match("item:(%d+)")
					tpspellsitems[itemid] = name
				end
			end
		end
		return tpspellsitems
	end, false, "full", function()
		if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
			local spellName, spellID = ElvUI_EltreumUI:EltruismSpellInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			if spellName then
				return spellID
			else
				return 187874 --fallback value
			end
		else
			local _, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			if itemLink then
				local itemid = itemLink:match("item:(%d+)")
				return itemid
			end
		end
	end,
	function(_, value)
		if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
			local spellName, spellID = ElvUI_EltreumUI:EltruismSpellInfo(value)
			if spellName and spellID then
				if spellID == 1233637 then
					E.db.ElvUI_EltreumUI.otherstuff.datatextteleport = tostring(spellID)
				else
					E.db.ElvUI_EltreumUI.otherstuff.datatextteleport = spellName
				end
			end
		else
			local name = GetItemInfo(value)
			E.db.ElvUI_EltreumUI.otherstuff.datatextteleport = _G.tostring(name)
		end
	end)
	ElvUI_EltreumUI.Options.args.misc.args.datatext.args.teleportnolabel = E.Libs.ACH:Toggle(L["No Label"], nil, 15, nil, false, "full", function() return E.db.ElvUI_EltreumUI.otherstuff.datatextteleportnolabel end, function(_, value) E.db.ElvUI_EltreumUI.otherstuff.datatextteleportnolabel = value end)
end
