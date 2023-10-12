local E, L = unpack(ElvUI)
local _G = _G
local DT = E:GetModule("DataTexts")
local InCombatLockdown = _G.InCombatLockdown
local UIErrorsFrame = _G.UIErrorsFrame
local ERR_NOT_IN_COMBAT = _G.ERR_NOT_IN_COMBAT

local function EltruismConfigOnEvent(self)
	self.text:SetText('|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogodev.tga:14:14:0:0|t'..E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1))
end

local function EltruismConfigOnEnter()
	DT.tooltip:ClearLines()
	DT.tooltip:AddDoubleLine(L["Left Click:"], L["Open Eltruism Configuration Panel"], 1, 1, 1)
	DT.tooltip:AddDoubleLine(L["Right Click:"], L["Open Eltruism Installation"], 1, 1, 1)
	DT.tooltip:Show()
end

local function EltruismConfigOnClick(_, button)
	if InCombatLockdown() then UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1.0, 0.2, 0.2, 1.0) end
	if not InCombatLockdown() then
		if button == 'LeftButton' then
			E:ToggleOptions('ElvUI_EltreumUI')
			--E.Libs.AceConfigDialog:SelectGroup('ElvUI', 'ElvUI_EltreumUI')
		elseif button == 'RightButton' then
			E:GetModule('PluginInstaller'):Queue(ElvUI_EltreumUI.InstallerData)
		end
	end
end
DT:RegisterDatatext('Eltruism', nil, nil, EltruismConfigOnEvent, nil, EltruismConfigOnClick, EltruismConfigOnEnter, nil, L["Eltruism Config"])
