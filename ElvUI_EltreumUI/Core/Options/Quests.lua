local E, _, _, P = unpack(ElvUI)
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local _G = _G
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame

-- Eltruism quest options
function ElvUI_EltreumUI:QuestOptions()
	ElvUI_EltreumUI.Options.args.quests = E.Libs.ACH:Group(E:TextGradient(_G.QUESTS_LABEL or "", 0.50, 0.70, 1, 0.67, 0.95, 1), L["Automate Quests and Gossip, add a Quest Item Bar, hide Quests during Boss fights and more"], 85, 'tab')
	ElvUI_EltreumUI.Options.args.quests.icon = 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Icons\\quest'
	ElvUI_EltreumUI.Options.args.quests.args.general = E.Libs.ACH:Group(L["General"], nil, 1)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.general.args.questboss = E.Libs.ACH:Toggle(L["Collapse Quests during Encounters/Boss Fights"], L["Collapse Quests when the boss fight starts"], 2, nil, false,'full',function() return E.db.ElvUI_EltreumUI.quests.enable end,function(_, value) E.db.ElvUI_EltreumUI.quests.enable = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.description2 = E.Libs.ACH:Description(" ", 3, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.general.args.questcombat = E.Libs.ACH:Toggle(L["Collapse Quests during any combat event"], L["Collapse Quests when you enter combat"], 4, nil, false,'full',function() return E.db.ElvUI_EltreumUI.quests.combatenable end,function(_, value) E.db.ElvUI_EltreumUI.quests.combatenable = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.description3 = E.Libs.ACH:Description(" ", 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.general.args.questarena = E.Libs.ACH:Toggle(L["Hide Quests during Battlegrounds and Arenas"], nil, 6, nil, false,'full',function() return E.db.ElvUI_EltreumUI.quests.arena end,function(_, value) E.db.ElvUI_EltreumUI.quests.arena = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.descriptionmplus = E.Libs.ACH:Description(" ", 7, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.questmplus = E.Libs.ACH:Toggle(E.NewSign..L["Hide Quests during Mythic Plus"], nil, 8, nil, false,'full',function() return E.db.ElvUI_EltreumUI.quests.mythicplus end,function(_, value) E.db.ElvUI_EltreumUI.quests.mythicplus = value E:StaticPopup_Show('CONFIG_RL') end, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.description4 = E.Libs.ACH:Description(" ", 40, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full", not E.Retail)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.objectiveanchor = E.Libs.ACH:Toggle(L["Objective Frame Anchor"], L["Reactivate the ElvUI Objective Frame Anchor and Mover"], 41, nil, false,'full',function() return E.db.ElvUI_EltreumUI.quests.anchor end,function(_, value) E.db.ElvUI_EltreumUI.quests.anchor = value E:StaticPopup_Show('CONFIG_RL') end, nil, not E.Retail)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.objectiveheight = E.Libs.ACH:Range(L["Objective Frame Height"], L["Height of the objective tracker. Increase size to be able to see more objectives."], 42, { min = 100, max = 900, step = 1 }, "full",
		function()
			if ObjectiveTrackerFrame then
				return E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight
			else
				return 1
			end
		end, function(_, value)
			if ObjectiveTrackerFrame then
				E.db.ElvUI_EltreumUI.skins.questsettings.objectiveFrameHeight = value
				ElvUI_EltreumUI:UpdateObjectiveTrackerHeight()
			end
		end, function() return not E.db.ElvUI_EltreumUI.quests.anchor end, not E.Retail)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.description5 = E.Libs.ACH:Description(" ", 43, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.general.args.wowhead = E.Libs.ACH:Toggle(L["Enable Wowhead Button on Quest Log"], L["Show a button for Wowhead quest links"], 44, nil, false, "full", function() return E.db.ElvUI_EltreumUI.skins.questswowhead end, function(_, value) E.db.ElvUI_EltreumUI.skins.questswowhead = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.quests.args.general.args.description6 = E.Libs.ACH:Description(" ", 45, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.general.args.questscale = E.Libs.ACH:Range(L["Quest Detail Scale"], nil, 46, { min = 0.01, max = 3, step = 0.01 }, "full", function() return E.db.ElvUI_EltreumUI.skins.questsettings.questScale end, function(_, value) E.db.ElvUI_EltreumUI.skins.questsettings.questScale = value if _G["QuestFrame"] then _G["QuestFrame"]:SetScale(value) end if _G["QuestLogDetailFrame"] then _G["QuestLogDetailFrame"]:SetScale(value) end if _G["QuestLogFrame"] then _G["QuestLogFrame"]:SetScale(value) end if _G["GossipFrame"] then _G["GossipFrame"]:SetScale(value) end end, function() return not E.db.ElvUI_EltreumUI.skins.quests end)
	ElvUI_EltreumUI.Options.args.quests.args.item = E.Libs.ACH:Group(L["Quest Item Bar"], nil, 2)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.description1 = E.Libs.ACH:Description(L["Quest Item Bar"], 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembar = E.Libs.ACH:Toggle(L["Enable Quest Item Bar"], L["Add a Quest Item bar, keybind can be changed in Keybinds > ElvUI Eltruism"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.questitems end,function(_, value) E.db.ElvUI_EltreumUI.quests.questitems = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembarfade = E.Libs.ACH:Toggle(L["Quest Item Bar follows visibility settings for ElvUI Action Bar 1"], L["The Quest Item Bar will appear only when ElvUI Action Bar 1 appears, following its settings"], 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.questitemsbar1 end,function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsbar1 = value E:StaticPopup_Show('CONFIG_RL') end, function() return (not E.db.ElvUI_EltreumUI.quests.questitems) or E.db.ElvUI_EltreumUI.quests.questitemsfade end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembarmouseover = E.Libs.ACH:Toggle(L["Quest Item Bar Button Mouse Over"], L["Each Button in the Quest Item Bar will appear only if the cursor is over it"], 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.questitemsfade end,function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsfade = value E:StaticPopup_Show('CONFIG_RL') end, function() return (not E.db.ElvUI_EltreumUI.quests.questitems) or E.db.ElvUI_EltreumUI.quests.questitemsbar1 end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembarkeybind = E.Libs.ACH:Toggle(L["Keybind Text"], nil, 4, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.showkeybind end,function(_, value) E.db.ElvUI_EltreumUI.quests.showkeybind = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.quests.questitems end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.description2 = E.Libs.ACH:Description(L["Quest Item Bar Button Size"], 5, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitemsbarsizex = E.Libs.ACH:Range(L["Width"], L["Change the size of the button on the Quest Item Bar"], 6, { min = 10, max = 100, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.quests.questitemsize end, function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsize = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.quests.questitems end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitemsbarsizey = E.Libs.ACH:Range(L["Height"], L["Change the size of the button on the Quest Item Bar"], 6, { min = 10, max = 100, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.quests.questitemsizey end, function(_, value) E.db.ElvUI_EltreumUI.quests.questitemsizey = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.quests.questitems end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembarspacing = E.Libs.ACH:Range(L["Button Spacing"], L["The spacing between buttons."], 7, { min = 0, max = 20, step = 1 }, "full", function() return E.db.ElvUI_EltreumUI.quests.questitemspacing end, function(_, value) E.db.ElvUI_EltreumUI.quests.questitemspacing = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.quests.questitems end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembarorientation = E.Libs.ACH:Select(L["Bar Direction"], nil, 8, {
		["HORIZONTAL"] = L["Horizontal"],
		["VERTICAL"] = L["Vertical"],
	}, false, nil, function() return E.db.ElvUI_EltreumUI.quests.questorientation end, function(_, value) E.db.ElvUI_EltreumUI.quests.questorientation = value end, function() return not E.db.ElvUI_EltreumUI.quests.questitems end)
	ElvUI_EltreumUI.Options.args.quests.args.item.args.questitembarorientation.style = "radio"
	ElvUI_EltreumUI.Options.args.quests.args.autoaccept = E.Libs.ACH:Group(L["Auto Accept"], nil, 2)
	ElvUI_EltreumUI.Options.args.quests.args.autoaccept.args.description1 = E.Libs.ACH:Description(" ", 1, nil, 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\EltreumHeader', nil, 3240, 1, "full")
	ElvUI_EltreumUI.Options.args.quests.args.autoaccept.args.autoaccept = E.Libs.ACH:Toggle(L["Enable Automatically accepting/turning in Quests when not holding CTRL/SHIFT/ALT"], L["You will automatically accept and turn in quests that do not require gold, are not weekly and are not daily"], 2, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.autoaccept end,function(_, value) E.db.ElvUI_EltreumUI.quests.autoaccept = value E:StaticPopup_Show('CONFIG_RL') end)
	ElvUI_EltreumUI.Options.args.quests.args.autoaccept.args.autoacceptdaily = E.Libs.ACH:Toggle(L["Accept Daily and Weekly quests"], L["You will also automatically accept Daily and Weekly Quests"], 3, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.acceptdaily end,function(_, value) E.db.ElvUI_EltreumUI.quests.acceptdaily = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.quests.autoaccept end)
	ElvUI_EltreumUI.Options.args.quests.args.autoaccept.args.autoacceptinvert = E.Libs.ACH:Toggle(L["Invert CTRL/SHIFT/ALT"], L["You will only accept and turn in quests if you hold CTRL/SHIFT/ALT while talking to the NPC"], 4, nil, false,'full', function() return E.db.ElvUI_EltreumUI.quests.autoacceptinvert end,function(_, value) E.db.ElvUI_EltreumUI.quests.autoacceptinvert = value E:StaticPopup_Show('CONFIG_RL') end, function() return not E.db.ElvUI_EltreumUI.quests.autoaccept end)

end
