local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local pairs = _G.pairs

--skin WarpDeplete
function ElvUI_EltreumUI:EltruismWarpDeplete()
	if E.db.ElvUI_EltreumUI.skins.warpdeplete then
		local WarpDeplete = E.Libs.AceAddon:GetAddon("WarpDeplete")

		--like bugsack the frame is not generated on load
		if not _G["WarpDepleteFrame"].isHooked then
			hooksecurefunc(WarpDeplete, 'Show', function()
				if not _G["WarpDepleteFrame"].isSkinned then
					for _, v in pairs{_G["WarpDepleteBars"]:GetChildren()} do
						--print(v:GetObjectType())
						for _, j in pairs{v:GetChildren()} do
							if j:IsObjectType('StatusBar') then
								local r1,g1,b1 = j:GetStatusBarColor()
								j:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r1 - 0.4,g= g1 - 0.4,b= b1 - 0.4,a= E.db.general.backdropfadecolor.a}, {r=r1 + 0.2,g= g1 + 0.2,b= b1 + 0.2,a= E.db.general.backdropfadecolor.a})
								if not j.EltruismHook then --hook so it updates later
									hooksecurefunc(j,"SetStatusBarColor", function(_,r,g,b)
										j:GetStatusBarTexture():SetGradient("HORIZONTAL", {r=r - 0.4,g= g - 0.4,b= b - 0.4,a= E.db.general.backdropfadecolor.a}, {r=r + 0.2,g= g + 0.2,b= b + 0.2,a= E.db.general.backdropfadecolor.a})
									end)
									j.EltruismHook = true
								end
							end
						end

						--v:CreateBackdrop('Transparent')
						if E.db.ElvUI_EltreumUI.skins.shadow.enable then
							if v and not v.shadow then
								v:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								v.shadow:ClearAllPoints()
								v.shadow:SetPoint("TOPLEFT", v, "TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length+1, E.db.ElvUI_EltreumUI.skins.shadow.length-1)
								v.shadow:SetPoint("BOTTOMRIGHT", v, "BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length-1, -E.db.ElvUI_EltreumUI.skins.shadow.length+1)
								ElvUI_EltreumUI:ShadowColor(v.shadow)
							end
						end
					end
					_G["WarpDepleteFrame"].isSkinned = true
				end
			end)
			_G["WarpDepleteFrame"].isHooked = true
		end
	end
end
S:AddCallbackForAddon('WarpDeplete', "EltruismWarpDeplete", ElvUI_EltreumUI.EltruismWarpDeplete)
