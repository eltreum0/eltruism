local E, L= unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local EnableAddOn = _G.C_AddOns and _G.C_AddOns.EnableAddOn or _G.EnableAddOn
local DisableAddOn = _G.C_AddOns and _G.C_AddOns.DisableAddOn or _G.DisableAddOn
local GetAddOnInfo = _G.C_AddOns and _G.C_AddOns.GetAddOnInfo or _G.GetAddOnInfo
local select = _G.select
local gsub = _G.gsub
local ipairs = _G.ipairs
local type = _G.type
local format = _G.format
local CreateFrame = _G.CreateFrame
local strsplit = _G.strsplit
local strlen = _G.strlen

--adapted from windtools with authorization from fang2hou, ty again fang

local function ConstructCompatibilityFrame()
	local frame = CreateFrame("Frame", "EltruismCompatibilityFrame", E.UIParent)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
	frame:SetClampedToScreen(true)
	frame:SetSize(550, 500)
	frame:SetPoint("CENTER")
	--frame:CreateBackdrop("Transparent")
	S:HandleFrame(frame)
	frame.numModules = 0
	frame:Hide()
	frame:SetScript("OnHide", function()
		if frame.configChanged then
			E:StaticPopup_Show("PRIVATE_RL")
		end
	end)
	if not frame.shadow then
		frame:CreateShadow()
		ElvUI_EltreumUI:ShadowColor(frame.shadow)
	end

	frame:SetFrameStrata("TOOLTIP")
	frame:SetFrameLevel(9000)

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton, BackdropTemplate")
	close:SetScript("OnClick", function() frame:Hide() end)
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT")
	close:SetFrameLevel(frame:GetFrameLevel() + 1)
	S:HandleCloseButton(close)

	local title = frame:CreateFontString(nil, "ARTWORK")
	title:FontTemplate()
	title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	title:SetText(ElvUI_EltreumUI.Name.." "..L["Compatibility Check"])
	title:SetPoint("TOP", frame, "TOP", 0, -10)

	local desc = frame:CreateFontString(nil, "ARTWORK")
	desc:FontTemplate()
	desc:SetJustifyH("CENTER")
	desc:SetWidth(420)
	desc:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	desc:SetText(L["AddOns that do the same thing can cause issues, to prevent errors you should pick between them below. Choose what you prefer!"])
	desc:SetPoint("TOP", frame, "TOP", 0, -40)

	local largeTip = frame:CreateFontString(nil, "ARTWORK")
	largeTip:FontTemplate()
	largeTip:SetJustifyH("CENTER")
	largeTip:SetWidth(500)
	largeTip:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	largeTip:SetText(E:TextGradient("Choose the option you would like to enable", 0.50, 0.70, 1, 0.67, 0.95, 1))
	largeTip:SetPoint("TOP", desc, "BOTTOM", 0, -10)

	local bottomDesc = frame:CreateFontString(nil, "ARTWORK")
	bottomDesc:FontTemplate()
	bottomDesc:SetJustifyH("CENTER")
	bottomDesc:SetWidth(530)
	bottomDesc:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	bottomDesc:SetText(E.NewSign ..format(L["If you find the %s option has issues, alert me via Discord or GitHub issue."], select(2,GetAddOnInfo("ElvUI_EltreumUI"))))
	bottomDesc:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)

	local completeButton = CreateFrame("Button", "EltruismCompatibilityFrameCompleteButton", frame, "UIPanelButtonTemplate, BackdropTemplate")
	completeButton.Text:SetText(L["Complete"])
	completeButton.Text:SetJustifyH("CENTER")
	completeButton.Text:SetJustifyV("CENTER")
	completeButton.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	completeButton:SetSize(350, 35)
	completeButton:SetPoint("BOTTOM", bottomDesc, "TOP", 0, 10)
	S:HandleButton(completeButton)
	completeButton:SetScript("OnClick",function() frame:Hide() end)

	local scrollFrameParent = CreateFrame("ScrollFrame", "EltruismCompatibilityFrameScrollFrameParent", frame, "UIPanelScrollFrameTemplate")
	scrollFrameParent:CreateBackdrop("Transparent")
	scrollFrameParent:SetPoint("TOPLEFT", largeTip, "BOTTOMLEFT", 0, -10)
	scrollFrameParent:SetPoint("RIGHT", frame, "RIGHT", -32, 0)
	scrollFrameParent:SetPoint("BOTTOM", completeButton, "TOP", 0, 10)
	S:HandleScrollBar(scrollFrameParent.ScrollBar)
	local scrollFrame = CreateFrame("Frame", "EltruismCompatibilityFrameScrollFrame", scrollFrameParent)
	scrollFrame:SetSize(scrollFrameParent:GetSize())
	scrollFrameParent:SetScrollChild(scrollFrame)
	frame.scrollFrameParent = scrollFrameParent
	frame.scrollFrame = scrollFrame
