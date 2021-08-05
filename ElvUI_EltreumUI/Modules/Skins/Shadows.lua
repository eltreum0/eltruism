local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local ElvUF_Player_PowerBar = _G['ElvUF_Player_PowerBar']
local ElvUF_Player_HealthBar = _G['ElvUF_Player_HealthBar']
local ElvUF_TargetTarget_HealthBar = _G['ElvUF_TargetTarget_HealthBar']
local ElvUF_TargetTarget_PowerBar = _G['ElvUF_TargetTarget_PowerBar']
local ElvUF_Target_HealthBar = _G['ElvUF_Target_HealthBar']
local ElvUF_Target_PowerBar = _G['ElvUF_Target_PowerBar']
local ElvUF_Focus_HealthBar = _G['ElvUF_Focus_HealthBar']
local ElvUF_Focus_PowerBar = _G['ElvUF_Focus_PowerBar']
local ElvUF_Pet = _G['ElvUF_Pet']
local pairs = _G.pairs
local CreateFrame = _G.CreateFrame

--turns out elvui includes shadows! Ty azilroka
function ElvUI_EltreumUI:Shadows()
	--Very simple shadows from elvui, SLE likely does it way better
	if E.db.ElvUI_EltreumUI.skins.shadows then

		--blizzard ones
		if not _G.GameMenuFrame.shadow then
			_G.GameMenuFrame:CreateShadow()
		end

		if not _G.DropDownList1.shadow then
			_G.DropDownList1:CreateShadow()
		end
		if not _G.DropDownList2.shadow then
			_G.DropDownList2:CreateShadow()
		end

		_G.GameTooltipStatusBar:CreateShadow()
		if not _G.GameTooltip.shadow then
			_G.GameTooltip:CreateShadow()
		end

		if not _G.GameTooltip.shadow then
			_G.GameTooltip:CreateShadow()
		end

		if not _G.ReadyCheckFrame.shadow then
			_G.ReadyCheckFrame:CreateShadow()
		end

		if not _G.StackSplitFrame.shadow then
			_G.StackSplitFrame:CreateShadow()
		end

		if not _G.ChatConfigFrame.shadow then
			_G.ChatConfigFrame:CreateShadow()
		end

		if not _G.MailFrame.shadow then
			_G.MailFrame:CreateShadow()
		end

		if not IsAddOnLoaded("Blizzard_MacroUI") then
			LoadAddOn("Blizzard_MacroUI")
		end
		local MacroFrame = _G.MacroFrame
		MacroFrame:HookScript("OnShow", function()
			if not _G.MacroFrame.shadow then
				_G.MacroFrame:CreateShadow()
			end
		end)

		if not _G.ShoppingTooltip1.shadow then
			_G.ShoppingTooltip1:CreateShadow()
		end

		if not _G.ShoppingTooltip2.shadow then
			_G.ShoppingTooltip2:CreateShadow()
		end

		if not _G.VideoOptionsFrame.shadow then
			_G.VideoOptionsFrame:CreateShadow()
		end

		if not _G.InterfaceOptionsFrame.shadow then
			_G.InterfaceOptionsFrame:CreateShadow()
		end

		if not IsAddOnLoaded("Blizzard_BindingUI") then
			LoadAddOn("Blizzard_BindingUI")
		end
		local KeyBindingFrame = _G.KeyBindingFrame
		KeyBindingFrame:HookScript("OnShow", function()
			if not _G.KeyBindingFrame.shadow then
				_G.KeyBindingFrame:CreateShadow()
			end
		end)

		if not IsAddOnLoaded("Blizzard_TalentUI") then
			LoadAddOn("Blizzard_TalentUI")
		end

		if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
			local PlayerTalentFrame = _G.PlayerTalentFrame
			PlayerTalentFrame:HookScript("OnShow", function()
				if ElvUI_EltreumUI.Retail then
					if not _G.PlayerTalentFrame.shadow then
						_G.PlayerTalentFrame:CreateShadow()
					end
				elseif ElvUI_EltreumUI.TBC then
					if not _G.PlayerTalentFrame.backdrop.shadow then
						_G.PlayerTalentFrame.backdrop:CreateShadow()
					end
				end
			end)
		end

		if ElvUI_EltreumUI.Classic then
			local TalentFrame = _G.TalentFrame
			TalentFrame:HookScript("OnShow", function()
					if not _G.TalentFrame.backdrop.shadow then
						_G.TalentFrame.backdrop:CreateShadow()
					end
			end)
		end

		local RightChatShadow = CreateFrame("Frame", "EltruismRightChatShadowFrame")
		local rightsizex, rightsizey = _G['RightChatMover']:GetSize()
		RightChatShadow:SetSize(rightsizex, rightsizey)
		RightChatShadow:SetParent(_G['RightChatPanel'])
		if not (self.RightChatIsSkinned) then
			RightChatShadow.shadow = RightChatShadow:CreateShadow(nil, true)
			RightChatShadow:SetPoint("TOPRIGHT", _G['RightChatPanel'] ,"TOPRIGHT", 0, 0)
			RightChatShadow:SetPoint("BOTTOMLEFT", _G['RightChatDataPanel'] ,"BOTTOMLEFT", 0, 0)
			RightChatShadow:Show()
			self.RightChatIsSkinned = true
		end

		local LeftChatShadow = CreateFrame("Frame", "EltruismLeftChatShadowFrame")
		local leftsizex, leftsizey = _G['LeftChatMover']:GetSize()
		LeftChatShadow:SetSize(leftsizex, leftsizey)
		LeftChatShadow:SetParent(_G['LeftChatPanel'])
		if not (self.LeftChatIsSkinned) then
			LeftChatShadow.shadow = LeftChatShadow:CreateShadow(nil, true)
			LeftChatShadow:SetPoint("TOPLEFT", _G['LeftChatPanel'] ,"TOPLEFT", 0, 0)
			LeftChatShadow:SetPoint("BOTTOMRIGHT", _G['LeftChatDataPanel'] ,"BOTTOMRIGHT", 0, 0)
			LeftChatShadow:Show()
			self.LeftChatIsSkinned = true
		end

		local MinimapShadow = CreateFrame("Frame", "EltruismMiniMapShadowFrame")
		local Minimapsizex, Minimapsizey = _G['Minimap']:GetSize()
		MinimapShadow:SetSize(Minimapsizex, Minimapsizey)
		MinimapShadow:SetParent(_G['RightChatPanel'])
		if not (self.minimapIsSkinned) then
			MinimapShadow.shadow = MinimapShadow:CreateShadow(nil, true)
			MinimapShadow:SetPoint("TOPRIGHT", _G['Minimap'] ,"TOPRIGHT", 0, 0)
			MinimapShadow:SetPoint("BOTTOMLEFT", _G['MinimapPanel'] ,"BOTTOMLEFT", 0, 0)
			MinimapShadow:Show()
			self.minimapIsSkinned = true
		end


		if ElvUI_EltreumUI.Retail then

			if not _G.QueueStatusFrame.shadow then
				_G.QueueStatusFrame:CreateShadow()
			end

			if not _G.SplashFrame.shadow then
				_G.LFDRoleCheckPopup:CreateShadow()
			end

			if not _G.LFDReadyCheckPopup.shadow then
				_G.LFDReadyCheckPopup:CreateShadow()
			end

			if not _G.LFDRoleCheckPopup.shadow then
				_G.LFDRoleCheckPopup:CreateShadow()
			end

			if not _G.LFGListApplicationDialog.shadow then
				_G.LFGListApplicationDialog:CreateShadow()
			end

			if not IsAddOnLoaded("Blizzard_Calendar") then
				LoadAddOn("Blizzard_Calendar")
			end
			local CalendarFrame = _G.CalendarFrame
			CalendarFrame:HookScript("OnShow", function()
				if not _G.CalendarFrame.shadow then
					_G.CalendarFrame:CreateShadow()
				end
			end)

			if not IsAddOnLoaded("Blizzard_Communities") then
				LoadAddOn("Blizzard_Communities")
			end
			local CommunitiesFrame = _G.CommunitiesFrame
			CommunitiesFrame:HookScript("OnShow", function()
				if not _G.CommunitiesFrame.shadow then
					_G.CommunitiesFrame:CreateShadow()
				end
			end)

			if not IsAddOnLoaded("Blizzard_AchievementUI") then
				LoadAddOn("Blizzard_AchievementUI")
			end
			local AchievementFrame = _G.AchievementFrame
			AchievementFrame:HookScript("OnShow", function()
				if not _G.AchievementFrame.backdrop.shadow then
					_G.AchievementFrame.backdrop:CreateShadow()
				end
			end)

			if not IsAddOnLoaded("Blizzard_GarrisonUI") then
				LoadAddOn("Blizzard_GarrisonUI")
			end
			local CovenantMissionFrame = _G.CovenantMissionFrame
			CovenantMissionFrame:HookScript("OnShow", function()
				if not _G.CovenantMissionFrame.shadow then
					_G.CovenantMissionFrame:CreateShadow()
				end
			end)

			local GarrisonLandingPage = _G.GarrisonLandingPage
			GarrisonLandingPage:HookScript("OnShow", function()
				if not _G.GarrisonLandingPage.shadow then
					_G.GarrisonLandingPage:CreateShadow()
				end
			end)

			if not IsAddOnLoaded("Blizzard_Collections") then
				LoadAddOn("Blizzard_Collections")
			end
			local CollectionsJournal = _G.CollectionsJournal
			CollectionsJournal:HookScript("OnShow", function()
				if not _G.CollectionsJournal.shadow then
					_G.CollectionsJournal:CreateShadow()
				end
			end)

			if not _G.FriendsFrame.shadow then
				_G.FriendsFrame:CreateShadow()
			end
			if not _G.PaperDollFrame.shadow then
				_G.PaperDollFrame:CreateShadow()
			end
			if not _G.GroupFinderFrame.shadow then
				_G.GroupFinderFrame:CreateShadow()
			end

			if not _G.WorldMapFrame.backdrop.shadow then
				_G.WorldMapFrame.backdrop:CreateShadow()
			end
			if not _G.SpellBookFrame.shadow then
				_G.SpellBookFrame:CreateShadow()
			end

			if not _G.ZoneAbilityFrame.shadow then
				_G.ZoneAbilityFrame:CreateShadow()
			end

			if not _G.BossButton.shadow then
				_G.BossButton:CreateShadow()
			end

		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			if not _G.FriendsFrame.backdrop.shadow then
				_G.FriendsFrame.backdrop:CreateShadow()
			end
			if not _G.WorldMapFrame.shadow then
				_G.WorldMapFrame:CreateShadow()
			end
			if not _G.CharacterFrame.backdrop.shadow then
				_G.CharacterFrame.backdrop:CreateShadow()
			end
			if not _G.SpellBookFrame.backdrop.shadow then
				_G.SpellBookFrame.backdrop:CreateShadow()
			end
			if not _G.FriendsFrame.backdrop.shadow then
				_G.FriendsFrame.backdrop:CreateShadow()
			end

			if E.private.bags.enable then
				if not _G.ElvUI_ContainerFrame.shadow then
					_G.ElvUI_ContainerFrame:CreateShadow()
				end
				if not _G.ElvUI_BankContainerFrame.shadow then
					_G.ElvUI_BankContainerFrame:CreateShadow()
				end
			end
		end

