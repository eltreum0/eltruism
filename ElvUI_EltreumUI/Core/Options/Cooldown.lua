local E = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G

local function voiceplayback()
	if E.Retail then
		_G.C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, _G.TEXT_TO_SPEECH or "Text to Speech", 1, E.db.ElvUI_EltreumUI.skins.doom.ttsvolume, true)
	else
		_G.C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.skins.doom.ttsvoice, _G.TEXT_TO_SPEECH or "Text to Speech", _G.Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.skins.doom.ttsvolume)
	end
end

-- Eltruism cooldown options
function ElvUI_EltreumUI:CooldownOptions()
	if E.Retail then return end
	ElvUI_EltreumUI.Options.args.cooldown = E.Libs.ACH:Group(E:TextGradient(L["Cooldown"], 0.50, 0.70, 1, 0.67, 0.95, 1), L["Show a pulsing cooldown and let it speak the spell name"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.cooldown.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\cooldown'
	ElvUI_EltreumUI.Options.args.cooldown.args.description1 = E.Libs.ACH:Description(L["Cooldown"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cooldown.args.enable = E.Libs.ACH:Toggle(L["Enable Cooldown Pulse"], L["Show a Skill Pulse when its cooldown is ending"], 2, nil, false,'full',function() return E.db.ElvUI_EltreumUI.skins.doom.enable end,function(_, value) E.db.ElvUI_EltreumUI.skins.doom.enable = value ElvUI_EltreumUI:Doom() E:StaticPopup_Show('PRIVATE_RL') end)
	ElvUI_EltreumUI.Options.args.cooldown.args.showSpellName = E.Libs.ACH:Toggle(L["Show Spell Name"], L["Displays a Text with the name of the spell"], 3, nil, false,'full',function() return E.db.ElvUI_EltreumUI.skins.doom.showSpellName end,function(_, value) E.db.ElvUI_EltreumUI.skins.doom.showSpellName = value ElvUI_EltreumUI:Doom() E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.pet = E.Libs.ACH:Toggle(L["Show Pet Spells"], nil, 3, nil, false,'full',function() return E.db.ElvUI_EltreumUI.skins.doom.pet end,function(_, value) E.db.ElvUI_EltreumUI.skins.doom.pet = value ElvUI_EltreumUI:Doom() E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.fadeInTime = E.Libs.ACH:Range(L["Fade In Time"], L["Time it takes for the icon to fade in"], 4, { min = 0, max = 5, step = 0.1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.fadeInTime end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.fadeInTime = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.fadeOutTime = E.Libs.ACH:Range(L["Fade Out Time"], L["Time it takes for the icon to fade out"], 4, { min = 0, max = 5, step = 0.1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.fadeOutTime = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.maxAlpha = E.Libs.ACH:Range(L["Alpha"], L["Transparency of the Icon"], 4, { min = 0, max = 1, step = 0.01 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.maxAlpha end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.maxAlpha = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.animScale = E.Libs.ACH:Range(L["Animation Scale"], L["Animation will scale to this size"], 4, { min = 0, max = 15, step = 0.1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.animScale end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.animScale = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.iconSize = E.Libs.ACH:Range(L["Icon Size"], L["Size of the Icon"], 4, { min = 6, max = 200, step = 0.1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.iconSize end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.iconSize = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.holdTime = E.Libs.ACH:Range(L["Hold Time"], L["How long the Icon will appear"], 4, { min = 0, max = 5, step = 0.1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.holdTime end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.holdTime = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.graceperiod = E.Libs.ACH:Range(L["Minimum Cooldown Length"], L["Cooldowns must be longer than this to show up"], 4, { min = 0, max = 120, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.graceperiod end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.graceperiod = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.gracelimit = E.Libs.ACH:Range(L["Maximum Cooldown Length"], L["Cooldowns must be shorter than this to show up"], 4, { min = 0, max = 3601, step = 1 }, nil, function() return E.db.ElvUI_EltreumUI.skins.doom.gracelimit end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.gracelimit = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.useignore = E.Libs.ACH:Toggle(L["Enable ignoring Spells"], nil, 5, nil, false,'full',function() return E.db.ElvUI_EltreumUI.skins.doom.ignoring end,function(_, value) E.db.ElvUI_EltreumUI.skins.doom.ignoring = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or E.db.ElvUI_EltreumUI.skins.doom.allowing end)
	ElvUI_EltreumUI.Options.args.cooldown.args.doomignored = E.Libs.ACH:Input(L["Ignored Spells, use a comma to separate spells"].." ("..L["Add SpellID"]..")", L["List of spells ignored, use a comma to separate spells"], 6, false, "full", function() return E.private.ElvUI_EltreumUI.doomignored end, function(_, value) E.private.ElvUI_EltreumUI.doomignored = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or not E.db.ElvUI_EltreumUI.skins.doom.ignoring or E.db.ElvUI_EltreumUI.skins.doom.allowing end)
	ElvUI_EltreumUI.Options.args.cooldown.args.useallowed = E.Libs.ACH:Toggle(L["Enable only for listed Spells"], nil, 7, nil, false,'full',function() return E.db.ElvUI_EltreumUI.skins.doom.allowing end,function(_, value) E.db.ElvUI_EltreumUI.skins.doom.allowing = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or E.db.ElvUI_EltreumUI.skins.doom.ignoring end)
	ElvUI_EltreumUI.Options.args.cooldown.args.doomallowed = E.Libs.ACH:Input(L["Allowed Spells, use a comma to separate spells"].." ("..L["Add SpellID"]..")", L["List of spells allowed, use a comma to separate spells"], 8, false, "full", function() return E.private.ElvUI_EltreumUI.doomallowed end, function(_, value) E.private.ElvUI_EltreumUI.doomallowed = value E:StaticPopup_Show('PRIVATE_RL') end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or not E.db.ElvUI_EltreumUI.skins.doom.allowing or E.db.ElvUI_EltreumUI.skins.doom.ignoring end)
	ElvUI_EltreumUI.Options.args.cooldown.args.description2 = E.Libs.ACH:Description(L["Text to Speech"], 9, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cooldown.args.ttsvoicetoggle = E.Libs.ACH:Toggle(L["Enable"], nil, 10, nil, false,'full',function() return E.db.ElvUI_EltreumUI.skins.doom.tts end,function(_, value) E.db.ElvUI_EltreumUI.skins.doom.tts = value ElvUI_EltreumUI:Doom() end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable end)
	ElvUI_EltreumUI.Options.args.cooldown.args.ttsvoiceselect = E.Libs.ACH:Select(L["Text to Speech Config"], nil, 11, function()
		local Voices = {}
		for _, v in _G.pairs(_G.C_VoiceChat.GetTtsVoices()) do
			--Voices[i] = v.name
			Voices[v.voiceID] = v.name
		end
		return Voices
	end, false, "full", function() return E.db.ElvUI_EltreumUI.skins.doom.ttsvoice end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.ttsvoice = _G.tonumber(value) voiceplayback() end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or not E.db.ElvUI_EltreumUI.skins.doom.tts end)
	ElvUI_EltreumUI.Options.args.cooldown.args.volume = E.Libs.ACH:Range(_G.VOLUME or "", nil, 12, { min = 0, max = 100, step = 1 }, 'full', function() return E.db.ElvUI_EltreumUI.skins.doom.ttsvolume end, function(_, value) E.db.ElvUI_EltreumUI.skins.doom.ttsvolume = value end, function() return not E.db.ElvUI_EltreumUI.skins.doom.enable or not E.db.ElvUI_EltreumUI.skins.doom.tts end)
	ElvUI_EltreumUI.Options.args.cooldown.args.description3 = E.Libs.ACH:Description(_G.PREVIEW or "", 13, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.cooldown.args.preview = E.Libs.ACH:Execute(_G.PREVIEW or "", nil, 14, function() ElvUI_EltreumUI:PreviewDoom() end,nil,false,'full')
end
