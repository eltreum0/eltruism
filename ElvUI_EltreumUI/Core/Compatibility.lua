local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local compatibilityran = false
local addonname = "NAME"
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local GetAddOnInfo = _G.GetAddOnInfo
local DisableAddOn = _G.DisableAddOn
local EnableAddOn = _G.EnableAddOn
local select = _G.select
local gsub = _G.gsub
local ipairs = _G.ipairs
local type = _G.type
local format = _G.format
local CreateFrame = _G.CreateFrame
local strsplit = _G.strsplit
local strlen = _G.strlen
local classcolor = E:ClassColor(E.myclass, true)

--adapted from windtools with authorization from fang2hou, ty again fang

local function ConstructCompatibilityFrame()
	local frame = CreateFrame("Frame", "EltruismCompatibilityFrame", E.UIParent)
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
	title:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
	title:SetText(select(2,GetAddOnInfo("ElvUI_EltreumUI")).." "..L["Compatibility Check"])
	title:SetPoint("TOP", frame, "TOP", 0, -10)

	local desc = frame:CreateFontString(nil, "ARTWORK")
	desc:FontTemplate()
	desc:SetJustifyH("CENTER")
	desc:SetWidth(420)
	desc:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
	desc:SetText(L["AddOns that do the same thing can cause issues, to prevent errors you should pick between them below. Choose what you prefer!"])
	desc:SetPoint("TOP", frame, "TOP", 0, -40)

	local largeTip = frame:CreateFontString(nil, "ARTWORK")
	largeTip:FontTemplate()
	largeTip:SetJustifyH("CENTER")
	largeTip:SetWidth(500)
	largeTip:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
	largeTip:SetText("|c"..E:RGBToHex(classcolor.r,classcolor.g,classcolor.b, 'ff')..L["Choose the option you would like to |cff1784d1use|r"].."|r")
	largeTip:SetPoint("TOP", desc, "BOTTOM", 0, -10)

	local bottomDesc = frame:CreateFontString(nil, "ARTWORK")
	bottomDesc:FontTemplate()
	bottomDesc:SetJustifyH("CENTER")
	bottomDesc:SetWidth(530)
	bottomDesc:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
	bottomDesc:SetText(E.NewSign ..format(L["If you find the %s option has issues, alert me via Discord or GitHub issue."], select(2,GetAddOnInfo("ElvUI_EltreumUI"))))
	bottomDesc:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)

	local completeButton = CreateFrame("Button", "EltruismCompatibilityFrameCompleteButton", frame, "UIPanelButtonTemplate, BackdropTemplate")
	completeButton.Text:SetText(L["Complete"])
	completeButton.Text:SetJustifyH("CENTER")
	completeButton.Text:SetJustifyV("CENTER")
	completeButton.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
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
	leftButton.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
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
	rightButton.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, E.db.general.fontStyle)
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

local function GetDatabaseRealValue(path)
	local accessTable, accessKey, accessValue = nil, nil, E

	for _, key in ipairs {strsplit(".", path)} do
		if key and strlen(key) > 0 then
			if accessValue and accessValue[key] ~= nil then
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

	return accessTable, accessKey, accessValue
end