----------------------------------------------------------------------------------------------------
		--elvui
		--action bars, from borders
		if E.private.actionbar.enable then
			for i = 1, 10 do
				local actionbars = {_G['ElvUI_Bar'..i]}
				for _, frame in pairs(actionbars) do
					for k = 1, 12 do
						local slots = {_G['ElvUI_Bar'..i..'Button'..k]}
						for _, button in pairs(slots) do
							if not button.shadow then
								button.shadow = button:CreateShadow(nil, true)
								button.shadow:SetParent(button)
								button.shadow.size = 2
							end
						end
					end
				end
			end
		end

		--same as above but for party
		for i = 1, 5 do
			local partymembers = {_G['ElvUF_PartyGroup1UnitButton'..i]}
			for _, frame in pairs(partymembers) do
				for _, button in pairs(partymembers) do
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

		--boss
		for i = 1, 5 do
			local bossmembers = {_G['ElvUF_Boss'..i]}
			for _, frame in pairs(bossmembers) do
				for _, button in pairs(bossmembers) do
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

		--pets
		if E.private.actionbar.enable then
			for i = 1, 12 do
				local button = _G['PetActionButton'..i]
				if not button then
					break
				else
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

		--stances
		for i = 1, 12 do
			local button = _G['ElvUI_StanceBarButton'..i]
			if not button then
				break
			else
				if not button.shadow then
					button.shadow = button:CreateShadow(nil, true)
					button.shadow:SetParent(button)
					button.shadow.size = 2
				end
			end
		end

		--classpower
		for i = 1, 10 do
			local button = _G['ElvUF_PlayerClassIconButton'..i]
			if not button then
				break
			else
				if not button.shadow then
					button.shadow = button:CreateShadow(nil, true)
					button.shadow:SetParent(button)
					button.shadow.size = 2
				end
			end
		end

		--runes
		for i = 1, 10 do
			local button = _G['ElvUF_PlayerRuneButton'..i]
			if not button then
				break
			else
				if not button.shadow then
					button.shadow = button:CreateShadow(nil, true)
					button.shadow:SetParent(button)
					button.shadow.size = 2
				end
			end
		end

		--_AdditionalPowerBar
		for i = 1, 10 do
			local button = _G['ElvUF_Player_AdditionalPowerBar'..i]
			if not button then
				break
			else
				if not button.shadow then
					button.shadow = button:CreateShadow(nil, true)
					button.shadow:SetParent(button)
					button.shadow.size = 2
				end
			end
		end

		if not _G['ElvUF_Player_AdditionalPowerBar1'] then
			if _G['ElvUF_Player_AdditionalPowerBar'] then
				if not _G.ElvUF_Player_AdditionalPowerBar.shadow then
					_G.ElvUF_Player_AdditionalPowerBar:CreateShadow()
				end
			end
		end

		local PlayerCastbar = CreateFrame("Frame", "EltruismPlayerCastBarShadowFrame")
		local PlayerCastbarx = E.db.unitframe.units.player.castbar.width + E.db.unitframe.units.player.castbar.iconSize -3
		local PlayerCastbary = E.db.unitframe.units.player.castbar.height -1
		PlayerCastbar:SetSize(PlayerCastbarx, PlayerCastbary)
		PlayerCastbar:SetParent(_G.ElvUF_Player_CastBar)
		if not (self.PlayerCastBarIsSkinned) then
			PlayerCastbar.shadow = PlayerCastbar:CreateShadow(nil, true)
			PlayerCastbar:SetPoint("CENTER", _G.ElvUF_Player_CastBar, "CENTER", -14, 0)
			PlayerCastbar:Show()

			self.PlayerCastBarIsSkinned = true
		end

		if not E.db.unitframe.units.target.castbar.overlayOnFrame == "Power" then
			local TargetCastbar = CreateFrame("Frame", "EltruismTargetCastBarShadowFrame")
			local TargetCastbarx = E.db.unitframe.units.target.castbar.width + E.db.unitframe.units.target.castbar.iconSize -2
			local TargetCastbary = E.db.unitframe.units.target.castbar.height - 1
			TargetCastbar:SetSize(TargetCastbarx, TargetCastbary)
			TargetCastbar:SetParent(_G.ElvUF_Target_CastBar)
			if not (self.TargetCastBarIsSkinned) then
				TargetCastbar.shadow = TargetCastbar:CreateShadow(nil, true)
				TargetCastbar:SetPoint("CENTER", _G.ElvUF_Target_CastBar, "CENTER", -14, 0)
				self.TargetCastBarIsSkinned = true
			end
		end

		if not ElvUF_Player_HealthBar.shadow then
			ElvUF_Player_HealthBar:CreateShadow()
		end

		if not ElvUF_Player_PowerBar.shadow then
			ElvUF_Player_PowerBar:CreateShadow()
		end

		if _G.ElvUF_Player_Stagger then
			if not _G.ElvUF_Player_Stagger.shadow then
				_G.ElvUF_Player_Stagger:CreateShadow()
			end
		end

		if not _G.ElvLootFrame.shadow then
			_G.ElvLootFrame:CreateShadow()
		end

		local DT = E:GetModule('DataTexts')
		if DT.tooltip then
			if not DT.tooltip.shadow then
				DT.tooltip:CreateShadow()
			end
		end

		if not ElvUF_TargetTarget_HealthBar.shadow then
			ElvUF_TargetTarget_HealthBar:CreateShadow()
		end

		if not ElvUF_TargetTarget_PowerBar.shadow then
			ElvUF_TargetTarget_PowerBar:CreateShadow()
		end

		if not ElvUF_TargetTarget_PowerBar.shadow then
			ElvUF_TargetTarget_PowerBar:CreateShadow()
		end

		if not ElvUF_Target_HealthBar.shadow then
			ElvUF_Target_HealthBar:CreateShadow()
		end

		if not ElvUF_Target_PowerBar.shadow then
			ElvUF_Target_PowerBar:CreateShadow()
		end

		if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
			if not ElvUF_Focus_HealthBar.shadow then
				ElvUF_Focus_HealthBar:CreateShadow()
			end
			if not ElvUF_Focus_PowerBar.shadow then
				ElvUF_Focus_PowerBar:CreateShadow()
			end
		end

		if not ElvUF_Pet.shadow then
			ElvUF_Pet:CreateShadow()
		end

		if E.private.bags.enable then
			if not _G.ElvUI_ContainerFrame.shadow then
				_G.ElvUI_ContainerFrame:CreateShadow()
			end
			if not _G.ElvUI_BankContainerFrame.shadow then
				_G.ElvUI_BankContainerFrame:CreateShadow()
			end
		end

		--elvui popup
		for i = 1, 5 do
			local ElvUI_StaticPopups = {_G['ElvUI_StaticPopup'..i]}
			for _, frame in pairs(ElvUI_StaticPopups) do
				for _, button in pairs(ElvUI_StaticPopups) do
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

		if IsAddOnLoaded('ProjectAzilroka') then
			if not _G.stAMFrame.shadow then
				_G.stAMFrame:CreateShadow()
			end

			if not _G.stAMProfileMenu.shadow then
				_G.stAMProfileMenu:CreateShadow()
			end
		end

	end
end

function ElvUI_EltreumUI:AuraShadows()
	if E.db.ElvUI_EltreumUI.skins.shadows then
		--buffs
		for i = 1, 20 do
			local buffaura = {_G['ElvUIPlayerBuffsAuraButton'..i]}
			for _, frame in pairs(buffaura) do
				for _, button in pairs(buffaura) do
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

		--debuffs
		for i = 1, 20 do
			local debuffaura = {_G['ElvUIPlayerDebuffsAuraButton'..i]}
			for _, frame in pairs(debuffaura) do
				for _, button in pairs(debuffaura) do
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

		--weapon enchant thing
		for i = 1, 20 do
			local weaponenchant = {_G['ElvUIPlayerBuffsTempEnchant'..i]}
			for _, frame in pairs(weaponenchant) do
				for _, button in pairs(weaponenchant) do
					if not button.shadow then
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end
		end

	end
end
