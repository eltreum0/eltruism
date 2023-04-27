local E, _, _, P = unpack(ElvUI)
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local UnitExists = _G.UnitExists
local rad = _G.rad

--Adds a model of the Target to the Target nameplate
local target3d = CreateFrame('PlayerModel', "EltruismNameplateModel")
--function to set model settings
local function SetNameplateModelSettings(nameplate)
	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions then
		return
	end
	target3d:ClearModel()
	target3d:SetUnit(nameplate.unit)
	target3d:SetDesaturation(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.desaturation or 0)
	target3d:SetPaused(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.paused or false)
	target3d:SetPortraitZoom(1) --allows the same cam as elvui UF
	target3d:SetCamDistanceScale(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.CamDistanceScale or 2)
	target3d:SetViewTranslation((E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationx or 0) * 100, (E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationy or 0) * 100)
	target3d:SetRotation(rad(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.Rotation or 0))
	target3d:SetAlpha(0)
	target3d:SetParent(nameplate.Health)
	target3d:SetFrameLevel(nameplate.Health:GetFrameLevel())
	if E.db.nameplates.plateSize and E.db.nameplates.plateSize.enemyWidth then
		target3d:SetSize(E.db.nameplates.plateSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight or 14)
	else
		target3d:SetSize(P.nameplates.plateSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight or 14)
	end
	target3d:ClearAllPoints()
	target3d:SetPoint("CENTER", nameplate.Health, "CENTER")
	target3d:SetInside(nameplate.Health, 0, 0) --(obj, anchor, xOffset, yOffset, anchor2, noScale)
	target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha or 0.5)
	--target3d:SetAnimation(3) --stand still
	--target3d:FreezeAnimation(60, 0, 55) -- Freeze the talking animation at the frame 55
	--target3d:SetFacing(-(math.pi/2)) --better than rotation?
	--adds fog
	--target3d:SetFogColor(r,g,b)
	--target3d:SetFogNear(0)
	--target3d:SetFogFar(10)
	--or light (dont use with fog)
	--target3d:SetLight(enabled, omni, dirX,dirY,dirZ, ambIntensity,ambR,ambG,ambB, dirIntensity,dirR,dirG,dirB)
end

function ElvUI_EltreumUI:NameplateModel(nameplate)
	if not E.db.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI.nameplates then return end
	if not E.db.ElvUI_EltreumUI.nameplates.nameplateOptions then return end
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel then

		if UnitExists("target")then
			if nameplate and nameplate.unit and UnitIsUnit(nameplate.unit,"target") then
				ElvUI_EltreumUI:NameplateCustomOptions(nameplate) --testing sending unit to other function
				if nameplate.Health and nameplate.Health:IsVisible() then

					--original, but can have wrong camera
					SetNameplateModelSettings(nameplate)

					--first delay, for selecting a target and fixing camera
					E:Delay(0.098, function()
						if UnitExists("target") then
							SetNameplateModelSettings(nameplate)
							target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha)
						end
					end)

					--second delay, for when swapping targets too fast can cause it to incorrectly set the previous target
					E:Delay(0.150, function()
						if UnitExists("target") then
							SetNameplateModelSettings(nameplate)
							target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha)
						end
					end)

				else
					target3d:ClearAllPoints()
					target3d:SetAlpha(0)
				end
			else
				target3d:ClearAllPoints()
				target3d:SetAlpha(0)
			end
		else
			target3d:ClearAllPoints()
			target3d:SetAlpha(0)
		end
	end
end
hooksecurefunc(NP, "SetupTarget", ElvUI_EltreumUI.NameplateModel)
