local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local NP = E:GetModule('NamePlates')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local UnitExists = _G.UnitExists

--Adds a model of the Target to the Target nameplate
local target3d = CreateFrame('PlayerModel', "EltruismNameplateModel")
--function to set model settings
local function SetNameplateModelSettings(nameplate)
	target3d:ClearModel()
	target3d:SetUnit(nameplate.unit)
	target3d:SetDesaturation(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.desaturation)
	target3d:SetPaused(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.paused)
	target3d:SetPortraitZoom(1) --allows the same cam as elvui UF
	target3d:SetCamDistanceScale(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.CamDistanceScale)
	target3d:SetViewTranslation(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationx*100,E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ViewTranslationy*100)
	target3d:SetRotation(rad(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.Rotation))
	target3d:SetAlpha(0)
	target3d:SetParent(nameplate.Health)
	target3d:SetFrameLevel(nameplate.Health:GetFrameLevel())
	target3d:SetSize(E.db.nameplates.plateSize.enemyWidth or P.nameplates.plateSize.enemyWidth, E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.incombatHeight)
	target3d:ClearAllPoints()
	target3d:SetPoint("CENTER", nameplate.Health, "CENTER")
	target3d:SetInside(nameplate.Health, 0, 0) --(obj, anchor, xOffset, yOffset, anchor2, noScale)
	target3d:SetAlpha(E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.modelalpha)
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
	if E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel then

		if UnitExists("target") then
			if nameplate and nameplate.unit then
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
			end
		else
			target3d:ClearAllPoints()
			target3d:SetAlpha(0)
		end
	end
end
hooksecurefunc(NP, "SetupTarget", ElvUI_EltreumUI.NameplateModel)
