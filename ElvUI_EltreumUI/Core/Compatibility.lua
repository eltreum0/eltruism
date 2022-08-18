local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--check for stuff that would cause problems
function ElvUI_EltreumUI:CheckCompatibility()
	E.PopupDialogs["ELTRUISMCOMPATIBILITYFIX"] = {
		text = L["MerathilisUI was detected, due to MerathilisUI and Eltruism doing some things that are similar, such as armory and gradient nameplates, those settings were disabled in order to not cause issues"],
		button1 = OKAY,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = false,
	}


 	if IsAddOnLoaded("ElvUI_MerathilisUI") then
 		E:StaticPopup_Show('ELTRUISMCOMPATIBILITYFIX')

 		if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel == true and E.db["mui"]["armory"]["character"]["classIcon"] == true then
 			E.db["mui"]["armory"]["character"]["classIcon"] = false
 		end

 	end
end
