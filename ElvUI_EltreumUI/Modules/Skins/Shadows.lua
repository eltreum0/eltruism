local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local pairs = _G.pairs
local CreateFrame = _G.CreateFrame
local NP = E:GetModule('NamePlates')
local UF = E:GetModule('UnitFrames')
--local AB = E:GetModule('ActionBars')
local A = E:GetModule('Auras')

--Frame Shadows, turns out ElvUI includes the function but it seems to add a lot of usage during load time
function ElvUI_EltreumUI:Shadows()
	if E.db.ElvUI_EltreumUI.skins.shadows then
		------------------------------------------------------------------------------------------------------blizzard frames
		if not IsAddOnLoaded("Blizzard_BindingUI") then
			LoadAddOn("Blizzard_BindingUI")
		end

		if not IsAddOnLoaded("Blizzard_MacroUI") then
			LoadAddOn("Blizzard_MacroUI")
		end

		local MacroFrame = _G.MacroFrame
		MacroFrame:SetScript("OnShow", function()
			if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
				if not _G.MacroFrame.shadow then
					_G.MacroFrame:CreateShadow()
				end
			elseif ElvUI_EltreumUI.Classic then
				if not _G.MacroFrame.backdrop.shadow then
					_G.MacroFrame.backdrop:CreateShadow()
				end
			end
		end)

		if not IsAddOnLoaded("Blizzard_TalentUI") then
			LoadAddOn("Blizzard_TalentUI")
		end

		local blizzardframes = {
			_G.GameMenuFrame,
			_G.DropDownList1,
			_G.DropDownList2,
			--_G.GameTooltipStatusBar.backdrop,
			_G.GameTooltip,
			_G.ReadyCheckFrame,
			_G.StackSplitFrame,
			_G.ChatConfigFrame,
			_G.ShoppingTooltip1,
			_G.ShoppingTooltip2,
			_G.VideoOptionsFrame,
			_G.InterfaceOptionsFrame,
			_G.StaticPopup1, --seems like blizzard
			_G.KeyBindingFrame,

			--need to confirm
			_G.CharacterFrameTab1.backdrop,
			_G.CharacterFrameTab2.backdrop,
			_G.CharacterFrameTab3.backdrop,
			_G.FriendsFrameTab1.backdrop,
			_G.FriendsFrameTab2.backdrop,
			_G.FriendsFrameTab3.backdrop,
			_G.FriendsFrameTab4.backdrop,
			_G.SpellBookFrameTabButton1.backdrop,
			_G.SpellBookFrameTabButton2.backdrop,
		}
		for _, frame in pairs(blizzardframes) do
			if frame and not frame.shadow then
				frame:CreateShadow()
			end
		end

		local MinimapShadow = CreateFrame("Frame", "EltruismMiniMapShadowFrame")
		local Minimapsizex, Minimapsizey = _G['Minimap']:GetSize()
		MinimapShadow:SetSize(Minimapsizex, Minimapsizey)
		MinimapShadow:SetParent(_G['Minimap'])
		if not (self.minimapIsSkinned) then
			MinimapShadow.shadow = MinimapShadow:CreateShadow(nil, true)
			MinimapShadow:SetPoint("TOPRIGHT", _G['Minimap'] ,"TOPRIGHT", 0, 0)
			MinimapShadow:SetPoint("BOTTOMLEFT", _G['MinimapPanel'] ,"BOTTOMLEFT", 0, 0)
			if E.db.datatexts.panels.MinimapPanel.backdrop == false then
				MinimapShadow:SetPoint("BOTTOMLEFT", _G['Minimap'] ,"BOTTOMLEFT", 0, 0)
				--print("aaaa")
			end
			MinimapShadow:Show()
			self.minimapIsSkinned = true
		end

		--tooltip hp bar, one of the worst actually
		if not _G.GameTooltipStatusBar.backdrop.shadow then
			local EltruismGameTooltipStatusBar = CreateFrame("Frame", "EltruismGameTooltipStatusBarShadowFrame")
			local GameTooltipStatusBarx, GameTooltipStatusBary = _G.GameTooltipStatusBar.backdrop:GetSize()
			EltruismGameTooltipStatusBar:SetSize(GameTooltipStatusBarx, GameTooltipStatusBary-3)
			EltruismGameTooltipStatusBar:SetParent(_G['GameTooltipStatusBar.backdrop'])
			if not (self.EltruismGameTooltipStatusBarIsSkinned) then
				EltruismGameTooltipStatusBar.shadow = EltruismGameTooltipStatusBar:CreateShadow()
				EltruismGameTooltipStatusBar:SetPoint("BOTTOMLEFT", _G.GameTooltipStatusBar.backdrop ,"BOTTOMLEFT", 0, 1)
				EltruismGameTooltipStatusBar:SetPoint("TOPRIGHT", _G.GameTooltipStatusBar.backdrop ,"TOPRIGHT", 0, 0)
				EltruismGameTooltipStatusBar:SetParent(_G.GameTooltipStatusBar.backdrop)
				EltruismGameTooltipStatusBar:Show()
				self.EltruismGameTooltipStatusBarIsSkinned = true
			end
		end

		--local a = _G["EltruismGameTooltipStatusBarShadowFrame"]:GetChildren()
		--print(inspect(getmetatable(a)))

		--attempt at mirroring elvui CreateFrame() but edited with a texture that doesn't have a bottom, pretty much failed since it looks the same
		--[[
		local offset = (E.PixelMode and 3) or (4)
		local shadow = CreateFrame('Frame', nil, _G.GameTooltipStatusBar.backdrop, 'BackdropTemplate')
		shadow:SetFrameLevel(1)
		shadow:SetFrameStrata(_G.GameTooltipStatusBar.backdrop:GetFrameStrata())
		shadow:SetOutside(_G.GameTooltipStatusBar.backdrop, offset, offset, nil, true)
		shadow:SetBackdrop({
			edgeFile = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\GlowTex2.tga",
			edgeSize = 3
		})
		shadow:SetBackdropColor(0, 0, 0, 0)
		shadow:SetBackdropBorderColor(0, 0, 0, 0.9)
		]]

		------------------------------------------------------------------------------------------------------version specific
		if ElvUI_EltreumUI.Retail then

			if not IsAddOnLoaded("Blizzard_Calendar") then
				LoadAddOn("Blizzard_Calendar")
			end
			if not IsAddOnLoaded("Blizzard_Communities") then
				LoadAddOn("Blizzard_Communities")
			end
			if not IsAddOnLoaded("Blizzard_AchievementUI") then
				LoadAddOn("Blizzard_AchievementUI")
			end

			if not IsAddOnLoaded("Blizzard_GarrisonUI") then
				LoadAddOn("Blizzard_GarrisonUI")
			end

			if not IsAddOnLoaded("Blizzard_CovenantSanctum") then
				LoadAddOn("Blizzard_CovenantSanctum")
			end

			if not IsAddOnLoaded("Blizzard_Soulbinds") then
				LoadAddOn("Blizzard_Soulbinds")
			end

			if not IsAddOnLoaded("Blizzard_Collections") then
				LoadAddOn("Blizzard_Collections")
			end

			if not IsAddOnLoaded("Blizzard_PVPUI") then
				LoadAddOn("Blizzard_PVPUI")
			end

			if not IsAddOnLoaded("Blizzard_VoidStorageUI") then
				LoadAddOn("Blizzard_VoidStorageUI")
			end

			if not IsAddOnLoaded("Blizzard_EncounterJournal") then
				LoadAddOn("Blizzard_EncounterJournal")
			end

			--retail frames
			local retailframes = {
				_G.QueueStatusFrame,
				--_G.SplashFrame,
				_G.LFDRoleCheckPopup,
				_G.LFDReadyCheckPopup,
				_G.LFGListApplicationDialog,
				_G.PaperDollFrame,
				_G.GroupFinderFrame,
				_G.ZoneAbilityFrame,
				_G.ReputationFrame,
				_G.TokenFrame,
				_G.SpellBookFrame,
				_G.FriendsFrame,
				_G.MerchantFrame,
				_G.MailFrame,
				_G.HelpFrame.backdrop,
				_G.WorldMapFrame.backdrop,
				_G.CalendarFrame,
				_G.CommunitiesFrame,
				_G.AchievementFrame.backdrop,
				_G.CovenantMissionFrame,
				_G.GarrisonLandingPage,
				_G.CovenantSanctumFrame,
				_G.SoulbindViewer,
				_G.CollectionsJournal,
				_G.CollectionsJournalTab1.backdrop,
				_G.CollectionsJournalTab2.backdrop,
				_G.CollectionsJournalTab3.backdrop,
				_G.CollectionsJournalTab4.backdrop,
				_G.CollectionsJournalTab5.backdrop,
				_G.ToyBox,
				_G.HeirloomsJournal,
				_G.PetJournal,
				_G.WardrobeFrame,
				_G.WardrobeCollectionFrame,
				_G.PVPUIFrame,
				_G.PVEFrameTab1.backdrop,
				_G.PVEFrameTab2.backdrop,
				_G.PVEFrameTab3.backdrop,
				_G.VoidStorageFrame,
				_G.EncounterJournal,
				_G.PlayerTalentFrame,
				_G.PlayerTalentFrameTab1.backdrop,
				_G.PlayerTalentFrameTab2.backdrop,
			}
			for _, frame in pairs(retailframes) do
				if frame and not frame.shadow then
					frame:CreateShadow()
				end
			end

			if E.private.actionbar.enable then
				if not _G.BossButton.shadow then
					_G.BossButton:CreateShadow()
				end
			end

		elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
			--tbc/classic frames
			local classicframes = {
				_G.HelpFrame,
				_G.QuestLogFrame.backdrop,
				_G.CharacterFrame.backdrop,
				_G.SpellBookFrame.backdrop,
				_G.FriendsFrame.backdrop,
				_G.MailFrame.backdrop,
				_G.MerchantFrame.backdrop,
				_G.WorldMapFrame,
				_G.PlayerTalentFrame.backdrop,
				_G.PlayerTalentFrameTab1.backdrop,
				_G.PlayerTalentFrameTab2.backdrop,
				_G.PlayerTalentFrameTab3.backdrop,
				_G.CharacterFrameTab4.backdrop,  --only in classic though
				_G.CharacterFrameTab5.backdrop,  --only in classic though
				_G.FriendsFrameTab5.backdrop, --only in classic though
			}
			for _, frame in pairs(classicframes) do
				if frame and not frame.shadow then
					frame:CreateShadow()
				end
			end
			--tbc only frames
			if ElvUI_EltreumUI.TBC then
				local tbcframes = {
				_G.LFGParentFrame.backdrop,
				_G.LFGParentFrameTab1.backdrop,
				_G.LFGParentFrameTab2.backdrop,
				}
				for _, frame in pairs(tbcframes) do
					if frame and not frame.shadow then
						frame:CreateShadow()
					end
				end
			end

		end
		------------------------------------------------------------------------------------------------------elvui frames
		local GeneralElvUIFrames = {
			_G['ElvLootFrame'],
			_G['ElvUI_ReputationBar'],
			_G['ElvUI_ExperienceBar'],
			_G['ElvUI_ThreatBar'],
			--_G['ElvUI_MicroBar.backdrop'],
		}
		for _, frame in pairs(GeneralElvUIFrames) do
			if frame and not frame.shadow then
				frame:CreateShadow()
			end
		end
		--datatexts
		local DT = E:GetModule('DataTexts')
		if DT.tooltip then
			if not DT.tooltip.shadow then
				DT.tooltip:CreateShadow()
			end
		end

		--action bars
		if E.private.actionbar.enable then
			--elvui action bars
			for i = 1, 10 do
				local actionbars = {_G['ElvUI_Bar'..i]}
				for _, frame in pairs(actionbars) do
					for k = 1, 12 do
						local slots = {_G['ElvUI_Bar'..i..'Button'..k]}
						for _, button in pairs(slots) do
							if not button.shadow then
								button:CreateShadow()
								--[[button.shadow = button:CreateShadow(nil, true)
								button.shadow:SetParent(button)
								button.shadow.size = 2]]
							end
						end
					end
				end
			end

			--pet bars
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

			--stances
			for i = 1, 12 do
				local button = _G['ElvUI_StanceBarButton'..i]
				if not button then
					break
				else
					if not button.shadow then
						button:CreateShadow()
						--[[button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2]]
					end
				end
			end
		end

		--microbar shadow
		if E.db.actionbar.microbar.enabled == true then
			if E.db.actionbar.microbar.backdrop == true then
				if not _G.ElvUI_MicroBar.backdrop.shadow then
					_G.ElvUI_MicroBar.backdrop:CreateShadow()
				end
			else
				local microbar = {
					_G['CharacterMicroButton'],
					_G['SpellbookMicroButton'],
					_G['TalentMicroButton'],
					_G['QuestLogMicroButton'],
					_G['SocialsMicroButton'],
					_G['MainMenuMicroButton'],
					_G['HelpMicroButton'],
					_G['LFGMicroButton'],
					_G['WorldMapMicroButton'],
					_G['AchievementMicroButton'],
					_G['GuildMicroButton'],
					_G['LFDMicroButton'],
					_G['EJMicroButton'],
					_G['CollectionsMicroButton'],
					_G['StoreMicroButton'],
				}
				for _, frame in pairs(microbar) do
					if frame and not frame.shadow then
						frame:CreateShadow()
					end
				end
			end
		end

		--unitframes
		if E.private.unitframe.enable then
			if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
				if not _G['ElvUF_Focus_HealthBar'].shadow then
					_G['ElvUF_Focus_HealthBar']:CreateShadow()
				end
				if not _G['ElvUF_Focus_HealthBar'].shadow then
					_G['ElvUF_Focus_PowerBar']:CreateShadow()
				end
			end

			local elvuiframes = {
				_G['ElvUF_TargetTarget_HealthBar'],
				_G['ElvUF_TargetTarget_PowerBar'],
				_G['ElvUF_Target_HealthBar'],
				_G['ElvUF_Target_PowerBar'],
				_G['ElvUF_Pet'],
				_G['ElvUF_Player_HealthBar'],
				_G['ElvUF_Player_PowerBar'],
				_G['ElvUF_Player_Stagger'],
			}
			for _, frame in pairs(elvuiframes) do
				if frame and not frame.shadow then
					frame:CreateShadow()
				end
			end

			--player castbar
			if not E.db.unitframe.units.player.castbar.overlayOnFrame == "Power" then
				local PlayerCastbar = CreateFrame("Frame", "EltruismPlayerCastBarShadowFrame")
				local isattached = E.db.unitframe.units.player.castbar.iconAttached
				local PlayerCastbarx, PlayerCastbary
				if isattached == false then
					PlayerCastbarx = (E.db.unitframe.units.player.castbar.width + E.db.unitframe.units.player.castbar.iconSize -4)
					PlayerCastbary = (E.db.unitframe.units.player.castbar.height - 3)
				elseif isattached == true then
					PlayerCastbarx = (E.db.unitframe.units.player.castbar.width - 4)
					PlayerCastbary = (E.db.unitframe.units.player.castbar.height - 3)
				end
				PlayerCastbar:SetSize(PlayerCastbarx, PlayerCastbary)
				PlayerCastbar:SetParent(_G.ElvUF_Player_CastBar)
				if not (self.PlayerCastBarIsSkinned) then
					PlayerCastbar.shadow = PlayerCastbar:CreateShadow(nil, true)
					PlayerCastbar:SetPoint("CENTER", _G['ElvUF_Player_CastBar'], "CENTER", -(PlayerCastbary/2), 0)
					PlayerCastbar:Show()
					self.PlayerCastBarIsSkinned = true
				end
			else
				if not _G['ElvUF_Player_CastBar'].shadow then
					_G['ElvUF_Player_CastBar']:CreateShadow()
				end
			end

			--target castbar
			if not E.db.unitframe.units.target.castbar.overlayOnFrame == "Power" then
				local TargetCastbar = CreateFrame("Frame", "EltruismTargetCastBarShadowFrame")
				local isattachedtarget = E.db.unitframe.units.target.castbar.iconAttached
				local TargetCastbarx, TargetCastbary
				if isattachedtarget == false then
					TargetCastbarx = (E.db.unitframe.units.target.castbar.width + E.db.unitframe.units.target.castbar.iconSize - 4)
					TargetCastbary = (E.db.unitframe.units.target.castbar.height - 3)
				elseif isattachedtarget == true then
					TargetCastbarx = (E.db.unitframe.units.target.castbar.width - 4)
					TargetCastbary = (E.db.unitframe.units.target.castbar.height - 3)
				end
				TargetCastbar:SetSize(TargetCastbarx, TargetCastbary)
				TargetCastbar:SetParent(_G.ElvUF_Target_CastBar)
				if not (self.TargetCastBarIsSkinned) then
					TargetCastbar.shadow = TargetCastbar:CreateShadow(nil, true)
					TargetCastbar:SetPoint("CENTER", _G['ElvUF_Target_CastBar'], "CENTER", -(TargetCastbary/2), 0) ---14, 0)
					TargetCastbar:Show()
					self.TargetCastBarIsSkinned = true
				end
			else
				if not _G['ElvUF_Target_CastBar'].shadow then
					_G['ElvUF_Target_CastBar']:CreateShadow()
				end
			end

			--party
			for i = 1, 5 do
				local partymembers = {_G['ElvUF_PartyGroup1UnitButton'..i]}
				for _, frame in pairs(partymembers) do
					for _, button in pairs(partymembers) do
						if not button.shadow then
							button:CreateShadow()
						--[[button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2]]
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
							button:CreateShadow()
						--[[button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2]]
						end
					end
				end
			end

			--runes
			if E.myclass == 'DEATHKNIGHT' then
				for i = 1, 6 do
					if not _G['ElvUF_PlayerRuneButton'..i] then
						break
					end
					local button = _G['ElvUF_PlayerRuneButton'..i] --.backdrop
					if not button then
						break
					else
						if not button.shadow then
							button:CreateShadow()
						end
					end
				end
			end

			--AdditionalPowerBar
			if E.myclass == 'DRUID' or E.myclass == 'SHAMAN' or E.myclass == 'PRIEST' then
				local additionalpowerbar = _G['ElvUF_Player_AdditionalPowerBar']
				if additionalpowerbar ~= nil then
					if not _G['ElvUF_Player_AdditionalPowerBar'].shadow then
						_G['ElvUF_Player_AdditionalPowerBar']:CreateShadow()
					end
				end
			end

			--classpower
			if not (E.myclass == 'DEATHKNIGHT') then
				for i = 1, 10 do
					if not _G['ElvUF_PlayerClassIconButton'..i] then
						break
					end
					local button = _G['ElvUF_PlayerClassIconButton'..i].backdrop
					if not button then
						break
					else
						if not button.shadow then
							button:CreateShadow()
							--[[button.shadow = button:CreateShadow(nil, true)
							button.shadow:SetParent(button)
							button.shadow.size = 2]]
						end
					end
				end
			end

			--AdditionalPowerBar
			--[[if E.myclass == 'DRUID' or E.myclass == 'SHAMAN' or E.myclass == 'PRIEST' then
				for i = 1, 3 do
					if not _G['ElvUF_Player_AdditionalPowerBar'..i] then
						break
					end
					local button = _G['ElvUF_Player_AdditionalPowerBar'..i].backdrop
					if not button then
						break
					else
						if not button.shadow then
							button:CreateShadow()
						end
					end
				end
			end]]

		end

		--bags
		if E.private.bags.enable then
			if not _G.ElvUI_ContainerFrame.shadow then
				_G['ElvUI_ContainerFrame']:CreateShadow()
			end
			if not _G.ElvUI_BankContainerFrame.shadow then
				_G['ElvUI_BankContainerFrame']:CreateShadow()
			end
		end

		--elvui popup
		for i = 1, 5 do
			local ElvUI_StaticPopups = {_G['ElvUI_StaticPopup'..i]}
			for _, frame in pairs(ElvUI_StaticPopups) do
				for _, button in pairs(ElvUI_StaticPopups) do
					if not button.shadow then
						button:CreateShadow()
						--[[button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2]]
					end
				end
			end
		end

		--chat
		local RightChatShadow = CreateFrame("Frame", "EltruismRightChatShadowFrame")
		if E.db["chat"]["panelBackdrop"] == "RIGHT" then
			return
		else
			local rightsizex, rightsizey = _G['RightChatMover']:GetSize()
			RightChatShadow:SetSize(rightsizex, rightsizey)
			RightChatShadow:SetParent(_G['RightChatPanel'].backdrop)
			if not (self.RightChatIsSkinned) then
				RightChatShadow.shadow = RightChatShadow:CreateShadow(nil, true)
				RightChatShadow:SetPoint("TOPRIGHT", _G['RightChatPanel'] ,"TOPRIGHT", 0, 0)
				RightChatShadow:SetPoint("BOTTOMLEFT", _G['RightChatDataPanel'] ,"BOTTOMLEFT", 0, 0)
				RightChatShadow:Show()
				self.RightChatIsSkinned = true
			end
		end

		local LeftChatShadow = CreateFrame("Frame", "EltruismLeftChatShadowFrame")
		if E.db["chat"]["panelBackdrop"] == "LEFT" then
			return
		else
			local leftsizex, leftsizey = _G['LeftChatMover']:GetSize()
			LeftChatShadow:SetSize(leftsizex, leftsizey)
			LeftChatShadow:SetParent(_G['LeftChatPanel'].backdrop)
			if not (self.LeftChatIsSkinned) then
				LeftChatShadow.shadow = LeftChatShadow:CreateShadow(nil, true)
				LeftChatShadow:SetPoint("TOPLEFT", _G['LeftChatPanel'] ,"TOPLEFT", 0, 0)
				LeftChatShadow:SetPoint("BOTTOMRIGHT", _G['LeftChatDataPanel'] ,"BOTTOMRIGHT", 0, 0)
				LeftChatShadow:Show()
				self.LeftChatIsSkinned = true
			end
		end

		if E.db["chat"]["panelBackdrop"] == "HIDEBOTH" then
			LeftChatShadow:Hide()
			RightChatShadow:Hide()
		end
		------------------------------------------------------------------------------------------------------end of elvui frames
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

