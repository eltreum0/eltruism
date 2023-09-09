local E = unpack(ElvUI)
local _G = _G
local UIFrameFadeOut = _G.UIFrameFadeOut
local hooksecurefunc = _G.hooksecurefunc
local UIFrameFadeIn = _G.UIFrameFadeIn
local valuecolors = E:ClassColor(E.myclass, true)
local S = E:GetModule('Skins')

local function CreateFader(frame)
	if not E.private.ElvUI_EltreumUI then return end
	if not E.private.ElvUI_EltreumUI.install_version then return end
	if not E.db.ElvUI_EltreumUI then return end
	if not E.db.ElvUI_EltreumUI.skins then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3 then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.button then return end
	if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor then return end

	if not frame.EltruismAnimation then
		frame.EltruismAnimation = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
		frame.EltruismAnimation:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.ace3.texture))
		if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
			frame.EltruismAnimation:SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.a or 1)
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

		frame:HookScript("OnEnter", function()
			--if frame.highlight and frame.highlight:IsVisible() then return end
			UIFrameFadeIn(frame.EltruismAnimation, E.db.ElvUI_EltreumUI.skins.ace3.fadetime, 0, 1)
			if frame.SetBackdropBorderColor then
				frame:SetBackdropBorderColor(0, 0, 0, 1)
				--frame.SetBackdropBorderColor = E.noop
			end
		end)
		frame:HookScript("OnLeave", function()
			--if frame.highlight and frame.highlight:IsVisible() then return end
			UIFrameFadeOut(frame.EltruismAnimation, E.db.ElvUI_EltreumUI.skins.ace3.fadetime, 1, 0)
		end)
	end
end

function ElvUI_EltreumUI:Ace3Skin()
	if not E.db.ElvUI_EltreumUI.skins.ace3.enable then return end

	--hooks based on elvui skin functions, just changing color/texture for the most part
	hooksecurefunc(E,"Config_UpdateLeftButtons",function()
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
				end
			end
		end
	end)

	hooksecurefunc(E,"Config_SetButtonColor",function(_,button, disabled)
		if disabled then
			if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
				button.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
			else
				button.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
			end
			if button.SetBackdropColor then
				if not E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.classcolor then
					button:SetBackdropColor(E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.r, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.g, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.b, E.db.ElvUI_EltreumUI.skins.ace3.button.disabled.a)
				else
					button:SetBackdropColor(valuecolors.r, valuecolors.g, valuecolors.b,E.db.general.backdropfadecolor.a)
				end
				--button:SetBackdropBorderColor(0, 0, 0, 0)
				--button.SetBackdropBorderColor = E.noop
			end
		else
			if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
				button.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
			else
				button.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
			end
			--if button.SetBackdropColor then
			--	button:SetBackdropBorderColor(0, 0, 0, 0)
				--button.SetBackdropBorderColor = E.noop
			--end
		end
	end)

	hooksecurefunc(S,"Ace3_SkinTab",function(_,tab)
		CreateFader(tab)
		if tab.selected then
			if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
				tab.text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b)
			else
				tab.text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
			end
			if tab.backdrop then
				tab.backdrop:SetBackdropColor(0.5, 0.5, 0.5, 0.3)
				--tab.backdrop:SetBackdropBorderColor(0, 0, 0, 0)
				--tab.backdrop.SetBackdropBorderColor = E.noop
			end
		elseif tab.disabled then
			if tab.Text and tab.Text.GetText then
				tab.Text:SetTextColor(0.5,0.5,0.5)
			end
		else
			if tab.Text and tab.Text.GetText then
				local r,g,b = tab.Text:GetTextColor()
				local r1,g1,b1 = E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.b
				if E.db.ElvUI_EltreumUI.skins.ace3.tab.TextSelected.classcolor then
					r1,g1,b1 = valuecolors.r,valuecolors.g,valuecolors.b
				end
				if (r == 1 and math.ceil(g*100) == 82 and b == 0) or (r == r1 and g == g1 and b == b1) then --get the other color so the disabled one is not overwritten
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						tab.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						tab.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
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
				if tab.Text and tab.Text.GetText then
					tab.Text:SetTextColor(0.5,0.5,0.5)
				end
			end)
			tab:HookScript("OnEnable", function()
				if tab.Text and tab.Text.GetText then
					if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
						tab.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
					else
						tab.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
					end
				end
			end)
			tab.EltruismDisableHook = true
		end
	end)

	hooksecurefunc(S,"Ace3_TabSetSelected",function(tab,selected)
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
		--else
			--bd:SetBackdropBorderColor(0, 0, 0, 0)
			--bd.SetBackdropBorderColor = E.noop
		end
	end)

	hooksecurefunc(S,"Ace3_RefreshTree",function(tab)
		if not tab.tree then return end
		if not E.private.skins.ace3Enable then return end
		local status = tab.status or tab.localstatus
		local lines = tab.lines
		local buttons = tab.buttons
		local offset = status.scrollvalue
		for i = offset + 1, #lines do
			local button = buttons[i - offset]
			if button then
				if button.highlight then
					button.highlight:SetDesaturated(true)
					button.highlight:SetTexture(E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.skins.ace3.texture))
					if not E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.classcolor then
						button.highlight:SetVertexColor(E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.r, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.g, E.db.ElvUI_EltreumUI.skins.ace3.button.hovercolor.b, 0.3)
					else
						button.highlight:SetVertexColor(valuecolors.r, valuecolors.g, valuecolors.b, 0.3)
					end
				end
				CreateFader(button)
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
