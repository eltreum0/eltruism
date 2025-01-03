local E = unpack(ElvUI)
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local hooksecurefunc = _G.hooksecurefunc
local UIFrameFadeIn = _G.UIFrameFadeIn
local math = _G.math
local type = _G.type
local ipairs  = _G.ipairs
local valuecolors = E:ClassColor(E.myclass, true)
local S = E:GetModule('Skins')

local function CreateFader(frame,isTree)
	if not E.private.ElvUI_EltreumUI then return end
	if not E.private.ElvUI_EltreumUI.install_version then return end
	if not E.db.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI.skins then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3 then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.button then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.tab then return end
	ElvUI_EltreumUI:OriginalClassColors() --early so color is correct

	if not frame.EltruismAnimation then
		frame.EltruismAnimation = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
		frame.EltruismAnimation:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.ace3.texture))
		if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
			frame.EltruismAnimation:SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r or 0.07, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g or 0.30, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b or 0.50, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a or 1)
		else
			frame.EltruismAnimation:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b,E.db.general.backdropfadecolor.a)
		end
		if frame.backdrop then
			frame.EltruismAnimation:SetInside(frame.backdrop)
		else
			frame.EltruismAnimation:SetInside(frame)
		end
		frame.EltruismAnimation:SetBlendMode("BLEND")
		frame.EltruismAnimation:SetAlpha(0)

		local backupR,backupG,backupB = 1,1,1

		frame:HookScript("OnEnter", function()
			if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
			if not frame.highlight then
				UIFrameFadeIn(frame.EltruismAnimation, E.db.ElvUI_EltreumUI.skins.ace3.fadetime, 0, 1)
			end
			if frame.SetBackdropBorderColor then
				frame:SetBackdropBorderColor(0, 0, 0, 1)
			end
			local frametext = (frame.Text) or (frame.text) or (_G[frame:GetName()] and _G[frame:GetName() .. "Text"]) --using frame.Text.GetText would return the function instead
			if frametext and frametext.GetText and not frame.disabled and not (frame.GetButtonState and frame:GetButtonState() == "DISABLED") then
				backupR,backupG,backupB = frametext:GetTextColor()
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
					frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
				else
					frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
		end)

		frame:HookScript("OnShow", function()
			if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
			local frametext = (frame.Text) or (frame.text) or (_G[frame:GetName()] and _G[frame:GetName() .. "Text"]) --using frame.Text.GetText would return the function instead
			if frametext and frametext.GetText then
				E:Delay(0,function() --the disable is delayed so delay running to run after it
					if frame.selected then
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
							frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
						else
							frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					elseif frame.disabled or (frame.GetButtonState and frame:GetButtonState() == "DISABLED") then
						frametext:SetTextColor(0.5,0.5,0.5)
					else
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end
				end)
			end
		end)

		frame:HookScript("OnEnable", function()
			if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
			local frametext = (frame.Text) or (frame.text) or (_G[frame:GetName()] and _G[frame:GetName() .. "Text"]) --using frame.Text.GetText would return the function instead
			if frametext and frametext.GetText then
				if frame.selected then
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
						frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
					else
						frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				elseif frame.disabled or (frame.GetButtonState and frame:GetButtonState() == "DISABLED") then
					frametext:SetTextColor(0.5,0.5,0.5)
				else
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end
		end)

		frame:HookScript("OnClick", function()
			if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
			local frametext = (frame.Text) or (frame.text) or (_G[frame:GetName()] and _G[frame:GetName() .. "Text"]) --using frame.Text.GetText would return the function instead
			if frametext and frametext.GetText then
				if frame.selected then
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
						frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
					else
						frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				elseif frame.disabled or (frame.GetButtonState and frame:GetButtonState() == "DISABLED") then
					frametext:SetTextColor(0.5,0.5,0.5)
				else
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end
		end)

		frame:HookScript("OnDisable", function()
			if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
			local frametext = (frame.Text) or (frame.text) or (_G[frame:GetName()] and _G[frame:GetName() .. "Text"]) --using frame.Text.GetText would return the function instead
			if frametext and frametext.GetText then
				if frame.selected then
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
						frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
					else
						frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				elseif frame.disabled or (frame.GetButtonState and frame:GetButtonState() == "DISABLED") then
					frametext:SetTextColor(0.5,0.5,0.5)
				else
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end
		end)

		frame:HookScript("OnLeave", function()
			if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
			if isTree then
				if not frame.selected then
					UIFrameFadeOut(frame.EltruismAnimation, E.db.ElvUI_EltreumUI.skins.ace3.fadetime, 1, 0)
				end
			else
				UIFrameFadeOut(frame.EltruismAnimation, E.db.ElvUI_EltreumUI.skins.ace3.fadetime, 1, 0)
			end
			local frametext = (frame.Text) or (frame.text) or (_G[frame:GetName()] and _G[frame:GetName() .. "Text"]) --using frame.Text.GetText would return the function instead
			if frametext and frametext.GetText and not frame.disabled and not (frame.GetButtonState and frame:GetButtonState() == "DISABLED") then
				frametext:SetTextColor(backupR,backupG,backupB)
			end
		end)
	end
