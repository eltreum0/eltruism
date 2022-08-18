local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
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

 		if E.db.ElvUI_EltreumUI.widenameplate.enable and E.db.mui.nameplates.enhancedAuras.enable then
 			E.db.mui.nameplates.enhancedAuras.enable = false
 			E.db.ElvUI_EltreumUI.widenameplate.enable = true
 			compatibilityran = true
 			addonname = "MerathilisUI"
 		end

 		if E.db.ElvUI_EltreumUI.gradientmode.npenable and E.db.mui.nameplates.gradient then
 			E.db.mui.nameplates.gradient = false
 			E.db.ElvUI_EltreumUI.gradientmode.npenable = true
 			compatibilityran = true
 			addonname = "MerathilisUI"
 		end

 		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons and E.db.mui.unitframes.roleIcons then
 			E.db.mui.unitframes.roleIcons = false
 			E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons = true
 			compatibilityran = true
 			addonname = "MerathilisUI"
 		end

 		if E.db.ElvUI_EltreumUI.instances.enable and E.db.mui.maps.minimap.instanceDifficulty.enable then
 			E.db.mui.maps.minimap.instanceDifficulty.enable = false
 			E.db.ElvUI_EltreumUI.instances.enable = true
 			compatibilityran = true
 			addonname = "MerathilisUI"
 		end

 		if E.db.ElvUI_EltreumUI.loottext.combatindicator and E.db.mui.CombatAlert.enable then
 			E.db.mui.CombatAlert.enable = false
 			E.db.ElvUI_EltreumUI.loottext.combatindicator = true
 			compatibilityran = true
 			addonname = "MerathilisUI"
 		end


 	end







 	E.PopupDialogs["ELTRUISMCOMPATIBILITYFIX1"] = {
		text = addonname..L[" was detected, due to "..addonname.." and Eltruism doing some things that are similar, settings that are similar were disabled"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}

	E:StaticPopup_Show('ELTRUISMCOMPATIBILITYFIX')
end
