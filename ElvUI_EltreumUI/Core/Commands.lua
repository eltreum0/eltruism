local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local CreateFrame = _G.CreateFrame
local GetCoinIcon = _G.GetCoinIcon
local CombatText_AddMessage = _G.CombatText_AddMessage
local CombatText_StandardScroll = _G.CombatText_StandardScroll
local print = _G.print
local strlower = _G.strlower
local GetContainerNumSlots = E.Retail and C_Container.GetContainerNumSlots or _G.GetContainerNumSlots
local GetContainerItemInfo = E.Retail and C_Container.GetContainerItemInfo or _G.GetContainerItemInfo
local UseContainerItem = E.Retail and C_Container.UseContainerItem or _G.UseContainerItem
local select = _G.select
local C_Covenants = _G.C_Covenants
local next = _G.next
local SendChatMessage = _G.SendChatMessage


-- Register on init
function ElvUI_EltreumUI:LoadCommands()
	self:RegisterChatCommand('eltruism', 'RunCommands')
	self:RegisterChatCommand('eltruismdebug', 'DebugMode')

	--add to moveui table
	if not self.ConfigModeAddedEltruism then
		tinsert(E.ConfigModeLayouts, #(E.ConfigModeLayouts) + 1, "ELTREUMUI")
		E.ConfigModeLocalizedStrings["ELTREUMUI"] = format("|cff82B4ff%s |r", "Eltruism")
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
			CombatText_AddMessage("|T ".. 136176 ..":22:22:-11:-11:64:64:5:59:5:59|t|t  ".."Eltruism Loot is currently disabled!", CombatText_StandardScroll, 255, 255, 255)
		end
	elseif message == 'config' or message == 'options' or message == '' then
		E:ToggleOptions()
		E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
	elseif message == 'dev' then
		if E.db.ElvUI_EltreumUI.dev == false then
			E.db.ElvUI_EltreumUI.dev = true
			ElvUI_EltreumUI:Print("Development Tools Enabled, please reload")
			E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.dev == true then
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
		if E.db.ElvUI_EltreumUI.unitframes.lightmode == true then
			ElvUI_EltreumUI:DarkMode() E:StaticPopup_Show('CONFIG_RL')
		elseif E.db.ElvUI_EltreumUI.unitframes.lightmode == false then
			ElvUI_EltreumUI:LightMode() E:StaticPopup_Show('CONFIG_RL')
		else
			ElvUI_EltreumUI:DarkMode() E:StaticPopup_Show('CONFIG_RL')
		end
	elseif message == 'gradient' then
		if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable == false then
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = true
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable = true
			ElvUI_EltreumUI:GradientMode()
			E:StaticPopup_Show('CONFIG_RL')
			ElvUI_EltreumUI:Print("Gradient Enabled, please reload")
		elseif E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable == true then
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = false
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable = false
			E:StaticPopup_Show('CONFIG_RL')
			ElvUI_EltreumUI:Print("Gradient Disabled, please reload")
		end
	elseif message == 'weakauras' then
		E.PopupDialogs["ELTRUISMWABARWARNING"] = {
			text = L["Overwrites some profile settings to move ActionBars, Unitframes and Powers to look more similar to a WeakAura. |cffFF0000WARNING:|r This will overwrite some of your profile settings with no way to restore"],
			OnAccept = function()
				if E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
					E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA = false
					ElvUI_EltreumUI:WeakAurasLikeActionBars()
				elseif E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA == false then
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
	elseif message == 'background' then
		if E.db.ElvUI_EltreumUI.unitframes.greybackground == true then
			ElvUI_EltreumUI:BlackBg()
		elseif E.db.ElvUI_EltreumUI.unitframes.greybackground == false then
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
			ElvUI_EltreumUI:Print(UnitName("target").." "..UnitCreatureType("target").." ".._G["ElvUF_Target"].Portrait3D:GetModelFileID())
		else
			ElvUI_EltreumUI:Print("Target either doesn't exist or doesn't have 3D model portrait enabled")
		end
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
			print("|cff82B4ff/!key and /!keys|r - Links your keystone and covenant in chat")
		end
		print("|cff82B4ff/eltruism background|r - Toggles chat between grey and black background colors for ElvUI")
		print("|cff82B4ff/eltruism color|r - Toggles unitframe between light and dark modes")
		print("|cff82B4ff/eltruism gradient|r - Activates gradient mode")
		print("|cff82B4ff/eltruism chat|r - Toggles chat between dark and transparent modes")
		print("|cff82B4ff/eltruismdebug on/off|r - Toggles debug mode where addons will be disabled/enabled for troubleshooting")
		print("|cff82B4ff/eltruism weakauras|r - Toggles actionbars to be similart o WeakAuras, will overwrite settings")
	end
end

--ty luckyone for allowing me to use this
local AddOns = {
	["ElvUI"] = true,
	["ElvUI_Libraries"] = true,
	["ElvUI_Options"] = true,
	["ElvUI_EltreumUI"] = true,
	["AddOnSkins"] = true,
	["!BugGrabber"] = true,
	["BugSack"] = true,
}
function ElvUI_EltreumUI:DebugMode(message)
	local switch = strlower(message)
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
	else
		ElvUI_EltreumUI:Print("Usage: /eltruismdebug on or /eltruismdebug off, to enable or disable debug mode")
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
				local itemLink, _, _, itemID = select(7, C_Container.GetContainerItemInfo(bag, slot))
				if itemID and ids[itemID] then
					keys[itemID] = itemLink
				end
			end
		end
	end
	local channel = (event == 'CHAT_MSG_GUILD' and 'GUILD') or (event == 'CHAT_MSG_PARTY_LEADER' and 'PARTY') or (event == 'CHAT_MSG_PARTY' and 'PARTY')
	local function link(channel)
		update()
		-- Add covenant data
		local covenantID = C_Covenants.GetActiveCovenantID()
		local covenantData = covenantID and C_Covenants.GetCovenantData(covenantID)
		local covenantName = ''
		if covenantData then
		covenantName = covenantData.name
		end
		if E.db.ElvUI_EltreumUI.otherstuff.mpluskeys then
			for _, itemlink in next, keys do
				message = ""..itemlink
				SendChatMessage(message..(covenantName and (' ('..covenantName..')') or ''), channel)
			end
		end
	end

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
			_G.ChallengesKeystoneFrame:SetScript("OnShow", function()
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
