local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local pairs = _G.pairs
local GetNumQuestWatches = _G.GetNumQuestWatches
local GetQuestLogLeaderBoard = _G.GetQuestLogLeaderBoard
local GetQuestIndexForWatch = _G.GetQuestIndexForWatch
local QuestLogTrackTracking = _G.QuestLogTrackTracking
local GetQuestLogTitle = _G.GetQuestLogTitle
local UIParent_ManageFramePositions = _G.UIParent_ManageFramePositions
local select = _G.select
local ScenarioObjectiveBlockBackground
local ScenarioObjectiveBlockBackgroundTexture
local wowheadbutton = CreateFrame("Button", nil)
local dontexpandanymorequests = 0
if E.Retail then
	ScenarioObjectiveBlockBackground = CreateFrame("Frame", "EltruismScenarioBlockBg")
	ScenarioObjectiveBlockBackgroundTexture = ScenarioObjectiveBlockBackground:CreateTexture()
end
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

function ElvUI_EltreumUI:SkinQuests()

	--create the button for wowhead
	if E.db.ElvUI_EltreumUI.skins.questswowhead then
		if E.Retail then
			wowheadbutton:SetWidth(80)
			wowheadbutton:SetHeight(20)
			wowheadbutton:SetParent(_G.WorldMapFrame)
			wowheadbutton:SetPoint("TOPRIGHT", _G.WorldMapFrame, "TOPRIGHT", -80, 0)
		elseif E.TBC or E.Classic then
			local x, y = _G.QuestFramePushQuestButton:GetSize()
			wowheadbutton:SetWidth(x)
			wowheadbutton:SetHeight(y)
			wowheadbutton:SetParent(_G.QuestLogFrame)
			wowheadbutton:SetPoint("LEFT", _G.QuestFramePushQuestButton, "LEFT", -x-2, 0)
		elseif E.Wrath then
			local x, y = _G.QuestLogFrameTrackButton:GetSize()
			wowheadbutton:SetWidth(x)
			wowheadbutton:SetHeight(y)
			wowheadbutton:SetParent(_G.QuestLogFrame)
			wowheadbutton:SetPoint("LEFT", _G.QuestLogFrameTrackButton, "RIGHT", 2, 0)
		end
		wowheadbutton:SetText("Wowhead")
		wowheadbutton:SetNormalFontObject("GameFontNormal")
		--let elvui handle the button skin
		S:HandleButton(wowheadbutton)
		--get the wowhead region based on game language region
		local wowheadregion
		if E.Retail then
			if E.locale == "deDE" then
				wowheadregion = "de.wowhead.com"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "wowhead.com"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "es.wowhead.com"
			elseif E.locale == "frFR" then
				wowheadregion = "fr.wowhead.com"
			elseif E.locale == "itIT" then
				wowheadregion = "it.wowhead.com"
			elseif E.locale == "koKR" then
				wowheadregion = "ko.wowhead.com"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "pt.wowhead.com"
			elseif E.locale == "ruRU" then
				wowheadregion = "ru.wowhead.com"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "cn.wowhead.com"
			end
		elseif E.TBC then
			if E.locale == "deDE" then
				wowheadregion = "de.tbc.wowhead.com"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "tbc.wowhead.com"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "es.tbc.wowhead.com"
			elseif E.locale == "frFR" then
				wowheadregion = "fr.tbc.wowhead.com"
			elseif E.locale == "itIT" then
				wowheadregion = "it.tbc.wowhead.com"
			elseif E.locale == "koKR" then
				wowheadregion = "ko.tbc.wowhead.com"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "pt.tbc.wowhead.com"
			elseif E.locale == "ruRU" then
				wowheadregion = "ru.tbc.wowhead.com"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "cn.tbc.wowhead.com"
			end
		elseif E.Wrath then
			if E.locale == "deDE" then
				wowheadregion = "wowhead.com/wotlk/de"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "wowhead.com/wotlk"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "wowhead.com/wotlk/es"
			elseif E.locale == "frFR" then
				wowheadregion = "wowhead.com/wotlk/fr"
			elseif E.locale == "itIT" then
				wowheadregion = "wowhead.com/wotlk/it"
			elseif E.locale == "koKR" then
				wowheadregion = "wowhead.com/wotlk/ko"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "wowhead.com/wotlk/pt"
			elseif E.locale == "ruRU" then
				wowheadregion = "wowhead.com/wotlk/ru"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "wowhead.com/wotlk/cn"
			end
		elseif E.Classic then
			if E.locale == "deDE" then
				wowheadregion = "de.classic.wowhead.com"
			elseif E.locale == "enUS" or E.locale == "enCN" or E.locale == "enGB" or E.locale == "enTW" then
				wowheadregion = "classic.wowhead.com"
			elseif E.locale == "esMX" or E.locale == "esES" then
				wowheadregion = "es.classic.wowhead.com"
			elseif E.locale == "frFR" then
				wowheadregion = "fr.classic.wowhead.com"
			elseif E.locale == "itIT" then
				wowheadregion = "it.classic.wowhead.com"
			elseif E.locale == "koKR" then
				wowheadregion = "ko.classic.wowhead.com"
			elseif E.locale == "ptBR" or E.locale == "ptPT" then
				wowheadregion = "pt.classic.wowhead.com"
			elseif E.locale == "ruRU" then
				wowheadregion = "ru.classic.wowhead.com"
			elseif E.locale == "zhCN" or E.locale == "zhTW" then
				wowheadregion = "cn.classic.wowhead.com"
			end
		end
		--register the button for clicks
		wowheadbutton:RegisterForClicks("AnyUp")

		--get questid
		if E.Retail then
			local questID
			local getquestid = CreateFrame("FRAME")
			getquestid:RegisterEvent("QUEST_DATA_LOAD_RESULT")
			getquestid:SetScript("OnEvent", function()
				questID = QuestMapFrame_GetDetailQuestID()
				if questID ~= nil then
					questID = questID
				elseif questID == nil then
					questID = _G.C_SuperTrack.GetSuperTrackedQuestID()
				end
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				if questID ~= 0 then
					E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
				else
					E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, L["No quest selected"])
				end
			end)
		elseif E.Classic or E.TBC then
			local questID
			--hook the function that sets the quest detail to get the questID from the quest title
			hooksecurefunc("QuestLog_SetSelection", function(questTitle) --questlogframe.lua 311
				questID = select(8, GetQuestLogTitle(questTitle))
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
			end)
		elseif E.Wrath then
			local questID
			--hook the function that sets the quest detail to get the questID from the quest title
			hooksecurefunc("QuestLog_SetSelection", function(questTitle) --_G.QuestLogFrame.lua 311
				questID = select(8, GetQuestLogTitle(questTitle))
			end)
			--set the link to show when the button is clicked
			wowheadbutton:SetScript('OnClick', function()
				E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, "https://"..wowheadregion.."/quest="..questID)
			end)
		end
	else
		wowheadbutton:Hide()
	end

	if E.db.ElvUI_EltreumUI.skins.quests and E.private.skins.blizzard.objectiveTracker and E.private.skins.blizzard.enable then
		if E.Retail then
			-- and (not IsAddOnLoaded("ElvUI_WindTools"))
			if (not IsAddOnLoaded('!KalielsTracker')) and (not IsAddOnLoaded('SorhaQuestLog')) and (not IsAddOnLoaded('ClassicQuestLog')) and (not IsAddOnLoaded('Who Framed Watcher Wabbit?')) then
				--WQs banner
				local ObjectiveTrackerBonusBannerFrame = _G.ObjectiveTrackerBonusBannerFrame
				if ObjectiveTrackerBonusBannerFrame then
					--textcoords from https://www.townlong-yak.com/framexml/39229/Helix/AtlasInfo.lua
					ObjectiveTrackerBonusBannerFrame.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					ObjectiveTrackerBonusBannerFrame.Title:SetText("") --so that the text doesn't show up when it shouldnt
					ObjectiveTrackerBonusBannerFrame.Icon:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.Icon:SetTexCoord(0.482422, 0.785156, 0.00195312, 0.294922)
					ObjectiveTrackerBonusBannerFrame.Icon2:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.Icon2:SetTexCoord(0.482422, 0.785156, 0.00195312, 0.294922)
					ObjectiveTrackerBonusBannerFrame.Icon3:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.Icon3:SetTexCoord(0.482422, 0.785156, 0.00195312, 0.294922)
					ObjectiveTrackerBonusBannerFrame.BG1:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.BG1:SetTexCoord(0.00195312, 0.818359, 0.359375, 0.507812)
					ObjectiveTrackerBonusBannerFrame.BG2:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\bonusobjectives")
					ObjectiveTrackerBonusBannerFrame.BG2:SetTexCoord(0.00195312, 0.818359, 0.359375, 0.507812)
					ObjectiveTrackerBonusBannerFrame.BG1:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.BG2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-bg
					ObjectiveTrackerBonusBannerFrame.Icon:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.Icon2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
					ObjectiveTrackerBonusBannerFrame.Icon3:SetVertexColor(classcolor.r, classcolor.g, classcolor.b) --bonusobjectives-title-icon
				end

				--Interface/AddOns/Blizzard_ObjectiveTracker/Blizzard_ObjectiveTracker.lua
				local questmodules = {
					QUEST_TRACKER_MODULE,
					ACHIEVEMENT_TRACKER_MODULE,
					BONUS_OBJECTIVE_TRACKER_MODULE,
					WORLD_QUEST_TRACKER_MODULE,
					UI_WIDGET_TRACKER_MODULE,
					CAMPAIGN_QUEST_TRACKER_MODULE,
				}
				local mult = 0.85
				for _, k in pairs(questmodules) do
					hooksecurefunc(k, "AddObjective", function(_, block,objectiveKey,_,lineType)
						if not block then
							return
						end
						if E.db.ElvUI_EltreumUI.skins.shadow.enable then --minimize shadows
							if k.Header.MinimizeButton and not k.Header.MinimizeButton.shadow then
								k.Header.MinimizeButton:CreateShadow()
								k.Header.MinimizeButton.shadow:ClearAllPoints()
								k.Header.MinimizeButton.shadow:SetPoint("TOPLEFT", k.Header.MinimizeButton.tex, "TOPLEFT", -1,1)
								k.Header.MinimizeButton.shadow:SetPoint("BOTTOMRIGHT", k.Header.MinimizeButton.tex, "BOTTOMRIGHT", 1,-1)
								if EnhancedShadows then EnhancedShadows:RegisterShadow(k.Header.MinimizeButton.shadow) end
							end
						end
						if block.HeaderText then --quest title
							block.HeaderText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+1, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
								block.HeaderText:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							else
								block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							end
							block.HeaderText:SetWordWrap(true)
						end
						if block.currentLine then --quest text
							if block.currentLine.objectiveKey == 0 then --also quest title
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									block.currentLine.Text:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									block.currentLine.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
								end
								block.currentLine.Text:SetWordWrap(true)
							else --step/description of the quest
								block.currentLine.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
								block.currentLine.Text:SetTextColor(mult, mult, mult)
								block.currentLine.Text:SetWordWrap(true)
							end
						end
						local line = DEFAULT_OBJECTIVE_TRACKER_MODULE:GetLine(block, objectiveKey, lineType)
						if ( line.Dash ) then
							if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
								line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							else
								line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						end
					end)
				end

				if _G.ObjectiveTrackerFrame.HeaderMenu.Title then --fix when collapsed
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize*1.5, E.db.general.fontStyle)
					_G.ObjectiveTrackerFrame.HeaderMenu.Title:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end

				hooksecurefunc('ObjectiveTracker_Update', function ()
					local modules = ObjectiveTrackerFrame.MODULES
					if not modules then
						return
					end
					for i = 1, #modules do
						local module = modules[i]
						if module and module.Header and module.Header.Text then --the big type of quest
							if not IsAddOnLoaded("ElvUI_SLE") then
								module.Header.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize*1.5, E.db.general.fontStyle)
							end
							if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
								module.Header.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							else
								module.Header.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
							module.Header.Text:SetShadowColor(0, 0, 0, 0.8)
							module.Header.Text:SetShadowOffset(2, -1)

							--create the lines
							if not module.Header.EltruismStatusLine then
								if IsAddOnLoaded("ElvUI_SLE") then
									if E.private["sle"]["skins"]["objectiveTracker"]["enable"] then
										return
									end
								end
								if module.Header.Text and module.Header.Text:GetText() ~= nil then
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "Eltruism"..module.Header.Text:GetText().."Line", module.Header)
								else
									module.Header.EltruismStatusLine = CreateFrame("StatusBar", "EltruismLine", module.Header)
								end
								module.Header.EltruismStatusLine:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
								module.Header.EltruismStatusLine:SetPoint("BOTTOM", module.Header, 0, 0)
								module.Header.EltruismStatusLine:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))
								if not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor then
									if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
										module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
									else
										module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
									end
								else
									module.Header.EltruismStatusLine:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g,E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b,E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r,E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g,E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b)
								end
								module.Header.EltruismStatusLine:SetFrameLevel(1)
								if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not module.Header.EltruismStatusLine.shadow then
									module.Header.EltruismStatusLine:CreateBackdrop('Transparent')
									module.Header.EltruismStatusLine:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
									if EnhancedShadows then EnhancedShadows:RegisterShadow(module.Header.EltruismStatusLine.shadow) end
								end
							end
						end
					end
				end)

				--skin the progress bars
				local function EltreumSkinProgressBars(_, _, line)
					local progressBar = line and line.ProgressBar
					local bar = progressBar and progressBar.Bar
					if not bar or progressBar.EltruismSkin then
						return
					else
						if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow then
							bar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(bar.shadow) end
							if progressBar.block and progressBar.Bar.Icon then
								progressBar.block:CreateShadow()
								progressBar.block.shadow:ClearAllPoints()
								progressBar.block.shadow:SetPoint("TOPLEFT", progressBar.Bar.Icon, "TOPLEFT", -3,3)
								progressBar.block.shadow:SetPoint("BOTTOMRIGHT", progressBar.Bar.Icon, "BOTTOMRIGHT", 3,-3)
							end
						end
						progressBar.Bar.backdrop:SetAlpha(0.7)
						--progressBar:SetBackdropColor(0, 0, 0, 1)
						--progressBar.Bar.backdrop:SetBackdropBorderColor(0, 0, 0, 1)
						progressBar.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.queststatusbartexture))
						progressBar.EltruismSkin = true
					end
				end
				hooksecurefunc(QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(BONUS_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(CAMPAIGN_QUEST_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(SCENARIO_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)
				hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddProgressBar", EltreumSkinProgressBars)

				hooksecurefunc(SCENARIO_CONTENT_TRACKER_MODULE, 'UpdateCriteria', function ()
					if ScenarioObjectiveBlock then
						local frames = {ScenarioObjectiveBlock:GetChildren()}
						for _, frame in pairs(frames) do
							if frame.Text then
								frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle) --this is the objective like boss 1/1
								frame.Text:SetTextColor(1, 1, 1) --dungeon obj text
								frame.Text:SetWordWrap(true)
							end
						end
					end
				end)

				if _G.ScenarioObjectiveBlock then
					local frames = {_G.ScenarioObjectiveBlock:GetChildren()}
					for _, frame in pairs(frames) do
						if frame.Text then
							frame.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+2, E.db.general.fontStyle)
							if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
								frame.Text:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							else
								frame.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							end
							frame.Text:SetWordWrap(true)
						end
					end
				end

				--skin the dungeon/raid/scenario bg
				hooksecurefunc(_G["SCENARIO_CONTENT_TRACKER_MODULE"], "Update", function ()
					ScenarioObjectiveBlockBackground:SetParent(_G.ScenarioStageBlock)
					ScenarioObjectiveBlockBackground:ClearAllPoints()
					--ScenarioObjectiveBlockBackground:SetAllPoints(_G.ScenarioStageBlock.NormalBG)
					ScenarioObjectiveBlockBackground:SetPoint("CENTER", _G.EltruismScenarioLine, "CENTER", 5, -47)
					ScenarioObjectiveBlockBackground:SetSize(250, 80)
					ScenarioObjectiveBlockBackground:CreateBackdrop('Transparent')
					ScenarioObjectiveBlockBackgroundTexture:SetTexture("Interface\\Addons\\ElvUI\\Code\\Media\\Textures\\White8x8.tga")
					ScenarioObjectiveBlockBackgroundTexture:SetColorTexture(0, 0, 0, 0.01)
					ScenarioObjectiveBlockBackgroundTexture:SetAlpha(0.01)
					ScenarioObjectiveBlockBackgroundTexture:SetAllPoints(_G.ScenarioStageBlock.NormalBG)
					ScenarioObjectiveBlockBackground:Show()
					ScenarioObjectiveBlockBackgroundTexture:Show()
					if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not ScenarioObjectiveBlockBackground.shadow then
						ScenarioObjectiveBlockBackground:CreateBackdrop('Transparent')
						ScenarioObjectiveBlockBackground:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(ScenarioObjectiveBlockBackground.shadow) end
					end
					_G.ScenarioStageBlock.NormalBG:Hide()
					_G.ScenarioStageBlock.FinalBG:Hide()
					--dungeon/raid/scenario name text
					if _G.ScenarioStageBlock.Stage then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							_G.ScenarioStageBlock.Stage:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
						else
							_G.ScenarioStageBlock.Stage:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
						end
						_G.ScenarioStageBlock.Stage:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+6, E.db.general.fontStyle)
						_G.ScenarioStageBlock.Stage:SetShadowColor(0, 0, 0, 0.8)
						_G.ScenarioStageBlock.Stage:SetShadowOffset(2, -1)
					end
				end)

				--on mouse enter and leave
				hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					if ( block.HeaderText ) then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							block.HeaderText.colorStyle = {r = E.db.ElvUI_EltreumUI.skins.questsettings.customr, g = E.db.ElvUI_EltreumUI.skins.questsettings.customg, b = E.db.ElvUI_EltreumUI.skins.questsettings.customb}
						else
							block.HeaderText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							block.HeaderText.colorStyle = {r = classcolor.r, g = classcolor.g, b = classcolor.b}
						end
					end
					if block.currentLine then --this is the text
						for _, line in pairs(block.lines) do
							line.Text:SetTextColor(1, 1, 1)
							line.Text.colorStyle = {r = mult * 1, g = mult * 1, b = mult * 1}
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end)

				hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					if ( block.HeaderText ) then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							block.HeaderText.colorStyle = {r = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, g = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, b = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb}
						else
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							block.HeaderText.colorStyle = { r = mult * classcolor.r, g = mult * classcolor.g, b = mult * classcolor.b }
						end
					end
					if block.currentLine then
						for _, line in pairs(block.lines) do
							line.Text:SetTextColor(mult, mult, mult)
							line.Text.colorStyle = {r = mult, g = mult, b = mult}
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end)

				hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					if block.currentLine then --this is the text
						for objectiveKey, line in pairs(block.lines) do --Blizzard_ObjectiveTracker.lua#L458
							if objectiveKey == 0 then --its the title
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							else -- its the subtext
								line.Text:SetTextColor(1, 1, 1)
							end
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end)

				hooksecurefunc(WORLD_QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					if block.currentLine then
						for objectiveKey, line in pairs(block.lines) do --Blizzard_ObjectiveTracker.lua#L458
							if objectiveKey == 0 then --its the title
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Text:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Text:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
								end
							else -- its the subtext
								line.Text:SetTextColor(mult, mult, mult)
							end
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end)

				hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderEnter", function(_, block)
					if ( block.HeaderText ) then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							block.HeaderText.colorStyle = {r = E.db.ElvUI_EltreumUI.skins.questsettings.customr, g = E.db.ElvUI_EltreumUI.skins.questsettings.customg, b = E.db.ElvUI_EltreumUI.skins.questsettings.customb}
						else
							block.HeaderText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							block.HeaderText.colorStyle = {r = classcolor.r, g = classcolor.g, b = classcolor.b}
						end
					end
					if block.currentLine then --this is the text
						for _, line in pairs(block.lines) do
							line.Text:SetTextColor(1, 1, 1)
							line.Text.colorStyle = {r = mult * 1, g = mult * 1, b = mult * 1}
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end)

				hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderLeave", function(_, block)
					if ( block.HeaderText ) then
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							block.HeaderText:SetTextColor(mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb)
							block.HeaderText.colorStyle = {r = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customr, g = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customg, b = mult * E.db.ElvUI_EltreumUI.skins.questsettings.customb}
						else
							block.HeaderText:SetTextColor(mult * classcolor.r, mult * classcolor.g, mult * classcolor.b)
							block.HeaderText.colorStyle = { r = mult * classcolor.r, g = mult * classcolor.g, b = mult * classcolor.b }
						end
					end
					if block.currentLine then
						for _, line in pairs(block.lines) do
							line.Text:SetTextColor(mult, mult, mult)
							line.Text.colorStyle = {r = mult, g = mult, b = mult}
							if ( line.Dash ) then
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									line.Dash:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									line.Dash:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end)
			end
		elseif E.Classic or E.TBC then
			if IsAddOnLoaded('!KalielsTracker') or IsAddOnLoaded('SorhaQuestLog') or IsAddOnLoaded('ClassicQuestLog') or IsAddOnLoaded('Who Framed Watcher Wabbit?') then
				return
			end

			--move the text for no quests
			_G.QuestLogNoQuestsText:ClearAllPoints()
			_G.QuestLogNoQuestsText:SetPoint("CENTER", _G.QuestLogFrame, 0, 0)
			--make the whole thing bigger almost like retail
			_G.QuestLogFrame:SetWidth(765)
			_G.QuestLogFrame:SetHeight(550)
			--move the frame title
			_G.QuestLogTitleText:ClearAllPoints()
			_G.QuestLogTitleText:SetPoint("TOP", _G.QuestLogFrame, "TOP", 0, -20)
			--increase the size of the quest title frame
			_G.QuestLogListScrollFrame:SetHeight(390)
			_G.QuestLogListScrollFrame:SetWidth(350)
			--increase the size of the quest description frame and move it
			_G.QuestLogDetailScrollFrame:ClearAllPoints()
			_G.QuestLogDetailScrollFrame:SetPoint("TOPLEFT", _G.QuestLogListScrollFrame, "TOPRIGHT", 35, 0)
			_G.QuestLogDetailScrollFrame:SetHeight(390)

			-- Create the additional rows
			--local numQuests = QUESTS_DISPLAYED
			local numQuests = 6
			--QUESTS_DISPLAYED = QUESTS_DISPLAYED + 18
			_G.QUESTS_DISPLAYED = 24
			if dontexpandanymorequests == 0 then
				for i = numQuests + 1, 24 do
					local questTitlebutton = CreateFrame("Button", "QuestLogTitle" .. i, _G.QuestLogFrame, "QuestLogTitleButtonTemplate")
					questTitlebutton:SetID(i)
					questTitlebutton:Hide()
					questTitlebutton:ClearAllPoints()
					questTitlebutton:SetPoint("TOPLEFT", _G["QuestLogTitle" .. (i - 1)], "BOTTOMLEFT", 0, 1)
				end
				--increase the width of the rows so the title fits
				for i = 1, 24 do
					local questTitle = _G["QuestLogTitle"..i]
					questTitle:Width(335)
				end
				dontexpandanymorequests = 1
			end

			if IsAddOnLoaded('Questie') then
				if _G.Questie.db.global.trackerEnabled then
					return
				end
			end

			--add quest header like retail/wrath
			if not _G["EltruismQuestLine"] then
				_G.QuestWatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", _G.QuestWatchFrame)
			else
				_G.QuestWatchFrame.HeaderBar = _G["EltruismQuestLine"]
			end
			_G.QuestWatchFrame.HeaderBar:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
			_G.QuestWatchFrame.HeaderBar:SetPoint("TOP", _G.QuestWatchFrameMover, "TOP", 40, 0)
			_G.QuestWatchFrame.HeaderBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))
			--_G.QuestWatchFrame.HeaderBar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b)
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
				_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
			else
				_G.QuestWatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
			end
			if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G["EltruismQuestLine"].shadow then
				_G.QuestWatchFrame.HeaderBar:CreateBackdrop('Transparent')
				_G.QuestWatchFrame.HeaderBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G.QuestWatchFrame.HeaderBar.shadow) end
			end
			local InvisFrameHeaderBar = CreateFrame("Frame", nil, _G.QuestWatchFrame.HeaderBar)
			InvisFrameHeaderBar:SetFrameLevel(_G.QuestWatchFrame.HeaderBar:GetFrameLevel() + 10)
			InvisFrameHeaderBar:SetInside()
			local QuestWatchFrameTitle = _G.QuestWatchFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
			QuestWatchFrameTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+3, E.db.general.fontStyle)
			if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
				QuestWatchFrameTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
			else
				QuestWatchFrameTitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
			end
			QuestWatchFrameTitle:SetParent(InvisFrameHeaderBar)
			QuestWatchFrameTitle:ClearAllPoints()
			QuestWatchFrameTitle:SetPoint("LEFT", InvisFrameHeaderBar, 6, 8)

			--from blizzard's FrameXML/_G.QuestLogFrame.lua
			--skin the classic objective frame
			hooksecurefunc("QuestWatch_Update",function()

				local NumQuests = select(2, GetNumQuestLogEntries())
				if (NumQuests >= (MAX_QUESTS - 5)) then
					QuestWatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, "Quests"))
				else
					QuestWatchFrameTitle:SetText(format("%d/%d - %s", NumQuests, MAX_QUESTS, "Quests"))
				end
				if (GetNumQuestWatches() == 0) then
					_G.QuestWatchFrame.HeaderBar:SetAlpha(0)
				else
					_G.QuestWatchFrame.HeaderBar:SetAlpha(1)
				end


				local numObjectives
				local questWatchMaxWidth = 0
				local tempWidth
				local watchText
				--local text, type, finished --type is unused
				local text, _, finished
				--local questTitle --unused
				local watchTextIndex = 1
				local questIndex
				local objectivesCompleted

				for i=1, GetNumQuestWatches() do
					questIndex = GetQuestIndexForWatch(i)
					if ( questIndex ) then
						numObjectives = GetNumQuestLeaderBoards(questIndex)

						--If there are objectives set the title
						if ( numObjectives > 0 ) then
							-- Set title
							watchText = _G["QuestWatchLine"..watchTextIndex]
							watchText:SetText(GetQuestLogTitle(questIndex))
							watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
							--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)

							tempWidth = watchText:GetWidth()
							-- Set the anchor of the title line a little lower
							if ( watchTextIndex > 1 ) then
								--watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -4)
								watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -10)
								--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
							watchText:Show()
							if ( tempWidth > questWatchMaxWidth ) then
								questWatchMaxWidth = tempWidth
							end
							watchTextIndex = watchTextIndex + 1
							objectivesCompleted = 0
							for j=1, numObjectives do
								text, _, finished = GetQuestLogLeaderBoard(j, questIndex)
								if ( text == nil ) then
									text = ""
								end
								if ( finished == nil ) then
									finished = true
								end
								watchText = _G["QuestWatchLine"..watchTextIndex]
								-- Set Objective text
								watchText:SetText(" - "..text)
								watchText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
								--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								-- Color the objectives
								if ( finished ) then
									watchText:SetTextColor(0, 1, 0)
									--watchText:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
									objectivesCompleted = objectivesCompleted + 1
								else
									watchText:SetTextColor(0.8, 0.8, 0.8)
								end
								tempWidth = watchText:GetWidth()
								if ( tempWidth > questWatchMaxWidth ) then
									questWatchMaxWidth = tempWidth
								end
								--watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, 0)
								watchText:SetPoint("TOPLEFT", "QuestWatchLine"..(watchTextIndex - 1), "BOTTOMLEFT", 0, -5)
								--watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								watchText:Show()
								watchTextIndex = watchTextIndex + 1
							end
							-- Brighten the quest title if all the quest objectives were met
							watchText = _G["QuestWatchLine"..watchTextIndex-numObjectives-1]
							if ( objectivesCompleted == numObjectives ) then
								--watchText:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
								watchText:SetTextColor(0, 1, 0)
							else
								if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
									watchText:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
								else
									watchText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
								end
							end
						end
					end
				end

				-- Set tracking indicator
				if ( GetNumQuestWatches() > 0 ) then
					QuestLogTrackTracking:SetVertexColor(0, 1.0, 0)
				else
					QuestLogTrackTracking:SetVertexColor(1.0, 0, 0)
				end

				-- If no watch lines used then hide the frame and return
				if ( watchTextIndex == 1 ) then
					_G.QuestWatchFrame:Hide()
					return
				else
					_G.QuestWatchFrame:Show()
					_G.QuestWatchFrame:SetHeight(watchTextIndex * 13)
					_G.QuestWatchFrame:SetWidth(questWatchMaxWidth + 10)
				end

				-- Hide unused watch lines
				for i=watchTextIndex, MAX_QUESTWATCH_LINES do
					_G["QuestWatchLine"..i]:Hide()
				end

				UIParent_ManageFramePositions()
			end)
		elseif E.Wrath then
			if IsAddOnLoaded('!KalielsTracker') or IsAddOnLoaded('SorhaQuestLog') or IsAddOnLoaded('ClassicQuestLog') or IsAddOnLoaded('Who Framed Watcher Wabbit?') then
				return
			end

			if IsAddOnLoaded('Questie') then --questie overwrites the default tracker sadly instead of hooking into it
				if _G.Questie.db.global.trackerEnabled then
					return
				end
			end
			--from blizzard's FrameXML/WatchFrame.lua
			local questside
			if _G.ObjectiveFrameMover then
				questside = _G.ObjectiveFrameMover:GetPoint()
			else
				questside = "RIGHT"
			end
			--skin the classic objective frame, based on aftermathh's
			local function colorquests(line, _, _, isHeader, text, _, _, isComplete) --(line, anchor, verticalOffset, isHeader, text, dash, hasItem, isComplete)
				if line and line.text then
					if ( isHeader ) then
						--line.text:SetTextColor(0.75, 0.61, 0)
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
						if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
							line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
						else
							line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
						line.text:SetWidth(250)
					elseif isComplete then
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
						line.text:SetTextColor(0, 1, 0)
						line.text:SetWidth(250)
					else
						line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
						line.text:SetTextColor(0.8, 0.8, 0.8)
						line.text:SetWidth(250)
					end
					if line.dash then
						line.dash:Hide()
					end
				end

				local WatchFrame = _G.WatchFrame
				local WatchFrameLines = _G.WatchFrameLines

				if not _G["EltruismQuestLine"] then
					WatchFrame.HeaderBar = CreateFrame("StatusBar", "EltruismQuestLine", WatchFrameLines)
				else
					WatchFrame.HeaderBar = _G["EltruismQuestLine"]
				end
				WatchFrame.HeaderBar:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.sizex, E.db.ElvUI_EltreumUI.skins.questsettings.sizey)
				WatchFrame.HeaderBar:SetPoint("TOP", WatchFrame, "TOP", 0, -23)
				WatchFrame.HeaderBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.questsettings.texture))
				--WatchFrame.HeaderBar:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b)
				if not E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
						WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass))
					else
						WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass))
					end
				else
					WatchFrame.HeaderBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1g, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor1b, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2r, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2g, E.db.ElvUI_EltreumUI.skins.questsettings.linecustomcolor2b)
				end

				if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not _G["EltruismQuestLine"].shadow then
					_G["EltruismQuestLine"]:CreateBackdrop('Transparent')
					_G["EltruismQuestLine"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["EltruismQuestLine"].shadow) end
				end

				local InvisFrameHeaderBar = CreateFrame("Frame", nil, WatchFrame.HeaderBar)
				InvisFrameHeaderBar:SetFrameLevel(WatchFrame.HeaderBar:GetFrameLevel() + 10)
				InvisFrameHeaderBar:SetInside()

				local WatchFrameTitle = _G.WatchFrameTitle
				WatchFrameTitle:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize+3, E.db.general.fontStyle)
				if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
					WatchFrameTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
				else
					WatchFrameTitle:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end

				WatchFrameTitle:SetParent(InvisFrameHeaderBar)
				WatchFrameTitle:ClearAllPoints()
				WatchFrameTitle:SetPoint("LEFT", InvisFrameHeaderBar, 6, 8)

				local NumQuests = select(2, GetNumQuestLogEntries())

				if (NumQuests >= (MAX_QUESTS - 5)) then
					WatchFrameTitle:SetText(format("|CFFFF0000%d/%d|r - %s", NumQuests, MAX_QUESTS, "Quests"))
				else
					WatchFrameTitle:SetText(format("%d/%d - %s", NumQuests, MAX_QUESTS, "Quests"))
				end

				if (GetNumQuestWatches() == 0) then
					WatchFrame.HeaderBar:SetAlpha(0)
				else
					WatchFrame.HeaderBar:SetAlpha(1)
				end

				for i = 1, _G.WATCHFRAME_NUM_ITEMS do
					local Button = _G["WatchFrameItem"..i]
					if not (Button) then
						return
					end
					local _, Anchor = Button:GetPoint()
					Button:ClearAllPoints()
					if _G["WatchFrameItem"..i.."HotKey"] then
						_G["WatchFrameItem"..i.."HotKey"]:SetText("")
					end
					if Anchor ~= nil then
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", Anchor, "LEFT", -40, -10)
						else
							Button:SetPoint("RIGHT", Anchor, "RIGHT", 120, -10)
						end
					--elseif Anchor == nil then
						--Button:SetPoint("LEFT", _G["WatchFrameLine"..i.."Text"], "LEFT", -40, -10)
						if not (Button.QuestTexture) then
							if _G["EltruismQuestTexture"] then
								Button.QuestTexture = _G["EltruismQuestTexture"]
							else
								Button.QuestTexture = Button:CreateTexture("EltruismQuestTexture")
							end
							Button.QuestTexture:SetSize(24, 24)
							if questside:match("RIGHT") then
								Button.QuestTexture:SetPoint("LEFT", Button, "LEFT", -12, 0)
							else
								Button.QuestTexture:SetPoint("RIGHT", Button, "RIGHT", 26, 0)
							end
							Button.QuestTexture:SetTexture(E.Media.Textures.BagQuestIcon)
							Button.QuestTexture:SetParent(Button)
						end
						Button:SetSize(E.db.ElvUI_EltreumUI.skins.questsettings.linebuttonsize, E.db.ElvUI_EltreumUI.skins.questsettings.linebuttonsize)
						if E.db.ElvUI_EltreumUI.skins.questsettings.lineshadow and not Button.shadow then
							Button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(Button.shadow) end
						end
						S:HandleButton(Button)
						local texture = _G["WatchFrameItem"..i.."IconTexture"]
						texture:SetTexCoord(0.08,0.92,0.08,0.92)
					else
						Button:ClearAllPoints()
						if _G["EltruismQuestTexture"] then
							_G["EltruismQuestTexture"]:ClearAllPoints()
						end
					end
				end
			end
			hooksecurefunc("WatchFrame_SetLine", colorquests)
			hooksecurefunc("WatchFrame_Update",colorquests)

			--fix? item moving to wrong side
			hooksecurefunc("WatchFrameItem_OnEvent", function()
				for i = 1, _G.WATCHFRAME_NUM_ITEMS do
					local Button = _G["WatchFrameItem"..i]
					if not (Button) then
						return
					end
					local _, Anchor = Button:GetPoint()
					Button:ClearAllPoints()
					if _G["WatchFrameItem"..i.."HotKey"] then
						_G["WatchFrameItem"..i.."HotKey"]:SetText("")
					end
					if Anchor ~= nil then
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", Anchor, "LEFT", -40, -10)
						else
							Button:SetPoint("RIGHT", Anchor, "RIGHT", 120, -10)
						end
					elseif Anchor == nil then
						if questside:match("RIGHT") then
							Button:SetPoint("LEFT", _G["WatchFrameLine"..i.."Text"], "LEFT", -40, -10)
						else
							Button:SetPoint("RIGHT", _G["WatchFrameLine"..i.."Text"], "RIGHT", 120, -10)
						end
					end
				end
			end)

			_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
			_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
			_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
			_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)

			if not _G["WatchFrameCollapseExpandButton"].shadow then
				_G["WatchFrameCollapseExpandButton"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				_G["WatchFrameCollapseExpandButton"].shadow:ClearAllPoints()
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("TOPLEFT", _G["WatchFrameCollapseExpandButton"], "TOPLEFT", -1, 1)
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("TOPRIGHT", _G["WatchFrameCollapseExpandButton"], "TOPRIGHT", 1, 1)
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("BOTTOMLEFT", _G["WatchFrameCollapseExpandButton"], "BOTTOMLEFT", -1, -1)
				_G["WatchFrameCollapseExpandButton"].shadow:SetPoint("BOTTOMLEFT", _G["WatchFrameCollapseExpandButton"], "BOTTOMLEFT", 1, -1)
				if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["WatchFrameCollapseExpandButton"].shadow) end
			end

			hooksecurefunc("WatchFrame_Collapse", function()
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\PlusButton")
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\PlusButton")
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)

			end)
			hooksecurefunc("WatchFrame_Expand", function()
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
				_G["WatchFrameCollapseExpandButton"]:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexture("Interface\\Addons\\ElvUI\\Core\\Media\\Textures\\MinusButton")
				_G["WatchFrameCollapseExpandButton"]:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
			end)

			--highlight
			hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
				local line
				_G.WatchFrame_Update()
				for index = self.startLine, self.lastLine do
					line = self.lines[index]
					if ( line ) then
						if line.text:GetTextColor() == 0 and 0.99999779462814 and 0 and 0.99999779462814 then
							line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
							line.text:SetWidth(250)
						else
							if ( index == self.startLine ) then
								-- header
								if ( onEnter ) then

									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr+0.2, E.db.ElvUI_EltreumUI.skins.questsettings.customg+0.2, E.db.ElvUI_EltreumUI.skins.questsettings.customb+0.2)
									else
										line.text:SetTextColor(classcolor.r+0.2, classcolor.g+0.2, classcolor.b+0.2)
									end
									line.text:SetWidth(250)
								else
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
									if E.db.ElvUI_EltreumUI.skins.questsettings.customcolor then
										line.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.questsettings.customr, E.db.ElvUI_EltreumUI.skins.questsettings.customg, E.db.ElvUI_EltreumUI.skins.questsettings.customb)
									else
										line.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
									end
									line.text:SetWidth(250)
								end
							else
								if ( onEnter ) then
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
									line.text:SetTextColor(1, 1, 1)
									--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
									--line.dash:SetTextColor(1, 1, 1)
									line.text:SetWidth(250)
								else
									line.text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
									line.text:SetTextColor(0.8, 0.8, 0.8)
									--line.dash:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.questsettings.fontSize, E.db.general.fontStyle)
									--line.dash:SetTextColor(0.8, 0.8, 0.8)
									line.text:SetWidth(250)
									--line.text:ClearAllPoints()
									--line.text:SetPoint("LEFT", line.dash, "RIGHT")
								end
							end
						end
					end
				end
			end)
			_G.WatchFrame_Update()
		end
	end
end
