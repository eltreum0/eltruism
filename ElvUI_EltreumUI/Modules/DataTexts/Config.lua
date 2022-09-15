local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local DT = E:GetModule("DataTexts")
local InCombatLockdown = _G.InCombatLockdown
local UIErrorsFrame = _G.UIErrorsFrame
local ERR_NOT_IN_COMBAT = _G.ERR_NOT_IN_COMBAT

local lastPanelEltruismConfig
local displayStringEltruismconfig = ''
local function EltruismConfigOnEvent(self)
	lastPanelEltruismConfig = self
	self.text:SetFormattedText(displayStringEltruismconfig, E.global.datatexts.settings.ElvUI.Label ~= '' and E.global.datatexts.settings.ElvUI.Label or 'Eltruism')
end

local function EltruismConfigOnEnter()
	DT.tooltip:ClearLines()
	DT.tooltip:AddDoubleLine(L["Left Click:"], L["Open Eltruism Configuration Panel"], 1, 1, 1)
	DT.tooltip:AddDoubleLine(L["Right Click:"], L["Open Eltruism Installation"], 1, 1, 1)
	DT.tooltip:Show()
end

local function EltruismConfigOnClick(_, button)
	if InCombatLockdown() then UIErrorsFrame:AddMessage("|cffFF0000"..ERR_NOT_IN_COMBAT.."|r") end
	if not InCombatLockdown() then
		if button == 'LeftButton' then
			E:ToggleOptionsUI()
			E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
		elseif button == 'RightButton' then
			E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
		end
	end
end

local function EltruismConfigValueColorUpdate(hex)
	displayStringEltruismconfig = strjoin('', hex, '%s|r')

	if lastPanelEltruismConfig then
		EltruismConfigOnEvent(lastPanelEltruismConfig, 'ELVUI_COLOR_UPDATE')
	end
end
E.valueColorUpdateFuncs[EltruismConfigValueColorUpdate] = true
DT:RegisterDatatext('Eltruism', nil, nil, EltruismConfigOnEvent, nil, EltruismConfigOnClick, EltruismConfigOnEnter, nil, L["Eltruism Config"], nil, EltruismConfigValueColorUpdate)
