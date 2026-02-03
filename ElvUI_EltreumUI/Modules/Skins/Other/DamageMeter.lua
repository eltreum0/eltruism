local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

--pretty much copied from elvui and edited to look more like details
do

	--GetSpecializationInfo(1)

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
	}




	local function SkinDamageMeter(window)
		if not window then return end
		--[[local ScrollBar = window.GetScrollBar and window:GetScrollBar()
		if ScrollBar then
			S:HandleTrimScrollBar(ScrollBar)
		end
		local ScrollBox = window.GetScrollBox and window:GetScrollBox()
		if ScrollBox and not ScrollBox.IsSkinned then
			hooksecurefunc(ScrollBox, 'Update', S.DamageMeter_HandleScrollBox)

			S.DamageMeter_HandleScrollBox(ScrollBox)

			ScrollBox.IsSkinned = true
		end]]

		--if not bar.StatusBar then return end
		print(window,'1')
	end

	--skin blizzard's dps meter to be similar to my details skin
	function ElvUI_EltreumUI:BlizzDamageMeter()
		if _G.DamageMeter and not _G.DamageMeter.EltruismHook then
			hooksecurefunc(S, "DamageMeter_HandleStatusBar", function(bar)
				if not bar then return end
				if not bar.StatusBar then return end
				print(bar,"2")

				if bar.UpdateIcon and not bar.UpdateIconEltruismHook then
					hooksecurefunc(bar, "UpdateIcon", function(bar2)
						if not bar2.Icon or not bar2.Icon.Icon then return end
						print(bar2,bar2.Icon,bar2.Icon.Icon)
						--there is a bar2.specIconID, but its using texture ids, would need to look up each spec texture
						--perhaps add options to customize icons, if map the textures to specs
					end)
					bar.UpdateIconEltruismHook = true
				end
				--bar.StatusBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsDetailsCustom(bar.classFilename))
			end)

			hooksecurefunc(_G.DamageMeter, 'SetupSessionWindow', function()
				_G.DamageMeter:ForEachSessionWindow(SkinDamageMeter)
			end)
			_G.DamageMeter:ForEachSessionWindow(SkinDamageMeter)

			_G.DamageMeter.EltruismHook = true
		end

	end
	S:AddCallbackForAddon('Blizzard_DamageMeter', "EltruismBlizzDamageMeter", ElvUI_EltreumUI.BlizzDamageMeter)

end