--old method i came up with
--[[
function ElvUI_EltreumUI:AuraShadows()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.shadows.nameplates then
		return
	end
	if E.db.ElvUI_EltreumUI.shadows.aura then
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


			--target buff uf
			for i = 1, 20 do
				local targetbuffs = {_G['ElvUF_TargetBuffsButton'..i]}
				for _, frame in pairs(targetbuffs) do
					for _, button in pairs(targetbuffs) do
						if not button.shadow then
							button.shadow = button:CreateShadow(nil, true)
							button.shadow:SetParent(button)
							button.shadow.size = 2
						end
					end
				end
			end

			--target debuff uf
			for i = 1, 20 do
				local targetbuffs = {_G['ElvUF_TargetDebuffsButton'..i]}
				for _, frame in pairs(targetbuffs) do
					for _, button in pairs(targetbuffs) do
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
end

function ElvUI_EltreumUI:NameplateShadows()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
	elseif not E.db.ElvUI_EltreumUI.shadows.nameplates then
		return
	end
	if E.private["nameplates"]["enable"] == true then
		if E.db.ElvUI_EltreumUI.shadows.nameplates then
			local nameplates = C_NamePlate.GetNamePlates()
		 	--print(#nameplates)
			local nameplatelist = {}
			for i = 1, #nameplates do
				table.insert(nameplatelist, _G["ElvNP_NamePlate"..i.."Health"])
			end
			for _,v in pairs(nameplatelist) do
				if not v.backdrop.shadow then
					v.backdrop:CreateShadow()
				end
			end
		end
	end
end
]]--

--benik's version
function ElvUI_EltreumUI:NameplateShadows(nameplate)
	if E.db.ElvUI_EltreumUI.shadows.nameplates then
		if nameplate.Health.backdrop then
			if not nameplate.Health.backdrop.shadow then
				nameplate.Health.backdrop:CreateShadow()
			end
		end
	end

	if E.db.ElvUI_EltreumUI.shadows.nppower then
		if nameplate.Power.backdrop then
			if not nameplate.Power.backdrop.shadow then
				nameplate.Power.backdrop:CreateShadow()
			end
		end
	end

	if E.db.ElvUI_EltreumUI.shadows.npcastbar then
		if nameplate.Castbar.backdrop then
			if not nameplate.Castbar.backdrop.shadow then
				nameplate.Castbar.backdrop:CreateShadow()
			end
		end

		if nameplate.Castbar.Button then
			if not nameplate.Castbar.Button.shadow then
				nameplate.Castbar.Button:CreateShadow()
			end
		end
	end

	if E.db.ElvUI_EltreumUI.shadows.npportraits then
		if nameplate.Portrait.backdrop then
			if not nameplate.Portrait.backdrop.shadow then
				nameplate.Portrait.backdrop:CreateShadow()
			end
		end
	end
end
hooksecurefunc(NP, 'StylePlate', ElvUI_EltreumUI.NameplateShadows) --nameplate shadows

function ElvUI_EltreumUI:Construct_AuraIcon(button)
	if E.db.ElvUI_EltreumUI.shadows.npauras then
		if not button then return end
		if not button.shadow then
			button:CreateShadow()
		end
	end
end
hooksecurefunc(NP, 'Construct_AuraIcon', ElvUI_EltreumUI.Construct_AuraIcon) -- nameplate buffs/debuffs shadows

function ElvUI_EltreumUI:AuraShadows(button)
	if E.db.ElvUI_EltreumUI.shadows.aura then
		if not button then return end
		if not button.shadow then
			button:CreateShadow()
		end
	end
end
hooksecurefunc(A, 'CreateIcon', ElvUI_EltreumUI.AuraShadows)  --aura (minimap) shadows

function ElvUI_EltreumUI:UFAuraShadows(button)
	if E.db.ElvUI_EltreumUI.shadows.ufaura then
		if not button then return end
		if not button.shadow then
			button:CreateShadow()
		end
	end
end
hooksecurefunc(UF, 'Construct_AuraIcon', ElvUI_EltreumUI.UFAuraShadows)   --uf aura shadows

--uses a lot more cpu for some reason
--[[
function ElvUI_EltreumUI:ActionBarShadows(button)
	if E.db.ElvUI_EltreumUI.shadows.actionbars then
		if not button then return end
		if not button.shadow then
			button:CreateShadow()
		end
	end
end
hooksecurefunc(AB, 'StyleButton', ElvUI_EltreumUI.ActionBarShadows)  --action bar shadows

benik's statusbar tooltip method, basically the same
local TT = E:GetModule('Tooltip')
function ElvUI_EltreumUI:TooltipStatusbarShadow(tt)
    if not tt.StatusBar then return end

    if not tt.StatusBar.backdrop.shadow then
        tt.StatusBar.backdrop:CreateShadow()
    end
end
hooksecurefunc(TT, "GameTooltip_SetDefaultAnchor", ElvUI_EltreumUI.TooltipStatusbarShadow)
]]