end

local function AddButtonToCompatibilityFrame(data)
	_G["EltruismCompatibilityFrame"].numModules = _G["EltruismCompatibilityFrame"].numModules + 1

	local leftButton = CreateFrame("Button","EltruismCompatibilityFrameLeftButton" .. _G["EltruismCompatibilityFrame"].numModules,_G["EltruismCompatibilityFrame"].scrollFrame,"UIPanelButtonTemplate, BackdropTemplate")
	leftButton.Text:SetText(format("%s\n%s", data.module1, data.plugin1))
	leftButton.Text:SetJustifyH("CENTER")
	leftButton.Text:SetJustifyV("CENTER")
	leftButton.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	leftButton:SetSize(220, 40)
	leftButton:SetPoint("TOPLEFT", _G["EltruismCompatibilityFrame"].scrollFrame, "TOPLEFT", 5, -_G["EltruismCompatibilityFrame"].numModules * 50 + 45)
	S:HandleButton(leftButton)
	leftButton:SetScript("OnClick",function(self)
		data.func1()
		_G["EltruismCompatibilityFrame"].configChanged = true
		local name = gsub(self:GetName(), "LeftButton", "MiddleTexture")
		if _G[name] then
			_G[name]:SetTexture(E.Media.Textures.ArrowUp)
			_G[name]:SetRotation(S.ArrowRotation.left)
			_G[name]:SetVertexColor(0.27, 0.50, 0.70)
		end
	end)

	local middleTexture = _G["EltruismCompatibilityFrame"].scrollFrame:CreateTexture("EltruismCompatibilityFrameMiddleTexture" .. _G["EltruismCompatibilityFrame"].numModules, "ARTWORK")
	middleTexture:SetPoint("CENTER")
	middleTexture:SetSize(20, 20)
	middleTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Icons\\choice.tga")
	middleTexture:SetVertexColor(1, 1, 1)
	middleTexture:SetPoint("CENTER", _G["EltruismCompatibilityFrame"].scrollFrame, "TOP", 0, -_G["EltruismCompatibilityFrame"].numModules * 50 + 25)

	local rightButton = CreateFrame("Button","EltruismCompatibilityFrameRightButton" .. _G["EltruismCompatibilityFrame"].numModules,_G["EltruismCompatibilityFrame"].scrollFrame,"UIPanelButtonTemplate, BackdropTemplate")
	rightButton.Text:SetText(format("%s\n%s", data.module2, data.plugin2))

	rightButton.Text:SetJustifyH("CENTER")
	rightButton.Text:SetJustifyV("CENTER")
	rightButton.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	rightButton:SetSize(220, 40)
	rightButton:SetPoint("TOPRIGHT", _G["EltruismCompatibilityFrame"].scrollFrame, "TOPRIGHT", -5, -_G["EltruismCompatibilityFrame"].numModules * 50 + 45)
	S:HandleButton(rightButton)
	rightButton:SetScript("OnClick",function(self)
		data.func2()
		_G["EltruismCompatibilityFrame"].configChanged = true
		local name = gsub(self:GetName(), "RightButton", "MiddleTexture")
		if _G[name] then
			_G[name]:SetTexture(E.Media.Textures.ArrowUp)
			_G[name]:SetRotation(S.ArrowRotation.right)
			_G[name]:SetVertexColor(1, 0.20, 0.10)
		end
	end)
end

