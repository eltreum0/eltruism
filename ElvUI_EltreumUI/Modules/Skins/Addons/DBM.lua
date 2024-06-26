local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G

--dbm skin, made to look similar to bigwigs
function ElvUI_EltreumUI:DBMSkin()
	if E.db.ElvUI_EltreumUI.skins.dbm then
		if not _G.DBT then return end
		hooksecurefunc(_G.DBT, 'CreateBar', function(bars) --line 248
			for bar in bars:GetBarIterator() do --line 560, returns pairs(self.bars)
				if not bar.EltruismSkin then
					hooksecurefunc(bar, "ApplyStyle", function() --line 927
						local statusbar = _G[bar.frame:GetName()..'Bar']
						local icon = _G[bar.frame:GetName()..'BarIcon1']
						local spark = _G[bar.frame:GetName().."BarSpark"]
						spark:Hide()

						bar.frame:SetHeight(15) --same as bigwigs
						bar.frame:SetTemplate("Transparent")
						statusbar:SetOutside(bar.frame)

						icon:SetSize(22.5,22.5) --(bar.frame:GetHeight()*1.5, bar.frame:GetHeight()*1.5)
						icon:SetTexCoord(0.08,0.92,0.08,0.92)
						icon:ClearAllPoints()
						icon:SetPoint("BOTTOMRIGHT", bar.frame, "BOTTOMLEFT", E.PixelMode and -5 or -10, 0)

						--shadows
						if E.db.ElvUI_EltreumUI.skins.shadow then
							if not bar.frame.shadow then
								bar.frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(bar.frame.shadow)
							end
							if icon:IsShown() and not statusbar.shadow then
								statusbar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(statusbar.shadow)
								statusbar.shadow:ClearAllPoints()
								statusbar.shadow:SetPoint("BOTTOMLEFT", icon,"BOTTOMLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								statusbar.shadow:SetPoint("TOPLEFT", icon,"TOPLEFT", -E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
								statusbar.shadow:SetPoint("BOTTOMRIGHT", icon,"BOTTOMRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, -E.db.ElvUI_EltreumUI.skins.shadow.length)
								statusbar.shadow:SetPoint("TOPRIGHT", icon,"TOPRIGHT", E.db.ElvUI_EltreumUI.skins.shadow.length, E.db.ElvUI_EltreumUI.skins.shadow.length)
							end
						end
						--gradient is very memory intensive in this case due to how colors are set by dbm, changing all the time
						--[[if not statusbar.EltruismHook then
							hooksecurefunc(statusbar,"SetStatusBarColor",function(_,r,g,b)
								if not (r or g or b) then return end
								if E.Retail or E.Cata then
									statusbar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.5,g= g-0.5,b= b-0.5,a= 0.9}, {r=r+0.2,g= g+0.2,b= b+0.2,a= 0.9})
								else
									statusbar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.5, g-0.5, b-0.5, 0.9, r+0.2, g+0.2, b+0.2, 0.9)
								end
								statusbar.EltruismHook=true
							end)
						end]]
						bar.EltruismSkin = true
					end)
					bar:ApplyStyle()
				end
			end
		end)
	end
end
S:AddCallbackForAddon('DBM-StatusBarTimers', "EltruismDBM", ElvUI_EltreumUI.DBMSkin)

local function SkinGUI()
	--this is likely not a good idea...
	for i=1,2000 do
		if _G["DBM_GUI_Option_"..i] and not _G["DBM_GUI_Option_"..i].EltruismSkin then
			if _G["DBM_GUI_Option_"..i]:GetObjectType() == "Button" then
				S:HandleButton(_G["DBM_GUI_Option_"..i])
			elseif _G["DBM_GUI_Option_"..i]:GetObjectType() == "EditBox" then
				S:HandleEditBox(_G["DBM_GUI_Option_"..i])
			elseif _G["DBM_GUI_Option_"..i]:GetObjectType() == "Slider" then
				S:HandleSliderFrame(_G["DBM_GUI_Option_"..i])
			elseif _G["DBM_GUI_Option_"..i]:GetObjectType() == "CheckButton" then
				S:HandleCheckBox(_G["DBM_GUI_Option_"..i])
			end
			_G["DBM_GUI_Option_"..i].EltruismSkin = true
		end
		if _G["DBM_GUI_DropDown"..i] and not _G["DBM_GUI_DropDown"..i].EltruismSkin then
			local width = _G["DBM_GUI_DropDown"..i]:GetWidth()
			S:HandleDropDownBox(_G["DBM_GUI_DropDown"..i], width, true)
			if _G["DBM_GUI_DropDown"..i.."Text"] then
				_G["DBM_GUI_DropDown"..i.."Text"]:ClearAllPoints()
				_G["DBM_GUI_DropDown"..i.."Text"]:SetPoint("CENTER", _G["DBM_GUI_DropDown"..i].backdrop, "CENTER", 0,0)
			end
			_G["DBM_GUI_DropDown"..i].EltruismSkin = true
		end
	end
