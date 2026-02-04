local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local tostring = _G.tostring

--pretty much copied from elvui and edited to look more like details
do

	local BlizzardTextureIDsForSpecs = {
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
		["7455385"] = 1480,
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
	}
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
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-eltruism",
		},
		["Eltruism Bars"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism_bars",
		},
		["Eltruism Bars Solid"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism_bars_solid",
		},
		["Eltruism Bars Solid Outline"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism_bars_solid_outline",
		},
		["Eltruism Flat"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-flat-wow",
		},
		["Eltruism B&W"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-eltruism-bw",
		},
		["Eltruism UGG"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-ugg",
		},
		["Eltruism UGG B&W"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\details-ugg-bw",
		},
		["Eltruism Symbols"] = {
			["isSpec"] = false,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\eltruism-symbols",
		},
		["Eltruism Spec"] = {
			["isSpec"] = true,
			["path"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\spec_icons_eltruism",
		},
	}

	function ElvUI_EltreumUI:AddDamageMeterIconPack(name,isSpec,path)
		--name: what is going to show on the options
		--isSpec: if its spec icons, set true, otherwise its class so false
		--path: the path to the file
		--exammple:
		--ElvUI_EltreumUI:AddDamageMeterIconPack("Eltruism Spec",true,"Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Details\\spec_icons_eltruism")
		if ElvUI_EltreumUI.DamageMeterIcons[name] then return end --protect against adding it multiple times
		ElvUI_EltreumUI.DamageMeterIcons[name] = {
			["isSpec"] = isSpec,
			["path"] = path,
		}
	end


	local function SkinDamageMeterWindow(window) --actual window
		if not window then return end
		--print(window.Icon,window.StatusBar,window.updateLock,window.useClassColor)
		--[[local ScrollBar = window.GetScrollBar and window:GetScrollBar()
		if ScrollBar then
			S:HandleTrimScrollBar(ScrollBar)
		end]]
		--[[local ScrollBox = window.GetScrollBox and window:GetScrollBox()
		if ScrollBox and not ScrollBox.IsSkinned then
			hooksecurefunc(ScrollBox, 'Update', function()
				ScrollBox:ForEachFrame(SkinDamageMeterStatusBars)
			end)
			ScrollBox.IsSkinned = true
		end]]
	end

	local function SkinDamageMeter(bar)
		if not bar then return end
		if not bar.StatusBar then return end
		if bar.UpdateIcon and not bar.UpdateIconEltruismHook then
			hooksecurefunc(bar, "UpdateIcon", function(bar2)
				if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.iconSpec then
					if bar2.specIconID and BlizzardTextureIDsForSpecs[tostring(bar2.specIconID)] then
						local textureCoords = class_specs_coords[BlizzardTextureIDsForSpecs[tostring(bar2.specIconID)]]
						bar2.Icon.Icon:SetTexture(ElvUI_EltreumUI.DamageMeterIcons["Eltruism Spec"]["path"])
						bar2.Icon.Icon:SetTexCoord(textureCoords[1],textureCoords[2],textureCoords[3],textureCoords[4])
					end
				else
					local textureCoords = class_coords[bar.classFilename]
					bar2.Icon.Icon:SetTexture(ElvUI_EltreumUI.DamageMeterIcons["Eltruism"]["path"])
					bar2.Icon.Icon:SetTexCoord(textureCoords[1],textureCoords[2],textureCoords[3],textureCoords[4])
				end
			end)
			bar.UpdateIconEltruismHook = true
		end
		if not bar.GradientStatusBarEltruismHook then
			--turns out the details hook was indeed useful later (years later) but i need to get the texture first
			bar.StatusBar:SetStatusBarTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.texture))
			local sbtexture = bar.StatusBar:GetStatusBarTexture()
			if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.shadows and not bar.StatusBar.shadow then
				bar.StatusBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(bar.StatusBar.shadow)
			end
			hooksecurefunc(sbtexture, "SetVertexColor", function(_, r, g, b)
				if bar.classFilename then
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						sbtexture:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(bar.classFilename))
					else
						sbtexture:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetails(bar.classFilename))
					end
				else
					sbtexture:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.5,g= g-0.5,b= b-0.5,a= 0.9}, {r=r+0.2,g= g+0.2,b= b+0.2,a= 0.9})
				end
				--even though its supposed to not be secret we will get the secret error
				--[[if bar.StatusBar.Name then
					local name = E:StripString(bar.StatusBar.Name:GetText())
					bar.StatusBar.Name:SetText(ElvUI_EltreumUI:GradientName(ElvUI_EltreumUI:ShortenString(name, 12, true), bar.classFilename))
				end]]
			end)
			bar.GradientStatusBarEltruismHook = true
		end
	end

	--skin blizzard's dps meter to be similar to my details skin
	function ElvUI_EltreumUI:BlizzDamageMeter()
		if E.db.ElvUI_EltreumUI.skins.blizzdamagemeter.enable then
			if _G.DamageMeter and not _G.DamageMeter.EltruismHook then
				hooksecurefunc(S, "DamageMeter_HandleStatusBar", SkinDamageMeter)

				hooksecurefunc(_G.DamageMeter, 'SetupSessionWindow', function()
					_G.DamageMeter:ForEachSessionWindow(SkinDamageMeterWindow)
				end)
				_G.DamageMeter:ForEachSessionWindow(SkinDamageMeterWindow)

				_G.DamageMeter.EltruismHook = true

				--if no refresh then turns out the specicons are nil because it seems they are loaded later
				--because of blizzard being blizzard we need to run the refresh more than once as it turns out
				E:Delay(1, function()
					_G.DamageMeter:RefreshLayout()
				end)
				_G.DamageMeter:RefreshLayout()
			end
		end
	end
	S:AddCallbackForAddon('Blizzard_DamageMeter', "EltruismBlizzDamageMeter", ElvUI_EltreumUI.BlizzDamageMeter)

end
