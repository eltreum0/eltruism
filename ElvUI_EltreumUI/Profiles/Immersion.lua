local E, L, V, P, G = unpack(ElvUI)

-- Immersion profile setup
function ElvUI_EltreumUI:GetImmersionProfile()
	ImmersionSetup = {
		["strata"] = "MEDIUM",
		["scale"] = 0.8,
		["elementscale"] = 1,
		["boxoffsetY"] = -133.80126953125,
		["immersivemode"] = true,
		["titleoffset"] = 453.3848906017483,
		["enablenumbers"] = true,
		["boxpoint"] = "Top",
		["disableprogression"] = false,
		["titleoffsetY"] = 113.8747863769531,
		["hideui"] = false,
		["titlescale"] = 1,
		["delaydivisor"] = 40,
		["boxoffsetX"] = -0.02017488703131676,
		["boxscale"] = 1,
		["accept"] = "SPACE",
		["showprogressbar"] = true,
		["solidbackground"] = true,
		["boxlock"] = true,
		["anidivisor"] = 5,
		["flipshortcuts"] = false,
		["inspect"] = "SHIFT",
		["titlelock"] = true,
		["nameplatemode"] = false,
		["movetalkinghead"] = true,
		["supertracked"] = false,
		["onthefly"] = false,
		["reset"] = "TAB",
	}
end