end

--dbm gui
function ElvUI_EltreumUI:DBMGUISkin()
	if E.db.ElvUI_EltreumUI.skins.dbm then
		if not _G.DBM_GUI then return end
		hooksecurefunc(_G.DBM_GUI, "ShowHide", function()
			if _G["DBM_GUI_OptionsFrame"]:IsShown() then
				SkinGUI()
				if _G["DBM_GUI_OptionsFrame"] and not _G["DBM_GUI_OptionsFrame"].EltruismSkin then
					S:HandleFrame(_G["DBM_GUI_OptionsFrame"])
					if E.db.ElvUI_EltreumUI.skins.shadow then
						if not _G["DBM_GUI_OptionsFrame"].shadow then
							_G["DBM_GUI_OptionsFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["DBM_GUI_OptionsFrame"].shadow)
						end
					end
					_G["DBM_GUI_OptionsFrame"].EltruismSkin = true
				end
				if _G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"] and not _G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"].EltruismSkin then
					S:HandleScrollBar(_G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"])
					_G["DBM_GUI_OptionsFramePanelContainerFOVScrollBar"].EltruismSkin = true
				end
				if _G["DBM_GUI_OptionsFrameTab1"] and not _G["DBM_GUI_OptionsFrameTab1"].EltruismSkin then
					S:HandleTab(_G["DBM_GUI_OptionsFrameTab1"])
					if _G["DBM_GUI_OptionsFrameTab1"].Text then
						_G["DBM_GUI_OptionsFrameTab1"].Text:ClearAllPoints()
						_G["DBM_GUI_OptionsFrameTab1"].Text:SetPoint("CENTER", _G["DBM_GUI_OptionsFrameTab1"])
					end
					_G["DBM_GUI_OptionsFrameTab1"].EltruismSkin = true
				end
				if _G["DBM_GUI_OptionsFrameTab2"] and not _G["DBM_GUI_OptionsFrameTab2"].EltruismSkin then
					S:HandleTab(_G["DBM_GUI_OptionsFrameTab2"])
					if _G["DBM_GUI_OptionsFrameTab2"].Text then
						_G["DBM_GUI_OptionsFrameTab2"].Text:ClearAllPoints()
						_G["DBM_GUI_OptionsFrameTab2"].Text:SetPoint("CENTER", _G["DBM_GUI_OptionsFrameTab2"])
					end
					_G["DBM_GUI_OptionsFrameTab2"].EltruismSkin = true
				end
				if _G["DBM_GUI_OptionsFrameWebsiteButton"] and not _G["DBM_GUI_OptionsFrameWebsiteButton"].EltruismSkin then
					S:HandleButton(_G["DBM_GUI_OptionsFrameWebsiteButton"])
					_G["DBM_GUI_OptionsFrameWebsiteButton"].EltruismSkin = true
				end
				if _G["DBM_GUI_OptionsFrameOkay"] and not _G["DBM_GUI_OptionsFrameOkay"].EltruismSkin then
					S:HandleButton(_G["DBM_GUI_OptionsFrameOkay"])
					_G["DBM_GUI_OptionsFrameOkay"].EltruismSkin = true
				end
				if _G["DBM_GUI_DropDown"] and not _G["DBM_GUI_DropDown"].EltruismSkin then
					S:HandleFrame(_G["DBM_GUI_DropDown"])
					_G["DBM_GUI_DropDown"].EltruismSkin = true
				end
			end
		end)
		hooksecurefunc(_G.DBM_GUI, "UpdateModList", function()
			E:Delay(1, function()
				SkinGUI()
			end)
		end)
	end
end
S:AddCallbackForAddon('DBM-GUI', "EltruismDBMGUI", ElvUI_EltreumUI.DBMGUISkin)
