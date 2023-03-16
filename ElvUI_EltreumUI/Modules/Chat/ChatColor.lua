local ElvUI_EltreumUI, E, L, V, P, G = unpack((select(2, ...)))
local _G = _G

--chat without backdrop
function ElvUI_EltreumUI:TransparentChat()
	E.db["chat"]["fadeUndockedTabs"] = true
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["panelTabTransparency"] = true
	E.db["chat"]["fadeTabsNoBackdrop"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
		E.db["datatexts"]["panels"]["EltruismDataText"]["backdrop"] = false
		E.db["datatexts"]["panels"]["EltruismDataText"]["panelTransparency"] = false
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["backdrop"] = false
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["panelTransparency"] = false
	end

	E:UpdateChat()
	E:UpdateLayout()
	E:UpdateDataBars()
	E:UpdateDataTexts()
	--E:StaggeredUpdateAll()

	if _G["EltruismRightChatShadowFrame"] then
		_G["EltruismRightChatShadowFrame"]:Hide()
	end
	if _G["EltruismLeftChatShadowFrame"] then
		_G["EltruismLeftChatShadowFrame"]:Hide()
	end

	--show the chat buttons because they are attached to the chat datatext not panel
	_G.LeftChatToggleButton:SetAlpha(1)
	_G.LeftChatToggleButton:Show()
	_G.RightChatToggleButton:SetAlpha(1)
	_G.RightChatToggleButton:Show()

	ElvUI_EltreumUI:Print("Chat set to Transparent mode")
end

--chat with backdrop
function ElvUI_EltreumUI:DarkChat()
	E.db["chat"]["fadeUndockedTabs"] = false
	E.db["chat"]["panelBackdrop"] = "SHOWBOTH"
	E.db["chat"]["panelTabTransparency"] = false
	E.db["chat"]["fadeTabsNoBackdrop"] = false
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = true
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
		E.db["datatexts"]["panels"]["EltruismDataText"]["backdrop"] = true
		E.db["datatexts"]["panels"]["EltruismDataText"]["panelTransparency"] = true
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["backdrop"] = true
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["panelTransparency"] = true
	end

	E:UpdateChat()
	E:UpdateLayout()
	E:UpdateDataBars()
	E:UpdateDataTexts()
	--E:StaggeredUpdateAll()

	if _G["EltruismRightChatShadowFrame"] then
		_G["EltruismRightChatShadowFrame"]:Show()
	end
	if _G["EltruismLeftChatShadowFrame"] then
		_G["EltruismLeftChatShadowFrame"]:Show()
	end

	--show the chat buttons because they are attached to the chat datatext not panel
	_G.LeftChatToggleButton:SetAlpha(1)
	_G.LeftChatToggleButton:Show()
	_G.RightChatToggleButton:SetAlpha(1)
	_G.RightChatToggleButton:Show()

	ElvUI_EltreumUI:Print("Chat set to Dark mode")
end
