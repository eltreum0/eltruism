local E, L, V, P, G = unpack(ElvUI)
local classcolor = E:ClassColor(E.myclass, true)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local tostring = _G.tostring

-- WarpDeplete profile setup
function ElvUI_EltreumUI:GetWarpDepleteProfile()
	if IsAddOnLoaded("WarpDeplete") then
		WarpDepleteDB["profileKeys"][E.mynameRealm] = E.mynameRealm
		WarpDepleteDB["global"]["mdtAlertShown"] = true
		WarpDepleteDB["profiles"][E.mynameRealm] = {
			["timerSuccessColor"] = "ff00ff24",
			["bar1TextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			["forcesFont"] = E.db.general.font,
			["frameX"] = 0,
			["completedObjectivesColor"] = not E.myclass == "PRIEST" and tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")) or tostring(E:RGBToHex(classcolor.r-0.4, classcolor.g-0.4, classcolor.b-0.4, "ff", "")),
			["keyDetailsFontSize"] = 14,
			["timerFont"] = E.db.general.font,
			["bar3Font"] = E.db.general.font,
			["bar3TextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			["objectivesFont"] = E.db.general.font,
			["keyDetailsFont"] = E.db.general.font,
			["keyFont"] = E.db.general.font,
			--["prideGlowColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			--["showPrideGlow"] = false, --nvm still shows the annoying mdt popup even when disabled
			["deathsFont"] = E.db.general.font,
			["completedForcesColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			["bar1Font"] = E.db.general.font,
			["bar2TextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			["bar2Font"] = E.db.general.font,
			["frameY"] = -92.44456481933594,
			["forcesTextureColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			["bar1Texture"] = "ElvUI Norm1",
			["bar2Texture"] = "ElvUI Norm1",
			["forcesOverlayTexture"] = "Eltreum-Blank",
			["bar3Texture"] = "ElvUI Norm1",
			["forcesTexture"] = "Asphyxia-Norm",
			["timerRunningColor"] = tostring(E:RGBToHex(classcolor.r, classcolor.g, classcolor.b, "ff", "")),
			["forcesFontSize"] = 18,
			["forcesOverlayTextureColor"] = "ffffffff",
			["insertKeystoneAutomatically"] = false,
		}

		ElvUI_EltreumUI:Print(L["WarpDeplete profile has been set."])
	else
		ElvUI_EltreumUI:Print(L["WarpDeplete is not loaded"])
	end
end
