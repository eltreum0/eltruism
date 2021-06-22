local _G = _G
local unpack = _G.unpack
local select = _G.select
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

function ElvUI_EltreumUI:Changelog(value)
	if E.db.ElvUI_EltreumUI.changelog.version == "2.0.0" then
		return ElvUI_EltreumUI:Changelogv2()
	elseif E.db.ElvUI_EltreumUI.changelog.version == "1.0.0" then
		return ElvUI_EltreumUI:Changelogv1()
	else
		return [[Changelog could not be loaded due to a missing setting on user's side. Please select a version from the dropdown to fix this error.]]
	end
end
