local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local EnableAddOn = _G.C_AddOns and _G.C_AddOns.EnableAddOn or _G.EnableAddOn
local DisableAddOn = _G.C_AddOns and _G.C_AddOns.DisableAddOn or _G.DisableAddOn
local GetAddOnInfo = _G.C_AddOns and _G.C_AddOns.GetAddOnInfo or _G.GetAddOnInfo
local GetNumAddOns = _G.C_AddOns and _G.C_AddOns.GetNumAddOns or _G.GetNumAddOns
local CreateFrame = _G.CreateFrame
local GetCoinIcon = _G.C_CurrencyInfo and _G.C_CurrencyInfo.GetCoinIcon or _G.GetCoinIcon
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll
local print = _G.print
local strlower = _G.strlower
local GetContainerNumSlots = E.Retail and C_Container.GetContainerNumSlots or _G.GetContainerNumSlots
local GetContainerItemInfo = E.Retail and C_Container.GetContainerItemInfo or _G.GetContainerItemInfo
local UseContainerItem = E.Retail and C_Container.UseContainerItem or _G.UseContainerItem
local next = _G.next
local SendChatMessage = _G.SendChatMessage
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar


-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	self:RegisterChatCommand('eltruismdebug', 'DebugMode')

	--add to moveui table
	if not self.ConfigModeAddedEltruism then
		tinsert(E.ConfigModeLayouts, #(E.ConfigModeLayouts) + 1, "ELTREUMUI")
		--E.ConfigModeLocalizedStrings["ELTREUMUI"] = format("|cff82B4ff%s |r", "Eltruism")
		E.ConfigModeLocalizedStrings["ELTREUMUI"] = E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1)
		self.ConfigModeAddedEltruism = true
	end
	if E.Retail then
		if E.db.ElvUI_EltreumUI.waypoints.waytext.enable then
			if not IsAddOnLoaded("TomTom") then
				self:RegisterChatCommand('way', 'WaypointTexttoCoordinate')
				self:RegisterChatCommand('waypoint', 'WaypointTexttoCoordinate')
			else
				self:RegisterChatCommand('eway', 'WaypointTexttoCoordinate')
				self:RegisterChatCommand('ewaypoint', 'WaypointTexttoCoordinate')
				ElvUI_EltreumUI:Print("TomTom detected, commands moved to /eway and /ewaypoint")
			end
		end
		if E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
			self:RegisterChatCommand('!key', 'Keys')
			self:RegisterChatCommand('!keys', 'Keys')
		end
	end
end