end

function ElvUI_EltreumUI:Ace3Skin()
	if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end

	if _G.PluginInstallFrame then --add fader to install frames, but will only work when not using eltruism installer due to the image previews
		if _G.PluginInstallOption1Button then CreateFader(_G.PluginInstallOption1Button) end
		if _G.PluginInstallOption2Button then CreateFader(_G.PluginInstallOption2Button) end
		if _G.PluginInstallOption3Button then CreateFader(_G.PluginInstallOption3Button) end
		if _G.PluginInstallOption4Button then CreateFader(_G.PluginInstallOption4Button) end
	end

	if _G.LFDQueueFrameTypeDropDownName then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.LFDQueueFrameTypeDropDownName:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.LFDQueueFrameTypeDropDownName:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	if _G.LFDQueueFrameRandomScrollFrameChildFrameTitle then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.LFDQueueFrameRandomScrollFrameChildFrameTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.LFDQueueFrameRandomScrollFrameChildFrameTitle:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	if _G.LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.LFDQueueFrameRandomScrollFrameChildFrameRewardsLabel:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	if _G.LFDQueueFrameFollowerTitle then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.LFDQueueFrameFollowerTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.LFDQueueFrameFollowerTitle:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	if _G.RaidFinderQueueFrameSelectionDropDownName then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.RaidFinderQueueFrameSelectionDropDownName:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.RaidFinderQueueFrameSelectionDropDownName:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	if _G.RaidFinderQueueFrameScrollFrameChildFrameTitle then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.RaidFinderQueueFrameScrollFrameChildFrameTitle:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.RaidFinderQueueFrameScrollFrameChildFrameTitle:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	if _G.RaidFinderQueueFrameScrollFrameChildFrameRewardsLabel then
		if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
			_G.RaidFinderQueueFrameScrollFrameChildFrameRewardsLabel:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
		else
			_G.RaidFinderQueueFrameScrollFrameChildFrameRewardsLabel:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
		end
	end

	--hooks based on elvui skin functions, just changing color/texture for the most part
	hooksecurefunc(E,"Config_UpdateLeftButtons",function()
		if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
		local frame = E:Config_GetWindow()
		if not (frame and frame.leftHolder) then return end
		local status = frame.obj.status
		local selected = status and status.groups.selected
		for _, btn in ipairs(frame.leftHolder.buttons) do
			if type(btn) == 'table' and btn.IsObjectType and btn:IsObjectType('Button') then
				local enabled = btn.info.key == selected
				if enabled then
					if not E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.classcolor then
						btn:SetBackdropColor(E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.r, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.g, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.b, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.a)
					else
						btn:SetBackdropColor(valuecolors.r, valuecolors.g, valuecolors.b,E.db.general.backdropfadecolor.a)
					end
					btn:SetBackdropBorderColor(0, 0, 0, 1)
					--btn.SetBackdropBorderColor = E.noop
					local btntext = (btn.Text) or (btn.text) or (_G[btn:GetName()] and _G[btn:GetName() .. "Text"]) --using btn.Text.GetText would return the function instead
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
						btntext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
					else
						btntext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end
		end
	end)

	hooksecurefunc(E,"Config_SetButtonColor",function(_,button, disabled)
		if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
		local buttontext = (button.Text) or (button.text) or (_G[button:GetName()] and _G[button:GetName() .. "Text"]) --using button.Text.GetText would return the function instead
		if disabled then
			if not E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.classcolor then
				buttontext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.r, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.g, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.b)
			else
				buttontext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
			end
			if button.SetBackdropColor then
				if not E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.classcolor then
					button:SetBackdropColor(E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.r, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.g, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.b, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.a)
				else
					button:SetBackdropColor(valuecolors.r, valuecolors.g, valuecolors.b,E.db.general.backdropfadecolor.a)
				end
				button:SetBackdropBorderColor(0, 0, 0, 1)
				--button.SetBackdropBorderColor = E.noop
			end
		else
			if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
				buttontext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
			else
				buttontext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
			end
			--if button.SetBackdropColor then
			--	button:SetBackdropBorderColor(0, 0, 0, 0)
				--button.SetBackdropBorderColor = E.noop
			--end
		end
	end)

	hooksecurefunc(S,"Ace3_SkinTab",function(_,tab)
		if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
		CreateFader(tab)
		local tabtext = (tab.Text) or (tab.text) or (_G[tab:GetName()] and _G[tab:GetName() .. "Text"]) --using tab.Text.GetText would return the function instead
		if tab.selected then
			if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
				tabtext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
			else
				tabtext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
			end
			if tab.backdrop then
				tab.backdrop:SetBackdropColor(0.5, 0.5, 0.5, 0.3)
				--tab.backdrop:SetBackdropBorderColor(0, 0, 0, 0)
				--tab.backdrop.SetBackdropBorderColor = E.noop
			end
		elseif tab.disabled then
			tabtext:SetTextColor(0.5,0.5,0.5)
		else
			if tabtext and tabtext.GetText then
				local r,g,b = tab.Text:GetTextColor()
				local r1,g1,b1 = E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b
				if E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
					r1,g1,b1 = valuecolors.r,valuecolors.g,valuecolors.b
				end
				if (r == 1 and math.ceil(g*100) == 82 and b == 0) or (r == r1 and g == g1 and b == b1) then --get the other color so the disabled one is not overwritten
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						tabtext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						tabtext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end
			--if tab.backdrop then
			--	tab.backdrop:SetBackdropBorderColor(0, 0, 0, 0)
				--tab.backdrop.SetBackdropBorderColor = E.noop
			--end
		end

		if not tab.EltruismDisableHook then
			tab:HookScript("OnDisable", function()
				if tabtext and tabtext.GetText then
					if not tab.selected then
						tabtext:SetTextColor(0.5,0.5,0.5)
					end
				end
			end)
			tab:HookScript("OnEnable", function()
				if tabtext and tabtext.GetText then
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						tabtext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						tabtext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end)
			tab.EltruismDisableHook = true
		end
	end)

	hooksecurefunc(S,"Ace3_TabSetSelected",function(tab,selected)
		if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
		local bd = tab.backdrop
		if not bd then return end
		if tab.disabled then return end
		if type(tab) ~= 'table' then return end
		if selected then
			if tab.Text and tab.Text.GetText then
				if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
					tab.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
				else
					tab.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
				end
			end
			if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
				bd:SetBackdropColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a)
			else
				bd:SetBackdropColor(valuecolors.r, valuecolors.g, valuecolors.b,E.db.general.backdropfadecolor.a)
			end
			bd:SetBackdropBorderColor(0, 0, 0, 1)
			--bd.SetBackdropBorderColor = E.noop
		end
	end)

	hooksecurefunc(S,"Ace3_RefreshTree",function(tab)
		if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
		if not tab.tree then return end
		if not E.private.skins.ace3Enable then return end
		local status = tab.status or tab.localstatus
		local lines = tab.lines
		local buttons = tab.buttons
		local offset = status.scrollvalue
		for i = offset + 1, #lines do
			local button = buttons[i - offset]
			if button then
				local buttontext = (button.Text) or (button.text) or (_G[button:GetName()] and _G[button:GetName() .. "Text"]) --using button.Text.GetText would return the function instead
				if button.selected then
					if buttontext and buttontext.GetText then
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
							buttontext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
						else
							buttontext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end
				else
					if buttontext and buttontext.GetText then
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							buttontext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							buttontext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end
				end
				if button.highlight then
					button.highlight:SetDesaturated(true)
					button.highlight:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.ace3.texture))
					if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
						button.highlight:SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, 0.3)
					else
						button.highlight:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 0.3)
					end
				end
				CreateFader(button,true)
			end
		end
	end)

	hooksecurefunc(S,"HandleSliderFrame",function(_,frame)
		if not frame then return end
		if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
			frame:GetThumbTexture():SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a)
		else
			frame:GetThumbTexture():SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b,0.8)
		end
	end)

	hooksecurefunc(S,"HandleCheckBox",function(_,frame)
		if not frame then return end
		if frame.SetCheckedTexture then
			if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
				frame:GetCheckedTexture():SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a)
			else
				frame:GetCheckedTexture():SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b,0.8)
			end
		end
	end)

	hooksecurefunc(S,"HandleNextPrevButton",function(_,btn) --actually skins dropdowns too
		if not btn then return end
		if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
			btn:GetNormalTexture():SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a)
		else
			btn:GetNormalTexture():SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b,0.8)
		end
	end)

	hooksecurefunc(S,"Ace3_CheckBoxSetDesaturated",function(frame,value)
		if not frame then return end
		if value then return end
		if frame:GetObjectType() == "Texture" then
			if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
				frame:SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a)
			else
				frame:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b,0.8)
			end
		end
	end)
end

hooksecurefunc(S,"HandleTab",function(_,tab, noBackdrop)
	if not tab then return end
	if noBackdrop then return end
	CreateFader(tab)
end)

hooksecurefunc(S,"HandleButton",function(_,button, _, _, noStyle)
	if button.EltruismAnimationTest then return end
	if noStyle then return end
	CreateFader(button)
end)

--for some reason buttons on macro frame dont get animation, maybe because they load too early?
--[[
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local macroframe = CreateFrame("FRAME")
macroframe:RegisterEvent("ADDON_LOADED")
macroframe:SetScript("OnEvent",function(_,_,arg)
	if (arg == "Blizzard_MacroUI") or IsAddOnLoaded("Blizzard_MacroUI") then
		macroframe:UnregisterAllEvents()
		if _G["MacroFrame"] then
			for _, button in next, {
				_G.MacroSaveButton,
				_G.MacroCancelButton,
				_G.MacroDeleteButton,
				_G.MacroNewButton,
				_G.MacroExitButton,
				_G.MacroEditButton,
				_G.MacroFrameTab1,
				_G.MacroFrameTab2,
			} do
				if button then
					print(button:GetName())
					CreateFader(button)
				end
			end
		end
	end
end)
]]
