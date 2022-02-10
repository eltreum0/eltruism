local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- AddOnSkins Profile
function ElvUI_EltreumUI:AddonSetupAS()
	if IsAddOnLoaded('AddOnSkins') then
		ElvUI_EltreumUI:GetASProfile()
		ElvUI_EltreumUI:Print(L["AddOnSkins profile has been set."])
	else
		ElvUI_EltreumUI:Print("AddOnSkins is not loaded")
	end
end

-- Immersion Profile
function ElvUI_EltreumUI:AddonSetupImmersion()
	if IsAddOnLoaded('Immersion') then
		ElvUI_EltreumUI:GetImmersionProfile()
		ElvUI_EltreumUI:Print(L["Immersion profile has been set."])
	else
		ElvUI_EltreumUI:Print("Immersion is not loaded")
	end
end

-- BigWigs Profile
function ElvUI_EltreumUI:AddonSetupBW()
	if IsAddOnLoaded('BigWigs') then
		ElvUI_EltreumUI:GetBigWigsProfile()
		ElvUI_EltreumUI:Print(L["BigWigs profile has been set."])
	else
		ElvUI_EltreumUI:Print("BigWigs is not loaded")
	end
end

-- DBM Profile
function ElvUI_EltreumUI:AddonSetupDBM()
	if IsAddOnLoaded('DBM-Core') then
		ElvUI_EltreumUI:GetDBMProfile()
		ElvUI_EltreumUI:Print(L["DBM profile has been set."])
	else
		ElvUI_EltreumUI:Print("DBM is not loaded")
	end
end

-- Details Profile
function ElvUI_EltreumUI:AddonSetupDT()
	if IsAddOnLoaded('Details') then
		ElvUI_EltreumUI:GetDetailsProfile()
		ElvUI_EltreumUI:Print(L["Details profile using Blizzard icons has been set."])
	else
		ElvUI_EltreumUI:Print("Details is not loaded")
	end
end

function ElvUI_EltreumUI:AddonSetupDTReleaf()
	if IsAddOnLoaded('Details') then
		ElvUI_EltreumUI:GetDetailsProfileReleaf()
		ElvUI_EltreumUI:Print("Details profile using Releaf Transparent icons has been set.")
	else
		ElvUI_EltreumUI:Print("Details is not loaded")
	end
end

function ElvUI_EltreumUI:AddonSetupDTReleafv3()
	if IsAddOnLoaded('Details') then
		ElvUI_EltreumUI:GetDetailsProfileReleaf()
		ElvUI_EltreumUI:Print("Details profile using Releaf Solid icons has been set.")
	else
		ElvUI_EltreumUI:Print("Details is not loaded")
	end
end

-- DynamicCam Profile
function ElvUI_EltreumUI:AddonSetupDynamicCam()
	if IsAddOnLoaded('DynamicCam') then
		ElvUI_EltreumUI:GetDynamicCamProfile()
		ElvUI_EltreumUI:Print(L["Dynamic Cam profile has been set."])
	else
		ElvUI_EltreumUI:Print("Dynamic Cam is not loaded")
	end
end

-- GladiusEx Profile
function ElvUI_EltreumUI:AddonSetupGladiusEx()
	if IsAddOnLoaded('GladiusEx') then
		ElvUI_EltreumUI:GetGladiusExProfile()
		ElvUI_EltreumUI:Print(L["GladiusEx profile has been set."])
	else
		ElvUI_EltreumUI:Print("GladiusEx is not loaded")
	end
end

-- MRT Profile
function ElvUI_EltreumUI:AddonSetupMRT()
	if IsAddOnLoaded('MRT') then
		ElvUI_EltreumUI:GetMRTProfile()
		ElvUI_EltreumUI:Print(L["Method Raid Tools profile has been set."])
	else
		ElvUI_EltreumUI:Print("Method Raid Tools is not loaded")
	end
end

-- ProjectAzilroka Profile
function ElvUI_EltreumUI:AddonSetupPA()
	if IsAddOnLoaded('ProjectAzilroka') then
		ElvUI_EltreumUI:GetPAProfile()
		ElvUI_EltreumUI:Print(L["ProjectAzilroka profile has been set."])
	else
		ElvUI_EltreumUI:Print("ProjectAzilroka is not loaded")
	end
end

-- Questie Profile
function ElvUI_EltreumUI:AddonSetupQuestie()
	if IsAddOnLoaded('Questie') then
		ElvUI_EltreumUI:GetQuestieProfile()
		ElvUI_EltreumUI:Print(L["Questie profile has been set."])
	else
		ElvUI_EltreumUI:Print("Questie is not loaded")
	end
end

-- NameplateSCT Profile
function ElvUI_EltreumUI:AddonSetupNameplateSCT()
	if IsAddOnLoaded('NameplateSCT') then
		ElvUI_EltreumUI:GetNameplateSCTProfile()
		SetCVar("enableFloatingCombatText", 0)
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			SetCVar("floatingCombatTextCombatDamage", 0)
		end
		ElvUI_EltreumUI:Print(L["NameplateSCT profile has been set."])
	else
		ElvUI_EltreumUI:Print("NameplateSCT is not loaded")
	end
end

-- FCT Profile
function ElvUI_EltreumUI:AddonSetupFCT()
	if IsAddOnLoaded('ElvUI_FCT') then
		ElvUI_EltreumUI:GetFCTProfile()
		SetCVar("enableFloatingCombatText", 0)
		if ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			SetCVar("floatingCombatTextCombatDamage", 0)
		end
		ElvUI_EltreumUI:Print(L["Floating Combat Text profile has been set."])
	else
		ElvUI_EltreumUI:Print("Floating Combat Text is not loaded")
	end
end

-- Gladius Profile
function ElvUI_EltreumUI:SetupGladius()
	if IsAddOnLoaded('Gladius') then
		ElvUI_EltreumUI:GetGladiusProfile()
		ElvUI_EltreumUI:Print(L["Gladius profile has been set."])
	else
		ElvUI_EltreumUI:Print("Gladius is not loaded")
	end
end

-- Gladdy Profile
function ElvUI_EltreumUI:SetupGladdy()
	if IsAddOnLoaded('Gladdy') then
		ElvUI_EltreumUI:GetGladdyProfile()
		ElvUI_EltreumUI:Print(L["Gladdy profile has been set."])
	else
		ElvUI_EltreumUI:Print("Gladdy is not loaded")
	end
end