local function GetDatabaseRealValue(path,accessValue)
	local accessTable, accessKey = nil, nil
	for _, key in ipairs {strsplit(".", path)} do
		if key and strlen(key) > 0 then
			if accessValue then
				if type(accessValue) == "function" then return end
				if accessValue[key] ~= nil then
					if type(accessValue[key]) == "boolean" then
						accessTable = accessValue
						accessKey = key
					end
					accessValue = accessValue[key]
				elseif accessValue[key] == nil then --its the default value so not exported/present
					accessTable = true
					accessKey = key
				else
					if E.db.ElvUI_EltreumUI.dev then
						ElvUI_EltreumUI:Print("[Compatibility] database path not found\n" .. path)
					end
					return
				end
			end
		end
	end

	return accessTable, accessKey, accessValue
end

local function GetCheckCompatibilityFunction(targetAddonName, targetAddonLocales,isToggleInstead,notElvUIDB)
	if not IsAddOnLoaded(targetAddonName) then
		return E.noop
	end
	if notElvUIDB then
		return function(myModuleName, targetAddonModuleName, myDB, targetAddonDB, targetAddonDBsub)
			if not (myDB and targetAddonDB and type(myDB) == "string" and type(targetAddonDB) == "string") then
				return
			end
			local myTable, myKey, myValue = GetDatabaseRealValue(myDB, E)
			local targetTable, targetKey, targetValue = GetDatabaseRealValue(targetAddonDBsub, _G[targetAddonDB])
			if myValue and targetValue then
				AddButtonToCompatibilityFrame({
					module1 = myModuleName,
					plugin1 = select(2,GetAddOnInfo("ElvUI_EltreumUI")),
					func1 = function()
						myTable[myKey] = true
						targetTable[targetKey] = false
					end,
					module2 = targetAddonModuleName,
					plugin2 = targetAddonLocales,
					func2 = function()
						myTable[myKey] = false
						targetTable[targetKey] = true
					end
				})
			end
		end
	elseif not isToggleInstead then
		return function(myModuleName, targetAddonModuleName, myDB, targetAddonDB)
			if not (myDB and targetAddonDB and type(myDB) == "string" and type(targetAddonDB) == "string") then
				return
			end
			local myTable, myKey, myValue = GetDatabaseRealValue(myDB, E)
			local targetTable, targetKey, targetValue = GetDatabaseRealValue(targetAddonDB, E)
			if myValue and targetValue then
				AddButtonToCompatibilityFrame({
					module1 = myModuleName,
					plugin1 = select(2,GetAddOnInfo("ElvUI_EltreumUI")),
					func1 = function()
						myTable[myKey] = true
						targetTable[targetKey] = false
					end,
					module2 = targetAddonModuleName,
					plugin2 = targetAddonLocales,
					func2 = function()
						myTable[myKey] = false
						targetTable[targetKey] = true
					end
				})
			end
		end
	else
		return function(myModuleName, targetAddon, myDB)
			if not (myDB and targetAddon) then
				return
			end
			local myTable, myKey, myValue = GetDatabaseRealValue(myDB, E)
			if myValue and IsAddOnLoaded(targetAddon) then
				AddButtonToCompatibilityFrame({
					module1 = myModuleName,
					plugin1 = select(2,GetAddOnInfo("ElvUI_EltreumUI")),
					func1 = function()
						myTable[myKey] = true
						DisableAddOn(targetAddon)
					end,
					module2 = "AddOn:",
					plugin2 = select(2,GetAddOnInfo(targetAddon)),
					func2 = function()
						myTable[myKey] = false
						EnableAddOn(targetAddon)
					end
				})
			end
		end
	end
end