local function GetCheckCompatibilityFunction(targetAddonName, targetAddonLocales,isToggleInstead)
	if not IsAddOnLoaded(targetAddonName) then
		return E.noop
	end

	if not isToggleInstead then
		return function(myModuleName, targetAddonModuleName, myDB, targetAddonDB)
			if not (myDB and targetAddonDB and type(myDB) == "string" and type(targetAddonDB) == "string") then
				return
			end
			local myTable, myKey, myValue = GetDatabaseRealValue(myDB)
			local targetTable, targetKey, targetValue = GetDatabaseRealValue(targetAddonDB)
			if myValue == true and targetValue == true then
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
			if not (myDB and targetAddonName) then
				return
			end
			local myTable, myKey, myValue = GetDatabaseRealValue(myDB)
			if myValue == true and IsAddOnLoaded(targetAddonName) then
				AddButtonToCompatibilityFrame({
					module1 = myModuleName,
					plugin1 = select(2,GetAddOnInfo("ElvUI_EltreumUI")),
					func1 = function()
						myTable[myKey] = true
						DisableAddOn(targetAddonName)
					end,
					module2 = "AddOn:",
					plugin2 = select(2,GetAddOnInfo(targetAddonName)),
					func2 = function()
						myTable[myKey] = false
						EnableAddOn(targetAddonName)
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

	--other addons that are disable/enable
	local CheckDeja = GetCheckCompatibilityFunction("DejaCharacterStats", select(2,GetAddOnInfo("DejaCharacterStats")),true)
	local CheckKaliel = GetCheckCompatibilityFunction("!KalielsTracker", select(2,GetAddOnInfo("!KalielsTracker")),true)
	local CheckWabbit = GetCheckCompatibilityFunction("Who Framed Watcher Wabbit", select(2,GetAddOnInfo("Who Framed Watcher Wabbit")),true)
	local CheckCQL = GetCheckCompatibilityFunction("ClassicQuestLog", select(2,GetAddOnInfo("ClassicQuestLog")),true)
	local CheckSorha = GetCheckCompatibilityFunction("SorhaQuestLog", select(2,GetAddOnInfo("SorhaQuestLog")),true)
	local CheckDoom = GetCheckCompatibilityFunction("Doom_CooldownPulse", select(2,GetAddOnInfo("Doom_CooldownPulse")),true)

	--Merathilis UI
	CheckMerathilisUI(L["Class Icons"], L["Class Icons"], "db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel", "db.mui.armory.character.classIcon")
	CheckMerathilisUI(L["Character Panel"], L["Character Panel"], "db.ElvUI_EltreumUI.skins.classicarmory", "db.mui.armory.character.enable")
	CheckMerathilisUI(L["Gradient Nameplate\nHealth/CastBar/Threat"], L["Gradient Nameplate Health"], "db.ElvUI_EltreumUI.unitframes.gradientmode.npenable", "db.mui.nameplates.gradient")

	CheckMerathilisUI(L["Cooldown Pulse\n(Includes TTS)"], L["Cooldown Pulse"], "db.ElvUI_EltreumUI.skins.doom.enable", "db.mui.cooldownFlash.enable")
	CheckMerathilisUI(format("%s\n%s", L["Waypoints"], L["Autopin, Time to Arrive"]), format("%s\n%s", L["Waypoints"], L["Autopin"]), "db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable", "db.mui.maps.superTracker.enable")
	CheckMerathilisUI(format("%s\n%s", L["Waypoints"], L["Chat Command"]), format("%s\n%s", L["Waypoints"], L["Chat Command"]), "db.ElvUI_EltreumUI.waypoints.waytext.enable", "db.mui.mapssuperTracker.waypointParse.enable")
	CheckMerathilisUI(L["Cast Bar Custom Spark/Texture"], L["Cast Bar"], "db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable", "db.mui.unitframes.castbar.spark.enable")
	CheckMerathilisUI(L["Combat Alert"], L["Combat Alert"], "db.ElvUI_EltreumUI.loot.loottext.combatindicator", "db.mui.CombatAlert.enable")
	CheckMerathilisUI(L["Custom Role Icons"], L["Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.mui.unitframes.roleIcons.enable")
	CheckMerathilisUI(L["Unitframe/Chat Role Icons"], L["Chat Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "db.mui.chat.roleIcons.enable")

	CheckMerathilisUI(L["Chat Loot Icons"], L["Chat Loot Icons"], "db.ElvUI_EltreumUI.chat.looticons", "db.mui.chat.chatLink.enable")
	CheckMerathilisUI(L["Quests Skin"], L["Quests Skin"], "db.ElvUI_EltreumUI.skins.quests", "db.mui.blizzard.objectiveTracker.enable")
	CheckMerathilisUI(L["Gradient Zone/Mail/Quest Text"], L["Zone Text"], "db.ElvUI_EltreumUI.skins.zones", "db.mui.media.zoneText.enable")
	CheckMerathilisUI(L["Gradient Zone/Mail/Quest Text"], L["Mail Text"], "db.ElvUI_EltreumUI.skins.zones", "db.mui.media.miscText.mail.enable")
	CheckMerathilisUI(L["Custom Power Models"], L["Power Models"], "db.ElvUI_EltreumUI.unitframes.models.powerbar", "db.mui.unitframes.power.enable")
	CheckMerathilisUI(L["Custom Gradient Details"], L["Gradient Details"], "db.ElvUI_EltreumUI.skins.details", "db.mui.skins.addonSkins.dt")
	CheckMerathilisUI(L["Gradient BigWigs"], L["BigWigs"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.mui.skins.addonSkins.bw.enable")
	CheckMerathilisUI(L["Gradient BigWigs"], L["BigWigs Queue Timer"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.mui.skins.addonSkins.bw.queueTimer.enable")
	CheckMerathilisUI(L["BugSack"], L["BugSack"], "db.ElvUI_EltreumUI.skins.bugsack", "db.mui.skins.addonSkins.bs")
	CheckMerathilisUI(L["Clique"], L["Clique"], "db.ElvUI_EltreumUI.skins.clique", "db.mui.skins.addonSkins.cl")
	CheckMerathilisUI(L["Immersion"], L["Immersion"], "db.ElvUI_EltreumUI.skins.immersion", "db.mui.skins.addonSkins.imm")

	--WindTools
	CheckWindTools(format("%s\n%s", L["Waypoints"], L["Autopin, Time to Arrive"]), format("%s\n%s", L["Waypoints"], L["Autopin"]), "db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable", "private.WT.maps.superTracker.enable")
	CheckWindTools(format("%s\n%s", L["Waypoints"], L["Chat Command"]), format("%s\n%s", L["Waypoints"], L["Chat Command"]), "db.ElvUI_EltreumUI.waypoints.waytext.enable", "private.WT.maps.superTracker.waypointParse.enable")
	CheckWindTools(L["Quests Skin"], L["Quests Skin"], "db.ElvUI_EltreumUI.skins.quests", "private.WT.quest.objectiveTracker.enable")
	CheckWindTools(L["Map Scale"], L["Map Scale"], "db.ElvUI_EltreumUI.otherstuff.worldmapscale", "private.WT.maps.worldMap.scale.enable")
	CheckWindTools(L["Shadows"], L["Shadows"], "db.ElvUI_EltreumUI.skins.shadow.enable", "private.WT.skins.shadow")
	CheckWindTools(L["Unitframe/Chat Role Icons"], L["Unitframe Role Icons"], "db.ElvUI_EltreumUI.otherstuff.eltruismroleicons", "private.WT.unitFrames.roleIcon.enable")
	CheckWindTools(L["Combat Alert"], L["Combat Alert"], "db.ElvUI_EltreumUI.loot.loottext.combatindicator", "db.WT.combat.combatAlert.text")
	CheckWindTools(L["Keystone\n!key command/Autoinsert"], L["Keystone Autoinsert"], "db.ElvUI_EltreumUI.otherstuff.mpluskeys", "db.WT.combat.quickKeystone.enable")
	CheckWindTools(L["Fast Loot"], L["Fast Loot"], "db.ElvUI_EltreumUI.loot.fastloot", "db.WT. = trueitem.fastLoot.enable")
	CheckWindTools(L["Auto Type Delete"], L["Auto Type Delete"], "db.ElvUI_EltreumUI.otherstuff.delete", "db.WT.item.delete.enable")
	CheckWindTools(L["Quest Autoaccept"], L["Quest Autoaccept"], "db.ElvUI_EltreumUI.quests.autoaccept", "db.WT.quest.turnIn.enable")
	CheckWindTools(L["Chat Loot Item Level"], L["Chat Loot Item Level"], "db.ElvUI_EltreumUI.chat.itemlevels", "db.WT.social.chatLink.level")
	CheckWindTools(L["Chat Loot Icons"], L["Chat Loot Icons"], "db.ElvUI_EltreumUI.chat.looticons", "db.WT.social.chatLink.icon")
	CheckWindTools(L["Gradient BigWigs"], L["BigWigs"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.WT.skins.addons.bigWigs")
	CheckWindTools(L["Gradient BigWigs"], L["BigWigs Queue Timer"], "db.ElvUI_EltreumUI.skins.bigwigs", "private.WT.skins.addons.bigWigsQueueTimer")
	CheckWindTools(L["BugSack"], L["BugSack"], "db.ElvUI_EltreumUI.skins.bugsack", "private.WT.skins.addons.bugSack")
	CheckWindTools(L["Immersion"], L["Immersion"], "db.ElvUI_EltreumUI.skins.immersion", "private.WT.skins.addons.immersion")
	CheckWindTools(L["RareScanner"], L["RareScanner"], "db.ElvUI_EltreumUI.skins.rarescanner", "private.WT.skins.addons.rareScanner")
	CheckWindTools(L["SimulationCraft"], L["SimulationCraft"], "db.ElvUI_EltreumUI.skins.simulationcraft", "private.WT.skins.addons.simulationcraft")

	--other addons that are a disable/enable deal due to not being elvui plugins
	CheckDeja(L["Character Panel"], L["DejaCharacterStats"], "db.ElvUI_EltreumUI.skins.classicarmory", "DejaCharacterStats")
	CheckKaliel(L["Quests Skin"], L["!KalielsTracker"], "db.ElvUI_EltreumUI.skins.quests", "!KalielsTracker")
	CheckWabbit(L["Quests Skin"], L["Who Framed Watcher Wabbit"], "db.ElvUI_EltreumUI.skins.quests", "Who Framed Watcher Wabbit")
	CheckCQL(L["Quests Skin"], L["ClassicQuestLog"], "db.ElvUI_EltreumUI.skins.quests", "ClassicQuestLog")
	CheckSorha(L["Quests Skin"], L["SorhaQuestLog"], "db.ElvUI_EltreumUI.skins.quests", "SorhaQuestLog")
	CheckDoom(L["Cooldown"], L["Doom_CooldownPulse"], "db.ElvUI_EltreumUI.skins.doom.enable", "Doom_CooldownPulse")

	if _G["EltruismCompatibilityFrame"].numModules > 0 then
		_G["EltruismCompatibilityFrame"]:Show()
		E:Delay(2, function()
			if _G["MERCompatibilityFrame"] then --2 windows at the same time is just confusing
				_G["MERCompatibilityFrame"]:Hide()
			end
		end)
	end
end
