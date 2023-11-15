local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar

-- AddOnSkins Profile
function ElvUI_EltreumUI:AddonSetupAS()
	if IsAddOnLoaded("AddOnSkins") then
		ElvUI_EltreumUI:GetASProfile()
		ElvUI_EltreumUI:Print(L["AddOnSkins profile has been set."])
	else
		ElvUI_EltreumUI:Print("AddOnSkins is not loaded")
	end
end

-- Immersion Profile
function ElvUI_EltreumUI:AddonSetupImmersion()
	if IsAddOnLoaded("Immersion") then
		ElvUI_EltreumUI:GetImmersionProfile()
		ElvUI_EltreumUI:Print(L["Immersion profile has been set."])
	else
		ElvUI_EltreumUI:Print("Immersion is not loaded")
	end
end

-- BigWigs Profile
function ElvUI_EltreumUI:AddonSetupBW()
	if IsAddOnLoaded("BigWigs") then
		ElvUI_EltreumUI:GetBigWigsProfile()
		ElvUI_EltreumUI:Print(L["BigWigs profile has been set."])
	else
		ElvUI_EltreumUI:Print("BigWigs is not loaded")
	end
end

-- DBM Profile
function ElvUI_EltreumUI:AddonSetupDBM()
	if IsAddOnLoaded("DBM-Core") then
		ElvUI_EltreumUI:GetDBMProfile()
		ElvUI_EltreumUI:Print(L["DBM profile has been set."])
	else
		ElvUI_EltreumUI:Print("DBM is not loaded")
	end
end

-- Details Profile
function ElvUI_EltreumUI:AddonSetupDT(style)
	if IsAddOnLoaded("Details") then
		if style == "spec" then
			ElvUI_EltreumUI:GetDetailsProfile()
			ElvUI_EltreumUI:Print(L["Details profile using Blizzard icons has been set."])
		elseif style == "releafalpha" then
			ElvUI_EltreumUI:GetDetailsProfileReleaf()
			ElvUI_EltreumUI:Print("Details profile using Releaf Transparent icons has been set.")
		elseif style == "releafsolid" then
			ElvUI_EltreumUI:GetDetailsProfileReleafv3()
			ElvUI_EltreumUI:Print("Details profile using Releaf Solid icons has been set.")
		end
	else
		ElvUI_EltreumUI:Print("Details is not loaded")
	end
end

-- DynamicCam Profile
function ElvUI_EltreumUI:AddonSetupDynamicCam()
	if IsAddOnLoaded("DynamicCam") then
		ElvUI_EltreumUI:GetDynamicCamProfile()
		ElvUI_EltreumUI:Print(L["Dynamic Cam profile has been set."])
	else
		ElvUI_EltreumUI:Print("Dynamic Cam is not loaded")
	end
end

-- GladiusEx Profile
function ElvUI_EltreumUI:AddonSetupGladiusEx()
	if IsAddOnLoaded("GladiusEx") then
		ElvUI_EltreumUI:GetGladiusExProfile()
		ElvUI_EltreumUI:Print(L["GladiusEx profile has been set."])
	else
		ElvUI_EltreumUI:Print("GladiusEx is not loaded")
	end
end

-- MRT Profile
function ElvUI_EltreumUI:AddonSetupMRT()
	if IsAddOnLoaded("MRT") then
		ElvUI_EltreumUI:GetMRTProfile()
		ElvUI_EltreumUI:Print(L["Method Raid Tools profile has been set."])
	else
		ElvUI_EltreumUI:Print("Method Raid Tools is not loaded")
	end
end

-- ProjectAzilroka Profile
function ElvUI_EltreumUI:AddonSetupPA()
	if IsAddOnLoaded("ProjectAzilroka") then
		ElvUI_EltreumUI:GetPAProfile()
		ElvUI_EltreumUI:Print(L["ProjectAzilroka profile has been set."])
	else
		ElvUI_EltreumUI:Print("ProjectAzilroka is not loaded")
	end
end

-- Questie Profile
function ElvUI_EltreumUI:AddonSetupQuestie()
	if IsAddOnLoaded("Questie") then
		ElvUI_EltreumUI:GetQuestieProfile()
		ElvUI_EltreumUI:Print(L["Questie profile has been set."])
	else
		ElvUI_EltreumUI:Print("Questie is not loaded")
	end
end

-- Combat Text Profile
function ElvUI_EltreumUI:AddonSetupCombatText(addon)
	if IsAddOnLoaded("NameplateSCT") or IsAddOnLoaded("ElvUI_FCT") then
		SetCVar("enableFloatingCombatText", 0)
		if E.Wrath or E.Classic then
			SetCVar("floatingCombatTextCombatDamage", 0)
		end
	end
	if addon == "NameplateSCT" then
		if IsAddOnLoaded("NameplateSCT") then
			ElvUI_EltreumUI:GetNameplateSCTProfile()
			ElvUI_EltreumUI:Print(L["NameplateSCT profile has been set."])
		else
			ElvUI_EltreumUI:Print("NameplateSCT is not loaded")
		end
	elseif addon == "ElvUI_FCT" then
		if IsAddOnLoaded("ElvUI_FCT") then
			ElvUI_EltreumUI:GetFCTProfile()
			ElvUI_EltreumUI:Print(L["Floating Combat Text profile has been set."])
		else
			ElvUI_EltreumUI:Print("Floating Combat Text is not loaded")
		end
	end
end

-- Gladius Profile
function ElvUI_EltreumUI:SetupGladius()
	if IsAddOnLoaded("Gladius") then
		ElvUI_EltreumUI:GetGladiusProfile()
		ElvUI_EltreumUI:Print(L["Gladius profile has been set."])
	else
		ElvUI_EltreumUI:Print("Gladius is not loaded")
	end
end

-- Gladdy Profile
function ElvUI_EltreumUI:SetupGladdy()
	if IsAddOnLoaded("Gladdy") then
		ElvUI_EltreumUI:GetGladdyProfile()
		ElvUI_EltreumUI:Print(L["Gladdy profile has been set."])
	else
		ElvUI_EltreumUI:Print("Gladdy is not loaded")
	end
end

-- Repooc's Dynamic Status Icons
function ElvUI_EltreumUI:SetupDynamicStatusIcons()
	if IsAddOnLoaded("ElvUI_DynamicStatusIcons") then
		if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["anchorPoint"] = "BOTTOMRIGHT"
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["color"]["b"] = 0.4274500310421
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["color"]["g"] = 0.60784178972244
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["color"]["r"] = 0.77646887302399
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["faceright"] = true
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["iconpack"] = "Default - Pepe - Traveler"
			E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["scale"] = 0.8
			E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["anchorPoint"] = "BOTTOMLEFT"
			E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["color"]["b"] = 0.4274500310421
			E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["color"]["g"] = 0.60784178972244
			E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["color"]["r"] = 0.77646887302399
			E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["iconpack"] = "Default - Pepe - Clockwork"
			E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["scale"] = 0.8
			if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS/Tank") then
				E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["xOffset"] = -75
				E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["yOffset"] = -83
				E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["xOffset"] = 75
				E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["yOffset"] = -83
			elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
				E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["xOffset"] = -49
				E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["yOffset"] = -88
				E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["xOffset"] = 49
				E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["yOffset"] = -88
			end
			ElvUI_EltreumUI:Print("Dynamic Status Icons was setup")
		else
			ElvUI_EltreumUI:Print("Eltruism profile not found")
		end
	end
end