function ElvUI_EltreumUI:CheckCompatibility()

	ConstructCompatibilityFrame()

	--ElvUI plugins
	local CheckMerathilisUI = GetCheckCompatibilityFunction("ElvUI_MerathilisUI", select(2,GetAddOnInfo("ElvUI_MerathilisUI")),false)
	local CheckWindTools = GetCheckCompatibilityFunction("ElvUI_WindTools", select(2,GetAddOnInfo("ElvUI_WindTools")),false)
	local CheckmMediaTag = GetCheckCompatibilityFunction("ElvUI_mMediaTag", select(2,GetAddOnInfo("ElvUI_mMediaTag")),false)
	local CheckWunderUI = GetCheckCompatibilityFunction("WunderUI", select(2,GetAddOnInfo("WunderUI")),false)
	local CheckToxiUI = GetCheckCompatibilityFunction("ElvUI_ToxiUI", select(2,GetAddOnInfo("ElvUI_ToxiUI")),false)

	--other addons that are disable/enable
	local CheckDeja = GetCheckCompatibilityFunction("DejaCharacterStats", select(2,GetAddOnInfo("DejaCharacterStats")),true)
	local CheckKaliel = GetCheckCompatibilityFunction("!KalielsTracker", select(2,GetAddOnInfo("!KalielsTracker")),true)
	local CheckWabbit = GetCheckCompatibilityFunction("Who Framed Watcher Wabbit", select(2,GetAddOnInfo("Who Framed Watcher Wabbit")),true)
	local CheckCQL = GetCheckCompatibilityFunction("ClassicQuestLog", select(2,GetAddOnInfo("ClassicQuestLog")),true)
	local CheckSorha = GetCheckCompatibilityFunction("SorhaQuestLog", select(2,GetAddOnInfo("SorhaQuestLog")),true)
	local CheckDoom = GetCheckCompatibilityFunction("Doom_CooldownPulse", select(2,GetAddOnInfo("Doom_CooldownPulse")),true)
	--local CheckRaiderIO = GetCheckCompatibilityFunction("RaiderIO", select(2,GetAddOnInfo("RaiderIO")),false,true)
	--local CheckQuestie = GetCheckCompatibilityFunction("Questie", select(2,GetAddOnInfo("Questie")),false,true)

	--Character Panel
	CheckMerathilisUI(L["Character Panel"].."\n"..L["Class Icons"], L["Character Panel"].."\n"..L["Class Icons"], "db.ElvUI_EltreumUI.skins.classicarmory", "db.mui.armory.character.enable")
	CheckDeja(L["Character Panel"], L["DejaCharacterStats"], "db.ElvUI_EltreumUI.skins.classicarmory", "DejaCharacterStats")
	CheckToxiUI(L["Character Panel"], "Armory", "db.ElvUI_EltreumUI.skins.elvui.SetTemplate", "db.TXUI.armory.enabled")
	CheckToxiUI(L["Expand Character Art"], "Armory", "db.ElvUI_EltreumUI.skins.elvui.SetTemplate", "db.TXUI.armory.enabled")
	CheckWunderUI(L["Character Panel"], "Armory", "db.ElvUI_EltreumUI.skins.classicarmory", "db.WunderUI.armory.enabled")
	CheckWunderUI(L["Expand Character Art"], "Armory", "db.ElvUI_EltreumUI.skins.expandarmorybg", "db.WunderUI.armory.enabled")

	--Nameplates
	CheckMerathilisUI(L["Gradient Nameplate\nHealth/CastBar/Threat"], L["Gradient Nameplate Health"], "db.ElvUI_EltreumUI.unitframes.gradientmode.npenable", "db.mui.nameplates.gradient")
	CheckMerathilisUI(L["Gradient Nameplate\nHealth/CastBar/Threat"], L["Castbar Shield"], "db.ElvUI_EltreumUI.unitframes.gradientmode.npenable", "db.mui.nameplates.castbarShield")

	--Cooldown
	CheckMerathilisUI(L["Cooldown Pulse\n(Includes TTS)"], L["Cooldown Pulse"], "db.ElvUI_EltreumUI.skins.doom.enable", "db.mui.cooldownFlash.enable")
	CheckDoom(L["Cooldown"], L["Doom_CooldownPulse"], "db.ElvUI_EltreumUI.skins.doom.enable", "Doom_CooldownPulse")

	--Quests
	CheckWindTools(L["Quest Autoaccept"], L["Quest Autoaccept"], "db.ElvUI_EltreumUI.quests.autoaccept", "db.WT.quest.turnIn.enable")
	CheckMerathilisUI(L["Quests Skin"], L["Quests Skin"], "db.ElvUI_EltreumUI.skins.quests", "db.mui.blizzard.objectiveTracker.enable")
	CheckWindTools(L["Quests Skin"], L["Quests Skin"], "db.ElvUI_EltreumUI.skins.quests", "private.WT.quest.objectiveTracker.enable")
	CheckKaliel(L["Quests Skin"], L["!KalielsTracker"], "db.ElvUI_EltreumUI.skins.quests", "!KalielsTracker")
	CheckWabbit(L["Quests Skin"], L["Who Framed Watcher Wabbit"], "db.ElvUI_EltreumUI.skins.quests", "Who Framed Watcher Wabbit")
	CheckCQL(L["Quests Skin"], L["ClassicQuestLog"], "db.ElvUI_EltreumUI.skins.quests", "ClassicQuestLog")
	CheckSorha(L["Quests Skin"], L["SorhaQuestLog"], "db.ElvUI_EltreumUI.skins.quests", "SorhaQuestLog")

	--map/waypoint
	CheckMerathilisUI(format("%s\n%s", L["Waypoints"], L["Autopin, Time to Arrive"]), format("%s\n%s", L["Waypoints"], L["Autopin"]), "db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable", "db.mui.maps.superTracker.enable")
	CheckMerathilisUI(format("%s\n%s", L["Waypoints"], L["Chat Command"]), format("%s\n%s", L["Waypoints"], L["Chat Command"]), "db.ElvUI_EltreumUI.waypoints.waytext.enable", "db.mui.maps.superTracker.waypointParse.enable")
	CheckWindTools(format("%s\n%s", L["Waypoints"], L["Autopin, Time to Arrive"]), format("%s\n%s", L["Waypoints"], L["Autopin"]), "db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable", "private.WT.maps.superTracker.enable")
	CheckWindTools(format("%s\n%s", L["Waypoints"], L["Chat Command"]), format("%s\n%s", L["Waypoints"], L["Chat Command"]), "db.ElvUI_EltreumUI.waypoints.waytext.enable", "private.WT.maps.superTracker.waypointParse.enable")
	CheckWindTools(L["Map Scale"], L["Map Scale"], "db.ElvUI_EltreumUI.otherstuff.worldmapscale", "private.WT.maps.worldMap.scale.enable")

	--unitframes
	CheckMerathilisUI(L["Cast Bar Custom Spark/Texture"], L["Cast Bar"], "db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable", "db.mui.unitframes.castbar.spark.enable")
	CheckMerathilisUI(L["Unitframe/Chat Role Icons"], L["Chat Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.mui.chat.roleIcons.enable")
	CheckMerathilisUI(L["Custom Role Icons"], L["Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.mui.unitframes.roleIcons.enable")
	CheckMerathilisUI(L["Custom Power Models"], L["Power Models"], "db.ElvUI_EltreumUI.unitframes.models.powerbar", "db.mui.unitframes.power.enable")
	CheckWindTools(L["Unitframe/Chat Role Icons"], L["Unitframe Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "private.WT.unitFrames.roleIcon.enable")

	--chat
	CheckMerathilisUI(L["Chat Loot Icons"], L["Chat Loot Icons"], "db.ElvUI_EltreumUI.chat.looticons", "db.mui.chat.chatLink.enable")
	CheckWindTools(L["Chat Loot Icons"], L["Chat Loot Icons"], "db.ElvUI_EltreumUI.chat.looticons", "db.WT.social.chatLink.icon")
	CheckWindTools(L["Chat Loot Item Level"], L["Chat Loot Item Level"], "db.ElvUI_EltreumUI.chat.itemlevels", "db.WT.social.chatLink.level")

	--general gradient
	CheckMerathilisUI(L["Gradient\nHealth/Power/Castbars"], L["Gradient Power"], "db.ElvUI_EltreumUI.unitframes.gradientmode.enable", "db.mui.gradient.enable")
	CheckMerathilisUI(L["Custom Gradient Details"], L["Gradient Details"], "db.ElvUI_EltreumUI.skins.details", "private.mui.skins.addonSkins.dt.gradientBars")
	CheckMerathilisUI(L["Custom Gradient Details"], L["Gradient Details Names"], "db.ElvUI_EltreumUI.skins.details", "private.mui.skins.addonSkins.dt.gradientName")
	CheckMerathilisUI(L["Gradient BigWigs"], L["BigWigs"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.mui.skins.addonSkins.bw.enable")
	CheckWindTools(L["Gradient BigWigs"], L["BigWigs"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.WT.skins.addons.bigWigs")
	CheckMerathilisUI(L["Gradient BigWigs"], L["BigWigs Queue Timer"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.mui.skins.addonSkins.bw.queueTimer.enable")
	CheckWindTools(L["Gradient BigWigs"], L["BigWigs Queue Timer"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.WT.skins.addons.bigWigsQueueTimer")
	CheckToxiUI(L["Gradient"], "Gradient Mode", "db.ElvUI_EltreumUI.unitframes.gradientmode.enable", "db.TXUI.themes.gradientMode.enabled")
	CheckMerathilisUI(L["Gradient"], L["Gradient"], "db.ElvUI_EltreumUI.unitframes.gradientmode.enable", "db.mui.gradient.enable")
	CheckMerathilisUI(L["Tooltip\nGradient Name and Health"], L["Tooltip\nGradient Name"], "db.ElvUI_EltreumUI.skins.gradienttooltip", "db.mui.gradient.enable") --currently merathilis ui does not do anything with the tooltip option (no db entry toggle), only general disable of gradient works

	--skins for addons
	CheckMerathilisUI(L["BugSack"], L["BugSack"], "db.ElvUI_EltreumUI.skins.bugsack", "private.mui.skins.addonSkins.bs")
	CheckWindTools(L["BugSack"], L["BugSack"], "db.ElvUI_EltreumUI.skins.bugsack", "private.WT.skins.addons.bugSack")
	CheckMerathilisUI(L["Clique"], L["Clique"], "db.ElvUI_EltreumUI.skins.clique", "private.mui.skins.addonSkins.cl")
	CheckMerathilisUI(L["Immersion"], L["Immersion"], "db.ElvUI_EltreumUI.skins.immersion", "private.mui.skins.addonSkins.imm")
	CheckWindTools(L["Immersion"], L["Immersion"], "db.ElvUI_EltreumUI.skins.immersion", "private.WT.skins.addons.immersion")
	CheckWindTools(L["RareScanner"], L["RareScanner"], "db.ElvUI_EltreumUI.skins.rarescanner", "private.WT.skins.addons.rareScanner")
	CheckWindTools(L["SimulationCraft"], L["SimulationCraft"], "db.ElvUI_EltreumUI.skins.simulationcraft", "private.WT.skins.addons.simulationcraft")
	CheckWindTools(L["WarpDeplete"], L["WarpDeplete"], "db.ElvUI_EltreumUI.skins.warpdeplete", "private.WT.skins.addons.warpDeplete")
	CheckWindTools(L["Hekili"], L["Hekili"], "db.ElvUI_EltreumUI.skins.hekili", "private.WT.skins.addons.hekili")
	CheckWindTools(L["OmniCD"], L["OmniCD"], "db.ElvUI_EltreumUI.skins.omnicd", "private.WT.skins.addons.omniCD")
	CheckToxiUI(L["Skin ElvUI"], "ElvUI Theme", "db.ElvUI_EltreumUI.skins.elvui.SetTemplate", "db.TXUI.addons.elvUITheme.enabled")
	CheckMerathilisUI("Details".." "..L["Embed"], "Details".." "..L["Embed"], "db.ElvUI_EltreumUI.skins.detailsembed", "private.mui.skins.embed.enable")
	CheckWindTools("Ace3", L["Widgets"].." "..L["Button"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.WT.skins.widgets.button.enable")
	CheckWindTools("Ace3", L["Widgets"].." "..L["Tab"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.WT.skins.widgets.tab.enable")
	CheckWindTools("Ace3", L["Widgets"].." "..L["Tree Group Button"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.WT.skins.widgets.treeGroupButton.enable")
	CheckWindTools("Ace3", L["Widgets"].." "..L["Slider"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.WT.skins.widgets.slider.enable")
	CheckWindTools("Ace3", L["Widgets"].." "..L["CheckBox"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.WT.skins.widgets.checkBox.enable")
	--CheckMerathilisUI("Ace3", L["Widgets"].." "..L["Button"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.mui.skins.widgets.button.enable")
	--CheckMerathilisUI("Ace3", L["Widgets"].." "..L["Tab"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.mui.skins.widgets.tab.enable")
	--CheckMerathilisUI("Ace3", L["Widgets"].." "..L["Tree Group Button"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.mui.skins.widgets.treeGroupButton.enable")
	--CheckMerathilisUI("Ace3", L["Widgets"].." "..L["Slider"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.mui.skins.widgets.slider.enable")
	--CheckMerathilisUI("Ace3", L["Widgets"].." "..L["CheckBox"], "db.ElvUI_EltreumUI.skins.ace3.enable", "private.mui.skins.widgets.checkBox.enable")
	CheckMerathilisUI("Ace3", "Ace3", "db.ElvUI_EltreumUI.skins.ace3.enable", "private.mui.skins.addonSkins.ace3")

	--other
	CheckMerathilisUI(L["Combat Alert"], L["Combat Alert"], "db.ElvUI_EltreumUI.loot.loottext.combatindicator", "db.mui.CombatAlert.enable")
	CheckmMediaTag(L["Class Colored Nameplate Options"].."\n"..L["Hover"],L["Auto color Glow"], "db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow", "db.mMT.nameplate.bordercolor.glow")
	CheckmMediaTag(L["Class Colored Nameplate Options"].."\n"..L["Border"],L["Auto color Border"], "db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate", "db.mMT.nameplate.bordercolor.border")
	CheckmMediaTag(L["Quests Skin"], L["Objective Tracker"], "db.ElvUI_EltreumUI.skins.quests", "db.mMT.objectivetracker.enable")
	CheckmMediaTag(L["Role Icons"], L["Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.mMT.roleicons.enable")
	CheckmMediaTag(L["A.F.K"].."\n"..L["Eltruism Logo"], "AFK Logo", "db.ElvUI_EltreumUI.otherstuff.afklogoeltruism", "db.mMT.afk.logo")
	CheckmMediaTag(L["Portrait Skin"], L["Portraits"], "db.ElvUI_EltreumUI.unitframes.portrait.enable", "db.mMT.portraits.general.enable")
	CheckWindTools(L["Shadows"], L["Shadows"], "db.ElvUI_EltreumUI.skins.shadow.enable", "private.WT.skins.shadow")
	CheckWindTools(L["Combat Alert"], L["Combat Alert"], "db.ElvUI_EltreumUI.loot.loottext.combatindicator", "db.WT.combat.combatAlert.text")
	CheckWindTools(L["Keystone\n!key command/Autoinsert"], L["Keystone Autoinsert"], "db.ElvUI_EltreumUI.otherstuff.mpluskeys", "db.WT.combat.quickKeystone.enable")
	CheckWindTools(L["Fast Loot"], L["Fast Loot"], "db.ElvUI_EltreumUI.loot.fastloot", "db.WT.item.fastLoot.enable")
	CheckWindTools(L["Auto Type Delete"], L["Auto Type Delete"], "db.ElvUI_EltreumUI.otherstuff.delete", "db.WT.item.delete.enable")
	CheckWindTools(L["Add Spec Icons to the Group Finder Listing"], L["LFG List"], "db.ElvUI_EltreumUI.skins.groupfinderSpecIcons", "private.WT.misc.lfgList.enable")
	--CheckMerathilisUI(L["Add Spec Icons to the Group Finder Listing"], L["LFG List"], "db.ElvUI_EltreumUI.skins.groupfinderSpecIcons", "db.mui.misc.lfgInfo.enable") --actually is tooltip only
	CheckWunderUI(L["Role Icons"], L["Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.WunderUI.skins.elvUIIcons.roleIcons.enabled")
	CheckWunderUI(L["Portrait Skin"], "Ring Portraits", "db.ElvUI_EltreumUI.unitframes.portrait.enable", "db.WunderUI.skins.elvUIIcons.ringIcons.enabled")
	CheckToxiUI(L["A.F.K"].."\n"..L["Skin"], "AFK Mode", "db.ElvUI_EltreumUI.otherstuff.afklogo", "db.TXUI.addons.afkMode.enabled")
	CheckToxiUI(L["Role Icons"], "Role Icons", "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.TXUI.elvUIIcons.roleIcons.enabled")

	--non elvui addon dbs
	--CheckRaiderIO(L["Dungeon Score"].."\n"..L["Flags"], L["RaiderIO Tooltip"], "db.ElvUI_EltreumUI.skins.groupfinderDungeonScore", "RaiderIO_Config","showDropDownCopyURL")
	--CheckQuestie(L["Quests Skin"], L["Quests Skin"], "db.ElvUI_EltreumUI.skins.quests", "Questie","db.char.trackerEnabled")

	if _G["EltruismCompatibilityFrame"].numModules > 0 then
		_G["EltruismCompatibilityFrame"]:Show()
		ElvUI_EltreumUI:HidePopups(0)
		E:Delay(2, function()
			if _G["MERCompatibilityFrame"] then --2 windows at the same time is just confusing
				_G["MERCompatibilityFrame"]:Hide()
			end
		end)
	end
end