function ElvUI_EltreumUI:RunCommands(message)
	if message == 'installer' or message == 'install' or message == 'setup' then
		E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
	elseif message == 'loot' then
		if E.db.ElvUI_EltreumUI.loot.loottext.enable then
			local aImage = GetCoinIcon(9999999999)
			local aSilver = GetCoinIcon(100)
			local aCopper = GetCoinIcon(1)
			--RaidNotice_AddMessage(RaidWarningFrame, "Raid Boss Emote Frame Raid Warning Test Message", ChatTypeInfo["RAID_WARNING"], 10)
			if E.Retail then
				CombatText_AddMessage("|T ".. aImage ..":22:22:0:0:64:64:5:59:5:59|t ".."9.999.999 Gold", CombatText_StandardScroll, 255, 255, 255)
			elseif E.Classic or E.Wrath then
				CombatText_AddMessage("|T ".. aImage ..":22:22:0:0:64:64:5:59:5:59|t ".."214.748 Gold |T ".. aSilver ..":22:22:0:0:64:64:5:59:5:59|t ".."36 Silver |T ".. aCopper ..":22:22:0:0:64:64:5:59:5:59|t ".."47 Copper", CombatText_StandardScroll, 255, 255, 255)
			end
		else
			CombatText_AddMessage("|T ".. 136176 ..":22:22:-11:-11:64:64:5:59:5:59|t ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	elseif message == 'config' or message == 'options' or message == '' then
		E:ToggleOptions("ElvUI_EltreumUI")
		--E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	elseif message == 'dev' then
		if not E.db.ElvUI_EltreumUI.dev then
			E.db.ElvUI_EltreumUI.dev = true
			ElvUI_EltreumUI:Print("Development Tools Enabled, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.dev then
			E.db.ElvUI_EltreumUI.dev = false
			ElvUI_EltreumUI:Print("Development Tools Disabled, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		end
	elseif message == 'translate' then
		if E.db.ElvUI_EltreumUI.deepLwarning then
			E.db.ElvUI_EltreumUI.deepLwarning = false
			ElvUI_EltreumUI:Print("DeepL translation warning Disabled")
		else
			E.db.ElvUI_EltreumUI.deepLwarning = true
			ElvUI_EltreumUI:Print("DeepL translation warning Enabled")
		end
	elseif message == 'chat' then
		if E.db.chat.panelBackdrop == "HIDEBOTH" then
			ElvUI_EltreumUI:DarkChat()
		elseif E.db.chat.panelBackdrop == "SHOWBOTH" then
			ElvUI_EltreumUI:TransparentChat()
		else
			ElvUI_EltreumUI:TransparentChat()
		end
	elseif message == 'color' then
		if E.db.ElvUI_EltreumUI.unitframes.lightmode then
			ElvUI_EltreumUI:DarkMode() E:StaticPopup_Show('CONFIG_RL')
		elseif not E.db.ElvUI_EltreumUI.unitframes.lightmode then
			ElvUI_EltreumUI:LightMode() E:StaticPopup_Show('CONFIG_RL')
		else
			ElvUI_EltreumUI:DarkMode() E:StaticPopup_Show('CONFIG_RL')
		end
	elseif message == 'gradient' then
		ElvUI_EltreumUI:GradientMode()
		E:StaticPopup_Show('CONFIG_RL')
	elseif message == 'weakauras' then
		E.PopupDialogs["ELTRUISMWABARWARNING"] = {
			text = L["Overwrites some profile settings to move ActionBars, Unitframes and Powers to look more similar to a WeakAura. |cffFF0000WARNING:|r This will overwrite some of your profile settings with no way to restore"],
			OnAccept = function()
				if E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
					E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA = false
					ElvUI_EltreumUI:WeakAurasLikeActionBars()
				elseif not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
					E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA = true
					ElvUI_EltreumUI:WeakAurasLikeActionBars()
				end
			end,
			--OnCancel = function() end,
			button1 = ACCEPT,
			button2 = CANCEL,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}
		E:StaticPopup_Show('ELTRUISMWABARWARNING')

	elseif message == 'performance' then
		E.PopupDialogs["ELTRUISMPERFORMANCE"] = {
			text = L["Disabling a number of functions in ElvUI and Eltruism to optimize performance"],
			OnAccept = function()
				ElvUI_EltreumUI:PerformanceOptimization()
				ReloadUI()
			end,
			button1 = ACCEPT,
			button2 = CANCEL,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}
		E:StaticPopup_Show('ELTRUISMPERFORMANCE')
	elseif message == 'background' then
		if E.db.ElvUI_EltreumUI.unitframes.greybackground then
			ElvUI_EltreumUI:BlackBg()
		elseif not E.db.ElvUI_EltreumUI.unitframes.greybackground then
			ElvUI_EltreumUI:GreyBg()
		else
			ElvUI_EltreumUI:GreyBg()
		end
	elseif message == 'secretbgtest' then
		if not E.db.ElvUI_EltreumUI.otherstuff.colorbg then
			local valuecolors = E:ClassColor(E.myclass, true)
			E.db.ElvUI_EltreumUI.otherstuff.colorbg = true
			E.db.general.backdropcolor.b = valuecolors.b*0.3
			E.db.general.backdropcolor.g = valuecolors.g*0.3
			E.db.general.backdropcolor.r = valuecolors.r*0.3
			ElvUI_EltreumUI:Print("Secret test class color background. Backdrop updated, type /eltruism secretbgtest again to disable")
		else
			E.db.general.backdropcolor.b = 0.098039215686275
			E.db.general.backdropcolor.g = 0.098039215686275
			E.db.general.backdropcolor.r = 0.098039215686275
			E.db.ElvUI_EltreumUI.otherstuff.colorbg = false
			ElvUI_EltreumUI:Print("Disabled Class Color background, using default background color instead.")
		end
		E:UpdateMediaItems()
	elseif message == 'modeldebug' then
		if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style == "3D" and UnitExists("target") then
			ElvUI_EltreumUI:Print(UnitName("target").." ".._G["ElvUF_Target"].Portrait3D:GetModelFileID())
		else
			ElvUI_EltreumUI:Print("Target either doesn't exist or doesn't have 3D model portrait enabled")
		end
	elseif message == 'update' then
		E.PopupDialogs["ELTRUISMSETTINGSWARNING"] = {
			text = L["Resets/Updates Eltruism Settings to Eltreum's Defaults"],
			OnAccept = function()
				ElvUI_EltreumUI:UpdateEltruismSettings()
				ReloadUI()
			end,
			--OnCancel = function() end,
			button1 = ACCEPT,
			button2 = CANCEL,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}
		E:StaticPopup_Show('ELTRUISMSETTINGSWARNING')
	elseif message == 'autoupdate' then
		if not E.db.ElvUI_EltreumUI.autoupdate then
			E.db.ElvUI_EltreumUI.autoupdate = true
			ElvUI_EltreumUI:Print("Auto Update of Eltruism settings during a new version enabled")
		else
			E.db.ElvUI_EltreumUI.autoupdate = false
			ElvUI_EltreumUI:Print("Auto Update of Eltruism settings during a new version disabled")
		end
	elseif message == 'detailshide' then
		if not E.db.ElvUI_EltreumUI.skins.detailsembedooc then
			E.db.ElvUI_EltreumUI.skins.detailsembedooc = true
			ElvUI_EltreumUI:EltruismDetails()
			ElvUI_EltreumUI:Print("Details Hiding out of Combat Enabled")
		else
			E.db.ElvUI_EltreumUI.skins.detailsembedooc = false
			ElvUI_EltreumUI:Print("Details Hiding out of Combat Disabled")
		end
	elseif message == 'autoadjust' then
		if (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
			if not E.db.ElvUI_EltreumUI.borders.borderautoadjust then
				E.db.ElvUI_EltreumUI.borders.borderautoadjust = true
				ElvUI_EltreumUI:Print("Borders Autoadjust enabled")
			else
				E.db.ElvUI_EltreumUI.borders.borderautoadjust = false
				ElvUI_EltreumUI:Print("Borders Autoadjust disabled")
			end
		end
	elseif message == 'thinmode' then
		E.PopupDialogs["ELTRUISMTHINMODEWARNING"] = {
			text = L["Experimental Thin Mode UI, there is no going back to previous settings unless manually adjusting.\n|cffFF0000WARNING:|r This will overwrite some of your profile settings with no way to restore"],
			OnAccept = function()
				ElvUI_EltreumUI:ThinBars()
			end,
			--OnCancel = function() end,
			button1 = ACCEPT,
			button2 = CANCEL,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}
		E:StaticPopup_Show('ELTRUISMTHINMODEWARNING')
	elseif message == 'elvuiskin' then
		if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
			E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate = false
			ElvUI_EltreumUI:Print("ElvUI Skin disabled")
		else
			E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate = true
			ElvUI_EltreumUI:Print("ElvUI Skin enabled")
		end
		E:StaticPopup_Show('CONFIG_RL')
	elseif message == 'paging' then
		ElvUI_EltreumUI:ActionPagingSwap()
	else
		ElvUI_EltreumUI:Print("|cff82B4ffYou have entered an unknown command, here's a list of commands you can use:|r")
		print("|cff82B4ff/eltruism|r - Opens Eltruism Config")
		print("|cff82B4ff/eltruism options/config|r - Opens Eltruism Config")
		print("|cff82B4ff/eltruism setup/install|r - Opens Eltruism Installer")
		print("|cff82B4ff/eltruism loot|r - Demonstrates the LootText")
		if E.Retail then
			if not IsAddOnLoaded("TomTom") then
				print("|cff82B4ff/way and /waypoint|r - Sets a map waypoint with the supplied coordinates")
			else
				print("|cff82B4ff/eway and /ewaypoint|r - Sets a map waypoint with the supplied coordinates")
			end
			print("|cff82B4ff/!key and /!keys|r - Links your keystone in chat")
		end
		print("|cff82B4ff/eltruism background|r - Toggles between grey and black background")
		print("|cff82B4ff/eltruism color|r - Toggles unitframe between light and dark modes")
		print("|cff82B4ff/eltruism gradient|r - Toggles gradient mode")
		print("|cff82B4ff/eltruism chat|r - Toggles chat between dark and transparent modes")
		print("|cff82B4ff/eltruismdebug on/off|r - Toggles debug mode")
		print("|cff82B4ff/eltruism update|r - Resets/Updates Eltruism Settings to Eltreum's Defaults")
		print("|cff82B4ff/eltruism detailshide|r - Toggles Details hiding out of combat")
		if (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
			print("|cff82B4ff/eltruism autoadjust|r - Toggles Borders automatically adjusting the layout")
		end
		print("|cff82B4ff/eltruism weakauras|r - Toggles actionbars to be similar to WeakAuras, will overwrite settings")
		print("|cff82B4ff/eltruism elvuiskin|r - Toggles ElvUI Skin")
		print("|cff82B4ff/eltruism paging|r - Swaps Actionbar paging between Bar 1 and Bar4, otherwise resets to Bar4")
		print("|cff82B4ff/eltruism autoupdate|r - Enables automatically updating Eltruism settings")
	end
end

--ty luckyone for allowing me to use this
local AddOns = {
	["ElvUI"] = true,
	["ElvUI_Libraries"] = true,
	["ElvUI_Options"] = true,
	["ElvUI_EltreumUI"] = true,
	["!BugGrabber"] = true,
	["BugSack"] = true,
	["!CPUThieves"] = true,
	["ElvUI_CPU"] = true,
}
function ElvUI_EltreumUI:DebugMode(message)
	local switch = strlower(message)
	if switch ~= ('on' or 'off') then
		if next(ElvDB.EltruismDisabledAddOns) then
			switch = 'off'
		else
			switch = 'on'
		end
	end
	if switch == 'on' then
		for i = 1, GetNumAddOns() do
			local name = GetAddOnInfo(i)
			if not AddOns[name] and E:IsAddOnEnabled(name) then
				DisableAddOn(name, E.myname)
				ElvDB.EltruismDisabledAddOns[name] = i
			end
		end
		SetCVar('scriptErrors', 1)
		ReloadUI()
	elseif switch == 'off' then
		if next(ElvDB.EltruismDisabledAddOns) then
			for name in pairs(ElvDB.EltruismDisabledAddOns) do
				EnableAddOn(name, E.myname)
			end
			wipe(ElvDB.EltruismDisabledAddOns)
			ReloadUI()
		end
	--else
		--ElvUI_EltreumUI:Print("Usage: /eltruismdebug on or /eltruismdebug off, to enable or disable debug mode")
	end
end

--Adapted from Luckyone's +keys as requested by khornan
-- keystone id tables and keys table with stored keys
local ids = {
	[138019] = true, -- Legion
	[158923] = true, -- BfA
	[180653] = true, -- Shadowlands
	[151086] = true, -- Tournament
	[187786] = true, -- Legion Timewalking
	[186159] = true, -- Dragonflight
}
local keys = {
}
function ElvUI_EltreumUI:Keys(event,message)
	if E.Wrath or E.Classic then
		return
	elseif message == nil then
		return
	elseif message:match("!keys") == false or message:match("!key") == false then
		return
	end

	local function update()
		for bag = 0, NUM_BAG_SLOTS do
			local bagSlots = C_Container.GetContainerNumSlots(bag)
			for slot = 1, bagSlots do
				local containerInfo = C_Container.GetContainerItemInfo(bag, slot)
				if containerInfo then
					local itemLink = containerInfo.hyperlink
					local itemID = containerInfo.itemID
					if itemID and ids[itemID] then
						keys[itemID] = itemLink
					end
				end
			end
		end
	end

	local function link(channel)
		update()
		if E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
			for _, itemlink in next, keys do
				message = itemlink
				SendChatMessage(message, channel)
			end
		end
	end

	local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or (event == 'CHAT_MSG_PARTY_LEADER' and 'PARTY') or (event == 'CHAT_MSG_PARTY' and 'PARTY')
	if event == 'BAG_UPDATE_DELAYED' then
		update()
	elseif message and ( strlower(message) == '!keys' or strlower(message) == '!key') then
		--local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or (event == 'CHAT_MSG_PARTY_LEADER' and 'PARTY') or (event == 'CHAT_MSG_PARTY' and 'PARTY')
		link(channel)
	end

end

--frame to update using events
local keyframe = CreateFrame("FRAME")
keyframe:RegisterEvent("BAG_UPDATE_DELAYED")
keyframe:RegisterEvent("CHAT_MSG_GUILD")
keyframe:RegisterEvent("CHAT_MSG_PARTY_LEADER")
keyframe:RegisterEvent("CHAT_MSG_PARTY")
keyframe:SetScript("OnEvent", function(_,event, message)
	if E.Retail and E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
		ElvUI_EltreumUI:Keys(event, message)
	else
		keyframe:UnregisterAllEvents()
	end
end)

local keystone = CreateFrame("FRAME")
keystone:RegisterEvent("ADDON_LOADED")
keystone:SetScript("OnEvent", function(_,_,addon)
	if (addon == "Blizzard_ChallengesUI" or IsAddOnLoaded("Blizzard_ChallengesUI")) and E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
		keystone:UnregisterAllEvents()
		if _G.ChallengesKeystoneFrame then
			_G.ChallengesKeystoneFrame:HookScript("OnShow", function()
				for bag = 0, NUM_BAG_SLOTS do
					local bagSlots = GetContainerNumSlots(bag)
					for slot = 1, bagSlots do
						local containerInfo = GetContainerItemInfo(bag, slot)
						if containerInfo and containerInfo.itemID then
							if ids[containerInfo.itemID] then
								UseContainerItem(bag, slot)
							end
						end
					end
				end
			end)
		end
	end
end)
