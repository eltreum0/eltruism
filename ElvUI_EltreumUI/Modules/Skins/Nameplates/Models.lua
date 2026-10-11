local E, _, _, P = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local CreateFrame = _G.CreateFrame
local UnitExists = _G.UnitExists
local rad = _G.rad
local type = _G.type

--Adds a model of the Target to the Target nameplate
local target3d = CreateFrame('PlayerModel', "EltruismNameplateModel", E.HiddenFrame or _G.UIParent)
target3d:Hide()
local targetNameplate

--function to clear model when unselected or hidden
local function ClearTargetModel()
	targetNameplate = nil
	target3d:ClearAllPoints()
	target3d:ClearModel()
	target3d:SetAlpha(0)
	target3d:Hide()
	if E.HiddenFrame then
		target3d:SetParent(E.HiddenFrame)
	end
end

--function to set model settings
local function SetNameplateModelSettings(nameplate)
	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions then
		return
	end
	target3d:SetParent(nameplate.Health)
	target3d:SetFrameLevel(nameplate.Health:GetFrameLevel())
	target3d:ClearModel()
	target3d:SetUnit(nameplate.__unit)
	target3d:SetDesaturation(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.desaturation or 0)
	target3d:SetPaused(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.paused or false)
	target3d:SetPortraitZoom(1) --allows the same cam as elvui UF
	target3d:SetCamDistanceScale(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.CamDistanceScale or 2)
	target3d:SetViewTranslation((E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationx or 0) * 100, (E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationy or 0) * 100)
	target3d:SetRotation(rad(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.Rotation or 0))
	target3d:SetAlpha(0)
	if E.db.nameplates.clickSize and E.db.nameplates.clickSize.enemyWidth then
		target3d:SetSize(E.db.nameplates.clickSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight or 14)
	else
		target3d:SetSize(P.nameplates.clickSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight or 14)
	end
	target3d:ClearAllPoints()
	target3d:SetPoint("CENTER", nameplate.Health, "CENTER")
	target3d:SetInside(nameplate.Health, 0, 0) --(obj, anchor, xOffset, yOffset, anchor2, noScale)
	target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha or 0.5)
	target3d:Show()
end

local function DelayedNameplateModelSettings()
	if UnitExists("target") and targetNameplate and targetNameplate.__unit and E:UnitIsUnit(targetNameplate.__unit, "target") then
		SetNameplateModelSettings(targetNameplate)
	end
end

function ElvUI_EltreumUI:NameplateModel(_, nameplate, removed)
	if not E.db.ElvUI_EltreumUI or not E.db.ElvUI_EltreumUI.nameplates or not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions then return end
	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel then
		ClearTargetModel()
		return
	end

	if removed and nameplate and nameplate == targetNameplate then
		ClearTargetModel()
		return
	end

	if not UnitExists("target") then
		ClearTargetModel()
		return
	end

	if not nameplate or type(nameplate) ~= "table" then return end

	if nameplate.__unit and E:UnitIsUnit(nameplate.__unit, "target") then
		if nameplate.Health and nameplate.Health:IsVisible() then
			targetNameplate = nameplate
			SetNameplateModelSettings(nameplate)

			--first delay, for selecting a target and fixing camera
			E:Delay(0.098, DelayedNameplateModelSettings)

			--second delay, for when swapping targets too fast can cause it to incorrectly set the previous target
			E:Delay(0.150, DelayedNameplateModelSettings)
		else
			ClearTargetModel()
		end
	elseif targetNameplate == nameplate then
		ClearTargetModel()
	end
end
ElvUI_EltreumUI:SecureHook(NP, "SetupTarget", "NameplateModel")

local eventFrame = CreateFrame("FRAME")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:SetScript("OnEvent", function()
	if not UnitExists("target") then
		ClearTargetModel()
	end
end)
