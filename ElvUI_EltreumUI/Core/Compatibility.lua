local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local compatibilityran = false
local addonname


--check for stuff that would cause problems


function ElvUI_EltreumUI:CheckCompatibility()
	E.PopupDialogs["ELTRUISMCOMPATIBILITYFIX"] = {
		text = addonname..L[" was detected, due to "..addonname.." and Eltruism doing some things that are similar, settings that are similar were disabled"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}


 	if IsAddOnLoaded("ElvUI_MerathilisUI") then
 		E:StaticPopup_Show('ELTRUISMCOMPATIBILITYFIX')

 		if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel == true and E.db["mui"]["armory"]["character"]["classIcon"] == true then
 			E.db["mui"]["armory"]["character"]["classIcon"] = false
 			compatibilityran = true
 			addonname = "MerathilisUI"
 		end




 	end
end
