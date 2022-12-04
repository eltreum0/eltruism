local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local compatibilityran = false
local addonname = "NAME"

--check for stuff that would cause problems
function ElvUI_EltreumUI:CheckCompatibility()
	if IsAddOnLoaded("ElvUI_MerathilisUI") then
		if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel and (E.db.mui.armory.character.classIcon or E.db.mui.armory.character.classIcon == nil) then
			E.db.mui.armory.character.classIcon = false
			E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if (E.db.ElvUI_EltreumUI.skins.expandarmorybg or E.db.ElvUI_EltreumUI.skins.classicarmory) and (E.db.mui.armory.character.enable or E.db.mui.armory.character.enable == nil) then
			E.db.mui.armory.character.enable = false
			E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
			E.db.ElvUI_EltreumUI.skins.classicarmory = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if (E.db.ElvUI_EltreumUI.skins.expandarmorybg or E.db.ElvUI_EltreumUI.skins.classicarmory) and (E.db.mui.armory.inspect.enable or E.db.mui.armory.inspect.enable == nil) then
			E.db.mui.armory.inspect.enable = false
			E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
			E.db.ElvUI_EltreumUI.skins.classicarmory = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.statcolors and (E.db.mui.armory.stats.classColorGradient or E.db.mui.armory.stats.classColorGradient == nil) then
			E.db.mui.armory.stats.classColorGradient = false
			E.db.ElvUI_EltreumUI.skins.statcolors = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable and (E.db.mui.nameplates.enhancedAuras.enable or E.db.mui.nameplates.enhancedAuras.enable == nil) then
			E.db.mui.nameplates.enhancedAuras.enable = false
			E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.mui.nameplates.gradient or E.db.mui.nameplates.gradient == nil then
			E.db.mui.nameplates.gradient = false
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons and (E.db.mui.unitframes.roleIcons.enable or E.db.mui.unitframes.roleIcons.enable == nil) then
			E.db.mui.unitframes.roleIcons.enable = false
			E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		--[[if E.db.ElvUI_EltreumUI.skins.instances.enable and E.db.mui.maps.minimap.instanceDifficulty.enable then
			E.db.mui.maps.minimap.instanceDifficulty.enable = false
			E.db.ElvUI_EltreumUI.skins.instances.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end]]

		if E.db.ElvUI_EltreumUI.skins.doom.enable and (E.db.mui.cooldownFlash.enable or E.db.mui.cooldownFlash.enable == nil) then
			E.db.mui.cooldownFlash.enable = false
			E.db.ElvUI_EltreumUI.skins.doom.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable and (E.db.mui.maps.superTracker.enable or E.db.mui.maps.superTracker.enable == nil) then
			E.db.mui.maps.superTracker.enable = false
			E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.autopin and (E.db.mui.maps.superTracker.autoTrackWaypoint or E.db.mui.maps.superTracker.autoTrackWaypoint == nil) then
			E.db.mui.maps.superTracker.autoTrackWaypoint = false
			E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.autopin = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable and (E.db.mui.unitframes.castbar.spark.enable or E.db.mui.unitframes.castbar.spark.enable == nil) then
			E.db.mui.unitframes.castbar.spark.enable = false
			E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture and (E.db.mui.unitframes.castbar.enable or E.db.mui.unitframes.castbar.enable == nil) then
			E.db.mui.unitframes.castbar.enable = false
			E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.castbartexture = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.loot.loottext.combatindicator and (E.db.mui.CombatAlert.enable or E.db.mui.CombatAlert.enable == nil) then
			E.db.mui.CombatAlert.enable = false
			E.db.ElvUI_EltreumUI.loot.loottext.combatindicator = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons and (E.db.mui.chat.roleIcons.enable or E.db.mui.chat.roleIcons.enable == nil) then
			E.db.mui.chat.roleIcons.enable = false
			E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.chat.looticons and (E.db.mui.chat.chatLink.enable or E.db.mui.chat.chatLink.enable == nil) then
			E.db.mui.chat.chatLink.enable = false
			E.db.ElvUI_EltreumUI.chat.looticons = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.quests and (E.db.mui.blizzard.objectiveTracker.enable or E.db.mui.blizzard.objectiveTracker.enable == nil) then
			E.db.mui.blizzard.objectiveTracker.enable = false
			E.db.ElvUI_EltreumUI.skins.quests = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and (E.db.mui.media.zoneText.enable or E.db.mui.media.zoneText.enable == nil) then
			E.db.mui.media.zoneText.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and (E.db.mui.media.miscText.mail.enable or E.db.mui.media.miscText.mail.enable == nil) then
			E.db.mui.media.miscText.mail.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and (E.db.mui.media.miscText.gossip.enable or E.db.mui.media.miscText.gossip.enable == nil) then
			E.db.mui.media.miscText.gossip.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and (E.db.mui.media.miscText.questFontSuperHuge.enable or E.db.mui.media.miscText.questFontSuperHuge.enable == nil) then
			E.db.mui.media.miscText.questFontSuperHuge.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.mui.unitframes.power.enable or E.db.mui.unitframes.power.enable == nil then
			E.db.mui.unitframes.power.enable = false
			E.db.ElvUI_EltreumUI.unitframes.models.powerbar = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.private.mui.skins.addonSkins.dt or E.private.mui.skins.addonSkins.dt == nil then
			E.private.mui.skins.addonSkins.dt = false
			E.db.ElvUI_EltreumUI.skins.details = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

	end

	E.PopupDialogs["ELTRUISMCOMPATIBILITYFIX"] = {
		text = "|cffFF0000"..L["WARNING"]..":|r "..addonname..L[" was detected. To prevent issues some settings were changed."],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}

	if addonname ~= "NAME" and compatibilityran == true then
		E:StaticPopup_Show('ELTRUISMCOMPATIBILITYFIX')
	end
end
