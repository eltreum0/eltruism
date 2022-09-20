local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local compatibilityran = false
local addonname = "NAME"

--check for stuff that would cause problems
function ElvUI_EltreumUI:CheckCompatibility()
	if IsAddOnLoaded("ElvUI_MerathilisUI") then
		if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel and E.db.mui.armory.character.classIcon then
			E.db.mui.armory.character.classIcon = false
			E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if (E.db.ElvUI_EltreumUI.skins.expandarmorybg or E.db.ElvUI_EltreumUI.skins.classicarmory) and E.db.mui.armory.character.enable then
			E.db.mui.armory.character.enable = false
			E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
			E.db.ElvUI_EltreumUI.skins.classicarmory = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if (E.db.ElvUI_EltreumUI.skins.expandarmorybg or E.db.ElvUI_EltreumUI.skins.classicarmory) and E.db.mui.armory.inspect.enable then
			E.db.mui.armory.inspect.enable = false
			E.db.ElvUI_EltreumUI.skins.expandarmorybg = true
			E.db.ElvUI_EltreumUI.skins.classicarmory = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.statcolors and E.db.mui.armory.stats.classColorGradient then
			E.db.mui.armory.stats.classColorGradient = false
			E.db.ElvUI_EltreumUI.skins.statcolors = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable and E.db.mui.nameplates.enhancedAuras.enable then
			E.db.mui.nameplates.enhancedAuras.enable = false
			E.db.ElvUI_EltreumUI.nameplates.widenameplate.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.mui.nameplates.gradient then
			E.db.mui.nameplates.gradient = false
			E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons and E.db.mui.unitframes.roleIcons.enable then
			E.db.mui.unitframes.roleIcons.enable = false
			E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.instances.enable and E.db.mui.maps.minimap.instanceDifficulty.enable then
			E.db.mui.maps.minimap.instanceDifficulty.enable = false
			E.db.ElvUI_EltreumUI.skins.instances.enable = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.loot.loottext.combatindicator and E.db.mui.CombatAlert.enable then
			E.db.mui.CombatAlert.enable = false
			E.db.ElvUI_EltreumUI.loot.loottext.combatindicator = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.chat.looticons and E.db.mui.chat.chatLink.enable then
			E.db.mui.chat.chatLink.enable = false
			E.db.ElvUI_EltreumUI.chat.looticons = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.quests and E.db.mui.blizzard.objectiveTracker.enable then
			E.db.mui.blizzard.objectiveTracker.enable = false
			E.db.ElvUI_EltreumUI.skins.quests = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and E.db.mui.media.zoneText.enable then
			E.db.mui.media.zoneText.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and E.db.mui.media.miscText.mail.enable then
			E.db.mui.media.miscText.mail.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and E.db.mui.media.miscText.gossip.enable then
			E.db.mui.media.miscText.gossip.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.ElvUI_EltreumUI.skins.zones and E.db.mui.media.miscText.questFontSuperHuge.enable then
			E.db.mui.media.miscText.questFontSuperHuge.enable = false
			E.db.ElvUI_EltreumUI.skins.zones = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.db.mui.unitframes.power.enable then
			E.db.mui.unitframes.power.enable = false
			E.db.ElvUI_EltreumUI.unitframes.models.powerbar = true
			compatibilityran = true
			addonname = "MerathilisUI"
		end

		if E.private.mui.skins.addonSkins.dt then
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
