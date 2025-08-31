local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local pairs = _G.pairs
local hooksecurefunc = _G.hooksecurefunc
local valuecolors = E:ClassColor(E.myclass, true)

--skin simple addon manager
function ElvUI_EltreumUI:EltruismSAM()
	if E.db.ElvUI_EltreumUI.skins.sam then
		S:HandleFrame(_G["SimpleAddonManager"]) --although it exists since the start apparently it fires again in the hook
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			if not _G["SimpleAddonManager"].shadow then
				_G["SimpleAddonManager"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				ElvUI_EltreumUI:ShadowColor(_G["SimpleAddonManager"].shadow)
			end
		end
		--S:HandleButton(_G["SimpleAddonManager"].SetsButton) --errors due to not existing
		--S:HandleButton(_G["SimpleAddonManager"].ConfigButton) --errors due to not existing

		--sam apparently delays everything so hook the function
		hooksecurefunc(_G.SimpleAddonManager, "Initialize", function(frame) --frame will be the _G["SimpleAddonManager"] again
			if frame.CharacterDropDown then --needs tweaks
				S:HandleDropDownBox(frame.CharacterDropDown, nil, "Transparent")
				frame.CharacterDropDown:SetWidth(150) --if it set height on the HandleDropDownBox the frame moves around
				frame.CharacterDropDown:SetHeight(25)
				frame.CharacterDropDown.SetHeight = E.noop --it attempts to change height again
			end
			S:HandleButton(frame.SetsButton)
			S:HandleEditBox(frame.SearchBox)
			S:HandleScrollBar(frame.AddonListFrame.ScrollFrame.ScrollBar)
			S:HandleButton(frame.ConfigButton)
			S:HandleButton(frame.CategoryButton)
			S:HandleButton(frame.CategoryFrame.NewButton)
			S:HandleButton(frame.CategoryFrame.SelectAllButton)
			S:HandleButton(frame.CategoryFrame.ClearSelectionButton)
			S:HandleScrollBar(frame.CategoryFrame.ScrollFrame.ScrollBar)
			S:HandleButton(frame.CancelButton)
			S:HandleButton(frame.OkButton)
			S:HandleButton(frame.DisableAllButton)
			S:HandleButton(frame.EnableAllButton)
			S:HandleNextPrevButton(frame.ResultOptionsButton, "down")
		end)

		--from elvui
		hooksecurefunc('HybridScrollFrame_CreateButtons', function(frame, template)
			if template == "SimpleAddonManagerAddonItem" then --actual addon list
				for _, category in pairs(frame.buttons) do
					if not category.IsSkinned then
						S:HandleCheckBox(category.EnabledButton)
						S:HandleCollapseTexture(category.ExpandOrCollapseButton, nil, true) --not sure if its working or is my glues
						category.HighlightTexture:SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\NormTex2")
						category.HighlightTexture:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 0.3)
						category.IsSkinned = true
					end
				end
			elseif template == "SimpleAddonManagerCategoryItem" then --category stuff
				for _, category in pairs(frame.buttons) do
					if not category.IsSkinned then
						S:HandleCheckBox(category.EnabledButton)
						category.HighlightTexture:SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\NormTex2")
						category.HighlightTexture:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 0.3)
						category.IsSkinned = true
					end
				end
			end
		end)

		--the dropdown/tooltip is not made at the start, and there can be many
		--S:HandleDropDownBox(_G.ElioteDDM_DropDownList1)
		local SAMDropdown = _G.LibStub("ElioteDropDownMenu-1.0")
		if SAMDropdown then
			hooksecurefunc(SAMDropdown, "UIDropDownMenu_CreateFrames", function(level)
				if _G["ElioteDDM_DropDownList"..level] and not _G["ElioteDDM_DropDownList"..level].IsSkinned then
					--S:HandleFrame(_G["ElioteDDM_DropDownList"..level]) --doesnt work
					--S:HandleDropDownBox(_G["ElioteDDM_DropDownList"..level.."Backdrop"]) --doesnt work
					--S:HandleDropDownBox(_G["ElioteDDM_DropDownList"..level.."MenuBackdrop"]) --works, but not transparent
					S:HandleFrame(_G["ElioteDDM_DropDownList"..level.."MenuBackdrop"]) --works
					S:HandleFrame(_G["ElioteDDM_DropDownList"..level.."Backdrop"]) --works too
					if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
						if not _G["ElioteDDM_DropDownList"..level].shadow then
							_G["ElioteDDM_DropDownList"..level]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(_G["ElioteDDM_DropDownList"..level].shadow)
						end
					end
					_G["ElioteDDM_DropDownList"..level].IsSkinned = true
				end
			end)
		end
	end
end
S:AddCallbackForAddon('SimpleAddonManager', "EltruismSAM", ElvUI_EltreumUI.EltruismSAM)
