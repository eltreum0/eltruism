local E, L = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local tostring = _G.tostring
local pairs = _G.pairs
local setmetatable = _G.setmetatable
local CreateFrame = _G.CreateFrame
local CreateColor = _G.CreateColor
local InCombatLockdown = _G.InCombatLockdown
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut
local embedpanel
local RightChatDamageMeterHook = false
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local GetClassColor = _G.C_ClassColor and _G.C_ClassColor.GetClassColor or _G.GetClassColor
--local canaccessvalue = _G.canaccessvalue
local dmMin = CreateColor(1, 1, 1, 1)
local dmMax = CreateColor(1, 1, 1, 1)
local cachedTextureKey
local cachedTexturePath
local cachedIconPackKey
local cachedIconPackPath

--keep per-frame state in weak tables instead of writing keys onto blizzard frames to avoid tainting secret comparisons
local barState = setmetatable({}, { __mode = "k" })
local widgetOwner = setmetatable({}, { __mode = "k" })
local hookedWidgets = setmetatable({}, { __mode = "k" })
local barBgTextures = setmetatable({}, { __mode = "k" })

--pretty much copied from elvui and edited to look more like details
do

	--[[local BlizzardTextureIDsForSpecs = {
		["608952"] = 270,
		["608953"] = 269,
		["608951"] = 268,
		["136145"] = 265,
		["136172"] = 266,
		["136186"] = 267,
		["135932"] = 62,
		["135810"] = 63,
		["135846"] = 64,
		["4511811"] = 1467,
		["4511812"] = 1468,
		["5198700"] = 1473,
		["1247264"] = 577,
		["1247265"] = 581,
		["7455385"] = 1480, --devourer
		["135940"] = 256,
		["237542"] = 257,
		["136207"] = 258,
		["461112"] = 253,
		["236179"] = 254,
		["461113"] = 255,
		["135920"] = 65,
		["236264"] = 66,
		["135873"] = 70,
		["136048"] = 262,
		["237581"] = 263,
		["136052"] = 264,
		["136096"] = 102,
		["132115"] = 103,
		["132276"] = 104,
		["136041"] = 105,
		["132355"] = 71,
		["132347"] = 72,
		["132341"] = 73,
		["135770"] = 250,
		["135773"] = 251,
		["135775"] = 252,
		["236270"] = 259,
		["236286"] = 260,
		["132320"] = 261,
		--initial specs, seems only evoker doesnt use the same icon
		--["135775"]=1455,
		--["1247264"]=1456,
		--["136096"]=1447,
		["4574311"]=1465,
		--["461112"]=1448,
		--["135846"]=1449,
		--["608953"]=1450,
		--["135873"]=1451,
		--["135940"]=1452,
		--["236270"]=1453,
		--["136048"]=1444,
		--["136145"]=1454,
		--["132355"]=1446,
	}

	--use the same coords as details so its compatible with details icon packs
	--credits for the cords to details and tercio and team
	--have to add devourer
	local class_specs_coords = {
		[577] = {128/512, 192/512, 256/512, 320/512}, --havoc demon hunter
		[581] = {192/512, 256/512, 256/512, 320/512}, --vengeance demon hunter
		[1480] = {448/512, 512/512, 256/512, 320/512}, --devourer demon hunter

		[250] = {0, 64/512, 0, 64/512}, --blood dk
		[251] = {64/512, 128/512, 0, 64/512}, --frost dk
		[252] = {128/512, 192/512, 0, 64/512}, --unholy dk

		[102] = {192/512, 256/512, 0, 64/512}, -- druid balance
		[103] = {256/512, 320/512, 0, 64/512}, -- druid feral
		[104] = {320/512, 384/512, 0, 64/512}, -- druid guardian
		[105] = {384/512, 448/512, 0, 64/512}, -- druid resto

		[253] = {448/512, 512/512, 0, 64/512}, -- hunter bm
		[254] = {0, 64/512, 64/512, 128/512}, --hunter marks
		[255] = {64/512, 128/512, 64/512, 128/512}, --hunter survivor

		[62] = {(128/512) + 0.001953125, 192/512, 64/512, 128/512}, --mage arcane
		[63] = {192/512, 256/512, 64/512, 128/512}, --mage fire
		[64] = {256/512, 320/512, 64/512, 128/512}, --mage frost

		[268] = {320/512, 384/512, 64/512, 128/512}, --monk bm
		[269] = {448/512, 512/512, 64/512, 128/512}, --monk ww
		[270] = {384/512, 448/512, 64/512, 128/512}, --monk mw

		[65] = {0, 64/512, 128/512, 192/512}, --paladin holy
		[66] = {64/512, 128/512, 128/512, 192/512}, --paladin protect
		[70] = {(128/512) + 0.001953125, 192/512, 128/512, 192/512}, --paladin ret

		[256] = {192/512, 256/512, 128/512, 192/512}, --priest disc
		[257] = {256/512, 320/512, 128/512, 192/512}, --priest holy
		[258] = {(320/512) + (0.001953125 * 4), 384/512, 128/512, 192/512}, --priest shadow

		[259] = {384/512, 448/512, 128/512, 192/512}, --rogue assassination
		[260] = {448/512, 512/512, 128/512, 192/512}, --rogue combat
		[261] = {0, 64/512, 192/512, 256/512}, --rogue sub

		[262] = {64/512, 128/512, 192/512, 256/512}, --shaman elemental
		[263] = {128/512, 192/512, 192/512, 256/512}, --shamel enhancement
		[264] = {192/512, 256/512, 192/512, 256/512}, --shaman resto

		[265] = {256/512, 320/512, 192/512, 256/512}, --warlock aff
		[266] = {320/512, 384/512, 192/512, 256/512}, --warlock demo
		[267] = {384/512, 448/512, 192/512, 256/512}, --warlock destro

		[71] = {448/512, 512/512, 192/512, 256/512}, --warrior arms
		[72] = {0, 64/512, 256/512, 320/512}, --warrior fury
		[73] = {64/512, 128/512, 256/512, 320/512}, --warrior protect

		[1467] = {256/512, 320/512, 256/512, 320/512}, -- Devastation
		[1468] = {320/512, 384/512, 256/512, 320/512}, -- Preservation
		[1473] = {384/512, 448/512, 256/512, 320/512}, -- Augmentation
		[1465] = {256/512, 320/512, 256/512, 320/512}, -- Initial, let it use Devastation
	}]]
	local class_coords = {
		["DEMONHUNTER"] = {
			0.73828126 / 2, -- [1]
			1 / 2, -- [2]
			0.5 / 2, -- [3]
			0.75 / 2, -- [4]
		},
		["HUNTER"] = {
			0, -- [1]
			0.25 / 2, -- [2]
			0.25 / 2, -- [3]
			0.5 / 2, -- [4]
		},
		["WARRIOR"] = {
			0, -- [1]
			0.25 / 2, -- [2]
			0, -- [3]
			0.25 / 2, -- [4]
		},
		["ROGUE"] = {
			0.49609375 / 2, -- [1]
			0.7421875 / 2, -- [2]
			0, -- [3]
			0.25 / 2, -- [4]
		},
		["MAGE"] = {
			0.25 / 2, -- [1]
			0.49609375 / 2, -- [2]
			0, -- [3]
			0.25 / 2, -- [4]
		},
		["PET"] = {
			0.25 / 2, -- [1]
			0.49609375 / 2, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["DRUID"] = {
			0.7421875 / 2, -- [1]
			0.98828125 / 2, -- [2]
			0, -- [3]
			0.25 / 2, -- [4]
		},
		["MONK"] = {
			0.5 / 2, -- [1]
			0.73828125 / 2, -- [2]
			0.5 / 2, -- [3]
			0.75 / 2, -- [4]
		},
		["DEATHKNIGHT"] = {
			0.25 / 2, -- [1]
			0.5 / 2, -- [2]
			0.5 / 2, -- [3]
			0.75 / 2, -- [4]
		},
		["UNKNOW"] = {
			0.5 / 2, -- [1]
			0.75 / 2, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["PRIEST"] = {
			0.49609375 / 2, -- [1]
			0.7421875 / 2, -- [2]
			0.25 / 2, -- [3]
			0.5 / 2, -- [4]
		},
		["UNGROUPPLAYER"] = {
			0.5 / 2, -- [1]
			0.75 / 2, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["Alliance"] = {
			0.49609375 / 2, -- [1]
			0.742187 / 25, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["WARLOCK"] = {
			0.7421875 / 2, -- [1]
			0.98828125 / 2, -- [2]
			0.25 / 2, -- [3]
			0.5 / 2, -- [4]
		},
		["ENEMY"] = {
			0, -- [1]
			0.25 / 2, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["Horde"] = {
			0.7421875 / 2, -- [1]
			0.98828125 / 2, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["PALADIN"] = {
			0, -- [1]
			0.25 / 2, -- [2]
			0.5 / 2, -- [3]
			0.75 / 2, -- [4]
		},
		["MONSTER"] = {
			0, -- [1]
			0.25 / 2, -- [2]
			0.75 / 2, -- [3]
			1 / 2, -- [4]
		},
		["SHAMAN"] = {
			0.25 / 2, -- [1]
			0.49609375 / 2, -- [2]
			0.25 / 2, -- [3]
			0.5 / 2, -- [4]
		},
		["EVOKER"] = {
			0.50390625, -- [1]
			0.625, -- [2]
			0, -- [3]
			0.125, -- [4]
		},
	}

	ElvUI_EltreumUI.DamageMeterIcons = {
		["Eltruism"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name,
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-eltruism",
		},
		["EltruismBars"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." Bars",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism_bars",
		},
		["EltruismBarsSolid"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." Bars Solid",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism_bars_solid",
		},
		["EltruismBarsSolidOutline"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." Bars Solid Outline",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism_bars_solid_outline",
		},
		["EltruismFlat"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." Flat",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-flat-wow",
		},
		["EltruismBW"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." B&W",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-eltruism-bw",
		},
		["EltruismUGG"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." UGG",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-ugg",
		},
		["EltruismUGGBW"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." UGG B&W",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-ugg-bw",
		},
		["EltruismSymbols"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." Symbols",
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism-symbols",
		},
		--[[["EltruismSpec"] = {
			["DisplayName"] = ElvUI_EltreumUI.Name.." Spec",
			["isSpec"] = true,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\spec_icons_eltruism",
		},]]
	}

	function ElvUI_EltreumUI:AddDamageMeterIconPack(name,DisplayName,isSpec,path)
		--name: what is going to show in the variables, avoid spaces
		--DisplayName: the name that shows in the options, can have spaces and fancy colors
		--isSpec: if its spec icons, set true, otherwise its class so false
		--path: the path to the file
		--example:
		--ElvUI_EltreumUI:AddDamageMeterIconPack("EltruismSpec","Very Fancy and Long name",true,"Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\spec_icons_eltruism")
		if ElvUI_EltreumUI.DamageMeterIcons[name] then return end --protect against adding it multiple times
		ElvUI_EltreumUI.DamageMeterIcons[name] = {
			["DisplayName"] = DisplayName,
			["isSpec"] = isSpec,
			["path"] = path,
		}
	end

	local function SetMouseOver(frame, mode)
		if not frame then return end
		if mode == "enter" then
			UIFrameFadeIn(frame, 0.5, 0, 1)
		elseif mode == "leave" then
			UIFrameFadeOut(frame, 0.5, 1, 0)
		end
	end

	local function OnWindowEnter(frame)
		SetMouseOver(frame.Header, "enter")
		SetMouseOver(frame.DamageMeterTypeDropdown, "enter")
		SetMouseOver(frame.SessionDropdown, "enter")
		SetMouseOver(frame.SettingsDropdown, "enter")
	end

	local function OnWindowLeave(frame)
		SetMouseOver(frame.Header, "leave")
		SetMouseOver(frame.DamageMeterTypeDropdown, "leave")
		SetMouseOver(frame.SessionDropdown, "leave")
		SetMouseOver(frame.SettingsDropdown, "leave")
	end

	local function HideBlizzardRegion(region)
		if not region then return end
		region:SetAlpha(0)
		if region:IsShown() then
			region:Hide()
		end
	end

	local function EnsureHiddenRegion(region)
		if not region then return end
		HideBlizzardRegion(region)
		if not hookedWidgets[region] then
			hooksecurefunc(region, "Show", HideBlizzardRegion)
			hookedWidgets[region] = true
		end
	end

	local function GetBarTexture()
		local texKey = E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.texture
		if cachedTextureKey ~= texKey or not cachedTexturePath then
			cachedTexturePath = E.LSM:Fetch("statusbar", texKey)
			cachedTextureKey = texKey
		end
		return cachedTexturePath
	end

	local function UpdateBarBackground(bar)
		if not bar then return end
		if bar.StatusBar then
			EnsureHiddenRegion(bar.StatusBar.Background)
			EnsureHiddenRegion(bar.StatusBar.BackgroundEdge)

			local bg = barBgTextures[bar.StatusBar]
			if not bg then
				bg = bar.StatusBar:CreateTexture(nil, "BACKGROUND", nil, -1)
				bg:SetAllPoints(bar.StatusBar)
				barBgTextures[bar.StatusBar] = bg
			end
			local tex = GetBarTexture()
			if tex then
				bg:SetTexture(tex)
			else
				bg:SetColorTexture(0, 0, 0, 1)
			end
			local bgFade = E.db.general.backdropfadecolor
			bg:SetVertexColor(0, 0, 0, (bgFade and bgFade.a) or 0.6)
		end
		if bar.Background then
			EnsureHiddenRegion(bar.Background)
		end
	end

	local function UpdateBarIcon(bar)
		if not bar or not bar.Icon or not bar.Icon.Icon then return end
		local skin = E.db.ElvUI_EltreumUI.skins.blizzdamagemeter
		local iconTexture = bar.Icon.Icon

		--let blizzard render native spec icons when iconSpec is enabled, or spell icons when spellID is set
		if skin.iconSpec or not skin.replaceIcon or (E:NotSecretValue(bar.spellID) and bar.spellID) then
			if hookedWidgets[iconTexture] then
				iconTexture:SetTexCoord(0.0625, 0.9, 0.0626, 0.9)
				hookedWidgets[iconTexture] = nil
			end
			return
		end

		if E:NotSecretValue(bar.classFilename) and bar.classFilename then --avoid spell stuff
			local textureCoords = class_coords[bar.classFilename]
			if textureCoords then
				local iconPackKey = skin.iconPack
				if cachedIconPackKey ~= iconPackKey or not cachedIconPackPath then
					local icons = ElvUI_EltreumUI.DamageMeterIcons
					local pack = icons[tostring(iconPackKey)]
					cachedIconPackPath = (pack and pack.path) or icons["Eltruism"].path
					cachedIconPackKey = iconPackKey
				end

				iconTexture:SetTexture(cachedIconPackPath)
				iconTexture:SetTexCoord(textureCoords[1], textureCoords[2], textureCoords[3], textureCoords[4])
				hookedWidgets[iconTexture] = true
			end
		end
	end

	local function UpdateBarName(bar)
		if not bar or not bar.StatusBar or not bar.StatusBar.Name then return end
		if not E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.gradientBar or ElvUI_EltreumUI:IsInInstance(true) then return end

		local nameFS = bar.StatusBar.Name
		local state = barState[bar]
		if not nameFS.GetText or (state and state.settingName) then return end

		local name = nameFS:GetText()
		if name and E:NotSecretValue(name) then
			if state and name == state.formattedName then return end
			if bar.classFilename and E:NotSecretValue(bar.classFilename) then
				local nameStripped = E:StripString(name)
				local formatted = E.Retail and ElvUI_EltreumUI:GradientName(ElvUI_EltreumUI:ShortenString(nameStripped, 12, true), bar.classFilename) or ElvUI_EltreumUI:GradientName(nameStripped, bar.classFilename)
				if formatted then
					if not state then
						state = {}
						barState[bar] = state
					end
					state.formattedName = formatted
					if formatted ~= name then
						state.settingName = true
						nameFS:SetText(formatted)
						state.settingName = false
					end
				end
			end
		end
	end

	local function OnNameSetText(nameFS)
		local bar = widgetOwner[nameFS]
		if not bar then return end
		local state = barState[bar]
		if state and state.settingName then return end
		UpdateBarName(bar)
	end

	local function ApplyBarGradient(bar, r, g, b)
		if not bar or not bar.StatusBar then return end
		if not E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.gradientBar or ElvUI_EltreumUI:IsInInstance(true) then return end

		local sbtexture = bar.StatusBar:GetStatusBarTexture()
		if not sbtexture then return end

		local gm = E.db.ElvUI_EltreumUI.unitframes.gradientmode
		local orientation = gm.orientation
		local classFilename = bar.classFilename
		if classFilename and E:NotSecretValue(classFilename) then
			if gm.customcolor then
				sbtexture:SetGradient(orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(classFilename))
			else
				sbtexture:SetGradient(orientation, ElvUI_EltreumUI:GradientColorsDetails(classFilename))
			end
			return
		end

		if not (r and g and b and E:NotSecretValue(r) and E:NotSecretValue(g) and E:NotSecretValue(b)) then
			r, g, b = bar.StatusBar:GetStatusBarColor()
		end
		if r and g and b and E:NotSecretValue(r) and E:NotSecretValue(g) and E:NotSecretValue(b) then
			dmMin:SetRGBA(E:Clamp(r - 0.5, 0, 1), E:Clamp(g - 0.5, 0, 1), E:Clamp(b - 0.5, 0, 1), 0.9)
			dmMax:SetRGBA(E:Clamp(r + 0.2, 0, 1), E:Clamp(g + 0.2, 0, 1), E:Clamp(b + 0.2, 0, 1), 0.9)
			sbtexture:SetGradient(orientation, dmMin, dmMax)
		elseif classFilename and GetClassColor then
			local classColor = GetClassColor(classFilename)
			if classColor then
				sbtexture:SetGradient(orientation, classColor, classColor)
			end
		end
	end

	--use shared callbacks instead of per-bar closures to keep memory/cpu low on scrollbox updates
	local function OnStatusBarVertexColor(sbtexture, r, g, b)
		local bar = widgetOwner[sbtexture]
		if not bar then return end
		ApplyBarGradient(bar, r, g, b)
		UpdateBarName(bar)
	end

	local function OnStatusBarColor(statusBar, r, g, b)
		local bar = widgetOwner[statusBar]
		if not bar then return end
		ApplyBarGradient(bar, r, g, b)
		UpdateBarName(bar)
	end

	local function EnsureVertexColorHook(bar)
		if not bar or not bar.StatusBar then return end
		local sbtexture = bar.StatusBar:GetStatusBarTexture()
		if sbtexture then
			widgetOwner[sbtexture] = bar
			if not hookedWidgets[sbtexture] then
				hooksecurefunc(sbtexture, "SetVertexColor", OnStatusBarVertexColor)
				hookedWidgets[sbtexture] = true
			end
		end
	end

	local function ApplyBarTexture(bar)
		if not bar or not bar.StatusBar or ElvUI_EltreumUI:IsInInstance(true) then return end
		local state = barState[bar]
		if state and state.settingTexture then return end
		local tex = GetBarTexture()
		if tex then
			if not state then
				state = {}
				barState[bar] = state
			end
			state.settingTexture = true
			bar.StatusBar:SetStatusBarTexture(tex)
			state.settingTexture = false
		end
	end

	local function OnStatusBarTexture(statusBar)
		local bar = widgetOwner[statusBar]
		if not bar then return end
		local state = barState[bar]
		if state and state.settingTexture then return end
		ApplyBarTexture(bar)
		EnsureVertexColorHook(bar)
		ApplyBarGradient(bar)
	end

	local barStyleMethods = {
		"SetupSharedStyleBackground",
		"UpdateBackground",
		"SetupDefaultStyle",
		"SetupThinStyle",
		"SetupBorderedStyle",
		"SetStyle",
		"UpdateStyle",
		"Init",
	}

	local function OnBarStyleOrInit(bar)
		if ElvUI_EltreumUI:IsInInstance(true) then return end
		UpdateBarBackground(bar)
		ApplyBarTexture(bar)
		EnsureVertexColorHook(bar)
		ApplyBarGradient(bar)
		UpdateBarName(bar)
	end

	local function SkinDamageMeter(bar)
		if ElvUI_EltreumUI:IsInInstance(true) then return end
		if not bar or not bar.StatusBar then return end

		local state = barState[bar]
		if not state then
			state = {}
			barState[bar] = state
		end

		local db = E.db.ElvUI_EltreumUI.skins.blizzdamagemeter
		widgetOwner[bar.StatusBar] = bar

		UpdateBarBackground(bar)

		if not state.styleHooks then
			for _, method in pairs(barStyleMethods) do
				if bar[method] then
					hooksecurefunc(bar, method, OnBarStyleOrInit)
				end
			end
			state.styleHooks = true
		end

		if db.replaceIcon then
			UpdateBarIcon(bar)
			if bar.UpdateIcon and not state.iconHook then
				hooksecurefunc(bar, "UpdateIcon", UpdateBarIcon)
				state.iconHook = true
			end
		end

		if not state.textureHook then
			ApplyBarTexture(bar)
			hooksecurefunc(bar.StatusBar, "SetStatusBarTexture", OnStatusBarTexture)
			state.textureHook = true
		end

		if db.shadows then
			if bar.SetClipsChildren then
				bar:SetClipsChildren(false)
			end
			if not bar.StatusBar.shadow then
				if ElvUI_EltreumUI.CreateFastShadow then
					ElvUI_EltreumUI:CreateFastShadow(bar.StatusBar, E:Scale(2))
				else
					bar.StatusBar:CreateShadow(2)
					ElvUI_EltreumUI:ShadowColor(bar.StatusBar.shadow)
				end
			end
		end

		if db.gradientBar then
			EnsureVertexColorHook(bar)

			if not state.gradientHook then
				--hook statusbar directly since SetStatusBarColor does not trigger SetVertexColor
				hooksecurefunc(bar.StatusBar, "SetStatusBarColor", OnStatusBarColor)

				if bar.UpdateName then
					hooksecurefunc(bar, "UpdateName", UpdateBarName)
				end

				if bar.StatusBar.Name and not hookedWidgets[bar.StatusBar.Name] then
					widgetOwner[bar.StatusBar.Name] = bar
					hooksecurefunc(bar.StatusBar.Name, "SetText", OnNameSetText)
					if bar.StatusBar.Name.SetFormattedText then
						hooksecurefunc(bar.StatusBar.Name, "SetFormattedText", OnNameSetText)
					end
					hookedWidgets[bar.StatusBar.Name] = true
				end

				state.gradientHook = true
			end

			ApplyBarGradient(bar)
			UpdateBarName(bar)
		end

		state.skinned = true
	end

	local function SkinDamageMeterWindow(window) --actual window
		if not window or hookedWidgets[window] then return end
		--start hidden
		if window.Header then
			UIFrameFadeOut(window.Header, 0, 1, 0)
		end
		if window.DamageMeterTypeDropdown then
			UIFrameFadeOut(window.DamageMeterTypeDropdown, 0, 1, 0)
		end
		if window.SessionDropdown then
			UIFrameFadeOut(window.SessionDropdown, 0, 1, 0)
		end
		if window.SettingsDropdown then
			UIFrameFadeOut(window.SettingsDropdown, 0, 1, 0)
		end

		window:SetScript("OnEnter", OnWindowEnter)
		window:SetScript("OnLeave", OnWindowLeave)
		hookedWidgets[window] = true
		--window.DamageMeterTypeDropdown.TypeName:SetParent(window)
		--window.DamageMeterTypeDropdown.TypeName:SetTextColor(1, 1, 1, 1)
		--window.DamageMeterTypeDropdown.TypeName:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	end

	local function SkinIfNeeded(frame)
		local state = barState[frame]
		if not state or not state.skinned then
			SkinDamageMeter(frame)
		end
	end

	local function OnScrollBoxUpdate(scrollBox)
		scrollBox:ForEachFrame(SkinIfNeeded)
	end

	local function ForEachWindowEntry(window, callback, hookScrollBox)
		if not window then return end
		local scrollBox = window.GetScrollBox and window:GetScrollBox()
		if scrollBox then
			scrollBox:ForEachFrame(callback)
			if hookScrollBox and not hookedWidgets[scrollBox] then
				hooksecurefunc(scrollBox, "Update", OnScrollBoxUpdate)
				hookedWidgets[scrollBox] = true
			end
		end
		if window.MinimizeContainer then
			if window.MinimizeContainer.LocalPlayerEntry then
				callback(window.MinimizeContainer.LocalPlayerEntry)
			end
			local sourceScrollBox = window.MinimizeContainer.SourceWindow and window.MinimizeContainer.SourceWindow.GetScrollBox and window.MinimizeContainer.SourceWindow:GetScrollBox()
			if sourceScrollBox then
				sourceScrollBox:ForEachFrame(callback)
				if hookScrollBox and not hookedWidgets[sourceScrollBox] then
					hooksecurefunc(sourceScrollBox, "Update", OnScrollBoxUpdate)
					hookedWidgets[sourceScrollBox] = true
				end
			end
		end
	end

	local function SkinSessionWindow(window)
		if not window then return end
		if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.mouseOverTop then
			SkinDamageMeterWindow(window)
		end
		ForEachWindowEntry(window, SkinDamageMeter, true)
	end

	local function OnSetupSessionWindow()
		_G.DamageMeter:ForEachSessionWindow(SkinSessionWindow)
	end

	local function RefreshWindowIcons(window)
		ForEachWindowEntry(window, UpdateBarIcon, false)
	end

	function ElvUI_EltreumUI:UpdateDamageMeterIcons()
		if not _G.DamageMeter then return end
		_G.DamageMeter:ForEachSessionWindow(RefreshWindowIcons)
	end

	local function SyncEmbedVisibility()
		if not embedpanel then return end
		if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhidden then
			embedpanel:Hide()
			_G["RightChatPanel"]:Show()
		else
			embedpanel:Show()
			_G["RightChatPanel"]:Hide()
		end
	end

	local function HideEmbedDelayed()
		if not embedpanel then return end
		embedpanel:Hide()
		_G["RightChatPanel"]:Show()
		E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhidden = true
	end

	local function SetupEmbedPanel()
		if not embedpanel then return end
		if InCombatLockdown() then
			embedpanel.needsSetup = true
			embedpanel:RegisterEvent("PLAYER_REGEN_ENABLED")
			return
		end

		embedpanel:SetAllPoints(_G["RightChatPanel"])
		embedpanel:SetParent(E.UIParent)
		embedpanel:SetFrameStrata("BACKGROUND")

		if not embedpanel.EltruismSkinned and (E.db["chat"]["panelBackdrop"] == "RIGHT" or E.db["chat"]["panelBackdrop"] == "SHOWBOTH") then
			S:HandleFrame(embedpanel, true, "Transparent")
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and not embedpanel.shadow then
				embedpanel:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(embedpanel.shadow)
			end
			embedpanel.EltruismSkinned = true
		end

		local numberOfWindows = (_G.DamageMeter and _G.DamageMeter:GetCurrentSessionWindowCount()) or 0 --setup for embed, and maybe refresh if that didnt throw errors

		for i = 1, numberOfWindows do
			if _G["DamageMeterSessionWindow"..i] then
				_G["DamageMeterSessionWindow"..i]:SetParent(embedpanel)
				_G["DamageMeter"]:SetParent(embedpanel)
			end
		end
		if _G["DamageMeterSessionWindow1"] then
			_G["DamageMeterSessionWindow1"]:ClearAllPoints()
			--_G["DamageMeterSessionWindow1"]:SetPoint("TOPLEFT", embedpanel, "TOPLEFT",0,-20)
			_G["DamageMeterSessionWindow1"]:SetAllPoints(embedpanel)
		end

		embedpanel.needsSetup = false
		SyncEmbedVisibility()
	end

	local function OnEmbedEvent(_, event)
		if event == "PLAYER_REGEN_DISABLED" then
			if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhideooc then
				embedpanel:Show()
				_G["RightChatPanel"]:Hide()
				E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhidden = false
			end
		elseif event == "PLAYER_REGEN_ENABLED" then
			if embedpanel.needsSetup then
				SetupEmbedPanel()
			end
			if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhideooc then
				E:Delay(E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedDelay, HideEmbedDelayed)
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			SyncEmbedVisibility()
		end
		if not E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhideooc and not embedpanel.needsSetup then
			embedpanel:UnregisterEvent("PLAYER_REGEN_ENABLED")
			embedpanel:UnregisterEvent("PLAYER_REGEN_DISABLED")
		end
	end

	local function OnRightChatClick(_, button)
		if button == 'RightButton' then
			if embedpanel:IsShown() then
				embedpanel:Hide()
				_G["RightChatPanel"]:Show()
				E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhidden = true
			else
				embedpanel:Show()
				_G["RightChatPanel"]:Hide()
				E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhidden = false
			end
		end
	end

	local function OnRightChatEnter()
		_G.GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Damage Meter"], 1, 1, 1)
		_G.GameTooltip:Show()
	end

	local function FixMissingChatToggle()
		if not _G.RightChatToggleButton:IsShown() then --fix when no chat toggle exists
			E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhidden = false
		end
	end

	--skin blizzard's dps meter to be similar to my details skin
	function ElvUI_EltreumUI:BlizzDamageMeter()
		if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.enable then
			if not ElvUI_EltreumUI:IsInInstance(true) then

				--prep for the meter
				SetCVar("damageMeterEnabled", 1) --no point in skinnig it if the meter is not enabled

				if _G.DamageMeter and not hookedWidgets[_G.DamageMeter] then

					--acidweb's fix
					_G.DamageMeter:SetClampedToScreen(false)
					_G.DamageMeter:SetClampRectInsets(-2000, -2000, -2000, -2000)
					if _G.DamageMeterSessionWindow1 then
						_G.DamageMeterSessionWindow1:SetClampedToScreen(false)
						_G.DamageMeterSessionWindow1:SetClampRectInsets(-2000, -2000, -2000, -2000)
					end

					--skins change requires checking the table, then using that to actually skin like before
					local ElvUIDamageMeterData = S.addonStorage and S.addonStorage.Blizzard_DamageMeter and S.addonStorage.Blizzard_DamageMeter.data
					if ElvUIDamageMeterData and ElvUIDamageMeterData.HandleStatusBar and not hookedWidgets[ElvUIDamageMeterData] then
						hooksecurefunc(ElvUIDamageMeterData, "HandleStatusBar", SkinDamageMeter)
						hookedWidgets[ElvUIDamageMeterData] = true
					end

					hooksecurefunc(_G.DamageMeter, 'SetupSessionWindow', OnSetupSessionWindow)

					--use blizz function to skin
					_G.DamageMeter:ForEachSessionWindow(SkinSessionWindow)
					hookedWidgets[_G.DamageMeter] = true

					--if no refresh then turns out the specicons are nil because it seems they are loaded later
					--because of blizzard being blizzard we need to run the refresh more than once as it turns out
					--[[E:Delay(1, function()
						_G.DamageMeter:RefreshLayout()
					end)
					_G.DamageMeter:RefreshLayout()]]

					--different refresh
					--[[for i = 1, numberOfWindows do
						if _G["DamageMeterSessionWindow"..i] then
							_G["DamageMeterSessionWindow"..i]:Refresh()
						end
					end]]
				end

				if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embed and E.private.chat.enable and not IsAddOnLoaded("Details") then
					if not _G["EltruismDamageMeterEmbedPanel"] then
						embedpanel = CreateFrame("FRAME", "EltruismDamageMeterEmbedPanel")
					else
						embedpanel = _G["EltruismDamageMeterEmbedPanel"]
					end

					SetupEmbedPanel()

					if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.embedhideooc then
						embedpanel:RegisterEvent("PLAYER_REGEN_ENABLED")
						embedpanel:RegisterEvent("PLAYER_REGEN_DISABLED")
					end
					embedpanel:RegisterEvent("PLAYER_ENTERING_WORLD")

					--now cause a problem since its delayed
					E:Delay(10, FixMissingChatToggle)

					embedpanel:SetScript("OnEvent", OnEmbedEvent)

					if not RightChatDamageMeterHook then
						_G.RightChatToggleButton:HookScript("OnClick", OnRightChatClick)
						_G.RightChatToggleButton:HookScript('OnEnter', OnRightChatEnter)

						RightChatDamageMeterHook = true
					end
				end
			end
		end
	end
	S:AddCallbackForAddon('Blizzard_DamageMeter', "EltruismBlizzDamageMeter", ElvUI_EltreumUI.BlizzDamageMeter)
end
